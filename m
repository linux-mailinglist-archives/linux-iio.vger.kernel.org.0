Return-Path: <linux-iio+bounces-17405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADCA760D2
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C20C3A633D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E451D416E;
	Mon, 31 Mar 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQdlxg4j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BC1C84CB;
	Mon, 31 Mar 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408233; cv=none; b=kRJPVJmynSSNODSBzRUUHuju58PAluK6/XnYoY5+hDLI1coWXnsCRfq3JUl9PaOrVUkoFJ+XHHaI9nRK6O/IZPSfOgl/yNAizs0Skjsn9Kjm6mrs3vc+1v35ikKomTLx3iXuMvOe7fntr9H4zEn2qWNnFoQ53W6tgwP38lwdsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408233; c=relaxed/simple;
	bh=v5/aGBXrnpmIR/MRqYG6B6qzr4YwPYCQPlaNNqpX0Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeHRhGvpyeFRUJqF2gfx0lTQj1xrDd5T84RWXWwa7X5GYA/3MRy9TaOC3pMlXHX2tiKJBut67w0Snsx/KCGdQ4OvqSVOP/4c2gwAXWxvAmtJ6qJ0yM0v+rxFEwW0fBdEKVrqfUFn0futB6sFajsLlZXAqxd6AygIo9eelfYbQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQdlxg4j; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307bc125e2eso37336421fa.3;
        Mon, 31 Mar 2025 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408229; x=1744013029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uVVjMkbZOkaEXnUCiz9eqUlCXr+M7NzQvljWk7Fl/I=;
        b=NQdlxg4jRAJ29P6508tjdwEMQG1YknL5pvEduKFM3Ts+9+0uRGBvxKY5QLMHa7Sm0h
         IITZghKpHkpfwzpX9TnGsD0VP2Z2hzFSJkRQjL4tr1Z+uenUvCcaudoxkzHe6zTt/Gz1
         xyqdZBUmngWI+4L3yQ3xHNhAAva6UI0xSmjm6zGwcaXoEWAmXxD86+0zWF7YZyOGht/R
         tfvQvolaKJzi3cM19NnL1zD5iMtvnnQtX9RzS5UdomNk1yF71vxjd34TL5VDcrciFZSX
         paA/tx1qh2jBhjD9ejDIchVTGupprmmsiZoqq+2hRgJkkk1LsBfDWBYP4/2Wpz8fSzBF
         Ktjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408229; x=1744013029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uVVjMkbZOkaEXnUCiz9eqUlCXr+M7NzQvljWk7Fl/I=;
        b=clJDJP+Sx4MwLxQrEQMr+KltKnWeNq/04Fqb9CPh/8KV+8XyKl066Lv3tHYl1EOh8B
         TThPOCAlValnhmhhS4MWFsTLccJsa30ibO5uKlD3rO6rN79CdbTcKs2Yxli2dTY6PPbZ
         bESglUlrrLcxIP9RVG0ed+ROqA3ZmAXTVhXx2OmIrg3rBD4m6jO3l5Z6geLIDndUczmw
         DsPBKl43sG7Hux7VvmnqZj3qY6BUePc1GVWA97YUTx6HpvSZz3NZnP5TrUqo2ecje5xG
         sKXFjKJEJSkJqvPu4xloA/kJYEuH9+rmQZHD0x+466vhSv5/kMv8a5Qpq+GIFuvdNq6r
         78lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV5aV6E4Y1ufe7lKrHJCrRL/+p9f4cCVCuyyKTJuGFu3B3UBw+Ms03nKbv4fMlkOmSFjAuvJ78sK4bouzG@vger.kernel.org, AJvYcCXccsRUz/sSNyCjFgNNJk/0ICZfpUQy0IxGghA8JCKTxsZRT41A9/Sm/pAR1PE/okzRDmozCjrg3xMS@vger.kernel.org, AJvYcCXtIjcqt2YamxvwDyc7J4C6GKm3HjR+5zcW3E8rLwM28mvuZ/8Sx2T/TD+BxJe9G3/IIkS6YnpGymcA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tk55TXhT/8FHXqWGNJcQ77VigFYGdmjTm7ysdUNnol8ILGdS
	8ast60dqIndd31gU+LACuVVMU9tzs71uTuRbdxl8F3YTV0dVc2QX6GbbfQ==
