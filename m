Return-Path: <linux-iio+bounces-17900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F33A83B55
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011CB3A3D20
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7B1D90AD;
	Thu, 10 Apr 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnYPjaCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591541D61BB;
	Thu, 10 Apr 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270305; cv=none; b=ExcR1QfcSGFL0/sWuGL5QtuJsnfRb1WT77RRJfoFneUuQNKJfLWKES7tFz7GuMp+brc1hsD4Rf3WTY7BxCEyYjgaPlE/pf0dKqte9JCvklvPVLo3UZUTcacGcCvKmmVcCjApZyp55Vnjd9XpeAx6EkdbazrnaqO3jssYGYsxh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270305; c=relaxed/simple;
	bh=x3CrBGxwvw24DkP4YIzmlpFaOvqBoXiN6BuA45vfztQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IENMSmRFYPMoCSSIqTWF8qCMMAbCcWSZJ86aP7KiqRTNWX6oc3GNGTPQ1lnNxzgw1QuZImqIICAZ0RiqUiA65xxBVS/afQypQLFmAnB8sZj0kGaYgrkojEofZgwGNss8WlFvalMRS+8mIEmli0DEd7bM4xUknMTHxq6NiCZRJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnYPjaCI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf848528aso3764345e9.2;
        Thu, 10 Apr 2025 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744270302; x=1744875102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J0XXK2XRI5t+UpVn0uQ99Ecvx1YK+boTgIFSUaat814=;
        b=TnYPjaCI5icVj7YPc/ApSUGoXGp3sXuEjVdUxeHUF3FVUO/ADhkdz3sT3UvqZbSQG7
         oA+FQiZsHxNTSV1hkCqzRPw7siFdzE7QCPag8l0IknjoKlkIaDZSfnQam/4DuLg7fCAV
         kHgMkCpU1pUA9XrvwR5G2uOW/dpaqJ9bVR7JkRLHsfo6WOS9xpgO9o76Me/OmNu+IEY8
         RzV3il7OcRz8MvaVIfrfjenv9xQFhRNDIFnMyEof32EMXnrjvBjAxx5HfUCk9eoERagi
         djLS2m543nEFaJf2yE+9gagYUChOW2SIza9r6nYCz5shkdrISLlhwx3dphUbAHF9/bEv
         RF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744270302; x=1744875102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0XXK2XRI5t+UpVn0uQ99Ecvx1YK+boTgIFSUaat814=;
        b=VtilMO7V947Aey3/qKsPuJDebugLaMECH59qxfqYZ4fJi/UFAOAS011xkg3VFAwY7i
         jWwfMJDkZdY/iiJ0Eyn7GYggeqhZr3vv/g7/HUnhqqq1ZocPWgpADUfXvHPrL9bWrcxE
         0FqfC4EmAIe7gkQqJHlRb1iS1PTPAHRlqJ99FrugSAPIeQL8ttEbhA6a/2cTYJPCeFox
         nwCzUcW9Y6Bfo+HhXKnP1VhygeoHjMcF5Ud1g3MwfFnqeB1cUpWavrcUPYpnxt5HyO5N
         V9GnMX9ZNkK2VLnffObZyMlNcWqhRwOoZOr2S6/6O4i8TEsStQUqTE0WIFsAm2ac3yb9
         JJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUYfNFEXDz07Cho5qsqchc8m4OtJFXGMvizryxwCBSphqFXuT2RMcD0jooyXDH9dsOfZvjLGMnogvyb@vger.kernel.org, AJvYcCUuyCeWLCaW5YgMdjfu1vLFxLopNuZ/nY8V1E9k2VfL2gdBcL7gKQZyLfJh+pn8GqEdNB+zkH/f86PJ@vger.kernel.org, AJvYcCVGjQ9E6x3v1xw4oLgA56e/jtU6Fe3xvyJSGm0iQ2pvv5nvMT3Ng0oxQypfVX28TIFz1Xv23K8KgfxOJen6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1cDXHpoDl1VvS+eOapw57rTLpUso6c2j53D7hdaE+tBcMZSXs
	f49uP335D7QuEfITNwDPzJluHrVMXbNmPFKHtLOHXvzWekO0TCbm
X-Gm-Gg: ASbGncundXi9zubZtkv+gNIXUDnuTTQ3C+SLTLLi8XtKG3pVJ12ittomDJE2VuyNid/
	UJVCdogr9g0zny+ODwUwmhLZeTme73DESF9CTuXEAWLkJ4pGHawE3jRyitPTvALgnKx2vcR9ax3
	yZoMu7nM77aszOkx3txxpfHMfCDKZFIWnGSQbGvOKcWTDSe0PfflMsMLvFozM79X63yMxyWhCSy
	p/9RQZfHZPMwMny/0YGKabmewKpZh29dxkGnpCl7nA9fGA6p5WorYqP9InSDXgVu3UGKxLvHGes
	1/t8jF3MfF1pwv1IVLMA+qV/cr4Qk6XNCDnSJYd9QSpQ/A47zZRhegWNtapOiYyiGsvc9MI7iPC
	sNSA06UoG6xjlPr0=
