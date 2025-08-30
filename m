Return-Path: <linux-iio+bounces-23499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1534B3CEF4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2B17F7F7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486912D24A6;
	Sat, 30 Aug 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HU0Rp16M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEA254848
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756581451; cv=none; b=dOaobGE2OMxiwgJD1bVmaai7eqHUTfrxaAsS8WpXaet7xaWg2AfKIkl4btETkCDzdl3c8cC9ldOI5n64CqBNFIyl0reZU+Jsr4jrPfd8paD/MZkdEskhejI7mBLnaO5o9COGYgyeVvMbEssWlB7Q8nU4Ah+j1azXwHbhHDj1De0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756581451; c=relaxed/simple;
	bh=WdVF2BAL9RHtgGJ8oH6ri2G6ozpp7byX6Zutkplyh5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFUecqEi3A3P+3LSCQGsa4yvC9Cq9itJWse6MKjH5VMCbOl3jOT4QC8PoGqGk1snFcnTTrk2XSe2fKkolEmro7Jxw6vta53ZqtOjN9PBHzRyHWhziMXoc35qrt/JsnovHRwwuFMAVkGyzU1XKmbLTo2D9CfPIoVblAeyLGI0BPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HU0Rp16M; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381e2079fso2595727a34.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756581447; x=1757186247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqGSGUwLUq1KdTzX1+8uUT3YWh+WYtzDjLeR09YION0=;
        b=HU0Rp16M0sOPq89dy9YjicCRV5eAWWNCrlfCjcJroWy5xbyLvivYe/fTMRb4t9vvRy
         6wZPcZFWE95RP3Fzq9IHHLi+lu2k+udMU1JaTlVr+sfiuGFEkxGX0BDROZwfOyIya/4q
         bW//OuXWJGJQS6mulVwlc4WpI1wWCLvq8W1S3akBJATuN3z/bUqrvMrdzTqrVOENxZmH
         P3NeCw5JmKXIkJeN8QoDWBXkpP3c+7iQS7J08Mvj2O+/TQ26HYM28Sxa6DbNCADtVST6
         pZHB0ZDmP8jM68E4giUJ7v8ADdctmjGGIgLk9d8pn0fvTfiGXITLWIooAcnMGHZ0P7cU
         lNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756581447; x=1757186247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqGSGUwLUq1KdTzX1+8uUT3YWh+WYtzDjLeR09YION0=;
        b=shiuleuaD8ttWKu7jfLNKugqsxREQJkg8uXHWuAmR2cwtbpdEPUbnuGB3co15E3toK
         rZep2ssVGmAR3wIWffFXTq+hgS0XhQ4C4WbzRc6iLAxjn1sbMswdOdv2tgnVf0/j1/uC
         OnHsV42OK31K807z2ARmJD/5FZIEnQJfxCYq848RQj1yw/g/2Y6FVGkZMv4BBdEniJd9
         zHeNRt9OujdX5W4oa4r7Ab0JF9nKYHHCuEGxgtAjT5hvcTMMq9Rq61k7djAwVdbBR9+X
         k1TROUBwdfRp/Qgr+Df++vM6OT6S8GpWLkweQj79iuobI+0/Zsr+d2Gsx33k4r+WBSAa
         0fpA==
X-Forwarded-Encrypted: i=1; AJvYcCVUESdkg9YDbQuC6MAOJcwdZyUfkx7IDWGqasX1dApfVHCq1Lwkx8JTrMVzZowSKEZkmC/Ssl4FSBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcVhpmQWKfzkscOu+7kwk5dufRRCRHkykHANhPOWpoBAkKxc1
	2kfT0EDSKSgWoVXuBe2c3baLsghLZZ8xTR5hxA5BkJtFrQZS4PSu5mECIXdptYJJ59M=
