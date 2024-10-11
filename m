Return-Path: <linux-iio+bounces-10435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE0999EBB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AF7B239E7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF320ADDF;
	Fri, 11 Oct 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nnuqvxtd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519820A5D9
	for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634079; cv=none; b=po7HK8hQDqujZ89gmtFZvH76mMst2rF3o6Ha4LvgGkePNwCnMK97LdXpmHFUuWzAU0Z/1FBO03Y0XjmBsj3u4ijmpVv4zgpWEMEEbZVcO21nyGcgmzFuXYWJE5qDVeaEwE95M/8tZkSeiJ52CuNSKT1Z+TDs9HARSWtBHewXLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634079; c=relaxed/simple;
	bh=7ftOlJC1PtwoD9F01QWr+UAlvSzlPJQuPxb9pqcTnsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyHSoVLCfq4dY+etf5ygF6SW84TKyFSqSEzGQw9goZp8DrVVdG+Ld4XUx05+OWqahPDHxOrJ9LtI3V/GuOvaLqhK0dlhr2wnX+mgLyiZVN1WaX1BoKIP/PvTizy2P4j1XcczHrWIh79n4aHXoYcVJ1grFSQKn0YyPW8+KRkkK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nnuqvxtd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43120f65540so981505e9.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2024 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728634074; x=1729238874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vIaEQc/8vBhlzJfOx2+dGd0buFxvNNtQA/s3X/88a6A=;
        b=nnuqvxtdrqK3NXFxhIUQw4UXgTBp0KB6iCTSp+mp9AvLSPEH0nJtCjeC2q2O+PmcoI
         MViRT/7h+NLhZP3x2XsJlyZhaRZneApkQ7Uvn2U4fn99z+tUgFah6KxkICxTuldLYs1f
         KdYFMAH9UMzI67kzaJxIRwIaUlMXWBWiM3eqfsKYx15Y6DVt4bU+Bob4Ss14C2ZHEeqC
         a9xXVPYN8jxtW8aXn850hrpV6hvnTThtJBk83e76xeV/KfB4A3x3xvNyAvhXhi7sFM8T
         E7F3YH6h4zWSM7FOYg8jZfVeCE7naMuQwSM7fkhbB9Ftq7S1cul3pe0AP3iU5qwjhf7B
         sV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728634074; x=1729238874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIaEQc/8vBhlzJfOx2+dGd0buFxvNNtQA/s3X/88a6A=;
        b=tmCJmVWpFCMo6759MNYg9IdHodeaE6E8XxzvlSkpwaW8YFZ8XHIBs1Fb9JPUGHgNZR
         GgKWtWAOerwc+dvgPWL3ZEaWALVaEqajMHhKfPAUVS/i/QOJz7PdL4j87qmPucnW77y/
         6/ofCi1qdKTVNPPTrBGzFjaIv7PzXeAWxxsGw955oy5MGb6fP42fnBEvcJx+jpbPg+g+
         cG+bRHn4ntklDaUQ1zp4+MbeDZPxI93kKaUHseOxu1ttdRLm5pEhGGZHkAJPqVne+p5D
         wVU6vevANPTe+GJtiVlC4hYGYnZA7kqEGDzF+j3FCBEv1DzSpZBSNN+38UBxg3C7FiKw
         PrVA==
X-Forwarded-Encrypted: i=1; AJvYcCXQPymjNJeyUMenVPb8q8XW+x9lhOsUvu9kXjfmhkaMXoHagBdCtsYct1gOZ4bvnvgeOt+X1eSGECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPV/dSmxzAeTOQ9v6CGxlrHeekbY3qQQl5znLdFG2BPz1I6/f6
	ABo8Tm2O2l46UWSo9398q8XlPA1j8rxKlriYNyW/6+K+AQ/Vnjl4blod65v9S7U=
X-Google-Smtp-Source: AGHT+IHuIE86BSl8AWPzS1jE9ZhGa+A9OBx8PYLXJ4/H7ERLu5EwwnPKHyY21NQoLs0HxqbHizvATg==
X-Received: by 2002:a05:600c:1f8e:b0:428:1b0d:8657 with SMTP id 5b1f17b1804b1-4311df5ac41mr10314135e9.22.1728634073815;
        Fri, 11 Oct 2024 01:07:53 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a881bsm3343446f8f.16.2024.10.11.01.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:07:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:06:32 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 06/10] iio: dac: adi-axi-dac: extend features
