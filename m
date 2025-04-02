Return-Path: <linux-iio+bounces-17538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AACA7883E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005023A6B94
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21A232368;
	Wed,  2 Apr 2025 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIw3jWvM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894C3C17;
	Wed,  2 Apr 2025 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576366; cv=none; b=OKMFr4se7QNoijdhH79PRkWUysAWZWI6NRpnOiyLR6UvqG2aIUHYoGmqJ9mFsgGn1JqfGmLpFLCGpQp88U9WswYYyHEDLXotOnGiJyLo2h6gnZZtedDVzaXW2PsjXKUJM3DUGC80O0h7oHA2a9yJVcj8B0oztb8/mvaUU5eaXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576366; c=relaxed/simple;
	bh=NuDLQRs5l0dChPpwOQQfl42OYxc8n6kig9UU+8ovl4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syaGrVe6uXBQ8Qe28rBXdo4q+GzBRYNTo3m9cLrOJncOmAkiKtMBFqVv7LbWZOgcN9upaDWKhWA6HaOXM6J9hEr0j/1OlPVwzAo87OWP/BGGx8X7IVQHBvE8XzcQi5wCp8gSGnTJwgwLs2wNxJ3XKcBZrkEE7py+CwZEv784jEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIw3jWvM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499659e669so1878441e87.3;
        Tue, 01 Apr 2025 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576363; x=1744181163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EA3jhMqOTPL7EhQ50J1i67Md0hhqleTtmmrsXC2hOk=;
        b=hIw3jWvMo6HAqC7Gs/6kK9HUjHYlD4mbaemEP4lHZ91qILQ6U0pwJRt0bn3Q/RXehV
         kc+Mg4jnTrKu/miOBXHLx1ZmhLjJTH+xKJKL3bL9QAZFQmPf7mgT2BDa04ks61fE9XYJ
         2r2jPFWAvIvNQcxsrqboEikkdgWaJOLXGJORqzkfZnScCmIVaryJ6vvYxV0cz+Tx3y1C
         BbNIsO+JX+67eOeMEd39LiCmrd/RSd/KTDe98SPkJRsPJ9tM17VF0E4OlO5ABpJqZWe5
         7Ccjjl7QU5tw8lkkts/XlyVluCVIKz3hi8udy94mOtlGkxr6uQSWpdoEuGO14UvOFcmR
         oT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576363; x=1744181163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EA3jhMqOTPL7EhQ50J1i67Md0hhqleTtmmrsXC2hOk=;
        b=dtqYgFdx3bKSXpbl1jwji7HIlSJM+6H6pr8UlaauY+HHWJKu0agZQQdI9opq738wd/
         FRKNhNO98lEDsrA6YITXQ1IsBcakWIMptQcCOLy8H813NBqgKBc9OQBVSVq584kjIWTU
         TT3vkJKgr/uEt5kSZr5jtnAGDLz76pR8qdnvSfCPbIxq60+bTjUBkiNL807TkMOqnyn5
         nBBFFmpcU3/mWsAKq22wfw027vxsJaNfyNkn3tsnFHNkIGTm0ihHYbKl+Nov0DhHu0BJ
         /U4uiGrfe9JzA6d6LqNFU5PunIw7ocZv+cboDy6FFaRDHfPMReRD8YVDB2RhxOP/U/lh
         UF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ83Md9e54LNtacLJbRMfuAI5wT4tQAvEtF+I3VPd57Vc8cXGiVDfM941qvT/8eghsCnwO3CukM5af34+g@vger.kernel.org, AJvYcCX2mbG8Xsm+5D+o1iPmgIsbaAKF8SqBvjN2CwrfFxxiyst66yK/JO0ywzhSvCDGPnreKC2PKdy2QUFb@vger.kernel.org, AJvYcCXgNKQfdbWp4TPGbJ+MaIAOtVJV6okcRo9lVr65rDzG7/EhkHo/UgSq/OCnFEMlq1eemp/b9Oipd5SE@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcnD+jCKo3tWHkp5RngeJsB8uRF1P/zDoOmXxeAPU/27m8DqD
	t90Xf90pr4KvPdpQAevwoOgWx7ieDWw/694i4dgjcJ5MCeMLTfybnnqGiw==
