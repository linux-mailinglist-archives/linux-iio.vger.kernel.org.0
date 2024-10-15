Return-Path: <linux-iio+bounces-10599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0D99DF29
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E0B216CF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CDB17C225;
	Tue, 15 Oct 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeE+eD0e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728A9474;
	Tue, 15 Oct 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976553; cv=none; b=EYVYRUp5l2jYotcd5Du9+m0WUL6nBcWLZqhYGOXiba6fr80de+Ldx+TT3ROdqma4j+C4nW//uGUJdAQeh9EpLRUsLBj1MiSIXYWAFOdTBXQPt7L0LAKJoPFcrhBM71FDfKVVov8kCvtFPlRR/8EGX4vcUvDvD+YDOhxpbjhyews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976553; c=relaxed/simple;
	bh=sFZIR6lXrq3kssGqpRo0h0joTq5lDXNQsh84+tz3x1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gjlwy2l8eAtIZpts5aUNuEUxFP71Ckz0NfHBm2IwWa2v94ZlF1EV930GB7IgcztCB5NoaH/EkiXOorJFuRCYg6wxKm2yWxVfaPJ0z1YP0QxYloLvV7uFFa4g+ZIRchlcopUghzIoNMsNCLoriglrojs1wJ4fvXTnN5bYTOH3ZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeE+eD0e; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3594544f8f.0;
        Tue, 15 Oct 2024 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728976549; x=1729581349; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GR1eIIESPy1qfPzRC/ZwSKq5cDfeE2SYUoGepcS/MeM=;
        b=OeE+eD0eAtHaaRIobNwG1BaTMroPDW8Yqsi4W0aPqmi6AhsxBeKdfoygd4o9hCcioL
         qBRRM9ahHJ4NBqdsHQ1qAc88j+K+5g8OkDqBoSG2vIZq7n/HDzQcuTWLe6BCsfsSYnRi
         NRQIXNjGHzJZJa0Ur6m+NWkIFdu+e/a8t40wCUE27Pv4A0LSs8bOcbSQOyUlxIRnnCkI
         M/kalllszYnfwPNg1kO5VsAkYsa+MFbYwH34uyv4brxs7AT3lj4hSQtoKDO7eM37b8lt
         RLxtsVYSH63msfVfoGsmjysjBp9GFqD325BnvLGHQfqu4FnH6txsLoTqh8/AfynV68FQ
         0nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976549; x=1729581349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR1eIIESPy1qfPzRC/ZwSKq5cDfeE2SYUoGepcS/MeM=;
        b=ibZ2O3Q4BmT8dkj8fE6aSigRiBcFhoMgmu6Mr+MdFAs62f+sfdyZVWBJtrbxWGqbiQ
         QPttccTNX4ZU4lol1XGikaDcPk02GN9yB+x052ewSSwHKwDKr00+rJIKdAnbHZ06fS+L
         dLzwnqZtS90eMZmwDnnGuT2eOWNu59X47QsBZ3mtzH/sP61F72IPhkZiiwBFsV6QkUEI
         q74jjqolrqjemnOt96AHJPFK2Wx9g6xHj2n5phl2GRn5KfrQtELyk+kHeM143RWSdG94
         YZfjlHE/EKAg5FlcdaEGeIaqSujTG8IB/hwnxGoVkVoaivkM3fB7GnTyiMFHC8mtIVLu
         6+fA==
X-Forwarded-Encrypted: i=1; AJvYcCVfe/uOso9brCrbKm738jAG3cQ7OdM+B70yUSP9Go7gNn5USccQaR+m8ZRj9YHvuVis/k97+NlA4pXPq+JU@vger.kernel.org, AJvYcCVno3WDVhQ255qmhcYQCPwJK+6lEFNhbaf9/Ef6DmVHctQdNz/vVPF7voiwRP7MjOdZoodfk0ptH+XV@vger.kernel.org
X-Gm-Message-State: AOJu0YwlT3xm4vB6Mm9gnKBG0wgWu/t/5B2PB1DMZ9XCtxdFBAE5Zamz
	rBtAiiDNVyP/XuV+YhNgWzqp94oy96n6DjgdS7nsv3ZBit4Mvlch
X-Google-Smtp-Source: AGHT+IEzS6sRJEmMlBA5GgbedVtHx2n5gKeXdYCMLWHSWNJ4wiLxm2khsMyM3c4eydiyK/BJtnm1Vg==
X-Received: by 2002:a5d:5108:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37d552d4a14mr10718212f8f.29.1728976548857;
        Tue, 15 Oct 2024 00:15:48 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa882acsm800365f8f.38.2024.10.15.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 00:15:48 -0700 (PDT)
