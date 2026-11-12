
FROM node:20-bookworm

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Install Playwright Chromium and system dependencies
RUN npx playwright install --with-deps chromium

# Copy project files
COPY . .

# Railway port
ENV PORT=6767
ENV HEADLESS=true
ENV NODE_ENV=production

EXPOSE 6767

CMD ["npm", "start"]