X-Gm-Gg: ASbGncswZs+xWZx/wrDThq1dl4+SvllUDA3QN+MwTWumRIm9fZOvMj36ui+tbNjwK0U
	pH2DHxMZv3/7uQ2gY95SlSoYuZ5jAj8kGFkKTL3tXfSaRwvsiuVuwX+x5BPd0EWyVPZJMjcjBvN
	DZeIsa1sKyBmic09Cf9fbQsPRu7MVkOB9jsojIqCXH2iapUiJqp3l9D0syvvP6Aa3cSmDgpdrrS
	N2kb3/QZl9RH1Kb7pH5EH4CrbKu8CEohYbNBjLc3Z8/14qDFdusa2pvMZkZdJM/hVqOkulKwnqJ
	BZ6zHW79Q/1sgc3IZi7xagB0IwC4Ttdw+7YBh+w/kyW10pRbeh3nTM8K6xHeoQ3pF82eZyRz/ar
	WnqTne0magxDfAOKnScRE5yHxTEK0H1xXmcnSovYpvbYcJYimYhun9QMNJRXcm6NFE6ah+p4kiS
	8Y7mPMY1SZAg==
X-Google-Smtp-Source: AGHT+IHIlNcGEM1D5+J0O6wJj6KCZd05RjnLhvwN2uXB1r6JWS0bniIEtPjY99c5/cSdvWwXX6E5sg==
X-Received: by 2002:a05:6830:dcc:b0:745:54e4:6da5 with SMTP id 46e09a7af769-74569c6972emr1783634a34.0.1756581446605;
        Sat, 30 Aug 2025 12:17:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457438873dsm57361a34.24.2025.08.30.12.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:17:26 -0700 (PDT)
