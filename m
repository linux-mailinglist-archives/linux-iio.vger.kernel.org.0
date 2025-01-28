Return-Path: <linux-iio+bounces-14651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586EA202F6
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F53A7713
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 01:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DD156220;
	Tue, 28 Jan 2025 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ldk66S8D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DE2BAE3
	for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2025 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027485; cv=none; b=t8jSaOEgRfokIBuwGZHpwLSptri44xdTfOkOM+ObxNoDPOuyTSyeG9z/3xmBnNg7LXBLmqXEauBmrr1DkPpz4n1peKN9P5Sc/P/zem/uGwIffu3RCJY5iyMD4J6lXI7IwbpQUXf/A0DexaRwG7vZLwRO5cNFuyjsCpF8FQXnA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027485; c=relaxed/simple;
	bh=W2vtj8Inztk5I57FahtBoIk4QOlTJBrTtZTrvoqVlbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTfS0GvbBMk7eGU8h9Dmg9tgqMnRW+l6PuF2ET+x++a9z19KOqD7GiTR2H1p7iP2szYF9xJE50OQiSTwOb4jmsDN2oTTlKLUJ07OIecfHyjSYT+cW1ibdx4c+J8DhiJDhArs7RetzBVaAPn1U8ktyU8277iQLImRWJjirVjPM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ldk66S8D; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so781077eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 17:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738027481; x=1738632281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25zSxeGpn8hecS+X/dOVDQ7FU4vVOQilBYDHN/cOKNs=;
        b=Ldk66S8D2As05UlQwI2KRLTWGIwvz3ZD9ydtOcziv3ShUPz3UwoloUeDp8o9trwW5U
         BORHXaF1I8rDH7XfGzYHlNDvuy07aBNYhA+OkOlyedDgji3z8npPJu3X16mGRcG9+xLs
         SLDFHf9GacmyW3l+4ffN94P3C5uCmHBQAhjw6KcGRvtgBsh/Ptb64FVpafb+GHT0tIwM
         lc5wdFkpVq042EtUKouk/G1HYZxm05nPH5RV5BhUBpR+2dWd4eDI/G3ElixfYDlFyFT2
         /m+8d8F2cDSLMXJ597d2Um8UYCBNmG2052vzObNpq5L08o6SF2XaFcV6E2G4HqlK+zpl
         wgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738027481; x=1738632281;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25zSxeGpn8hecS+X/dOVDQ7FU4vVOQilBYDHN/cOKNs=;
        b=QtHubdTMZKlhkY4zpIEMTiPDl+gmmZF3fmTx6HPb582uyIJ16ZBeZLqydRMJZ/oMVY
         J0IRDheor+S08nepnUd6g9CVbYzLgw1m6hDPPLydbvnX0VyscE8BFSlQKs0sftAquiD3
         LbIkZW8X4hd4xG8pA7QwC5XtdeeIOr8LeU0H3qLD0CpzKK6CWUhMhp3wWdODTjh+Alae
         j7ey2674XeuHIJ+/IIKwTWr7FjVX1iJy3BV4QO8Py3Tz/qTk02Urvkby0Y+Ls+y9qm94
         VtXb4Pl0YIxxRxjlek6gsaqzQkaVQa9n0RIzWqE0oOpS/o9ybWgdTwzzcnYumGIsmaKp
         NI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrfqSAhIOICd84bYQRHW/cTndbKR+aX2qZ+BKeI7oO9iMEjp1hD2di4JDr7JhZ8iwSPlkqA+Jvqk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhC7EL3l7OTU1BBQTyrlhynz7z2VGVvqZFIXIHWLI679JfmaCc
	riICTp5Q4cjX7vYcs2OeB53cglFS85HTS+WtRCnMeU9Sn1ph3/mvagWyRNUfLjU=
X-Gm-Gg: ASbGncueY8ZcIQ8BUjOhjUaZKCa7nWmWwr7HwvtbNHkuc7Y8nZGuhHpSriHKAUdmv0T
	aWkKNRoeoxdpDEoLsGXGjV/nnqkzhLaJ4cf1U61p1VihcctjioveLxr5gfDCccqKO7rMZTLRBJy
	BPt32qH7fRK4Ox6Ew4NTKDqgP61OEp5j8fVPPoxhQ/NdOCgjWnzluhkDh6vuBsDF6lRI9vfQ9XB
	wA+alKT2EsybJWpDocDfjpgLHuFdkRB9c63Wn9zirfroOj4qt/YUZForlGRTHst7iXzhKr41JYY
	fanDJoGoQxEbhlZC3AsyQoDIZJt6V0o16R//9SywQg==
