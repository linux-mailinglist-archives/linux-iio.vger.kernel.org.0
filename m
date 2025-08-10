Return-Path: <linux-iio+bounces-22515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABCCB1FAD5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D384D1898E48
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192A26CE05;
	Sun, 10 Aug 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iic6ewxo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4033246787;
	Sun, 10 Aug 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840660; cv=none; b=RpLZYoK7YbAQroERzob2IPqXV4KFi6VDl82afcVVrgfe0yu7rD2YG/X/PWbopkJlcLtWrASE1GdbfpwWW58ZbI2cTafgUuxWbuVR2j2m6QStXvZBF4LKOEFWhgQCgzxA6/GMito239/Hkd8lOu2fbCBWJRSrUZO49FpfcJLOBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840660; c=relaxed/simple;
	bh=Hne6qwxJ4KYkirc6n+j6KNnWgG/jNvNCJiD/yQhYjSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYH8AWkiVTCeclvzqrodIEfJF7jDjlpiEGVPoD3wCWZNjodD+8g1B8HJUOyBynQQw/a9fGHhGV73f/0Cns8rcZ4DsCXdCRkJKQx3UexnJaUTZs8u9Xhmk3qTaXCLEiyzzUupYPg5azU943b5vC97ObTYbmLJGtOaRP9FsjOD6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iic6ewxo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so3418845a91.3;
        Sun, 10 Aug 2025 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840658; x=1755445458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBIWANbCSNqX3PB3qnnw7IYaFXCa8H4jpKX9qPWWwF4=;
        b=iic6ewxo6AtwVkqNV1auf8YIYJp93JBJXOX3xcaUiZ4N6KTGPuhkPmSzi9+a2AsYNV
         wds+T6wizJNF+62VMO3bPhIeAu44/oWbXdSysAeZXN3CuULyVxGkaJAQ8tJfY40+mDxZ
         ewUVZ8f1QqbQ8AU79L/Hfdir3R+5+fRQPWaj1E8zwURZA18mv0rCDYtF6YXtEe5gpzP/
         Qh+PGAXKF/oOReHN+1EhIEuzFXhpc691IWwxBOKSEyxVPkxq3tuEBzz8o1E0Cn1XQFx1
         RODiDepOPbwK+d0csaIb0p7EEgXt9vHxRJKTt9Bhg0cmzbQaz/kmfr6BPhcCePvodnoN
         6ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840658; x=1755445458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBIWANbCSNqX3PB3qnnw7IYaFXCa8H4jpKX9qPWWwF4=;
        b=qT2mSj1ymmembTNVUZ/FNhByg7oMh8zJ/x3bGsWYVpc09Se03LcHXpHKsoOjC5BMzX
         5wCU0gjJ/ONV80HHS1D9jwnelqW0X1LmKQEwM9j9eOMTvMaB1RFymZON1b4vkoZwlxIT
         MWzfybwpmZJNthNdfxxoNsKrCpTZKJe6+cb2sqaLUPDkp0MsRHGUmbWukAd4bniOUkZm
         sefYHZvmFSdWToqPBkYG4E8PVFKmN1tfgiyIWhWVHIAnG6kfErk8NPIQTUJov3dIse2R
         AZFpskZreJFYFWcIZVzOr02e0fvFZ1pr3L3IaFvmuyR5y+H6Q2UpXtbv75bv8uytgFn5
         rwfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQbcibUjDPVJ13fPyid3p3niIXdoTOSzoUV77SAWG7ZAPpPvtImPfl9YWDIT5Wv+qaTH571HD4lcJn@vger.kernel.org, AJvYcCWILV/8ozuqFYIPArkRYACC/6kLGjjzckHJqQJhV+ZNamTYMaA8PkP5gCqq6h9OFlh4ujaqxYBQD8vH@vger.kernel.org, AJvYcCWnQVnayt46ePTfKcj7yFJibHNT0Cox+9oVee2jsGMsjmBX42FC8+BsdM+9kN2xgvLozn3hnzvbx06kOnRx@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUhfn/b2qb9E9yU90KSWD6ilQEbNYZVkH68vKyTWsHlDq+KXK
	g0Uhn816ikXlL2F51j612pJQLkhJyho+yaBoxyp3ZyMHvX92BXBRNSXR
