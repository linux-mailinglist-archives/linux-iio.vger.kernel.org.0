Return-Path: <linux-iio+bounces-11667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DE9B74A5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8286D28683C
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B455146A63;
	Thu, 31 Oct 2024 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl7gayR8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828D146599;
	Thu, 31 Oct 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356547; cv=none; b=C9kxE+6PU9D/je5j2FBEqS22lN99DZEfnb+rpz2bzI0784kNVpwPBlZkRLwmmmQykpKCT4xKNeocrwYarlEohDaMmDzmeGT5z0Mz4jQONBqUOpO8jNPyrHSfHHZHJDPcasV+ZR+CuBZjfXJvEUjQ+PsqLqhi5MxAdulKsuOc4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356547; c=relaxed/simple;
	bh=q/59yFbh8SfsCt8UmgbjPvCb9jhhsN+B8fPlN0zgjvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXflqtoAE4Kl6hGsCyhqdi+w6Qb8kOoC4p/ABkHaBvVHZ+0EB7QCl93NrfSV5WIOjwVZQvvkCCOe7XlOVXGY6jyF1mfamCFR4BD/K4rZSySV25s/62RpqAy5UCT/y0L+dV2GRn7dudy7N4EWZcSHV45TBUTg+mDi8KjFd8tRz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl7gayR8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso407745f8f.0;
        Wed, 30 Oct 2024 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356543; x=1730961343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F75xPnob/0lWkFALsaz/alsMdiA7L3Oet9JH75Rjxo8=;
        b=Rl7gayR82iKBM5z/SWHUT4cFd4EYs0LIDnPy+5WRZVm9/xNkUdqn8/dtbUDIqjbybC
         AznOPqBesNpDWAhu0lF1kNZP5IicXl8j39a0eAvKuJT397nDKRsCBE1JhFb8agWNUGKa
         MqorGXHzwOAdMGVwu6rxtjXOH4QTSp8t3jndqrU38Pwe0t+DhBbg4uaol4VQpnJjwEOj
         GKbvdnIkRXAasF5nT6kqk6wDXo4KrTafWcI5Q6VcWUEWwALEujnnkYiiEAQiz7xT1e4k
         NI7OwS5rVXOQGNy6sDfqqXY/RGWMbLkhfYMwWGZBbJ1lbWO2BGiRQ76/tbZasn+8yhYH
         5aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356543; x=1730961343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F75xPnob/0lWkFALsaz/alsMdiA7L3Oet9JH75Rjxo8=;
        b=jkmSAirBSLnKlyE6YEXJ/Yo9hKzHsluDnaABiMxgiLq1HEbsdKGbCj2zC1yvJr52xq
         dRCFBiTCPrvgLZ1VZIn9oL1fqcZImSJfcyUOWRhnOvXl14b0Ys+1+ZHC1/tNnfKiUKx1
         UWOierdrmbAQR0xS8SfJgGce/0iy5YIC3cJMh9gbaWRtthSS5Up9mel7Vn/tawvfE+TS
         4umELItYOF8jyDTcZTLpuEV1wOu3ZOmk0ZilaT/FzOsbedYBSx7y73zjMA830ENqI4fm
         KIC9X1gFEqABrkH12frAOiVHz9qQ5L2cBMF1MVfABdsBUo+Fn/1lIDBg6keyeq+lQPIo
         FqGw==
X-Forwarded-Encrypted: i=1; AJvYcCURIP9tkE2sUqkHIKrZcK4feGi/GEkQeGwF/KCvnN1Y3IFLhI6Sim+QM0vcmFuJIVg2XHj27BroC4loRadP@vger.kernel.org, AJvYcCUlrYHa3DhE4rVruZ8trShS1wINM5YY/VxXC2aeI4X/JsdnSyuquoylMnXIxyh0mZjfuuIy04i7LWUo@vger.kernel.org, AJvYcCXiHtEDMIx1locUPCnoJbdN8eUMPVWFiBcozFCxQsxEnWzsjp657P1Pc6ApMNCt4iYzew4q2pvbJktw@vger.kernel.org
X-Gm-Message-State: AOJu0YwndX1DJ21DNdTLrGSOl8X9odUdQCf0ImztS4wRis2xwU67XdxO
	7T+TTmch6viATf63t6HloX9ShIhEJgBSiTZXeKv5aAmOnPTpq9xx
X-Google-Smtp-Source: AGHT+IETCRY2PNqng4xrGPPp//Zq9XZAJ4eH/XyOR+CwXOLr0jw/zWi6YLf9eBcejrRfprHEONGb7Q==
X-Received: by 2002:a05:6000:104a:b0:37d:2de4:d64 with SMTP id ffacd0b85a97d-38061162c32mr12281346f8f.35.1730356542457;
        Wed, 30 Oct 2024 23:35:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10ea7c2sm1063670f8f.57.2024.10.30.23.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:35:41 -0700 (PDT)
