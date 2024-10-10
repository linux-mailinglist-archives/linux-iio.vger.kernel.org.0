Return-Path: <linux-iio+bounces-10388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B170E99875C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8662A1C240AF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD461C9DF6;
	Thu, 10 Oct 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlMfIIui"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F91C9DD8;
	Thu, 10 Oct 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566189; cv=none; b=LwQ1augDgIrdUheZj4hKQVaQoXT/V2WOHx7R/OU6d/ZiO5MFtYA3BWu64ow2LdUc6ORcBHju86vSTZDripAgb32RdTAsLItEjYs289ImCoIAVIyb1YXVaeOOoUQDPgVvQ1YANvJl/6gGz+hjRg2SSSYg0C40KuMNFSpaXR4LlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566189; c=relaxed/simple;
	bh=3HwfzdXn0j0Rx2ZZOUlOM9e6doN0yC5xhjxpcP7ATyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeuY7P/LGQ5EOibROhe4/DR9087lvOQnDnkQx6Fxf1fK3yQ9pTjrZuI5XauI5bZVzgDWFBJwd1BlnMJ0c9KETr8O5XjOgaEEBYq66F+CyJe8d6Vc5lXr5tyqTirFh8h9J9KzLg6S/UdoRtuNDwcfiN0cn9hrKF9XvwAyoC0DQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlMfIIui; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so5506315e9.1;
        Thu, 10 Oct 2024 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728566184; x=1729170984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGnv7ZwrheqBS7+EPimPagheCQiLEPPVfO/PcTJ3F6o=;
        b=PlMfIIui639UMTFcRgG5DESnN+du1ILTUiDG7CSdbQOT/FVk55gjTAMtRbpsoTICa8
         em4o1lQ1MJAL/Z4mntrLN5Xe2MLu9nBFK6T54Cl3r+TZnREmMAbc+Co8LLzZNXncvH0M
         r4j5PjyvY1p7akojW513z5CWy7MnvIdFH8/47IW2BiX+7Ne8GE2UVJrUyZBMXQBrm3SU
         Etch2hlhXPNmr//BCe9XFRhlgGrCilP0ErbbYxQrYorLpfGLXQhJ3r0ViY1LrlUyAfcm
         ShqK+xPam1ziesQwu3tYoCP8a0A0w57KvXAVefzTD/9cBA5hf+WVBY8Y3uLXNG1V7tOv
         ZADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566184; x=1729170984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGnv7ZwrheqBS7+EPimPagheCQiLEPPVfO/PcTJ3F6o=;
        b=I3+Leq3MTGt0iO0tG4Dyw4pi22Dq1WsOYLvWKFDVc3xljF/C91H4rsiA9veG2pOXHq
         oM7xauOzqqqqjz+w4LI4jymL6Ju0HV1nCF0erXpnuRlKK0RcXrFsC1wrbmjzjp3efe4T
         uTC58wYunpKIv0IMYPCuaz6EOyJW84Dr3AeZPVDcMKMjODV/3zWRjMfevjKZgb6cvd2n
         +PhenJ9I0iBq3FebqkT57tfIVwuLwyLi2MrnmuWejcoLNGEPHmBukMmcKbJCwYCgTJnZ
         qepUox7hx/ELhnpqZN/oYqDDQKFiyezMXf8nvAWUao100TAGa+cAH5zc6O9IwKbkIYI7
         ZrFw==
X-Forwarded-Encrypted: i=1; AJvYcCW9iEKlkG/l7kcAkv85tDvHOpTYBZaoAMcX3QYsiSV028azJ2JFTXpBLescM9cyG5JY0c3Fg5A4nDSH@vger.kernel.org, AJvYcCWkxa+aOw3Y2wHCWEBRq0J+1bkexeopWj4nMvermEFaG6Rc4ZfScaD5zf145EeN0bNTaYPeZe169gz3@vger.kernel.org, AJvYcCXQScspv4OCapiENmi6f7WqqwfwH4Kjo1yrXEMRN1hsGOtrydPzj8U7bzsrBq5WCei5SgEW1SFNmOw5Xm3G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GfIAytisOEoR1K04/CFDulJMQ0nSDSmCaPwnLO0oFd0SQjIV
	klH8lBmiMpeV0iNbt+B0DYqU45OWc/rm1jLsnkCzctOxYIO+wxrs
X-Google-Smtp-Source: AGHT+IFNLN0vY04yqW0EoxO58ly/Nw9vyAxGg17YXIOlbzAVfQlKoSS/fTgrRavwWo6F51lBnOwkLQ==
X-Received: by 2002:a05:600c:1d08:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-43115aa1f07mr27225895e9.5.1728566184169;
        Thu, 10 Oct 2024 06:16:24 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43118355cf5sm16320285e9.31.2024.10.10.06.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:16:23 -0700 (PDT)
Message-ID: <11b397492cd6c20876e3eb6a2d89173c0dfcbc70.camel@gmail.com>
Subject: Re: [PATCH v5 06/10] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dletchner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 10 Oct 2024 15:20:39 +0200
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-6-3d410944a63d@baylibre.com>
References: 
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-6-3d410944a63d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
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

