Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B447697C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 06:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhLPFZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 00:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhLPFZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 00:25:08 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3859C061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 21:25:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i12so22655322pfd.6
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZuCP7Co0gYO1HOFUqe1FLCUCRr1072AxVaWOi86RyM=;
        b=VBmV4aqFmfLnNqhFjjnhZ27kFZI0aGpIdsWy6snCDK864RlEUEavI9kQ5g8EMLAxoh
         CvBydy6KBa8np1OZbsjbZC6PwvQICR8FQdiffJ3/VclAsUJu6vu9gNIZc1uk2ukHQYlm
         OViaknDW6ZgX9cOIdYJhVzRtnW6pvcjXK6caPJ+H+rxorkBwpE3f//frjE3c9y2NteUM
         mrYPFoQQrGbgtZDx2zKioUFcyZLB1mXnS3xVSaGOQFnQFojPaeepg8CMh/COssEIr7+x
         wSQm53xoE/UDt13KGbVHL7S4IO7702u2DhYkAKAI+O7AnbMttjx26nJqZzL5ObZLfS/p
         G7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZuCP7Co0gYO1HOFUqe1FLCUCRr1072AxVaWOi86RyM=;
        b=5eYVOajPv8rRGyYjg9fhNHhm1oD34Rx/WuoBWgqH6FP2GZFKbgpopbNb2xCdNR1RZH
         IlIYdlxoJzkZbykLPn9bmKQuBly5cDycflMoMUeuKItxAO4w+HTX++xDTO0mqn0YKCvv
         Rm9iEygasAPC8PjapXEstPjYskt7vhw00hTG0q6rSZdxvgLfAJTDV7zdJRJUDOitm+Fn
         tJfFTKnwnKTUuwUtxAij1Bg/JrRTowNuGTs8VtPg0hm9JuQXaKzaH2VcrRaPMMPregbn
         lZ4dT6iugRvqi54p9/ujARZlAiUlYZl2uBuZL+ARRsmhL/CwC/HzylC/g1gCF8pPebYM
         Ea4g==
X-Gm-Message-State: AOAM532XR55FBcAlZiH2Z9bEJyl2OfdzPAnQ5nwbIFHcgio/P2OPGai3
        s2ZN+F5d2BFvSmCXPlCxB1VfjF1KLDxajw==
X-Google-Smtp-Source: ABdhPJxeVW9K6Qvucfr1DAZnj0M2/G3AMVmXgtXKr/YWQ3jXBzdevCMsUjts84HH/ZHdBtQDa9mDfA==
X-Received: by 2002:a05:6a00:1a53:b0:4b1:7ab:9b5 with SMTP id h19-20020a056a001a5300b004b107ab09b5mr12371765pfv.29.1639632308135;
        Wed, 15 Dec 2021 21:25:08 -0800 (PST)
Received: from shinobu ([37.120.154.45])
        by smtp.gmail.com with ESMTPSA id v25sm4382654pfg.175.2021.12.15.21.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 21:25:07 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:25:03 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] counter: ti-eqep: Use container_of instead of struct
 counter_device::priv
Message-ID: <YbrNr20FBb+ZMShv@shinobu>
References: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="589yszANg6TAMqXB"
Content-Disposition: inline
In-Reply-To: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--589yszANg6TAMqXB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 12:43:12PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Using counter->priv is a memory read and so more expensive than
> container_of which is only an addition. (In this case even a noop
> because the offset is 0.)
>=20
> So container_of is expected to be a tad faster, it's type-safe, and
> produces smaller code (ARCH=3Darm allmodconfig):
>=20
> 	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers/cou=
nter/ti-eqep.o
> 	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
> 	Function                                     old     new   delta
> 	ti_eqep_position_enable_write                132     120     -12
> 	ti_eqep_position_enable_read                 260     248     -12
> 	ti_eqep_position_ceiling_write               132     120     -12
> 	ti_eqep_position_ceiling_read                236     224     -12
> 	ti_eqep_function_write                       220     208     -12
> 	ti_eqep_function_read                        372     360     -12
> 	ti_eqep_count_write                          312     300     -12
> 	ti_eqep_count_read                           236     224     -12
> 	ti_eqep_action_read                          664     652     -12
> 	Total: Before=3D4598, After=3D4490, chg -2.35%
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I'll pick this up and submit it with the rest of the Counter changes for
this cycle.

Thanks,

William Breathitt Gray

