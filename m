Return-Path: <linux-iio+bounces-9664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F060397D5FE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24712859A5
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4516CD35;
	Fri, 20 Sep 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4EjSlHO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87702D05E;
	Fri, 20 Sep 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837860; cv=none; b=D0MjNJoElYwUO8jdkEjnh6ZwOpv0xhBenC6Xwemfps0Osf3uY9Zcf6RFlAaBu8yfm/bftkjCpCAdeTxFW10VyU3H8viJTeCQ5atyp4XDvynuZ/nTRRyOdqRnsstMf1BwxcRKD+C8ZTVlAStB1jJfirTxXDw/uDcAat/fO/L4v+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837860; c=relaxed/simple;
	bh=Sv65k5J94/KPYasGYLHEJcQEaChcchrIj+A4MozYu5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5tVCBipBb6/vAa2m596m15TLB1t5ZSYzhw4u5pddpGHEXjufgPkTnZ46dTlcG9jcGs11yWDQ4n8ncF+JvcH3ODmeoY1fqNeQScOIHpORJ5OgqmocDmXO7UFnS17ADEEjuEdIg6b37hkQzE3e/R6sezitWWLUBr2/ShDz0hUu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4EjSlHO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-378f90ad32dso1301192f8f.0;
        Fri, 20 Sep 2024 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726837857; x=1727442657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVem1vqTDwwLPKSZNYY/Ool64muwuHhKKu3sx78fStM=;
        b=P4EjSlHOiew1BFznkadjwi/wmXx9nlw0+wxd6N3DrB3dTLVuJO0bH/KFp8goV9xZhB
         +1AfF+TwKjtgbTZAqg5WI9/YyjAX7E8dDRIdOGH9Z9X51DBmRAVjhajctoOb5qGZkWe/
         gEPj8fowlLUT204FKkHyBfnXFU6oBg9jkiTB0d4g6xKJWTid4f0HAtAC445MNO10RMlk
         iCt+Yy7Uwxdb7v1/g/tpM3CI0cbtFm6k4/694YUgA9Xq6ojVT46ULGtUhKQkeaRzEft6
         yYZd9v7L1gH1Gs4AyFWkaMYOPnMFb+nqAncwM3v6j3nI73XWi4XyXhnPp2HgU+WsBPpc
         w2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837857; x=1727442657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVem1vqTDwwLPKSZNYY/Ool64muwuHhKKu3sx78fStM=;
        b=e6UQ3Z4U61/VOSmSSasKpXkkhe2UAT4+PwDVYUHxqkXmiZs6u6fin8e7NnN13xXYx4
         Oy5fWb+S8i2gz3KWGSF1sjQB5yCNlVOLv0INoCejehrhZJ5DJjF2xEKmhOxWm8aEA6LB
         rE4yI5Cp6oHX0RE0kiufy4c3Y5swLNiAIDmf+Zqjri1fCVmJlIARTWACrJdLykEcAfQh
         JB9IpSuio+JjR9YjkYMBbdubkHfapFRoMObb2xiYBdmyOhgx1k+mroX1ZTyal6pmOUiM
         KWgO8DVWA9TSXctJZse9E5e3BBcAdxGThdUKhLxtZS9oZPeeQdx+vH3+9l/SR+6VguQo
         piKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy9R8rIO7iD63AAzfDo70sgfvLq0TBrO3YRsQ09VcEb2Vd1wwZeciFphpJnD9JV5qUDQ0KL/1pCDmA@vger.kernel.org, AJvYcCWQFi775gJKglnybuTAQ5st+lSxYMJLxuDmts5NewqTFpVy6FPo0DpigO8MBgXc3CSWXyFIIzpn9AZ1mFmr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxzx4MFwQkzwGCjltpvBLsgeM/cCTYSZjRxI9MP+huS3+3DDw2
	IBfZafpGpF3zIPJGZv/CgVP0o/dx/dejn6J0w3lb8Hl5Eih8gVAo
