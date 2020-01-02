import axios from 'axios';

export const HTTP = axios.create({
  baseURL: `/api`,
  headers: {
    Authorization: 'Bearer {token}'
  }
})

export const KSQL = axios.create({
  baseURL: '/',
  headers: {
    'Content-Type': 'application/vnd.ksql.v1+json; charset=utf-8',
    'Accept': 'application/vnd.ksql.v1+json',
  },
})