Return-Path: <linux-iio+bounces-11464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A769B31C7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC772843F3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7681DC04B;
	Mon, 28 Oct 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBh6oG9b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585912AE8C;
	Mon, 28 Oct 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122471; cv=none; b=UjEAdLNNS1mNkA51P3v/gVdp6VQkGMWqVIYgbu9HE9U37nLIOj4zkHii3O28Bikk1lMVN4CroRRNsDOqOaI4EgUCd9fO0Gefa0ftLiFWc9suSzphBSR8fZCY4Kumsis9l7AxPaekibCcW3x6ggh2VoGPvw+lAiKZWKQL+xz/Iho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122471; c=relaxed/simple;
	bh=SQUx1LeKDPykg8EL85hzJPhMTJVRpNKGMLyS0BF+KFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFTHz3HqnSmkNAN/sioNBu6k6M0FkpYaLb8vvsPlTnwRkai4mqyoUaMaXIRPNPedBwnOF33V44+o9/kAHe+6LPIry7uJl4pXaILdLHg64+dBQrLBp4JEgF+jiWP0mk5ZYLf41QG+IsXcnI7pd15ARXjRgSQpFC/HXcTvaWngYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBh6oG9b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5aedd177so2918006f8f.1;
        Mon, 28 Oct 2024 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730122467; x=1730727267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68PJDSg07f0bxch+VUEO+1oDGL4AKHJjPCCWr8YxKSY=;
        b=UBh6oG9b22AKMS72yuzwn9evF4A+atIqZCkysiBcoxtgKgUw+OuUU/G2id/psNpaLM
         sJn49hMj6RR6QWc+uI3m6eqlyYOWTtfGY/hgHOvf+Xftz/mDB3gf/A9/dsrod6W8Q/mO
         XX9PaowSsR0bLCPW1hw2vPiiRy9L9WQTICgGDqV8Z2ICNdnmgQMJKI9rXqCwmPp3RdjI
         ODmzUjMEz3rSetIpM6c9YIvu8N+cLK+sJveVaXwulJJg/gFF7avitT79yIyVcSQckHad
         ztiztlsYzUJMjbyFktrQBsHeSmYPH0jbFbaMym6bzL0pJDmiq2PNZyPeXUGytZ9zlCk8
         i3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122467; x=1730727267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68PJDSg07f0bxch+VUEO+1oDGL4AKHJjPCCWr8YxKSY=;
        b=wyJQXowYZOfNMTEdovs6eRgYMdak8uwa+L5rGRzsYYv5pTYDT1jESyrRbrXYmtER8g
         SFvDLy5Q2d6T5o9i0vK2FXM2Zg9Jf0wukVZkXDvNt2EB3p/gQp/J4iZPxCGoqZWuGNNZ
         bAHOztbsW95AjAG++5PdaAYdL9gjfrR9oVc6ocGqmAK0HPgNWpiUwywuZz2Mhi9waVg4
         MwU5rON52xW6ABWIzwszm+iXpGlBf95r3QrL5wvUOcSvCWsx0MInAE+y6tg4L1Ikgl36
         Nm3Qx8aLnJnYQ3TcIRR38nnOhSWlBYvlSIJ2Hd4B5NvXQKT3Iw6Nrv1dnxIrD83GZd6A
         3Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCUVY/hU/pYLeJWWu2NJHY7TH+BH4ZMO6dmDwPup1dCoH905y6f9x1oeyaEhKAwA7dEm7SAcWB2dKuAtMhDT@vger.kernel.org, AJvYcCVqf3av10ComISSf4NGrJfD4+XWlcbi9pCMzd2sT9qTzRYOuFllorckinddjEc1kGKi3EqgHjX62K3/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk4SV0Wl95up48ICxVBdsT17b/mbJ77L0My+OgG0SjvbZdTqk
	CKQLab8TC5GPJ16xMa7LOEebkU9e58917v/144A8EfZEAVq5GjDB
X-Google-Smtp-Source: AGHT+IG1jajkaB6fhAs54gYUSuxFDdMhQvxQ5nlM+cv0obvjmGd11CWQwD7XXkjQ5TkWZszEgRYHVg==
X-Received: by 2002:adf:a3d4:0:b0:37d:47b3:7b86 with SMTP id ffacd0b85a97d-38061200913mr6439652f8f.44.1730122467352;
        Mon, 28 Oct 2024 06:34:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13309sm9524649f8f.3.2024.10.28.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:34:27 -0700 (PDT)
Message-ID: <04e90dcf73bf87495e06639bd31160b848bde207.camel@gmail.com>
Subject: Re: [PATCH v8 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	dlechner@baylibre.com
Date: Mon, 28 Oct 2024 14:34:26 +0100
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
References: 
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	 <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-7-74ca7dd60567@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 11:49 +0200, Angelo Dureghello wrote:
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

LGTM, just one question inline. If not an issue:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++
> =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 530 ++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0drivers/iio/dac/ad3552r-hs.h |=C2=A0 19 ++
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A05 files changed, 568 insertions(+)
>=20
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 26f9de55b79f..f76eaba140d8 100644
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
> index 000000000000..97dfc598aec6
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -0,0 +1,530 @@
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
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> +		 * considered always on (considering buffering mode always).
> +		 */
> +		*val =3D DIV_ROUND_CLOSEST(st->data->bus_sample_data_clock_hz *
> +					 4 * 2, chan->scan_type.realbits);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D st->data->bus_reg_read(st->back,
> +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> +				val, 2);
> +		if (ret)
> +			return ret;

Is there any potential issue by doing a raw access when streaming?

- Nuno S=C3=A1



