Return-Path: <linux-iio+bounces-17531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97EA787E4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACF63B1BCC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423F230D0D;
	Wed,  2 Apr 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6XkXrkH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941F230BE1;
	Wed,  2 Apr 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574187; cv=none; b=jxrlESUvPVeyLXMCBl8h5cfu3Io7c3oZ/4sAkU+tO+B6ohdTLbEUY4JZSxSKExLbipFrsLftrSWS5sJ6bjTYpT7/SeW6tS48lx2GjAitYvQpbdOnb2LYoFsLc+AuwXf1zIIa21OTgtGOH09x1f3tXehhcrSdSnbLTenudt7Jaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574187; c=relaxed/simple;
	bh=Ejk433xMKNvwRiZRsOpObVDXsfiuKL5kHtoWmlHV7CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZUQFG4TuxhzPzX+zeMsQsREEF4K7QM2nEVoKxvzH5n9XX7IQGlA2jbOQHe4k75sAAr+KgC0oGqEoPSyfdRFF5tXFuZTaSPL5Ho8b+1mVOEA0LcESzfyINjFPf022XKpwAL3a8s+nROlqhH03pYH6qrqDqZLOdi9fLTNNDsRRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6XkXrkH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54af20849bbso4988313e87.0;
        Tue, 01 Apr 2025 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574184; x=1744178984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9poQQApOvltd4OZFnAjrdcwn6wTxy+f6oI7slYK8Mlg=;
        b=E6XkXrkHJs2ZvY/m96M8Mmz7Oyrxm2jyOQXdNmAR7og+bK7wEZZIUjhz/MfY6XoiFf
         pCqHedWtK+9af+3LcKv3OuJHWEy3YeqWddprDQLO4Xd4Y2cyQiIwLMnXFwp1v4yBKv78
         Q57m+31G8QpHWRv2qVyHZacw7X9cFqEB9CwgLtX8vasEfTcQ3SASumIj/OJX+h+4QD4I
         UN/VJDAX8Y4sWdVjr8kXTTIgrWbJZkrlrqAQaU8+1RknBqBH/G8HP7zFzJBb4LKnrGsf
         r7oaYK7LDh+IKu7u1kK/N2+qPH3CxxAWco1TmLskcQI/zJxV0JVzSXPcHvo3yAZIUf/Q
         iSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574184; x=1744178984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9poQQApOvltd4OZFnAjrdcwn6wTxy+f6oI7slYK8Mlg=;
        b=YYOgQOBxYriqyVdzGoap15ZIFGfb6k6cIxEBxQVbdBWK7QrNYGSop5YWjBtnNdFzXg
         Y8ubKlQWNkbvgzQiw/khrWnNr28wiTuhUgz6+/zWJ0waw4d6G5K7LzNyXuYQ+m+npjkn
         WYf5ZcVcC3jLOL3IzuTiX6veye/89gE9/7OdYajZbNtQfv4pJwGdZ477KEQc6lnmX48b
         ovbDASjlCJpLmgz1CA55/MoJH2gFdZNn0PKfJ3CvlWuXnXgGcjZydJlyP6BnL1vVFlNP
         lsnXkc7D/k55D8qSzjAs8jsEs1BcLO7BV0AFdciTlzLLiFcZn16ervM+Zoo2OB46f6iR
         Jsdg==
X-Forwarded-Encrypted: i=1; AJvYcCUOwsZKiEFknDTWWRH7mxR/GHNUnCQk8YSCQ4yH2BUIar+OGgQsex8CtvOQ1lkNWTPxh7EDxfI557t3@vger.kernel.org, AJvYcCVVGfGbDKJDmWpWjBoYMTkAYaBprXs4T55z3JYDQrTOKj3Ixe8OzIHZdBCC2dwsJtnyQFGjmgPzZzV/gb/x@vger.kernel.org, AJvYcCWSL3LiEvijdCT11EYL3Bzx3Sqe22t9yztWlf6xPnReO/CqoGygFhSALjb3l9TSI3TdFuujAjiOoPkA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf16RRkfLVf4Mwtfhgt24kpWvrSGQx0yiT1jRbINPvQnzQKvSy
	rQ5S98mY5a3XaxLG5H1N1rWcVqLqZYg8Oa4A6W6YZgvGab1XxhE+
X-Gm-Gg: ASbGncuevPMPnNN5cecoplITwWJn6pIVT3indmqNSHRMHxSamXDuVnWK213btg9IcZD
	sIvmrJ4YZwkxv4DenGWoAO8syETdmyxGNS7eMXK1REh1xJdHUl/zHBMNVsKnd2Kse2XOixYPksN
	deDM1wRe7KpB5154cp7Y6uUwTwD4d4jiRDJpgHR9LjVeuYuX5ZmOtRXb/AqxD58mkONVFh2yaZK
	wG+8WYZ9IDufb2BygXWhD1QRsk3uCV2zG/X7LUehk856Z0R7QV3wozEGPQAExKhEXin4SEa2Wy1
	0d9NL8wH+52QNVhkdiPGNEDq/I5B49tvkPX0mklQeEF2nEE9fNLzBQzUke/DeA==
X-Google-Smtp-Source: AGHT+IGhrFEO2HuwZqu2BS3FajwuLpVL+6aFB+AWDbNlCDzTwrBAgFwyswrUfvs8CQoi4pvSFmINyA==
X-Received: by 2002:a05:6512:a96:b0:545:2fa9:8cf5 with SMTP id 2adb3069b0e04-54b1112793amr4131020e87.49.1743574183776;
        Tue, 01 Apr 2025 23:09:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580011sm1532802e87.149.2025.04.01.23.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:09:41 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:09:38 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] iio: adc: ti-adc128s052: Use devm_mutex_init()
Message-ID: <469d5ab906c3c723cb657bbcf1ce200fae255ead.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D5FZTS/uluurQEIt"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--D5FZTS/uluurQEIt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Jonathan:
"Whilst it doesn't bring huge advantage, now we have devm_mutex_init()
it seems reasonable to use it and maybe catch a use after free for the
lock"

Switch to use devm_mutex_init() while working on this file.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v1 =3D> v2:
 - Check the return value for the devm_mutex_init()
---
 drivers/iio/adc/ti-adc128s052.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 861a35169196..bef2d29c06af 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -173,7 +173,9 @@ static int adc128_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	mutex_init(&adc->lock);
+	ret =3D devm_mutex_init(&spi->dev, &adc->lock);
+	if (ret)
+		return ret;
=20
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
--=20
2.49.0


--D5FZTS/uluurQEIt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1KIACgkQeFA3/03a
ocWbrQf/cbJx7mbkVx2xQ6mtSBZVGw4gqWL5Fgtukf/Rj9hpm0pIXsCqWWT/pVYU
oKi3iHtySyGS6gpEKEBJDoz23Qun6LgJPtRcbmrJ+jsXmbbUA/FjJbUd0LM9QORN
mrDu9aT2nRePpRaOI2lxgLpePokBmFMmJeUzX6abAMILZi8KFpW5oUXEhPzzmS3R
Q08MpORMVpoJRef7rV+x5Zhe0OEdoq88bPLWA3gjZOn3N3N2AY4EwMItlAE6/3CR
ZxveXWxqBZKAh6bqZwgFX7YwmtaTFuTPeeyOh//hZTQ582/xx8ntH+gmQOE0PHCK
1vGW2XveL/ExMTgqEiXjX6en4gTGnw==
=kcFh
-----END PGP SIGNATURE-----

--D5FZTS/uluurQEIt--

