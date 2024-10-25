Return-Path: <linux-iio+bounces-11241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A188F9AF9AD
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 08:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1A1F23B44
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 06:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC1198E81;
	Fri, 25 Oct 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoboBaJP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E918C030;
	Fri, 25 Oct 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836836; cv=none; b=WzZueWi9L0Vkq7TLrGa+8gWO9ltFcwb+twb1tt5iJyKAOICh3R5xwVc/9HbOLV6ZxdU0DNDQLY7DpVdWAsRAdGKJGewzZg+ycDDaMp87nWynQNbp3QDZECA2rtoC/IExxP0Q3TfHDCd/z4qxd3zvZBiKIglwInIVn7jP1lLyFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836836; c=relaxed/simple;
	bh=ftZRSZ1gbOsPmw5ihJaDFTNc4xbRCmEIuAcNB+CpY7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqXgaaFDHIP5v5jAfpBN8jf0NnQVetKVIVCMsAxrXoLiaxsA/aKRHh2Egb/9K8cBXR8iXwRbYXCf1qU9fF5d2/ZU/5xamHC6Wmdv1QIKzPGQ6CSzg1yMPevv2sAHnJO5hGIc3/K0/JmYIfVFYS72Tacv2XF2t3zoFc/k6KRv5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoboBaJP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso218483866b.1;
        Thu, 24 Oct 2024 23:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836832; x=1730441632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQxLMO8GfBgHfGm4i8Pyx/epeXStpaAQg45viyWWx70=;
        b=AoboBaJPdxS98oLYBGRBTGs3wXOGXftb4J19mZnCyi5RugX+M52wifHHfLoF+DhRgR
         2SGodGUtssMx2j54yevelk1bv8FluvncdAsQ6WOEew8FhDrB1E7Jjg4UcFtS4dcJj+tp
         +T/VB5chPl/qDXcnTmnSY49PIRue845klRTw/S5TQqTndAFRW9VHHf9i67ufQaHOj+BL
         k8wRVScM7DBIBY+kJ1yhJCyFRjsmGW6hHL8C6LugRwqL89syANmkU+m/K6xW0WBduBfp
         /onxpghGL5Kh43gS9vj2h/mvKZL+cODkPHfh3yeqGK3H4GJsF5vW07HMh4qfx5wun763
         uQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836832; x=1730441632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQxLMO8GfBgHfGm4i8Pyx/epeXStpaAQg45viyWWx70=;
        b=oG4i2BIjbEdoBb18W8DMkONh2kw0DITnv7PrH0a1RZZDh1vFt3IBGT+Sf2Fe5mVDJQ
         EX/ttueDhGE8XU/LhUOJRw29v7scQX19UMbMz5K7f2DMgGs8wdYKX6uJWq6Wtc8LEsDe
         3KKbxwQFEmN1gLFOe/YKkwfcdZXUq7o8/hWuKPLWrIw3GtaJzwh4anr21yB1Gu4wJ4HJ
         0oW6XSZdxaIH7E8Wn9NWHjwWNXaEuWx+1ahaKxzLtfYKciZQALd5/AHOftvEvj1GaggG
         Ezyt+QUMXlfNUih83Mww/zzXi/V65ag2yENRUYHh7rhhjUwZuwRq7eISFRIMgvT6wUiM
         S4cw==
X-Forwarded-Encrypted: i=1; AJvYcCULalIvSBjJqbO96Giv1sCsDZkD74JYuTLzynuU8dpnyNuwdJr825u2eBzug/N/m5imshSuBI2dqCDHutcK@vger.kernel.org, AJvYcCVnYAf9nRxUty0o2z7F4b2yA0KA3HV5/A0y4FlF0sHyLY0GE+VAsXjgAI2fvmuzrytBhXi/w+4Q3bCB@vger.kernel.org, AJvYcCWD3vtieoEJy+EYqgIDSlNEA0Yzicl5ZgedLUcEEsLJ0ndeK534WEn24EfkIqtlivW0Zetz8WPC9r/4@vger.kernel.org
X-Gm-Message-State: AOJu0YwzErOvjn1roxEQ6iz0FnNom9+SqjzRPY2+NPOvnM4iwOeXvcLU
	MaKJiQazq85m1+AVz2L3q0BdpDCJxjRyL3sJhEPpuUSrt6DMjqX7nduHX6e0JtD4yQ==
