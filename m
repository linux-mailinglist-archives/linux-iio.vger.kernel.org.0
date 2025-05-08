Return-Path: <linux-iio+bounces-19317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE135AB00B1
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4188B17A661
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961A2253BB;
	Thu,  8 May 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mICO/toI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F71E3DE8
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722756; cv=none; b=SRWsZkLd1OQ6+mUeg039HGzTUhoqMyZOqNt4qK09QgkofD32Hhzs7odlt83pW8GAVbOYo/MmqeT4Ju5hebySwcT98TU7GX0USFn+qljFbN/TQjoh1C+VPjQRy7z7OcfcG8G7zVVdqApZXBw8hIikJwZlxD+e3escurxlBdmd7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722756; c=relaxed/simple;
	bh=sYeZLtpHPeuyHV/41fg3SXOFV2Tg9CfQcSP+Mkt6FAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AlqW9zGXu3Rej2YfcbHRknr47cTJVMQ+4d+oIfRCUvD+jhUQ2VQU7o7A5FDN4KrgoCyLErMG+MDp1xRLXSOffyajlXtlb4ZC5Fjc/6uFrd3M1wOzEDk/M52G5yfNm8zix0ClXODCkKfldNA4JuLyCBmeeM2hyCS0Fm58FoSphJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mICO/toI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73044329768so912357a34.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746722752; x=1747327552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZS1DAu/OGipdaeYyDVfVQy+AhcyRGZVYwm5fK44jnLQ=;
        b=mICO/toIb/HlwX+vg9U5ispi7FBErVNzk5S+GKrVfiMt8Y2sUWYVUeEWT5Wi8nCr6v
         02++H8yzwEV94bOjpiHlmNrmIkO6VgiFtwGM41DxDhAI5RvKBGFjuMAaYm9v8XJNE9J4
         Cy8eM65qmTdTqF3zci1lPbGYttDTMqQ1LnAnWTD124bQc5HqUbtuHfgffbi136fLyfa8
         /O6TdBwVDV83oL5z3ml/Z4RYP8CbJ6CBSv0ybsnE5WvfAy/uSZiRKYvBhb6WzDEAFT1+
         F+UMXMva8AbhPui8DGHBcDu3M3kMIEc9NB2MlYOXan5WQUjOCf5bSnQSCJo/QJwkuEIs
         NcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722752; x=1747327552;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS1DAu/OGipdaeYyDVfVQy+AhcyRGZVYwm5fK44jnLQ=;
        b=k4OuabwfsgoCP+MR+yyXZBXK9W0H4VnDa103wUR5jihhW3ZShPgytKEnCDlHXwPm7F
         /W+jUTvTz+sxrBjsWXDsOv/qHW8/7MCUGginR/BgNgPUTftjSiKysFj1XpnVPYFIXEEu
         Be03+Sr20qQod+Tesiu9TdG71NUyhInGpiuPoMQC3AUO1y6q0RcmKsNHyYUGL+SRGWEl
         iLrgH3vjSkusGB6FYSamN95S5wfj0uzCsn8ba1qTWJoKB46r7++opXZnMeyuL3lG+MZb
         zmBVVLhd9uAk1b0L/OwNE1QoW4Lvqe6MZE5Iuk2UPRmMeM0SYVExbF1M+YMSFlUqtHfS
         Peog==
X-Forwarded-Encrypted: i=1; AJvYcCUA4aiv4A0NgrLmWZbeMS7mKKJ94+VSYO0Z07lywC2jMTFhPDa7IiAeCDjo1F8rKwzQK6ddvstErBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0C8osAGgkQo3F1+l7HPfKHWRwDlxMsvCibZGmWqFq7xo3Wslt
	ZXd6XWNiukZJpYsUCWNGxsr8kdi0Q6QNLYLPTTxZkMZb/24oH8i74c9mEDaTnPU=
X-Gm-Gg: ASbGncs5BjAbNcfNCrA+ETvX9P/7m/JsnS2o82VuuejIXHl4FfHEbEUb+GmrZW3u/zI
	tpDjiJ9Y8blNOmSOFrubjmHQK1mbIDh+VbtwEVl/YW4aVWcVWyFhNNKYNujS5PgORIt7hhUKdGX
	IM2sTvxPEBwbIIDh2mVmzYhSJ9roHHtqnaA5gCbZhHJuFv10NEDoaavejaMhBdJvI84wLD1DQtJ
	8ZWCEh36Y0phikGmEdh3FxOrWO1Z8XFHqGFLBpJYlwkrVW28bfBU0wjBUXBn76Riy4R9vxx82vo
	6bKtxEFwHVwgIS7wpx2LDnUEupUsH8qm6Px6AXeMkXhM6Hi4ft6LnzFgRVeou32NA8g0+4h/xCs
	k9QnmuT4mFDs1RFpjyA==
X-Google-Smtp-Source: AGHT+IEZDZLOMxJDt8kLUDFqLwM51K2NVQLT54ITBkIlx9L3ppO4Dyj06GSMVCaofCpDgYIIbqiFjw==
X-Received: by 2002:a05:6830:3788:b0:72c:10db:f210 with SMTP id 46e09a7af769-732269faf05mr352368a34.13.1746722752395;
        Thu, 08 May 2025 09:45:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d59e1sm102555a34.34.2025.05.08.09.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:45:51 -0700 (PDT)
Message-ID: <37ae4941-da7e-4298-8269-b5faf29fffdd@baylibre.com>
Date: Thu, 8 May 2025 11:45:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: adc: adi-axi-adc: add set decimation rate
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
 <20250508123107.3797042-3-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508123107.3797042-3-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 7:30 AM, Pop Ioan Daniel wrote:
> Add support for setting decimation rate.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - update ADI_AXI_ADC_REG_CHAN_USR_CTRL_2 register in a per-channel register
>  - rename ADI_AXI_ADC_DEC_RATE_MASK in
>    ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK
>  - add channel index parameter to keep axi_adc_set_dec_rate generic
>  - remove ad7405 chip-specific struct
>  drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 9e8c30230791..33eb8f337e0b 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -80,6 +80,9 @@
>  #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
>  #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
>  
> +#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(c)	(0x0424 + (c) * 0x40)
> +#define   ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK		GENMASK(15, 0)
> +
>  /* IO Delays */
>  #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
>  #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> @@ -242,6 +245,17 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
>  	}
>  }
>  
> +static int axi_adc_set_dec_rate(struct iio_backend *back, unsigned int chan,
> +				unsigned int rate)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_update_bits(st->regmap,
> +				  ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(chan),
> +				  ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
> +				  FIELD_PREP(ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK, rate));

Rate is getting a bit far past 80 chars, so would be nice to wrap that line.

> +}
> +
>  static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
>  				    unsigned int *status)
>  {
> @@ -550,6 +564,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.oversampling_ratio_set = axi_adc_set_dec_rate,

Would make more sense if function was named axi_adc_oversampling_ratio_set.
(Making the names match exactly (with namespace prefix added) make less info
you have to hold in your head when reading the driver.)

>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


