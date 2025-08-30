Return-Path: <linux-iio+bounces-23506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03501B3CF3C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FB81644E0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C02E093C;
	Sat, 30 Aug 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rk8Zy+s8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19222E092D
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756584879; cv=none; b=VgDwVC6cfWih0dGwn6fxjxmm662xVHyQU0nDkdnGEHTOtcCtLVRMOuCjJxoc0kUffr7gn9Q99HKS9LFpmb2TtijBF3Z9CIzwjncD67CPcL4Z71x48N10m5vhULKVU+ZUu7ucwgAMAppBNeFVnuKE4w1W456mx316dG7gXm+Ml4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756584879; c=relaxed/simple;
	bh=J7KELir1yZZsD5gL9nXbuR7LDEcaaK3JfHSH7jKNTyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpiECt4ClLxdPMOGjqg1NMYelfe2mG4FuRbAglHZnw1ADuRWcXcWucol1rU0uHOS3LFZXDD9WmFhiMcKp5WzLlO0aY6LU+SKxTcWvlxihH7j5Z5WazMwd359hsfGILVLRUwMQaDDws+HCWuw6Abw0GHJ60OwpDDUWUw91f51Yos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rk8Zy+s8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74542b1b2bcso3330581a34.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756584875; x=1757189675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nufrg1DUK9qiyJefkSfS4lUJPzfDc+a/Y59sgpg2UA8=;
        b=Rk8Zy+s87TKptlLY5cfe9c5g6cw3L/K6m9YBW3uglbzAndvII1BlQrXUnugtrFwaO/
         uhyylmyAkvnBZQbSu6g0c3EuqgGrLyjUsdS/MPwakdOgoRSq6ymYB3q7AmguincCZ9t7
         WHs7NEUtgSs8skdhLPwWQpJYAjHBbVb2c2hcb+9I8DCz4P/O/2RVuUUd+YMYyXEeLxrV
         H78A8ntjJwye0WKlM+9tCqgcP/JawAKKZdjO4SJfrMY4ZhUnHXimezAiq79ydf/GkVRG
         qsaHwtFQvQiLv29FLKh23feWWvUq2mSZbMcGzbsScPon3qAoJiqnEqQs0Xk0Fhso/yXn
         kVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756584875; x=1757189675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nufrg1DUK9qiyJefkSfS4lUJPzfDc+a/Y59sgpg2UA8=;
        b=mOkne6W0HvmESHPu6dpEUBieUK6cQhHxi7YGlPZ8I4osZxiuHP4Lv40lTluL7JREAG
         h5ta7OM8jO1ATJoAtuL/PVVhWhm9cODxrBDX7PX6M7i0SxNZhwLwU8H5BwxxUG+Cs64O
         pa8gfDQsunJXSFlM2s0Et1KQlqy3ENuWdP5kjklUUUh+HFoqM33DSTunL2aJqkRVvjuu
         fyW+XdKIqXcOQxSe68lhQkVUHZE5/BnK9VsGDPh9RdMYeXyckdLiB5arwygRQ+28Efgv
         VtyT83TIFJerhhvKvM1ny7Hb2mZjaLFxlmYvTjxeMSykrEfIUQxZMEbmuWDmycNLAlSd
         1b0g==
X-Forwarded-Encrypted: i=1; AJvYcCX9yPvb5peXmYjV+0OAfW03GCvx/nfoVPjwQIwOc2jIGytuqCRrUetWtUADx4JWGirldVxXGVWOe94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB4s/J19dDLaTwa/bJjvyTA8WvTma/dleox2omhNSTq+uivC6
	ahgP12c6fb+yu6N2rdenfkTJoTbDkXoG4dUX6cKr7qqNzc6AShV5LLZJAwCvZTqLSSU=
