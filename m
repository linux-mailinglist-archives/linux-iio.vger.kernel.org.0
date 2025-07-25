Return-Path: <linux-iio+bounces-22013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6FDB11A26
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F645616CC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4E2BF014;
	Fri, 25 Jul 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl0QEFjv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E317D2;
	Fri, 25 Jul 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433079; cv=none; b=WceBF5wo9WozaHLcuVXmduTj3tcc0VmcAedJDDyH3vNl22Xt2vOYQuAmvXR6cd/m+XxezJRMxMBL24xyGDEGpyPh7QsIF0dTEgdX1PatltHuH4wRLzeuBYK8WsjsqQxxqqvvl863sZ7aJoXLLMbB6j35U7rZ7zpPdw5Jtifkh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433079; c=relaxed/simple;
	bh=v2vlE5uWbU1Puw8y8wPaxzo0Fzm793g1ZDrNAVqW0lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn5JQo4Ksst+HXP5ToKcLePN3bI3bfHQ95hAiYq59ZCoaWd3FPDQ+k4qsobBJYO1q9hDik/zqewNBfmL9B6o3g6T1Q7cZyFm1SoEuGOWDIcnVcRbprmJ5UqjKpQdINgQvRwbw4TEYugmSU3eYHLOX2IyqA/ZpXRDCSFhInJb+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl0QEFjv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so4166950a12.1;
        Fri, 25 Jul 2025 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753433075; x=1754037875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rG7isa9DnjNPqFBQJMevyeVveUJwhY7Mn6J7Kotx83E=;
        b=cl0QEFjv1x5T+FL5FAFNSrWcpZf+barPGUmljGAbWrnBEPUCyXB68sgDsHgf40IQGm
         yFSAgLzc/fq3yetCZ2tnAYkMIbUQ+M9R79pcYtVnGWVpV0NSjOszEVhfSfvzIWNaQJd0
         I2/D814MgXZlPHjjWYD9EIW9WdSBH8IUmf6i4crBBTUbxFRWrXGB5iDFdwIalOedJ/Zd
         AAlpPE6BBw+sojcLLCKJe+gUpmkIMzYt+LgIkWlv27a5PDgqTQgPNLK/AZx+POZudLEQ
         fmMH0H8iB4d2KuYSegxqDP5RAe7rjXeOBgQ7v3t52bkO8wpl0nAnAwbEgjJzxCdcbnsd
         nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433075; x=1754037875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG7isa9DnjNPqFBQJMevyeVveUJwhY7Mn6J7Kotx83E=;
        b=iZ2HiQdeJDxDiGEzCYFoLv4HYeQ0E6ymYNGDbwpICi22pbzUIrkCdvFI8K0IJmkul1
         YRh414BZWy+QXhtCqCJRf/YUITp3/sDPNZRly1MMLGVxFI13huJNnXF+7yfkLQQ4bveB
         97tgT+P/aM300T8n0OhSej3peaQvGU9UqQKLNlCs+8xHHP+j5A4sUosfCwKcjoCgJFZh
         QOoPdZHjUk9ThGEkYWQv7HpsuJ6z4OkVAgZf1ei1/Vt1xi6TUcZBLlvUXXnWNTaQksnd
         EXLA49XF1PXGiVNwzKWR9qfmTHkzT/OOpULJJsLrFSOzeFc87ilI8gNMDkUtC5ieAvDs
         blHA==
X-Forwarded-Encrypted: i=1; AJvYcCXiKKaSTIenr6TLDRpOUrNubVhVrM9rZVRxYSOpHYfepDgGVZ5qlcNzAhiMzS0id2kPhFeVmhccTNY=@vger.kernel.org, AJvYcCXuTIrxdkHVamrmglgSocZBlJGzB1IXGXUgLLHs9nbYqvOLp7L5zt/5KEWBrDPkGwNeRyBr7I1xqsn3flSA@vger.kernel.org
X-Gm-Message-State: AOJu0YxARPBGpKiDmyV0OdMrb9ralpgmykcG6kyyLwRWpzck8JaJ2HR7
	AjtlrpD4lL3fUqD/W/qpqiH+o9iKNwCqU0E9momTJKnEVclNHRG21Phv