X-Google-Smtp-Source: AGHT+IHA6RHsMt5MuhUG1erEmFD4uckiBwq5oXRKpLstJF8EE5mZ1SIsRI5TYojYk+uJ2XYnHr1Z9g==
X-Received: by 2002:a17:907:6e93:b0:a9a:e2b:1711 with SMTP id a640c23a62f3a-a9ad257c4a8mr391769566b.0.1729836832067;
        Thu, 24 Oct 2024 23:13:52 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7b90sm30770166b.28.2024.10.24.23.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:13:51 -0700 (PDT)
Message-ID: <31e09df8a3fd562eff9a5bf6bd7a7706f27449b6.camel@gmail.com>
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
Date: Fri, 25 Oct 2024 08:13:50 +0200
In-Reply-To: <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
	 <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
	 <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
	 <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
	 <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Angelo,

Just some minor (not that big of a deal comments)

On Thu, 2024-10-24 at 17:02 +0200, Angelo Dureghello wrote:
> Hi Nuno,
>=20
> On 24.10.2024 15:05, Nuno S=C3=A1 wrote:
> > On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote:
> > > Hi Nuno,
> > >=20
> > > On 22.10.2024 14:28, Nuno S=C3=A1 wrote:
> > > > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Add High Speed ad3552r platform driver.
> > > > >=20
> > > > > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > > > > through the current AXI backend, or similar alternative IIO backe=
nd.
> > > > >=20
> > > > > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > > > > driver, this driver is coupled with a DAC IIO backend that finall=
y
> > > > > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to rea=
ch
> > > > > maximum transfer rate of 33MUPS using dma stream capabilities.
> > > > >=20
> > > > > All commands involving QSPI bus read/write are delegated to the b=
ackend
> > > > > through the provided APIs for bus read/write.
> > > > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > > =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 14 ++
> > > > > =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> > > > > =C2=A0drivers/iio/dac/ad3552r-hs.c | 547
> > > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > > =C2=A0drivers/iio/dac/ad3552r-hs.h |=C2=A0 18 ++
> > > > > =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4=
 +
