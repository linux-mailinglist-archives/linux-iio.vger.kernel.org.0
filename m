Return-Path: <linux-iio+bounces-11722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F077F9B8532
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6521F223F9
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8A21A76D5;
	Thu, 31 Oct 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN9RlTkR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3015665E;
	Thu, 31 Oct 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409740; cv=none; b=nzOKDAZujjEYYUeOpeNC+EHy4CR5ao28CgA2D0QCL+iDs7gs+v9aWgBKgNCt6N7eo7atX4iB5lI9xLhGoyQTPwkHzprPfYHewcCcQK+giTgkuow2AbjVKlKUDz42MuxR11DbdML7mggnUwvcaF13e0Sz7S52SArsbgCl9zezP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409740; c=relaxed/simple;
	bh=BOOl39CI37M2c8ebIw1rX3CdU7DQHOb8JkInrd0Ub9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+HnB2GC/nEEUwojU5Tcj1UewFwmACMWsz/6c7JlaUmcBZEEKsUl+GgnR8V3ce8uJL9FZC/fcUAry3Sr+YVGPvuw+8exBq8N1XuLVwvce97Rv47uC9h9QZzvyT9dxRK9BqfG0gqF5FbNeDJ4MPIb8fs5F9pXQruOteZvos6as8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN9RlTkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC6EC4CEC3;
	Thu, 31 Oct 2024 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730409738;
	bh=BOOl39CI37M2c8ebIw1rX3CdU7DQHOb8JkInrd0Ub9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QN9RlTkR5RI1odq1MwBZq2ETR2R/w+v+GuquDQkZMTsQXu0s36th5ZQ9YruOI5vXZ
	 jcFfgC1JRjHDHIBNhy3DjXJhw1E2bPdtiVgUdo8g24BHl8XZ0tJPFvM5ayTezdOyG2
	 F/4zwtX07ma1BbnZfuYKHqTFUebn8CnoU1jfg92eA2fWQk3/KMEmnFhAPKPN+DDGY+
	 t71MdttzP5a3CAHFWRyapF/vhQznzEG5lA2zxlZa9dWCOo0gDrlHw4eVIO0SkuKx2p
	 tzQK98/bytqF4bDbpHjR9cyUE6lu+ifLxpHUlZXzjpkUp0z04n/u1AdcevFWKRkQih
	 3OnlG6X/CVCag==
Date: Thu, 31 Oct 2024 21:22:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
 <broonie@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>
Subject: Re: [PATCH v9 4/8] iio: dac: adi-axi-dac: extend features
Message-ID: <20241031212209.3d94c18c@jic23-huawei>
In-Reply-To: <2e343f2da60b8ad4da9f24d0d42a961abf2dc30f.camel@gmail.com>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	<20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-4-f6960b4f9719@kernel-space.org>
	<51afb385d291d27ea4e5d8b1f5f3389573b119d5.camel@gmail.com>
	<20241029211737.6486e0d6@jic23-huawei>
	<2e343f2da60b8ad4da9f24d0d42a961abf2dc30f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 07:35:41 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-10-29 at 21:17 +0000, Jonathan Cameron wrote:
> > On Tue, 29 Oct 2024 09:13:42 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Mon, 2024-10-28 at 22:45 +0100, Angelo Dureghello wrote: =20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Extend AXI-DAC backend with new features required to interface
> > > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > > IP but with some customizations to work with the ad3552r.
> > > >=20
> > > > Then, a series of generic functions has been added to match with
> > > > ad3552r needs. Function names has been kept generic as much as
> > > > possible, to allow re-utilization from other frontend drivers.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---=C2=A0  =20
> > >=20
> > > Hi Angelo,
> > >=20
> > > Small stuff that Jonathan might be able to change while applying... W=
ith that:
> > >=20
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > >  =20
> > > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 256 +++++++++++++++++++++++++=
++++++++++++++--
> > > > -
> > > > =C2=A01 file changed, 242 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-ax=
i-dac.c
> > > > index 04193a98616e..155d04ca2315 100644
> > > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > > @@ -46,9 +46,28 @@
> > > > =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > > =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > > =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > > =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > > +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > > > +
> > > > +#define
> > > > AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE	(AXI_DAC_CUSTOM_CTRL_TRANSFER_DAT=
A | \
> > > > +						 AXI_DAC_CUSTOM_CTRL_STREAM)
> > > > =C2=A0
> > > > =C2=A0/* DAC Channel controls */
> > > > =C2=A0#define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> > > > @@ -63,12 +82,21 @@
> > > > =C2=A0#define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> > > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3,=
 0)
