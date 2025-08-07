Return-Path: <linux-iio+bounces-22393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70FB1D4EF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46B2F4E1287
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F0264F96;
	Thu,  7 Aug 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIuf9jGf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A0254876;
	Thu,  7 Aug 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559334; cv=none; b=mKkNvtBgI1ZX8jiUzn1H4SQ/a59eZEsXrG/8SNLCsYhOojwNubrzmUJXTHBGXg1g805/xe8XeKYI2/sgIfM4f4osaq2Bwd55qGM4zYkMBWCEMOQlIRVN8SxW3tGKU4/oI8FEpmVtPPMsIsOYm2on2GQnY/jcuTUzWwBNTU7JwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559334; c=relaxed/simple;
	bh=Siz48S+liI6W6M/aRzCxs+H3uw/5bMwmmqls1302Weg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beCzapR5+y7ZjgG7RmRqtrOcXnJgUtVd98tSJdKx9XnvqyTzJ6rdSpNu0rRLHyU4h+JPP1+rBRO2F7TKE+g+LmDpApe/pPjEYWfiboqtOeO0GlucA+IGtQi4RqCWj7lIKGwn/H/tyTehDRQX8o+wWy3MIK5ACwje5UQLL/FfGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIuf9jGf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-332590cc87fso6659381fa.3;
        Thu, 07 Aug 2025 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559330; x=1755164130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDecFcqmjWF2jDhd7cAyPmPfhLM6PzWjpX5jhJB/FOQ=;
        b=mIuf9jGf8ujolCR7aAXJCHzcTeeliZ5QW/RBfbz5TpaQWhQ7I6zr7eQkB9V7fRN14w
         Y6OmCvRIrj4VqmAfiLTcl6mY5n60nkIjxSWO3nb75YQqbXc+42WxnVAFJFZd8V22KWsK
         zwaPnrGnw2VbeZt6cvH2VC1Gn8PPBwWWCdeIlJ2LQ9w15D81PJrrQuFt7tRNkPF48Xfa
         bGUSl2dyQGC3+s6A8qmb+pTk7bI0ihh/nnbQ9dXJRvgvDBVjj0GyVhfDO7jLFz85N8Sh
         NzOgKTNJx86rocn8XUXOtCYtUFSuKhTpI2srllKzueDOep70drN9S6X4PG++tyr7BTnM
         9UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559330; x=1755164130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDecFcqmjWF2jDhd7cAyPmPfhLM6PzWjpX5jhJB/FOQ=;
        b=uBH3Cy2LdBx2vdcO0cGci0uvGvUMeGcJdO0ICGUefPgORsnnnKE2+/G4CPxaYI2tWA
         bMb/cTrqeiG7WlGajpbgkmZHsKdM0s9pJ9VAQOx41qvk71phbEWeO6zkk9wPEZELKeTy
         VgRDGagPUjutk+X8KmOvvoxfow8jMHhETbakKHS3nCQXed3lNKn0tCfQGJvi608NMHgk
         2xOWprYh5CepbuQEo05uXMD65X23Vll94KMvk/9IMMAId97vmceCAOOa9wqDVrWR8DlH
         1j2ipSfZQdHI3fxZ/pFPd2Krncv9hl+65LwCEW1xJyc54o2hw//CXVo5Y9gGIhsqSVpU
         DbOg==
X-Forwarded-Encrypted: i=1; AJvYcCV/S3tf5Td5XQqAODPZ0lBfixI7uvGFk7XzTJPFEqK/bFHuhLXBWFnOyDo05bi0r4ljLabXdp7PYpuJ@vger.kernel.org, AJvYcCV6iRCAcP8ImPVtDUfhjBTZwxvAKJ6jCNg4n697kiFnHF458CtEG0y+7WCEiLGCC0Gi5OmQCS3qZK0n@vger.kernel.org, AJvYcCVOJxfTPJD0MyBbamoJwZE/3ZP5uMZefVqPVv/PCQLBXOnjq0sci1WIfvsyIBeudMfyqE9aDF7hMLDkKLwt@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9fnlNF9aQc0Da5JPlcZ9C3W+4r/OjGEnUEUmz7Ge0Kxr5sz3
	n2GpIGPNEXSQWeGzJcOPlgAIgXQdQTc5Q5UUJCQeI5bF2Bbdyl+BKR+6