X-Google-Smtp-Source: AGHT+IFm+m8KoCPBm2gvMIiTXh0zvX9mDr+eiz+6ju/W6hF+2+7ukxKF/iJGH4PCISP14uicVLRF8w==
X-Received: by 2002:a05:6870:6981:b0:29f:f1cc:12a5 with SMTP id 586e51a60fabf-2b1c0c025c8mr25742739fac.31.1738027480964;
        Mon, 27 Jan 2025 17:24:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f1d86c1sm3119505fac.23.2025.01.27.17.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 17:24:39 -0800 (PST)
Message-ID: <de145d80-1b2f-4107-8f8d-612024e1dd10@baylibre.com>
Date: Mon, 27 Jan 2025 19:24:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com, PopPaul2021 <paul.pop@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:14 AM, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables SINC3 and WIDEBAND
> filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features.
> 
> Co-developed-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Decimation_rate attribute replaced for oversampling_ratio.
> ---
>  drivers/iio/adc/ad7768-1.c | 389 +++++++++++++++++++++++++++++++------
>  1 file changed, 325 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 01ccbe0aa708..6d0b430a8d54 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -5,6 +5,7 @@
>   * Copyright 2017 Analog Devices Inc.
>   */
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -17,6 +18,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
> +#include "linux/util_macros.h"

nit: alphabetical order

