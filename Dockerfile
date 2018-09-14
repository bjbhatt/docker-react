FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

# CMD ["npm", "run", "build"] **This command only if you need container running
RUN npm run build

FROM nginx
# for AWS Beanstalk port mapping
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