Message-ID: <549566b00524c0230a6a970b74a38dbe58e2589d.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
	 <broonie@kernel.org>
Date: Tue, 15 Oct 2024 09:15:47 +0200
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 12:08 +0200, Angelo Dureghello wrote:
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

Hi Angelo,

Some more questions from me on top of David's review...

> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++
> =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 526 ++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0drivers/iio/dac/ad3552r-hs.h |=C2=A0 18 ++
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A05 files changed, 566 insertions(+)
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
> index 000000000000..cb29a600e141
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -0,0 +1,526 @@
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
> +	struct ad3552r_hs_platform_data *data;
> +	bool ddr_mode;
> +};
> +
> +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> +					u32 reg, u32 mask, u32 val,
> +					size_t xfer_size)
> +{
> +	u32 rval;
> +	int err;

Be consistent. You have a mixture of err and ret. Personally, slight prefer=
ence for
'ret'.

> +
> +	err =3D st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> +	if (err)
> +		return err;
> +
> +	rval &=3D ~mask;
> +	rval |=3D val;
> +

nit: can be done in one liner...

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
> +		/* Using 4 lanes (QSPI) */
> +		*val =3D DIV_ROUND_CLOSEST(sclk * 4 * (1 + st->ddr_mode),
> +					 chan->scan_type.storagebits);

If we assume ddr always on, don't forget to put that in a comment. In fact,=
 please
say that the sampling frequency is only about stream mode (buffering) on.

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

Hmm, I think there's an important question here. How useful it is to have "=
just" raw
writes? I don't think there's anything preventing us from supporting SCALE =
and OFFSET
as the SPI driver? Those are important pieces for useland to be able to com=
pute the
peak voltage level, right? Or am I missing something?

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
> +				=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> +				=C2=A0=C2=A0=C2=A0 val, 2);
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +	struct iio_backend_data_fmt fmt =3D {
> +		.type =3D IIO_BACKEND_DATA_UNSIGNED
> +	};
> +	int loop_len, val, err;
> +
> +	/* Inform DAC chip to switch into DDR mode */
> +	err =3D ad3552r_qspi_update_reg_bits(st,
> +					=C2=A0=C2=A0 AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR,
> +					=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR, 1);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC IP to go for DDR mode from now on */
> +	err =3D iio_backend_ddr_enable(st->back);
> +	if (err) {
> +		dev_warn(st->dev, "could not set DDR mode, not streaming");

To me, this is an error so I would treat it as such. dev_err()

> +		goto exit_err;
> +	}
> +
> +	st->ddr_mode =3D true;
> +
> +	switch (*indio_dev->active_scan_mask) {
> +	case AD3552R_CH0_ACTIVE:
> +		st->single_channel =3D true;
> +		loop_len =3D 2;
> +		val =3D AD3552R_REG_ADDR_CH_DAC_16B(0);
> +		break;
> +	case AD3552R_CH1_ACTIVE:
> +		st->single_channel =3D true;
> +		loop_len =3D 2;
> +		val =3D AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	case AD3552R_CH0_CH1_ACTIVE:
> +		st->single_channel =3D false;
> +		loop_len =3D 4;
> +		val =3D AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +		goto exit_err_ddr;
> +	}
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loop_len, 1);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	err =3D iio_backend_data_transfer_addr(st->back, val);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	err =3D iio_backend_data_format_set(st->back, 0, &fmt);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	err =3D iio_backend_data_stream_enable(st->back);
> +	if (err)
> +		goto exit_err_ddr;
> +
> +	return 0;
> +
> +exit_err_ddr:
> +	iio_backend_ddr_disable(st->back);
> +
> +exit_err:
> +	ad3552r_qspi_update_reg_bits(st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 0, 1);
> +
> +	iio_backend_ddr_disable(st->back);
> +
> +	st->ddr_mode =3D false;

'ddr_mode' is pretty much used for the sampling freq, right? If we go the w=
ay of just
reporting the buffering sampling freq, I guess you can drop this variable.

> +
> +	return err;
> +}
> +
> +static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> +	int err;
> +
> +	err =3D iio_backend_data_stream_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	/* Inform DAC to set in SDR mode */
> +	err =3D ad3552r_qspi_update_reg_bits(st,
> +					=C2=A0=C2=A0 AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					=C2=A0=C2=A0 AD3552R_MASK_SPI_CONFIG_DDR,
> +					=C2=A0=C2=A0 0, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_ddr_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	st->ddr_mode =3D false;
> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_set_output_range(struct ad3552r_hs_state *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mode)
> +{
> +	return ad3552r_qspi_update_reg_bits(st,
> +				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> +				AD3552R_MASK_CH_OUTPUT_RANGE,
> +				FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode) |
> +				FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode),
> +				1);