> > > > =C2=A0
> > > > +#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> > > > +
> > > > =C2=A0/* 360 degrees in rad */
> > > > =C2=A0#define AXI_DAC_2_PI_MEGA			6283190
> > > > =C2=A0
> > > > =C2=A0enum {
> > > > =C2=A0	AXI_DAC_DATA_INTERNAL_TONE,
> > > > =C2=A0	AXI_DAC_DATA_DMA =3D 2,
> > > > +	AXI_DAC_DATA_INTERNAL_RAMP_16BIT =3D 11,
> > > > +};
> > > > +
> > > > +struct axi_dac_info {
> > > > +	unsigned int version;
> > > > +	const struct iio_backend_info *backend_info;
> > > > +	bool has_dac_clk;
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0struct axi_dac_state {
> > > > @@ -79,9 +107,11 @@ struct axi_dac_state {
> > > > =C2=A0	 * data/variables.
> > > > =C2=A0	 */
> > > > =C2=A0	struct mutex lock;
> > > > +	const struct axi_dac_info *info;
> > > > =C2=A0	u64 dac_clk;
> > > > =C2=A0	u32 reg_config;
> > > > =C2=A0	bool int_tone;
> > > > +	int dac_clk_rate;
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static int axi_dac_enable(struct iio_backend *back)
> > > > @@ -471,6 +501,11 @@ static int axi_dac_data_source_set(struct iio_=
backend
> > > > *back, unsigned int chan,
> > > > =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > > =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > > =C2=A0					=C2=A0 AXI_DAC_DATA_DMA);
> > > > +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> > > > +		return regmap_update_bits(st->regmap,
> > > > +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > > +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > > +					=C2=A0 AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> > > > =C2=A0	default:
> > > > =C2=A0		return -EINVAL;
> > > > =C2=A0	}
> > > > @@ -528,6 +563,154 @@ static int axi_dac_reg_access(struct iio_back=
end *back,
> > > > unsigned int reg,
> > > > =C2=A0	return regmap_write(st->regmap, reg, writeval);
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static int axi_dac_ddr_enable(struct iio_backend *back)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > +				 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > > +}
> > > > +
> > > > +static int axi_dac_ddr_disable(struct iio_backend *back)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > > +}
> > > > +
> > > > +static int axi_dac_data_stream_enable(struct iio_backend *back)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM=
_ENABLE);
> > > > +}
> > > > +
> > > > +static int axi_dac_data_stream_disable(struct iio_backend *back)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > +				 AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> > > > +}
> > > > +
> > > > +static int axi_dac_data_transfer_addr(struct iio_backend *back, u3=
2 address)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	if (address > FIELD_MAX(AXI_DAC_CUSTOM_CTRL_ADDRESS))
> > > > +		return -EINVAL;
> > > > +
> > > > +	/*
> > > > +	 * Sample register address, when the DAC is configured, or stream
> > > > +	 * start address when the FSM is in stream state.
> > > > +	 */
> > > > +	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > > +				=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > > +				=C2=A0 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > > +				=C2=A0 address));
> > > > +}
> > > > +
> > > > +static int axi_dac_data_format_set(struct iio_backend *back, unsig=
ned int ch,
> > > > +				=C2=A0=C2=A0 const struct iio_backend_data_fmt *data)
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	switch (data->type) {
> > > > +	case IIO_BACKEND_DATA_UNSIGNED:
> > > > +		return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > > +					 AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static int axi_dac_bus_reg_write_locked(struct iio_backend *back, =
u32 reg,
> > > > +					u32 val, size_t data_size)=C2=A0  =20
> > >=20
> > > nit: this is actually unlocked and needs to be locked from the outsid=
e. So,
> > > unlocked could be a better suffix. But more importantly is the extra =
call to
> > > iio_backend_get_priv(). We can just pass *st directly from the outer =
function. =20
> >=20
> > This naming always gets confusing. Are we naming the state, or what hap=
pens?
> >=20
> > A lockdep marking just inside the function can be used to make it obvio=
us
> > or the old __ prefix to say 'special, check the rules'.
> >  =20
>=20
>=20
> Yeah, personally I would prefer the __ prefix...
I've tweaked it to __axi_dac_bus_reg_write() whilst applying.


>=20
> - Nuno S=C3=A1
>=20
>=20
>=20