> ---
>  drivers/counter/ti-eqep.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 09817c953f9a..9e0e46bca4c2 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -87,10 +87,15 @@ struct ti_eqep_cnt {
>  	struct regmap *regmap16;
>  };
> =20
> +static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_dev=
ice *counter)
> +{
> +	return container_of(counter, struct ti_eqep_cnt, counter);
> +}
> +
>  static int ti_eqep_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	u32 cnt;
> =20
>  	regmap_read(priv->regmap32, QPOSCNT, &cnt);
> @@ -102,7 +107,7 @@ static int ti_eqep_count_read(struct counter_device *=
counter,
>  static int ti_eqep_count_write(struct counter_device *counter,
>  			       struct counter_count *count, u64 val)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	u32 max;
> =20
>  	regmap_read(priv->regmap32, QPOSMAX, &max);
> @@ -116,7 +121,7 @@ static int ti_eqep_function_read(struct counter_devic=
e *counter,
>  				 struct counter_count *count,
>  				 enum counter_function *function)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	u32 qdecctl;
> =20
>  	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> @@ -143,7 +148,7 @@ static int ti_eqep_function_write(struct counter_devi=
ce *counter,
>  				  struct counter_count *count,
>  				  enum counter_function function)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	enum ti_eqep_count_func qsrc;
> =20
>  	switch (function) {
> @@ -173,7 +178,7 @@ static int ti_eqep_action_read(struct counter_device =
*counter,
>  			       struct counter_synapse *synapse,
>  			       enum counter_synapse_action *action)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	enum counter_function function;
>  	u32 qdecctl;
>  	int err;
> @@ -245,7 +250,7 @@ static int ti_eqep_position_ceiling_read(struct count=
er_device *counter,
>  					 struct counter_count *count,
>  					 u64 *ceiling)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	u32 qposmax;
> =20
>  	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
> @@ -259,7 +264,7 @@ static int ti_eqep_position_ceiling_write(struct coun=
ter_device *counter,
>  					  struct counter_count *count,
>  					  u64 ceiling)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
> =20
>  	if (ceiling !=3D (u32)ceiling)
>  		return -ERANGE;
> @@ -272,7 +277,7 @@ static int ti_eqep_position_ceiling_write(struct coun=
ter_device *counter,
>  static int ti_eqep_position_enable_read(struct counter_device *counter,
>  					struct counter_count *count, u8 *enable)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
>  	u32 qepctl;
> =20
>  	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> @@ -285,7 +290,7 @@ static int ti_eqep_position_enable_read(struct counte=
r_device *counter,
>  static int ti_eqep_position_enable_write(struct counter_device *counter,
>  					 struct counter_count *count, u8 enable)
>  {
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> +	struct ti_eqep_cnt *priv =3D ti_eqep_count_from_counter(counter);
> =20
>  	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
> =20
>=20
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> --=20
> 2.30.2
>=20

--589yszANg6TAMqXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmG6zZkACgkQhvpINdm7
VJIFiA//SlCtuWiPbCm076AJxUxrTfyA3/kcXp3XhsWKjKfKRPk1qR7QNJDu2Tmy
Y/xbHrfPVy7HgQ1Ur5jjqDtIB+Q2IxGZbHyrV89X9nwU5Wxlg/IoTiFuhtc4Y4+c
6Hp5g4hvdVI92EgOaM1CzeWVlzEOoBCV5XOJUgE0llpYafEFqL73WeW3+lb47U/L
0l6sJGHq4ReEfR6NLwSlK+2Tr0Xxz5MbrLBbI/ceFkci+6eaLvdByZj6vyt0UJ38
7q3G7fa/p5jO3flQPTKlEL9qyLV9mzmQk8YZr9GmwsNlh+duMPN/Qvzr7amcbszh
1N0nredfg0BQSFtsn+Kgn6iqp7JaVXHgF9vN3EFSPSd8c626HKKJjOtw8lVpfA3j
JN2NsaB4YMnQ0nYa6E6s3W6UYZHHqVb7+O8ksluZsmKOxL1cGuJOC69q9ds0uxRs
BTdGtZc5PXhri2XUWE1Bo9uhpKRudCuWWfTnOpoR3C0wXjJkVevXU3aIUyBD6RTV
PsXRwq+FoSEqVhkmBkOjPBtQL4hA/tzt85e7nfpK5HqbEoq5RDMLuqg4n0Jfsiue
4tcmJFJSrU5045FP1LaCls98cUNAcKtzBv+Qbp4WYqTsZYBWp3jICSuAAhgBnBzK
3U+gcFOlvwOlJjmHpk16zaaP2wFQXGNnh/mOpyenwaSIeVHbwtM=
=CICC
-----END PGP SIGNATURE-----

--589yszANg6TAMqXB--
