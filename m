Return-Path: <linux-iio+bounces-11554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2A9B43D9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 09:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB98B220B6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C8F203715;
	Tue, 29 Oct 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKuUal75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A214C6E;
	Tue, 29 Oct 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189367; cv=none; b=ClnpOggbgcR2UYWuyDz3W0Bm4oRNHhT0X49iAH4ESgSoVhBxFP+FUmb0SOKoue9dvdkTTvU97cPUw63rNLRwaQ7/HMZQfb17DX/q2FjJaILNfzRt8ArCuz3a4/2fhOpNbJ5nqpGE7mniNb5xVV4dIw43FMmm5drSCGx5CKOKIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189367; c=relaxed/simple;
	bh=V4fdTt6VacxZNGOQPnJSy2fLiLBr121Jm3kT5IiBJ8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuxhUOebGO9GqmsuYlG/gsX+fDdy869fqsroYOJwaTtQJwLrab+dp1iVvhxeaOQx+qXM74ouIkhRg7M6MQ/McpJ5frSl2miAvZCDmIybNOoEwh+rl+ANORqn9PZrgcSpo3jTnHvfNjee7U/RI+9tZM56HCmdBKJX+rlN90qCSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKuUal75; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e7e73740so4284605e87.3;
        Tue, 29 Oct 2024 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730189363; x=1730794163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpj1ugOlxEm9ZQsDOX+HXJiuvcM3PHjiPDoWtSR/0xo=;
        b=bKuUal755uINR/AwxTSYS/adYJkRqBgzy5WWEFkbRb3LGXW1jjdUJSjFoXcC51XRzS
         oVyn8qHEuyP4uoR625tqKBsGv/YklalXwzwa765Jp1WQHXQ1ReHIkolVATwQKOpdB3Xd
         /eJ3MGB+kKxG6wx3yIM/k1kIoYlobgY3HQYoDdCb8N7zmVqLygqnKhrl53b5Ccdbe2sh
         cdaLEh6IBSULeHhmGQl5Cray6hGjtyzFkKEZI6Lu11fW2aklp0T2S/ZyZC+lwybPRrow
         oqHnbI3xCtKW/8KVuqDylrQVq7NkIc5MH0G4khvbdjbuRV0eVe/+JXnyAcpmZqRrsHKJ
         NiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189363; x=1730794163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpj1ugOlxEm9ZQsDOX+HXJiuvcM3PHjiPDoWtSR/0xo=;
        b=jXkZfzKo55iKKwWHVGg8JmRCB0jOYsM7bYYcOEZxnNG+C07HvLxAftMS1ucf+QeSTL
         ufeL5fcvC7/PfyfTq07Ih9zG1UitOieeE7HmzeVUr84cZokWAJZrLamzGyCZ5GU7pgcm
         zYFcv6Dp8HePn9S1JRnpbgbdbwkkwOUiIOI2wGpxk7tZSROOwXePXlBdB4DxVqknJsZ2
         Qz2WHGC5/+D8KIFhFV27IOqwbe+HRyo5WjbEU3KsVfBG8Md/cYV9isUXRSUUqt2MbzZU
         RBZoCCh5EimqS5vV+DXux/NzwhPTVxwEIvMF6jPx8tntztGtoOsfSVQBKEZb+oGaqpJz
         iL5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtdvE8S/OfznNsxAa6hbhNKuBXRIKeE2RcfNTvgxQ1SWVEgCw+wB00B8qmT9GaqeI2uGrlRrwoWdXwXcop@vger.kernel.org, AJvYcCWJ7ceI0+PjRl8Xu877ylIM1GUdKFlJYv8wokhYfArD3DsOkWxvFiqZRlPwiZ6zs1g1JxYxsMsHOrS4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eZvuNiRkl05GArYWfsNXr2/FdqFve6z/k7L2jTGZarVPF2EG
	TxfMZw5TOeyvW9mtdZC6M7D+al1UcVL2dGgZUFS75V2bwyCfEnva