Message-ID: <iu27yjjqt3fpd46uum4hr3yb642cueesjda5k2zvjaq2vx2i57@lztomcj4esfo>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-6-3d410944a63d@baylibre.com>
 <11b397492cd6c20876e3eb6a2d89173c0dfcbc70.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11b397492cd6c20876e3eb6a2d89173c0dfcbc70.camel@gmail.com>

On 10.10.2024 15:20, Nuno Sá wrote:
> On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Extend AXI-DAC backend with new features required to interface
> > to the ad3552r DAC. Mainly, a new compatible string is added to
> > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > IP but with some customizations to work with the ad3552r.
> > 
> > Then, a serie of generic functions has been added to match with
> > ad3552r needs. Function names has been kept generic as much as
> > possible, to allow re-utilization from other frontend drivers.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> 
> Just some minor stuff. Not seeing any fundamental issue with this patch.
> 
> >  drivers/iio/dac/adi-axi-dac.c | 285 ++++++++++++++++++++++++++++++++++++++++-
> > -
> >  1 file changed, 274 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> > index 04193a98616e..e43d0ecccb50 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -46,9 +46,28 @@
> >  #define AXI_DAC_CNTRL_1_REG			0x0044
> >  #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
> >  #define AXI_DAC_CNTRL_2_REG			0x0048
> > +#define   AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > +#define   AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> >  #define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > +#define   AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > +#define AXI_DAC_STATUS_1_REG			0x0054
> > +#define AXI_DAC_STATUS_2_REG			0x0058
> >  #define AXI_DAC_DRP_STATUS_REG			0x0074
> >  #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > +#define   AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > +#define   AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > +#define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > +#define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > +#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > +#define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > +#define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> > +
> > +#define
> > AXI_DAC_STREAM_ENABLE			(AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA | \
> > +						AXI_DAC_CUSTOM_CTRL_STREAM)
> >  
> >  /* DAC Channel controls */
> >  #define AXI_DAC_CHAN_CNTRL_1_REG(c)		(0x0400 + (c) * 0x40)
> > @@ -63,12 +82,27 @@
> >  #define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> >  #define   AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
> >  
> > +#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> > +
> >  /* 360 degrees in rad */
> >  #define AXI_DAC_2_PI_MEGA			6283190
> >  
> >  enum {
> >  	AXI_DAC_DATA_INTERNAL_TONE,
> >  	AXI_DAC_DATA_DMA = 2,
> > +	AXI_DAC_DATA_INTERNAL_RAMP_16BIT = 11,
> > +};
> > +
> > +enum {
> > +	AXI_DAC_BUS_TYPE_NONE,
> > +	AXI_DAC_BUS_TYPE_DDR_QSPI,
> > +};
> 
> Do we still need the above?
> 
> > +
> > +struct axi_dac_info {
> > +	unsigned int version;
> > +	const struct iio_backend_info *backend_info;
> > +	bool bus_controller;
> > +	bool has_dac_clk;
> >  };
> > 
> >  struct axi_dac_state {
> > @@ -79,9 +113,12 @@ struct axi_dac_state {
> >  	 * data/variables.
> >  	 */
> >  	struct mutex lock;
> > +	const struct axi_dac_info *info;
> > +	struct clk *clk;
> 
> Is it used?
> 
> >  	u64 dac_clk;
> >  	u32 reg_config;
> >  	bool int_tone;
> > +	int dac_clk_rate;
> >  };
> >  
> >  static int axi_dac_enable(struct iio_backend *back)
> > @@ -471,6 +508,11 @@ static int axi_dac_data_source_set(struct iio_backend
> > *back, unsigned int chan,
> >  					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
> >  					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> >  					  AXI_DAC_DATA_DMA);
> > +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> > +		return regmap_update_bits(st->regmap,
> > +					  AXI_DAC_CHAN_CNTRL_7_REG(chan),
> > +					  AXI_DAC_CHAN_CNTRL_7_DATA_SEL,
> > +					  AXI_DAC_DATA_INTERNAL_RAMP_16BIT);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -528,6 +570,186 @@ static int axi_dac_reg_access(struct iio_backend *back,
> > unsigned int reg,
> >  	return regmap_write(st->regmap, reg, writeval);
> >  }
> >  
> > +static int axi_dac_ddr_enable(struct iio_backend *back)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +
> > +	return regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +				 AXI_DAC_CNTRL_2_SDR_DDR_N);
> > +}
> > +
> > +static int axi_dac_ddr_disable(struct iio_backend *back)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +
> > +	return regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +			       AXI_DAC_CNTRL_2_SDR_DDR_N);
> > +}
> > +
> > +static int axi_dac_data_stream_enable(struct iio_backend *back)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +
> > +	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +			       AXI_DAC_STREAM_ENABLE);
> > +}
> > +
> > +static int axi_dac_data_stream_disable(struct iio_backend *back)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +
> > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_STREAM_ENABLE);
> > +}
> > +
> > +static int axi_dac_data_transfer_addr(struct iio_backend *back, u32 address)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +
> 
> We could add some validation for address with FIELD_MAX()
> 
> > +	/*
> > +	 * Sample register address, when the DAC is configured, or stream
> > +	 * start address when the FSM is in stream state.
> > +	 */
> > +	return regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				  AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > +				  FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > +				  address));
> > +}
> > +
> > +static int axi_dac_data_format_set(struct iio_backend *back, unsigned int ch,
> > +				   const struct iio_backend_data_fmt *data)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int err;
> > 
> 
> Not sure if I mentioned it already but please use 'ret' so it's consistent with
> what we have. But for this function, see below
> 
> > +	switch (data->type) {
> > +	case IIO_BACKEND_DATA_UNSIGNED:
> > +		err = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +					AXI_DAC_CNTRL_2_UNSIGNED_DATA);
> > +		if (err)
> > +			return err;
> > +		break;
> 		return regmap_clear_bits();
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> 
> remove the above...
> 
> > +}
> > +
> > +static int axi_dac_read_raw(struct iio_backend *back,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int err;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_FREQUENCY: {
> > +		int reg;
> 
> I would just declare it at top scope and remove {}. Otherwise...
> > +
> > +		if (!st->info->has_dac_clk)
> > +			return -EOPNOTSUPP;
> > +
> > +		/*
> > +		 * As from ad3552r AXI IP documentation,
> > +		 * returning the SCLK depending on the stream mode.
> > +		 */
> > +		err = regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> > +		if (err)
> > +			return err;
> > +
> > +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> > +			*val = st->dac_clk_rate / 2;
> > +		else
> > +			*val = st->dac_clk_rate / 8;
> > +
> > +		return IIO_VAL_INT;
> > +		}
> 
> ... does not look good
>  
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 val,
> > +				 size_t data_size)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int ret;
> > +	u32 ival;
> > +
> > +	if (data_size == 2)
> 
> nit: sizeof(u16)
> 
> > +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> > +	else
> > +		ival = FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> > +
> > +	ret = regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> > +	 * the data size. So keeping data size control here only,
> > +	 * since data size is mandatory for the current transfer.
> > +	 * DDR state handled separately by specific backend calls,
> > +	 * generally all raw register writes are SDR.
> > +	 */
> > +	if (data_size == 1)
> > +		ret = regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +				      AXI_DAC_CNTRL_2_SYMB_8B);
> > +	else
> > +		ret = regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +					AXI_DAC_CNTRL_2_SYMB_8B);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read_poll_timeout(st->regmap,
> > +				       AXI_DAC_CUSTOM_CTRL_REG, ival,
> > +				       ival &
> > AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > +				       10, 100 * KILO);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +}
> > +
> > +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
> > +				size_t data_size)
> > +{
> > +	struct axi_dac_state *st = iio_backend_get_priv(back);
> > +	int ret;
> > +	u32 ival;
> > +
> > +	/*
> > +	 * SPI, we write with read flag, then we read just at the AXI
> > +	 * io address space to get data read.
> > +	 */
> > +	ret = axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
> > data_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG,
> > ival,
> > +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) !=
> > +				AXI_DAC_UI_STATUS_IF_BUSY,
> > +				10, 100);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> > +}
> > +
> >  static const struct iio_backend_ops axi_dac_generic_ops = {
> >  	.enable = axi_dac_enable,
> >  	.disable = axi_dac_disable,
> > @@ -541,11 +763,29 @@ static const struct iio_backend_ops axi_dac_generic_ops
> > = {
> >  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
> >  };
> >  
> > +static const struct iio_backend_ops axi_ad3552r_ops = {
> > +	.enable = axi_dac_enable,
> > +	.read_raw = axi_dac_read_raw,
> > +	.request_buffer = axi_dac_request_buffer,
> > +	.data_source_set = axi_dac_data_source_set,
> > +	.ddr_enable = axi_dac_ddr_enable,
> > +	.ddr_disable = axi_dac_ddr_disable,
> > +	.data_stream_enable = axi_dac_data_stream_enable,
> > +	.data_stream_disable = axi_dac_data_stream_disable,
> > +	.data_format_set = axi_dac_data_format_set,
> > +	.data_transfer_addr = axi_dac_data_transfer_addr,
> > +};
> > +
> >  static const struct iio_backend_info axi_dac_generic = {
> >  	.name = "axi-dac",
> >  	.ops = &axi_dac_generic_ops,
> >  };
> >  
> > +static const struct iio_backend_info axi_ad3552r = {
> > +	.name = "axi-ad3552r",
> > +	.ops = &axi_ad3552r_ops,
> > +};
> > +
> >  static const struct regmap_config axi_dac_regmap_config = {
> >  	.val_bits = 32,
> >  	.reg_bits = 32,
> > @@ -555,7 +795,6 @@ static const struct regmap_config axi_dac_regmap_config =
> > {
> >  
> >  static int axi_dac_probe(struct platform_device *pdev)
> >  {
> > -	const unsigned int *expected_ver;
> >  	struct axi_dac_state *st;
> >  	void __iomem *base;
> >  	unsigned int ver;
> > @@ -566,15 +805,26 @@ static int axi_dac_probe(struct platform_device *pdev)
> >  	if (!st)
> >  		return -ENOMEM;
> >  
> > -	expected_ver = device_get_match_data(&pdev->dev);
> > -	if (!expected_ver)
> > +	st->info = device_get_match_data(&pdev->dev);
> > +	if (!st->info)
> >  		return -ENODEV;
> >  
> > -	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +	clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> >  	if (IS_ERR(clk))
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> >  				     "failed to get clock\n");
> >  
> > +	if (st->info->has_dac_clk) {
> > +		struct clk *dac_clk;
> > +
> > +		dac_clk = devm_clk_get_enabled(&pdev->dev, "dac_clk");
> > +		if (IS_ERR(dac_clk))
> > +			return dev_err_probe(&pdev->dev, PTR_ERR(dac_clk),
> > +					     "failed to get dac_clk
> > clock\n");
> > +
> > +		st->dac_clk_rate = clk_get_rate(dac_clk);
> > +	}
> > +
> >  	base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);
> > @@ -598,12 +848,13 @@ static int axi_dac_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> > ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
> > +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> > +		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
> >  		dev_err(&pdev->dev,
> >  			"Major version mismatch. Expected %d.%.2d.%c,
> > Reported %d.%.2d.%c\n",
> > -			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> > -			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> > -			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> > +			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> > +			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> > +			ADI_AXI_PCORE_VER_PATCH(st->info->version),
> >  			ADI_AXI_PCORE_VER_MAJOR(ver),
> >  			ADI_AXI_PCORE_VER_MINOR(ver),
> >  			ADI_AXI_PCORE_VER_PATCH(ver));
> > @@ -629,7 +880,8 @@ static int axi_dac_probe(struct platform_device *pdev)
> >  		return ret;
> >  
> >  	mutex_init(&st->lock);
> > -	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
> > +
> > +	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info,
> > st);
> >  	if (ret)
> >  		return dev_err_probe(&pdev->dev, ret,
> >  				     "failed to register iio backend\n");
> > @@ -642,10 +894,21 @@ static int axi_dac_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
> > +static const struct axi_dac_info dac_generic = {
> > +	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
> > +	.backend_info = &axi_dac_generic,
> > +};
> > +
> > +static const struct axi_dac_info dac_ad3552r = {
> > +	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
> > +	.backend_info = &axi_ad3552r,
> > +	.bus_controller = true,
> 
> Do we still need bus_controller?

actually still using it to create devices subnodes.
Will move it to the last patch.
 
> 
> - Nuno Sá
> 
> 

Regards,
  angelo

