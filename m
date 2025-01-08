Return-Path: <linux-iio+bounces-14044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC92DA0674F
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3BE166437
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BDA203709;
	Wed,  8 Jan 2025 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EnmI6aw1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1E2040B7
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372267; cv=none; b=EFHf/uGE9mDqS+0HR+Sikk2cU0t144w1v7G5lllVGq6mvLGOgh64szHS5o4A20JNXYiaOZvdEePadpPHJt3007txBUaeQ+JzUrnFZHMY6AbX8YT18mFnGToCakr87Uxn8YwdsWNWdsn8aqA6p2nJRZVy7m20QNlNg+D6cpuOZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372267; c=relaxed/simple;
	bh=wT9VQbcuS7BFxGZZBSIgtndborf4+gYWmYpz1stc5Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3aXtKADmw91Tgy7GpbMof1v6b/K9ACDh/s7i4gQP3g55AY/JIzzLGgARTsFQcjsE6defYw8YutBwKd/5rQScIn33Jy0mjFtrqEQWBH0wLTIvvPA2XLOEFcCT4/nYR44UZsPocvUseJm6fGFsLiKS5dRlFry1hf6dMqY+h3gu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EnmI6aw1; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb98ad8caaso137830b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736372264; x=1736977064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkEoF5Kp2mENsEKwKQ7HP4jUd0VXXDdxnDIUrBbSU7s=;
        b=EnmI6aw1YLSXxNg3lGskcz/xuHWmmUdkfgj2674Vee6lA5irm+0gFoYkDQePSe+DnV
         fW0X1fHEXex4B9EujJ7/T4pW+mV7pNuzKcWDa7tflHZ7rYn/g9I3gNtRbSrBvZfYCCNN
         CEq2J6gvFtaEls+p8teOBsVKWFOD1/JcDYcXiAXSChDnw55/NFyd8oP5/tUCzz1ZOmxE
         SlTck098T2v24TpXqHCfNt9LoxAMRms+853NgWxqg5pPmy9/Ck5qG+oKgUvvmfaqMq78
         +ZNBzsZS31kW1VOXYjCEcsMZBE23wUwCupJNbwJd+IUmCE9XN7gtNUspyrX8t1hAhLic
         vHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736372264; x=1736977064;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkEoF5Kp2mENsEKwKQ7HP4jUd0VXXDdxnDIUrBbSU7s=;
        b=G7BEItnvYmIpAuABZ6lC7ABQJILIzqs+WhEBUbOA7UQsHwio6y4BvPiNMCKsn17RDa
         z/zhFYoeu1Rjqv0SNV+kN3jkpO2ziMCNobkZFo1paQd/nP8F11bZZCnlBfXiVc37Q2rO
         rtO+2tJhOWG8PW3Py3leMuVrXXovhba1cKGhgz72g4jgmVpVGRq0hmy7On9mYb6Ir2MF
         OLQh2c0BN7vwhlXmJmUTUBeYMs6NCpC+DEBjkJ9yEt1Lwwnw+pf8fDBqwXrN4AoKkhKY
         V/0YZ2gEnr2TjurOze96bSl6VvTg5F15n9a39IDt1hutpKIdqSjmKC1yw7tQEeMqHhKP
         97Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWp954fY6xBvp6sGLp7M4pu8jPGOkgZsA2k8HiL8vbTdS8e0ispxTpDM0EN/Y2eMDFDv593ymMUWh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbzRv0RxUFpz0AclVFDcc4zrX0JHmNeqFBI2KCYiR0I2clCoU
	K75kw+LrjX3BaJbby74GxpK+xwxgtBrRKL0oxixl8xZhPuUBK4GuDk3Wg5zx+60=