>  #include <linux/spi/spi.h>
>  
>  #include <linux/iio/buffer.h>
> @@ -77,6 +79,10 @@
>  #define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
>  #define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
>  
> +/* AD7768_SINC3_DEC_RATE */
> +#define AD7768_SINC3_DEC_RATE_MSB_MSK	GENMASK(12, 8)
> +#define AD7768_SINC3_DEC_RATE_LSB_MSK	GENMASK(7, 0)
> +
>  /* AD7768_REG_CONVERSION */
>  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
>  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> @@ -97,6 +103,18 @@
>  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
>  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
>  
> +/* Decimation Rate Limits */
> +#define SINC5_DEC_RATE_MIN		8
> +#define SINC5_DEC_RATE_MAX		1024
> +#define SINC3_DEC_RATE_MIN		32
> +#define SINC3_DEC_RATE_MAX		163840
> +#define WIDEBAND_DEC_RATE_MIN		32
> +#define WIDEBAND_DEC_RATE_MAX		1024
> +
> +enum {
> +	DEC_RATE,

Odd to have enum with one member. Also should have AD7768_ namespace prefix.

> +};
> +
>  enum ad7768_conv_mode {
>  	AD7768_CONTINUOUS,
>  	AD7768_ONE_SHOT,
> @@ -118,22 +136,12 @@ enum ad7768_mclk_div {
>  	AD7768_MCLK_DIV_2
>  };
>  
> -enum ad7768_dec_rate {
> -	AD7768_DEC_RATE_32 = 0,
> -	AD7768_DEC_RATE_64 = 1,
> -	AD7768_DEC_RATE_128 = 2,
> -	AD7768_DEC_RATE_256 = 3,
> -	AD7768_DEC_RATE_512 = 4,
> -	AD7768_DEC_RATE_1024 = 5,
> -	AD7768_DEC_RATE_8 = 9,
> -	AD7768_DEC_RATE_16 = 10
> -};
> -
> -struct ad7768_clk_configuration {
> -	enum ad7768_mclk_div mclk_div;
> -	enum ad7768_dec_rate dec_rate;
> -	unsigned int clk_div;
> -	enum ad7768_pwrmode pwrmode;
> +enum ad7768_flt_type {
> +	SINC5,
> +	SINC5_DEC_X8,
> +	SINC5_DEC_X16,
> +	SINC3,
> +	WIDEBAND
>  };
>  
>  enum ad7768_scan_type {
> @@ -145,18 +153,12 @@ static const int ad7768_mclk_div_rates[4] = {
>  	16, 8, 4, 2,
>  };
>  
> -static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
> -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
> -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
> -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
> -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
> -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
> -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
> -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
> -	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
> -	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
> +static const int ad7768_dec_rate_values[6] = {
> +	32, 64, 128, 256, 512, 1024,
> +};
> +
> +static const char * const ad7768_filter_enum[] = {
> +	"sinc5", "sinc3", "wideband"

Do we also need to consider "sinc3+rej60" to account for the EN_60HZ_REJ bit
in the DIGITAL_FILTER register?

>  };
>  
>  static const struct iio_scan_type ad7768_scan_type[] = {
> @@ -176,12 +178,32 @@ static const struct iio_scan_type ad7768_scan_type[] = {
>  	},
>  };
>  
> +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan);
> +static int ad7768_set_fil_type_attr(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan, unsigned int filter);
> +
> +static const struct iio_enum ad7768_flt_type_iio_enum = {
> +	.items = ad7768_filter_enum,
> +	.num_items = ARRAY_SIZE(ad7768_filter_enum),
> +	.set = ad7768_set_fil_type_attr,
> +	.get = ad7768_get_fil_type_attr,
> +};
> +
> +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> +	{ },
> +};
> +
>  static const struct iio_chan_spec ad7768_channels[] = {
>  	{
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),

info_mask_shared_by_type might be safer in case we ever have to add a non-
voltage channel for some reason.

> +		.ext_info = ad7768_ext_info,
>  		.indexed = 1,
>  		.channel = 0,
>  		.scan_index = 0,
> @@ -201,7 +223,9 @@ struct ad7768_state {
>  	struct gpio_chip gpiochip;
>  	unsigned int gpio_avail_map;
>  	unsigned int mclk_freq;
> -	unsigned int dec_rate;
> +	unsigned int mclk_div;
> +	unsigned int oversampling_ratio;
> +	enum ad7768_flt_type filter_type;
>  	unsigned int samp_freq;
>  	struct completion completion;
>  	struct iio_trigger *trig;
> @@ -223,6 +247,9 @@ struct ad7768_state {
>  	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +static int ad7768_set_freq(struct ad7768_state *st,
> +			   unsigned int freq);

Would be nice if we can reorder functions to avoid forward declaration.

> +
>  static int ad7768_spi_reg_read(void *context, unsigned int addr,
>  			       unsigned int *val)
>  {
> @@ -281,6 +308,31 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
>  	return 0;
>  }
>  
> +static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
> +{
> +	unsigned int mclk_div_value;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	ret = ad7768_spi_reg_read(st, AD7768_REG_POWER_CLOCK, &mclk_div_value, 1);
> +	if (ret)
> +		return ret;
> +
> +	mclk_div_value &= ~(AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK);
> +	/* Set mclk_div value */
> +	mclk_div_value |= AD7768_PWR_MCLK_DIV(mclk_div);
> +	/*
> +	 * Set power mode based on mclk_div value.
> +	 * ECO_MODE is only recommended for MCLK_DIV 16
> +	 */
> +	if (mclk_div > AD7768_MCLK_DIV_16)
> +		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_FAST_MODE);
> +	else
> +		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
> +
> +	return regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, mclk_div_value);

Can we do this with regmap_update_bits() and FIELD_PREP() instead?

> +}
> +
>  static int ad7768_set_mode(struct ad7768_state *st,
>  			   enum ad7768_conv_mode mode)
>  {
> @@ -349,23 +401,183 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int ad7768_set_dig_fil(struct ad7768_state *st,
> -			      enum ad7768_dec_rate dec_rate)
> +static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
> +				     unsigned int dec_rate)
> +{
> +	unsigned int dec_rate_msb, dec_rate_lsb, max_dec_rate;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	/*
> +	 * Maximum dec_rate is limited by the MCLK_DIV value
> +	 * and by the ODR. The edge case is for MCLK_DIV = 2
> +	 * ODR = 50 SPS.
> +	 * max_dec_rate <= MCLK / (2 * 50)
> +	 */
> +	max_dec_rate = st->mclk_freq / 100;
> +	dec_rate = clamp_t(unsigned int, dec_rate, 32, max_dec_rate);
> +	/*
> +	 * Calculate the equivalent value to sinc3 decimation ratio
> +	 * to be written on the SINC3_DECIMATION_RATE register:
> +	 *  Value = (DEC_RATE / 32) -1
> +	 */
> +	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
> +	dec_rate_msb = FIELD_GET(AD7768_SINC3_DEC_RATE_MSB_MSK, dec_rate);
> +	dec_rate_lsb = FIELD_GET(AD7768_SINC3_DEC_RATE_LSB_MSK, dec_rate);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_MSB, dec_rate_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_LSB, dec_rate_lsb);
> +	if (ret)
> +		return ret;

Can we use regmap_bulk_write()?

> +
> +	st->oversampling_ratio = (dec_rate + 1) * 32;
> +
> +	return 0;
> +}
> +
> +static int ad7768_set_dec_rate(struct ad7768_state *st, unsigned int dec_rate)
>  {
> +	unsigned int mode, dec_rate_reg;
> +	int ret;
> +
> +	dec_rate_reg = find_closest(dec_rate, ad7768_dec_rate_values,
> +				    ARRAY_SIZE(ad7768_dec_rate_values));
> +
> +	guard(mutex)(&st->lock);
> +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode &= ~AD7768_DIG_FIL_DEC_MSK;
> +	mode |= AD7768_DIG_FIL_DEC_RATE(dec_rate_reg);
> +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);

regmap_update_bits()?

> +	if (ret)
> +		return ret;
> +
> +	st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_reg];
> +
> +	return 0;
> +}
> +
> +static int ad7768_set_filter_type(struct iio_dev *dev,
> +				  enum ad7768_flt_type filter_type)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
>  	unsigned int mode;
>  	int ret;
>  
> -	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
> -		mode = AD7768_DIG_FIL_FIL(dec_rate);
> -	else
> -		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> +	guard(mutex)(&st->lock);

