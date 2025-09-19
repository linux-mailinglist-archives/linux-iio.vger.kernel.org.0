Return-Path: <linux-iio+bounces-24285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0DB89584
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CB4188F4A2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118E30E0EF;
	Fri, 19 Sep 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8zFlzSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB630DEBE
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283498; cv=none; b=BgHM+tmCxdFh3fxlzcOOet6rZ0UuYKs8Sk+i0jJVLiKsr0cSAuTbHdC5onso2XhzTMd1B1R21LrmeZEQDyERK7DNjs0+Zd0P4E9bcqAMx+aBuGRhsViK138mwcQ3cDN4rT1Sp9gryOS5ILmXQlEuQWuWC1ibm1uqD/Q+WvZzL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283498; c=relaxed/simple;
	bh=EB8AYT4J6/PsLC3tGdL7kRRWj4KO0Fz4Ds9m0A03ZaE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRmSdArGXuPqneMF/wm7gLInBnVFqSidqDA+SdEr7d9WcD40+OVtzLIRXYL6f585N3ALkPPUYQ+UpOv/lu1k6n+6ZZYKhBzrDBI4bQgvICQZwE3bUGXmtoCPwdw0EGJMgAsKnDcxGc9rXLYkEl4yVGTxmPXtifi3lEEQn+g5gh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8zFlzSH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so2254374a12.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758283494; x=1758888294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeAzKFjyyKPfuJHYBjM0s6bnRAAIWR4ZwXarS2/BZDg=;
        b=j8zFlzSHsU1RiMIYpjoLa6Ol3D4U1MQA8mslGn0MutnU2frU7nxIKGnYrcMJjkfw2n
         /v6QVXvs/7QID28CyOqi8GfHH+VjsiRsMzgx78YYPWPWQaCmSecSDTyxXozV9cOON9iI
         61tY6PIRXV1SOouLv2fVvpxFYBEO6//m+9IshTSRidWgHv/40b6XOW7pm4iDwPzzdbzz
         ZHlZSidGWvd39Ei2hOIbv8Q2Yo6qK1woiSIT1D10aVocQNwhm8U9nDmXtSwUdoorVn7A
         VHhdsJ753Bv4NQNLDeG6RqiPR6oDVQjGBvqGNx72EA8MLpMRF4LafAWwiwdvpONMyvu1
         n1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283494; x=1758888294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeAzKFjyyKPfuJHYBjM0s6bnRAAIWR4ZwXarS2/BZDg=;
        b=SKJjrLU3kEsAMcEyycjivqGOcHj//jX5FNKv4/7oe3CE3e7A9/R3b9oPdBs73lCfmh
         /+gHYw+1RHGKvv8McMrj4j3Zh5RvGT/WxjVGTAAzjAfg3HVGuy9UIzqV9dOBBei98PSC
         QUI3DNd7MDOoHd4lfFshMh41OEm6o3epBgR130RRs/KP+/ZcATYh5Botv0v8g735U4Ep
         7JwEHcmqE+uIcEaIPRgRem9j8NK9BVIcR0SG6Quiepee5ByG4K9xUpCTEO2Xm28XatM6
         0+Y7yIGJwXlifh7OQk7r5wWq8jaHCBpTJNf+y1vGgkzZ7osONTimbK4zLi7xbXuZNRVe
         foPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOEiqsXDC15g6FF4DUqXjmBYn2iOkWcsV4WFPK1z+Pw8vvYZPeiqNnDtqMwZ/dVYiM/CaNz2ZRk6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtUhljAgWE0EazwJ0GGYEB4X9S1XJyni9dbY1WbSGhcviDY/L
	JdwOWPJJWBHp8KRqxIpnvHbw+VwuSWMtcnbxDt62vGerY8XmvMRgcq2aV6GDxg==
