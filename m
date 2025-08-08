Return-Path: <linux-iio+bounces-22439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F8B1E512
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83E374E3E74
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3D270EBC;
	Fri,  8 Aug 2025 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKJanVI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99361267B9B;
	Fri,  8 Aug 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643358; cv=none; b=FUnwV1+8/Our0HGFvDpGpXqUXBw0ly9+d2Et/Brxvo7h/dNaSMKAUSDOCCvtSli7L5QcscrAGQy7ISuZsoHovhYxXjfBzZietQljcvRsksTIRUW6mUl9QLf7zIAnmOftQObVJDcmTcgShzqHXvHIpRxLfoL34lyqhwtT3gWeF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643358; c=relaxed/simple;
	bh=OYg8Gx9p6ZS5BYnwQy23wsSJHrlVh0B0YEUdjS+lPRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM6IWjCJrKMX0qPcWftfvIsXjrnMtUkZ1Xj+GdbXQo0agqYXx1sqMXef0OQeVgmwnKvjhrrOygZD8cBwVLdh81Utvs/DxlnM63P4Yi8PvDGYmgqvcdbKpRhY8aRCAg6AuNMoUYe0MkRbsER0v3CdqaXtAfoZZ7+BvYrrxrC9jB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKJanVI0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333a17be4e0so5179011fa.1;
        Fri, 08 Aug 2025 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643354; x=1755248154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIys3bAAa6pSMxUyZ671w9wq1HjPaUe9JQbuiuBDBrE=;
        b=mKJanVI0G+Yd8RCbvldY1jLQBWOQbobd3cqFtoSCAt2kpa5yk1WucLJN6iDvW54HKN
         C8FXZwmfK3WUBjvFYglftHiNW2+0ApYeojClwQMPZ9sg8T3zvLX4xHn9iOI0x3cBfX23
         xYYM5aorc5JMaA2V51QPVu1Os75SktiKH6fySkHYAI42V8bkX/mQKhXnq5ab2v3wPZih
         /SiXNVhLUzwYgXwqmHbZEh6i90mUZM9ZJLE2HGVOBOHSgg7+M+HO1OHasiqwVNjzKjGe
         g0FFtGsl8IHGkahdCCbrze7d5d4Ua2GCrpHX3xFe0idozVVISKdKDvMpFDXWsMOT9V1V
         nTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643354; x=1755248154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIys3bAAa6pSMxUyZ671w9wq1HjPaUe9JQbuiuBDBrE=;
        b=qF7nMuI6W92WUm8fr4y3pgf9YHGkbSg8wP4kvYz61lI4ZDZUut/K+rBuvW22/A7JR+
         B3A5VJ+2yBhTeimSYIf/Z6STd4DApxVkNlL7UCQy6L1CCjwrF+9yZehDM3vGAbvXr0qZ
         2IRzpO/o8J5tCvbi4N/ZTPw2SPZFqMFDOuVxHZzyu7RJ0dYrDuAVHSAInkJy4x8apE71
         Im8V94IuiMgHEP5xM6IoSOPe9sHO7t/72KAxqKw0uMnCfj0QGopW1EHM9HyZ6jEjlk32
         U1ROxat/Raaiy3HQ6dY35cEfgNsStWebPi8/hcQ+X0vlEKmj1pU+ClvWrSFL5+oZQIo8
         4VOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMluoyHkyhwhDFzMmhP/4QRPVeZ/CzwXQ9eaZV2lvvBPeM9c9skNt2hVKk5ioLThm8K6IjFY03bepA@vger.kernel.org, AJvYcCVaqf42JSoPSpJtW58nfo6EGZWhVQHD8N9siFqbvdzwcrrJDvFnlEmh6XGTi1Puzabo7XyiJ46Rs1lb@vger.kernel.org, AJvYcCWwNAHgMf0rVIT8T4fGMnyzOhcVjlz0Pib7ta8kMGxvsFUnjT0asLtTbQHIOCe4GUHcoIDOfoST2GyonGDk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3SRi9ERWSnhbYnp9QUHm3V9wGCfp858anSIdiptbxOYB8O0F
	fyzwK9Nes+WFkXgYYaxcPIncrpMLm2rIf3fTJWQpSdHaNPzAiolClg2+
X-Gm-Gg: ASbGncsHduZQw9DYrPtsoBG2BGtd++3cI6zksTt58Q+5TprIZHC8iYxZpq407L4zzWl
	RzvTOJv4BiM0Q0+O7xejMVnBzJk+hDxy7OrgrzLKwMwNRrsmbrvh1bvESxPoTF+Kr5E6BDGz9mG
	UTrjPkO2dH1L5CWCpuruCtirgJGItmRMlKzOEL2/SLADluMcIQKHBKw4127JsLI+Gh48/FBBoDv
	JW1s8kK/h3hNuUb4BB5pWXjrIOGtqJCuMcNDBJicujg4B13Kw/K6/8Fndqi1kFxirtoeBWWLr2i
	gyAaXT9poZaeJw3rSa4xk2sN2Db50/zAKCZp+cbAoWU9arMq3mylonBHa69JSNEmyPY/NKwAkoo
	e+njDWUo3hucXu/oO1/AN3j00EyEx