> > > > > =C2=A05 files changed, 584 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > > > index fa091995d002..fc11698e88f2 100644
> > > > > --- a/drivers/iio/dac/Kconfig
> > > > > +++ b/drivers/iio/dac/Kconfig
> > > > > @@ -6,6 +6,20 @@
> > > > > =C2=A0
> > > > > =C2=A0menu "Digital to analog converters"
> > > > > =C2=A0
> > > > > +config AD3552R_HS
> > > > > +	tristate "Analog Devices AD3552R DAC High Speed driver"
> > > > > +	select ADI_AXI_DAC
> > > > > +	help
> > > > > +	=C2=A0 Say yes here to build support for Analog Devices AD3552R
> > > > > +	=C2=A0 Digital to Analog Converter High Speed driver.
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The drive=
r requires the assistance of an IP core to operate,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 since dat=
a is streamed into target device via DMA, sent over a
> > > > > +	=C2=A0 QSPI + DDR (Double Data Rate) bus.
> > > > > +
> > > > > +	=C2=A0 To compile this driver as a module, choose M here: the
> > > > > +	=C2=A0 module will be called ad3552r-hs.
> > > > > +
> > > > > =C2=A0config AD3552R
> > > > > =C2=A0	tristate "Analog Devices AD3552R DAC driver"
> > > > > =C2=A0	depends on SPI_MASTER
> > > > > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > > > > index c92de0366238..d92e08ca93ca 100644
> > > > > --- a/drivers/iio/dac/Makefile
> > > > > +++ b/drivers/iio/dac/Makefile
> > > > > @@ -4,6 +4,7 @@
> > > > > =C2=A0#
> > > > > =C2=A0
> > > > > =C2=A0# When adding new entries keep the list in alphabetical ord=
er
> > > > > +obj-$(CONFIG_AD3552R_HS) +=3D ad3552r-hs.o ad3552r-common.o
> > > > > =C2=A0obj-$(CONFIG_AD3552R) +=3D ad3552r.o ad3552r-common.o
> > > > > =C2=A0obj-$(CONFIG_AD5360) +=3D ad5360.o
> > > > > =C2=A0obj-$(CONFIG_AD5380) +=3D ad5380.o
> > > > > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad355=
2r-hs.c
> > > > > new file mode 100644
> > > > > index 000000000000..27bdc35fdc29
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/dac/ad3552r-hs.c
> > > > > @@ -0,0 +1,547 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Analog Devices AD3552R
> > > > > + * Digital to Analog converter driver, High Speed version
> > > > > + *
> > > > > + * Copyright 2024 Analog Devices Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > > +#include <linux/iio/backend.h>
> > > > > +#include <linux/iio/buffer.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/property.h>
> > > > > +#include <linux/units.h>
> > > > > +
> > > > > +#include "ad3552r.h"
> > > > > +#include "ad3552r-hs.h"
> > > > > +
> > > > > +struct ad3552r_hs_state {
> > > > > +	const struct ad3552r_model_data *model_data;
> > > > > +	struct gpio_desc *reset_gpio;
> > > > > +	struct device *dev;
> > > > > +	struct iio_backend *back;
> > > > > +	bool single_channel;
> > > > > +	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
> > > > > +	struct ad3552r_hs_platform_data *data;
> > > > > +};
> > > > > +
> > > > > +static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state =
*st,
> > > > > +					u32 reg, u32 mask, u32 val,
> > > > > +					size_t xfer_size)
> > > > > +{
> > > > > +	u32 rval;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D st->data->bus_reg_read(st->back, reg, &rval, xfer_size)=
;
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	rval =3D (rval & ~mask) | val;
> > > > > +
> > > > > +	return st->data->bus_reg_write(st->back, reg, rval, xfer_size);
> > > > > +}
> > > > > +
> > > > > +static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec con=
st *chan,
> > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, lon=
g mask)
> > > > > +{
> > > > > +	struct ad3552r_hs_state *st =3D iio_priv(indio_dev);
> > > > > +	int ret;
> > > > > +	int ch =3D chan->channel;
> > > > > +
> > > > > +	switch (mask) {
> > > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > > +		int sclk;
> > > > > +
> > > > > +		ret =3D iio_backend_read_raw(st->back, chan, &sclk, 0,
> > > > > +					=C2=A0=C2=A0 IIO_CHAN_INFO_FREQUENCY);
> > > > > +		if (ret !=3D IIO_VAL_INT)
> > > > > +			return -EINVAL;
> > > > > +
> > > >=20
> > > > I just saw you had some questions on v6 that everyone failed to see=
. See my
> > > > reply to David here:
> > > >=20
> > > > https://lore.kernel.org/linux-iio/61cf3072af74a8b2951c948ddc2383ba1=
e55954d.camel@gmail.com/
> > > >=20
> > > > It should be easy and it's something that makes sense (at least to =
me :))
> > > >=20
> > >=20
> > > I understood that we would improve things later in case.
> > >=20
> > > Could we maybe stay with IIO_CHAN_INFO_FREQUENCY ? It doesn't seems t=
o me
> > > so out of scope. Sorry but i am trying to finalize someway this job,
> > > so i am trying to conatain changes now at v7, if code is not really=
=20
> > > totally wrong.
> >=20
> > I think you're trying to rush in the series. I can understand your frus=
tration
> > but
> > believe me that v7 (or v8) is not so bad :).
> >=20
> > David already raised concerns about using IIO_CHAN_INFO_FREQUENCY. I'm =
also not a
> > fan
> > of it and gave you another option that should be trivial and makes sens=
e (given
> > that
> > bus_read and write are already being done through the platform_data int=
erface).
> > So
> > no, I don't think we're going to accept "is not really totally wrong.".=
 IOW, We
> > want
> > it to be totally right - if such a thing exists :).
> >=20
> > >=20
>=20
> i changed this way, using platform_data:
>=20
> static int axi_dac_bus_clok(struct iio_backend *back)

If we don't have error I would change it to:

static void axi_dac_bus_clock(struct iio_backend *back, u64 *rate) - or at =
the very
least return u64 and not int.

But alternatively, if you want to take simplicity one step further, you can=
 just save
a u64 bus_clock variable in your platform_data and access it directly (give=
n that
we're only assuming the streaming rate in which case this is constant). And=
 If we
ever have an usecase where we need more flexibility, it should be fairly st=
aright to
bring this the bus_clock() callback.

I'm fine either way so up to you :)

- Nuno S=C3=A1