X-Gm-Gg: ASbGncuBfmWJSmVF2Rx39ZkTKS2FvxV6REls2hK1h3YeI3osa/NDukshuPk3AY7we4m
	N2V2r0nAIlYbwX3is8WeRr8fmE+knohCyUJKDLV5jc2LqJDjaCTLpXoAr2s8wyOJVXGJ3Y2COtW
	68B10xBocdRn+SVDnlrZw2fDwUjdTRWbwYUN385pJ29zcrBTjqInlCXci8d9hacA2+LnUxafVZS
	4xWi53lQRDiWXazPhuUIN/muksHayRyBN0l2wpX7TjRPbKxWjWZNMMrzxd1ooEy+loVwcRBBL8b
	cTelxD9FRKN+oxIzUFdZPACHDVKHbqnR+ZZHevT5NO+X5+eQVrBZ3jLUNkEhJ0Pw+QTCHROAlxl
	B17UJe4w6eY+cYH0xsTnxrzE9/TidomE=
X-Google-Smtp-Source: AGHT+IFoChiIoUOXeobw7QT0kPBjnTuVIMmkErksIaCZsvi/RYO/yJiAhEHEmHEe1v6BMFVmpZ83SQ==
X-Received: by 2002:a17:90b:2b4f:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-32183a05009mr15818432a91.15.1754840658091;
        Sun, 10 Aug 2025 08:44:18 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32161282b5esm12666144a91.27.2025.08.10.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 08:44:17 -0700 (PDT)
Date: Sun, 10 Aug 2025 12:44:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: add ade9000 support
Message-ID: <aJi-YCsgepj0GLip@debian-BULLSEYE-live-builder-AMD64>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808141020.4384-4-antoniu.miclaus@analog.com>

Hi Antoniu,

Similarly to Nuno, I'm also getting into review only in v3 and may be missing
remarks made in previous iterations. Also, this driver is extensive and for now,
I only reviewed a few things (mostly register definitions and clock setup).
I agree with somebody's suggestion I've seen about splitting the code into more
patches according to the features that are going to be supported.
More comments inline.

On 08/08, Antoniu Miclaus wrote:
> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
...
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1c6ca5fd4b6d..98876d1ea8bf 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7173) += ad7173.o
> +obj-$(CONFIG_ADE9000) += ade9000.o
>  obj-$(CONFIG_AD7191) += ad7191.o
>  obj-$(CONFIG_AD7192) += ad7192.o
>  obj-$(CONFIG_AD7266) += ad7266.o
> @@ -46,6 +47,7 @@ obj-$(CONFIG_AD7944) += ad7944.o
>  obj-$(CONFIG_AD7949) += ad7949.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AD9467) += ad9467.o
> +obj-$(CONFIG_ADE9000) += ade9000.o
Duplicated addition to into Makefile?

>  obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
>  obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..a05327119128
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c
> @@ -0,0 +1,2033 @@
...
> +
> +/* Address of ADE9000 registers */
> +#define	ADE9000_REG_AIGAIN		0x000
> +#define	ADE9000_REG_AVGAIN		0x00B
> +#define	ADE9000_REG_AIRMSOS		0x00C
> +#define	ADE9000_REG_AVRMSOS		0x00D
> +#define	ADE9000_REG_APGAIN		0x00E
> +#define	ADE9000_REG_AWATTOS		0x00F
> +#define	ADE9000_REG_AVAROS		0x010
> +#define	ADE9000_REG_AFVAROS		0x012
> +#define	ADE9000_REG_CONFIG0		0x060
> +#define	ADE9000_REG_DICOEFF		0x072
> +#define	ADE9000_REG_AI_PCF		0x20A
> +#define	ADE9000_REG_AV_PCF		0x20B
> +#define	ADE9000_REG_AIRMS		0x20C
> +#define	ADE9000_REG_AVRMS		0x20D
> +#define	ADE9000_REG_AWATT		0x210
> +#define	ADE9000_REG_AVAR		0x211
> +#define	ADE9000_REG_AVA			0x212
> +#define ADE9000_REG_AFVAR		0x214
> +#define	ADE9000_REG_APF			0x216
> +#define	ADE9000_REG_BI_PCF		0x22A
> +#define	ADE9000_REG_BV_PCF		0x22B
> +#define	ADE9000_REG_BIRMS		0x22C
> +#define	ADE9000_REG_BVRMS		0x22D
> +#define	ADE9000_REG_CI_PCF		0x24A
> +#define	ADE9000_REG_CV_PCF		0x24B
> +#define	ADE9000_REG_CIRMS		0x24C
> +#define	ADE9000_REG_CVRMS		0x24D
> +#define	ADE9000_REG_AWATT_ACC		0x2E5
> +#define ADE9000_REG_AWATTHR_LO		0x2E6
Some defines are using tabs before the define name, others are using spaces.
I would standardize to have one space after each '#define' but I guess it's
also okay if you use all tabs.