X-Gm-Gg: ASbGnctzZcV5TYr57lkQotp8rZSJA0+oH6wgcxVKq9yJkbsJktoHWYZcGKhNGyx7T+b
	xZM8FbYsfvuJ00xNPRF1HANkiiMKRPUv65fSqYRfHqV9ScT5xkn6agrTQ7kzMcRgVNopCQe/JRC
	rIdA4biRalfIAAU9n3dYYD1UJOcXtN4DhRUynQf49GNLexs31VPkTurrkvLDcPcPYUM1gqDw2xH
	3R60u1l7LPSOAafpAwY24qTnMB1ZNjaQceZRyTbYznKa6Qz7tDSQ/GFIlbCY+lqyyAOU2OK+3c6
	adVg1XhiTBeBGZXEKE3ubAS6H4+RZIg9iA25u0MfMmEgpQw9tQVsL+JVec0hJf1O3q+AyxDtD6K
	nTXQbDPm3WmetAcYC7y/YgNM=
X-Google-Smtp-Source: AGHT+IHbGsaNdYDC1j310lz9PmLJTB3WHkcdt5HLCuK7xsP021Fr9KDqFDqq16xgF0nyj0Ljw5YJRQ==
X-Received: by 2002:a05:6402:3202:b0:62f:7e0e:c2ab with SMTP id 4fb4d7f45d1cf-62fc0a7cf2dmr2870263a12.19.1758283494112;
        Fri, 19 Sep 2025 05:04:54 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d437b1sm3218317a12.22.2025.09.19.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:04:53 -0700 (PDT)
Message-ID: <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt
 configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>, dan@dlrobertson.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 13:05:19 +0100
In-Reply-To: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Thanks for your patch.

On Fri, 2025-09-19 at 00:37 +0530, Akshay Jindal wrote:
> Refactor the generic interrupt configuration logic to improve readability
> and reduce repetitive code. Replace hard-coded register values with macro=
s
> and enums, making it clearer what configuration is written to hardware.
>=20
> Introduce a const struct to map event direction to the corresponding
> generic interrupt. This removes the need for switch statements in multipl=
e
> callbacks, including activity event setup, read_event_value, and
> write_event_value, while still performing the selection at runtime.
>=20
> This change has no functional impact but simplifies the code and makes it
> easier to maintain and extend in future updates.
>=20
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---

You may be trying to refactor too much in one single patch. I would maybe t=
hink
about splitting this into 2/3 logical changes.

> =C2=A0drivers/iio/accel/bma400.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 71=
 +++++++++++++++---
> =C2=A0drivers/iio/accel/bma400_core.c | 128 ++++++++++++++++-------------=
---
> =C2=A02 files changed, 125 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 932358b45f17..ab7d1d139b66 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -68,7 +68,19 @@
> =C2=A0#define BMA400_CMD_REG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7e
> =C2=A0
> =C2=A0/* Interrupt registers */
> -#define BMA400_INT_CONFIG0_REG	=C2=A0=C2=A0=C2=A0 0x1f
> +#define BMA400_INT_CONFIG0_REG			0x1f
> +#define BMA400_INT_CONFIG0_ORTN_CHG_MASK	BIT(1)
> +#define BMA400_INT_CONFIG0_GEN1_MASK		BIT(2)
> +#define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
> +#define BMA400_INT_CONFIG0_FIFO_FULL_MASK	BIT(5)
> +#define BMA400_INT_CONFIG0_FIFO_WTRMRK_MASK	BIT(6)
> +#define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
> +
> +enum generic_intr {
> +	GEN1_INTR,
> +	GEN2_INTR
> +};
> +
> =C2=A0#define BMA400_INT_CONFIG1_REG	=C2=A0=C2=A0=C2=A0 0x20
> =C2=A0#define BMA400_INT1_MAP_REG	=C2=A0=C2=A0=C2=A0 0x21
> =C2=A0#define BMA400_INT_IO_CTRL_REG	=C2=A0=C2=A0=C2=A0 0x24
> @@ -96,15 +108,53 @@
> =C2=A0#define BMA400_ACC_ODR_MIN_HZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
2
> =C2=A0
> =C2=A0/* Generic interrupts register */
> -#define BMA400_GEN1INT_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3f
> -#define BMA400_GEN2INT_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4A
> -#define BMA400_GEN_CONFIG1_OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x01
> -#define BMA400_GEN_CONFIG2_OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x02
> -#define BMA400_GEN_CONFIG3_OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x03
> -#define BMA400_GEN_CONFIG31_OFF=C2=A0=C2=A0=C2=A0=C2=A0 0x04
> -#define BMA400_INT_GEN1_MSK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(2)
> -#define BMA400_INT_GEN2_MSK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(3)
> -#define BMA400_GEN_HYST_MSK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 GENMASK(1, 0)
> +#define BMA400_GENINT_CONFIG_REG_BASE	0x3f
> +#define BMA400_NUM_GENINT_CONFIG_REGS	11
> +#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)	\
> +	(BMA400_GENINT_CONFIG_REG_BASE +		\
> +	(gen_intr) * BMA400_NUM_GENINT_CONFIG_REGS +	\
> +	(config_idx))

