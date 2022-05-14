// ignore_for_file: constant_identifier_names

const googleMapURI = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
const nodeBackendURI = 'https://fixpalsbackend.herokuapp.com';
const flaskBackendURI = 'https://fixpals-flask-backend.herokuapp.com';

const LOGIN = nodeBackendURI + "/userLogin";
const VALIDATE_OTP = nodeBackendURI + "/validateOTP";
const ALL_BANNERS = flaskBackendURI + "/banners";
const ALL_CATEGORIES = flaskBackendURI + "/categories";
const SUBCATEGORY_BY_ID = flaskBackendURI + "/subcategory/";
const SERVICE_BY_ID = flaskBackendURI + "/product/";
const POPULAR_SERVICES = flaskBackendURI + "/popular_products";
const SEARCH_PRODUCTS = flaskBackendURI + "/products";
