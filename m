Return-Path: <linux-iio+bounces-6251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5929079A8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA191F24443
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5562F149E06;
	Thu, 13 Jun 2024 17:20:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74D14A4DC;
	Thu, 13 Jun 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299229; cv=none; b=ZtwvfB/ZV7ejL0IeHHt+wXLN6SpcEedzqQXNkST5nvY6Qf/l5fH8CYNH4j+8j6h+qDxL1qYnT5T+jKeZXOIsNTDWgfZkKmEMPhxrR1y8LB51FuL2dhdSyYaIodRHoINWGZYNSEXfF1id1UuF0Jr4J8B/rTW2n9fBzuwOFBCTafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299229; c=relaxed/simple;
	bh=bcTlQCZmkD/Xi9pbAhyUanFMXK8HrG7tkMYcoDGGb+g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzpKMs75IVbWW7zhNibdHWrpI5+pD2F8huCnmktjEZagOgifZuqetAZ5hwtZrgUeqW/2KeGaGWqce0BWDux3C9iRJHQxmdU4JYOPKWOESIj+t/xEwSK38yalBRi6WUx4u+vdmhQLrYACAcjSChgyd+KOWJ5+Yk8xPlxCZkAWWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0TfD3Fs8z6K91P;
	Fri, 14 Jun 2024 01:19:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8267F1400CB;
	Fri, 14 Jun 2024 01:20:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 18:20:22 +0100
Date: Thu, 13 Jun 2024 18:20:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
CC: Lucas Stankus <lucas.p.stankus@gmail.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, Hans de
 Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>, "Broadcom internal kernel review list"
	<bcm-kernel-feedback-list@broadcom.com>, "Shawn Guo" <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, "Kevin Hilman" <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, "Martin Blumenstingl"
	<martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste
 Maneyrol <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [RESEND][PATCH] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
Message-ID: <20240613182021.00005072@Huawei.com>
In-Reply-To: <20240611165214.4091591-1-tgamblin@baylibre.com>
References: <20240611165214.4091591-1-tgamblin@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 11 Jun 2024 12:52:06 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Simplify the way regmap is accessed in iio drivers.
>=20
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>=20
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Looks like a good change in general. However...

The problem with a change like this is it results in
non trivial backporting if we need to due to a fix in related
code.

As such, whilst it will obviously generate a lot of patches, I'd
like this split up into a series so each patch touches only one driver.
Fine to keep a single patch for the multiple module for a single
device cases though.

Also some very long lines that need the line breaks put back.

Jonathan


> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index b8ddbfd98f11..40e605c57adb 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -1034,10 +1034,8 @@ static int msa311_chip_init(struct msa311_priv *ms=
a311)
>  				     "failed to unmap map0/map1 interrupts\n");
> =20
>  	/* Disable all axes by default */
> -	err =3D regmap_update_bits(msa311->regs, MSA311_ODR_REG,
> -				 MSA311_GENMASK(F_X_AXIS_DIS) |
> -				 MSA311_GENMASK(F_Y_AXIS_DIS) |
> -				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> +	err =3D regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
> +				MSA311_GENMASK(F_X_AXIS_DIS) | MSA311_GENMASK(F_Y_AXIS_DIS) | MSA311=
_GENMASK(F_Z_AXIS_DIS));
Too long

> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index b6c4ef70484e..8fabf748c36b 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -385,9 +385,8 @@ static irqreturn_t cpcap_adc_irq_thread(int irq, void=
 *data)
> @@ -424,23 +423,17 @@ static void cpcap_adc_setup_calibrate(struct cpcap_=
adc *ddata,
>  	if (error)
>  		return;
> =20
> -	error =3D regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> -				   CPCAP_BIT_ATOX_PS_FACTOR |
> -				   CPCAP_BIT_ADC_PS_FACTOR1 |
> -				   CPCAP_BIT_ADC_PS_FACTOR0,
> -				   0);
> +	error =3D regmap_clear_bits(ddata->reg, CPCAP_REG_ADCC2,
> +				  CPCAP_BIT_ATOX_PS_FACTOR | CPCAP_BIT_ADC_PS_FACTOR1 | CPCAP_BIT_AD=
C_PS_FACTOR0);
That one is over 100! =20
>  	if (error)

> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-c=
ore.c
> index a791ba3a693a..ff1c81553045 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c

> =20
> @@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, =
void *p)
>  				 "FIFO overflow! Emptying and resetting FIFO\n");
>  			fifo_overflow =3D true;
>  			/* Reset and enable the FIFO */
> -			ret =3D regmap_update_bits(mpu3050->map,
> -						 MPU3050_USR_CTRL,
> -						 MPU3050_USR_CTRL_FIFO_EN |
> -						 MPU3050_USR_CTRL_FIFO_RST,
> -						 MPU3050_USR_CTRL_FIFO_EN |
> -						 MPU3050_USR_CTRL_FIFO_RST);
> +			ret =3D regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);

Keep the line break to stay under 80 chars.

> @@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio=
_trigger *trig,
>  			return ret;
> =20
>  		/* Reset and enable the FIFO */
> -		ret =3D regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
> -					 MPU3050_USR_CTRL_FIFO_EN |
> -					 MPU3050_USR_CTRL_FIFO_RST,
> -					 MPU3050_USR_CTRL_FIFO_EN |
> -					 MPU3050_USR_CTRL_FIFO_RST);
> +		ret =3D regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);

For IIO stuff try and stay under 80 chars unless there is a strong
readability argument for going longer.  Here there isn't one.

>  		if (ret)
>  			return ret;
> =20

