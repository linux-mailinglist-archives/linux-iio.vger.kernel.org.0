Return-Path: <linux-iio+bounces-11116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48D9AE5A6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66406B24F12
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E81D6DA1;
	Thu, 24 Oct 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq8LQET1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221D1CB33E;
	Thu, 24 Oct 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775146; cv=none; b=FzfNJ2trBre7oGe8o+F7dwh2fZrGzqvWm0urWUwVzPw7l7p2/jzCn4VjwOoA/jjgJDPrYaWAgnx6UuXSw/gitu9U3F+airBgJ6eZP0OkU8KbGRrrI8tsT0UEJCKtBtTAEjapETmZE5k/MIhQi/BmZ17QPzBvmYdRDAWT6Plz7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775146; c=relaxed/simple;
	bh=n6l5hc/2n9jPxOPN3/St/8M3PvbHfLND+44ZcV6EP7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HyyijlImuzdC9r/4nyBO4g5Qj1ALAtyEFmJgeKOfi0QbV8YGOsn8fFZK4uQ+j3T6VqxyeIzhx6uSubGijAdBNKLL7yHvQir76uqlDmcVQbfgejo5geFW0lF+yI14Q7WkNjQfo34pT1pfVOj1nLlcvLX6qeVX1D4usDWmcFl3WTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq8LQET1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f84907caso1002948e87.3;
        Thu, 24 Oct 2024 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729775141; x=1730379941; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OQv32Z8mAHG5OK3SHu/zIgCqiiNdmT6FoFFK/nbJJw=;
        b=gq8LQET1I90zQT/Si0Y4vA9bnKsWnIrhaQVylfhw44ko+p+/jOhBbmdvukVKSZLvjV
         OptPLxQW83L5zCuX+tXp5gQzfAty0Yl/bRBXaDvU0WJ03+9H+7Ie0kdi/1FqT/VjLaj/
         KepDn/f8/2EwdYOJcUOPi3u1vdG+g8tyC/nSBhrfojD2+Wfmtb/4olYLzQLxK4DpIwPU
         K6bPgbBR527IFz3g8u3Lzqnrhb8gpL52xyeA7ixXymnE5nO09XqkDyumunLlyJMUY4JE
         DjnSTgxg3NUtkPeajnJKU7OL+O4TSlcgCkBcLQr1UhLEwVqnXiRsz2hTx0zI7WGwyR5p
         PDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729775141; x=1730379941;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OQv32Z8mAHG5OK3SHu/zIgCqiiNdmT6FoFFK/nbJJw=;
        b=SaPVExr4xyN2vF1CFf3bUVZLZO2zDC67cMDL0vy+PnK34IfOra/gTPuJ2GdyKzQ0FZ
         ziooZleAWG1CnpZ2dhhOyuPQWCmRgVJ7hbgB4EeHSkYsZ7xxMUblTVlbfnu3S/82Gn1u
         XfvEnbPppiH/duq357YcVpD7ymWvjpP3cgrV8qsQSqzPw0Out+hYMyCknDLyR68vcCx5
         1bYwSQBqUW2hmAbJvJgoTz8D9jbcbmBrLS1ViP05hBq0B8AMmG+lKsJoXgMb9bpTi/FL
         UcGQT9UK9F+5anth04rIazLshd6wu+kL06Bh6pa0F4z1Hc09+18+4AEcPX0+ImvVVUDt
         ihMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Il3WtNw/MIm9I0BqPW5SeHFysuhY3nAcQHPQbVyQM0Ift14OSip5/o3EpM+ZE+10evzVqY2GflaH@vger.kernel.org, AJvYcCVlKSrdhZLy47O/QPUr+x57ReGX89pGQpN90LoBiBgafB9GSwDh8QaRYaqmHIHzIhgs5OWrzDIJBLxouA1P@vger.kernel.org, AJvYcCWxi5cJ7WgEiNNfGVHR6JLdm/tB2oMf9zVsLKy32pcPxafZ7GRG4ZlX5i35QQicYJj5EGBz3774g3MU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8FfalOypx6TBRmlc6Uofuq038HxcSsea4ee0pmuuZhQKqWld
	hzT5w6wF8Wu9lP3X8gZWLMGozvSea4jNDLtFahCL995k0wUODq6GymX7aiHOb+orjevy