Just some minor stuff. Not seeing any fundamental issue with this patch.

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 285 +++++++++++++++++++++++++++++++=
+++++++++-
> -
> =C2=A01 file changed, 274 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 04193a98616e..e43d0ecccb50 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -46,9 +46,28 @@
> =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> +#define AXI_DAC_STATUS_1_REG			0x0054
> +#define AXI_DAC_STATUS_2_REG			0x0058
> =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> +#define AXI_DAC_UI_STATUS_REG			0x0088
> +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> +
> +#define
> AXI_DAC_STREAM_ENABLE			(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
> +						AXI_DAC_CUSTOM_CTRL_STREAM)
> =C2=A0
> =C2=A0/* DAC Channel controls */
> =C2=A0#define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> @@ -63,12 +82,27 @@
> =C2=A0#define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
> =C2=A0
> +#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> +
> =C2=A0/* 360 degrees in rad */
> =C2=A0#define AXI_DAC_2_PI_MEGA			6283190
> =C2=A0
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

Do we still need the above?

> +
> +struct axi_dac_info {
> +	unsigned int version;
> +	const struct iio_backend_info *backend_info;
> +	bool bus_controller;
> +	bool has_dac_clk;
> =C2=A0};
>=20
> =C2=A0struct axi_dac_state {
> @@ -79,9 +113,12 @@ struct axi_dac_state {
> =C2=A0	 * data/variables.
> =C2=A0	 */
> =C2=A0	struct mutex lock;
> +	const struct axi_dac_info *info;
> +	struct clk *clk;

Is it used?

> =C2=A0	u64 dac_clk;
> =C2=A0	u32 reg_config;
> =C2=A0	bool int_tone;
> +	int dac_clk_rate;
> =C2=A0};
> =C2=A0
> =C2=A0static int axi_dac_enable(struct iio_backend *back)
> @@ -471,6 +508,11 @@ static int axi_dac_data_source_set(struct iio_backen=
d
> *back, unsigned int chan,
> =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> =C2=A0					=C2=A0 AXI_DAC_DATA_DMA);
> +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> +		return regmap_update_bits(st->regmap,
> +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> +					=C2=A0 AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -528,6 +570,186 @@ static int axi_dac_reg_access(struct iio_backend *b=
ack,
> unsigned int reg,
> =C2=A0	return regmap_write(st->regmap, reg, writeval);
> =C2=A0}
> =C2=A0
> +static int axi_dac_ddr_enable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +				 AXI_DAC_CNTRL_2_SDR_DDR_N);
> +}
> +
> +static int axi_dac_ddr_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N);
> +}
> +
> +static int axi_dac_data_stream_enable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_STREAM_ENABLE);
> +}
> +
> +static int axi_dac_data_stream_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_STREAM_ENABLE);
> +}
> +
> +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 addr=
ess)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +

We could add some validation for address with FIELD_MAX()

> +	/*
> +	 * Sample register address, when the DAC is configured, or stream
> +	 * start address when the FSM is in stream state.
> +	 */
> +	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> +				=C2=A0 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> +				=C2=A0 address));
> +}
> +
> +static int axi_dac_data_format_set(struct iio_backend *back, unsigned in=
t ch,
> +				=C2=A0=C2=A0 const struct iio_backend_data_fmt *data)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int err;
>=20

Not sure if I mentioned it already but please use 'ret' so it's consistent =
with
what we have. But for this function, see below

> +	switch (data->type) {
> +	case IIO_BACKEND_DATA_UNSIGNED:
> +		err =3D regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +					AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> +		if (err)
> +			return err;
> +		break;
		return regmap_clear_bits();
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

remove the above...

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
> +		int reg;

I would just declare it at top scope and remove {}. Otherwise...
> +
> +		if (!st->info->has_dac_clk)
> +			return -EOPNOTSUPP;
> +
> +		/*
> +		 * As from ad3552r AXI IP documentation,
> +		 * returning the SCLK depending on the stream mode.
> +		 */
> +		err =3D regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> +		if (err)
> +			return err;
> +
> +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> +			*val =3D st->dac_clk_rate / 2;
> +		else
> +			*val =3D st->dac_clk_rate / 8;
> +
> +		return IIO_VAL_INT;
> +		}

... does not look good
=20
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 =
val,
> +				 size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 ival;
> +
> +	if (data_size =3D=3D 2)

nit: sizeof(u16)

> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> +	else
> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> +
> +	ret =3D regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> +	 * the data size. So keeping data size control here only,
> +	 * since data size is mandatory for the current transfer.
> +	 * DDR state handled separately by specific backend calls,
> +	 * generally all raw register writes are SDR.
> +	 */
> +	if (data_size =3D=3D 1)
> +		ret =3D regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B);
> +	else
> +		ret =3D regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +					AXI_DAC_CNTRL_2_SYMB_8B);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> reg));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read_poll_timeout(st->regmap,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_REG, ival,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival &
> AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *=
val,
> +				size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 ival;
> +
> +	/*
> +	 * SPI, we write with read flag, then we read just at the AXI
> +	 * io address space to get data read.
> +	 */
> +	ret =3D axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
> data_size);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG,
> ival,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) !=3D
> +				AXI_DAC_UI_STATUS_IF_BUSY,
> +				10, 100);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> +}
> +
> =C2=A0static const struct iio_backend_ops axi_dac_generic_ops =3D {
> =C2=A0	.enable =3D axi_dac_enable,
> =C2=A0	.disable =3D axi_dac_disable,
> @@ -541,11 +763,29 @@ static const struct iio_backend_ops axi_dac_generic=
_ops
> =3D {
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_dac_reg_access=
),
> =C2=A0};
> =C2=A0
> +static const struct iio_backend_ops axi_ad3552r_ops =3D {
> +	.enable =3D axi_dac_enable,
> +	.read_raw =3D axi_dac_read_raw,
> +	.request_buffer =3D axi_dac_request_buffer,
> +	.data_source_set =3D axi_dac_data_source_set,
> +	.ddr_enable =3D axi_dac_ddr_enable,
> +	.ddr_disable =3D axi_dac_ddr_disable,
> +	.data_stream_enable =3D axi_dac_data_stream_enable,
> +	.data_stream_disable =3D axi_dac_data_stream_disable,
> +	.data_format_set =3D axi_dac_data_format_set,
> +	.data_transfer_addr =3D axi_dac_data_transfer_addr,
> +};
> +
> =C2=A0static const struct iio_backend_info axi_dac_generic =3D {
> =C2=A0	.name =3D "axi-dac",
> =C2=A0	.ops =3D &axi_dac_generic_ops,
> =C2=A0};
> =C2=A0
> +static const struct iio_backend_info axi_ad3552r =3D {
> +	.name =3D "axi-ad3552r",
> +	.ops =3D &axi_ad3552r_ops,
> +};
> +
> =C2=A0static const struct regmap_config axi_dac_regmap_config =3D {
> =C2=A0	.val_bits =3D 32,
> =C2=A0	.reg_bits =3D 32,
> @@ -555,7 +795,6 @@ static const struct regmap_config axi_dac_regmap_conf=
ig =3D
> {
> =C2=A0
> =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> =C2=A0{
> -	const unsigned int *expected_ver;
> =C2=A0	struct axi_dac_state *st;
> =C2=A0	void __iomem *base;
> =C2=A0	unsigned int ver;
> @@ -566,15 +805,26 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> =C2=A0	if (!st)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	expected_ver =3D device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	st->info =3D device_get_match_data(&pdev->dev);
> +	if (!st->info)
> =C2=A0		return -ENODEV;
> =C2=A0
> -	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> =C2=A0	if (IS_ERR(clk))
> =C2=A0		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get clock\n");
> =C2=A0
> +	if (st->info->has_dac_clk) {
> +		struct clk *dac_clk;
> +
> +		dac_clk =3D devm_clk_get_enabled(&pdev->dev, "dac_clk");
> +		if (IS_ERR(dac_clk))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get dac_clk
> clock\n");
> +
> +		st->dac_clk_rate =3D clk_get_rate(dac_clk);
> +	}
> +
> =C2=A0	base =3D devm_platform_ioremap_resource(pdev, 0);
> =C2=A0	if (IS_ERR(base))
> =C2=A0		return PTR_ERR(base);
> @@ -598,12 +848,13 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=3D
> ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=3D
> +		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
> =C2=A0		dev_err(&pdev->dev,
> =C2=A0			"Major version mismatch. Expected %d.%.2d.%c,
> Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> +			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> +			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> +			ADI_AXI_PCORE_VER_PATCH(st->info->version),
> =C2=A0			ADI_AXI_PCORE_VER_MAJOR(ver),
> =C2=A0			ADI_AXI_PCORE_VER_MINOR(ver),
> =C2=A0			ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -629,7 +880,8 @@ static int axi_dac_probe(struct platform_device *pdev=
)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	mutex_init(&st->lock);
> -	ret =3D devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
> +
> +	ret =3D devm_iio_backend_register(&pdev->dev, st->info->backend_info,
> st);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(&pdev->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to register iio backend\n");
> @@ -642,10 +894,21 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static unsigned int axi_dac_9_1_b_info =3D ADI_AXI_PCORE_VER(9, 1, 'b');
> +static const struct axi_dac_info dac_generic =3D {
> +	.version =3D ADI_AXI_PCORE_VER(9, 1, 'b'),
> +	.backend_info =3D &axi_dac_generic,
> +};
> +
> +static const struct axi_dac_info dac_ad3552r =3D {
> +	.version =3D ADI_AXI_PCORE_VER(9, 1, 'b'),
> +	.backend_info =3D &axi_ad3552r,
> +	.bus_controller =3D true,

Do we still need bus_controller?

- Nuno S=C3=A1



