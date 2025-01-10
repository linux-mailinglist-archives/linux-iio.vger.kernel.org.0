Return-Path: <linux-iio+bounces-14104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6748A096DB
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA46188E7AE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97983212D67;
	Fri, 10 Jan 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XnhJyEE2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0A211288
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525539; cv=none; b=q9QMpOoBo5DnmNxOaZC7jg1rg6QtMT6o/y/JAaDmjF8/BhjgAgXesjqBrEXGyLYnlkS7NGk+Zl4SW1Fftil7heZNHr1nOpLTM+oHB3QICCvBdww9RkxiGh/djcGbjYixpsytrLEcvyUbXiIbPfUx4RReXorm7/+DohCFg74cFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525539; c=relaxed/simple;
	bh=lpuK8OR/n3tmxcAxXugYYB2UaUwmUm3NDFUu/9uqsiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtlJ+qXOI8zNFCu4mZfdLNWkq9HVI0GGIkuCJM5Ilg34arbZyff0jetI7cgSTX7/IOPe2tW6jpZvsEeEBfO7v7hCexJobWjQRDCFk/rHQ0aPKuDYwwYldm+5SX8qQJ0R9N+T1yQrCaoLI5cG/T1Bc2V15fJpcRGkSf5GImkppsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XnhJyEE2; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f32fab5de9so613222eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736525535; x=1737130335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAuHO1b44k5AxnlIkasVBNwmUMkj9yOBNt6aXQteDlg=;
        b=XnhJyEE2ZEJpRQSS++pSJ39K44d+6fT0aiqENKtRvF7jHCqXkI7Ku/faiLW46wmHTU
         beaD9I6d9x69xz+cJiX8gd6wztnRjCzPj0UNsIDyu+lquvRzZWF+Jvc6GXJU79GTCQ/v
         ndxFylbm9mlrZN02NSFBQ9cWFbVEbhdlsWDi43K6kIv6rMkNf+c+Ve4zMgmpjiK6HNy+
         I73OmVtqHk1LUEfMBypVr5fkKm8magF6kichjIH90heMROXYWGwOfc6TnwiIQOwCsm9p
         OcFGi14w+4zwG4kjeovsH3QX240Z7cvAI71BKqsRmDFAmWro1v3/eH00z5jEg7ZSKQ4S
         0GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525535; x=1737130335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAuHO1b44k5AxnlIkasVBNwmUMkj9yOBNt6aXQteDlg=;
        b=CG1KjDZPilvCO7JhnX5HlmV9Q7DqQ2jUylGTpjzoCN+kwDtQb8DV2DNMYAkx1g/i0j
         3QEHI5u/S/hnR3Xh+jvU8ElpNhw+awVG+c4Sx+r7R8pUgkhHO/hPp1ZJJxZkySy/EzMj
         B398gtzqZVe05Kp5d+Ko/fEzoxbkj/HBVX8bXmBhIEP3Gi+k0I9KuK7V/W20SFTd3Sjt
         rJSiCDs5vea1chEreSQOP7YgHXrx5Oahi+l0M8XwnKXEZWAjyeZHzQa1nkvB9TMh4Vkt
         K2TkKqN1O+9HvhS3sV/GRz7umbrcpyAbOohFTj0n1yw45w8GCmqvTXybrxSp8ZmdLrik
         cmnA==
X-Forwarded-Encrypted: i=1; AJvYcCXOjhz8NY5RzE3mjTNnWKDVqHzo0BPSoVCvwNw651vNYkJ8TvowDfGwgZndN1Uw0Tbk4+9tAtN3MdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsxYul80+NErY7cfdFeqjuL2gGs6uYYzkPgG+oMfmakOlLkog
	tTUA4pHZP1KwobljtxG9NYBd4j3tVs4vv1KTgAOkpRQjL+WZfLd0G6M5nHZVCLU=