X-Google-Smtp-Source: AGHT+IEP9Ugwo22LiUMQn1HV8z4k+Wj7PEBShAT6pFxnVQ5hA2v6JM1wOMBGrgedPWi+KUXCzMtIuQ==
X-Received: by 2002:a05:6512:4008:b0:52e:76d5:9504 with SMTP id 2adb3069b0e04-53b23ddc8e8mr1402737e87.3.1729775140311;
        Thu, 24 Oct 2024 06:05:40 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm17655015e9.47.2024.10.24.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:05:39 -0700 (PDT)
Message-ID: <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 24 Oct 2024 15:05:39 +0200
In-Reply-To: <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
	 <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
	 <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote:
> Hi Nuno,
>=20
> On 22.10.2024 14:28, Nuno S=C3=A1 wrote:
> > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add High Speed ad3552r platform driver.
> > >=20
> > > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > > through the current AXI backend, or similar alternative IIO backend.
> > >=20
> > > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > > driver, this driver is coupled with a DAC IIO backend that finally
> > > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> > > maximum transfer rate of 33MUPS using dma stream capabilities.
> > >=20
> > > All commands involving QSPI bus read/write are delegated to the backe=
nd
> > > through the provided APIs for bus read/write.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1=
4 ++
> > > =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> > > =C2=A0drivers/iio/dac/ad3552r-hs.c | 547
> > > +++++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0drivers/iio/dac/ad3552r-hs.h |=C2=A0 18 ++
> > > =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > =C2=A05 files changed, 584 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > index fa091995d002..fc11698e88f2 100644
> > > --- a/drivers/iio/dac/Kconfig
> > > +++ b/drivers/iio/dac/Kconfig
> > > @@ -6,6 +6,20 @@
> > > =C2=A0
> > > =C2=A0menu "Digital to analog converters"
> > > =C2=A0
> > > +config AD3552R_HS
> > > +	tristate "Analog Devices AD3552R DAC High Speed driver"
> > > +	select ADI_AXI_DAC
> > > +	help
> > > +	=C2=A0 Say yes here to build support for Analog Devices AD3552R
> > > +	=C2=A0 Digital to Analog Converter High Speed driver.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The driver re=
quires the assistance of an IP core to operate,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 since data is=
 streamed into target device via DMA, sent over a