Message-ID: <121b632b-1cac-41dc-a33e-f17b8e32523b@baylibre.com>
Date: Sat, 30 Aug 2025 14:17:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 7:45 PM, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
> 
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable control
> of the PGA through the channel scale interface.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad4030.c | 239 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 235 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 37ba00097efe..32157b3a0420 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -21,6 +21,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/log2.h>
> +#include <linux/minmax.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -42,6 +43,8 @@
>  #define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
>  #define     AD4030_REG_CHIP_GRADE_AD4632_16_GRADE	0x05
>  #define     AD4030_REG_CHIP_GRADE_AD4632_24_GRADE	0x02
> +#define     AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE	0x1E
> +#define     AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE	0x1C
>  #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
>  #define AD4030_REG_SCRATCH_PAD			0x0A
>  #define AD4030_REG_SPI_REVISION			0x0B
> @@ -121,6 +124,10 @@
>  /* Datasheet says 9.8ns, so use the closest integer value */
>  #define AD4030_TQUIET_CNV_DELAY_NS	10
>  
> +/* HARDWARE_GAIN */
> +#define ADAQ4616_PGA_PINS		2
> +#define ADAQ4616_GAIN_MAX_NANO		6666666667
> +
>  enum ad4030_out_mode {
>  	AD4030_OUT_DATA_MD_DIFF,
>  	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
> @@ -149,6 +156,20 @@ enum {
>  	AD4030_OFFLOAD_SCAN_TYPE_AVG,
>  };
>  
> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integers.
> + */
> +static const int ad4030_hw_gains[] = {
> +	333, 556, 2222, 6667,
> +};
> +
> +static const int ad4030_hw_gains_frac[4][2] = {
> +	{ 1, 3 },  /* 1/3 gain */
> +	{ 5, 9 },  /* 5/9 gain */
> +	{ 20, 9 }, /* 20/9 gain */
> +	{ 20, 3 }, /* 20/3 gain */
> +};
> +
>  struct ad4030_chip_info {
>  	const char *name;
>  	const unsigned long *available_masks;
> @@ -160,6 +181,7 @@ struct ad4030_chip_info {
>  	int num_voltage_inputs;
>  	unsigned int tcyc_ns;
>  	unsigned int max_sample_rate_hz;
> +	unsigned int num_pga_pins;

This is only usesd for boolean checks, so perhaps:

	bool has_pga;

>  };
>  
>  struct ad4030_state {
> @@ -183,6 +205,10 @@ struct ad4030_state {
>  	struct spi_offload *offload;
>  	struct spi_offload_trigger *offload_trigger;
>  	struct spi_offload_trigger_config offload_trigger_config;
> +	struct gpio_descs *pga_gpios;
> +	int pga_index;
> +	unsigned int scale_avail[ARRAY_SIZE(ad4030_hw_gains)][2];
> +	size_t scale_avail_size;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> @@ -239,7 +265,7 @@ struct ad4030_state {
>   * - voltage0-voltage1
>   * - voltage2-voltage3
>   */
> -#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
> +#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload, _pga) {		\
>  	.info_mask_shared_by_all =					\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
>  	.info_mask_shared_by_all_available =				\
> @@ -250,6 +276,7 @@ struct ad4030_state {
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
>  		BIT(IIO_CHAN_INFO_RAW),					\
>  	.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> +		(_pga ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
>  		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
> @@ -264,10 +291,16 @@ struct ad4030_state {
>  }
>  
>  #define AD4030_CHAN_DIFF(_idx, _scan_type)				\
> -	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 0)
>  
>  #define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
> -	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 0)
> +
> +#define ADAQ4216_CHAN_DIFF(_idx, _scan_type)				\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 0, 1)
> +
> +#define ADAQ4216_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
> +	__AD4030_CHAN_DIFF(_idx, _scan_type, 1, 1)
>  
>  static const int ad4030_rx_bus_width[] = {
>  	1, 2, 4, 8,
> @@ -429,6 +462,74 @@ static const struct regmap_config ad4030_regmap_config = {
>  	.max_register = AD4030_REG_DIG_ERR,
>  };
>  
> +static void ad4030_fill_scale_avail(struct ad4030_state *st)
> +{
> +	unsigned int mag_bits, tmp0, tmp1, i;
> +	u64 range;
> +
> +	/*
> +	 * The maximum precision of differential channels is retrieved from the
> +	 * chip properties. The output code of differential channels is in two's
> +	 * complement format (i.e. signed), so the MSB is the sign bit and only
> +	 * (precision_bits - 1) bits express voltage magnitude.
> +	 */
> +	mag_bits = st->chip->precision_bits - 1;

Seems odd that function below checks for if (scan_type->sign == 's') but this
doesn't.

> +
> +	for (i = 0; i < ARRAY_SIZE(ad4030_hw_gains); i++) {
> +		range = mult_frac(st->vref_uv, ad4030_hw_gains_frac[i][1],
> +				  ad4030_hw_gains_frac[i][0]);
> +		/*
> +		 * If range were in mV, we would multiply it by NANO below.
> +		 * Though, range is in µV so multiply it by MICRO only so the
> +		 * result after right shift and division scales output codes to
> +		 * millivolts.
> +		 */
> +		tmp0 = div_u64_rem(((u64)range * MICRO) >> mag_bits, NANO, &tmp1);
> +		st->scale_avail[i][0] = tmp0; /* Integer part */
> +		st->scale_avail[i][1] = tmp1; /* Fractional part */

Could just give the variables meaningful names and avoid the comments.

> +	}
> +}
> +
> +static int ad4030_set_pga_gain(struct ad4030_state *st)
> +{
> +	DECLARE_BITMAP(bitmap, ADAQ4616_PGA_PINS) = { };
> +
> +	bitmap_write(bitmap, st->pga_index, 0, 2);

Use ADAQ4616_PGA_PINS here instead of 2?

> +
> +	return gpiod_multi_set_value_cansleep(st->pga_gpios, bitmap);
> +}
> +
> +static int ad4030_set_pga(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int gain_int,
> +			  int gain_fract)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	unsigned int mag_bits;
> +	u64 gain_nano, tmp;
> +
> +	if (!st->pga_gpios)
> +		return -EINVAL;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);

Need to check for error.

> +	if (scan_type->sign == 's')
> +		mag_bits = st->chip->precision_bits - 1;
> +	else
> +		mag_bits = st->chip->precision_bits;
> +
> +	gain_nano = gain_int * NANO + gain_fract;
> +
> +	if (!in_range(gain_nano, 0, ADAQ4616_GAIN_MAX_NANO))
> +		return -EINVAL;
> +
> +	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << mag_bits, NANO);
> +	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
> +	st->pga_index = find_closest(gain_nano, ad4030_hw_gains,
> +				     ARRAY_SIZE(ad4030_hw_gains));
> +
> +	return ad4030_set_pga_gain(st);
> +}
> +
>  static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  				 struct iio_chan_spec const *chan,
>  				 int *val,
> @@ -455,7 +556,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  	*val2 = scan_type->realbits == 30 ? st->chip->precision_bits
>  					  : scan_type->realbits;
>  
> -	return IIO_VAL_FRACTIONAL_LOG2;
> +	/* The LSB of the 8-bit common-mode data is always vref/256. */
> +	if (scan_type->realbits == 8 || !st->chip->num_pga_pins)

`if` statement should be earlier so that we don't set *val, *val2
twice.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	*val = st->scale_avail[st->pga_index][0];
> +	*val2 = st->scale_avail[st->pga_index][1];
> +
> +	return IIO_VAL_INT_PLUS_NANO;
>  }
>  
>  static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
> @@ -654,6 +762,19 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
>  				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
>  }
>  
> +static int ad4030_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;

Unreachable code.

> +}
> +
>  static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
>  {
>  	struct ad4030_state *st = iio_priv(dev);
> @@ -891,6 +1012,15 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
>  		*length = ARRAY_SIZE(ad4030_average_modes);
>  		return IIO_AVAIL_LIST;
>  
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!st->pga_gpios)

		if (st->scale_avail_size == 1)

