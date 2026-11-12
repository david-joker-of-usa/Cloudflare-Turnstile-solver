FROM mcr.microsoft.com/playwright:v1.64.0-jammy

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
# npm package-এর সাথে matching Chromium revision install করো
# (base image-এর browser version আলাদা হতে পারে)
RUN npx playwright install chromium
COPY . .

# Xvfb install
RUN apt-get update && apt-get install -y xvfb && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV HEADLESS=false
ENV PORT=6767
ENV TIMEOUT=60
ENV DISPLAY=:99

EXPOSE 6767

# Railway health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:6767/health', (r) => { process.exit(r.statusCode === 200 ? 0 : 1) })" || exit 1

# Xvfb দিয়ে wrapped mode (headed, VPS-এর মতো)
CMD ["xvfb-run", "--auto-servernum", "--server-args=-screen 0 1280x720x24", "node", "Turnstile_Solver.js"]