Not sure the above macro helps that much. More on this below...

> +
> +/* Generic Interrupt Config0 register */
> +#define BMA400_GENINT_CONFIG0_HYST_MASK			GENMASK(1, 0)
> +#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK		GENMASK(3, 2)
> +#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK		BIT(4)
> +#define BMA400_GENINT_CONFIG0_X_EN_MASK			BIT(5)
> +#define BMA400_GENINT_CONFIG0_Y_EN_MASK			BIT(6)
> +#define BMA400_GENINT_CONFIG0_Z_EN_MASK			BIT(7)
> +
> +enum bma400_hysteresis_config {
> +	NO_HYSTERESIS,
> +	HYSTERESIS_24MG,
> +	HYSTERESIS_48MG,
> +	HYSTERESIS_96MG
> +};
> +
> +enum bma400_accel_data_src {
> +	ACCEL_FILT1,
> +	ACCEL_FILT2
> +};
> +
> +enum bma400_ref_updt_mode {
> +	BMA400_REF_MANUAL_UPDT_MODE,
> +	BMA400_REF_ONETIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_LP_UPDT_MODE
> +};
> +
> +/* Generic Interrupt Config1 register */
> +#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK		BIT(0)
> +#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK		BIT(1)
> +
> +enum bma400_genintr_acceleval_axescomb {
> +	BMA400_EVAL_X_OR_Y_OR_Z,
> +	BMA400_EVAL_X_AND_Y_AND_Z,
> +};
> +
> +enum bma400_detect_criterion {
> +	BMA400_DETECT_INACTIVITY,
> +	BMA400_DETECT_ACTIVITY,
> +};
> =C2=A0
> =C2=A0/* TAP config registers */
> =C2=A0#define BMA400_TAP_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x57
> @@ -119,6 +169,7 @@
> =C2=A0#define BMA400_TAP_QUIETDT_MSK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMAS=
K(5, 4)
> =C2=A0#define BMA400_TAP_TIM_LIST_LEN=C2=A0=C2=A0=C2=A0=C2=A0 4
> =C2=A0
> +
> =C2=A0/*
> =C2=A0 * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> =C2=A0 * converting to micro values for +-2g range.
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_c=
ore.c
> index 85e23badf733..d59c26b8a57f 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -121,6 +121,29 @@ struct bma400_data {
> =C2=A0	__be16 duration;
> =C2=A0};
> =C2=A0
> +struct bma400_genintr_info {
> +	u8 genintr;
> +	unsigned int intrmask;
> +	enum iio_event_direction dir;
> +	enum bma400_detect_criterion detect_mode;
> +};
> +
> +/* Lookup struct for determining GEN1/GEN2 based on dir */
> +static const struct bma400_genintr_info bma400_genintrs[] =3D {
> +	[IIO_EV_DIR_RISING] =3D {
> +		.genintr =3D GEN1_INTR,	/* 0 for GEN1 */
> +		.intrmask =3D BMA400_INT_CONFIG0_GEN1_MASK,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.detect_mode =3D BMA400_DETECT_ACTIVITY,
> +	},
> +	[IIO_EV_DIR_FALLING] =3D {
> +		.genintr =3D GEN2_INTR,	/* 1 for GEN2 */
> +		.intrmask =3D BMA400_INT_CONFIG0_GEN2_MASK,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.detect_mode =3D BMA400_DETECT_INACTIVITY,
> +	}
> +};
> +
> =C2=A0static bool bma400_is_writable_reg(struct device *dev, unsigned int=
 reg)
