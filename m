Return-Path: <linux-iio+bounces-21144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA72AED6E0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0821899A64
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34C1F2BB8;
	Mon, 30 Jun 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C7y+dnx+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6A23ABB1
	for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271321; cv=none; b=hn8r8jMzxOdpM7EIBsXBZuB7TTmuXBvculnTAtomOwoF62nw8xbubtlEdJSv/UJE6/6TupjVNf8A2BtQV7erGjZ9zOSrhyUNiD76DJuB9dy0IDuzlr090J6kHpaDpA1l+xt/unGabEhvy2ceEqYjPqAB3Q/nTPrAa0e1j/+hDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271321; c=relaxed/simple;
	bh=t+kZxgmjETPax5y2jiTEex+Rai34JjnFq3cXlFhUcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPuD+bepliDagt/Fg2HyJN2TlIE7beffdfnesiBPqfpCYDNABt34sFAAJzHed2WH58vmH2pU3YLwgsUMmN4ELfaZfo8FzqjvIWyIPJbm90UETzvPR1y7SNfgsTps5KE1B5Dkob1AiZQz1dTHPPqQLAASNolBb/c3bV14yYAAJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C7y+dnx+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad574992fcaso302598866b.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Jun 2025 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751271317; x=1751876117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3Lsecw5+w8E59mY9ydAEs0Hf8U+oscmBxX5k3FVxM0=;
        b=C7y+dnx+J9I4rtqRwVgfN8lIeDamYb8qZexGqIbVs+fhutvBA1ItwX4AM/unZFBiDx
         8jDZmmeYnkqtmnknO/8HZAE+U8549GhO+gdncEUV9KsrW9ZG9skYqxXnWy5k+49NA4Ew
         kLAa7aoJ5O1hUQu/RSZ6WZcuBKdSR7QKgWB/0m3i8L03iw5U/oqyggQycAmQ3/CCiDOv
         FIGdVp6iTHhjiadgcI1Wbth+/s1/4qpv/Ab1cXdyGt/YciDsygzWZUw5b9Q6eEKBc3fC
         PLt7Qr46NKCrt9JBf1eBBnQeVFh0mMRZEoJRWw/+QDMzbcymqat4q2zlyq9/uzD4vNft
         Tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751271317; x=1751876117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3Lsecw5+w8E59mY9ydAEs0Hf8U+oscmBxX5k3FVxM0=;
        b=H/YEo4b4TIKH8yoi1elhhsMMF1HQiW8GPKIOXIVH3104PQdT+kaSVnR1CBC20DUj+s
         8akOiOAfvLbh9L8wjvV/S4INA37tWBcEhNG0Pp21EdudeN6WBEZwkzOJBfZDt7GsriuL
         LwKADdOpzJHH6t9nL18sheAoaL//2d0vOfKKXsJ0tw/7uryPxlbJ5v3ekiDqaL27DLXs
         KQYaa+5P/Lyh/Jbmb2LiZAeiZJvXp13XyUJ//HNcSFIGYHwK04LMHeF6cYHiACicsOLv
         8kGxLWw/NpUcuvHCmzcYSCO3wI+RD5kDMYJcKNsmFeTpjDOrjNsKhhs7p3sUxF6/nlVD
         2s0w==
X-Forwarded-Encrypted: i=1; AJvYcCUuJSb8BeDc+YWH5vLIPuz2/Tp/UAaoMgZQdzNpvTueXyKi5b4UKiKax9h1qk8+5uNOf7wwBqH+sbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3nNS43kXtwwaiyFAOt3+yYkz/ZXi/nmUVLuSsPzSc5fyYFIo
	YygSUjV4/3beV/u6+2cvLj2xO+r6WNEvZ9gKuKTCVKY/5ycVAAI6SbefnPUlDuCfMTg=
X-Gm-Gg: ASbGncs5YDPx5MlGbL9/VYURhyKySp0lSG39+/5As+uaMM0kRM/2T73s3iRZb5+Oexr
	N3UvEy/pBzb4hzSIuBcRqhL+bLc1r2+5NNlxF2A4jBZOvd4W1Y7hO/N09CarAyANMMT2cnU3ami
	oWH9CEJUJjATHkjLLUVZdUQayjql3YzfxYdG31h2xKYcZVJ4jgZRDZN/m+Pn2gIZmLi1P+BuSZ+
	p/BVlLIO9rNwGBdhZ6zb7mSL95qsKzkaGZxFQ8Oif8vioI+HNpdGw3zEyzWsxCbCaY3+0ZDwEWU
	0XXYh1jbklq/xk4Os5ls+CjyBSWtggWO9dmSLxVGyXspRiyHfGih8XvsfiQttzEEa5zr/O+1QVk
	VqZPq86fVi7b6HdJsFRnw85C+Q7Ey