X-Gm-Gg: ASbGncvnXWEWswkO/LDNyZ4AIRqssn8RuSQ2a4WwLclXVZuwOzCJyA6zoOrdYvX9NGx
	Deivv/oT334tZOxeSmxzdoat98kdibjrROUW7MFUGIJtC6XB3xdgcljyX7P/gfHUblEovw4NaAz
	a9mrJegqaXQufkdlWamBktSg12IgMgWS3VOGx3GFzyee9T4I4jULFtSWrOcFbD1cQqhO7XzXudc
	ymVtBicD+BiUZv1SbwUGf57gsqd4tPDrSCw4Dxqjfn/QQ+eBz+FT6qFZq5D30NfvVTYsQ6aP3L3
	/MaJbaMI2TxkiulpQpK4cToDA7YwuHgysLSyQ5fHSvYPeIce4rUqtoPPXpC4uZFspO/uBfzm0/h
	U6iCiUrPRl1gaFjdXKGCmZ4g=
X-Google-Smtp-Source: AGHT+IEzTIo4aLymcS+GMCx+IwML2PygqRMBBI0YfPS8QeKR++dF6Hdme/PQWGF7hx4qly2irjGwHw==
X-Received: by 2002:a05:6402:50cb:b0:607:2e08:f3e6 with SMTP id 4fb4d7f45d1cf-614f05f6207mr1088580a12.17.1753433074935;
        Fri, 25 Jul 2025 01:44:34 -0700 (PDT)