X-Gm-Gg: ASbGncuc1sn2ZEOQmsCwsyIu3HkTc9DFCTSg3CGbyRsL7iR6r80YRqLZNm0oifW0HIb
	ZPfpYBQ63enMs+ZM5UGVonYPENJ5XZIyDMqigJLiAXOYxV0n1p/d36KY7E0c14SueCONbAhqgO4
	F4B+PkbwgerbTCgpJLoCKc4k7ZcgactbxvTNEmCGYBT48mKa3CxSkdV3abJwJzrnds8djPSSvxv
	z6mwsd35TECg8FhgWJ9h4hLeYs0d8RIc6jYuudH8yVLURAubpdLNCi7EMY4/zQgXnh0LM8tK4LV
	kUaHmjJPAC4IlCm/vQ==
X-Google-Smtp-Source: AGHT+IG9UWT6+UtW1+6mBflgBW6+S9PKMGjapdyo5qsRLtA7+iy0R49t7ozHV0wb9W3uYEidUkqfzQ==
X-Received: by 2002:a05:6870:6ec9:b0:29e:40f8:ad9b with SMTP id 586e51a60fabf-2aa066d6787mr6559272fac.14.1736525535136;
        Fri, 10 Jan 2025 08:12:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad805a43dcsm1005500fac.32.2025.01.10.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:12:13 -0800 (PST)
Message-ID: <a643e2cc-b540-42df-b63b-07cc339bb33e@baylibre.com>
Date: Fri, 10 Jan 2025 10:12:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] iio: dac: ad3552r-hs: add ad3541/2r support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-8-ab42aef0d840@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-8-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 4:24 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> A new FPGA HDL has been developed from ADI to support ad354xr
> devices.
> 
> Add support for ad3541r and ad3542r with following additions:
> 
> - use common device_info structures for hs and non hs drivers,
> - DMA buffering, use DSPI mode for ad354xr and QSPI for ad355xr,
> - change sample rate to respect number of lanes.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-common.c |   4 +
>  drivers/iio/dac/ad3552r-hs.c     | 225 ++++++++++++++++++++++++++++++++-------
>  drivers/iio/dac/ad3552r.h        |   3 +
>  3 files changed, 195 insertions(+), 37 deletions(-)
> 

...

> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index bfb6228c9b9b..4600a9e84dfc 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c

...

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

u32 would be more natural for register value. Or make an enum for this.

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
> +	 * With ad3541/2r support, QSPI pin is held low at reset from HDL,
> +	 * streaming start sequence must respect strictly the order below.
> +	 */
> +
>  	/* Primary region access, set streaming mode (now in SPI + SDR). */
>  	ret = ad3552r_qspi_update_reg_bits(st,
>  					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> @@ -139,48 +212,106 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
> +	/*
> +	 * Set target loop len, 0x2c 0r 0x2a, descending loop, and keeping loop

Not sure what 0x2c and 0x2a mean, so comment could be improved. And 0r looks
like a typo.

> +	 * len value so it's not cleared hereafter when enabling streaming mode
> +	 * (cleared by CS_ up).
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
> +
> +	/*
> +	 * From here onward mode is DDR, so reading any register is not possible
> +	 * anymore, including calling "ad3552r_qspi_update_reg_bits" function.
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
>  
> +	/*
> +	 * Backend setup must be done now only, or related register values will
> +	 * be disrupted by previous bus accesses.
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
> +
> +	/*
> +	 * Back bus to simple SPI, this must be executed together with above
> +	 * target mode unwind, and can be done only after it.
> +	 */
> +	st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
>  
> +exit_err_ddr_mode:
>  	iio_backend_ddr_disable(st->back);
>  
> +exit_err_ddr_mode_target:
> +	/*
> +	 * Back to SDR. In DDR we cannot read, whatever the mode is, so not
> +	 * using update.
> +	 */
> +	st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +				FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, 1),
> +				1);

Should be using st->config_d & ~AD3552R_MASK_SPI_CONFIG_DDR here instead of
hard-coding FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, 1).

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

