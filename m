Return-Path: <linux-iio+bounces-15266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85BA2F269
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C3B3A2BD5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710024419F;
	Mon, 10 Feb 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="by1l6cjA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839AC1E283C
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203324; cv=none; b=A4W2mwAzEWFCKLCbpjypGw3a3AErf2noLl7AFxJI5KRR/lXQfePcSZ1IAXjaX7C3Z0AFQW+xMsVMoz8e7naWYKzz2ZGyrcxmTRy7mQXXC6qT9EUweV87B+GUjekgw/EO5U5jO7uct+kAfB8nJ2iRDcRInPXcOlzMYsnt0CwyYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203324; c=relaxed/simple;
	bh=u0VAYcq/akyEWKSTt6GgPq/wArBPZN2RGKupkPBoI9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Stt+F3kpgWk56rBTrK0rHm5WzyFLcRxZ9K/fii4DBHs7poYadl5osORxyCfpkMPr3tDnoo+pdaSehq8EFeU8tbWdvJTAgELmPKf4C/N+mwVje3iSa/Ha6zU9DuOFa4Qa7KkWBeaNBLmlVyGVOvSZrbqwbibJz+zGhzZJbfIc3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=by1l6cjA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3005916aso1513995a34.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203321; x=1739808121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9hNY1B3hiFWbuQVz7IVTYjJtWHZaIF3fkXcrf0/HLc=;
        b=by1l6cjAYc0fhrKXUYScnFBk65YXDFVSsHpa/Pux4dscqAJzIlo7ToU3Qx0mQRw8If
         mALiPurZ9eMt5jGUnugbqiUYTTp2yyei/rIE3nIPJ+REpuEezQe/PsuiPls+RG4gzXLX
         mIs/8cdPbeU7Y5bugrP9Ssxkz7XFrnAc9Qq8Raw+/LudAV11AHSxJypFKSsFCw3nh9f6
         0uNwMWTkGbITbt2r8fuJf+JbvcseWDSQgEOqFtEycCjrXcoD6C8/UDOzNpTmf/15sLWQ
         D1r9ltQndNdsqQUbiACkEz8nmUCOi2DR/atV6pZ5X4QsueYXa6uWqWAgt8wXuCtWNQV0
         1uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203321; x=1739808121;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9hNY1B3hiFWbuQVz7IVTYjJtWHZaIF3fkXcrf0/HLc=;
        b=IiLnW9ohWYZ3bkyE+LBf39p5miUj4jJJ4YRs336r5AtFMI46Rqd9Rr+vgEt1ibbUTm
         1FodU9P02+wPeV6EKPF58qGsnES26bt1akWzqLAfXWL0gXTbg/wEQ1JydJS4wTm8kGhf
         omBm+lXyJPZooo/llCbuD9WZXTSQuE5Y0PkZVIIbPfguv7OH7xeaxvlMoSb1AKFh8U+y
         bIckQ76FQ9GhxRFlDe9GLMnJ85T5XT2VsAT9Rn6yFZygNT+QuKIO/16G6nITRige8Ypz
         ab0zQ6qygC97e5EcVEJViRKK8gmpABQZ7Jf13lYnO2Ck2Ng5jd81U4rpS9Z3C25t8RDM
         63ow==
X-Forwarded-Encrypted: i=1; AJvYcCVbNvKfKjdrGaeZ6xqtzhUlMNXkha0fKRcupYJ2JJJ/TnuN3PzUfse8GMSgltIu/9BAee+oc9pax1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPziLfYvd/T+2MWnJgaLvHIGBQOYa+Ql8Fw5xjJGQbzppSs7X
	cLLLbYybvfk4aI56kxPoLSHBbmK95ikMBIKMwKMs6tmT4TCv37mKBwYML3ZD7ss=
X-Gm-Gg: ASbGncu7XwoxLs5R4v9LcOkP/DO961CgKLa9V4ikGDp58g9nxe/dhofRBQeOJCa/MBI
	KocOsaAX2msma6wGRxlKeQsiZd12HeLZSqScQsYJR5V7p0unTqsiRV72MEwrPmDF0VRHm9qbH11
	U3fm5IO87Eq0PNY/xWxpjtmq17ONPEWs20fMa8AndeMnwonPPWhPrVC7wogRpC2sPeNfVsnnQEW
	1YgWFG56HQgg7NpMK3jBVnWSmva80X4gCb5xSBcENZ16VId8WxZm1/eCzUvsXvDSDpUeqEIroX7
	1V+TSDCxoSRWWToCPfDicgni2tZKykP6zSgVpq2sEJFmD7FlW0dL