Received: from nsa ([95.214.217.20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd336253sm1878476a12.65.2025.07.25.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:44:34 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:44:48 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: ad7173: support changing filter type
Message-ID: <evxvva62zqwusoizcoeds6bojjdc4z5chtdeaikaxuliftvfde@xuctkxp45437>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
 <20250710-iio-adc-ad7137-add-filter-support-v1-3-acffe401c4d2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-3-acffe401c4d2@baylibre.com>

On Thu, Jul 10, 2025 at 05:39:52PM -0500, David Lechner wrote:
> Add support for changing the filter type to the ad7173 driver.
> 
> This family of chips by default uses a sinc5+sinc1 filter. There are
> also optional post-filters that can be added in this configuration for
> various 50/60Hz rejection purposes. The sinc3 filter doesn't have any
> post-filters and handles the output data rate (ODR) a bit differently.
> Here, we've opted to use SINC3_MAPx to get the maximum possible
> sampling frequencies with the SINC3 filter.
> 
> Adding support consists of adding the filter_type and
> filter_type_available attributes, making the sampling_frequency
> attribute aware of the filter type, and programming the filter
> parameters when we configure the channel of the ADC for reading
> a sample.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7173.c | 186 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 181 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 01d78d531d6c024dd92fff21b8b2afb750092b66..c235096fbad4aeb77a7385001a16bc0ecd603f46 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -8,6 +8,7 @@
>   *  AD7175-8/AD7176-2/AD7177-2
>   *
>   * Copyright (C) 2015, 2024 Analog Devices, Inc.
> + * Copyright (C) 2025 BayLibre, SAS
>   */
>  
>  #include <linux/array_size.h>
> @@ -149,7 +150,12 @@
>  					       (pin2) < st->info->num_voltage_in && \
>  					       (pin2) >= st->info->num_voltage_in_div)
>  
> -#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
> +#define AD7173_FILTER_SINC3_MAP		BIT(15)
> +#define AD7173_FILTER_SINC3_MAP_DIV	GENMASK(14, 0)
> +#define AD7173_FILTER_ENHFILTEN		BIT(11)
> +#define AD7173_FILTER_ENHFILT_MASK	GENMASK(10, 8)
> +#define AD7173_FILTER_ORDER		BIT(6)
> +#define AD7173_FILTER_ODR_MASK		GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS		8
>  #define AD4111_OW_DET_THRSH_MV		300
>  
> @@ -190,6 +196,15 @@ struct ad7173_device_info {
>  	u8 num_gpios;
>  };
>  
> +enum ad7173_filter_type {
> +	AD7173_FILTER_SINC3,
> +	AD7173_FILTER_SINC5_SINC1,
> +	AD7173_FILTER_SINC5_SINC1_PF1,
> +	AD7173_FILTER_SINC5_SINC1_PF2,
> +	AD7173_FILTER_SINC5_SINC1_PF3,
> +	AD7173_FILTER_SINC5_SINC1_PF4,
> +};
> +
>  struct ad7173_channel_config {
>  	/* Openwire detection threshold */
>  	unsigned int openwire_thrsh_raw;
> @@ -205,8 +220,10 @@ struct ad7173_channel_config {
>  	struct_group(config_props,
>  		bool bipolar;
>  		bool input_buf;
> +		u16 sinc3_ord_div;

typo? ord -> odr?

>  		u8 sinc5_odr_index;
>  		u8 ref_sel;
> +		enum ad7173_filter_type filter_type;
>  	);
>  };
>  
> @@ -266,6 +283,24 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
>  	5000,					/* 20    */
>  };
>  
> +/**
> + * ad7173_sinc3_ord_div_from_odr() - Convert ODR to divider value
> + * @odr_millihz: ODR (sampling_frequency) in milliHz
> + * Returns: Divider value for SINC3 filter to pass.
> + */
> +static u16 ad7173_sinc3_ord_div_from_odr(u32 odr_millihz)

same typo in the func name?

> +{
> +	/*
> +	 * Divider is f_MOD (1 MHz) / 32 / ODR. ODR freq is in milliHz, so
> +	 * we need to convert f_MOD to the same units. When SING_CYC=1 or
> +	 * multiple channels are enabled (currently always the case), there
> +	 * is an additional factor of 3.
> +	 */
> +	u32 div = DIV_ROUND_CLOSEST(MEGA * MILLI, odr_millihz * 32 * 3);
> +	/* Avoid divide by 0 and limit to register field size. */
> +	return clamp(div, 1U, AD7173_FILTER_SINC3_MAP_DIV);
> +}
> +
>  static unsigned int ad4111_current_channel_config[] = {
>  	/* Ain sel: pos        neg    */
>  	0x1E8, /* 15:IIN0+    8:IIN0− */
> @@ -369,6 +404,47 @@ static const struct iio_enum ad7173_syscalib_mode_enum = {
>  	.get = ad7173_get_syscalib_mode
>  };
>  
> +static const char * const ad7173_filter_types_str[] = {
> +	[AD7173_FILTER_SINC3] = "sinc3",
> +	[AD7173_FILTER_SINC5_SINC1] = "sinc5+sinc1",
> +	[AD7173_FILTER_SINC5_SINC1_PF1] = "sinc5+sinc1+pf1",
> +	[AD7173_FILTER_SINC5_SINC1_PF2] = "sinc5+sinc1+pf2",
> +	[AD7173_FILTER_SINC5_SINC1_PF3] = "sinc5+sinc1+pf3",
> +	[AD7173_FILTER_SINC5_SINC1_PF4] = "sinc5+sinc1+pf4",
> +};
> +
> +static int ad7173_set_filter_type(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int val)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	st->channels[chan->address].cfg.filter_type = val;
> +	st->channels[chan->address].cfg.live = false;
> +
> +	iio_device_release_direct(indio_dev);
> +
> +	return 0;
> +}
> +
> +static int ad7173_get_filter_type(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +
> +	return st->channels[chan->address].cfg.filter_type;
> +}

I know, I'm usual picky with this but FWIW, the above is a possible data
race. Anyways, still up to you...

- Nuno Sá

> +
> +static const struct iio_enum ad7173_filter_type_enum = {
> +	.items = ad7173_filter_types_str,
> +	.num_items = ARRAY_SIZE(ad7173_filter_types_str),
> +	.set = ad7173_set_filter_type,
> +	.get = ad7173_get_filter_type,
> +};
> +
>  static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
>  	{
>  		.name = "sys_calibration",
> @@ -379,6 +455,16 @@ static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
>  		 &ad7173_syscalib_mode_enum),
>  	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
>  			   &ad7173_syscalib_mode_enum),
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7173_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
> +			   &ad7173_filter_type_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec_ext_info ad7173_temp_chan_spec_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7173_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
> +			   &ad7173_filter_type_enum),
>  	{ }
>  };
>  
> @@ -582,14 +668,18 @@ static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
>  		      sizeof(struct {
>  				     bool bipolar;
>  				     bool input_buf;
> +				     u16 sinc3_ord_div;
>  				     u8 sinc5_odr_index;
>  				     u8 ref_sel;
> +				     enum ad7173_filter_type filter_type;
>  			     }));
>  
>  	return cfg1->bipolar == cfg2->bipolar &&
>  	       cfg1->input_buf == cfg2->input_buf &&
> +	       cfg1->sinc3_ord_div == cfg2->sinc3_ord_div &&
>  	       cfg1->sinc5_odr_index == cfg2->sinc5_odr_index &&
> -	       cfg1->ref_sel == cfg2->ref_sel;
> +	       cfg1->ref_sel == cfg2->ref_sel &&
> +	       cfg1->filter_type == cfg2->filter_type;
>  }
>  
>  static struct ad7173_channel_config *
> @@ -630,6 +720,7 @@ static int ad7173_load_config(struct ad7173_state *st,
>  {
>  	unsigned int config;
>  	int free_cfg_slot, ret;
> +	u8 post_filter_enable, post_filter_select;
>  
>  	free_cfg_slot = ida_alloc_range(&st->cfg_slots_status, 0,
>  					st->info->num_configs - 1, GFP_KERNEL);
> @@ -649,8 +740,49 @@ static int ad7173_load_config(struct ad7173_state *st,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * When SINC3_MAP flag is enabled, the rest of the register has a
> +	 * different meaning. We are using this option to allow the most
> +	 * possible sampling frequencies with SINC3 filter.
> +	 */
> +	if (cfg->filter_type == AD7173_FILTER_SINC3)
> +		return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
> +				       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 1) |
> +				       FIELD_PREP(AD7173_FILTER_SINC3_MAP_DIV,
> +						  cfg->sinc3_ord_div));
> +
> +	switch (cfg->filter_type) {
> +	case AD7173_FILTER_SINC5_SINC1_PF1:
> +		post_filter_enable = 1;
> +		post_filter_select = 2;
> +		break;
> +	case AD7173_FILTER_SINC5_SINC1_PF2:
> +		post_filter_enable = 1;
> +		post_filter_select = 3;
> +		break;
> +	case AD7173_FILTER_SINC5_SINC1_PF3:
> +		post_filter_enable = 1;
> +		post_filter_select = 5;
> +		break;
> +	case AD7173_FILTER_SINC5_SINC1_PF4:
> +		post_filter_enable = 1;
> +		post_filter_select = 6;
> +		break;
> +	default:
> +		post_filter_enable = 0;
> +		post_filter_select = 0;
> +		break;
> +	}
> +
>  	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
> -			       AD7173_FILTER_ODR0_MASK & cfg->sinc5_odr_index);
> +			       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 0) |
> +			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
> +					  post_filter_enable) |
> +			       FIELD_PREP(AD7173_FILTER_ENHFILTEN,
> +					  post_filter_select) |
> +			       FIELD_PREP(AD7173_FILTER_ORDER, 0) |
> +			       FIELD_PREP(AD7173_FILTER_ODR_MASK,
> +					  cfg->sinc5_odr_index));
>  }
>  
>  static int ad7173_config_channel(struct ad7173_state *st, int addr)
> @@ -1183,6 +1315,13 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->channels[chan->address].cfg.filter_type == AD7173_FILTER_SINC3) {
> +			/* Inverse operation of ad7173_sinc3_ord_div_from_odr() */
> +			*val = MEGA;
> +			*val2 = 3 * 32 * st->channels[chan->address].cfg.sinc3_ord_div;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
>  		reg = st->channels[chan->address].cfg.sinc5_odr_index;
>  
>  		*val = st->info->sinc5_data_rates[reg] / MILLI;
> @@ -1221,6 +1360,10 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>  	 *
>  	 * This will cause the reading of CH1 to be actually done once every
>  	 * 200.16ms, an effective rate of 4.99sps.
> +	 *
> +	 * Both the sinc5 and sinc3 rates are set here so that if the filter
> +	 * type is changed, the requested rate will still be set (aside from
> +	 * rounding differences).
>  	 */
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		freq = val * MILLI + val2 / MILLI;
> @@ -1230,6 +1373,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>  
>  		cfg = &st->channels[chan->address].cfg;
>  		cfg->sinc5_odr_index = i;
> +		cfg->sinc3_ord_div = ad7173_sinc3_ord_div_from_odr(freq);
>  		cfg->live = false;
>  		break;
>  
> @@ -1246,17 +1390,40 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
>  	struct ad7173_state *st = iio_priv(indio_dev);
> +	u16 sinc3_count = 0;
> +	u16 sinc3_div = 0;
>  	int i, j, k, ret;
>  
>  	for (i = 0; i < indio_dev->num_channels; i++) {
> -		if (test_bit(i, scan_mask))
> +		const struct ad7173_channel_config *cfg = &st->channels[i].cfg;
> +
> +		if (test_bit(i, scan_mask)) {
> +			if (cfg->filter_type == AD7173_FILTER_SINC3) {
> +				sinc3_count++;
> +
> +				if (sinc3_div == 0) {
> +					sinc3_div = cfg->sinc3_ord_div;
> +				} else if (sinc3_div != cfg->sinc3_ord_div) {
> +					dev_err(&st->sd.spi->dev,
> +						"All enabled channels must have the same sampling_frequency for sinc3 filter_type\n");
> +					return -EINVAL;
> +				}
> +			}
> +
>  			ret = ad7173_set_channel(&st->sd, i);
> -		else
> +		} else {
>  			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);
> +		}
>  		if (ret < 0)
>  			return ret;
>  	}
>  
> +	if (sinc3_count && sinc3_count < bitmap_weight(scan_mask, indio_dev->num_channels)) {
> +		dev_err(&st->sd.spi->dev,
> +			"All enabled channels must have sinc3 filter_type\n");
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * On some chips, there are more channels that setups, so if there were
>  	 * more unique setups requested than the number of available slots,
> @@ -1415,6 +1582,7 @@ static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
>  		.storagebits = 32,
>  		.endianness = IIO_BE,
>  	},
> +	.ext_info = ad7173_temp_chan_spec_ext_info,
>  };
>  
>  static void ad7173_disable_regulators(void *data)
> @@ -1655,7 +1823,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->cfg.bipolar = false;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		chan_st_priv->cfg.sinc3_ord_div = ad7173_sinc3_ord_div_from_odr(
> +			st->info->sinc5_data_rates[st->info->odr_start_value]
> +		);
>  		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
> +		chan_st_priv->cfg.filter_type = AD7173_FILTER_SINC5_SINC1;
>  		chan_st_priv->cfg.openwire_comp_chan = -1;
>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		if (st->info->data_reg_only_16bit)
> @@ -1727,7 +1899,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan->scan_index = chan_index;
>  		chan->channel = ain[0];
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> +		chan_st_priv->cfg.sinc3_ord_div = ad7173_sinc3_ord_div_from_odr(
> +			st->info->sinc5_data_rates[st->info->odr_start_value]
> +		);
>  		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
> +		chan_st_priv->cfg.filter_type = AD7173_FILTER_SINC5_SINC1;
>  		chan_st_priv->cfg.openwire_comp_chan = -1;
>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> 
> -- 
> 2.43.0
> 