Message-ID: <2e343f2da60b8ad4da9f24d0d42a961abf2dc30f.camel@gmail.com>
Subject: Re: [PATCH v9 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com,  Mark Brown
 <broonie@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>
Date: Thu, 31 Oct 2024 07:35:41 +0100
In-Reply-To: <20241029211737.6486e0d6@jic23-huawei>
References: 
	<20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	 <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-4-f6960b4f9719@kernel-space.org>
	 <51afb385d291d27ea4e5d8b1f5f3389573b119d5.camel@gmail.com>
	 <20241029211737.6486e0d6@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 21:17 +0000, Jonathan Cameron wrote:
> On Tue, 29 Oct 2024 09:13:42 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-10-28 at 22:45 +0100, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend AXI-DAC backend with new features required to interface
> > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > IP but with some customizations to work with the ad3552r.
> > >=20
> > > Then, a series of generic functions has been added to match with
> > > ad3552r needs. Function names has been kept generic as much as
> > > possible, to allow re-utilization from other frontend drivers.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---=C2=A0=20
> >=20
> > Hi Angelo,
> >=20
> > Small stuff that Jonathan might be able to change while applying... Wit=
h that:
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 256 +++++++++++++++++++++++++++=
++++++++++++--
> > > -
> > > =C2=A01 file changed, 242 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-=
dac.c
> > > index 04193a98616e..155d04ca2315 100644
> > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > @@ -46,9 +46,28 @@
> > > =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > > +
> > > +#define
> > > AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE	(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA =
| \
> > > +						 AXI_DAC_CUSTOM_CTRL_STREAM)
> > > =C2=A0
> > > =C2=A0/* DAC Channel controls */
> > > =C2=A0#define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> > > @@ -63,12 +82,21 @@
> > > =C2=A0#define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0=
)
> > > =C2=A0
> > > +#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> > > +
> > > =C2=A0/* 360 degrees in rad */
> > > =C2=A0#define AXI_DAC_2_PI_MEGA			6283190
> > > =C2=A0
> > > =C2=A0enum {
> > > =C2=A0	AXI_DAC_DATA_INTERNAL_TONE,
> > > =C2=A0	AXI_DAC_DATA_DMA =3D 2,
> > > +	AXI_DAC_DATA_INTERNAL_RAMP_16BIT =3D 11,
> > > +};
> > > +
> > > +struct axi_dac_info {
> > > +	unsigned int version;
> > > +	const struct iio_backend_info *backend_info;
> > > +	bool has_dac_clk;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0struct axi_dac_state {
> > > @@ -79,9 +107,11 @@ struct axi_dac_state {
> > > =C2=A0	 * data/variables.
> > > =C2=A0	 */
> > > =C2=A0	struct mutex lock;
> > > +	const struct axi_dac_info *info;
> > > =C2=A0	u64 dac_clk;
> > > =C2=A0	u32 reg_config;
> > > =C2=A0	bool int_tone;
> > > +	int dac_clk_rate;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static int axi_dac_enable(struct iio_backend *back)
> > > @@ -471,6 +501,11 @@ static int axi_dac_data_source_set(struct iio_ba=
ckend
> > > *back, unsigned int chan,
> > > =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > =C2=A0					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > =C2=A0					=C2=A0 AXI_DAC_DATA_DMA);
> > > +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> > > +		return regmap_update_bits(st->regmap,
> > > +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > > +					=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > > +					=C2=A0 AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> > > =C2=A0	default:
> > > =C2=A0		return -EINVAL;
> > > =C2=A0	}
> > > @@ -528,6 +563,154 @@ static int axi_dac_reg_access(struct iio_backen=
d *back,
> > > unsigned int reg,
> > > =C2=A0	return regmap_write(st->regmap, reg, writeval);
> > > =C2=A0}
> > > =C2=A0
> > > +static int axi_dac_ddr_enable(struct iio_backend *back)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > +				 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > +}
> > > +
> > > +static int axi_dac_ddr_disable(struct iio_backend *back)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > > +}
> > > +
> > > +static int axi_dac_data_stream_enable(struct iio_backend *back)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM_E=
NABLE);
> > > +}
> > > +
> > > +static int axi_dac_data_stream_disable(struct iio_backend *back)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +				 AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> > > +}
> > > +
> > > +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 =
address)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	if (address > FIELD_MAX(AXI_DAC_CUSTOM_CTRL_ADDRESS))
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Sample register address, when the DAC is configured, or stream
> > > +	 * start address when the FSM is in stream state.
> > > +	 */
> > > +	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +				=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > +				=C2=A0 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > +				=C2=A0 address));
> > > +}
> > > +
> > > +static int axi_dac_data_format_set(struct iio_backend *back, unsigne=
d int ch,
> > > +				=C2=A0=C2=A0 const struct iio_backend_data_fmt *data)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +
> > > +	switch (data->type) {
> > > +	case IIO_BACKEND_DATA_UNSIGNED:
> > > +		return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > +					 AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int axi_dac_bus_reg_write_locked(struct iio_backend *back, u3=
2 reg,
> > > +					u32 val, size_t data_size)=C2=A0=20
> >=20
> > nit: this is actually unlocked and needs to be locked from the outside.=
 So,
> > unlocked could be a better suffix. But more importantly is the extra ca=
ll to
> > iio_backend_get_priv(). We can just pass *st directly from the outer fu=
nction.
>=20
> This naming always gets confusing. Are we naming the state, or what happe=
ns?
>=20
> A lockdep marking just inside the function can be used to make it obvious
> or the old __ prefix to say 'special, check the rules'.
>=20


Yeah, personally I would prefer the __ prefix...

- Nuno S=C3=A1



