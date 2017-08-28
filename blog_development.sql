--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO root;

--
-- Name: blogs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE blogs (
    id integer NOT NULL,
    title character varying,
    description character varying,
    image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


ALTER TABLE blogs OWNER TO root;

--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blogs_id_seq OWNER TO root;

--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE blogs_id_seq OWNED BY blogs.id;


--
-- Name: comment_hierarchies; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE comment_hierarchies (
    ancestor_id integer NOT NULL,
    descendant_id integer NOT NULL,
    generations integer NOT NULL
);


ALTER TABLE comment_hierarchies OWNER TO root;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE comments (
    id integer NOT NULL,
    commenter character varying,
    body text,
    blog_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    parent_id integer
);


ALTER TABLE comments OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE follows (
    id integer NOT NULL,
    followable_type character varying NOT NULL,
    followable_id integer NOT NULL,
    follower_type character varying NOT NULL,
    follower_id integer NOT NULL,
    blocked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE follows OWNER TO root;

--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE follows_id_seq OWNER TO root;

--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE follows_id_seq OWNED BY follows.id;


--
-- Name: friendships; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE friendships (
    id integer NOT NULL,
    sender character varying,
    receiver character varying,
    accept boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE friendships OWNER TO root;

--
-- Name: friendships_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE friendships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE friendships_id_seq OWNER TO root;

--
-- Name: friendships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE friendships_id_seq OWNED BY friendships.id;


--
-- Name: replies; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE replies (
    id integer NOT NULL,
    body character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    comment_id integer
);


ALTER TABLE replies OWNER TO root;

--
-- Name: replies_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE replies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE replies_id_seq OWNER TO root;

--
-- Name: replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE replies_id_seq OWNED BY replies.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO root;

--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    avatar character varying
);


ALTER TABLE users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE votes (
    id integer NOT NULL,
    votable_type character varying,
    votable_id integer,
    voter_type character varying,
    voter_id integer,
    vote_flag boolean,
    vote_scope character varying,
    vote_weight integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE votes OWNER TO root;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE votes_id_seq OWNER TO root;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY blogs ALTER COLUMN id SET DEFAULT nextval('blogs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY follows ALTER COLUMN id SET DEFAULT nextval('follows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY friendships ALTER COLUMN id SET DEFAULT nextval('friendships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY replies ALTER COLUMN id SET DEFAULT nextval('replies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: root
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-07-25 07:35:51.432315	2017-07-25 07:35:51.432315
\.


--
-- Data for Name: blogs; Type: TABLE DATA; Schema: public; Owner: root
--

COPY blogs (id, title, description, image, created_at, updated_at, user_id) FROM stdin;
1	dfgfg	sfdgfd	imag5.jpg	2017-07-25 07:36:55.299515	2017-07-25 07:36:55.299515	1
2	rahul	sdfghfds	images1.jpeg	2017-07-25 07:59:53.908172	2017-07-25 07:59:53.908172	2
3	dfhgd	fdhfgh	\N	2017-07-25 08:01:13.051456	2017-07-25 08:01:13.051456	2
4	ravi	hii	\N	2017-07-25 08:01:59.619369	2017-07-25 08:01:59.619369	3
5	fhgr	fgdh	\N	2017-07-25 10:36:16.971642	2017-07-25 10:36:16.971642	3
6	Vijay	i am fine	\N	2017-07-25 15:26:45.884505	2017-07-25 15:26:45.884505	4
7	Rajesh	fdhgfgh	\N	2017-07-26 10:49:52.205588	2017-07-26 10:49:52.205588	5
\.


--
-- Name: blogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('blogs_id_seq', 7, true);


--
-- Data for Name: comment_hierarchies; Type: TABLE DATA; Schema: public; Owner: root
--

COPY comment_hierarchies (ancestor_id, descendant_id, generations) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY comments (id, commenter, body, blog_id, created_at, updated_at, parent_id) FROM stdin;
1	gfdg	dfg	7	2017-07-28 05:57:30.645523	2017-07-28 05:57:30.645523	\N
3	dsgffd	gdfgg	6	2017-07-28 06:11:23.556723	2017-07-28 06:11:23.556723	\N
5	dfsgfg	\N	\N	2017-07-31 11:18:32.132612	2017-07-31 11:18:32.132612	\N
6	dfsgdfsg	\N	\N	2017-07-31 11:20:31.585557	2017-07-31 11:20:31.585557	\N
7	dfgdgdfg	\N	\N	2017-07-31 11:23:36.782348	2017-07-31 11:23:36.782348	\N
8	fdhfdhgf	\N	\N	2017-07-31 11:37:10.970883	2017-07-31 11:37:10.970883	\N
9	fgdsfdfg	\N	\N	2017-07-31 12:00:28.82988	2017-07-31 12:00:28.82988	\N
10	fdhfdgdfg	\N	\N	2017-07-31 12:01:30.542357	2017-07-31 12:01:30.542357	\N
11	ravi	\N	\N	2017-07-31 12:04:59.309847	2017-07-31 12:04:59.309847	\N
12	drst	sgfdsg	\N	2017-07-31 12:12:15.439287	2017-07-31 12:12:15.439287	\N
13	raju	ghgfhfdhfdh	\N	2017-07-31 12:14:53.157405	2017-07-31 12:14:53.157405	\N
14	fghgg	sdfgdsfg	\N	2017-07-31 12:20:12.068063	2017-07-31 12:20:12.068063	\N
15	fdhf	fdhfdh	\N	2017-07-31 12:21:42.655148	2017-07-31 12:21:42.655148	\N
16	fdg	dfsgdf	\N	2017-07-31 12:56:39.367797	2017-07-31 12:56:39.367797	\N
17	sdg	sfdgsdg	\N	2017-07-31 13:17:16.203447	2017-07-31 13:17:16.203447	\N
18	sdg	sfdgsdg	\N	2017-07-31 13:37:58.203247	2017-07-31 13:37:58.203247	\N
19	fdgh	fghfdh	\N	2017-07-31 13:39:27.472911	2017-07-31 13:39:27.472911	\N
20	sgfdg	dfgsdg	\N	2017-07-31 13:45:08.137659	2017-07-31 13:45:08.137659	\N
21	ajay	hiii	\N	2017-07-31 14:01:14.252961	2017-07-31 14:01:14.252961	\N
22	dfg	dfg	\N	2017-08-02 05:28:55.916793	2017-08-02 05:28:55.916793	\N
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('comments_id_seq', 22, true);


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: root
--

COPY follows (id, followable_type, followable_id, follower_type, follower_id, blocked, created_at, updated_at) FROM stdin;
115	sdg	1	sfdgfds	2	t	2017-07-25 12:55:31.230602	2017-07-25 12:55:31.230602
116	ApplicationRecord	1	User	1	f	2017-07-25 13:00:23.542646	2017-07-25 13:00:23.542646
117	ApplicationRecord	1	User	1	f	2017-07-25 13:02:35.079241	2017-07-25 13:02:35.079241
118	ApplicationRecord	1	User	1	f	2017-07-25 13:06:10.769834	2017-07-25 13:06:10.769834
119	ApplicationRecord	1	User	1	f	2017-07-25 13:07:24.024997	2017-07-25 13:07:24.024997
120	ApplicationRecord	1	User	1	f	2017-07-25 13:27:29.368244	2017-07-25 13:27:29.368244
121	ApplicationRecord	1	User	1	f	2017-07-25 13:27:37.972144	2017-07-25 13:27:37.972144
122	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.126463	2017-07-25 13:27:38.126463
123	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.158368	2017-07-25 13:27:38.158368
124	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.184892	2017-07-25 13:27:38.184892
125	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.215896	2017-07-25 13:27:38.215896
126	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.244243	2017-07-25 13:27:38.244243
127	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.278053	2017-07-25 13:27:38.278053
128	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.302814	2017-07-25 13:27:38.302814
129	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.33951	2017-07-25 13:27:38.33951
130	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.371266	2017-07-25 13:27:38.371266
131	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.397798	2017-07-25 13:27:38.397798
132	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.433873	2017-07-25 13:27:38.433873
133	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.460838	2017-07-25 13:27:38.460838
134	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.49471	2017-07-25 13:27:38.49471
135	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.527462	2017-07-25 13:27:38.527462
136	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.553356	2017-07-25 13:27:38.553356
137	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.58042	2017-07-25 13:27:38.58042
138	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.615789	2017-07-25 13:27:38.615789
139	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.648447	2017-07-25 13:27:38.648447
140	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.672906	2017-07-25 13:27:38.672906
141	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.69868	2017-07-25 13:27:38.69868
142	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.826702	2017-07-25 13:27:38.826702
143	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.849318	2017-07-25 13:27:38.849318
144	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.876543	2017-07-25 13:27:38.876543
145	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.899797	2017-07-25 13:27:38.899797
146	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.922814	2017-07-25 13:27:38.922814
147	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.947737	2017-07-25 13:27:38.947737
148	ApplicationRecord	1	User	1	f	2017-07-25 13:27:38.979214	2017-07-25 13:27:38.979214
149	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.010541	2017-07-25 13:27:39.010541
150	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.043237	2017-07-25 13:27:39.043237
151	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.069789	2017-07-25 13:27:39.069789
152	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.096574	2017-07-25 13:27:39.096574
153	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.127789	2017-07-25 13:27:39.127789
154	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.15587	2017-07-25 13:27:39.15587
155	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.191521	2017-07-25 13:27:39.191521
156	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.240783	2017-07-25 13:27:39.240783
157	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.276053	2017-07-25 13:27:39.276053
158	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.31104	2017-07-25 13:27:39.31104
159	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.345515	2017-07-25 13:27:39.345515
160	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.381741	2017-07-25 13:27:39.381741
161	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.41843	2017-07-25 13:27:39.41843
162	ApplicationRecord	1	User	1	f	2017-07-25 13:27:39.453206	2017-07-25 13:27:39.453206
163	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.489811	2017-07-25 13:27:44.489811
164	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.539901	2017-07-25 13:27:44.539901
165	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.561753	2017-07-25 13:27:44.561753
166	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.590802	2017-07-25 13:27:44.590802
167	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.613496	2017-07-25 13:27:44.613496
168	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.650014	2017-07-25 13:27:44.650014
169	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.672814	2017-07-25 13:27:44.672814
170	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.697602	2017-07-25 13:27:44.697602
171	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.733267	2017-07-25 13:27:44.733267
172	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.75946	2017-07-25 13:27:44.75946
173	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.794113	2017-07-25 13:27:44.794113
174	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.815858	2017-07-25 13:27:44.815858
175	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.843643	2017-07-25 13:27:44.843643
176	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.878936	2017-07-25 13:27:44.878936
177	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.914455	2017-07-25 13:27:44.914455
178	ApplicationRecord	1	User	1	f	2017-07-25 13:27:44.986162	2017-07-25 13:27:44.986162
179	ApplicationRecord	1	User	1	f	2017-07-25 13:27:45.045322	2017-07-25 13:27:45.045322
180	ApplicationRecord	1	User	1	f	2017-07-25 13:27:45.114548	2017-07-25 13:27:45.114548
181	ApplicationRecord	1	User	1	f	2017-07-25 13:27:45.176064	2017-07-25 13:27:45.176064
182	ApplicationRecord	1	User	1	f	2017-07-25 13:27:45.206889	2017-07-25 13:27:45.206889
183	ApplicationRecord	1	User	1	f	2017-07-25 13:27:45.234259	2017-07-25 13:27:45.234259
184	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.270126	2017-07-25 13:28:15.270126
185	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.312235	2017-07-25 13:28:15.312235
186	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.349605	2017-07-25 13:28:15.349605
187	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.381887	2017-07-25 13:28:15.381887
188	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.418465	2017-07-25 13:28:15.418465
189	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.446419	2017-07-25 13:28:15.446419
190	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.48085	2017-07-25 13:28:15.48085
191	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.514786	2017-07-25 13:28:15.514786
192	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.539449	2017-07-25 13:28:15.539449
193	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.566325	2017-07-25 13:28:15.566325
194	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.599302	2017-07-25 13:28:15.599302
195	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.62249	2017-07-25 13:28:15.62249
196	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.644991	2017-07-25 13:28:15.644991
197	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.668853	2017-07-25 13:28:15.668853
198	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.692475	2017-07-25 13:28:15.692475
199	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.72384	2017-07-25 13:28:15.72384
200	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.752333	2017-07-25 13:28:15.752333
201	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.77962	2017-07-25 13:28:15.77962
202	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.816218	2017-07-25 13:28:15.816218
203	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.850176	2017-07-25 13:28:15.850176
205	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.753221	2017-07-25 13:28:17.753221
207	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.806652	2017-07-25 13:28:17.806652
209	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.923652	2017-07-25 13:28:17.923652
211	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.992526	2017-07-25 13:28:17.992526
213	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.047932	2017-07-25 13:28:18.047932
215	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.135849	2017-07-25 13:28:18.135849
217	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.206056	2017-07-25 13:28:18.206056
219	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.267366	2017-07-25 13:28:18.267366
221	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.323569	2017-07-25 13:28:18.323569
223	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.383314	2017-07-25 13:28:18.383314
225	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.453127	2017-07-25 13:28:18.453127
226	ApplicationRecord	1	User	1	f	2017-07-25 13:28:28.032919	2017-07-25 13:28:28.032919
204	ApplicationRecord	1	User	1	f	2017-07-25 13:28:15.874616	2017-07-25 13:28:15.874616
206	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.783423	2017-07-25 13:28:17.783423
208	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.891759	2017-07-25 13:28:17.891759
210	ApplicationRecord	1	User	1	f	2017-07-25 13:28:17.947918	2017-07-25 13:28:17.947918
212	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.020574	2017-07-25 13:28:18.020574
214	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.095359	2017-07-25 13:28:18.095359
216	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.169546	2017-07-25 13:28:18.169546
218	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.238499	2017-07-25 13:28:18.238499
220	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.297578	2017-07-25 13:28:18.297578
222	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.357812	2017-07-25 13:28:18.357812
224	ApplicationRecord	1	User	1	f	2017-07-25 13:28:18.419947	2017-07-25 13:28:18.419947
227	ApplicationRecord	1	User	1	f	2017-07-25 13:37:35.391975	2017-07-25 13:37:35.391975
228	ApplicationRecord	1	User	1	f	2017-07-25 13:50:36.653381	2017-07-25 13:50:36.653381
229	ApplicationRecord	1	User	1	f	2017-07-25 13:50:44.483069	2017-07-25 13:50:44.483069
230	ApplicationRecord	1	User	1	f	2017-07-25 13:50:47.52377	2017-07-25 13:50:47.52377
232	ApplicationRecord	1	User	1	f	2017-07-25 13:53:53.982759	2017-07-25 13:53:53.982759
233	ApplicationRecord	1	User	1	f	2017-07-25 13:54:03.701242	2017-07-25 13:54:03.701242
234	ApplicationRecord	1	User	1	f	2017-07-25 13:54:07.372423	2017-07-25 13:54:07.372423
235	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.504352	2017-07-25 13:54:07.504352
236	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.532053	2017-07-25 13:54:07.532053
237	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.554509	2017-07-25 13:54:07.554509
238	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.581146	2017-07-25 13:54:07.581146
239	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.606443	2017-07-25 13:54:07.606443
240	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.631346	2017-07-25 13:54:07.631346
241	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.656677	2017-07-25 13:54:07.656677
242	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.675553	2017-07-25 13:54:07.675553
243	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.70186	2017-07-25 13:54:07.70186
244	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.729691	2017-07-25 13:54:07.729691
245	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.751156	2017-07-25 13:54:07.751156
246	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.772599	2017-07-25 13:54:07.772599
247	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.795824	2017-07-25 13:54:07.795824
248	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.824652	2017-07-25 13:54:07.824652
249	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.845919	2017-07-25 13:54:07.845919
250	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.871905	2017-07-25 13:54:07.871905
251	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.892132	2017-07-25 13:54:07.892132
252	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.916795	2017-07-25 13:54:07.916795
253	ApplicationRecord	1	User	3	f	2017-07-25 13:54:07.942594	2017-07-25 13:54:07.942594
254	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.078368	2017-07-25 13:54:08.078368
255	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.107716	2017-07-25 13:54:08.107716
256	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.133729	2017-07-25 13:54:08.133729
257	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.156152	2017-07-25 13:54:08.156152
258	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.188222	2017-07-25 13:54:08.188222
259	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.223416	2017-07-25 13:54:08.223416
260	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.256107	2017-07-25 13:54:08.256107
261	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.281512	2017-07-25 13:54:08.281512
262	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.303306	2017-07-25 13:54:08.303306
263	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.323922	2017-07-25 13:54:08.323922
264	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.349621	2017-07-25 13:54:08.349621
265	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.375359	2017-07-25 13:54:08.375359
266	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.402152	2017-07-25 13:54:08.402152
267	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.435713	2017-07-25 13:54:08.435713
268	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.463541	2017-07-25 13:54:08.463541
269	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.497156	2017-07-25 13:54:08.497156
270	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.523464	2017-07-25 13:54:08.523464
271	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.557108	2017-07-25 13:54:08.557108
272	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.583935	2017-07-25 13:54:08.583935
273	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.618805	2017-07-25 13:54:08.618805
274	ApplicationRecord	1	User	3	f	2017-07-25 13:54:08.651459	2017-07-25 13:54:08.651459
275	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.688095	2017-07-25 13:54:13.688095
276	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.716155	2017-07-25 13:54:13.716155
277	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.738571	2017-07-25 13:54:13.738571
278	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.760803	2017-07-25 13:54:13.760803
279	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.78275	2017-07-25 13:54:13.78275
280	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.808565	2017-07-25 13:54:13.808565
281	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.854798	2017-07-25 13:54:13.854798
282	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.881484	2017-07-25 13:54:13.881484
283	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.905218	2017-07-25 13:54:13.905218
284	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.92982	2017-07-25 13:54:13.92982
285	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.955236	2017-07-25 13:54:13.955236
286	ApplicationRecord	1	User	3	f	2017-07-25 13:54:13.976019	2017-07-25 13:54:13.976019
287	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.001955	2017-07-25 13:54:14.001955
288	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.029389	2017-07-25 13:54:14.029389
289	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.050628	2017-07-25 13:54:14.050628
290	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.073733	2017-07-25 13:54:14.073733
291	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.096852	2017-07-25 13:54:14.096852
292	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.12021	2017-07-25 13:54:14.12021
293	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.149477	2017-07-25 13:54:14.149477
294	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.167804	2017-07-25 13:54:14.167804
295	ApplicationRecord	1	User	3	f	2017-07-25 13:54:14.192992	2017-07-25 13:54:14.192992
297	ApplicationRecord	2	User	3	f	2017-07-25 13:55:05.008041	2017-07-25 13:55:05.008041
298	ApplicationRecord	4	User	3	f	2017-07-25 13:59:34.56217	2017-07-25 13:59:34.56217
302	ApplicationRecord	3	User	3	f	2017-07-25 14:26:18.040233	2017-07-25 14:26:18.040233
303	ApplicationRecord	1	User	3	f	2017-07-25 14:27:38.33455	2017-07-25 14:27:38.33455
304	ApplicationRecord	1	User	3	f	2017-07-25 14:46:49.619341	2017-07-25 14:46:49.619341
305	ApplicationRecord	1	User	3	f	2017-07-25 15:03:46.825948	2017-07-25 15:03:46.825948
306	ApplicationRecord	4	User	3	f	2017-07-25 15:22:56.767896	2017-07-25 15:22:56.767896
307	ApplicationRecord	1	User	4	f	2017-07-25 15:27:51.966735	2017-07-25 15:27:51.966735
311	ApplicationRecord	4	User	3	f	2017-07-25 15:37:43.526534	2017-07-25 15:37:43.526534
316	ApplicationRecord	4	User	1	f	2017-07-26 06:03:03.949447	2017-07-26 06:03:03.949447
317	ApplicationRecord	4	User	1	f	2017-07-26 06:05:01.523344	2017-07-26 06:05:01.523344
318	ApplicationRecord	4	User	1	f	2017-07-26 06:11:25.422605	2017-07-26 06:11:25.422605
319	ApplicationRecord	4	User	2	f	2017-07-26 06:14:10.647357	2017-07-26 06:14:10.647357
320	ApplicationRecord	4	User	2	f	2017-07-26 06:15:01.251879	2017-07-26 06:15:01.251879
321	ApplicationRecord	4	User	1	f	2017-07-26 06:17:25.52965	2017-07-26 06:17:25.52965
322	ApplicationRecord	4	User	1	f	2017-07-26 06:28:33.423301	2017-07-26 06:28:33.423301
323	ApplicationRecord	4	User	4	f	2017-07-26 06:29:25.462997	2017-07-26 06:29:25.462997
324	ApplicationRecord	4	User	1	f	2017-07-26 07:40:58.200137	2017-07-26 07:40:58.200137
325	ApplicationRecord	2	User	4	f	2017-07-26 08:42:40.791514	2017-07-26 08:42:40.791514
326	ApplicationRecord	3	User	4	f	2017-07-26 08:42:40.870799	2017-07-26 08:42:40.870799
327	ApplicationRecord	5	User	4	f	2017-07-26 08:42:40.921499	2017-07-26 08:42:40.921499
328	ApplicationRecord	6	User	4	f	2017-07-26 08:42:40.956492	2017-07-26 08:42:40.956492
329	ApplicationRecord	4	User	4	f	2017-07-26 08:56:41.577503	2017-07-26 08:56:41.577503
\.


--
-- Name: follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('follows_id_seq', 329, true);


--
-- Data for Name: friendships; Type: TABLE DATA; Schema: public; Owner: root
--

COPY friendships (id, sender, receiver, accept, created_at, updated_at) FROM stdin;
1	5	5	f	2017-07-26 15:23:12.558057	2017-07-26 15:23:12.558057
4	2	3	t	2017-07-27 08:42:10.596255	2017-07-27 10:07:36.057344
6	3	2	t	2017-07-27 10:11:42.062591	2017-07-27 10:11:59.576837
7	2	4	t	2017-07-27 13:42:37.642003	2017-07-27 13:43:36.424305
5	2	6	t	2017-07-27 09:31:44.391318	2017-07-27 14:47:27.751643
2	2	1	t	2017-07-27 06:15:27.099198	2017-07-27 14:50:02.851647
8	1	6	t	2017-07-27 14:50:21.786498	2017-07-27 14:50:48.980277
\.


--
-- Name: friendships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('friendships_id_seq', 8, true);


--
-- Data for Name: replies; Type: TABLE DATA; Schema: public; Owner: root
--

COPY replies (id, body, created_at, updated_at, comment_id) FROM stdin;
1	fdhf	2017-07-28 08:02:06.072663	2017-07-28 08:02:06.072663	3
2	fdhggh	2017-07-28 08:04:00.498703	2017-07-28 08:04:00.498703	3
3	dhdgh	2017-07-28 08:13:35.586684	2017-07-28 08:13:35.586684	3
4	fshfd	2017-08-02 05:32:18.787719	2017-08-02 05:32:18.787719	1
\.


--
-- Name: replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('replies_id_seq', 4, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY schema_migrations (version) FROM stdin;
20170411083306
20170410073638
20170410101545
20170410102219
20170725074629
20170725082240
20170726065057
20170728053327
20170728063128
20170728074952
20170731085139
20170731085323
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, avatar) FROM stdin;
5	rajesh123@gmail.com	$2a$11$51NGIAPI8UM9n/g77HDc..bEGbGBP2uiwlPo2QFfkE1uooP/oshd2	\N	\N	\N	1	2017-07-26 10:49:29.16196	2017-07-26 10:49:29.16196	127.0.0.1	127.0.0.1	2017-07-26 10:49:29.116447	2017-07-26 10:49:29.163273	\N
2	rahul123@gmail.com	$2a$11$qACmJUokHEB33I1ovvDCn.nya3F2ekLN8An/k1t791sncXfGZ.Tg6	\N	\N	\N	2	2017-07-27 05:39:02.6764	2017-07-25 07:59:27.912911	127.0.0.1	127.0.0.1	2017-07-25 07:59:27.882759	2017-07-27 05:39:02.677986	\N
3	ravi123@gmail.com	$2a$11$OpH6g5I8f6iaQgbAgPl8xeQjXVqFcK9PAAVzKb92lOgwl7vyBOX8m	\N	\N	\N	2	2017-07-27 08:38:33.405736	2017-07-25 08:01:47.273713	127.0.0.1	127.0.0.1	2017-07-25 08:01:47.245245	2017-07-27 08:38:33.407492	\N
4	vijay123@gmail.com	$2a$11$OpAwh.Iif.GKWviPUGqNdOih4pFxuRAi6mLR2DpGv7PJ8D2niO/Gy	\N	\N	\N	2	2017-07-27 10:25:18.933787	2017-07-25 15:26:03.633739	127.0.0.1	127.0.0.1	2017-07-25 15:26:03.60995	2017-07-27 10:25:18.935385	\N
6	ramakant123@gmail.com	$2a$11$Q51pmW/CD.3b69vrcmuVUuU1BfAPT0GlK.Ysnr0kYDoGG/Cm88p4y	\N	\N	\N	2	2017-07-27 14:44:21.799273	2017-07-27 05:24:40.437475	127.0.0.1	127.0.0.1	2017-07-27 05:24:40.391527	2017-07-27 14:44:21.801104	\N
1	daulatramverma7@gmail.com	$2a$11$CNSBgNjjV9NQF.372jGeruWf9ZUO.4xSRiQw0XVGUGEiPtSay4D3C	\N	\N	\N	4	2017-07-27 14:49:30.007605	2017-07-27 05:54:37.78611	127.0.0.1	127.0.0.1	2017-07-25 07:36:35.797357	2017-07-27 14:49:30.009883	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('users_id_seq', 6, true);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY votes (id, votable_type, votable_id, voter_type, voter_id, vote_flag, vote_scope, vote_weight, created_at, updated_at) FROM stdin;
1	Blog	1	User	1	f	\N	1	2017-07-25 07:57:56.138321	2017-07-25 07:58:38.306887
2	Blog	2	User	2	t	\N	1	2017-07-25 08:01:19.440925	2017-07-25 08:01:19.440925
3	Blog	3	User	2	f	\N	1	2017-07-25 08:01:21.460551	2017-07-25 08:01:21.460551
4	Blog	4	User	3	t	\N	1	2017-07-25 08:16:21.291129	2017-07-25 08:16:21.291129
\.


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('votes_id_seq', 4, true);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: follows_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: friendships_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY friendships
    ADD CONSTRAINT friendships_pkey PRIMARY KEY (id);


--
-- Name: replies_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY replies
    ADD CONSTRAINT replies_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: comment_anc_desc_udx; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX comment_anc_desc_udx ON comment_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: comment_desc_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX comment_desc_idx ON comment_hierarchies USING btree (descendant_id);


--
-- Name: fk_followables; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_followables ON follows USING btree (followable_id, followable_type);


--
-- Name: fk_follows; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_follows ON follows USING btree (follower_id, follower_type);


--
-- Name: index_comments_on_blog_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_comments_on_blog_id ON comments USING btree (blog_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_votes_on_votable_id_and_votable_type_and_vote_scope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_votes_on_votable_id_and_votable_type_and_vote_scope ON votes USING btree (votable_id, votable_type, vote_scope);


--
-- Name: index_votes_on_voter_id_and_voter_type_and_vote_scope; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX index_votes_on_voter_id_and_voter_type_and_vote_scope ON votes USING btree (voter_id, voter_type, vote_scope);


--
-- Name: fk_rails_b9ae98a823; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_b9ae98a823 FOREIGN KEY (blog_id) REFERENCES blogs(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