X-Gm-Gg: ASbGncuEc4VL1unpcL+Hf/PBnyNFW9ATeTYMuNlt3O01+xSY2mVmPY3qqud9YCoQCKX
	Evs7rwRvYqaZopNTeTzXaVhp0ajdln640qnIeOVfgPd8SOrJco46Hu7JXFFBxTKZFC1rmMtCj2r
	PjwHwEyig5pKo55e7J+nodGGk8w56nq5GgdORWNx9eK9GfnwVxwIV/4tjnpnM0hyoKKZhqgBc3k
	I9P9yF2WwOqT3Kdup7WYao0yaeVGegXu8fRpvofPP0SHzQ7PEnELqT+TX1mDf0CQoUGZt/Zvt0b
	7A0UcVV9nf/jU5Rxp2eIiEW9ZSkwysfaLvYM57w4nQxxzzbyyw1w9O2B4wbjOlOgklPB53EQiHu
	kUQ2ceIcXOZhNr0U8bKI1dOLA7YVv8r6IMl0HppfzeQvfxWCgS5jyfKpO36bKXEN48DegEuz+Ur
	U=
X-Google-Smtp-Source: AGHT+IFXcKQTKtyYvAqc5v4L6TDXhF+IrPaumiByk5aQdzQvtT62kDXjKiwYg9KMnRYoAASLijiqZA==
X-Received: by 2002:a05:6808:1993:b0:435:de7e:8cc3 with SMTP id 5614622812f47-437f7d20d10mr1263091b6e.6.1756584874825;
        Sat, 30 Aug 2025 13:14:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4380001d11asm53315b6e.16.2025.08.30.13.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 13:14:33 -0700 (PDT)
