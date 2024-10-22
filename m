Return-Path: <linux-iio+bounces-10921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E99AA209
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD603282E3E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98019CCEC;
	Tue, 22 Oct 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqRCuCka"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3B146D78;
	Tue, 22 Oct 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599838; cv=none; b=mIpwe1NoK2irLFosRCgbFee7cGROK9YI+df4BBaLXSQYSOz+zux8XvDXgcvre7ZCzYVrtjoovnoQGnl/UYxWU+vDqm2DbxTyH8Mv982AKvOxPIzlR4LAZC5MsDII78Cn7xXNsMd6yYqS603dq61ac2qNC3G3PgQ8wquIBXoX1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599838; c=relaxed/simple;
	bh=kx+xixkswUYefS678/H3FGgzFSd3z2mEBBoPwJIYddw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXnSMWtLPyUWxkXddaAz8sj8mc3yHmYnCjX7Fvgw81uXQI9Hz//e899ASm9AVccF7q2kHSJWH3MQQMMEInOkTMt4WxadllpjX+NJVXpUgTvGEfjBLZnSgCy0Sh5ABGXfi2DPSKaSC55KSR3AHgAVzbeJgXZRzNthcIiLouK339k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqRCuCka; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso55030365e9.0;
        Tue, 22 Oct 2024 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729599835; x=1730204635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iSt8X6PT8WKwcLSfsOSIHXosovda2tlQR0zGu28f3qA=;
        b=HqRCuCkab9uchwZKsRPDRyxageVcBagexejRrM9MYKO8jalHv2vqHZuUqfbo+xdbwm
         905dLO446yv+QIWki5z+HG2+3gc/CUj64+4lOytlAEHL6vSoGTViAun8HMmOUyAD7NtV
         YH0heKiYH2U/0H/2tSQcgLPc2V7kt1A9afuqiy8p+v/XWQr8zamDCRidJTJLyvSsc+m3
         YFMZXDDFY28k/nwha+smUN2TkaDJhJoTh8SHfLgG4JWnC9QpkfOhnbTR/w8NcJ8Vsdrw
         y6nR0JP2kCR3OCWuf0r6K4rBz6A+JdRRD8Q1nkrDtaBgW5w3nHX0/9xOSkEFxvaCXH/p
         BJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729599835; x=1730204635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSt8X6PT8WKwcLSfsOSIHXosovda2tlQR0zGu28f3qA=;
        b=Mz3+iWVqA7sW6uHjzK0vlSJElu2oLRZVM/KMcaMp1Ib/WAoQAvUfNJQtUD+8mQe0q2
         lUu+mlxuRLO/J96nbUC2ICpDV6fJhoenqG8DXTLz9wXsqqfBAh0a+Wkbe8habcFMLFEu
         YIN/NfaXnauVBbvx5S+ym3XD0TF6aONfmJh3D8jf9SP2yjgchrbr5G4RLkPTgCzLP5OK
         FdIY9tIuBRgmHBEHm/wWDjqM7ojDxtmGtBYi/Ai90H2QRPGPchS8YP625bEVmaSAlIdt
         S8Xg0jvn2hz+4CXyYpDjFpA42kM0Twdo+w3w6xO/mZyg631406oHoSMEakFT9liGVlSi
         Y5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg2OAypyoBjxaAeg3H+UO0uoGB76ySTafH7lLR7jKSxZi0zsWSO1XGJSDk/cqTeE8kUbrYYevaVKZD@vger.kernel.org, AJvYcCXxuNC/7Xf7QNWEcYe0QdWGqU7MOHem5IDMQBaahykk0ddHww4kViVmtW7UNM2ZLs0ZWFErMWpoWfqulqxn@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXc1Q/20rc5GpzC1IjSOJ/9t902PthGPoosdXlXJXZoaZpRtN
	2WkfN90KlxhKpNCqQ/sFzFsq8r68z6/C9CFWuTtTqN0ZkJwhjfdx
X-Google-Smtp-Source: AGHT+IGZR7bPKrxhwz8VbI/Uqe7AGtqWvTlNMK6DuwZoQ3Y2ESXrbqFvN7Ggd3jvNYWRI7fPFq72zw==
X-Received: by 2002:a05:6000:b45:b0:37d:54d0:1f20 with SMTP id ffacd0b85a97d-37ea218b5ecmr9472482f8f.24.1729599834463;
        Tue, 22 Oct 2024 05:23:54 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm6521187f8f.91.2024.10.22.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:23:54 -0700 (PDT)
Message-ID: <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
	 <broonie@kernel.org>
