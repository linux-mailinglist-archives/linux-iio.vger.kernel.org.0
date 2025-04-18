Return-Path: <linux-iio+bounces-18247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37101A938C1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE51919E16E8
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1261B395F;
	Fri, 18 Apr 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePsMLfMC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00E2C1A2;
	Fri, 18 Apr 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986835; cv=none; b=bMMvepHyJk+eZJCRbAzc6lzG7bZPoK+7s4fYcoAWXy7jiUmw57CXQB5dQrePpnR4uf0x/EMjBBLamMH3UHp5sFWQtsSQgwQvGbIPIhJvLAJSNesKTIMiUVpeRgcWUCfiu9nAztSM6dczIEmGFqbplR0imTL7HGV/vTBX6yOQcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986835; c=relaxed/simple;
	bh=mQU/bc/X+pNjzJ/RfCqTbBynXEAB7s5q08NpNlQL9FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNZ8eyYUm665JSFzIcyf3H+ISI6Vt+U8xRCORjAMq7mIWEupWL5axWb6PqrUGD+MRj2PPMopUWfQPdXxWn5Nxk7NlEUZvo27OOZIVKqSnNcO4zYR7a6o2uPGcC6OStvmHHoFqB4C9Ae6Rl4bn9LKI/54JP5rf3N1OGSwdYYd4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePsMLfMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BFCC4CEE2;
	Fri, 18 Apr 2025 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986833;
	bh=mQU/bc/X+pNjzJ/RfCqTbBynXEAB7s5q08NpNlQL9FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePsMLfMCZBP0U5N07VFNAqwwTHKiVKxQ3m3MfFgEq50y4+7tbqNvI2lAwIJWsAkzn
	 HZOQwIs3BYrAGYkceYFcgmLZMl9nkGqujc9WPXTfZgqxgcqAY+5s+JUS18COtdXRvj
	 vxN+IZz24z3y9R9ehMHkOwYlI/MTTY/Eq4f9L6Y/hL9Gu81OgPXOP58DLViU5fnbuA
	 iUlUYodQVGxSwO8kzIA6gqALMVf4ZsBHSVb31Gn16LXqkSG4cL0yRd6UnprPAZ1hXo
	 83s6kvo7bN1iNHxNgWm1QffjgMI4cMPu0gSwij1Rwg9pGOWa1mtXV0ZWPY56L++7bA
	 LfeN+4AaoUVlg==
Date: Fri, 18 Apr 2025 15:33:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] iio: adc: ad4080: add driver support
Message-ID: <20250418153347.6d8e8057@jic23-huawei>
In-Reply-To: <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	<20250411123627.6114-14-antoniu.miclaus@analog.com>
	<4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

			=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D iio_backend_data_alignment_enable(st->back);
