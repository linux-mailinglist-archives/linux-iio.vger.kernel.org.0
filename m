Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405072D97A0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 12:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbgLNLqo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407656AbgLNLqo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 06:46:44 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D1C0613CF;
        Mon, 14 Dec 2020 03:46:03 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so11598333qtw.9;
        Mon, 14 Dec 2020 03:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFpqITYOXCkjCo14SrWlF+fIUrrOdHtQXzZ7bCjs+sk=;
        b=L4+xrczYAz+d6QuRe9rN7VKfaESVqwYUJn5lQOzM2yqiL8jFAB8bNHgxedgD05OSHH
         iB2S3GY7cAACZ0kdSSATwb5G+mVQ9/HERuTu/cq8UJYotX0rR2DJVs072U/BXwB5qlzH
         JP6DPM3tPeMonC05yyYQg9E5m54sC0dVbnUzcsyYjP/bVFWMentoMP3Md9LfG5GDTVlf
         fQEZyljnauGKIzPrtFtpxQXlXHiQwN9PpEXNKj5jaHAAJ2CqofRKcl3iizMY8EISX6CI
         xSfw3KqQPKWxuIchke2Fy4YwRFv1zX5COVPxh/wcVP6U/2tH4Qdm5g9CDvg3YIdQmLlT
         6F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFpqITYOXCkjCo14SrWlF+fIUrrOdHtQXzZ7bCjs+sk=;
        b=KNt1rgZ3C3xpgFx+YNyC4li09MSxZ1V2NwVPiu59GgnxVj422TNbdtICTur+3HeBvB
         RnBC3KvEwUlY8yNqOnFV3TxecC1jCvhbmJWB5kXjGHhA0TW7PztyDV5GhaFPwaXvLft5
         4bVcFbwotDkUkpYx8JDr60iqCJIiSxKsd4dW6zKZ6bVlBP4NxwUSrD9r6v2xeDVgzbO+
         ChuOqnGwmguUoP5th/ajGhGQaW1NqnH8WtnKF3YK+7gprzGNZy03SF6S3Gc9HBhr9wun
         1UlNtyiCmoVUSKCNQ2QNCJnZ8NFDFQUUUkrhYGMnt4yhVwGq2B32KDDNE3Hs1bliPQcK
         lPIQ==
X-Gm-Message-State: AOAM5321W3IazwOyh/2vz2JSgBZnYA+xBl9XHIwcpIGfyRl9gF2EcKSW
        UYu+5kOmGPl9s2eqesMQDDk=
X-Google-Smtp-Source: ABdhPJwIaZWlVJcOm74x87CmzZkfPq/479y3kedp+WhNNky6z5+UhoxmlbLfJJVHrjVXpSO2s8setw==
X-Received: by 2002:aed:3482:: with SMTP id x2mr31980781qtd.368.1607946363126;
        Mon, 14 Dec 2020 03:46:03 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id c2sm15053805qke.109.2020.12.14.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:46:02 -0800 (PST)
Date:   Mon, 14 Dec 2020 06:46:00 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter:ti-eqep: remove floor
Message-ID: <X9dQeKy/Ol4d+3iM@shinobu>
References: <20201214000927.1793062-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1/RN+4jYLU6AmmqK"
Content-Disposition: inline
In-Reply-To: <20201214000927.1793062-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--1/RN+4jYLU6AmmqK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 13, 2020 at 06:09:27PM -0600, David Lechner wrote:
> The hardware doesn't support this. QPOSINIT is an initialization value
> that is triggered by other things. When the counter overflows, it
> always wraps around to zero.
>=20
> Fixes: f213729f6796 "counter: new TI eQEP driver"
> Signed-off-by: David Lechner <david@lechnology.com>

Is the QPOSINIT preprocessor define needed at all anymore, or should it als=
o be
removed?

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/ti-eqep.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index a60aee1a1a29..65df9ef5b5bc 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -235,36 +235,6 @@ static ssize_t ti_eqep_position_ceiling_write(struct=
 counter_device *counter,
>  	return len;
>  }
> =20
> -static ssize_t ti_eqep_position_floor_read(struct counter_device *counte=
r,
> -					   struct counter_count *count,
> -					   void *ext_priv, char *buf)
> -{
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> -	u32 qposinit;
> -
> -	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
> -
> -	return sprintf(buf, "%u\n", qposinit);
> -}
> -
> -static ssize_t ti_eqep_position_floor_write(struct counter_device *count=
er,
> -					    struct counter_count *count,
> -					    void *ext_priv, const char *buf,
> -					    size_t len)
> -{
> -	struct ti_eqep_cnt *priv =3D counter->priv;
> -	int err;
> -	u32 res;
> -
> -	err =3D kstrtouint(buf, 0, &res);
> -	if (err < 0)
> -		return err;
> -
> -	regmap_write(priv->regmap32, QPOSINIT, res);
> -
> -	return len;
> -}
> -
>  static ssize_t ti_eqep_position_enable_read(struct counter_device *count=
er,
>  					    struct counter_count *count,
>  					    void *ext_priv, char *buf)
> @@ -301,11 +271,6 @@ static struct counter_count_ext ti_eqep_position_ext=
[] =3D {
>  		.read	=3D ti_eqep_position_ceiling_read,
>  		.write	=3D ti_eqep_position_ceiling_write,
>  	},
> -	{
> -		.name	=3D "floor",
> -		.read	=3D ti_eqep_position_floor_read,
> -		.write	=3D ti_eqep_position_floor_write,
> -	},
>  	{
>  		.name	=3D "enable",
>  		.read	=3D ti_eqep_position_enable_read,
> --=20
> 2.25.1
>=20

--1/RN+4jYLU6AmmqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl/XUG0ACgkQhvpINdm7
VJK87hAA07/kdR5gJXf/BTakREdhq1vWdNPv0TRGCdYMUnh/ruc+bJIe3zzfFDXI
OjNkRKS39aE6rWn2sKt59kNMujfddcVJZQehj3NBMSfjCe1OZ8Sk6T/N30cEOs8m
rV/tkcVnP6s9OlizKQfLKNvi3tkQzaIYTP6EJ4SIYJ0VJOJ8I+xjk8Z1mek6HXYt
lnLCuKqkEF63F+0045MSxVy+UsG4ZsHMhL7JZ293mxdBgzpaw90fS1aUpEzE62Tj
dEB99h5yUb+K9GzhcuNHFVUMtAEOcREjSHHNWxX2C9Uux+pnYJ5hLz3rC8CkN0K2
05yNxog/wRZZEozAaFJhJsVq7kGicvsId5mRKUZwaGML9yW4P2scsy8nYLhvBSgm
0ZeuWpRE3a3IhWx2FJKttJi2nR46NP7ppDDbz/ZPrrkLfyn/mXTfdExwQEIjh8oU
SsnF5uGidGmj9YPBtsRbNQbhEyN9JwDElWFHFJGWkUAmENEBARa3tH5NT6mkcn6p
AMJjUHt89K1DfhhOnhUXC3QapPZPAwv3L37352H4XnHLZim/uIQcL+xILEiuu8bd
0BH+9ohl6ZQEzbyLfm5PWQPsyFYCsfP24AKRNdWvDQldM/JkSJ5zsgCKg2TfyBPt
2Gf4Dd/DmX8QlrA4dAxCeBGs29zlcsMy5rQxBa/5yhF8Nd/cQ+Q=
=QubZ
-----END PGP SIGNATURE-----

--1/RN+4jYLU6AmmqK--
