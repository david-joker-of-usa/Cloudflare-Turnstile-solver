FROM mcr.microsoft.com/playwright:v1.65.0-jammy

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

ENV NODE_ENV=production
ENV HEADLESS=true

EXPOSE 6767

CMD ["node", "Turnstile_Solver.js"]
