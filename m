Return-Path: <linux-iio+bounces-16030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6AA42B79
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152FF173603
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E08265CA8;
	Mon, 24 Feb 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmX5n6Uf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA7262D38;
	Mon, 24 Feb 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422053; cv=none; b=HQAf2bLDEeR/lVKyluVvtS1KyiKdrTEVebTO77mxfon9R9I3HnxdDfmyANELJRxF/M4sTFSbNCHumxxYqIGVaHrPhCq9lXJV7NGrfxnRxf0+jcNoy9RgdkRxupiRzqdMEUlydVkipMFP/jtZN5RtaWU+l1NhmCOGfy9pa2YCijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422053; c=relaxed/simple;
	bh=JIpIZOP5vy73oO9iDSgdLJ1PBCR9YKveXma6mA77A/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3ox1uHJQuD3zCdy9wEq4X2349woF9yojWQiuwDucbxiTKIjtw1H9FSlWlgmTIoWBY7Awe2uN/UKn6BTbBwFSB0E36VI4vjDtDs0wTU1s7/7Jo5vrsmFfgwEprKaSEDq7gRF2+sl8x9rBnGMkDLue9vRS0HuM2Rz9Yiv23kqQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmX5n6Uf; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461a485a72so4622256e87.0;
        Mon, 24 Feb 2025 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422049; x=1741026849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvtg9LiT9FPYIsAlfx6bzRkO3KM227JB/0Q4qpEPDEo=;
        b=BmX5n6UfMmKP28G3n8CqDpZrOMMwojAffpcnmU1aY+tfz9zjH1BS+BKkeJF3hY2DbA
         UaXfkCnacHSlXDrzZD1fbVfKWjCqZ7dAJIxJVZQW8JOlZH6XGayGfeL6hmMGgsftBfwW
         KTOfYWNFoBT0q2NEGXhusHFFqpLUlntrbuigzMk4NdQBuYZWNRKmG8kXtD8WpyO1cReU
         EHulGx74CYzINswrSVlbPLOFogm15wQLPVEhfDLoslIJ1INogmUSEXaN5cNz5ERDClYy
         H/Ebs5xCYgU0ASJIDrE/oWH0uny5ffzESNEqQbPftvUfSK35st0UdjZgEMOPgp8MHT8V
         4vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422049; x=1741026849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvtg9LiT9FPYIsAlfx6bzRkO3KM227JB/0Q4qpEPDEo=;
        b=Njq9RHOAaNd66kaQqxAoI0xROqVA4ANE/9VniEtndv8C+7uEG54VNrJzR//QWl7doN
         dMcb+ld//SjgmMbw8pf91SkWchI6V8XZA5OeQUyOTtEITtFH/P5USL4az7rXf3MSswiB
         fUrDWBVYlBsolqfrMiCs5dz2atusoO1wJA1HYGIQqwfbSmI5sKpPlaiUEzLvfzq0FPQQ
         KhP+h5rOqPcwfypskPyvs8Neuhy8NWqZ6rrc3wfQwhEtFI0y9OrR7AacAUVp+HYasXlZ
         FjcFPXr+rGsZTSFfkSWpzXm3TpNNMrPfTO4wXRkpY2lo23B3EjrmcQvLWFVMu74YDT4/
         jfsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3o9Xg9F/OEGdhcjFP/0to0LYOQFxrFeAZE2mPlOUht1n2oanlU9u/V6jXpjJShqRmR6bW8pqaM2oY@vger.kernel.org, AJvYcCUEfULwHQXu54V1gbYixt2Yu03vObPQTmrvSgZedgZsH7Wd29V7qxS82J+bfJSTY8a/tBKZ1TiVM7E8vBRx@vger.kernel.org, AJvYcCUQvsJGPvIjgO9ZlWYW5WOLd2GSeu/s/UxAwEplGBm0qUO/4Hni9syaStv1YakxGb4NwAEn5psJYV25KSnsi8v4N/0=@vger.kernel.org, AJvYcCVxTnOECF8vFgE33c7TSfC1TPq7bRHxeXjkBoi8Nry9bW0XaCx90WKNoTtdD7E60FW8Yug7KezXPtw3@vger.kernel.org, AJvYcCXWnHRqwb3SBb/esf2XoRrOCOiWXjJ8r1GUGLW0+QGvtWpH+6aAVmdzcRq7lvgjrAai1GxsOiFuYxAmpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjd0MRWiH+BnXRAx9Q9l000yde7e7kMwcivsDB6nvbQX8ZnSAa
	S+q6wNetW5N94uU/A2JL4kn/sQlqDWHq4Rr5DeLojW/D4Jn3x76a