X-Google-Smtp-Source: AGHT+IEtZRBxgmlgPhwHUGlooSJYY+pqiYnO6gJJowPn6VrK0lqpKBYku3zEh0fEBORqS1qy68UmQQ==
X-Received: by 2002:a05:600c:2904:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-43f2f6d0079mr10195745e9.15.1744270301321;
        Thu, 10 Apr 2025 00:31:41 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572c43sm42609365e9.25.2025.04.10.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:31:40 -0700 (PDT)
Message-ID: <9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 07:31:59 +0100
In-Reply-To: <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marecelo,

First, superficial look...

On Wed, 2025-04-09 at 09:24 -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> Add support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Digital filter and sampling frequency configuration.
> - Calibration gain and offset configuration.
> - Differential and pseudo-differential input configuration.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 16 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4170.c | 1950 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 1968 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4170.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 991b6e2e373a..56cd87028dfd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1343,6 +1343,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> +F:	drivers/iio/adc/ad4170.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD4695 DRIVER
> =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 636469392945..de7139fc2a1f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -70,6 +70,22 @@ config AD4130
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will be
> =C2=A0	=C2=A0 called ad4130.
> =C2=A0
> +
> +config AD4170
> +	tristate "Analog Device AD4170 ADC Driver"
> +	depends on SPI
> +	depends on GPIOLIB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP_SPI
> +	depends on COMMON_CLK
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4170 SPI anal=
og
> +	=C2=A0 to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll be
> +	=C2=A0 called ad4170.
> +
> =C2=A0config AD4695
> =C2=A0	tristate "Analog Device AD4695 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..d3a1376d1f96 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> +obj-$(CONFIG_AD4170) +=3D ad4170.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..0d24286ac2ab
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c
> @@ -0,0 +1,1950 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Analog Devices, Inc.
> + * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +

...

> +
> +static int ad4170_read_sample(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int =
*val)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int settling_time_ms, ret;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * The ADC sequences through all enabled channels. That can lead to
> +	 * incorrect channel being sampled if a previous read would have left a
> +	 * different channel enabled. Thus, always enable and disable the
> +	 * channel on single-shot read.
> +	 */
> +	ret =3D ad4170_set_channel_enable(st, chan->address, true);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);

I would do the above right before wait_for_completion_timeout()...

> +
> +	ret =3D ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_SINGLE);
> +	if (ret)
> +		goto err_disable;
>=20

...

> +
> +static int ad4170_set_pga(struct ad4170_state *st,
> +			=C2=A0 struct iio_chan_spec const *chan, int val, int val2)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	unsigned int old_pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe)=
;
> +	unsigned int pga;
> +	int ret =3D 0;
> +
> +	for (pga =3D 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> +		if (val =3D=3D chan_info->scale_tbl[pga][0] &&
> +		=C2=A0=C2=A0=C2=A0 val2 =3D=3D chan_info->scale_tbl[pga][1])
> +			break;
> +	}
> +
> +	if (pga =3D=3D AD4170_NUM_PGA_OPTIONS)
> +		return -EINVAL;
> +
> +	if (pga =3D=3D old_pga)
> +		return 0;
> +
> +	setup->afe &=3D ~AD4170_AFE_PGA_GAIN_MSK;
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
>=20

ditto...

> +
> +	guard(mutex)(&st->lock);
> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret) {
> +		setup->afe &=3D ~AD4170_AFE_PGA_GAIN_MSK;
> +		setup->afe |=3D FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, old_pga);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad4170_set_channel_freq(struct ad4170_state *st,
> +				=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +				=C2=A0=C2=A0 int val2)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	enum ad4170_filter_type f_type =3D __ad4170_get_filter_type(setup->filt=
er);
> +	int filt_fs_tbl_size, i, ret =3D 0;
> +	unsigned int old_filter_fs;
> +
> +	switch (f_type) {
> +	case AD4170_SINC5_AVG:
> +		fallthrough;
> +	case AD4170_SINC3:
> +		filt_fs_tbl_size =3D ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl);
> +		break;
> +	case AD4170_SINC5:
> +		filt_fs_tbl_size =3D ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl);
> +		break;
> +	}
> +
> +	for (i =3D 0; i < filt_fs_tbl_size; i++) {
> +		if (st->sps_tbl[f_type][i][0] =3D=3D val &&
> +		=C2=A0=C2=A0=C2=A0 st->sps_tbl[f_type][i][1] =3D=3D val2)
> +			break;
> +	}
> +	if (i >=3D filt_fs_tbl_size)
> +		return -EINVAL;
> +
> +	old_filter_fs =3D setup->filter_fs;
> +	if (f_type =3D=3D AD4170_SINC5)
> +		setup->filter_fs =3D ad4170_sinc5_filt_fs_tbl[i];
> +	else
> +		setup->filter_fs =3D ad4170_sinc3_filt_fs_tbl[i];
> +
> +	guard(mutex)(&st->lock);

