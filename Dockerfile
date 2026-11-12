FROM mcr.microsoft.com/playwright:v1.65.0-jammy

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .

# Xvfb install
RUN apt-get update && apt-get install -y xvfb && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV HEADLESS=false
ENV DISPLAY=:99

EXPOSE 6767

# xvfb দিয়ে wrap করে চালাও
CMD ["xvfb-run", "--auto-servernum", "--server-args=-screen 0 1280x720x24", "node", "Turnstile_Solver.js"]
