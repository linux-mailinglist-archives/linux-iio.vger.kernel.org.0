Return-Path: <linux-iio+bounces-22328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2CB1C0F6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB76562549A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5835217723;
	Wed,  6 Aug 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc6VfU3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D221423C;
	Wed,  6 Aug 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463891; cv=none; b=Una3Ud0Vw8np8RjcogNS8IxIClcvYAjOroE8SomxBDEtaO2X8gaZ1cs6hNYhQP0WSt1RrbnGgizzYc+eW/KhJ2e2gZmCHO3mVxzgpRhe4xBB4hkyowgNSsAJKQDehCw2aXgWTZxOLXYqmMnM0iM7QIemtiWILJXl3KzVy2dCP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463891; c=relaxed/simple;
	bh=CUxnQ4GY08ij99cYSYWD3iJfG1n9N6iSRh+RypB4a+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu/Xmb+eKeHpw70WQR90Sj9ZsA4kEP8rPcfzUZ7w5OQ+UsafOBijR+026jpqCMhUUaT97YJFH2wz2dBu/CV0w0Msoobbr4sAfmLBPaNMBQPBzYa5QQ+iORS+uHU7ofcY2CmsLrcWLyBxcXY0ZRKSYf17vjPJNL86zifiVigjzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc6VfU3e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so6257961e87.3;
        Wed, 06 Aug 2025 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463888; x=1755068688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2OlHEVAsRkjY5zAiXvjq5Rb1uihfPZ5ZiFUL+/7JTo=;
        b=Bc6VfU3eobb6424zP0OoUUb6e6VBHX3P7/IwdfUKQrcitBJ3IlzEutI+Cd2M4XgG2N
         U/zGbwHMklypSEbNaGVSdBvPPBcK9MiOVOQb+aPPvplAfVR0Fw3z0FUM2/7iqD/Tv/Zl
         x85lwI0OYiZ63dAWceC3dvbsaHiA5zlh6LCCupYRMnMDLektLUZDrViMz3fEPWv4qLYn
         nkJt6YGU2h4MbYkNnCsT/NMIOuVF+5MO77ba4gJ4eklvqoKyVzNke0qGGyG5IBrac5Oz
         cEwsKehe/TRMFUiMQ1QpXZMIZLPwYUeZZxINwZbY/nEG+oW7ChEJN4lHODnd8Ub0e9bj
         /Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463888; x=1755068688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2OlHEVAsRkjY5zAiXvjq5Rb1uihfPZ5ZiFUL+/7JTo=;
        b=ce/EucZQhcofYQPhus16nfaoZh9TTAOnByN2fMJ8UzbXuykuMR/F4HNzGyWwPvqIR/
         NJjqOSSmcB2Ynkxw87jq+tC1Mtbln4Lkwzqm5h7AaZx6BovadG5snpxSxplSgV1e8bA/
         JixyD5kS8Mv8ckus0qeWRC8sdO1a+R+vU49z3einobXkmX+m1KzVGw3UZaAc03wQ9Lib
         gK3CN3iJrXIUCy943BJbGMa16No+xz25Elw1N7XWF2vzhHoh7PHADbK0I++DzHMuIOEq
         NBJLNvvaWYIGSWZl4azHKU0DrO2Ln0swcduigqYtXzutomwSqv+nsOd2R0aR1lt5OaOg
         XINA==
X-Forwarded-Encrypted: i=1; AJvYcCUAx2lYFH2zUvBLI/z5BW8AIXYtz/uhNKnIJUqXMm/vOqCMrdVntmdthe88tW6sTI64wrwP3Hmv6B9+@vger.kernel.org, AJvYcCUzyrHz6Hm7vol0jOR5hC3uXkUackI6LG1le52vBf9ImFEjPctPeil068sNhugAzc5PNfPdIwNdcFkQMEFC@vger.kernel.org, AJvYcCXTvf3FfHEgUga4IbXRUVld/+b+FnH/NC2m9lNL7dNLSB0/COz2MWr5PfnZDi4Wh8Pa82GFwYZXEDtv@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcVq7JDR3uU1yWGWo/ra+ZHl6ZUxB6xFeFuNAHqmk4yEsdYUW
	G4XTDm1iCpZWvlhq4jarUXSJrlyrvSkIT1Fm1tmolUSCDuaM7jyRbaX9
X-Gm-Gg: ASbGncudntyVKyXVL/HtuPpsuEnVRx+8TiCng0NvjziIxdsu82KXLc5zBsV7hf4a8Tm
	vr0IWQyRjLMWY7Q6Moor8oPRXpNIxnA7zPpHqQe0vWJToCD15jt83pjR9XbmVEf5N/mme/vrfYl
	wfX0stARlY4D8qAY6FtsJKoL3DnDkZeneKo1eH0enmf5rFNSQOpoE2/iU4CK7AN/k/VISLX892L
	VEBZmtVGc2pMxyK1J/fvepkYddDY85Gye73g47QDBvvVZVswO2pBneD2WkNDeGxTmwdjI6INeTU
	fnJnezk1JoI9vlVrsvJNQCM2iaKNHFgaOMfQNnB9hbi2ysA5vu+AzBjQR4mhQAntrmA1BjGcqMU
	2HTLKMDx8cuP0grI5Sl9IAbPDQh4u
