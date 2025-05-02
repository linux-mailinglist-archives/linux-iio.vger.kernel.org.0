Return-Path: <linux-iio+bounces-19004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67426AA762E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2527AD82C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83534257AF8;
	Fri,  2 May 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3hHiaVM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3A25484E;
	Fri,  2 May 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200223; cv=none; b=miMf1avyeLS6bBR2I5yLReklJJJxfFNy5BfkQKMZsrGOMBGXDRzuIlItIBNPaaSBhqeKL7ARcmlYcU80ESV63+rNJdkAUtvh0Qh/XAt9DluKILD9K7Yj6zyd32TIbwBkN3anX0Ex79uActUMgzQQimXkB4dFADmSA1JEAHm14dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200223; c=relaxed/simple;
	bh=vnwMkzoo6DOXOwrt31Dhlv9ptQvXIXE2ib0b/flVyQU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJycaSpBYRhHEW6V351sppiVJfOUJLeWEdojRypsqZpttt7F2UFLbT8jGdts3UwGCbw2r4tHxywSbXBvzdbdxlm2DgUpLDqDuqs3qd3v41UAJEM2evlZwuMbgZKwkXMfNVYthcRkifDhR/LLrYNn0rdC9jvSiTNOExYa6MU6XuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3hHiaVM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so2202454f8f.0;
        Fri, 02 May 2025 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746200219; x=1746805019; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiTyOzKFWy15gHUpgXpQHy0xaZeqv7kpNCCAtuNwpDM=;
        b=c3hHiaVM/V1jYYfvkbNRauoPsnBULxHwxuN/dXMl7W+g1hTNJwzcg8jKjeuDMx+6lL
         VchCfB5jAiOhwNefKM/j0R9UesNTMGoIrNeqEZpTLSWOn8r+I/EOSuRp2eL7Q+n2Yfzo
         xIsYk83wX2QJHSLgxWT+00whLFVS4ARGtF8sNwixUPTH3EJgua8DBmldXaZ0d2H/dsd7
         d6N7vLFO+7bElmy3q4iy3nHJ5QNKWa1N6fGp4DxVFV2fJAO6ZJCkE6R+lHZMXXpqxhK1
         k/J+Hkrkak0hSOYvCZxnLxjk3MqMqjzR8X8oxbekRueEdJB39KMDm6M+N//xWwVPWTr/
         ZYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746200219; x=1746805019;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiTyOzKFWy15gHUpgXpQHy0xaZeqv7kpNCCAtuNwpDM=;
        b=duBOA5axjQNUNr976j8tcICI+eD+C3YQlhxqYCwE7gEFYT8oayjCMHfdiT+F2qCZ+u
         pUtJxaspdhNuxQ9/0s2x1LbCxi31d28UpgEOrJKiRh9Ajjkq9HCHCdfLlXNkNH2oRosJ
         f9VMJqbZGoaRnjq68tq/mjgrRfxHM/s4VTkMRTPzFm9VsVcXhpUzRDmcrT19WSP3z0FV
         khPVjUFd7Im0t1hC4xR8vw8Yq+Rhfxtz2BIwB8CdtOBc6+Z3nIZ/fEORtgQkNWHfUylQ
         8yaSJhVdBrFQwlI+Je/F7QwBXZWBTUGxjZmn/QMxrWYqOID4rmZJJSP5CB1LcclYtaGE
         DiAg==
X-Forwarded-Encrypted: i=1; AJvYcCUXDcf+132Ulm8KkLq2IEnCKZG1xPCJTSGFzOhPl+5TozSSiOAr6LY3A6ZMrcl6LJsyiDKqNhFc/Zcg@vger.kernel.org, AJvYcCUmr5sz39E8Hs6iRudJnrTN08slYxQkm5XsyuUO6RxISs2iKHSbsWSBGI9z3j8/SF82uYKhHUeOjr55ARc7@vger.kernel.org, AJvYcCWrN1bWHMPrZu1trIv1seNU7QbV/M9stSEu/RDVye2LSF4QoPGcPbEFBWtnMIaUeF3wuFHwJI1nV9k6@vger.kernel.org
X-Gm-Message-State: AOJu0YxBonFY6WHOp+dvjkfVI+LMKx8moeKfC5GFZSzjcKuHRhmYOGey
	Xmpzd/XJNpcNpqFUdwfmpX2aHt3QoBgk+g0wODN2k8OEw7mFzky62tKLKr8W