I think you only call this function once, right? I would do this inline FWI=
W...

> +}
> +
> +static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> +{
> +	int err;
> +
> +	st->reset_gpio =3D devm_gpiod_get_optional(st->dev,
> +						 "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +

I suspect you actually want GPIOD_OUT_HIGH? Assuming the reset is active lo=
w, you
need to properly set it as such in DT. Then gpiolib will take care of thing=
s for you.
Note that, GPIOD_OUT_HIGH means "give me the pin in the asserted state". So=
 if it's
active low, then it will be effectively be low.

> +	if (st->reset_gpio) {
> +		fsleep(10);
> +		gpiod_set_value_cansleep(st->reset_gpio, 1);

Here you want to bring it out of reset and so de-assert the pin:

gpiod_set_value_cansleep(st->reset_gpio, 0);

Again, as long as you set the pin as active low in DT, gpiolib will negate =
the value
for you internally.

> +	} else {
> +		err =3D ad3552r_qspi_update_reg_bits(st,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +					AD3552R_MASK_SOFTWARE_RESET,
> +					AD3552R_MASK_SOFTWARE_RESET, 1);
> +		if (err)
> +			return err;
> +	}
> +	msleep(100);

nit: fsleep()

> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
> +{
> +	int err, val;
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL1) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> +		return -EIO;

This is in probing right? dev_err_probe()

> +	}
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL2) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> +		return -EIO;

ditto

> +	}
> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
> +					u16 gain, u16 offset)
> +{
> +	int err;
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(0)=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err, "Error writing register\n");
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_OFFSET(1)=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err, "Error writing register\n");
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(0),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gain, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err, "Error writing register\n");
> +
> +	err =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(1),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gain, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err, "Error writing register\n");
> +
> +	return 0;
> +}
> +
> +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> +{
> +	u8 gs_p, gs_n;
> +	s16 goffs;
> +	u16 id, rfb;
> +	u16 gain =3D 0, offset =3D 0;
> +	u32 val, range;
> +	int err;
> +
> +	err =3D ad3552r_hs_reset(st);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_ddr_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	err =3D ad3552r_hs_scratch_pad_test(st);
> +	if (err)
> +		return err;
> +
> +	err =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (err)
> +		return err;
> +
> +	id =3D val;
> +
> +	err =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> +	if (err)
> +		return err;
> +
> +	id |=3D val << 8;
> +	if (id !=3D st->model_data->chip_id)
> +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> +			 AD3552R_ID, id);
> +
> +	err =3D st->data->bus_reg_write(st->back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D st->data->bus_reg_write(st->back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_QUAD_SPI |
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE=
, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err =3D ad3552r_get_ref_voltage(st->dev);
> +	if (err < 0)
> +		return err;
> +
> +	val =3D err;

Then, 'err' is not an error. I don't really like of mixing return values (e=
rrors)
with values. Please pass the value as a pointer argument to the function.

> +
> +	err =3D ad3552r_qspi_update_reg_bits(st,
> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				val, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D ad3552r_get_drive_strength(st->dev, &val);
> +	if (!err) {
> +		err =3D ad3552r_qspi_update_reg_bits(st,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					val, 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	struct fwnode_handle *child __free(fwnode_handle) =3D
> +				device_get_named_child_node(st->dev, "channel");
> +	if (!child)
> +		return -EINVAL;
> +
> +	/*
> +	 * One of "adi,output-range-microvolt" or "custom-output-range-config"
> +	 * must be available in fdt.
> +	 */
> +	err =3D ad3552r_get_output_range(st->dev, st->model_data, child, &range=
);
> +	if (!err)
> +		return ad3552r_hs_set_output_range(st, range);
> +	if (err !=3D -ENOENT)
> +		return err;

It seems to me you're already getting the span values so it should be possi=
ble to
export them via sysfs as the spi driver, right?

> +
> +	err =3D ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &goffs);
> +	if (err)
> +		return err;
> +
> +	gain =3D ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
> +	offset =3D abs(goffs);
> +
> +	return ad3552r_hs_setup_custom_gain(st, gain, offset);
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
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
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
> +	if (!st->data)
> +		dev_err_probe(st->dev, -ENODEV, "No platform data !");

return dev_err_probe()

> +
> +	st->back =3D devm_iio_backend_get(&pdev->dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret =3D devm_iio_backend_enable(&pdev->dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	st->model_data =3D device_get_match_data(&pdev->dev);

error handling...

if (!st->model_data)
	return -ENODEV; (or -EINVAL) - it seems there's no consensus in what to
return here.

- Nuno S=C3=A1


