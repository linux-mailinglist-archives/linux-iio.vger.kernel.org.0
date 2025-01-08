Return-Path: <linux-iio+bounces-14040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3B7A066E5
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC41160964
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE6204C36;
	Wed,  8 Jan 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wkvrEyvg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C52046BF
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370384; cv=none; b=buB6aYn45AJYxzrj5LSsAcKoYt77EoKQaKiq0iqNvpplCYwaSz913/2keiV8OsI4ZuP8xGxTihGt1mvBY2jtch8GnBGRw+hpQTTaLNOfIKuwFM1UEcKrGU0cWgbBlImbzW2FNB9nmI1hMBYDtGFLSF5xBop86eWy/r0WJn9hK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370384; c=relaxed/simple;
	bh=zLb9dnA6Ssb07ai6m3XQ6+1ec8RZ3gkKxkF0TuJipNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlWXoElIPHrVfrEIdM/5VviG+jjP+5XtnJQfV6GXjmKiCV4ItxnwFXloEdsFoS7QIEGOOVlxJt7HtkZNYDaPOlzm9e5LHdg6xBe6fRglv84ls/CtDucfll7Xu/Izr+PgiV9RHIyKHdUaBJIFO+ij5oGh7pWuHkVXGJBebazgzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wkvrEyvg; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb790888c6so64929b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736370381; x=1736975181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6wBogert/kzi4EXMdyyUrWdh1fmB3qe91j+4+4toyA=;
        b=wkvrEyvg5vHnTRFPMg+N7nB/L/Le+87RvmQPdAOwmwkhL0bM/+/ffSyeN0ABd19A+3
         Xh/Uwrjeoj+tXL9zyRLTlo6CvBZ+Oko+pxb6A/w1yI8aFUECnY/BAAuroPEUMR5epvZf
         IDp0wUOkSPvqNy+rxRjnFzsOorvXrndr/AxEym1x6Mm4G4qP1Sp9JODZ04I05eTNF0iq
         V5BgRgtS/aPyrWBbowEXNoSvU3Ebu9giH4klgOM3Di6fBCLFLyooPlHfLdq63uuRM6Vr
         f7RAuyuh9aVdKfXuL3SiqY7L2cCfG3myrENnFKz118nm4+8gm/fASU+zNFub9Ruf4EC0
         uSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370381; x=1736975181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6wBogert/kzi4EXMdyyUrWdh1fmB3qe91j+4+4toyA=;
        b=gEkWkhQ2uf/oc+U20K30nCNEFXwgCsFMzwGtxey/eWCKeNVTFE5juRMkOjP+/ZimAO
         FN0sQf2F90ljAoJjcOVkySnninRMaTOcM1WfhYW56/yKLYl0ikDk05uVGyNzXxEaXXMN
         VV0jXVKlMiHlSnDOsgFfCaxBj5YaoZofgxQ6E5CDOHzdbLjBjqPHU+yaRvqQp1g/qsZ+
         WguifzoMGGsTWfjmLEfyY91mIUR+dgNpoeN6bPJjh+m+IFL8+ys3KRqercuGZ/Sg/ciQ
         SgxMreFA73dT17kfjBscaCcAdlY52o2lsvQBxHtjGS2qak16X5GVYq/l6Pk95HDj6+uF
         IZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVGVxBUCvqOU5TAR0i1yC8/LC82HNKlBepXG5+E+eK2W2lhkfkP5hm3Zy95ayvC0/AC7FvApahSfsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPfBVFpCeuO/gjowyZmXgriVyUhTF9DpTP/5srXiRTgdM2ado
	pbywY4H1AURseuwpU/7CbjYwMxyWh2q4kT676u1lePnwO6uWb1TYX8zxZXfbBVM=
X-Gm-Gg: ASbGnctKDuLPgDnKg60ocOBb4Bq3RMMTonECZSxu4WLU239IQk7k2dGLbrNhmEYH5xZ
	zep0nrr6d9SfVD09IaMv5BAax/zjibMFk9yl754a75hXAhnfkaIrCf0wVUpE90SbUhMA2IHnXEm
	hP3TnYS8yBj/L2EQ6lvjxhTaI8auHFDE12UjDnXe4G/rGX4RHRvaTUL4zMjjyV6NyNKdx69GTKd
	QCNa0eZsQDgwGsEszN5rCvDpzwJqgW6b0L9L0XMoHoUcx6GPSUTFDp8Qv/fh9NveqNsxEAjhNYS
	eZPvVoR60YH/TTwI/g==
