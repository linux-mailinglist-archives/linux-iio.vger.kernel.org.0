Return-Path: <linux-iio+bounces-6948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27591800B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AB11C23AF4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F51802C2;
	Wed, 26 Jun 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRM1WiYA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEB2AF1A;
	Wed, 26 Jun 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402216; cv=none; b=uNrXiEwQOcs78VE/i5v3+ogrxE0t+qwBnGxqKDN4hgRE9qwBiPlytfCwrY6jOYA8BEd7/EFDztzBAQxAtFyUPmrYaSCsuQG/zEFBoaZ2zmeBWdHPqxY2eapqfO1vdwIpLvCPZNVkLCIok2bvb64SObTdPuZ9U4c/b6Nd7fGAqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402216; c=relaxed/simple;
	bh=yccMOcIumFv6hYOj/hT74yJ2hOUlygZ/x8AbfqKRh/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9GfjgsVUhpXi2w8C9bdQkD/KyzrBirKL5OGgDKvuvU9r+IHqHJfxsdZypd7X0MMVgn3TRJi3g5l3R05Ymw8UI+OJHengsmKWs3cm0+46Jl5QPknJgXnIO+djgRyoIs2oF8NP7RLe68S8huVdo5CycWxnEwL43aTGAsZu4WJQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRM1WiYA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72477a60fbso450971566b.2;
        Wed, 26 Jun 2024 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719402213; x=1720007013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLEMTaZ9A3wb9xEpkeFlzON7wFJIqapk3Om4jOPBT4Q=;
        b=PRM1WiYA8GUOI7jGsggk1BEuwdVb9KOsQpDCRgpkppKwwUMpa8++sVBv9BnykUQ1RC
         93L4SNzBxA8bm0IAH9HkdaSM3JKWrwh8hUeIsPHRolibu18IM+QOZgpJUHMVMXW+49n1
         c3ZST1lecF22MMp7PeTucQe/k+Douotax7TPv9vKomM/kX2u1bS+UIHY5UzSanKFQxlZ
         f0VZZ4PTzelsrSxRdQG9asAF4oMY9qjKFWIWrt9LSSM1cMNm8FBsm938I1m6e2iqKA+q
         zhrxZgGYIVH/JYaz79GvUZumM3/kiQYTS75Jgc+0yX9f5zI2R96o4qsYT9C9Mh3t9R80
         n1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402213; x=1720007013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLEMTaZ9A3wb9xEpkeFlzON7wFJIqapk3Om4jOPBT4Q=;
        b=KGwKHLt3bzkijGIR4UIwM5YU5yZrf7Od5K7Kz4eR3IRXhr5k9sSL97roCN271lt53R
         twze07Na9uaySDifgWLGgxjCeKap5KhO0lZJStTYqyYv15FFgHEz4IqUqX0udNErWEw8
         X0LO9w7oHuG6RYWHpsttmNMoM96/aYhqTrt4PegE3otcEzi0jwfcQmNv7cjxT7M6mTST
         UH5ckO56maW+Ba5jV/nSkb2xu78uOvY4pjV9UYylruvo5zDjPEmrvbnK2VRFm65QbgL0
         eGVX2j72QuaVB+USY4HnSDJ2AdnUAniWMBdG7HTcDMhBRYpG4I5mrGSd+5kj+1DkjNaD
         4Biw==
X-Forwarded-Encrypted: i=1; AJvYcCXwIbe1esWNCwdsl0o6DsdF2uNtTOlYcn9cv+FkgzIl3VYk75KZKR5WkT84YORLYqxXfQH1kti50EuDjbTff8Q4LMxLFc1U29m6vFIiapBV8AqhadMwZ0ntLWMbQj9VbOdweGjJgHLb5wMPhrYEpbWAZXGDlH6KX12fC7+zSXypqwc8DCFjEQWAJ8IhUp/TXYfn5qXXHO0d+q/w+p+PAA==
X-Gm-Message-State: AOJu0YxJbe58ustqCcyt/U2nUtnuF/U4jEI1JrpYvZ9Z1+ibx5KWYroD
	uohCG7+nq1nzAHtQQ1lkIt532DmL00/7/6iqDOPXS96LtVBSfhpoOWc2dMwp97p9Cg==