would make more sense here.

> +			*vals = (int *)st->scale_avail[st->pga_index];
> +		else
> +			*vals = (int *)st->scale_avail;
> +		*length = st->scale_avail_size * 2; /* print int and nano part */
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -966,6 +1096,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad4030_set_sampling_freq(indio_dev, val);
>  
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4030_set_pga(indio_dev, chan, val, val2);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1037,6 +1170,7 @@ static const struct iio_info ad4030_iio_info = {
>  	.read_avail = ad4030_read_avail,
>  	.read_raw = ad4030_read_raw,
>  	.write_raw = ad4030_write_raw,
> +	.write_raw_get_fmt = &ad4030_write_raw_get_fmt,
>  	.debugfs_reg_access = ad4030_reg_access,
>  	.read_label = ad4030_read_label,
>  	.get_current_scan_type = ad4030_get_current_scan_type,
> @@ -1318,6 +1452,51 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
>  							   IIO_BUFFER_DIRECTION_IN);
>  }
>  
> +static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
> +			    struct ad4030_state *st)
> +{
> +	unsigned int i;
> +	int pga_value;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
> +
> +	if (ret == -EINVAL) {
> +		/* Setup GPIOs for PGA control */
> +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					     "Failed to get PGA gpios.\n");
> +
> +		if (st->pga_gpios->ndescs != 2)

s/2/ADAQ4616_PGA_PINS/?

> +			return dev_err_probe(dev, -EINVAL,
> +					     "Expected 2 GPIOs for PGA control.\n");
> +
> +		st->scale_avail_size = ARRAY_SIZE(ad4030_hw_gains);
> +		st->pga_index = 0;
> +		return ad4030_set_pga_gain(st);

We already intialized the array to GPIO_OUT_LOW, so isn't calling
ad4030_set_pga_gain() here with index of 0 redundant?

> +	}
> +
> +	/* Set ADC driver to handle pin-strapped PGA pins setup */
> +	for (i = 0; i < ARRAY_SIZE(ad4030_hw_gains); i++) {
> +		if (pga_value != ad4030_hw_gains[i])
> +			continue;
> +
> +		st->pga_index = i;
> +		break;
> +	}
> +	if (i == ARRAY_SIZE(ad4030_hw_gains))
> +		return dev_err_probe(dev, -EINVAL, "Invalid PGA value: %d.\n",
> +				     pga_value);
> +
> +	st->scale_avail_size = 1;
> +	st->pga_gpios = NULL;