X-Google-Smtp-Source: AGHT+IH0bXOoxeXSvqjzx9Iq2qCqly3/VvhQvLSrmbRnUfV+oXRXPE4xLFS1LpGtr9EgxmdHr/SLxQ==
X-Received: by 2002:a5d:4f0e:0:b0:374:bf97:ba10 with SMTP id ffacd0b85a97d-37a43154b16mr1410150f8f.25.1726837856799;
        Fri, 20 Sep 2024 06:10:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f97cbsm17470937f8f.50.2024.09.20.06.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:10:56 -0700 (PDT)
Message-ID: <b201064d6ab1f85709d99042bf4c77ac90d58a73.camel@gmail.com>
Subject: Re: [PATCH v3 06/10] iio: backend: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 20 Sep 2024 15:10:55 +0200
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-6-a17b9b3d05d9@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-6-a17b9b3d05d9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 11:20 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
>=20
> Then, a serie of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

The commit title is not ok... iio: dac: adi-axi-dac: ...

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 274 +++++++++++++++++++++++++++++++=
+++++++++--
> =C2=A01 file changed, 265 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index b8b4171b8043..3ca3a14c575b 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -44,11 +44,34 @@
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_RSTN_RSTN		BIT(0)
> =C2=A0#define AXI_DAC_REG_CNTRL_1		0x0044
> +#define=C2=A0=C2=A0 AXI_DAC_EXT_SYNC_ARM		BIT(1)
> +#define=C2=A0=C2=A0 AXI_DAC_EXT_SYNC_DISARM	BIT(2)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_SYNC			BIT(0)
> =C2=A0#define AXI_DAC_REG_CNTRL_2		0x0048
> +#define=C2=A0=C2=A0 AXI_DAC_SDR_DDR_N		BIT(16)
> +#define=C2=A0=C2=A0 AXI_DAC_SYMB_8B		BIT(14)
> =C2=A0#define	=C2=A0 ADI_DAC_R1_MODE		BIT(5)
> +#define=C2=A0=C2=A0 AXI_DAC_UNSIGNED_DATA		BIT(4)
> +#define AXI_DAC_REG_STATUS_1		0x54
> +#define AXI_DAC_REG_STATUS_2		0x58
> =C2=A0#define AXI_DAC_DRP_STATUS		0x0074
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_LOCKED		BIT(17)
> +#define AXI_DAC_CNTRL_DATA_RD		0x0080
> +#define=C2=A0=C2=A0 AXI_DAC_DATA_RD_8		GENMASK(7, 0)
> +#define=C2=A0=C2=A0 AXI_DAC_DATA_RD_16		GENMASK(15, 0)
> +#define AXI_DAC_CNTRL_DATA_WR		0x0084
> +#define=C2=A0=C2=A0 AXI_DAC_DATA_WR_8		GENMASK(23, 16)
> +#define=C2=A0=C2=A0 AXI_DAC_DATA_WR_16		GENMASK(23, 8)
> +#define AXI_DAC_UI_STATUS		0x0088
> +#define=C2=A0=C2=A0 AXI_DAC_BUSY			BIT(4)
> +#define AXI_DAC_REG_CUSTOM_CTRL		0x008C
> +#define=C2=A0=C2=A0 AXI_DAC_ADDRESS		GENMASK(31, 24)
> +#define=C2=A0=C2=A0 AXI_DAC_SYNCED_TRANSFER	BIT(2)
> +#define=C2=A0=C2=A0 AXI_DAC_STREAM		BIT(1)
> +#define=C2=A0=C2=A0 AXI_DAC_TRANSFER_DATA		BIT(0)
> +
> +#define AXI_DAC_STREAM_ENABLE		(AXI_DAC_TRANSFER_DATA | AXI_DAC_STREAM)
> +
> =C2=A0/* DAC Channel controls */
> =C2=A0#define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
> =C2=A0#define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0408 + (c) * 0x40)
> @@ -62,11 +85,25 @@
> =C2=A0#define AXI_DAC_REG_CHAN_CNTRL_7(c)	(0x0418 + (c) * 0x40)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DATA_SEL		GENMASK(3, 0)
> =C2=A0
> +#define AXI_DAC_RD_ADDR(x)		(BIT(7) | (x))
> +
> =C2=A0/* 360 degrees in rad */
> =C2=A0#define AXI_DAC_2_PI_MEGA		6283190
> +
> =C2=A0enum {
> =C2=A0	AXI_DAC_DATA_INTERNAL_TONE,
> =C2=A0	AXI_DAC_DATA_DMA =3D 2,
> +	AXI_DAC_DATA_INTERNAL_RAMP_16BIT =3D 11,
> +};
> +
> +enum {
> +	AXI_DAC_BUS_TYPE_NONE,
> +	AXI_DAC_BUS_TYPE_DDR_QSPI,
> +};
> +
> +struct axi_dac_info {
> +	unsigned int version;
> +	int bus_type;

Remove the bus_type... For now, let's just assume it's this QSPI implementa=
tion.
Let's worry with different buses when we actually have them. For now, let's=
 implement
this one but only for the new compatible. Maybe have a boolean in here like
`bus_controller`. You'll also need a backend info structure per dac_info st=
ructure.
More on that below...

Also it makes sense to have a const char *name variable. If it has a differ=
ent
compatible, we should name it accordingly.

> =C2=A0};
> =C2=A0
> =C2=A0struct axi_dac_state {
> @@ -77,6 +114,7 @@ struct axi_dac_state {
> =C2=A0	 * data/variables.
> =C2=A0	 */
> =C2=A0	struct mutex lock;
> +	const struct axi_dac_info *info;
> =C2=A0	u64 dac_clk;
> =C2=A0	u32 reg_config;
> =C2=A0	bool int_tone;
> @@ -461,6 +499,11 @@ static int axi_dac_data_source_set(struct iio_backen=
d *back,
> unsigned int chan,
> =C2=A0		return regmap_update_bits(st->regmap,
> =C2=A0					=C2=A0 AXI_DAC_REG_CHAN_CNTRL_7(chan),
> =C2=A0					=C2=A0 AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
> +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> +		return regmap_update_bits(st->regmap,
> +					=C2=A0 AXI_DAC_REG_CHAN_CNTRL_7(chan),
> +					=C2=A0 AXI_DAC_DATA_SEL,
> +					=C2=A0 AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -518,9 +561,206 @@ static int axi_dac_reg_access(struct iio_backend *b=
ack,
> unsigned int reg,
> =C2=A0	return regmap_write(st->regmap, reg, writeval);
> =C2=A0}
> =C2=A0
> +static int axi_dac_ext_sync_enable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_EXT_SYNC_ARM);
> +}
> +
> +static int axi_dac_ext_sync_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_1,
> +				 AXI_DAC_EXT_SYNC_DISARM);
> +}
> +
> +static int axi_dac_ddr_enable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +				 AXI_DAC_SDR_DDR_N);
> +}
> +
> +static int axi_dac_ddr_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_SDR_DDR_N);
> +}
> +
> +static int axi_dac_buffer_enable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_STREAM_ENABLE);
> +}
> +
> +static int axi_dac_buffer_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +				 AXI_DAC_STREAM_ENABLE);
> +}
> +
> +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 addr=
ess)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	/*
> +	 * Sample register address, when the DAC is configured, or stream
> +	 * start address when the FSM is in stream state.
> +	 */
> +	return regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +				=C2=A0 AXI_DAC_ADDRESS,
> +				=C2=A0 FIELD_PREP(AXI_DAC_ADDRESS, address));
> +}
> +
> +static int axi_dac_data_format_set(struct iio_backend *back, unsigned in=
t ch,
> +				=C2=A0=C2=A0 const struct iio_backend_data_fmt *data)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	if (data->type =3D=3D IIO_BACKEND_DATA_UNSIGNED)
> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +					 AXI_DAC_UNSIGNED_DATA);
> +
> +	return -EINVAL;