X-Gm-Gg: ASbGncuMoLFDBDFFu3AiE417pHUqc/w+0JJ96pS1l8Hhbusc17/3l3zWnU8wLXUAbyU
	uQvCfccmTNt28kYOiHdzH318TIBwyWJkFXFZVDDwDW39gigrSaGAVf/As0y6D9IYiK5d2eo7gUe
	g/pa0nhjxL8yTJ6FzZG2dMG3h2rsN9C4+1Rg5wJlN+gIbIwENP3rtjncUW88ySg19c8S0Wweaj5
	Uh3qX7QhVfNLf1D54abyoLzCW7RnmXa4VEc8RC88vGARd31ziRoWPxRraKC2TYz1A4FDNWNdTHA
	PmZpptAl1sw8RgwbYPMvg54YgeMDeU7V0iQbFVx9808qdaOCB7AUvVTC3tc1bjBNNF4KPXWlZDX
	uAaByt9ZC+ahv
X-Google-Smtp-Source: AGHT+IFx+B5/jAku86DC+shPHkrtgXBuoomLwEwmQETjZLEA90xpdMOY7j9NTmJuA/hzIFzNWC5UtQ==
X-Received: by 2002:a05:6000:1acc:b0:39c:1257:cc26 with SMTP id ffacd0b85a97d-3a099af1b8dmr2947971f8f.57.1746200219320;
        Fri, 02 May 2025 08:36:59 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae353esm2484781f8f.31.2025.05.02.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:36:58 -0700 (PDT)
Message-ID: <48ce035746cae8eab049ff178b6de194ead56960.camel@gmail.com>
Subject: Re: [PATCH v4 09/10] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 May 2025 16:37:02 +0100
In-Reply-To: <20250502085905.24926-10-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
	 <20250502085905.24926-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 11:59 +0300, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
> =C2=A0- drop _MSK postfix for bit definitions
> =C2=A0- add space before }
> =C2=A0- drop writing reserved bit.
> =C2=A0- use regmap_set_bits/regmap_clear_bits instead of regmap_write
> =C2=A0- use dev_dbg() where applies
> =C2=A0- use dev_err() where applies
> =C2=A0- use FIELD_PREP when _MSK defines are implied.
> =C2=A0- drop explicit statement `.shift =3D 0`
> =C2=A0- get clk_rate during probe.
> =C2=A0- handle IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_SAMP_FREQ in default=
.
> =C2=A0- use the new iio_backend_interface_data_align function
> =C2=A0- drop redundant else.
> =C2=A0- drop redundat mutex guards.
> =C2=A0- rearrange includes.
> =C2=A0- rename sinc5+pf1
> =C2=A0- use regmap_get_device
> =C2=A0- drop outermost ()
> =C2=A0- check mode for < 2
> =C2=A0- drop st->dec_rate and use functions inline.
> =C2=A0- drop ad4080_channels[] and use ad4080_channel instead
> =C2=A0- drop redundat if statement for num_lanes.
> =C2=A0- use - instead of _ for device properties.
> =C2=A0- drop reduandant assignement
> =C2=A0- drop indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0- rename filter_disabled to filter_none.
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 14 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4080.c | 570 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 593 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4080.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd04375ab4a2..0038f7a078ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1317,6 +1317,14 @@
> F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> =C2=A0F:	Documentation/iio/ad4030.rst
> =C2=A0F:	drivers/iio/adc/ad4030.c
> =C2=A0
> +ANALOG DEVICES INC AD4080 DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +F:	drivers/iio/adc/ad4080.c
> +
> =C2=A0ANALOG DEVICES INC AD4130 DRIVER
> =C2=A0M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> =C2=A0L:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..17df328f5322 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,20 @@ config AD4030
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad4030.
> =C2=A0
> +config AD4080
> +	tristate "Analog Devices AD4080 high speed ADC"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4080
> +	=C2=A0 high speed, low noise, low distortion, 20-bit, Easy Drive,
> +	=C2=A0 successive approximation register (SAR) analog-to-digital
> +	=C2=A0 converter (ADC). Supports iio_backended devices for AD4080.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4080.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..e6efed5b4e7a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> +obj-$(CONFIG_AD4080) +=3D ad4080.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..9168dee9323e
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4080 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
>=20