> =C2=A0{
> =C2=A0	switch (reg) {
> @@ -1114,10 +1137,10 @@ static int bma400_read_event_config(struct iio_de=
v
> *indio_dev,
> =C2=A0	case IIO_ACCEL:
> =C2=A0		switch (dir) {
> =C2=A0		case IIO_EV_DIR_RISING:
> -			return FIELD_GET(BMA400_INT_GEN1_MSK,
> +			return FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK,
> =C2=A0					 data->generic_event_en);

Like the above is above renaming defines in a more logical name. Not going =
to
opinate whether this name is better or not but you could put that (and othe=
r
similar changes) in one patch.

> =C2=A0		case IIO_EV_DIR_FALLING:
> -			return FIELD_GET(BMA400_INT_GEN2_MSK,
> +			return FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK,
> =C2=A0					 data->generic_event_en);
> =C2=A0		case IIO_EV_DIR_SINGLETAP:
> =C2=A0			return FIELD_GET(BMA400_S_TAP_MSK,
> @@ -1159,59 +1182,50 @@ static int bma400_activity_event_en(struct bma400=
_data
> *data,
> =C2=A0				=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> =C2=A0				=C2=A0=C2=A0=C2=A0 int state)
> =C2=A0{
> -	int ret, reg, msk, value;
> -	int field_value =3D 0;
> -
> -	switch (dir) {
> -	case IIO_EV_DIR_RISING:
> -		reg =3D BMA400_GEN1INT_CONFIG0;
> -		msk =3D BMA400_INT_GEN1_MSK;
> -		value =3D 2;
> -		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(BMA400_INT_GEN1_MSK, state)=
);
> -		break;
> -	case IIO_EV_DIR_FALLING:
> -		reg =3D BMA400_GEN2INT_CONFIG0;
> -		msk =3D BMA400_INT_GEN2_MSK;
> -		value =3D 0;
> -		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(BMA400_INT_GEN2_MSK, state)=
);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	int ret, regval;
> +	u8 genintr =3D bma400_genintrs[dir].genintr;
> +	u8 detect_criterion =3D bma400_genintrs[dir].detect_mode;
> +	unsigned int intrmask =3D bma400_genintrs[dir].intrmask;
> =C2=A0

Hmm, you should still have the switch case. Again, not sure the const struc=
t
adds that much but I'm also fine with it. But I would do:

switch (dir) {
case IIO_EV_DIR_RISING:
case IIO_EV_DIR_FALLING:
	genintr =3D bma400_genintrs[dir].genintr;
	detect_criterion =3D bma400_genintrs[dir].detect_mode;
	intrmask =3D bma400_genintrs[dir].intrmask;
default:
	return -EINVAL;

> =C2=A0	/* Enabling all axis for interrupt evaluation */
> -	ret =3D regmap_write(data->regmap, reg, 0xF8);
> +	ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr,
> 0),
> +			=C2=A0=C2=A0 BMA400_GENINT_CONFIG0_X_EN_MASK |
> +			=C2=A0=C2=A0 BMA400_GENINT_CONFIG0_Y_EN_MASK |
> +			=C2=A0=C2=A0 BMA400_GENINT_CONFIG0_Z_EN_MASK|
> +			=C2=A0=C2=A0 BMA400_REF_EVERYTIME_UPDT_MODE);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* OR combination of all axis for interrupt evaluation */
> -	ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF,
> value);
> +	regval =3D FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK,
> BMA400_EVAL_X_OR_Y_OR_Z) |
> +		 FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK,
> detect_criterion);
> +	ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr,
> 1), regval);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* Initial value to avoid interrupts while enabling*/
> -	ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
> +	ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr,
> 2), 0x0A);

