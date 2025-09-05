Return-Path: <linux-iio+bounces-23735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22640B44E29
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E414C17F60C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1722C3248;
	Fri,  5 Sep 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Eg/5Q/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF42C11CF;
	Fri,  5 Sep 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054573; cv=none; b=Uye22/rtWJxh/4S4d9TP6takOflIHj6hkdx3L2vZQ8LQRljr7xEbHeYTQmH39X3eBCiwhj9Adezns6hJMr/16UC0bchnXsuxz2SnORJjIwLPIq+2QERBMJ++Dy4IjmQ43/KFOubsi/VTq7Ggg5Nv16B8JqUjcr1TARoFtZA30MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054573; c=relaxed/simple;
	bh=qzCAWZODJAML4lT4t9fObyazL/c22sxvOpmbcm+Yab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHmwSX2VYqPvS18qvTINcTRpxyv9YNmkSLF+aO+bJBcYQxPLfOVUyaJ1avt/gAwiViuSyN0YyNcxqgTDbE7MX3bulkrO3DtPh0YR9o8E1kBuKsz83QlOV8Z7QHVBnut5iQ6oNhbMwCWG3ScJMM5oib7XITX3OXoXyXRBz8JB1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Eg/5Q/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336dd55aae1so16863491fa.1;
        Thu, 04 Sep 2025 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757054569; x=1757659369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUHbPnkcjbaUo/zWe26KrpAxYUocsWMPwn5KNFOXzTI=;
        b=J3Eg/5Q/szIh2aIzZX9oGE+hdoozt3wok4YJJMAFMH1DM0C1fyhLE23TvglNgkI520
         3gbTsVSzwVI2NZqMazIhGaGSnV/BK+oTQm2KFl3B0gZayy+sWGtcnXnpd0X1m9BzP5Sx
         KlGRIMwyc+/W1Zg6lmGe/TJrtmweMVVS6bNtl6SGbvZ+Fckx4wHqHB1tjpcIHvfZQ0N0
         NZFdGkA4UwmRryom7kZukcRA1P0blVIqvhbDvCK8zVPHY5T4zjp/g5jkNxh0b38Xolsi
         1UXbf0cNwm3a/QaFJV3tSdLGJ+6D0HmuP8MeqvRzvpeoxJmlREKzMkDioCBo3AqJwxmt
         hz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054569; x=1757659369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUHbPnkcjbaUo/zWe26KrpAxYUocsWMPwn5KNFOXzTI=;
        b=QQBjSrhfNp/ajuPIihHaZXs44+VpTszStEQVfqIzfYfMDjnGYGEm95bnteTp8kRjQf
         Hg7gwlmSwHJS4HiGqAl9lb7t3lQrtghO2m4ilOsVyDU23gkSlh+WdN5Zkzna0eAUi0Vj
         84dK1r+46O6NDJGQYcj1lc/NUEC93AjwJ15hnOMWrPyAy66drHWbNfMQOjCvy7yb5RCP
         AgF05PU7D+aFNby9Iq5YVi0xz22iE276N64TDvy/5+559rcPs9P+w8bYJZlcFVR9P6oO
         Wj1qtW61z8MYuo3g4jAtat6DOM8Gc/EjoQV6efHaq42ShyG19vmbEYA0kUJmZG3fR85g
         RuhA==
X-Forwarded-Encrypted: i=1; AJvYcCURaiwIKqEMeYi++pJCtesIkOQPgDS9rIZlDPceS3w+0Mxe81p3mCJ5h+3p2L37qVfF9Lsuu0UIIgau@vger.kernel.org, AJvYcCUsVUcazLiczEVGVtUP+sab7wzKZX/nyaRsJIlikeuX17hkVlnKamCA7rdjgidTD3/YXXKjLb+OUkwM@vger.kernel.org, AJvYcCX0vOO4x9A3MmBZuCp7Q1r5PMTsd8y2qKh8g0s/FxUM45HK8NZP6fTQ/y3FuWYhdAK9qdvRi8DcHF5z+IcF@vger.kernel.org, AJvYcCXJtbaTma28rl0UiLLIL53EfbkBc796yKUNoibltOQHcVFxVMj6dzDsQ6gDhaXkDmNFYpKGMLcMGjMnhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8CvGgXEM3tNN58cqBTA0yYzGsTFGr1yCZ9Qg77vZC4Vi6Lxj
	UKKN7diZcIja+JatnQRWFJMkuPatQ+CpI3k/gS7lozxfV8XR9a5uRqEG