Message-ID: <b024bd46-f1bd-4d9f-9d91-15ba18b9864f@baylibre.com>
Date: Sat, 30 Aug 2025 15:14:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, tgamblin@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:42 PM, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve
> such high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates.  Add SPI offload support for
> AD4030 and similar ADCs so to enable ADC data capture at maximum sample
> rates.
> 
> Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Trevor Gamblin <tgamblin@baylibre.com>
> Cc: Axel Haslam <ahaslam@baylibre.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Most of the code in this patch is based on work from Sergiu Cuciurean, Nuno Sa,
> Axel Haslam, and Trevor Gamblin, hence the many co-developed-by tags. I also
> draw inspiration from other drivers supporting SPI offload, many of them written
> by David Lechner.
> 
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4030.c | 400 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 378 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6de2abad0197..7cfbc07e7f77 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -49,6 +49,8 @@ config AD4030
>  	depends on GPIOLIB
>  	select REGMAP
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMA
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 82784593f976..68f76432dbfd 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -15,11 +15,15 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/unaligned.h>
>  #include <linux/units.h>
> @@ -111,6 +115,8 @@
>  #define AD4632_TCYC_NS			2000
>  #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
>  #define AD4030_TRESET_COM_DELAY_MS	750
> +/* Datasheet says 9.8ns, so use the closest integer value */
> +#define AD4030_TQUIET_CNV_DELAY_NS	10
>  
>  enum ad4030_out_mode {
>  	AD4030_OUT_DATA_MD_DIFF,
> @@ -120,7 +126,7 @@ enum ad4030_out_mode {
>  	AD4030_OUT_DATA_MD_32_PATTERN,
>  };
>  
> -enum {
> +enum ad4030_lane_mode {
>  	AD4030_LANE_MD_1_PER_CH,
>  	AD4030_LANE_MD_2_PER_CH,
>  	AD4030_LANE_MD_4_PER_CH,
> @@ -130,17 +136,21 @@ enum {
>  enum {
>  	AD4030_SCAN_TYPE_NORMAL,
>  	AD4030_SCAN_TYPE_AVG,
> +	AD4030_OFFLOAD_SCAN_TYPE_NORMAL,
> +	AD4030_OFFLOAD_SCAN_TYPE_AVG,
>  };
>  
>  struct ad4030_chip_info {
>  	const char *name;
>  	const unsigned long *available_masks;
>  	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
> +	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
>  	u8 grade;
>  	u8 precision_bits;
>  	/* Number of hardware channels */
>  	int num_voltage_inputs;
>  	unsigned int tcyc_ns;
> +	unsigned int max_sample_rate_hz;
>  };
>  
>  struct ad4030_state {
> @@ -148,11 +158,20 @@ struct ad4030_state {
>  	struct regmap *regmap;
>  	const struct ad4030_chip_info *chip;
>  	struct gpio_desc *cnv_gpio;
> +	struct pwm_device *conv_trigger;
> +	struct pwm_waveform conv_wf;
>  	int vref_uv;
>  	int vio_uv;
>  	int offset_avail[3];
>  	unsigned int avg_log2;
>  	enum ad4030_out_mode mode;
> +	enum ad4030_lane_mode lane_mode;
> +	/* offload sampling spi message */
> +	struct spi_transfer offload_xfer;
> +	struct spi_message offload_msg;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> +	struct spi_offload_trigger_config offload_trigger_config;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> @@ -209,12 +228,13 @@ struct ad4030_state {
>   * - voltage0-voltage1
>   * - voltage2-voltage3
>   */
> -#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
> +#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
>  	.info_mask_shared_by_all =					\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
>  	.info_mask_shared_by_all_available =				\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\

Sampling freqency should be shared_by_all, not separate. There is only
one conversion trigger and this is simultaneous sampling.

>  		BIT(IIO_CHAN_INFO_CALIBSCALE) |				\
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
>  		BIT(IIO_CHAN_INFO_RAW),					\
> @@ -232,12 +252,23 @@ struct ad4030_state {
>  	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
>  }
>  
> +#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
> +
> +#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
> +
>  static const int ad4030_average_modes[] = {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
>  	65536,
>  };
>  
> +static const struct spi_offload_config ad4030_offload_config = {
> +	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
> +			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
>  static int ad4030_enter_config_mode(struct ad4030_state *st)
>  {
>  	st->tx_data[0] = AD4030_REG_ACCESS;
> @@ -385,7 +416,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  	struct ad4030_state *st = iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
>  
> -	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);

Is this actually a bug fix? Won't this change the scale of
the common mode voltage channels?

>  	if (IS_ERR(scan_type))
>  		return PTR_ERR(scan_type);
>  
> @@ -458,6 +489,96 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static void ad4030_get_sampling_freq(const struct ad4030_state *st, int *freq)
> +{
> +	*freq = DIV_ROUND_CLOSEST_ULL(NANO, st->conv_wf.period_length_ns);
> +}
> +
> +static int __ad4030_set_sampling_freq(struct ad4030_state *st, unsigned int freq)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform conv_wf = { };
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	u32 mode;
> +	int ret;
> +	u64 target = AD4030_TCNVH_NS;
> +
> +	conv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		conv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->conv_trigger, &conv_wf);
> +		if (ret)
> +			return ret;
> +		target += 10;
> +	} while (conv_wf.duty_length_ns < 10);
> +
> +	offload_period_ns = conv_wf.period_length_ns;
> +
> +	ret = regmap_read(st->regmap, AD4030_REG_MODES, &mode);
> +	if (ret)
> +		return ret;
> +	if (FIELD_GET(AD4030_REG_MODES_MASK_OUT_DATA_MODE, mode) == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {

Since this depends on the oversampling ration, we need to defer this
until we start a buffered read. Otherwise if someone sets sampling
frequency first and the changes the oversampling ratio later, then
the PWM period will not be correct.

Alternatly, we could update this both when sampling freqency and
when oversampling ratio are updated. This would allow returning an
error if the oversampling ratio is too big for the requested
sampling frequency.

> +		u32 avg;
> +
> +		ret = regmap_read(st->regmap, AD4030_REG_AVG, &avg);
> +		if (ret)
> +			return ret;
> +
> +		offload_period_ns <<= FIELD_GET(AD4030_REG_AVG_MASK_AVG_VAL, avg);
> +	}
> +
> +	config->periodic.frequency_hz =  DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							  offload_period_ns);
> +
> +	/*
> +	 * The hardware does the capture on zone 2 (when spi trigger PWM
> +	 * is used). This means that the spi trigger signal should happen at
> +	 * tsync + tquiet_con_delay being tsync the conversion signal period
> +	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
> +	 *
> +	 * The PWM waveform API only supports nanosecond resolution right now,
> +	 * so round this setting to the closest available value.
> +	 */
> +	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += 10;
> +
> +	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
> +
> +	st->conv_wf = conv_wf;
> +
> +	return 0;
> +}
> +
> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (PTR_ERR_OR_ZERO(st->offload))
> +		return -EINVAL;
> +
> +	if (!freq || freq > st->chip->max_sample_rate_hz)
> +		return -EINVAL;
> +
> +	ret = __ad4030_set_sampling_freq(st, freq);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}
>  static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
>  				      struct iio_chan_spec const *chan,
>  				      int gain_int,
> @@ -618,7 +739,7 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
>  	unsigned int i;
>  	int ret;
>  
> -	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);

Since a single conversion doesn't use offload, I don't think we want to change this.

>  	if (IS_ERR(scan_type))
>  		return PTR_ERR(scan_type);
>  
> @@ -774,6 +895,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
>  		*val = BIT(st->avg_log2);
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (PTR_ERR_OR_ZERO(st->offload))
> +			return -EINVAL;
> +
> +		ad4030_get_sampling_freq(st, val);
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -814,6 +942,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		return ad4030_set_avg_frame_len(indio_dev, val);
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:

This casts val from signed to unsigned, so probably should check for val < 0 first.

> +		return ad4030_set_sampling_freq(indio_dev, val);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -868,7 +999,11 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
>  {
>  	struct ad4030_state *st = iio_priv(indio_dev);
>  
> -	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
> +	if (PTR_ERR_OR_ZERO(st->offload))
> +		return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
> +	else
> +		return st->avg_log2 ? AD4030_OFFLOAD_SCAN_TYPE_AVG :
> +				      AD4030_OFFLOAD_SCAN_TYPE_NORMAL;
>  }
>  
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
> @@ -903,6 +1038,67 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret < 0)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->conv_trigger, &st->conv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +	return 0;
> +out_pwm_disable:
> +	pwm_disable(st->conv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);
> +	if (ret)
> +		dev_warn(&st->spi->dev,

		dev_err()

would even be appropriate since we can't do anything else, the hardware
is broken.

> +			 "couldn't reenter register configuration mode\n");
> +	return ret;
> +}
> +
> +static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	pwm_disable(st->conv_trigger);
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);