> > > +	=C2=A0 QSPI + DDR (Double Data Rate) bus.
> > > +
> > > +	=C2=A0 To compile this driver as a module, choose M here: the
> > > +	=C2=A0 module will be called ad3552r-hs.
> > > +
> > > =C2=A0config AD3552R
> > > =C2=A0	tristate "Analog Devices AD3552R DAC driver"
> > > =C2=A0	depends on SPI_MASTER
> > > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > > index c92de0366238..d92e08ca93ca 100644
> > > --- a/drivers/iio/dac/Makefile
> > > +++ b/drivers/iio/dac/Makefile
> > > @@ -4,6 +4,7 @@
> > > =C2=A0#
> > > =C2=A0
> > > =C2=A0# When adding new entries keep the list in alphabetical order
> > > +obj-$(CONFIG_AD3552R_HS) +=3D ad3552r-hs.o ad3552r-common.o
> > > =C2=A0obj-$(CONFIG_AD3552R) +=3D ad3552r.o ad3552r-common.o
> > > =C2=A0obj-$(CONFIG_AD5360) +=3D ad5360.o
> > > =C2=A0obj-$(CONFIG_AD5380) +=3D ad5380.o
> > > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-h=
s.c
> > > new file mode 100644
> > > index 000000000000..27bdc35fdc29
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/ad3552r-hs.c
> > > @@ -0,0 +1,547 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices AD3552R
> > > + * Digital to Analog converter driver, High Speed version
> > > + *
> > > + * Copyright 2024 Analog Devices Inc.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/iio/backend.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/units.h>
> > > +
> > > +#include "ad3552r.h"
> > > +#include "ad3552r-hs.h"
> > > +
> > > +struct ad3552r_hs_state {
> > > +	const struct ad3552r_model_data *model_data;
> > > +	struct gpio_desc *reset_gpio;
> > > +	struct device *dev;
> > > +	struct iio_backend *back;
> > > +	bool single_channel;
> > > +	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
> > > +	struct ad3552r_hs_platform_data *data;
> > > +};
> > > +
> > > +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> > > +					u32 reg, u32 mask, u32 val,
> > > +					size_t xfer_size)
> > > +{
> > > +	u32 rval;
> > > +	int ret;
> > > +
> > > +	ret =3D st->data->bus_reg_read(st->back, reg, &rval, xfer_size);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	rval =3D (rval & ~mask) | val;
> > > +
> > > +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> > > +}
> > > +
> > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *=
chan,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long ma=
sk)
> > > +{
> > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > +	int ret;
> > > +	int ch =3D chan->channel;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > +		int sclk;
> > > +
> > > +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
> > > +		if (ret !=3D IIO_VAL_INT)
> > > +			return -EINVAL;
> > > +
> >=20
> > I just saw you had some questions on v6 that everyone failed to see. Se=
e my
> > reply to David here:
> >=20
> > https://lore.kernel.org/linux-iio/61cf3072af74a8b2951c948ddc2383ba1e559=
54d.camel@gmail.com/
> >=20
> > It should be easy and it's something that makes sense (at least to me :=
))
> >=20
>=20
> I understood that we would improve things later in case.
>=20
> Could we maybe stay with IIO_CHAN_INFO_FREQUENCY ? It doesn't seems to me
> so out of scope. Sorry but i am trying to finalize someway this job,
> so i am trying to conatain changes now at v7, if code is not really=20
> totally wrong.

I think you're trying to rush in the series. I can understand your frustrat=
ion but
believe me that v7 (or v8) is not so bad :).

David already raised concerns about using IIO_CHAN_INFO_FREQUENCY. I'm also=
 not a fan
of it and gave you another option that should be trivial and makes sense (g=
iven that
bus_read and write are already being done through the platform_data interfa=
ce). So
no, I don't think we're going to accept "is not really totally wrong.". IOW=
, We want
it to be totally right - if such a thing exists :).

