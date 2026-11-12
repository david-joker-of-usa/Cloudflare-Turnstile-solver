FROM mcr.microsoft.com/playwright:v1.44.0-jammy

WORKDIR /app

# package files আগে copy
COPY package*.json ./

# lockfile নেই, তাই npm ci নয় — npm install
RUN npm install --omit=dev

# বাকি সব কোড
COPY . .

ENV NODE_ENV=production
ENV HEADLESS=true

EXPOSE 6767

# আসল ফাইলের নাম
CMD ["node", "Turnstile_Solver.js"]