X-Google-Smtp-Source: AGHT+IGjw9XgGWQBmLGn08ybz5a5EqyMyo67bumI+JajrpJYR+eubv7RRtFS2+tHDeWqMdoRaN7KEg==
X-Received: by 2002:a17:907:9488:b0:ae3:60b8:11b6 with SMTP id a640c23a62f3a-ae360b8164dmr1152229166b.20.1751271316470;
        Mon, 30 Jun 2025 01:15:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae35363a167sm619138366b.21.2025.06.30.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:15:15 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:15:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
Message-ID: <pmqc36lr7filq6gu6bplg62qb4bx7cc7nx3ylsjuczv52cdlxr@2bdgzwobw3mv>
References: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
 <20250629182531.6666f690@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmqwkkvasyl7oez5"
Content-Disposition: inline
In-Reply-To: <20250629182531.6666f690@jic23-huawei>


--wmqwkkvasyl7oez5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
MIME-Version: 1.0

Hello Jonathan,

On Sun, Jun 29, 2025 at 06:25:31PM +0100, Jonathan Cameron wrote:
> > ---
> >  drivers/iio/adc/ad7124.c | 36 ++++++++++++++----------------------
> >  1 file changed, 14 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 92596f15e797378329d2072bff71e392664c69db..9808df2e92424283a86e9c1=
05492c7447d071e44 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -94,11 +94,6 @@
> > =20
> >  /* AD7124 input sources */
> > =20
> > -enum ad7124_ids {
> > -	ID_AD7124_4,
> > -	ID_AD7124_8,
> > -};
> > -
> >  enum ad7124_ref_sel {
> >  	AD7124_REFIN1,
> >  	AD7124_REFIN2,
> > @@ -193,17 +188,16 @@ struct ad7124_state {
> >  	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_=
MAX_CONFIGS);
> >  };
> > =20
> > -static struct ad7124_chip_info ad7124_chip_info_tbl[] =3D {
> > -	[ID_AD7124_4] =3D {
> > -		.name =3D "ad7124-4",
> > -		.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_4,
> > -		.num_inputs =3D 8,
> > -	},
> > -	[ID_AD7124_8] =3D {
> > -		.name =3D "ad7124-8",
> > -		.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_8,
> > -		.num_inputs =3D 16,
> > -	},
> > +static const struct ad7124_chip_info ad7124_4_chip_info =3D {
> > +	.name =3D "ad7124-4",
> > +	.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_4,
> > +	.num_inputs =3D 8,
> > +};
> > +
> > +static const struct ad7124_chip_info ad7124_8_chip_info =3D {
> > +	.name =3D "ad7124-8",
> > +	.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_8,
> > +	.num_inputs =3D 16,
> >  };
> > =20
> >  static int ad7124_find_closest_match(const int *array,
> > @@ -1341,17 +1335,15 @@ static int ad7124_probe(struct spi_device *spi)
> >  }
> > =20
> >  static const struct of_device_id ad7124_of_match[] =3D {
> > -	{ .compatible =3D "adi,ad7124-4",
> > -		.data =3D &ad7124_chip_info_tbl[ID_AD7124_4], },
> > -	{ .compatible =3D "adi,ad7124-8",
> > -		.data =3D &ad7124_chip_info_tbl[ID_AD7124_8], },
> > +	{ .compatible =3D "adi,ad7124-4", .data =3D &ad7124_4_chip_info },
> > +	{ .compatible =3D "adi,ad7124-8", .data =3D &ad7124_8_chip_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, ad7124_of_match);
> > =20
> >  static const struct spi_device_id ad71124_ids[] =3D {
> > -	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
> > -	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
> > +	{ "ad7124-4", (kernel_ulong_t)&ad7124_4_chip_info },
> > +	{ "ad7124-8", (kernel_ulong_t)&ad7124_8_chip_info },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad71124_ids);

The patch looks fine for me. I remember having considered creating such
a patch, too.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--wmqwkkvasyl7oez5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhiR48ACgkQj4D7WH0S
/k5hQwf8CX67IhP7EjlBxqJp4X1bxxVHL66ZeU15L5F2yevle/mejS3bH0OZvWXQ
gjZA2sNTR1xaUeJSnqBYT/E2nFQ9WbEwP8TLrmEL89LU2QVZd0XdoTXhV0zlgxcX
qqc/UVq+e8Ffv8vBfDVPiIe7vsyqxhJe7Mjcdfy2xtU3SR3bmrtG85O6WeXb7Re5
jeC3JKLxnmu69LIpCLRZ44OQzCljoPmbGRI0u0aU2yu+npobqt3S1v1f7rVgzP0l
LrXNG3w2gvnNrVDTj8nDneN1S7Y7vgCb+SygHS6ZPKp8P3PqGZeO9otp5JOvBJuu
2/Sp4c+jX7zd1KyMhHgv5q5K1+Bbrg==
=EfKV
-----END PGP SIGNATURE-----

--wmqwkkvasyl7oez5--