> > +	if (ret)
> > +		return ret;
> > +
> > +	do {
> > +		ret =3D iio_backend_sync_status_get(st->back, &sync_en);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (!sync_en)
> > +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit
> > Slip\n");
> > +	} while (--timeout && !sync_en);
> > +
> > +	if (timeout) {
> > +		dev_info(&st->spi->dev, "Success: Pattern correct and
> > Locked!\n");
> > +		if (st->num_lanes =3D=3D 1)
> > +			return regmap_write(st->regmap,
> > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > +					=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> > +		else
> > +			return regmap_write(st->regmap,
> > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > +					=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > +					=C2=A0=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > +	} else {
> > +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> > +		if (st->num_lanes =3D=3D 1) {
> > +			ret =3D regmap_write(st->regmap,
> > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> > +			if (ret)
> > +				return ret;
> > +		} else {
> > +			ret =3D regmap_write(st->regmap,
> > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > +					=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		return -ETIMEDOUT; =20
>=20
> So, first the things that I don't really get (also the hdl docs need to be
> improved FWIW):
>=20
> * It seems that we can have data alignment or data capture synchronization
> through an internal AMD FPGA technique called bit-slip or an external sig=
nal,
> right? In here, it seems that we only use bit-slip and never disable it. =
Is that
> really the goal?
>=20
> * This whole process seems to be some kind of calibration at the interface
> level, right?
>=20
> * What's the point of the conv clock? Is it only used to get the sample r=
ate? If
> so, the hdl docs are misleading as it seems that it can be used instead o=
f bit-
> slip for data capture alignment?
>=20
> Now, speaking about the backend API's, it looks like that
> iio_backend_self_sync_enable() and iio_backend_data_alignment_enable() co=
uld be
> merged into one API. From what I can tell, iio_backend_data_alignment_ena=
ble()
> just enables the bit-slip process but that likely does nothing unless the
> SELF_SYNC bit is also set to bit-slip, right? In fact, we could think abo=
ut a
> more generic (less flexible though) API like:
>=20
> * iio_backend_intf_data_align(back, timeout_us), or
> * iio_backend_intf_calib(back, timeout_us), or
> * iio_backend_intf_data_capture_sync(back, timeout_us)
>=20
> On the backend side, you could then enable bit-slip and do the status rea=
d (with
> timeout) and return success or an error code.
>=20
> The above seems to be pretty much what you're doing but in just one API t=
hat
> makes sense to me.
>=20
> Of course that the following questions still come to mind:
>=20
> * Do we need to disable bit-slip after we're done (still fits into the on=
e API
> model)?
> * Do we need a meaningful API to change between the syncing/alignment met=
hods?
> External signal vs bit-slip?
>=20
> The above is key to better think of an API. Right now it feels that you'r=
e just
> adding an API for every bit you want to control in this process...
>=20
> If we end up needing more flexibility for this, we can also consider the
> existing iio_backend_data_sample_trigger() API. I know is abusing a bit a=
nd a
> stretch but in the end of the day the whole thing is related with alignin=
g,
> syncing, calibrating the interface for properly sampling data. Even bit-s=
lip
> (while not a traditional external trigger) looks like some kind of self-
> adjusting, data-driven trigger mechanism to establish the correct startin=
g point
> for capturing data. So having two new enums like:
>=20
> IIO_BACKEND_SAMPLE_TRIGGER_EXT_SIGNAL,
> IIO_BACKEND_SAMPLE_TRIGGER_BIT_SLIP // or maybe a more generic name like
> s/BIT_SLIP/INTERNAL
>=20
> I do not think the above is that horrible :P... But I would really like t=
o get
> more opinions about this.

Seems reasonable to me to combine the two as long as we have good documenta=
tion.
Agreed it is kind of deriving a trigger from the signal so turning it on wi=
th
a trigger type selection doesn't seem unreasonable.

Name tricky though.

Jonathan

>=20
> > +	}
> > +} =20
>=20
> ...
>=20
> >=20
> > +static const struct ad4080_chip_info ad4080_chip_info =3D {
> > +	.name =3D "AD4080",
> > +	.product_id =3D AD4080_CHIP_ID,
> > +	.scale_table =3D ad4080_scale_table,
> > +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> > +	.num_channels =3D 1,
> > +	.channels =3D ad4080_channels,
> > +};
> > +
> > +static int ad4080_setup(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4080_state *st =3D iio_priv(indio_dev);
> > +	unsigned int id;
> > +	int ret;
> > +
> > +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> > +			=C2=A0=C2=A0 AD4080_SW_RESET);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> > +			=C2=A0=C2=A0 AD4080_SDO_ENABLE_MSK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (id !=3D AD4080_CHIP_ID)
> > +		return dev_err_probe(&st->spi->dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unrecognized CHIP_ID 0x%X\n", id);
> > +
> > +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPO_1_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> > +			=C2=A0=C2=A0 FIELD_PREP(AD4080_GPIO_1_SEL, 3));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D iio_backend_self_sync_enable(st->back);
> > +	if (ret)
> > +		return ret;
> > + =20
>=20
> AFAIU, the above is enabling bit-slip?
> =20
> > +	if (st->lvds_cnv_en) {
> > +		if (st->num_lanes) {
> > +			ret =3D regmap_update_bits(st->regmap,
> > +					=09
> > AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> > +						 AD4080_LVDS_CNV_CLK_CNT_MSK,
> > +					=09
> > FIELD_PREP(AD4080_LVDS_CNV_CLK_CNT_MSK, 7));
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +		ret =3D regmap_set_bits(st->regmap,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_LVDS_CNV_EN_MSK);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return ad4080_lvds_sync_write(st);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ad4080_properties_parse(struct ad4080_state *st)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	st->lvds_cnv_en =3D device_property_read_bool(&st->spi->dev,
> > +						=C2=A0=C2=A0=C2=A0 "adi,lvds-cnv-enable");
> > + =20
>=20
> nit: I would probably drop the enable part. The property is about stating=
 that
> the signal is LVDS instead of CMOS. And IIUC, this should also depend on =
the
> existence of `st->clk`
> =20
> > +	st->num_lanes =3D 1;
> > +	ret =3D device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val=
);
> > +	if (!ret)
> > +		st->num_lanes =3D val;
> > +}
> > +
> > +static int ad4080_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct device *dev =3D &spi->dev;
> > +	struct ad4080_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->spi =3D spi;
> > +
> > +	ret =3D devm_regulator_bulk_get_enable(dev,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > ARRAY_SIZE(ad4080_power_supplies),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 ad4080_power_supplies);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> > +
> > +	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return PTR_ERR(st->regmap);
> > +
> > +	st->info =3D spi_get_device_match_data(spi);
> > +	if (!st->info)
> > +		return -ENODEV;
> > +
> > +	ret =3D devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->info =3D spi_get_device_match_data(spi);
> > +	if (!st->info)
> > +		return -ENODEV;
> > + =20
>=20
> The above is duplicated...
>=20
> > +	indio_dev->name =3D st->info->name;
> > +	indio_dev->channels =3D st->info->channels;
> > +	indio_dev->num_channels =3D st->info->num_channels;
> > +	indio_dev->info =3D &ad4080_iio_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	ad4080_properties_parse(st);
> > +
> > +	st->clk =3D devm_clk_get_enabled(&spi->dev, "cnv");
> > +	if (IS_ERR(st->clk))
> > +		return PTR_ERR(st->clk);
> > + =20
>=20
> From the datasheet it looks like this clock is optional? Moreover in the =
IP docs
> we have the following:
>=20
>=20
> "SELF_SYNC: Controls if the data capture synchronization is done through =
CNV
> signal or bit-slip."
>=20
> So I wonder, is the cnv clock meaning that we want to have capture
> sync/alignment through that external signal instead of bit-slip?
>=20
> - Nuno S=C3=A1