Shouldn't the lock also protect the 'setup' struct?

> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret)
> +		setup->filter_fs =3D old_filter_fs;
> +
> +	return ret;
> +}
> +
> +static int ad4170_set_calib_offset(struct ad4170_state *st,
> +				=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	u32 old_offset;
> +	int ret;
> +
> +	old_offset =3D setup->offset;
> +	setup->offset =3D val;
> +
> +	guard(mutex)(&st->lock);
> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret)
> +		setup->offset =3D old_offset;
> +
> +	return ret;
> +}
> +
> +static int ad4170_set_calib_gain(struct ad4170_state *st,
> +				 struct iio_chan_spec const *chan, int val)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	u32 old_gain;
> +	int ret;
> +
> +	old_gain =3D setup->gain;
> +	setup->gain =3D val;
> +
> +	guard(mutex)(&st->lock);
> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret)
> +		setup->gain =3D old_gain;
> +
> +	return ret;
> +}
> +
> +static int __ad4170_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int =
val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val2, long info)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4170_set_pga(st, chan, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4170_set_channel_freq(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4170_set_calib_offset(st, chan, val);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4170_set_calib_gain(st, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4170_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +			=C2=A0=C2=A0=C2=A0 int val2, long info)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D __ad4170_write_raw(indio_dev, chan, val, val2, info);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +				=C2=A0=C2=A0=C2=A0 long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad4170_info =3D {
> +	.read_raw =3D ad4170_read_raw,
> +	.read_avail =3D ad4170_read_avail,
> +	.write_raw =3D ad4170_write_raw,
> +	.write_raw_get_fmt =3D ad4170_write_raw_get_fmt,
> +	.debugfs_reg_access =3D ad4170_debugfs_reg_access,
> +};
> +
> +static int ad4170_soft_reset(struct ad4170_state *st)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap8, AD4170_CONFIG_A_REG,
> +			=C2=A0=C2=A0 AD4170_SW_RESET_MSK);
> +	if (ret)
> +		return ret;
> +
> +	/* AD4170-4 requires 1 ms between reset and any register access. */
> +	fsleep(MILLI);
> +
> +	return 0;
> +}
> +
> +static int ad4170_parse_reference(struct ad4170_state *st,
> +				=C2=A0 struct fwnode_handle *child,
> +				=C2=A0 struct ad4170_setup *setup)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	u8 aux;
> +
> +	/* Positive reference buffer setup */
> +	aux =3D AD4170_REF_BUF_PRE; /* Default to have precharge buffer enabled=
. */
> +	ret =3D fwnode_property_read_u8(child, "adi,buffered-positive", &aux);
> +	if (ret) {

Shouldn't this be if (!ret)?

> +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,buffered-positive:
> %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 aux);
> +	}
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
> +
> +	/* Negative reference buffer setup */
> +	aux =3D AD4170_REF_BUF_PRE; /* Default to have precharge buffer enabled=
. */
> +	ret =3D fwnode_property_read_u8(child, "adi,buffered-negative", &aux);
> +	if (ret) {

ditto

> +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,buffered-negative:
> %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 aux);
> +	}
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
> +
> +	/* Voltage reference selection */
> +	aux =3D AD4170_REF_REFOUT; /* Default reference selection. */
> +	fwnode_property_read_u8(child, "adi,reference-select", &aux);
> +	if (aux > AD4170_REF_AVDD)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid reference selected %u\n", aux);
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_SELECT_MSK, aux);
> +
> +	return 0;
> +}
> +
> +static int ad4170_parse_adc_channel_type(struct device *dev,
> +					 struct fwnode_handle *child,
> +					 struct iio_chan_spec *chan)
> +{
> +	u32 pins[2];
> +	int ret;
> +
> +	ret =3D fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(pins));
> +	if (!ret) {
> +		chan->differential =3D true;
> +		chan->channel =3D pins[0];
> +		chan->channel2 =3D pins[1];
> +		return 0;
> +	}
> +	ret =3D fwnode_property_read_u32(child, "single-channel", &pins[0]);
> +	if (!ret) {
> +		chan->differential =3D false;
> +		chan->channel =3D pins[0];
> +
> +		ret =3D fwnode_property_read_u32(child, "common-mode-channel",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &pins[1]);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"single-ended channels must define common-mode-
> channel\n");
> +
> +		chan->channel2 =3D pins[1];
> +		return 0;
> +	}