> +#define ADE9000_REG_AVAHR_LO		0x2FA
> +#define ADE9000_REG_AFVARHR_LO		0x30E
> +#define ADE9000_REG_BWATTHR_LO		0x322
> +#define ADE9000_REG_BVAHR_LO		0x336
> +#define ADE9000_REG_BFVARHR_LO		0x34A
...
> +
> +/* Disable all interrupts except EGYRDY */
> +#define ADE9000_MASK0			0x00000001
Can we have more suggestive names for the masks?
If this disables all interrupts except EGYRDY, would it be reasonable to call it
ADE9000_EGYRDY_INT_MASK or ADE9000_MASK0_EGYRDY_MASK (or something that hints
about that interrupt)?
By the way, to me, this almost looks more like a constant than a mask.
Does it become clearer that these are masks if we define them with BIT macro?
#define ADE9000_MASK0_EGYRDY_MASK		BIT(0)   ?

> +
> +/* Disable all interrupts */
> +#define ADE9000_MASK1			0x00000000
Same suggestion would apply here although this really looks like a constant.
ADE9000_MASK1_INT_DISABLE maybe?

> +
> +/* Events disabled */
> +#define ADE9000_EVENT_MASK		0x00000000
I would call these predefined values just constants and drop the mask part of
the name.

> +
> +/*
> + * Assuming Vnom=1/2 of full scale.
> + * Refer to Technical reference manual for detailed calculations.
> + */
> +#define ADE9000_VLEVEL			0x0022EA28
> +
...
> +
> +static unsigned long ade9000_clkout_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	/* CLKOUT provides the same frequency as the crystal/external clock */
> +	return parent_rate ? parent_rate : 24576000; /* Default 24.576 MHz */
This value is a data sheet constant and is used twice in the driver. Does it
make sense to have a define for it?
#define ADE9000_DEFAULT_CLK_FREQ_HZ		24576000   ?

> +}
> +
> +static const struct clk_ops ade9000_clkout_ops = {
> +	.prepare = ade9000_clkout_prepare,
> +	.unprepare = ade9000_clkout_unprepare,
> +	.recalc_rate = ade9000_clkout_recalc_rate,
> +};
...
> +
> +static int ade9000_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ade9000_state *st;
> +	struct regmap *regmap;
> +	int irq;
> +	int ret;
...
> +
> +	/* Optional external clock input */
> +	st->clkin = devm_clk_get_optional_enabled(dev, "clkin");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(dev, PTR_ERR(st->clkin), "Failed to get and enable clkin: %ld", PTR_ERR(st->clkin));
> +
> +	/* Register clock output provider */
If I'm correctly reading ADE9000 data sheet, CLKOUT will have one of the
connections to the external crystal when a crystal is used. So, maybe condition
the clock provider feature to the supply of an external CMOS clock (not crystal)?
Also, the description of CLKIN pin gives me the impression that the device
requires an external clock input (either crystal or CMOS clock) so clkin would
not be optional.

> +	if (device_property_present(dev, "#clock-cells")) {
> +		struct clk_init_data clk_init = {};
> +		struct clk *clkout;
> +		unsigned long parent_rate = 24576000; /* Default crystal frequency */
> +
> +		if (st->clkin)
> +			parent_rate = clk_get_rate(st->clkin);
> +
> +		clk_init.name = "clkout";
> +		clk_init.ops = &ade9000_clkout_ops;
> +		clk_init.flags = CLK_GET_RATE_NOCACHE;
> +		clk_init.num_parents = 0;
> +
> +		st->clkout_hw.init = &clk_init;
> +
> +		clkout = devm_clk_register(dev, &st->clkout_hw);
> +		if (IS_ERR(clkout))
> +			return dev_err_probe(dev, PTR_ERR(clkout), "Failed to register clkout: %ld", PTR_ERR(clkout));
> +
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &st->clkout_hw);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to add clock provider: %d", ret);
> +	}

Best regards,
Marcelo