Date: Tue, 22 Oct 2024 14:28:12 +0200
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add High Speed ad3552r platform driver.
>=20
> The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> through the current AXI backend, or similar alternative IIO backend.
>=20
> Compared to the existing driver (ad3552r.c), that is a simple SPI
> driver, this driver is coupled with a DAC IIO backend that finally
> controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> maximum transfer rate of 33MUPS using dma stream capabilities.
>=20
> All commands involving QSPI bus read/write are delegated to the backend
> through the provided APIs for bus read/write.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++
> =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 547
> +++++++++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/iio/dac/ad3552r-hs.h |=C2=A0 18 ++
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A05 files changed, 584 insertions(+)
>=20
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index fa091995d002..fc11698e88f2 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -6,6 +6,20 @@
> =C2=A0
> =C2=A0menu "Digital to analog converters"
> =C2=A0
> +config AD3552R_HS
> +	tristate "Analog Devices AD3552R DAC High Speed driver"
> +	select ADI_AXI_DAC
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD3552R
> +	=C2=A0 Digital to Analog Converter High Speed driver.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The driver requir=
es the assistance of an IP core to operate,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 since data is str=
eamed into target device via DMA, sent over a
> +	=C2=A0 QSPI + DDR (Double Data Rate) bus.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ad3552r-hs.
> +
> =C2=A0config AD3552R
> =C2=A0	tristate "Analog Devices AD3552R DAC driver"
> =C2=A0	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index c92de0366238..d92e08ca93ca 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,6 +4,7 @@
> =C2=A0#
> =C2=A0
> =C2=A0# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD3552R_HS) +=3D ad3552r-hs.o ad3552r-common.o
> =C2=A0obj-$(CONFIG_AD3552R) +=3D ad3552r.o ad3552r-common.o
> =C2=A0obj-$(CONFIG_AD5360) +=3D ad5360.o
> =C2=A0obj-$(CONFIG_AD5380) +=3D ad5380.o
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> new file mode 100644
> index 000000000000..27bdc35fdc29
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD3552R
> + * Digital to Analog converter driver, High Speed version
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/units.h>
> +
> +#include "ad3552r.h"
> +#include "ad3552r-hs.h"
> +
> +struct ad3552r_hs_state {
> +	const struct ad3552r_model_data *model_data;
> +	struct gpio_desc *reset_gpio;
> +	struct device *dev;
> +	struct iio_backend *back;
> +	bool single_channel;
> +	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
> +	struct ad3552r_hs_platform_data *data;
> +};
> +
> +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> +					u32 reg, u32 mask, u32 val,
> +					size_t xfer_size)
> +{
> +	u32 rval;
> +	int ret;
> +
> +	ret =3D st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> +	if (ret)
> +		return ret;
> +
> +	rval =3D (rval & ~mask) | val;
> +
> +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> +}
> +
> +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	int ch =3D chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		int sclk;
> +
> +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
> +		if (ret !=3D IIO_VAL_INT)
> +			return -EINVAL;
> +

I just saw you had some questions on v6 that everyone failed to see. See my
reply to David here:

https://lore.kernel.org/linux-iio/61cf3072af74a8b2951c948ddc2383ba1e55954d.=
camel@gmail.com/

It should be easy and it's something that makes sense (at least to me :))

> +		/*
> +		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> +		 * considered always on (considering buffering mode always).
> +		 */
> +		*val =3D DIV_ROUND_CLOSEST(sclk * 4 * 2,
> +					 chan->scan_type.realbits);
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D st->data->bus_reg_read(st->back,
> +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> +				val, 2);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->ch_data[ch].scale_int;
> +		*val2 =3D st->ch_data[ch].scale_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D st->ch_data[ch].offset_int;
> +		*val2 =3D st->ch_data[ch].offset_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			return st->data->bus_reg_write(st->back,
> +				=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH_DAC_16B(chan-
> >channel),
> +				=C2=A0=C2=A0=C2=A0 val, 2);
> +		}

Maybe we'll get the new stuff in time for this :)

...

> +
> +static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * Using inverted "active-high" logic here, since ad3552r classic-spi
> +	 * fdt node (and driver) is using the same logic.
> +	 */
> +

I don't understand this. This is a new device with a different compatible. =
Why
keeping the wrong logic? AFAICT, there's nothing in the bindings about the =
pin
polarity.