X-Google-Smtp-Source: AGHT+IH9S6XemwYfniNbeUNOZtmCej/CIkwj7FU1HxrZ1wSdaP6lYKlQ/W7iJaNrVP139o2nAy1wuw==
X-Received: by 2002:a05:6808:2023:b0:3eb:428b:fa5a with SMTP id 5614622812f47-3ef2ee372d4mr2454902b6e.37.1736370381085;
        Wed, 08 Jan 2025 13:06:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc99d7c22sm11363970a34.69.2025.01.08.13.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:06:19 -0800 (PST)
Message-ID: <50488ccd-8106-4048-9be7-06b2da854f3a@baylibre.com>
Date: Wed, 8 Jan 2025 15:06:19 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] iio: dac: adi-axi-dac: add bus mode setup
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-4-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-4-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> The ad354xr requires DSPI mode (2 data lanes) to work in buffering
> mode, so backend needs to allow a mode selection between:
>     SPI  (entire ad35xxr family),
>     DSPI (ad354xr),
>     QSPI (ad355xr).
> 

It wouldn't hurt to mention here why AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER is
removed. It looks like it was just added by mistake in the original code and
isn't used anywhere.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.h  |  8 ++++++++
>  drivers/iio/dac/adi-axi-dac.c | 26 +++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.h b/drivers/iio/dac/ad3552r-hs.h
> index 724261d38dea..4a9e35234124 100644
> --- a/drivers/iio/dac/ad3552r-hs.h
> +++ b/drivers/iio/dac/ad3552r-hs.h
> @@ -8,11 +8,19 @@
>  
>  struct iio_backend;
>  
> +enum ad3552r_io_mode {
> +	AD3552R_IO_MODE_SPI,
> +	AD3552R_IO_MODE_DSPI,
> +	AD3552R_IO_MODE_QSPI,
> +};
> +
>  struct ad3552r_hs_platform_data {
>  	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val,
>  			    size_t data_size);
>  	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val,
>  			     size_t data_size);
> +	int (*bus_set_io_mode)(struct iio_backend *back,
> +			       enum ad3552r_io_mode mode);
>  	u32 bus_sample_data_clock_hz;
>  };
>  
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index d02eb535b648..79ca158c1ad9 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -64,7 +64,7 @@
>  #define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
>  #define AXI_DAC_CUSTOM_CTRL_REG			0x008C
>  #define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> -#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> +#define   AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE	GENMASK(3, 2)
>  #define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
>  #define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
>  
> @@ -725,6 +725,29 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
>  	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
>  }
>  
> +static int axi_dac_bus_set_io_mode(struct iio_backend *back,
> +				   enum ad3552r_io_mode mode)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +	int ival, ret;

Don't we need to protect against concurrent register access?

	guard(mutex)(&st->lock);

> +
> +	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
> +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(st->regmap,
> +				       AXI_DAC_UI_STATUS_REG, ival,
> +				       FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
> +				       10, 100 * KILO);
> +
> +	if (ret == -ETIMEDOUT)
> +		dev_err(st->dev, "AXI read timeout\n");

Same comment here as previous patch, is `dev_err()` really that helpful?

> +
> +	return ret;
> +}
> +
>  static void axi_dac_child_remove(void *data)
>  {
>  	platform_device_unregister(data);
> @@ -736,6 +759,7 @@ static int axi_dac_create_platform_device(struct axi_dac_state *st,
>  	struct ad3552r_hs_platform_data pdata = {
>  		.bus_reg_read = axi_dac_bus_reg_read,
>  		.bus_reg_write = axi_dac_bus_reg_write,
> +		.bus_set_io_mode = axi_dac_bus_set_io_mode,
>  		.bus_sample_data_clock_hz = st->dac_clk_rate,
>  	};
>  	struct platform_device_info pi = {
> 