This seems reduandant.

> +
> +	return 0;
> +}
> +
>  static int ad4030_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -1360,6 +1539,14 @@ static int ad4030_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	if (st->chip->num_pga_pins > 0) {
> +		ret = ad4030_setup_pga(dev, indio_dev, st);
> +		if (ret)
> +			return ret;
> +
> +		ad4030_fill_scale_avail(st);
> +	}
> +
>  	ret = ad4030_config(st);
>  	if (ret)
>  		return ret;
> @@ -1611,12 +1798,54 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
>  	.max_sample_rate_hz = 500 * KILO,
>  };
>  
> +static const struct ad4030_chip_info adaq4216_chip_info = {
> +	.name = "adaq4216",
> +	.available_masks = ad4030_channel_masks,
> +	.channels = {
> +		ADAQ4216_CHAN_DIFF(0, ad4030_16_scan_types),
> +		AD4030_CHAN_CMO(1, 0),
> +		IIO_CHAN_SOFT_TIMESTAMP(2),
> +	},
> +	.offload_channels = {
> +		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_16_scan_types),
> +		AD4030_CHAN_CMO(1, 0),
> +	},
> +	.grade = AD4030_REG_CHIP_GRADE_ADAQ4216_GRADE,
> +	.precision_bits = 16,
> +	.num_voltage_inputs = 1,
> +	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * MEGA,
> +	.num_pga_pins = ADAQ4616_PGA_PINS,
> +};
> +
> +static const struct ad4030_chip_info adaq4224_chip_info = {
> +	.name = "adaq4224",
> +	.available_masks = ad4030_channel_masks,
> +	.channels = {
> +		ADAQ4216_CHAN_DIFF(0, ad4030_24_scan_types),
> +		AD4030_CHAN_CMO(1, 0),
> +		IIO_CHAN_SOFT_TIMESTAMP(2),
> +	},
> +	.offload_channels = {
> +		ADAQ4216_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),
> +		AD4030_CHAN_CMO(1, 0),
> +	},
> +	.grade = AD4030_REG_CHIP_GRADE_ADAQ4224_GRADE,
> +	.precision_bits = 24,
> +	.num_voltage_inputs = 1,
> +	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * MEGA,
> +	.num_pga_pins = ADAQ4616_PGA_PINS,
> +};
> +
>  static const struct spi_device_id ad4030_id_table[] = {
>  	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
>  	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
>  	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
>  	{ "ad4632-16", (kernel_ulong_t)&ad4632_16_chip_info },
>  	{ "ad4632-24", (kernel_ulong_t)&ad4632_24_chip_info },
> +	{ "adaq4216", (kernel_ulong_t)&adaq4216_chip_info },
> +	{ "adaq4224", (kernel_ulong_t)&adaq4224_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad4030_id_table);
> @@ -1627,6 +1856,8 @@ static const struct of_device_id ad4030_of_match[] = {
>  	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
>  	{ .compatible = "adi,ad4632-16", .data = &ad4632_16_chip_info },
>  	{ .compatible = "adi,ad4632-24", .data = &ad4632_24_chip_info },
> +	{ .compatible = "adi,adaq4216", .data = &adaq4216_chip_info },
> +	{ .compatible = "adi,adaq4224", .data = &adaq4224_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad4030_of_match);