X-Gm-Gg: ASbGncsJ4p/EJozUzSBYMbmCrPd5dYTS/eVKCxK0B/HfnwGkO7TAlpfi79iojsesAbU
	jITNUlBV4v3a5blnGFTSxilvpOK9RAnCKRkIqFfGASQBD7L2JKuTisMyJ4NkdIChTpK9baLBuei
	WK8ylDAiD+VLZtOiwKioiNpFZIyovwlXTge+hZG6ZxFoATAoDD55jaQpNQ1OSv2yTIlcPS6pYeR
	eb+/3WqZziC7JwoYxUyxvWfetqAdFIEXheVjC/+OFwqpxUWB0RE85RlTdtGyXYBcm2eSsttzVBd
	tcBZCWSDvkhk7MeuYA==
X-Google-Smtp-Source: AGHT+IGFXAzChai+RWviDCzvJnHPJSnRdV40H74xIc79Ndb4p8aerNIYWAw3JeMcoIMq3CPD+FYRrg==
X-Received: by 2002:a05:6870:d0f:b0:29e:48d6:2e62 with SMTP id 586e51a60fabf-2aa0652ce6cmr2335592fac.9.1736372264059;
        Wed, 08 Jan 2025 13:37:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c6959sm13570623fac.19.2025.01.08.13.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:37:43 -0800 (PST)
Message-ID: <88587dae-0cef-499f-95c9-0fbf76f6c459@baylibre.com>
Date: Wed, 8 Jan 2025 15:37:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-8-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> A new fpga HDL has been developed from ADI to support ad354xr

s/fpga/FPGA/

> devices.
> 
> Add support for ad3541r and ad3542r with following additions:
> 
> - use common device_info structures for hs and non hs drivers,
> - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> - change samplerate to respect number of lanes.