>=20
> > > +		/*
> > > +		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> > > +		 * considered always on (considering buffering mode always).
> > > +		 */
> > > +		*val =3D DIV_ROUND_CLOSEST(sclk * 4 * 2,
> > > +					 chan->scan_type.realbits);
> > > +
> > > +		return IIO_VAL_INT;
> > > +	}
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret =3D st->data->bus_reg_read(st->back,
> > > +				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> > > +				val, 2);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val =3D st->ch_data[ch].scale_int;
> > > +		*val2 =3D st->ch_data[ch].scale_dec;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		*val =3D st->ch_data[ch].offset_int;
> > > +		*val2 =3D st->ch_data[ch].offset_dec;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
> > > +				struct iio_chan_spec const *chan,
> > > +				int val, int val2, long mask)
> > > +{
> > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > > +			return st->data->bus_reg_write(st->back,
> > > +				=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH_DAC_16B(chan-
> > > > channel),
> > > +				=C2=A0=C2=A0=C2=A0 val, 2);
> > > +		}
> >=20
> > Maybe we'll get the new stuff in time for this :)
> >=20
> > ...
> >=20
> > > +
> > > +static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> > > +{
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Using inverted "active-high" logic here, since ad3552r classic-s=
pi
> > > +	 * fdt node (and driver) is using the same logic.
> > > +	 */
> > > +
> >=20
> > I don't understand this. This is a new device with a different compatib=
le. Why
> > keeping the wrong logic? AFAICT, there's nothing in the bindings about =
the pin
> > polarity.
> >=20
>=20
> ad3552r.c uses same compatible (adi,ad3552r), and in the code it implemen=
ts=20
> this same inverted logic. So i thought to use the same logic.
> I can anyway change to the correct active-low logic for this driver,=20
> but would honestly not enter in fixing old code now at v7.=20
> Happy to do such fix on ad3552r.c later on.

Ok, bad example from me with the compatible. The point is this is a differe=
nt device.
It's a platform device while the other one is a spi device. So why doing it=
 wrong in
here? Not saying to change the other device logic, just not doing it delibe=
rately
wrong in a new device.

For the old device, we can't likely change it as we could break current use=
rs who
just adapted their DTs to conform to the driver logic.

>=20
> > > +	st->reset_gpio =3D devm_gpiod_get_optional(st->dev,
> > > +						 "reset", GPIOD_OUT_LOW);
> > > +	if (IS_ERR(st->reset_gpio))
> > > +		return PTR_ERR(st->reset_gpio);
> > > +
> > > +	if (st->reset_gpio) {
> > > +		fsleep(10);
> > > +		gpiod_set_value_cansleep(st->reset_gpio, 1);
> > > +	} else {
> > > +		ret =3D ad3552r_qspi_update_reg_bits(st,
> > > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > > +					AD3552R_MASK_SOFTWARE_RESET,
> > > +					AD3552R_MASK_SOFTWARE_RESET, 1);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +	msleep(100);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ad3552r_hs_scratch_pad_test(struct ad3552r_hs_state *st)
> > > +{
> > > +	int ret, val;
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_=
PAD,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL1, 1)=
;
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_P=
AD,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL1)
> > > +		return dev_err_probe(st->dev, -EIO,
> > > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> > > 0x%x\n",
> > > +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_=
PAD,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SCRATCH_PAD_TEST_VAL2, 1)=
;
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_P=
AD,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL2)
> > > +		return dev_err_probe(st->dev, -EIO,
> > > +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read
> > > 0x%x\n",
> > > +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
> > > +					int ch, u16 gain, u16 offset)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back,
> > > AD3552R_REG_ADDR_CH_OFFSET(ch),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, 1);
> > > +	if (ret)
> > > +		return dev_err_probe(st->dev, ret, "Error writing
> > > register\n");
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(=
ch),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gain, 1);
> > > +	if (ret)
> > > +		return dev_err_probe(st->dev, ret, "Error writing
> > > register\n");
> > > +
> > > +	return 0;
> >=20
> > nit: Not a big fan of these logs on read/write registers functions... A=
lso seems
> > that you're not being consistent (either you have them or not). FWIW, I=
 would
> > simplify and drop them. That would allow to do
> >=20
> > return st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_CH_GAIN(ch), =
gain, 1);
> >=20
>=20
> Used dev_err_probe on quite all probe functions.
> I don't see nothing really wrong on this codem except maybe a more meanin=
gful
> message.

No, you're not being consistent. You have another calls (example: st->data-
>bus_reg_rea()) where no log is being given.=20

