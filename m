Return-Path: <linux-iio+bounces-18248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E30A938C6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BE77A91A2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E61BCA0F;
	Fri, 18 Apr 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtEKHrLW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682881E492;
	Fri, 18 Apr 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987042; cv=none; b=S/PvtNhHK692OukhvKN+gdB4P3V+leOxYWlEfrDJtZCWqpI3lobyRyVw3iILpXf4bLN0w5ZO13cS0FLDypMXbVabVzhqyyxweUj0tFIcbVZNHEgdOl6hA8iNUEyzJ5kSdAu9KHbfxMxQ7Y+GuK3511+DbUcFCHv/uApo6Y79Efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987042; c=relaxed/simple;
	bh=rElrW8ZwB8SCquR/fgdOOeqkQMqqBIIiDIb2R7RWjdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6ElXT6JjbMeJ/fz+qqkDFO3oifSKOOTZUC0rEnqXtmLNdoEpvj6GEOvYBsuMqjMxnAjk2EBmbQOwHGBYZWxiTB+O+IQ17HzTAS7rBheZrd+FEJNnfDsBhgg0zzrw3iGxlwp6O/34XyjtnJd5yqd+NRhd3zWcNs5Di3HwELVIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtEKHrLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98500C4CEE2;
	Fri, 18 Apr 2025 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987041;
	bh=rElrW8ZwB8SCquR/fgdOOeqkQMqqBIIiDIb2R7RWjdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DtEKHrLWgdLuVTaMvCpwtPF6eL9aLLrX8/h2ZpO69r9WayECvo2W5pgxwztZrbvBD
	 nYhFojsQ6udK+V5YdcB27PCrksIelixTxjPzoQgH9vAhIptvDLo7l4zCnmVEpZTMd4
	 eDs37SrTJAJB+9VCJivizQEQkIqv0zdJrjw3K/iYGK/gs/5GdspzwnfzgAtiU1CKag
	 ZkLhgRVmCjv+AUgadXFRZyzquXUCYhxw7tQjbgLS62X+Br6vDpt9aNzMVu2fJvQ4RS
	 tipNidGax5NqxdN2TmILUByxABCpqQcnXgLjdFeCS4P0nrWXFZ5RsyfVQnw1KTSw/F
	 IWriTn2kfx0eQ==
Date: Fri, 18 Apr 2025 15:37:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250418153714.501d3cb0@jic23-huawei>
In-Reply-To: <ef90f91a-c5eb-46ce-934f-93ff1a18af14@baylibre.com>
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
	<20250412-togreg-v4-3-cb9e5309b99d@analog.com>
	<ef90f91a-c5eb-46ce-934f-93ff1a18af14@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 14:23:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/12/25 12:57 AM, Kim Seer Paller wrote:
> > The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls, providing full-scale output spans of 2.5V or
> > 5V for reference voltages of 2.5V. These devices operate from a single
> > 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> > variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disa=
bled
> > by default.
> >=20
> > Support for monitoring internal die temperature, output voltages, and
> > current of a selected channel via the MUXOUT pin using an external ADC
> > is currently not implemented.
> >=20
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > --- =20
>=20
> Looks very good now. :-)
>=20
> A made a few comments but maybe nothing serious enough to require a v5.

We have plenty of time in the cycle, so I think I would prefer a v5
just tidying up these last few bits.

Thanks,

Jonathan

>=20
> > diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..ffa04f678b86d8da6f5e47c=
35c265b6648121843
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3530r.c
> > @@ -0,0 +1,506 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
> > + * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
> > + *
> > + * Copyright 2025 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/kernel.h> =20
>=20
> Usually, we try to avoid including kernel.h - it includes too much.
>=20
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > + =20
> ...
>=20
> > +
> > +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> > +			 bool has_external_vref)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->regmap);
> > +	struct gpio_desc *reset_gpio;
> > +	int i, ret;
> > +	bool has_range_multiplier;
> > +
> > +	reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> > +				     "Failed to get reset GPIO\n");
> > +
> > +	if (reset_gpio) {
> > +		/* Perform hardware reset */
> > +		fsleep(1000);
> > +		gpiod_set_value_cansleep(reset_gpio, 0);
> > +	} else {
> > +		/* Perform software reset */
> > +		ret =3D regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> > +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	fsleep(10000);
> > +
> > +	has_range_multiplier =3D false;
> > +	if (device_property_present(dev, "adi,range-double")) { =20
>=20
> Since this is a flag, I think device_property_read_bool() is preferred.
>=20
> > +		ret =3D regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> > +				      AD3530R_OUTPUT_CONTROL_RANGE);
> > +		if (ret)
> > +			return ret;
> > +
> > +		has_range_multiplier =3D true;
> > +	}
> > +
> > +	if (!has_external_vref && st->chip_info->internal_ref_support) {
> > +		ret =3D regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> > +				      AD3530R_REFERENCE_CONTROL_SEL);
> > +		if (ret)
> > +			return ret;
> > +
> > +		st->vref_mv =3D has_range_multiplier ?
> > +			      2 * AD3530R_INTERNAL_VREF_MV :
> > +			      AD3530R_INTERNAL_VREF_MV;
> > +	}
> > +
> > +	if (has_external_vref)
> > +		st->vref_mv =3D has_range_multiplier ? 2 * vref / 1000 : vref / 1000;
> > + =20
>=20
> I think this would be simpler as:
>=20
> 	st->vref_mv =3D range_multiplier * vref / 1000;
>=20
> where range_multiplier is 1 or 2.
>=20
> > +	/* Set operating mode to normal operation. */
> > +	ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0,
> > +			   AD3530R_NORMAL_OPERATION);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> > +		ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
> > +				   AD3530R_NORMAL_OPERATION);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < st->chip_info->num_channels; i++)
> > +		st->chan[i].powerdown_mode =3D AD3530R_POWERDOWN_32K;
> > +
> > +	st->ldac_gpio =3D devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH=
); =20
>=20
> I guess it doesn't matter which state this starts in but GPIOD_OUT_LOW se=
ems
> more natural since we toggle it high the low later.
>=20
> > +	if (IS_ERR(st->ldac_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> > +				     "Failed to get ldac GPIO\n");
> > +
> > +	return 0;
> > +}
> > + =20