X-Google-Smtp-Source: AGHT+IGlAuOy5Ee+KlPIjyI5zGA34QpYY9um2MLp/eOjFZjLm6TIr3sdgpdBqjzdQDG2YD8UAx5R4Q==
X-Received: by 2002:ac2:4c55:0:b0:53a:40e:d54e with SMTP id 2adb3069b0e04-53b348b97b6mr5562259e87.4.1730189362732;
        Tue, 29 Oct 2024 01:09:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd? (p200300f6ef1521002c2bbcc5835ec2dd.dip0.t-ipconnect.de. [2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431b437d362sm18232865e9.0.2024.10.29.01.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:09:22 -0700 (PDT)
Message-ID: <51afb385d291d27ea4e5d8b1f5f3389573b119d5.camel@gmail.com>
Subject: Re: [PATCH v9 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
	 <broonie@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>
Date: Tue, 29 Oct 2024 09:13:42 +0100
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-4-f6960b4f9719@kernel-space.org>
References: 
	<20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	 <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-4-f6960b4f9719@kernel-space.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-28 at 22:45 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
>=20
> Then, a series of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Hi Angelo,

Small stuff that Jonathan might be able to change while applying... With th=
at:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 256 +++++++++++++++++++++++++++++++=
++++++++--
> -
> =C2=A01 file changed, 242 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 04193a98616e..155d04ca2315 100644
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
> AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE	(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
> +						 AXI_DAC_CUSTOM_CTRL_STREAM)
> =C2=A0
> =C2=A0/* DAC Channel controls */
> =C2=A0#define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> @@ -63,12 +82,21 @@
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
> +struct axi_dac_info {
> +	unsigned int version;
> +	const struct iio_backend_info *backend_info;
> +	bool has_dac_clk;
> =C2=A0};
> =C2=A0
> =C2=A0struct axi_dac_state {
> @@ -79,9 +107,11 @@ struct axi_dac_state {
> =C2=A0	 * data/variables.
> =C2=A0	 */
> =C2=A0	struct mutex lock;
> +	const struct axi_dac_info *info;
> =C2=A0	u64 dac_clk;
> =C2=A0	u32 reg_config;
> =C2=A0	bool int_tone;
> +	int dac_clk_rate;
> =C2=A0};
> =C2=A0
> =C2=A0static int axi_dac_enable(struct iio_backend *back)
> @@ -471,6 +501,11 @@ static int axi_dac_data_source_set(struct iio_backen=
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
> @@ -528,6 +563,154 @@ static int axi_dac_reg_access(struct iio_backend *b=
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
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM_ENABL=
E);
> +}
> +
> +static int axi_dac_data_stream_disable(struct iio_backend *back)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> +}
> +
> +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 addr=
ess)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	if (address > FIELD_MAX(AXI_DAC_CUSTOM_CTRL_ADDRESS))
> +		return -EINVAL;
> +
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
> +
> +	switch (data->type) {
> +	case IIO_BACKEND_DATA_UNSIGNED:
> +		return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +					 AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_write_locked(struct iio_backend *back, u32 re=
g,
> +					u32 val, size_t data_size)

nit: this is actually unlocked and needs to be locked from the outside. So,
unlocked could be a better suffix. But more importantly is the extra call t=
o
iio_backend_get_priv(). We can just pass *st directly from the outer functi=
on.

> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 ival;
> +
> +	/*
> +	 * Both AXI_DAC_CNTRL_2_REG and AXI_DAC_CUSTOM_WR_REG need to know
> +	 * the data size. So keeping data size control here only,
> +	 * since data size is mandatory for the current transfer.
> +	 * DDR state handled separately by specific backend calls,
> +	 * generally all raw register writes are SDR.
> +	 */
> +	if (data_size =3D=3D sizeof(u16))
> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> +	else
> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> +
> +	ret =3D regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> +	if (ret)
> +		return ret;
> +
> +	if (data_size =3D=3D sizeof(u8))
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
> +				AXI_DAC_UI_STATUS_REG, ival,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) =3D=3D
> 0,
> +				10, 100 * KILO);
> +	if (ret =3D=3D -ETIMEDOUT)
> +		dev_err(st->dev, "AXI read timeout\n");
> +
> +	/* Cleaning always AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA */
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +}
> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
> +					u32 val, size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +
> +	guard(mutex)(&st->lock);
> +	return axi_dac_bus_reg_write_locked(back, reg, val, data_size);
> +}
> +

Also just realized that the above read()/write() functions could make more =
sense
in the patch making the device a "bus controller". But well, not that impor=
tant
I guess.

- Nuno S=C3=A1