X-Google-Smtp-Source: AGHT+IHd03hIZFq+mKRDRpaNgEPl4nto3IHVTcpImtQsHtoKeXN0wVAnhIUbxRIPv2p+abqnhAEVDQ==
X-Received: by 2002:a05:6512:1597:b0:55a:90b:7a37 with SMTP id 2adb3069b0e04-55cc0157e86mr561404e87.50.1754643353425;
        Fri, 08 Aug 2025 01:55:53 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9906dsm2953861e87.83.2025.08.08.01.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:55:52 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:55:48 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <2a8c8107475f2e394c1a0a51c9a9ddc941132b5d.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2DFhNzDdPZ0QcWX0"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--2DFhNzDdPZ0QcWX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.

The BD79105 has a CONVSTART pin, which must be set high to start the ADC
conversion. Unlike with the ad7091 and ad7091r which also have a
CONVSTART pin, the BD79105 requires that the pin must remain high also
for the duration of the SPI access.

(*) Couple of words about the SPI. The BD79105 has pins named as
CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
MISO.

DIN is a signal which can be used as a chip-select. When DIN is pulled
low, the ADC will output the completed measurement via DOUT as SCLK is
clocked. According to the data-sheet, the DIN can also be used for
daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
'data-ready' -IRQ. These modes aren't supported by this driver.

Support reading ADC scale and data from the BD79105 using SPI, when DIN
is used as a chip-select.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v2 =3D> v3:
 - Check for missing convstart GPIO at probe.
 - Use indirect call to convstart (via function pointer) also from the
   ad7476_scan_direct().

 v1 =3D> v2:
 - Fix the conversion delay for the BD79105
 - Drop unnecessary GPIO check from the convstart disable
 - Drop unintended whitespace change
 - Fix spelling
---
 drivers/iio/adc/ad7476.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 6cb2cbeafbd3..1bec6657394c 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -32,8 +32,10 @@ struct ad7476_chip_info {
 	struct iio_chan_spec		channel[2];
 	void (*reset)(struct ad7476_state *);
 	void (*conversion_pre_op)(struct ad7476_state *st);
+	void (*conversion_post_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
+	bool				convstart_required;
 };
=20
 struct ad7476_state {
@@ -64,6 +66,18 @@ static void ad7091_convst(struct ad7476_state *st)
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
+static void bd79105_convst_disable(struct ad7476_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
+}
+
+static void bd79105_convst_enable(struct ad7476_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
+	/* Worst case, 2790 ns required for conversion */
+	ndelay(2790);
+}
+
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf =3D p;
@@ -81,6 +95,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
 				    iio_get_time_ns(indio_dev));
 done:
+	if (st->chip_info->conversion_post_op)
+		st->chip_info->conversion_post_op(st);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
@@ -103,6 +119,9 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 	if (ret)
 		return ret;
=20
+	if (st->chip_info->conversion_post_op)
+		st->chip_info->conversion_post_op(st);
+
 	return be16_to_cpup((__be16 *)st->data);
 }
=20
@@ -273,6 +292,22 @@ static const struct ad7476_chip_info ltc2314_14_chip_i=
nfo =3D {
 	.has_vref =3D true,
 };
=20
+static const struct ad7476_chip_info bd79105_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(16),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	/*
+	 * The BD79105 starts ADC data conversion when the CONVSTART line is
+	 * set HIGH. The CONVSTART must be kept HIGH until the data has been
+	 * read from the ADC.
+	 */
+	.conversion_pre_op =3D bd79105_convst_enable,
+	.conversion_post_op =3D bd79105_convst_disable,
+	/* BD79105 won't do conversion without convstart */
+	.convstart_required =3D true,
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
 static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
@@ -332,6 +367,9 @@ static int ad7476_probe(struct spi_device *spi)
 	if (IS_ERR(st->convst_gpio))
 		return PTR_ERR(st->convst_gpio);
=20
+	if (st->chip_info->convstart_required && !st->convst_gpio)
+		return dev_err_probe(&spi->dev, -EINVAL, "No convstart GPIO\n");
+
 	/*
 	 * This will never happen. Unless someone changes the channel specs
 	 * in this driver. And if someone does, without changing the loop
@@ -401,6 +439,7 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
 	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
 	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
+	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
--=20
2.50.1


--2DFhNzDdPZ0QcWX0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVu5QACgkQeFA3/03a
ocXmzQf/dvwrVkreuDO18fqPSKtlWrr2euJL29mcRd3F6DTN+5pS/SUkBGo9PqCQ
L/xeGP7CTJZxrdzKWxRaKk+0YwXxc0GejNnmTROngnLN9OSFCP37JUO7Wf5ZI3lR
jgRSjx36A5sSurQZC7W3SL8hJAt5k/jrrXUJDCQsHEJcA0csLV8QY3MOLHnhBuwZ
78Knxs/uVUi92zBqLnNU0PicEXscxLduzXvyK4PUkK7iQhOEa9jwrw7xvQfQJeW8
gAn61NU7vgMSZHZmvdkFGeu16qFZZ6ceMCgB9mIqMBYsso9CFfIFn1qF0ES8j9Gt
s6lwSSKrVsFibkh+i86Yi9VvC3qseQ==
=Abxz
-----END PGP SIGNATURE-----

--2DFhNzDdPZ0QcWX0--