Lock was removed in previous patch, so shouldn't be using it here.

> +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode &= ~AD7768_DIG_FIL_FIL_MSK;
> +	mode |= AD7768_DIG_FIL_FIL(filter_type);
>  
>  	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
>  	if (ret < 0)
>  		return ret;

Looks like we could drop the helper function and just use regmap_update_bits()
directly now.

>  
> -	/* A sync-in pulse is required every time the filter dec rate changes */
> -	return ad7768_send_sync_pulse(st);
> +	st->filter_type = filter_type;
> +
> +	return 0;
> +}
> +
> +static int ad7768_configure_dig_fil(struct iio_dev *dev,
> +				    enum ad7768_flt_type filter_type,
> +				    unsigned int dec_rate)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +
> +	if (filter_type == SINC3) {

Using a switch statement instead would be more like other IIO code.

> +		ret = ad7768_set_filter_type(dev, SINC3);
> +		if (ret)
> +			return ret;
> +
> +		/* recalculate the decimation for this filter mode */
> +		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);

Just return directly.

> +	} else if (filter_type == WIDEBAND) {
> +		ret = ad7768_set_filter_type(dev, filter_type);
> +		if (ret)
> +			return ret;
> +
> +		/* recalculate the decimation rate */
> +		ret = ad7768_set_dec_rate(st, dec_rate);
> +	} else {
> +		/* For SINC5 filter */
> +		/* Decimation 8 and 16 are set in the digital filter field */
> +		if (dec_rate <= 8) {
> +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X8);
> +			if (ret)
> +				return ret;
> +
> +			st->oversampling_ratio = 8;
> +		} else if (dec_rate <= 16) {
> +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X16);
> +			if (ret)
> +				return ret;
> +
> +			st->oversampling_ratio = 16;
> +		} else {
> +			ret = ad7768_set_filter_type(dev, SINC5);
> +			if (ret)
> +				return ret;
> +
> +			ret = ad7768_set_dec_rate(st, dec_rate);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad7768_set_fil_type_attr(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int filter)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +
> +	/*
> +	 * Filters of types 0, 1, and 2 correspond to SINC5.
> +	 * For SINC3 and wideband filter types, an offset of 2 is added
> +	 * to align with the expected register values.
> +	 */
> +	if (filter != SINC5)
> +		filter += 2;
> +
> +	ret = ad7768_configure_dig_fil(dev, filter, st->oversampling_ratio);
> +	if (ret)
> +		return ret;
> +
> +	/* Update sampling frequency */
> +	return ad7768_set_freq(st, st->samp_freq);
> +}
> +
> +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	int ret;
> +	unsigned int mode;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
> +	/* Filter types from 0 to 2 are represented as SINC5 */
> +	if (mode < SINC3)
> +		return SINC5;
> +
> +	/*
> +	 * Remove the offset for the sinc3 and wideband filters
> +	 * to get the corresponding attribute enum value
> +	 */
> +	return mode - 2;
>  }
>  
>  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> @@ -490,43 +702,37 @@ static int ad7768_gpio_init(struct iio_dev *indio_dev)
>  static int ad7768_set_freq(struct ad7768_state *st,
>  			   unsigned int freq)
>  {
> -	unsigned int diff_new, diff_old, pwr_mode, i, idx;
> +	unsigned int diff_new, diff_old, i, idx;
>  	int res, ret;
>  
> +	freq = clamp_t(unsigned int, freq, 50, 1024000);
>  	diff_old = U32_MAX;
>  	idx = 0;
>  
> -	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
> +	if (freq == 0)
> +		return -EINVAL;
> +
> +	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
>  
>  	/* Find the closest match for the desired sampling frequency */
> -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> -		diff_new = abs(res - ad7768_clk_config[i].clk_div);
> +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +		diff_new = abs(res - ad7768_mclk_div_rates[i]);
>  		if (diff_new < diff_old) {
>  			diff_old = diff_new;
>  			idx = i;
>  		}
>  	}
>  
> -	/*
> -	 * Set both the mclk_div and pwrmode with a single write to the
> -	 * POWER_CLOCK register
> -	 */
> -	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
> -		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> -	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
> -	if (ret < 0)
> +	/* Set both the mclk_div and pwrmode */
> +	ret = ad7768_set_mclk_div(st, idx);
> +	if (ret)
>  		return ret;
>  
> -	st->dec_rate = ad7768_clk_config[idx].clk_div /
> -		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
>  	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> -					  ad7768_clk_config[idx].clk_div);
> +					  ad7768_mclk_div_rates[idx] * st->oversampling_ratio);
>  
> -	return 0;
> +	/* A sync-in pulse is required every time the filter dec rate changes */