X-Google-Smtp-Source: AGHT+IHMGzXFsW5QxvXXbHGwYfKJNd9td15CLv5747+YTMqfokRMuWKfMafLi0qDxWtvGEuk08jhKw==
X-Received: by 2002:a17:907:a684:b0:a72:7e1e:6301 with SMTP id a640c23a62f3a-a727f820170mr265977466b.61.1719402212783;
        Wed, 26 Jun 2024 04:43:32 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a728d993fcdsm42056566b.28.2024.06.26.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:43:32 -0700 (PDT)
Message-ID: <f02cac02f9404bf6dcc5a8274b51d836960871ee.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ramona Gradinariu
	 <ramona.gradinariu@analog.com>
Date: Wed, 26 Jun 2024 13:47:23 +0200
In-Reply-To: <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
	 <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

minor stuff from me..

On Mon, 2024-06-24 at 17:01 -0500, David Lechner wrote:
> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
>=20
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v3 changes:
> * always include all channels, not just ones customized in DT
> * rework channel fwnode parsing for DT changes
>=20
> v2 changes:
> * rework register definition macros
> * remove code structure comments at top level
> * remove simple wrapper functions around regmap functions
> * rework channel fwnode parsing for DT changes
> * fix missing return value check
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4695.c | 730
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 743 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 025ee138a713..c52c4b0e69a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1216,6 +1216,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> +F:	drivers/iio/adc/ad4695.c
> =C2=A0F:	include/dt-bindings/iio/adi,ad4695.h
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b8184706c7d1..eed5547a5078 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -36,6 +36,17 @@ config AD4130
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad4130.
> =C2=A0
> +config AD4695
> +	tristate "Analog Device AD4695 ADC Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4695 and simi=
lar
> +	=C2=A0 analog to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4695.
> +
> =C2=A0config AD7091R
> =C2=A0	tristate
> =C2=A0
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 51298c52b223..c180c85b6327 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -7,6 +7,7 @@
> =C2=A0obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> +obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> =C2=A0obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> =C2=A0obj-$(CONFIG_AD7091R8) +=3D ad7091r8.o
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> new file mode 100644
> index 000000000000..72ab5b997f6e
> --- /dev/null
> +++ b/drivers/iio/adc/ad4695.c
> @@ -0,0 +1,730 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI ADC driver for Analog Devices Inc. AD4695 and similar chips
> + *
> + * https://www.analog.com/en/products/ad4695.html
> + * https://www.analog.com/en/products/ad4696.html
> + * https://www.analog.com/en/products/ad4697.html
> + * https://www.analog.com/en/products/ad4698.html
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 BayLibre, SAS
> + */
> +
> +#include <dt-bindings/iio/adi,ad4695.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
>=20

...

> +
> +static int ad4695_write_chn_cfg(struct ad4695_state *st,
> +				struct ad4695_channel_config *cfg)
> +{
> +	u32 mask =3D 0, val =3D 0;
> +
> +	mask |=3D AD4695_REG_CONFIG_IN_MODE;
> +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_MODE, cfg->bipolar ? 1 : 0);
> +

nit: don't need to OR the first assignments and so initializing the variabl=
es.