s/samplerate/sample rate/

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-common.c |   4 +
>  drivers/iio/dac/ad3552r-hs.c     | 240 ++++++++++++++++++++++++++++++++-------
>  drivers/iio/dac/ad3552r.h        |   3 +
>  3 files changed, 206 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> index 36920ec95836..fa3050dc2efa 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -44,6 +44,7 @@ const struct ad3552r_model_data ad3541r_model_data = {
>  	.ranges_table = ad3542r_ch_ranges,
>  	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
>  	.requires_output_range = true,
> +	.num_spi_data_lanes = 2,
>  };
>  EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
>  
> @@ -54,6 +55,7 @@ const struct ad3552r_model_data ad3542r_model_data = {
>  	.ranges_table = ad3542r_ch_ranges,
>  	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
>  	.requires_output_range = true,
> +	.num_spi_data_lanes = 2,
>  };
>  EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
>  
> @@ -64,6 +66,7 @@ const struct ad3552r_model_data ad3551r_model_data = {
>  	.ranges_table = ad3552r_ch_ranges,
>  	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
>  	.requires_output_range = false,
> +	.num_spi_data_lanes = 4,
>  };
>  EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
>  
> @@ -74,6 +77,7 @@ const struct ad3552r_model_data ad3552r_model_data = {
>  	.ranges_table = ad3552r_ch_ranges,
>  	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
>  	.requires_output_range = false,
> +	.num_spi_data_lanes = 4,
>  };
>  EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
>  
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index bfb6228c9b9b..5995bab6a9b1 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -19,6 +19,31 @@
>  #include "ad3552r.h"
>  #include "ad3552r-hs.h"
>  
> +/*
> + * Important notes for register map access:
> + * ========================================
> + *
> + * Register address space is divided in 2 regions, primary (config) and
> + * secondary (DAC). Primary region can only be accessed in simple SPI mode,
> + * with exception for ad355x models where setting QSPI pin high allows QSPI
> + * access to both the regions.
> + *
> + * Due to the fact that ad3541/2r do not implement QSPI, for proper device
> + * detection, HDL keeps "QSPI" pin level low at boot (see ad3552r manual, rev B
> + * table 7, pin 31, digital input). For this reason, actually the working mode
> + * between SPI, DSPI and QSPI must be set via software, configuring the target
> + * DAC appropriately, together with the backend api to configure the bus mode

s/api/API/

> + * accordingly.
> + *
> + * Also, important to note that none of the three modes allow to read in DDR.
> + *
> + * In non-buffering operations, mode is set to simple SPI SDR for all primary
> + * and secondary region r/w accesses, to avoid to switch the mode each time DAC
> + * register is accessed (raw accesses, r/w), and to be able to dump registers
> + * content (possible as non DDR only).
> + * In buffering mode, driver sets best possible mode, D/QSPI and DDR.
> + */
> +
>  struct ad3552r_hs_state {
>  	const struct ad3552r_model_data *model_data;
>  	struct gpio_desc *reset_gpio;
> @@ -27,6 +52,8 @@ struct ad3552r_hs_state {
>  	bool single_channel;
>  	struct ad3552r_ch_data ch_data[AD3552R_MAX_CH];
>  	struct ad3552r_hs_platform_data *data;
> +	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
> +	u32 config_d;
>  };
>  
>  static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> @@ -56,15 +83,19 @@ static int ad3552r_hs_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		/*
> -		 * Using 4 lanes (QSPI), then using 2 as DDR mode is
> -		 * considered always on (considering buffering mode always).
> +		 * Using a "num_spi_data_lanes" variable since ad3541/2 have
> +		 * only DSPI interface, while ad355x is QSPI. Then using 2 as
> +		 * DDR mode is considered always on (considering buffering
> +		 * mode always).
>  		 */
>  		*val = DIV_ROUND_CLOSEST(st->data->bus_sample_data_clock_hz *
> -					 4 * 2, chan->scan_type.realbits);
> +					 st->model_data->num_spi_data_lanes * 2,
> +					 chan->scan_type.realbits);
>  
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_RAW:
> +		/* For RAW accesses, stay always in simple-spi. */
>  		ret = st->data->bus_reg_read(st->back,
>  				AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
>  				val, 2);
> @@ -93,6 +124,7 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		/* For RAW accesses, stay always in simple-spi. */
>  		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  			return st->data->bus_reg_write(st->back,
>  				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
> @@ -104,6 +136,42 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ad3552r_hs_set_bus_io_mode_hs(struct ad3552r_hs_state *st)
> +{
> +	int bus_mode;
> +
> +	if (st->model_data->num_spi_data_lanes == 4)
> +		bus_mode = AD3552R_IO_MODE_QSPI;
> +	else
> +		bus_mode = AD3552R_IO_MODE_DSPI;
> +
> +	return st->data->bus_set_io_mode(st->back, bus_mode);
> +}
> +
> +static int ad3552r_hs_set_target_io_mode_hs(struct ad3552r_hs_state *st)
> +{
> +	int mode_target;
> +
> +	/*
> +	 * Best access for secondary reg area, QSPI where possible,
> +	 * else as DSPI.
> +	 */
> +	if (st->model_data->num_spi_data_lanes == 4)
> +		mode_target = AD3552R_QUAD_SPI;
> +	else
> +		mode_target = AD3552R_DUAL_SPI;
> +
> +	/*
> +	 * Better to not use update here, since generally it is already
> +	 * set as DDR mode, and it's not possible to read in DDR mode.
> +	 */
> +	return st->data->bus_reg_write(st->back,
> +				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> +					   mode_target) |
> +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +}
> +
>  static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> @@ -132,6 +200,11 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * With ad3541/2r supoport, QSPI pin is held low at reset from HDL,

s/supoport/support/

> +	 * streaming start sequence must respect strictly the order below.
> +	 */
> +
>  	/* Primary region access, set streaming mode (now in SPI + SDR). */
>  	ret = ad3552r_qspi_update_reg_bits(st,
>  					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> @@ -139,48 +212,114 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +	/*
> +	 * Set target loop len, 0x2c 0r 0x2a, descending loop,
> +	 * and keeping loop len value so it's not cleared hereafter when
> +	 * enabling streaming mode (cleared by CS_ up).

rewrap to be closer to 80 chars/line

> +	 */
> +	ret = ad3552r_qspi_update_reg_bits(st,
> +		AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
> +		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +	if (ret)
> +		goto exit_err_streaming;
> +
> +	ret = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_STREAM_MODE,
>  				      loop_len, 1);
>  	if (ret)
> -		return ret;
> +		goto exit_err_streaming;
>  
> -	/* Inform DAC chip to switch into DDR mode */
> -	ret = ad3552r_qspi_update_reg_bits(st,
> -					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> -					   AD3552R_MASK_SPI_CONFIG_DDR,
> -					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
> +	/*
> +	 * Registers dump for debug purposes is only possible until here,
> +	 * read in primary region must be SPI SDR (DDR read is never possible,
> +	 * D/QSPI SDR read in primary region is also not possible).
> +	 */

It doesn't look like we have debugfs implemented in this driver, so this
comment doesn't seem relent. And if we did, we could guard it with
iio_device_claim_direct_mode() to avoid the issue, so we shouldn't need
this comment in any case.

> +
> +	/* Setting DDR now, caching current config_d. */
> +	ret = st->data->bus_reg_read(st->back,
> +				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				     &st->config_d, 1);
>  	if (ret)
> -		return ret;
> +		goto exit_err_streaming;
> +
> +	st->config_d |= AD3552R_MASK_SPI_CONFIG_DDR;
> +	ret = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				      st->config_d, 1);
> +
> +	if (ret)
> +		goto exit_err_streaming;
>  
> -	/* Inform DAC IP to go for DDR mode from now on */
>  	ret = iio_backend_ddr_enable(st->back);
> -	if (ret) {
> -		dev_err(st->dev, "could not set DDR mode, not streaming");
> -		goto exit_err;
> -	}
> +	if (ret)
> +		goto exit_err_ddr_mode_target;
>  
> +	/*
> +	 * From here onward mode is DDR, so reading any register is not
> +	 * possible anymore, including calling "ad3552r_qspi_update_reg_bits"
> +	 * function.
> +	 */
> +
> +	/* Set target to best high speed mode (D or QSPI). */
> +	ret = ad3552r_hs_set_target_io_mode_hs(st);
> +	if (ret)
> +		goto exit_err_ddr_mode;
> +
> +	/* Set bus to best high speed mode (D or QSPI). */
> +	ret = ad3552r_hs_set_bus_io_mode_hs(st);
> +	if (ret)
> +		goto exit_err_bus_mode_target;
> +
> +	/*
> +	 * Backend setup must be done now only, or related register values
> +	 * will be disrupted by previous bus accesses.
> +	 */
>  	ret = iio_backend_data_transfer_addr(st->back, val);
>  	if (ret)
> -		goto exit_err;
> +		goto exit_err_bus_mode_target;
>  
>  	ret = iio_backend_data_format_set(st->back, 0, &fmt);
>  	if (ret)
> -		goto exit_err;
> +		goto exit_err_bus_mode_target;
>  
>  	ret = iio_backend_data_stream_enable(st->back);
>  	if (ret)
> -		goto exit_err;
> +		goto exit_err_bus_mode_target;
>  
>  	return 0;
>  
> -exit_err:
> -	ad3552r_qspi_update_reg_bits(st,
> -				     AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> -				     AD3552R_MASK_SPI_CONFIG_DDR,
> -				     0, 1);
> +exit_err_bus_mode_target:
> +	/* Back to simple SPI, not using update to avoid read. */
> +	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> +					   AD3552R_SPI) |
> +				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
>  
> +	/*
> +	 * Back bus to simple SPI, this must be executed together with above
> +	 * target mode unwind, and can be done only after it.
> +	 */
> +	st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
> +
> +exit_err_ddr_mode:
>  	iio_backend_ddr_disable(st->back);
>  
> +exit_err_ddr_mode_target:
> +	/*
> +	 * Back to SDR.

Odd place for line break.

> +	 * In DDR we cannot read, whatever the mode is, so not using update.
> +	 */
> +	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, 1),
> +				1);
> +
> +exit_err_streaming:
> +	/* Back to single instruction mode, disabling loop. */
> +	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +				AD3552R_MASK_SINGLE_INST |
> +				AD3552R_MASK_SHORT_INSTRUCTION, 1);
> +
>  	return ret;
>  }
>  
> @@ -193,11 +332,22 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Inform DAC to set in SDR mode */
> -	ret = ad3552r_qspi_update_reg_bits(st,
> -					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> -					   AD3552R_MASK_SPI_CONFIG_DDR,
> -					   0, 1);
> +	/*
> +	 * Set us to simple SPI, even if still in ddr, so to be able
> +	 * to write in primary region.
> +	 */
> +	ret = st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Back to SDR
> +	 * (in DDR we cannot read, whatever the mode is, so not using update).
> +	 */
> +	st->config_d &= ~AD3552R_MASK_SPI_CONFIG_DDR;
> +	ret = st->data->bus_reg_write(st->back,
> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				      st->config_d, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -205,11 +355,21 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Back to single instruction mode, disabling loop. */
> +	/*
> +	 * Back to simple SPI for secondary region too now,
> +	 * so to be able to dump/read registers there too if needed.
> +	 */
>  	ret = ad3552r_qspi_update_reg_bits(st,
> -					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> -					   AD3552R_MASK_SINGLE_INST,
> -					   AD3552R_MASK_SINGLE_INST, 1);
> +					   AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +					   AD3552R_MASK_MULTI_IO_MODE,
> +					   AD3552R_SPI, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Back to single instruction mode, disabling loop. */
> +	ret = ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,

I think this commit will fail to compile with this rename.

ad3552r_qspi_update_reg_bits -> ad3552r_update_reg_bits

This functinon isn't renamed until the next patch.

> +				      AD3552R_MASK_SINGLE_INST,
> +				      AD3552R_MASK_SINGLE_INST, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -319,6 +479,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  	if (ret)
>  		return ret;
>  
> +	/* HDL starts with DDR enabled, disabling it. */
>  	ret = iio_backend_ddr_disable(st->back);
>  	if (ret)
>  		return ret;
> @@ -352,6 +513,8 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
>  			 id, st->model_data->chip_id);
>  
> +	dev_info(st->dev, "chip id %s detected", st->model_data->model_name);