X-Gm-Gg: ASbGncugE3H/ghj6Q82S3izxtfBQBbm7ChwFmCWgmoP+GLyI9SlnWFogZRIyZV4MOsj
	j0iBT13sHQkon9hM7pPrBTyP0jCEOOvPO3bEcfisMNsu9XM1WUxUWEQnvJKio2O0o0DWBHT6T7M
	mR/OUJpGm65oNN3SaMzQxe2d1HrduBn9wS32sdxNDwCdzptAdV9wCjNdyN3xP8zkBLrX0vZi3hp
	I/2OFMbt9/AkvliSyLLcksRjT4HOEnKAylGr7QgOtJ5PHHLTtr1C5gplLa2q3kEzRlJPsKdkCq7
	Fiir7GAsL0xv+PEEyBzFan+a6JuwnRez6T+QrUbHMmFGeP5Ljcc=
X-Google-Smtp-Source: AGHT+IH5GCpE6QqU5Mq/4YURzGIUmuOkOuIthVzMwLwK3aArcaQtDZ/O+W0/TUDnugU1nkzcTIbJcQ==
X-Received: by 2002:a05:6512:3b25:b0:54a:cc76:1676 with SMTP id 2adb3069b0e04-54c0a52846dmr1605252e87.44.1743576362479;
        Tue, 01 Apr 2025 23:46:02 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094bb0e1sm1551511e87.52.2025.04.01.23.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:46:01 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:45:56 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: dac: bd79703 Store device address to 'address'
Message-ID: <e53cb4120d16a3c678e1f391b600af630d6767ce.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9MsS00R+CXwbngT5"
Content-Disposition: inline
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>


--9MsS00R+CXwbngT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79703 needs to identify a channel which we are reading from
in the SPI transfers. This can be seen as an address for the device.

For the bd79703 the address is nicely aligned with the channel number,
so the driver uses the channel ID for the SPI transfers. This, however,
does not need to be the case. The iio_chan_spec has a separate 'address'
field, which we can populate directly with this information.

This helps adding new ICs like the ROHM BD79702 where the channel ID is
different from this address to be handled by this driver, so we don't
need to have separate, IC specific mapping for channel numbers <=3D>
addresses.

Make the 'address' field in the iio_chan_spec to contain the SPI protocol
address for the channel, and use this value in the transfers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/rohm-bd79703.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index e998ab51052e..236aa98bf005 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -67,7 +67,7 @@ static int bd79703_write_raw(struct iio_dev *idev,
 	if (val < 0 || val >=3D 1 << BD79703_DAC_BITS)
 		return -EINVAL;
=20
-	return regmap_write(data->regmap, chan->channel + 1, val);
+	return regmap_write(data->regmap, chan->address, val);
 };
=20
 static const struct iio_info bd79703_info =3D {
@@ -82,7 +82,7 @@ static const struct iio_info bd79703_info =3D {
 	.channel =3D (_chan),					\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
-	.address =3D (_chan),					\
+	.address =3D (_chan + 1),					\
 }
=20
 static const struct iio_chan_spec bd79703_channels[] =3D {
--=20
2.49.0


--9MsS00R+CXwbngT5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3SQACgkQeFA3/03a
ocXcqAgAr1E03RS2gse8NPhoymcVGw0Qu+fG8IYXPGUGcOpLUvrS4kXr6GUMpjr3
UWA/fsI03TeotrtnB3qxvvWsI/TT7B6aARbIjD0h/Uysr1tldPoetg9h4gsM6CU4
KH3aNpCjjjMlagsR8pt5dLS/0rNhqH6/pvpMgf4h0L/JG5Bs51aK3IAk6vENpJ9C
Vy8+2kvh4UGtIVfJt6BVo7v5Q8bOk6GREiftumHgEOIsNizYgWFJ6b2KFQycAvRc
OOPDbeYScJJUugEWcQOb8P15CFKZVjHBa2SY2GmZmn+NiK7Sw2YQ2i1u9UU/9b9g
xMUDRYpDQuVlc60SUP4i5zxRvGHipw==
=5cZJ
-----END PGP SIGNATURE-----

--9MsS00R+CXwbngT5--