X-Google-Smtp-Source: AGHT+IHjkXKx26NwkNcZCzkQ77KGiHP6CQ4dceFn7PBBWV3IOnqgWpFoN/FcvxfiuwiF9Qvp79p/Ww==
X-Received: by 2002:a05:6512:3b10:b0:553:a32a:6ca with SMTP id 2adb3069b0e04-55caf35d800mr583199e87.32.1754463887459;
        Wed, 06 Aug 2025 00:04:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ca388556asm263590e87.95.2025.08.06.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:04:46 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:04:43 +0300
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
Subject: [PATCH 7/8] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <c7f94cdf9bdc6882953f6a074db3fd87570fa98b.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aUGwjoVvL5m2/5qa"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--aUGwjoVvL5m2/5qa
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
ISO.

DIN is a signal which can be used as a chip-select. When DIN is pulled
low, the ADC will output the completed measurement via DOUT as SCLK is
clocked. According to the data-sheet, the DIN can also be used for
daisy-chaining multiple ADCs. Also, DOUT can be used also for a
'data-ready' -IRQ. These modes aren't supported by this driver.

Support reading ADC scale and data from the BD79105 using SPI, when DIN
is used as a chip-select.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ad7476.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 1f736be09663..fc98aadc4077 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -33,6 +33,7 @@ struct ad7476_chip_info {
 	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
 	void (*conversion_pre_op)(struct ad7476_state *st);
+	void (*conversion_post_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
 };
@@ -64,6 +65,23 @@ static void ad7091_convst(struct ad7476_state *st)
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
+static void bd79105_convst_disable(struct ad7476_state *st)
+{
+	if (!st->convst_gpio)
+		return;
+
+	gpiod_set_value(st->convst_gpio, 0);
+}
+
+static void bd79105_convst_enable(struct ad7476_state *st)
+{
+	if (!st->convst_gpio)
+		return;
+
+	gpiod_set_value(st->convst_gpio, 1);
+	udelay(1); /* 10ns required for conversion */
+}
+
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf =3D p;
@@ -81,6 +99,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
 				    iio_get_time_ns(indio_dev));
 done:
+	if (st->chip_info->conversion_post_op)
+		st->chip_info->conversion_post_op(st);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
@@ -278,6 +298,20 @@ static const struct ad7476_chip_info ltc2314_14_chip_i=
nfo =3D {
 	.has_vref =3D true,
 };
=20
+static const struct ad7476_chip_info bd79105_chip_info =3D {
+	.convst_channel[0] =3D AD7091R_CONVST_CHAN(16),
+	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	/*
+	 * The BD79105 starts ADC data conversion when thw CONVSTART is set
+	 * HIGH. The CONVSTART must be kept HIGH until the data has been
+	 * read from the ADC.
+	 */
+	.conversion_pre_op =3D bd79105_convst_enable,
+	.conversion_post_op =3D bd79105_convst_disable,
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
 static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
@@ -347,7 +381,6 @@ static int ad7476_probe(struct spi_device *spi)
 	if (st->convst_gpio)
 		indio_dev->channels =3D st->chip_info->convst_channel;
 	/* Setup default message */
-
 	st->xfer.rx_buf =3D &st->data;
 	st->xfer.len =3D indio_dev->channels[0].scan_type.storagebits / 8;
=20
@@ -393,6 +426,7 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
 	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
 	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
+	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
--=20
2.50.1


--aUGwjoVvL5m2/5qa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/ooACgkQeFA3/03a
ocVmxwgAi9EzR99wm883Tq1QK/SBCpt39VZzzjvvQFRTrzIpZ1czCrWauWKW1b1k
y1OBL6091hmGV/eHc25E92Xqi7ApMZFUwCXNuHSD3DMgg10jB2Ii8zgUuEo50EY6
n+QHfvioxK6vgRz9XLC/71zobhw359iFtdW/7wmxNr8ftJsbP2wIiFoxOQQMqDUQ
NJgQBeExCaQsxoyUsnCCY7cU2g8ZJdb1em/roE6j3ohiB+l5tnSIAwPeglVd2/Md
LJ0SMFkCDsUKUeskXZr1XDq0DmmsYzQhDzY01KAdu1ITYxi/sfxqnY7IGyulmnvP
nKKg1zxqbBU+yU0jGGOljFA1q2RFOw==
=Iwtn
-----END PGP SIGNATURE-----

--aUGwjoVvL5m2/5qa--