X-Google-Smtp-Source: AGHT+IEmz/z79n57foTM2IiZV1RAkBRrvXZ8JCigqm1/04tEth3DdNZfHmVNCMaJppLzGcpSIjFH7A==
X-Received: by 2002:a05:6830:6010:b0:71f:bbbd:ab60 with SMTP id 46e09a7af769-726b88cbe92mr9464407a34.26.1739203321488;
        Mon, 10 Feb 2025 08:02:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b854f77c92sm1842798fac.30.2025.02.10.08.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 08:01:59 -0800 (PST)
Message-ID: <8a8432e7-86b9-43dd-9aa0-75875747eedb@baylibre.com>
Date: Mon, 10 Feb 2025 10:01:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/17] iio: adc: ad4695: Add support for SPI offload
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 2:09 PM, David Lechner wrote:
> Add support for SPI offload to the ad4695 driver. SPI offload allows
> sampling data at the max sample rate (500kSPS or 1MSPS).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 

...

> ---
>  drivers/iio/adc/Kconfig  |   1 +
>  drivers/iio/adc/ad4695.c | 445 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 429 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f4f03299f9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -52,6 +52,7 @@ config AD4695
>  	tristate "Analog Device AD4695 ADC Driver"
>  	depends on SPI
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP

I missed adding

	select SPI_OFFLOAD

Closes: https://lore.kernel.org/oe-kbuild-all/202502090910.ganYXEeF-lkp@intel.com/

>  	help

...


> +static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4695_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	struct spi_transfer *xfer = &st->buf_read_xfer[0];
> +	struct pwm_state state;
> +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
> +	u8 num_slots = 0;
> +	u8 temp_en = 0;
> +	unsigned int bit;
> +	int ret;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		if (bit == temp_chan_bit) {
> +			temp_en = 1;
> +			continue;
> +		}
> +
> +		ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
> +				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
> +		if (ret)
> +			return ret;
> +
> +		num_slots++;
> +	}
> +
> +	/*
> +	 * For non-offload, we could discard data to work around this
> +	 * restriction, but with offload, that is not possible.
> +	 */
> +	if (num_slots < 2) {
> +		dev_err(&st->spi->dev,
> +			"At least two voltage channels must be enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
> +				 AD4695_REG_TEMP_CTRL_TEMP_EN,
> +				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
> +					    temp_en));
> +	if (ret)
> +		return ret;
> +
> +	/* Each BUSY event means just one sample for one channel is ready. */
> +	memset(xfer, 0, sizeof(*xfer));
> +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	/* Using 19 bits per word to allow for possible oversampling */
> +	xfer->bits_per_word = 19;
> +	xfer->len = 4;
> +
> +	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
> +	st->buf_read_msg.offload = st->offload;
> +
> +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * NB: technically, this is part the SPI offload trigger enable, but it
> +	 * doesn't work to call it from the offload trigger enable callback
> +	 * because it requires accessing the SPI bus. Calling it from the
> +	 * trigger enable callback could cause a deadlock.
> +	 */
> +	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> +			      AD4695_REG_GP_MODE_BUSY_GP_EN);
> +	if (ret)
> +		goto err_unoptimize_message;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +	if (ret)
> +		goto err_disable_busy_output;
> +
> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	if (ret)
> +		goto err_offload_trigger_disable;
> +
> +	guard(mutex)(&st->cnv_pwm_lock);

Apparently clang doesn't like this guard() after goto, so I'll have to figure
out what to do about that. Probably need to add a helper function to avoid
goto below from jumping out of scoped_guard().

https://lore.kernel.org/oe-kbuild-all/202502090806.KxEvxCZC-lkp@intel.com/

> +	pwm_get_state(st->cnv_pwm, &state);
> +	/*
> +	 * PWM subsystem generally rounds down, so requesting 2x minimum high
> +	 * time ensures that we meet the minimum high time in any case.
> +	 */
> +	state.duty_cycle = AD4695_T_CNVH_NS * 2;
> +	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
> +	if (ret)
> +		goto err_offload_exit_conversion_mode;
> +
> +	return 0;
> +
> +err_offload_exit_conversion_mode:
> +	/*
> +	 * We have to unwind in a different order to avoid triggering offload.
> +	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
> +	 * done after spi_offload_trigger_disable().
> +	 */
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	ad4695_exit_conversion_mode(st);
> +	goto err_disable_busy_output;
> +
> +err_offload_trigger_disable:
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +
> +err_disable_busy_output:
> +	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> +			  AD4695_REG_GP_MODE_BUSY_GP_EN);
> +
> +err_unoptimize_message:
> +	spi_unoptimize_message(&st->buf_read_msg);
> +
> +	return ret;
> +}