IIRC, Jonathan suggested dev_dbg() here.

> +
>  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
>  				      AD3552R_MASK_RESET_STATUS, 1);
> @@ -364,14 +527,6 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
>  	if (ret)
>  		return ret;
>  
> -	ret = st->data->bus_reg_write(st->back,
> -				AD3552R_REG_ADDR_TRANSFER_REGISTER,
> -				FIELD_PREP(AD3552R_MASK_MULTI_IO_MODE,
> -					   AD3552R_QUAD_SPI) |
> -				AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> -	if (ret)
> -		return ret;
> -
>  	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
>  	if (ret)
>  		return ret;
> @@ -528,6 +683,9 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ad3552r_hs_of_id[] = {
> +	{ .compatible = "adi,ad3541r", .data = &ad3541r_model_data },
> +	{ .compatible = "adi,ad3542r", .data = &ad3542r_model_data },
> +	{ .compatible = "adi,ad3551r", .data = &ad3551r_model_data },
>  	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
>  	{ }
>  };
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index 23f038464a0c..9d450019ece9 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -132,6 +132,8 @@
>  
>  #define AD3552R_MAX_RANGES	5
>  #define AD3542R_MAX_RANGES	5
> +#define AD3552R_SPI		0
> +#define AD3552R_DUAL_SPI	1
>  #define AD3552R_QUAD_SPI	2
>  
>  extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
> @@ -156,6 +158,7 @@ struct ad3552r_model_data {
>  	const s32 (*ranges_table)[2];
>  	int num_ranges;
>  	bool requires_output_range;
> +	int num_spi_data_lanes;
>  };
>  
>  struct ad3552r_ch_data {
> 