Probably should disable offload first, otherwise, we could possibly get
bad data after stopping CNV trigger but before stopping offload trigger.

> +
> +	spi_unoptimize_message(&st->offload_msg);
> +
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);
> +	if (ret)
> +		dev_warn(&st->spi->dev,
> +			 "couldn't reenter register configuration mode\n");
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
> +	.postenable = &ad4030_offload_buffer_postenable,
> +	.predisable = &ad4030_offload_buffer_predisable,
> +};
> +
>  static int ad4030_regulators_get(struct ad4030_state *st)
>  {
>  	struct device *dev = &st->spi->dev;
> @@ -972,6 +1168,44 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
>  	return 0;
>  }
>  
> +static int ad4030_pwm_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +
> +	st->conv_trigger = devm_pwm_get(dev, "cnv");

The DT bindings didn't have pwm-names, so this should be NULL.

> +	if (IS_ERR(st->conv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
> +				     "Failed to get cnv pwm\n");
> +
> +	/*
> +	 * Preemptively disable the PWM, since we only want to enable it with
> +	 * the buffer
> +	 */
> +	pwm_disable(st->conv_trigger);
> +
> +	return 0;
> +}
> +
> +static void ad4030_prepare_offload_msg(struct ad4030_state *st)
> +{
> +	u8 data_width = st->chip->precision_bits;
> +	u8 offload_bpw;
> +
> +	if (st->lane_mode == AD4030_LANE_MD_INTERLEAVED)
> +		/*
> +		 * This means all channels on 1 lane.
> +		 */
> +		offload_bpw = data_width * st->chip->num_voltage_inputs;

This looks suspicious. I would suggest to just not support interleaved
with SPI offload.

If we do want to support it we will need to fix the HDL so that this is
not necessary. And likely we will need some kind of devicetree binding
to say that there is a descrambler between the SPI offload and the DMA
buffer so that we know that the data will actually come out correct.

> +	else
> +		offload_bpw  = data_width;
> +
> +	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;

Why using slower speed for offload?

> +	st->offload_xfer.bits_per_word = offload_bpw;
> +	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(offload_bpw));