> +	st->reset_gpio =3D devm_gpiod_get_optional(st->dev,
> +						 "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +
> +	if (st->reset_gpio) {
> +		fsleep(10);
> +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> +	} else {
> +		ret =3D ad3552r_qspi_update_reg_bits(st,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +					AD3552R_MASK_SOFTWARE_RESET,
> +					AD3552R_MASK_SOFTWARE_RESET, 1);
> +		if (ret)
> +			return ret;
> +	}
> +	msleep(100);
> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
> +{
> +	int ret, val;
> +
> +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL1)
> +		return dev_err_probe(st->dev, -EIO,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> +
> +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL2)
> +		return dev_err_probe(st->dev, -EIO,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
> +					int ch, u16 gain, u16 offset)
> +{
> +	int ret;
> +
> +	ret =3D st->data->bus_reg_write(st->back,
> AD3552R_REG_ADDR_CH_OFFSET(ch),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, 1);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret, "Error writing
> register\n");
> +
> +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gain, 1);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret, "Error writing
> register\n");
> +
> +	return 0;

nit: Not a big fan of these logs on read/write registers functions... Also =
seems
that you're not being consistent (either you have them or not). FWIW, I wou=
ld
simplify and drop them. That would allow to do

return st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch), gain=
, 1);

> +}
> +
> +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> +{
> +	s16 goffs;
> +	u16 id;
> +	u16 gain =3D 0, offset =3D 0;
> +	u32 ch, val, range;
> +	int ret;
> +
> +	ret =3D ad3552r_hs_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_ddr_disable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad3552r_hs_scratch_pad_test(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	id =3D val;
> +
> +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	id |=3D val << 8;
> +	if (id !=3D st->model_data->chip_id)
> +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> 0x%x\n",
> +			 AD3552R_ID, id);
> +
> +	ret =3D st->data->bus_reg_write(st->back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D st->data->bus_reg_write(st->back,
> +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> +					=C2=A0=C2=A0 AD3552R_QUAD_SPI) |
> +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad3552r_get_ref_voltage(st->dev, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val =3D ret;
> +
> +	ret =3D ad3552r_qspi_update_reg_bits(st,
> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				val, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad3552r_get_drive_strength(st->dev, &val);
> +	if (!ret) {
> +		ret =3D ad3552r_qspi_update_reg_bits(st,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					val, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	device_for_each_child_node_scoped(st->dev, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(st->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "reg property missing\n");
> +
> +		ret =3D ad3552r_get_output_range(st->dev, st->model_data,
> child,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &range);
> +		if (!ret) {
> +			st->ch_data[ch].range =3D range;
> +
> +			ret =3D ad3552r_hs_set_output_range(st, ch, range);
> +			if (ret)
> +				return ret;
> +
> +		} else if (ret =3D=3D -ENOENT) {
> +			ret =3D ad3552r_get_custom_gain(st->dev, child,
> +						&st->ch_data[ch].p,
> +						&st->ch_data[ch].n,
> +						&st->ch_data[ch].rfb,
> +						&st-
> >ch_data[ch].gain_offset);
> +			if (ret)
> +				return ret;
> +
> +			gain =3D ad3552r_calc_custom_gain(st->ch_data[ch].p,
> +						st->ch_data[ch].n,
> +						st->ch_data[ch].gain_offset);
> +			offset =3D abs(goffs);
> +
> +			st->ch_data[ch].range_override =3D 1;
> +
> +			ret =3D ad3552r_hs_setup_custom_gain(st, ch, gain,
> +							=C2=A0=C2=A0 offset);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return ret;
> +		}

Just personal preference... I think this would be neater:
if (ret && ret !=3D ENOENT)
	return ret;
if (ret =3D=3D -ENOENT) {
	...
} else {
	...
}

Advantage is that it also handles errors first (which is the typical patter=
n)

> +
> +		ad3552r_calc_gain_and_offset(&st->ch_data[ch], st-
> >model_data);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops =3D=
 {
> +	.postenable =3D ad3552r_hs_buffer_postenable,
> +	.predisable =3D ad3552r_hs_buffer_predisable,
> +};
> +
> +#define AD3552R_CHANNEL(ch) { \
> +	.type =3D IIO_VOLTAGE, \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) | \
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET), \
> +	.output =3D 1, \
> +	.indexed =3D 1, \
> +	.channel =3D (ch), \
> +	.scan_index =3D (ch), \
> +	.scan_type =3D { \
> +		.sign =3D 'u', \
> +		.realbits =3D 16, \
> +		.storagebits =3D 16, \
> +		.endianness =3D IIO_BE, \
> +	} \
> +}
> +
> +static const struct iio_chan_spec ad3552r_hs_channels[] =3D {
> +	AD3552R_CHANNEL(0),
> +	AD3552R_CHANNEL(1),
> +};
> +
> +static const struct iio_info ad3552r_hs_info =3D {
> +	.read_raw =3D &ad3552r_hs_read_raw,
> +	.write_raw =3D &ad3552r_hs_write_raw,
> +};
> +
> +static int ad3552r_hs_probe(struct platform_device *pdev)
> +{
> +	struct ad3552r_hs_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->dev =3D &pdev->dev;
> +
> +	st->data =3D pdev->dev.platform_data;

dev_get_platdata()

- Nuno S=C3=A1