nit: I would prefer error handling. Or assuming we might have additional ty=
pes in the
future, we can also make it a switch() case...

> +}
> +
> +static int axi_dac_read_raw(struct iio_backend *back,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int err;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY: {
> +		int clk_in, reg;
> +
> +		/*
> +		 * As from AXI IP documentation,
> +		 * returning the SCLK depending on the stream mode.
> +		 */

This comment is very specific to the implementation. Make sure to refer to =
the actual
ip on it (axi-ad3552r).
> +		clk_in =3D clk_get_rate(clk_get(st->dev, 0));
> +

Nope.. You have several problems in here:

1) clk_get() every time the function get's called. This has leaks;
2) AFAIR, this IP already get's the AXI bus clock to enable it. You'll have=
 to name
your clocks;
3) The clk_get() needs to be done on probe() (use the devm_ variant). And i=
t is only
mandatory for the axi_ad3552r implementation.=20
4) You're not enabling the clock (you can have it done in one call).
5) You need to return -EOPNOTSUPP or similar in case there's no support for=
 this. We
have a dedicated compatible so we can make use of it (maybe for now the
bus_controller boolean is enough - again, let's assume it's qspi).
6) I don't think the refclk is expected to change so you can likely get on =
probe().

> +		err =3D regmap_read(st->regmap, AXI_DAC_REG_CUSTOM_CTRL, &reg);
> +		if (err)
> +			return err;
> +
> +		if (reg & AXI_DAC_STREAM)
> +			*val =3D clk_in / 2;
> +		else
> +			*val =3D clk_in / 8;
> +
> +		return IIO_VAL_INT;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
> +				 unsigned int val, size_t data_size)
> +{

Be consistent... either two `u32` or two `unsigned int`

> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
> +		int ret;
> +		u32 ival;
> +
> +		if (data_size =3D=3D 2)
> +			ival =3D FIELD_PREP(AXI_DAC_DATA_WR_16, val);
> +		else
> +			ival =3D FIELD_PREP(AXI_DAC_DATA_WR_8, val);
> +
> +		ret =3D regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> +		 * the data size. So keeping data size control here only,
> +		 * since data size is mandatory for the current transfer.
> +		 * DDR state handled separately by specific backend calls,
> +		 * generally all raw register writes are SDR.
> +		 */
> +		if (data_size =3D=3D 1)
> +			ret =3D regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_SYMB_8B);
> +		else
> +			ret =3D regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +						AXI_DAC_SYMB_8B);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_ADDRESS,
> +					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_TRANSFER_DATA,
> +					 AXI_DAC_TRANSFER_DATA);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_read_poll_timeout(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_REG_CUSTOM_CTRL, ival,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival & AXI_DAC_TRANSFER_DATA,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					=C2=A0 AXI_DAC_TRANSFER_DATA);
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
> +				unsigned int *val, size_t data_size)
> +{

ditto. Not sure if the backend ops are like this. If yes, same comment.

> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
> +		int ret;
> +		u32 bval;
> +
> +		ret =3D axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
> +					=C2=A0=C2=A0=C2=A0 data_size);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bval, bval !=3D AXI_DAC_BUSY,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +

Both the above look mostly good... Just get rid of the bus_type id :)

> =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> =C2=A0	.enable =3D axi_dac_enable,
> =C2=A0	.disable =3D axi_dac_disable,
> +	.read_raw =3D axi_dac_read_raw,
> =C2=A0	.request_buffer =3D axi_dac_request_buffer,
> =C2=A0	.free_buffer =3D axi_dac_free_buffer,
> =C2=A0	.extend_chan_spec =3D axi_dac_extend_chan,
> @@ -528,6 +768,14 @@ static const struct iio_backend_ops axi_dac_generic_=
ops =3D {
> =C2=A0	.ext_info_get =3D axi_dac_ext_info_get,
> =C2=A0	.data_source_set =3D axi_dac_data_source_set,
> =C2=A0	.set_sample_rate =3D axi_dac_set_sample_rate,
> +	.ext_sync_enable =3D axi_dac_ext_sync_enable,
> +	.ext_sync_disable =3D axi_dac_ext_sync_disable,
> +	.ddr_enable =3D axi_dac_ddr_enable,
> +	.ddr_disable =3D axi_dac_ddr_disable,
> +	.buffer_enable =3D axi_dac_buffer_enable,
> +	.buffer_disable =3D axi_dac_buffer_disable,
> +	.data_format_set =3D axi_dac_data_format_set,
> +	.data_transfer_addr =3D axi_dac_data_transfer_addr,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_dac_reg_access=
),
> =C2=A0};

Make sure to define a new struct iio_backend_ops with the ops this design n=
eeds and
leave the above untouched.

- Nuno S=C3=A1