X-Gm-Gg: ASbGncu2kIjkzbnzoBzUV4sfZmPqPf/BbkHnAbbix5pql2RNdxASqfwN13OEU93tnvZ
	uU5KZ6MzbnNROgd1lwyHPdOawCWyPit8RfbKkrSn+C2ELVvPqY2CPA0uVH1boZRqdxJNZwOU17A
	Gg4Pe5mL7w5oOxuLOMFf2Z7w0serZzavQpV2MFcI4Fbivfr/9wLVjB2VU9oAj+dhIFG3omGKy8t
	vk6rwqjoW6G0zhgh3OG9jem7KIShi1Lua7acxPbSfMV4zihZtzXTs7g8xiZsr5HvMIl69d1HyFr
	XOnoiVBBU+nfC6Jf/BHxxCku2lzsMN/VIE18Xm07FQpNW88ReSE=
X-Google-Smtp-Source: AGHT+IEZ9/OxIiRg1Uwf5a4xvWkYALuTerAQTqhbJGtppjQX2rxuD4cTBU1LKgPnOaM6gIJe0gnlFw==
X-Received: by 2002:a05:651c:550:b0:308:eb34:103a with SMTP id 38308e7fff4ca-30de02dada5mr32824101fa.28.1743408229404;
        Mon, 31 Mar 2025 01:03:49 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2ab8704sm13268131fa.29.2025.03.31.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:03:48 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:03:44 +0300
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
Subject: [PATCH 5/6] iio: adc: ti-adc128s052: Simplify using guard(mutex)
Message-ID: <93a9d7ab74cd045949a2e2b6301f29c7d83d72ea.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mqsga9hZZTgjTnN1"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--mqsga9hZZTgjTnN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Error path in ADC reading function can be slighly simplified using the
guard(mutex). Do just that.

Also, document the mutex purpose while at it.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 90b23c68daea..c68ee4e17a03 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -9,6 +9,7 @@
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
=20
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
@@ -26,6 +27,7 @@ struct adc128 {
 	struct spi_device *spi;
=20
 	struct regulator *reg;
+	/* Serialize the SPI 'write-channel + read data' accesses */
 	struct mutex lock;
=20
 	__be16 buffer __aligned(IIO_DMA_MINALIGN);
@@ -39,18 +41,13 @@ static int adc128_adc_conversion(struct adc128 *adc, u8=
 channel)
 	msg[0] =3D channel << 3;
 	msg[1] =3D 0;
=20
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
=20
 	ret =3D spi_write(adc->spi, msg, 2);
-	if (ret < 0) {
-		mutex_unlock(&adc->lock);
+	if (ret < 0)
 		return ret;
-	}
=20
 	ret =3D spi_read(adc->spi, &adc->buffer, 2);
-
-	mutex_unlock(&adc->lock);
-
 	if (ret < 0)
 		return ret;
=20
--=20
2.48.1


--mqsga9hZZTgjTnN1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTGAACgkQeFA3/03a
ocXGQQf/ZpHbeZQsUAs5jSHkdAsYJArz6IrK81hgfH0oOSBexe6HojBS4O7i3SYO
0bLYV/E9zV0o8Vy7QzopE++VQbXauzBrTaTbfHoFT+wZ9XxStLhDgy2GzJ8iC2M9
s9imnA3PCCcLScVKsrgd3JHqnOL8Ypsq5LD5c+9VyeJuvAZ0TbBFfGvOHFs/s9Xb
I7ak7N2RETaHEQYGo6mT4x52FB4vyZV/fnoTQ09aHGtkXigvdSDcgUzXjQx/D2vU
PXyTyTA9SrNAp/d115PekRwDcXkFm6NWfVHpCewl+/gf8HWH5aCu2eyz/KrY1GXk
OhI7JGqkx7o00Sn+HkmpwIgOfQndQw==
=hJxn
-----END PGP SIGNATURE-----

--mqsga9hZZTgjTnN1--

