PGDMP                          |            as    14.2    14.2 !               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24859    as    DATABASE     d   CREATE DATABASE "as" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "as";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    24874    Event    TABLE     �   CREATE TABLE public."Event" (
    id integer NOT NULL,
    status boolean DEFAULT false NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    grouped boolean DEFAULT false NOT NULL
);
    DROP TABLE public."Event";
       public         heap    postgres    false    3            �            1259    24885 
   EventGroup    TABLE     u   CREATE TABLE public."EventGroup" (
    id integer NOT NULL,
    id_event integer NOT NULL,
    name text NOT NULL
);
     DROP TABLE public."EventGroup";
       public         heap    postgres    false    3            �            1259    24884    EventGroup_id_seq    SEQUENCE     �   CREATE SEQUENCE public."EventGroup_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."EventGroup_id_seq";
       public          postgres    false    3    213                       0    0    EventGroup_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."EventGroup_id_seq" OWNED BY public."EventGroup".id;
          public          postgres    false    212            �            1259    24894    EventPeople    TABLE     �   CREATE TABLE public."EventPeople" (
    id integer NOT NULL,
    id_event integer NOT NULL,
    id_group integer NOT NULL,
    name text NOT NULL,
    cpf text NOT NULL,
    matched text DEFAULT ''::text NOT NULL
);
 !   DROP TABLE public."EventPeople";
       public         heap    postgres    false    3            �            1259    24893    EventPeople_id_seq    SEQUENCE     �   CREATE SEQUENCE public."EventPeople_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."EventPeople_id_seq";
       public          postgres    false    3    215                       0    0    EventPeople_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."EventPeople_id_seq" OWNED BY public."EventPeople".id;
          public          postgres    false    214            �            1259    24873    Event_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Event_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Event_id_seq";
       public          postgres    false    3    211                       0    0    Event_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Event_id_seq" OWNED BY public."Event".id;
          public          postgres    false    210            �            1259    24862    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    postgres    false    3            l           2604    24877    Event id    DEFAULT     h   ALTER TABLE ONLY public."Event" ALTER COLUMN id SET DEFAULT nextval('public."Event_id_seq"'::regclass);
 9   ALTER TABLE public."Event" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211            o           2604    24888    EventGroup id    DEFAULT     r   ALTER TABLE ONLY public."EventGroup" ALTER COLUMN id SET DEFAULT nextval('public."EventGroup_id_seq"'::regclass);
 >   ALTER TABLE public."EventGroup" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            p           2604    24897    EventPeople id    DEFAULT     t   ALTER TABLE ONLY public."EventPeople" ALTER COLUMN id SET DEFAULT nextval('public."EventPeople_id_seq"'::regclass);
 ?   ALTER TABLE public."EventPeople" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            
          0    24874    Event 
   TABLE DATA                 public          postgres    false    211   Y$                 0    24885 
   EventGroup 
   TABLE DATA                 public          postgres    false    213   �$                 0    24894    EventPeople 
   TABLE DATA                 public          postgres    false    215   %                 0    24862    _prisma_migrations 
   TABLE DATA                 public          postgres    false    209   -%                  0    0    EventGroup_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."EventGroup_id_seq"', 1, false);
          public          postgres    false    212                       0    0    EventPeople_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."EventPeople_id_seq"', 1, false);
          public          postgres    false    214                       0    0    Event_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Event_id_seq"', 3, true);
          public          postgres    false    210            w           2606    24892    EventGroup EventGroup_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."EventGroup"
    ADD CONSTRAINT "EventGroup_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."EventGroup" DROP CONSTRAINT "EventGroup_pkey";
       public            postgres    false    213            y           2606    24902    EventPeople EventPeople_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."EventPeople"
    ADD CONSTRAINT "EventPeople_pkey" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public."EventPeople" DROP CONSTRAINT "EventPeople_pkey";
       public            postgres    false    215            u           2606    24883    Event Event_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Event" DROP CONSTRAINT "Event_pkey";
       public            postgres    false    211            s           2606    24870 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    209            z           2606    24903 #   EventGroup EventGroup_id_event_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EventGroup"
    ADD CONSTRAINT "EventGroup_id_event_fkey" FOREIGN KEY (id_event) REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public."EventGroup" DROP CONSTRAINT "EventGroup_id_event_fkey";
       public          postgres    false    213    211    3189            {           2606    24908 %   EventPeople EventPeople_id_event_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EventPeople"
    ADD CONSTRAINT "EventPeople_id_event_fkey" FOREIGN KEY (id_event) REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public."EventPeople" DROP CONSTRAINT "EventPeople_id_event_fkey";
       public          postgres    false    211    215    3189            |           2606    24913 %   EventPeople EventPeople_id_group_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."EventPeople"
    ADD CONSTRAINT "EventPeople_id_group_fkey" FOREIGN KEY (id_group) REFERENCES public."EventGroup"(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public."EventPeople" DROP CONSTRAINT "EventPeople_id_group_fkey";
       public          postgres    false    3191    213    215            
   �   x���v
Q���W((M��L�Sr-K�+QRs�	uV�0�QHK�)N�QP���٩�@�KjqrQ������*5��<	�k�an�kp�+�`��k�2s��Tt��%E�Dl�08$��4'_�ݵ���9���Es�� �YSA         
   x���             
   x���             �   x�m�Ak1�����ܶ�F2��$�S�eU{]���Ԋ���J���wx�x6�v��S�q��������t���1M��yI��u����a�ު�^J�j�b�h'�t�T��,H�-�/���caI����+d��2���7�
gDFa	s�Q�{�1��w:m@*��d�0h���	�vj��<����L�3�y�u�R�A�     