Does this function actually change oversampling_ration/decimation rate? Or do
we also need to sync after changing other filter parameters?

> +	return ad7768_send_sync_pulse(st);
>  }
>  
>  static int ad7768_set_vcm_output(struct ad7768_state *st, unsigned int mode)
> @@ -540,13 +746,16 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7768_state *st = iio_priv(indio_dev);
> -	unsigned int freq;
> +	unsigned int freq, freq_filtered;
>  	int i, len = 0;
>  
> -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> -		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> -					 ad7768_clk_config[i].clk_div);
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
> +	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
> +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +		freq = DIV_ROUND_CLOSEST(freq_filtered,
> +					 ad7768_mclk_div_rates[i]);
> +		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> +		if (freq >= 50)
> +			len += sysfs_emit_at(buf, len, "%d ", freq);
>  	}
>  
>  	buf[len - 1] = '\n';
> @@ -556,6 +765,37 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
>  
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
>  
> +static ssize_t oversampling_ratio_available_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int len = 0;
> +
> +	/* Return oversampling ratio available in range format */
> +	buf[len++] = '[';
> +	if (st->filter_type == SINC3) {
> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MAX);
> +	} else if (st->filter_type == WIDEBAND) {
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MAX);
> +	} else {
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MAX);	}
> +
> +	buf[len - 1] = ']';
> +	buf[len++] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RO(oversampling_ratio_available, 0);
> +
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -597,6 +837,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = st->samp_freq;
>  
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->oversampling_ratio;
> +
>  		return IIO_VAL_INT;
>  	}
>  
> @@ -608,10 +853,19 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
>  			    int val, int val2, long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad7768_set_freq(st, val);
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

Probably should have iio_device_claim_direct_mode() here since this is poking
registers.

case IIO_CHAN_INFO_SAMP_FREQ: needs it too, so I would suggest to rename this
function to __ad7768_write_raw() and then write:

static int ad7768_write_raw(struct iio_dev *indio_dev,
  			    int val, int val2, long info)
{
	int ret;

	ret = iio_device_claim_direct_mode(indio_dev);
	if (ret)
		return ret;

	ret = __ad7768_write_raw(indio_dev, val, val2, info);
	iio_device_release_direct_mode(indio_dev);

	return ret;
}

This is the preferred style to avoid extra indent and error unwinding complexity.

> +		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
> +		if (ret)
> +			return ret;
> +
> +		/* Update sampling frequency */
> +		return ad7768_set_freq(st, st->samp_freq);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -627,6 +881,7 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
>  
>  static struct attribute *ad7768_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_oversampling_ratio_available.dev_attr.attr,
>  	NULL
>  };

Opportunity for another preliminary cleanup patch. IIO has core support for
*_available attributes now, so we can implement struct iio_info.read_avail
callback instead of manually creating attribute. Existing
sampling_frequency_available attribute can be converted to use this, then
use it for oversampling_ratio_available as well.

>  
> @@ -639,7 +894,7 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  
> -	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
> +	return st->oversampling_ratio == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
>  		AD7768_SCAN_TYPE_NORMAL;
>  }
>  
> @@ -745,6 +1000,12 @@ static int ad7768_setup(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Set Default Digital Filter configuration:
> +	 * SINC5 filter with x32 Decimation rate
> +	 */
> +	ret = ad7768_configure_dig_fil(indio_dev, SINC5, 32);
> +
>  	/* Set the default sampling frequency to 32000 kSPS */
>  	return ad7768_set_freq(st, 32000);
>  }