Thanks to Andy, we have spi_bpw_to_bytes() to use here.

> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);

This currently only handles the case where one channel is enabled and
oversampling is disabled. 

> +}
> +
>  static int ad4030_config(struct ad4030_state *st)
>  {
>  	int ret;

...

> @@ -1050,24 +1309,55 @@ static int ad4030_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
>  				     "Failed to get cnv gpio\n");
>  
> -	/*
> -	 * One hardware channel is split in two software channels when using
> -	 * common byte mode. Add one more channel for the timestamp.
> -	 */
> -	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
>  	indio_dev->name = st->chip->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad4030_iio_info;
> -	indio_dev->channels = st->chip->channels;
> -	indio_dev->available_scan_masks = st->chip->available_masks;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> -					      ad4030_trigger_handler,
> -					      &ad4030_buffer_setup_ops);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to setup triggered buffer\n");
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	/* Fall back to low speed usage when no SPI offload available. */
> +	if (ret == -ENODEV) {
> +		/*
> +		 * One hardware channel is split in two software channels when
> +		 * using common byte mode. Add one more channel for the timestamp.
> +		 */
> +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
> +		indio_dev->channels = st->chip->channels;
> +		indio_dev->available_scan_masks = st->chip->available_masks;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      iio_pollfunc_store_time,
> +						      ad4030_trigger_handler,
> +						      &ad4030_buffer_setup_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup triggered buffer\n");
> +
> +	} else {
> +		/*
> +		 * One hardware channel is split in two software channels when
> +		 * using common byte mode. Offloaded SPI transfers can't support
> +		 * software timestamp so no additional timestamp channel is added.
> +		 */
> +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
> +		indio_dev->channels = st->chip->offload_channels;
> +		indio_dev->available_scan_masks = st->chip->available_masks;

I don't think scan_masks works here since this uses a DMA buffer and we can't
demux any extra channels that were enabled. Instead, I think we need to implement
a .validate_scan callback for the offload case to make sure the enabled channels
are one of the allowed combinations.

> +		ret = ad4030_spi_offload_setup(indio_dev, st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup SPI offload\n");
> +
> +		ret = ad4030_pwm_get(st);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to get PWM: %d\n", ret);
> +
> +		ret = __ad4030_set_sampling_freq(st, st->chip->max_sample_rate_hz);
> +		ad4030_prepare_offload_msg(st);

The message needs to change depending on the oversampling ratio and if
the common mode channel is enabled, so we can't do this in probe.

> +	}
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> @@ -1103,6 +1393,20 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
>  		.shift = 2,
>  		.endianness = IIO_BE,
>  	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 24,
> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_CPU,
> +	},
>  };
>  
>  static const struct iio_scan_type ad4030_16_scan_types[] = {
> @@ -1119,7 +1423,21 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
>  		.realbits = 30,
>  		.shift = 2,
>  		.endianness = IIO_BE,
> -	}
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 16,
> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_CPU,
> +	},
>  };

Instead of extending these arrays, I would just make 2 new arrays.