...

> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK=
_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_interface_data_align(st->back, 100);
> +	if (ret =3D=3D -ETIMEDOUT)
> +		dev_err(dev, "LVDS Sync Timeout.\n");
> +	if (ret)
> +		return ret;

Hmm I don't think the above two if() to be that helpful... Also,
ad4080_lvds_sync_write() seems to be only called from probe, so dev_err_pro=
be()?

> +
> +	dev_dbg(dev, "Success: Pattern correct and Locked!\n");
> +	return regmap_clear_bits(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
> +}
> +
> +static ssize_t ad4080_get_filter_type(struct iio_dev *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
> +	if (ret)
> +		return ret;
> +
> +	return FIELD_GET(AD4080_FILTER_CONFIG_FILTER_SEL_MSK, data);
> +}
> +
> +static int ad4080_set_filter_type(struct iio_dev *dev,
> +				=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0 unsigned int mode)
> +{
> +	struct ad4080_state *st =3D iio_priv(dev);
> +	unsigned int dec_rate;
> +	int ret;
> +
> +	dec_rate =3D ad4080_get_dec_rate(dev, chan);
> +
> +	if (mode >=3D SINC_5 && dec_rate >=3D 512)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	ret =3D iio_backend_filter_type_set(st->back, mode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +			=09
> FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +					=C2=A0=C2=A0=C2=A0 mode));
> +	if (ret)
> +		return ret;
> +
> +	st->filter_type =3D mode;
> +

The above is not properly synchronized with ad4080_set_dec_rate().
ad4080_set_dec_rate() also needs to be protected by the same lock otherwise
dec_rate can be change under our feet when changing the filter. The same is=
 true
for when updating the dec_rate.

I think that for ad4080_set_gec_rate() we do not really need to lock (i.e,
regmap should be fine)

> +	return 0;
> +}
> +
> +static int ad4080_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D ad4080_dec_rate_iio_enum;
> +		*length =3D ARRAY_SIZE(ad4080_dec_rate_iio_enum);
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad4080_iio_info =3D {
> +	.debugfs_reg_access =3D ad4080_reg_access,
> +	.read_raw =3D ad4080_read_raw,
> +	.write_raw =3D ad4080_write_raw,
> +	.read_avail =3D ad4080_read_avail,
> +};
> +
> +static const struct iio_enum ad4080_filter_type_enum =3D {
> +	.items =3D ad4080_filter_type_iio_enum,
> +	.num_items =3D ARRAY_SIZE(ad4080_filter_type_iio_enum),
> +	.set =3D ad4080_set_filter_type,
> +	.get =3D ad4080_get_filter_type,
> +};
> +
> +static struct iio_chan_spec_ext_info ad4080_ext_info[] =3D {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad4080_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			=C2=A0=C2=A0 &ad4080_filter_type_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec ad4080_channel =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.indexed =3D 1,
> +	.channel =3D 0,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.info_mask_shared_by_all_available =3D
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	.ext_info =3D ad4080_ext_info,
> +	.scan_index =3D 0,
> +	.scan_type =3D {
> +		.sign =3D 's',
> +		.realbits =3D 20,
> +		.storagebits =3D 32,
> +	},
> +};
> +
> +static const struct ad4080_chip_info ad4080_chip_info =3D {
> +	.name =3D "AD4080",
> +	.product_id =3D AD4080_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4080_channel,
> +};
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	unsigned int id;
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id !=3D AD4080_CHIP_ID)
> +		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPIO_CONFIG_A_GPO_1_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			=C2=A0=C2=A0 FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK,
> 3));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->lvds_cnv_en)
> +		return 0;
> +
> +	ret =3D regmap_update_bits(st->regmap,
> +				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			=09
> AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> +			=09
> FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	if (st->num_lanes !=3D 1) {

I think st->num_lanes > 1 would make the intent more explicit...

> +		ret =3D regmap_set_bits(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_set_bits(st->regmap,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV=
_EN);
> +	if (ret)
> +		return ret;
> +
> +	return ad4080_lvds_sync_write(st);
> +}
> +
> +static void ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +
> +	st->lvds_cnv_en =3D device_property_read_bool(dev, "adi,lvds-cnv-
> enable");
> +
> +	st->num_lanes =3D 1;
> +	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);

we should validate the value given by DT...

- Nuno S=C3=A1