X-Gm-Gg: ASbGnctSOHm4757/5y8Zf3WgkO9Hl2OXEm5V9OEqWLyRieinDz7RcZXsiFTxdqlQueV
	GkJkSQE6Rfip1oHq2t//jArN/RXqHe3yNGnjzrrv3rT7FRRka2NK1GUiIZcEVk3QnBu/6Y0f+Ib
	MrRnQXuef5DmjPaJv1ZD6uKVRn+jovuvXgC0jD/ruQokGS5L5gpEkDTX7xZ04U2gkfdwswd/KT1
	g8GvC2lC0e2eaBqsLxC1PKgxY3FyQyf43An3oh6JUP25C2IGQqfMTqcGyssfHwo4aYfK2o6XfaA
	3w1eCrOe5VjTLUFDXh3MFGga5I/uddQL
X-Google-Smtp-Source: AGHT+IEnOT33v2tdUxI89+C2mfa+nuzArxhmJ+3qGyLgimw3UzsP7sWa0GhRzJ9QUi85xzA0PWfy3A==
X-Received: by 2002:a05:6512:1244:b0:545:b28:2fa2 with SMTP id 2adb3069b0e04-54838edd962mr5783123e87.7.1740422049175;
        Mon, 24 Feb 2025 10:34:09 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae82ecsm22381fa.98.2025.02.24.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:34:07 -0800 (PST)
Date: Mon, 24 Feb 2025 20:34:01 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 06/10] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
Message-ID: <38d39befcca110132fd4349c87fcb5d7ff51a2c8.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8S99u4QPCxXt6129"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--8S99u4QPCxXt6129
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Device pointer is the only variable which is used by the
ads7924_get_channels_config() and which is declared outside this
function. Still, the function gets the iio_device and i2c_client as
parameters. The sole caller of this function (probe) already has the
device pointer which it can directly pass to the function.

Simplify code by passing the device pointer directly as a parameter
instead of digging it from the iio_device's private data.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
This commit is compile-tested only! All further testing is appreciated.
---
 drivers/iio/adc/ti-ads7924.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index 66b54c0d75aa..b1f745f75dbe 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -251,11 +251,8 @@ static const struct iio_info ads7924_info =3D {
 	.read_raw =3D ads7924_read_raw,
 };
=20
-static int ads7924_get_channels_config(struct i2c_client *client,
-				       struct iio_dev *indio_dev)
+static int ads7924_get_channels_config(struct device *dev)
 {
-	struct ads7924_data *priv =3D iio_priv(indio_dev);
-	struct device *dev =3D priv->dev;
 	struct fwnode_handle *node;
 	int num_channels =3D 0;
=20
@@ -380,7 +377,7 @@ static int ads7924_probe(struct i2c_client *client)
 	indio_dev->num_channels =3D ARRAY_SIZE(ads7924_channels);
 	indio_dev->info =3D &ads7924_info;
=20
-	ret =3D ads7924_get_channels_config(client, indio_dev);
+	ret =3D ads7924_get_channels_config(dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
 				     "failed to get channels configuration\n");
--=20
2.48.1


--8S99u4QPCxXt6129
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u5kACgkQeFA3/03a
ocUP/wf/VssnGJzhil921kJivWyVXzSnMaeybHUgfqTjw5Zs8pEJEjyxYGmfB0di
tjOo9fM6CU6pCBZ3XAkIo/2gIF6tF/T1WqB3fi0FCoEaBom/Yi415/zqjSVEBEiB
Xf3hFCVZ4JdCkVfk30vXw7hRKFPg6gaVwl+pNTRVWUXEUUVAYuuUCHNcJm7Xl9t0
jBu2CWoYYda3OcfMZ0Ur8P8ilEnUuLQ1xUB9L5gTjS07zBUZKwGsXOUWcn1zzQl2
xBOhyA8kKiUUExnjupG8PFetjj2J96xvb8CKUhFYlL++kxVjSV69p5rrNGJNfoME
uHF7y3m7tQKmP0+oXv/AlOapJUp5BQ==
=3pau
-----END PGP SIGNATURE-----

--8S99u4QPCxXt6129--