I do not think readability is improved here. The former is way easier to re=
ad
IMO. Also, we still have the magic 0x0A.

> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* Initial duration value to avoid interrupts while enabling*/
> -	ret =3D regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,
> 0x0F);
> +	ret =3D regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr,
> 4), 0x0F);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
> -				 field_value);
> +	regval =3D FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state);
> +	if (genintr)
> +		regval =3D FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state);
> +
> +	ret =3D regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, intrmask,
> regval);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
> -				 field_value);
> +	ret =3D regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> intrmask, regval);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	set_mask_bits(&data->generic_event_en, msk, field_value);
> +	set_mask_bits(&data->generic_event_en, intrmask, regval);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -1336,18 +1350,6 @@ static int bma400_write_event_config(struct iio_de=
v
> *indio_dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int get_gen_config_reg(enum iio_event_direction dir)
> -{
> -	switch (dir) {
> -	case IIO_EV_DIR_FALLING:
> -		return BMA400_GEN2INT_CONFIG0;
> -	case IIO_EV_DIR_RISING:
> -		return BMA400_GEN1INT_CONFIG0;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> =C2=A0static int bma400_read_event_value(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> =C2=A0				=C2=A0=C2=A0 enum iio_event_type type,
> @@ -1356,22 +1358,20 @@ static int bma400_read_event_value(struct iio_dev
> *indio_dev,
> =C2=A0				=C2=A0=C2=A0 int *val, int *val2)
> =C2=A0{
> =C2=A0	struct bma400_data *data =3D iio_priv(indio_dev);
> -	int ret, reg, reg_val, raw;
> +	int ret, genintr, reg_val, raw;
> =C2=A0
> =C2=A0	if (chan->type !=3D IIO_ACCEL)
> =C2=A0		return -EINVAL;
> =C2=A0
> =C2=A0	switch (type) {
> =C2=A0	case IIO_EV_TYPE_MAG:
> -		reg =3D get_gen_config_reg(dir);
> -		if (reg < 0)
> -			return -EINVAL;
> +		genintr =3D bma400_genintrs[dir].genintr;

Again you should make sure dir is valid. You could keep get_gen_config_reg(=
) and
do something similar with what I suggested above.

> =C2=A0
> =C2=A0		*val2 =3D 0;
> =C2=A0		switch (info) {
> =C2=A0		case IIO_EV_INFO_VALUE:
> =C2=A0			ret =3D regmap_read(data->regmap,
> -					=C2=A0 reg + BMA400_GEN_CONFIG2_OFF,
> +					=C2=A0 BMA400_GENINT_CONFIG_REG(genintr,
> 2),
> =C2=A0					=C2=A0 val);
> =C2=A0			if (ret)
> =C2=A0				return ret;
> @@ -1379,7 +1379,7 @@ static int bma400_read_event_value(struct iio_dev
> *indio_dev,
> =C2=A0		case IIO_EV_INFO_PERIOD:
> =C2=A0			mutex_lock(&data->mutex);
> =C2=A0			ret =3D regmap_bulk_read(data->regmap,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg + BMA400_GEN_CONFIG3_OFF,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> BMA400_GENINT_CONFIG_REG(genintr, 3),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->duration,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(data->duration));
> =C2=A0			if (ret) {
> @@ -1390,10 +1390,12 @@ static int bma400_read_event_value(struct iio_dev
> *indio_dev,
> =C2=A0			mutex_unlock(&data->mutex);
> =C2=A0			return IIO_VAL_INT;
> =C2=A0		case IIO_EV_INFO_HYSTERESIS:
> -			ret =3D regmap_read(data->regmap, reg, val);
> +			ret =3D regmap_read(data->regmap,
> +					=C2=A0 BMA400_GENINT_CONFIG_REG(genintr,
> 0),
> +					=C2=A0 val);

One more case where I don't really think this macro is doing readability an=
y
better.

- Nuno S=C3=A1