Kind of a nitpick but for the above I would flip the logic. First check for=
 errors in
the single-channel case and then you can have one less of level of indentat=
ion...

> +	return dev_err_probe(dev, ret,
> +		"Channel must define one of diff-channels or single-channel.\n");
> +}
> +
> +static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *child,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan_num)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +	struct ad4170_chan_info *chan_info;
> +	struct ad4170_setup *setup;
> +	struct iio_chan_spec *chan;
> +	unsigned int ch_reg;
> +	u8 ref_select;
> +	bool bipolar;
> +	int ret;
> +
> +	ret =3D fwnode_property_read_u32(child, "reg", &ch_reg);
> +	if (ret)
> +		return ret;
> +

Could also deserve a log message?

> +	if (ch_reg >=3D AD4170_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Channel idx greater than no of channels\n"=
);
>=20

...

>=20
> +
> +static int ad4170_trigger_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	st->trig =3D devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-trig%d",
> +					=C2=A0 indio_dev->name,
> +					=C2=A0 iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops =3D &ad4170_trigger_ops;
> +	st->trig->dev.parent =3D indio_dev->dev.parent;
> +
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret =3D devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig =3D iio_trigger_get(st->trig);
> +
> +	return request_irq(st->spi->irq, &ad4170_irq_handler, IRQF_ONESHOT,
> +			=C2=A0=C2=A0 indio_dev->name, indio_dev);

devm_request_irq()...

> +}
> +
> +static int ad4170_regulator_setup(struct ad4170_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +
> +	/* Required regulators */
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "avdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
> +
> +	st->vrefs_uv[AD4170_AVDD_SUP] =3D ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "iovdd");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
> +
> +	st->vrefs_uv[AD4170_IOVDD_SUP] =3D ret;
> +
> +	/* Optional regulators */
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "avss");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
> +
> +	/* Assume AVSS at GND (0V) if not provided */
> +	st->vrefs_uv[AD4170_AVSS_SUP] =3D ret =3D=3D -ENODEV ? 0 : -ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refin1p");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN+ voltage.\n");
> +
> +	st->vrefs_uv[AD4170_REFIN1P_SUP] =3D ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refin1n");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
> +
> +	/* Negative supplies are assumed to provide negative voltage */
> +	st->vrefs_uv[AD4170_REFIN1N_SUP] =3D ret =3D=3D -ENODEV ? -ENODEV : -re=
t;

Maybe to early for me but the comment does not make it clear to me why the =
negation?
Won't the regulator return a negative voltage?

> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refin2p");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN2+
> voltage.\n");
> +
> +	st->vrefs_uv[AD4170_REFIN2P_SUP] =3D ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refin2n");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get REFIN2-
> voltage.\n");
> +
> +	/* Negative supplies are assumed to provide negative voltage */
> +	st->vrefs_uv[AD4170_REFIN2N_SUP] =3D ret =3D=3D -ENODEV ? -ENODEV : -re=
t;
> +
> +	return 0;
> +}
> +
> +static int ad4170_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4170_state *st;
> +	const char *dev_name;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	devm_mutex_init(dev, &st->lock);

check for errors...

> +
> +	dev_name =3D spi_get_device_match_data(spi);
> +	if (!dev_name)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D dev_name;
> +	indio_dev->info =3D &ad4170_info;
> +
> +	st->spi =3D spi;
> +	st->regmap8 =3D devm_regmap_init_spi(spi, &ad4170_regmap8_config);
> +	if (IS_ERR(st->regmap8))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap8),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap8\n");
> +
> +	st->regmap16 =3D devm_regmap_init_spi(spi, &ad4170_regmap16_config);
> +	if (IS_ERR(st->regmap16))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap16),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap16\n");
> +
> +	st->regmap24 =3D devm_regmap_init_spi(spi, &ad4170_regmap24_config);
> +	if (IS_ERR(st->regmap24))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap24),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap24\n");
> +

Hmm, interesting idea... but I would expect an explanation on why can't we =
have bulk
reads for the 16 and 24 bit cases? Without it, I have to ask why not?
=20
> +	ret =3D ad4170_regulator_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4170_soft_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4170_parse_firmware(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to parse firmware\n");
> +
> +	ret =3D ad4170_initial_config(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup device\n");
> +
> +	init_completion(&st->completion);
> +
> +	if (spi->irq) {
> +		ret =3D ad4170_trigger_setup(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to setup
> trigger\n");

Typically it's better to log the errors inside ad4170_trigger_setup() unles=
s you use
it outside probe.

- Nuno S=C3=A1
>=20
> +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4170 SPI driver");
> +MODULE_LICENSE("GPL");