X-Gm-Gg: ASbGncv84LwoKVMW7y+4UDADErnzM3ZM89k502QaFnLvdNaxGoI/U8tPeJGa0QvZKPK
	7Y1B3IBnDmUZpIYSSW1VHKQB/vhCdxy+uw0EuOVkgrIw6+1nml206kJ1/sxJlVybWN1kajgABc+
	fEUvre5Ei1OFt/OnNJ1Wo/QHWW9qV2cJVww1uVjvUg5D3Im7KzzP84XC5Bq8AmvYgcKNQENARUB
	zr7sSVBEJpJY/Q4Fh0QRPJoHmoPZwu/nUCOTo+TgSUn/q6JX/8lp7qeBkqZYnlS6KVyk+rvzkTY
	Xyh+VGZU9kCxhvFXttn2MklPh5Fq+UphF7r7TQUCppadC9u5ICx7OiaMJt+pO1QNyYu4s8FT+jG
	MdusOHD/+zGDGVX9qhzn5y/IGx69U4w==
X-Google-Smtp-Source: AGHT+IHbgrH1VLQtm2p/eFDCr1ouNRmrinBCemNGljOUErnpQaJVamgU9DDTeGzlLxnFkskNWmHayg==
X-Received: by 2002:a05:651c:235a:20b0:336:8be2:a716 with SMTP id 38308e7fff4ca-336ca91655dmr51956731fa.8.1757054569408;
        Thu, 04 Sep 2025 23:42:49 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad25e15sm1636936e87.126.2025.09.04.23.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 23:42:48 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:42:44 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Hans de Goede <hansg@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Support ROHM BD79112 ADC
Message-ID: <8338b9b73a037e000c09627155a097d6b08d7423.1757053456.git.mazziesaccount@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDa0cXCW7zrSgmCU"
Content-Disposition: inline
In-Reply-To: <cover.1757053456.git.mazziesaccount@gmail.com>


--VDa0cXCW7zrSgmCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
which are maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - no changes
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3d..8e78a1168c17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21864,9 +21864,10 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
-ROHM BD79124 ADC / GPO IC
+ROHM BD791xx ADC / GPO IC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
+F:	drivers/iio/adc/rohm-bd79112.c
 F:	drivers/iio/adc/rohm-bd79124.c
=20
 ROHM BH1745 COLOUR SENSOR
--=20
2.51.0


--VDa0cXCW7zrSgmCU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi6hmQACgkQeFA3/03a
ocV80wgAmNhJ0BU5m7eBnbz9PcYGPrsuWCwyqB/dWTYxcgpfEOpYQktxYXXy1r5D
E1eMMQKlmzEWQvjGjhV8ZnEPNHzdCuGFEw0rXLKcmSa+Zz+nm3xNzG2ffGQ7HJ/Q
hLc7/nqvO4Upo1hg1s7GurZ89hNTb1CA6b6bntJAJehnghGl2vLbA6Kbmz8UXYxo
dvjCbRDhV5jpOQgZ5uCFE9/hmLeCKDCb+k6Q++ig+btj+c+Jj2yZS/C3f6hrpQRU
NkS/eDYSMH9zvkWV7EMAg5E4KykkZ6j813Qb9avK8JUXNgzyKdK5tl/rp/KFHNzk
krpdj+l5W4p9CHvbTW4RHeCqnDtlHg==
=ahsv
-----END PGP SIGNATURE-----

--VDa0cXCW7zrSgmCU--