>=20
> > > +}
> > > +
> > > +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> > > +{
> > > +	s16 goffs;
> > > +	u16 id;
> > > +	u16 gain =3D 0, offset =3D 0;
> > > +	u32 ch, val, range;
> > > +	int ret;
> > > +
> > > +	ret =3D ad3552r_hs_reset(st);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D iio_backend_ddr_disable(st->back);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D ad3552r_hs_scratch_pad_test(st);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_I=
D_L,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	id =3D val;
> > > +
> > > +	ret =3D st->data->bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_I=
D_H,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &val, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	id |=3D val << 8;
> > > +	if (id !=3D st->model_data->chip_id)
> > > +		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> > > 0x%x\n",
> > > +			 AD3552R_ID, id);
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_SH_REFERENCE_CON=
FIG,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D st->data->bus_reg_write(st->back,
> > > +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > > +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> > > +					=C2=A0=C2=A0 AD3552R_QUAD_SPI) |
> > > +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERN=
AL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERN=
AL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D ad3552r_get_ref_voltage(st->dev, &val);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	val =3D ret;
> > > +
> > > +	ret =3D ad3552r_qspi_update_reg_bits(st,
> > > +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > > +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> > > +				val, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D ad3552r_get_drive_strength(st->dev, &val);
> > > +	if (!ret) {
> > > +		ret =3D ad3552r_qspi_update_reg_bits(st,
> > > +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > > +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> > > +					val, 1);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	device_for_each_child_node_scoped(st->dev, child) {
> > > +		ret =3D fwnode_property_read_u32(child, "reg", &ch);
> > > +		if (ret)
> > > +			return dev_err_probe(st->dev, ret,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "reg property missing\n");
> > > +
> > > +		ret =3D ad3552r_get_output_range(st->dev, st->model_data,
> > > child,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &range);
> > > +		if (!ret) {
> > > +			st->ch_data[ch].range =3D range;
> > > +
> > > +			ret =3D ad3552r_hs_set_output_range(st, ch, range);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +		} else if (ret =3D=3D -ENOENT) {
> > > +			ret =3D ad3552r_get_custom_gain(st->dev, child,
> > > +						&st->ch_data[ch].p,
> > > +						&st->ch_data[ch].n,
> > > +						&st->ch_data[ch].rfb,
> > > +						&st-
> > > > ch_data[ch].gain_offset);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			gain =3D ad3552r_calc_custom_gain(st->ch_data[ch].p,
> > > +						st->ch_data[ch].n,
> > > +						st->ch_data[ch].gain_offset);
> > > +			offset =3D abs(goffs);
> > > +
> > > +			st->ch_data[ch].range_override =3D 1;
> > > +
> > > +			ret =3D ad3552r_hs_setup_custom_gain(st, ch, gain,
> > > +							=C2=A0=C2=A0 offset);
> > > +			if (ret)
> > > +				return ret;
> > > +		} else {
> > > +			return ret;
> > > +		}
> >=20
> > Just personal preference... I think this would be neater:
> > if (ret && ret !=3D ENOENT)
> > 	return ret;
> > if (ret =3D=3D -ENOENT) {
> > 	...
> > } else {
> > 	...
> > }
> >=20
> > Advantage is that it also handles errors first (which is the typical pa=
ttern)
>=20
> I tested this code, would not change possibly now at this stage,
> unless another version should be sent.

Not sure if we'll need another but personally I cannot ack this one as it s=
tands...
sorry.

> =C2=A0
> >=20
> > > +
> > > +		ad3552r_calc_gain_and_offset(&st->ch_data[ch], st-
> > > > model_data);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct iio_buffer_setup_ops ad3552r_hs_buffer_setup_ops=
 =3D {
> > > +	.postenable =3D ad3552r_hs_buffer_postenable,
> > > +	.predisable =3D ad3552r_hs_buffer_predisable,
> > > +};
> > > +
> > > +#define AD3552R_CHANNEL(ch) { \
> > > +	.type =3D IIO_VOLTAGE, \
> > > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) | \
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET), \
> > > +	.output =3D 1, \
> > > +	.indexed =3D 1, \
> > > +	.channel =3D (ch), \
> > > +	.scan_index =3D (ch), \
> > > +	.scan_type =3D { \
> > > +		.sign =3D 'u', \
> > > +		.realbits =3D 16, \
> > > +		.storagebits =3D 16, \
> > > +		.endianness =3D IIO_BE, \
> > > +	} \
> > > +}
> > > +
> > > +static const struct iio_chan_spec ad3552r_hs_channels[] =3D {
> > > +	AD3552R_CHANNEL(0),
> > > +	AD3552R_CHANNEL(1),
> > > +};
> > > +
> > > +static const struct iio_info ad3552r_hs_info =3D {
> > > +	.read_raw =3D &ad3552r_hs_read_raw,
> > > +	.write_raw =3D &ad3552r_hs_write_raw,
> > > +};
> > > +
> > > +static int ad3552r_hs_probe(struct platform_device *pdev)
> > > +{
> > > +	struct ad3552r_hs_state *st;
> > > +	struct iio_dev *indio_dev;
> > > +	int ret;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	st =3D iio_priv(indio_dev);
> > > +	st->dev =3D &pdev->dev;
> > > +
> > > +	st->data =3D pdev->dev.platform_data;
> >=20
> > dev_get_platdata()
> >=20
>=20
> pdev->dev.platform_data seems correct to me, used in a lot of places
> in the driver framework. Can we stay with it ?
>=20

It is correct but if we an helper, why not using it? It may be used in a lo=
t of
places just because the helper was added afterwards...

- Nuno S=C3=A1
>=20