> +	mask |=3D AD4695_REG_CONFIG_IN_PAIR;
> +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_PAIR, cfg->pin_pairing);
> +
> +	mask |=3D AD4695_REG_CONFIG_IN_AINHIGHZ_EN;
> +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_AINHIGHZ_EN, cfg->highz_en ? 1
> : 0);
> +
> +	return regmap_update_bits(st->regmap, AD4695_REG_CONFIG_IN(cfg-
> >channel),
> +				=C2=A0 mask, val);
> +}
> +
> +/**
> + * ad4695_read_one_sample - Read a single sample using single-cycle mode
> + * @st: The AD4695 state
> + * @address: The address of the channel to read
> + *
> + * Upon return, the sample will be stored in the raw_data field of @st.
> + *
> + * Context: can sleep, must be called with iio_device_claim_direct held
> + * Return: 0 on success, a negative error code on failure
> + */
> +static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int
> address)
> +{
> +	struct spi_transfer xfer[2] =3D { };
> +	int ret;
> +
> +	ret =3D ad4695_set_single_cycle_mode(st, address);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Setting the first channel to the temperature channel isn't
> supported
> +	 * in single-cycle mode, so we have to do an extra xfer to read the
> +	 * temperature.
> +	 */
> +	if (address =3D=3D AD4695_CMD_TEMP_CHAN) {
> +		/* We aren't reading, so we can make this a short xfer. */
> +		st->cnv_cmd2 =3D AD4695_CMD_TEMP_CHAN << 3;
> +		xfer[0].bits_per_word =3D 8;

nit: isn't this the default?

> +		xfer[0].tx_buf =3D &st->cnv_cmd2;
> +		xfer[0].len =3D 1;
> +		xfer[0].cs_change =3D 1;
> +		xfer[0].cs_change_delay.value =3D AD4695_T_CONVERT_NS;
> +		xfer[0].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +		/* Then read the result and exit conversion mode. */
> +		st->cnv_cmd =3D AD4695_CMD_EXIT_CNV_MODE << 11;
> +		xfer[1].bits_per_word =3D 16;
> +		xfer[1].tx_buf =3D &st->cnv_cmd;
> +		xfer[1].rx_buf =3D &st->raw_data;
> +		xfer[1].len =3D 2;
> +
> +		return spi_sync_transfer(st->spi, xfer, 2);
> +	}
> +
> +	/*
> +	 * The conversion has already been done and we just have to read the
> +	 * result and exit conversion mode.
> +	 */
> +	st->cnv_cmd =3D AD4695_CMD_EXIT_CNV_MODE << 11;
> +	xfer[0].bits_per_word =3D 16;
> +	xfer[0].tx_buf =3D &st->cnv_cmd;
> +	xfer[0].rx_buf =3D &st->raw_data;
> +	xfer[0].len =3D 2;
> +
> +	return spi_sync_transfer(st->spi, xfer, 1);
> +}
> +
> +static int ad4695_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> +	struct ad4695_channel_config *cfg =3D &st->channels_cfg[chan-
> >scan_index];
> +	u8 realbits =3D chan->scan_type.realbits;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret =3D ad4695_read_one_sample(st, chan->address);
> +			if (ret)
> +				return ret;
> +
> +			if (chan->scan_type.sign =3D=3D 's')
> +				*val =3D sign_extend32(st->raw_data, realbits -
> 1);
> +			else
> +				*val =3D st->raw_data;
> +
> +			return IIO_VAL_INT;
> +		}
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val =3D st->vref_mv;
> +			*val2 =3D chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_TEMP:
> +			/* T_scale (=C2=B0C) =3D raw * V_REF (mV) / (-1.8 mV/=C2=B0C *
> 2^16) */
> +			*val =3D st->vref_mv * -556;
> +			*val2 =3D 16;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (cfg->pin_pairing =3D=3D AD4695_IN_PAIR_COM)
> +				*val =3D st->com_mv * (1 << realbits) / st-
> >vref_mv;
> +			else if (cfg->pin_pairing =3D=3D AD4695_IN_PAIR_EVEN_ODD)
> +				*val =3D cfg->common_mode_mv * (1 << realbits)
> / st->vref_mv;
> +			else
> +				*val =3D 0;
> +
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			/* T_offset (=C2=B0C) =3D -725 mV / (-1.8 mV/=C2=B0C) */
> +			/* T_offset (raw) =3D T_offset (=C2=B0C) * (-1.8 mV/=C2=B0C) *
> 2^16 / V_REF (mV) */
> +			*val =3D -47513600;
> +			*val2 =3D st->vref_mv;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev, unsigned=
 int
> reg,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int
> *readval)
> +{
> +	struct ad4695_state *st =3D iio_priv(indio_dev);
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		if (readval)
> +			return regmap_read(st->regmap, reg, readval);
> +
> +		return regmap_write(st->regmap, reg, writeval);
> +	}
> +
> +	unreachable();
> +}
> +
> +static const struct iio_info ad4695_info =3D {
> +	.read_raw =3D &ad4695_read_raw,
> +	.debugfs_reg_access =3D &ad4695_debugfs_reg_access,
> +};
> +
> +static int ad4695_parse_channel_cfg(struct iio_dev *indio_dev)
> +{
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct ad4695_state *st =3D iio_priv(indio_dev);

Why not passing in struct ad4695_state directly?

...

>=20
> +
> +	/* Needed for debugfs since it only access registers 1 byte at a
> time. */
> +	ret =3D regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_C,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4695_REG_SPI_CONFIG_C_MB_STRICT);
> +	if (ret)
> +		return ret;
> +

Question... do we gain something but not doing the above? Because debugfs i=
s
optional and always doing it even when it's not present looks unnecessary.=
=20

- Nuno S=C3=A1