X-Gm-Gg: ASbGnctZk1lN4TT+XWUiIOgTg3UA7VKLTxe3gVueZ3Sc7FkSO28JmZQQKnQG3VR5txU
	6KHOovdFpNL8wto0IwRS1oy82TOOZ3xf8dZW2gy+ycQnBzslZR6CT4MRMZ8A24Zi3Gsl9Ti9Vsc
	4fPJ+rQ+fIenpo54rXF+ioubLzKKfJFlAYMvPwPUc2mm1+bGzwgB8PDcw88GxsUU6Fmq7GtV6Ia
	J2GMGGgIsK4aoIwn6Ziuz7qb3FdCBjnaIrnhOUXX4Mp1sl2OhVh1SAzYXbtR2Abe6Sdv7d1uEu8
	w48nbJFJTb9RxuRyDjNeoAKtXGKhR1yQPfPW8iHbOtbboxkb+9zxvB8YmjBKPObctrlxx7ak0dx
	UtdUNQKMlUlBPCA3jTfRfAl6Izain
X-Google-Smtp-Source: AGHT+IFA5bhiuAB1VJf9qdAQJ8NLlGe3pEmYc9PAupbjTt3MpiUIH0SBoyHUBrE3C8gn9dkvRyZhuQ==
X-Received: by 2002:a05:651c:20d0:b0:332:3794:aa2f with SMTP id 38308e7fff4ca-33381290cc3mr6598701fa.14.1754559330201;
        Thu, 07 Aug 2025 02:35:30 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3326cdb7481sm13100031fa.75.2025.08.07.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:35:29 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:35:25 +0300
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
Subject: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8etcVA/yzcjN15sC"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--8etcVA/yzcjN15sC
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
daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
'data-ready' -IRQ. These modes aren't supported by this driver.

Support reading ADC scale and data from the BD79105 using SPI, when DIN
is used as a chip-select.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v1 =3D> v2:
 - Fix the conversion delay for the BD79105
 - Drop unnecessary GPIO check from the convstart disable
 - Drop unintended whitespace change
 - Fix spelling
---
 drivers/iio/adc/ad7476.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 8914861802be..aa8a522633eb 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -31,6 +31,7 @@ struct ad7476_chip_info {
 	struct iio_chan_spec		channel[2];
 	void (*reset)(struct ad7476_state *);
 	void (*conversion_pre_op)(struct ad7476_state *st);
+	void (*conversion_post_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
 };
@@ -39,6 +40,7 @@ struct ad7476_state {
 	struct spi_device		*spi;
 	struct gpio_desc		*convst_gpio;
 	void (*conversion_pre_op)(struct ad7476_state *st);
+	void (*conversion_post_op)(struct ad7476_state *st);
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	struct iio_chan_spec		channel[2];
@@ -63,6 +65,21 @@ static void ad7091_convst(struct ad7476_state *st)
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
+static void bd79105_convst_disable(struct ad7476_state *st)
+{
+	gpiod_set_value(st->convst_gpio, 0);
+}
+
+static void bd79105_convst_enable(struct ad7476_state *st)
+{
+	if (!st->convst_gpio)
+		return;
+
+	gpiod_set_value(st->convst_gpio, 1);
+	/* Worst case, 2790 nS required for conversion */
+	ndelay(2790);
+}
+
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf =3D p;
@@ -80,6 +97,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
 				    iio_get_time_ns(indio_dev));
 done:
+	if (st->conversion_post_op)
+		st->conversion_post_op(st);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
@@ -271,6 +290,20 @@ static const struct ad7476_chip_info ltc2314_14_chip_i=
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
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
 static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
@@ -325,6 +358,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	st->conversion_pre_op =3D chip_info->conversion_pre_op;
+	st->conversion_post_op =3D chip_info->conversion_post_op;
 	st->convst_gpio =3D devm_gpiod_get_optional(&spi->dev,
 						  "adi,conversion-start",
 						  GPIOD_OUT_LOW);
@@ -400,6 +434,7 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
 	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
 	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
+	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
--=20
2.50.1


--8etcVA/yzcjN15sC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUc10ACgkQeFA3/03a
ocXIYQf8CpftaiR0rZJNDqS0b6RjPMR1TrceGpkv1ps4436Mcwuwb5rBCol+fwkS
ui2ao0zOF8OMipI5AgRT7oNYfcKEG6yIT486K89XGesC9sp+5454tVeeFYYAvb5g
IclKYi+bAMA4Nl99x2C/7ZPfomlCFDVNUXowNZ4YHMbXuEx8fyDiP5NgWf1DzVoP
crJuXosGfXIp22B1t6xkq/x8rafvd8gbP0fA82LVO+VpPfgXY4egleeWfVbkjULX
kcqDSiGpvYLCVUVhMXrLRt8g9XTtJlaGQWwZCKZ6TdOi1TEB4Ztmg2QCOq6s66+y
EscTBwhDi7fOxvMH3VTeWl3iU939Hg==
=uiYC
-----END PGP SIGNATURE-----

--8etcVA/yzcjN15sC--

