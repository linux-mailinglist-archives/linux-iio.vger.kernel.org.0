Return-Path: <linux-iio+bounces-8696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F895BF07
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D04B23AC8
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A271D0492;
	Thu, 22 Aug 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vIc7zM1C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98E28EA
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355681; cv=none; b=cruN5ODb+t4AX/+/1nEbXCcPQ7FsduLueHuKKi2jTDeauYTAxgHQFzjbH/2cXTbvB4k11l9pJrG9y0OyRYiHoVKs+2hZFwwyFbh716wqa3aOwTUg9NiHT1KtZczbrDu03DF8mB90dH3lWO7slmaBd8SdGTt4YIj2VENABbWUXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355681; c=relaxed/simple;
	bh=KjZO6ov7QSzqGB8UfoaK++XtOC9CJ0RJO4l/iww/z+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWlc3assvgazj2gdC/x7zVmM2/a/3/mzBkvA0fg7mX66UOafZ/+KJ2g2LVB5uwEVG57+kPvNIxep82pC/PQELhPdVqmjN4BoPXoHMyknp5vtbAG/IEnn8XZ5nUquliGnJQuSeATKw/3UJT/i/y7BIA4dOO2kWPXE9HwUV5GG2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vIc7zM1C; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093f3a1af9so916363a34.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724355678; x=1724960478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=670CRJ9jVf7RxbXdzDHqgrLMdBCRweoWeG3V6wkq1C0=;
        b=vIc7zM1Crh1hFVrbYUfiSAxwpGZdOv9Mk5VZjnrtESRlaFni0d30Z2A8shjP5GDXBP
         SNz4Qu1dM1ssVrXzfdnnReGQ/QjzyvY/ySyRvnh89KmMNLYCSdYHZNKcQ7af5aqux3at
         GD6sIo3TI1Xb+er5NBMfCCzcFo4PalQRNyjlr4ZP2mvGy2zaNx71zkKvwqRw2+K5ile5
         c3fNvCWbQm1zKHuSzZJvEi39NlXcUqh7KFjcioaEjv5HlzERbI3w+T5NS+iWEc6B205V
         ZdGhPiNmJNog1ki7NJw5T5+0bQVI8B/woiI7r62nVxsxTw9VgtCZEOyoN3Z07ZWbQE4A
         dK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355678; x=1724960478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=670CRJ9jVf7RxbXdzDHqgrLMdBCRweoWeG3V6wkq1C0=;
        b=Z2Zej87pcIxAEHyXdWMT2eAZBD9WihQO7r3LkTr8yl/ptzYGiwyGciyw967xm3I2xf
         E4eBny5br5RqyD7Rhj0p86YOg3I0iNmJWJNU4RUf/EUa1T+gz69ybxeX+RkSZkmCD/XB
         cRnPHN+/6ZKhqH3RVddYS+UPWeRvu7v+g0p6rPH8VYjk6Ni9wWKuiRo9+1UInmkDzcKY
         NZsWAoPsp1kBrJJ/bxr0/ehh9ugqmA9i+F8NZFwwfDX95XKRc01RnTj8JGNlcNjb2OHP
         rlcnQqOugQCCNlDhGJ93ARM4TQ6+V5wsLFMfg9j6Yg2QciH+ua3JHTGxgnCgyzjJtm65
         vQFQ==
X-Gm-Message-State: AOJu0YxmLE2u7rjKwDcPx0tVsWu4RAJG+dIIwl80JBkAEIHw8w8GMnk+
	2PiAeZ0tvMHo1iZK0pJfS3VfrYYsgqijcB30lzI7budkCOFjQ/5tNKNidOCFOdo=
X-Google-Smtp-Source: AGHT+IFZSe/r/mnJ8YlB9/9dMx9W3A17/8eBIdxBLgHxiDXZZIXwExnG+81QB+VbczIa+3km0d6JYw==
X-Received: by 2002:a05:6808:199d:b0:3da:bbf9:9284 with SMTP id 5614622812f47-3de195af78dmr6272139b6e.51.1724355678554;
        Thu, 22 Aug 2024 12:41:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225c52a6sm407124b6e.44.2024.08.22.12.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:41:18 -0700 (PDT)
Message-ID: <e82e4324-7f86-458b-acef-0acaaede0c64@baylibre.com>
Date: Thu, 22 Aug 2024 14:41:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: adc: ad4030: add averaging support
To: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-3-5c68f3327fdd@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-3-5c68f3327fdd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 7:45 AM, Esteban Blanc wrote:
> This add support for the averaging mode of AD4030 using oversampling IIO
> attribute
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  drivers/iio/adc/ad4030.c | 126 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 111 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index a981dce988e5..e1e1dbf0565c 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -115,6 +115,18 @@ enum ad4030_out_mode {
>  	AD4030_OUT_DATA_MD_32_PATTERN = 0x04
>  };
>  
> +enum {
> +	AD4030_LANE_MD_1_PER_CH,
> +	AD4030_LANE_MD_2_PER_CH,
> +	AD4030_LANE_MD_4_PER_CH,
> +	AD4030_LANE_MD_INTERLEAVED = 0b11,

nit: value 0f AD4030_LANE_MD_INTERLEAVED is already 3, so
shouldn't need to specify it.

> +};
> +
> +enum {
> +	AD4030_SCAN_TYPE_NORMAL,
> +	AD4030_SCAN_TYPE_AVG,
> +};
> +
>  struct ad4030_chip_info {
>  	const char *name;
>  	const unsigned long *available_masks;
> @@ -135,6 +147,7 @@ struct ad4030_state {
>  	int vref_uv;
>  	int vio_uv;
>  	int offset_avail[3];
> +	unsigned int avg_len;
>  	u32 conversion_speed_hz;
>  	enum ad4030_out_mode mode;
>  
> @@ -169,8 +182,11 @@ struct ad4030_state {
>  	},								\
>  }
>  
> -#define AD4030_CHAN_IN(_idx, _storage, _real, _shift) {			\
> -	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),		\
> +#define AD4030_CHAN_IN(_idx, _scan_type) {				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.info_mask_shared_by_all_available =				\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
>  		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
>  		BIT(IIO_CHAN_INFO_RAW),					\
> @@ -183,15 +199,16 @@ struct ad4030_state {
>  	.scan_index = _idx * 2,						\
>  	.extend_name = "Channel" #_idx " differential part",		\
>  	.differential = true,						\
> -	.scan_type = {							\
> -		.sign = 's',						\
> -		.storagebits = _storage,				\
> -		.realbits = _real,					\
> -		.shift = _shift,					\
> -		.endianness = IIO_BE,					\
> -	},								\
> +	.has_ext_scan_type = 1,						\
> +	.ext_scan_type = _scan_type,					\
> +	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
>  }
>  
> +static const int ad4030_average_modes[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384,
> +	32768, 65536
> +};
> +
>  static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
>  			   void *val, size_t val_size)
>  {
> @@ -327,6 +344,13 @@ static int ad4030_get_chan_offset(struct iio_dev *indio_dev, int ch, int *val)
>  	return 0;
>  }
>  
> +static int ad4030_get_avg_frame_len(struct iio_dev *dev)
> +{
> +	const struct ad4030_state *st = iio_priv(dev);
> +
> +	return 1L << st->avg_len;
> +}
> +
>  static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int gain_int,
>  				int gain_frac)
>  {
> @@ -369,6 +393,22 @@ static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
>  			  st->rx_data.raw, AD4030_REG_OFFSET_BYTES_NB);
>  }
>  
> +static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
> +{
> +	struct ad4030_state *st = iio_priv(dev);
> +	unsigned int avg_val = ilog2(avg_len);
> +	int ret;

Should probably limit avg_len max to 65536 to avoid weird roll
around when higher values are given.

> +
> +	ret = regmap_write(st->regmap, AD4030_REG_AVG, AD4030_REG_AVG_MASK_AVG_SYNC |
> +		    FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_val));
> +	if (ret)
> +		return ret;
> +
> +	st->avg_len = avg_val;
> +
> +	return 0;
> +}
> +
>  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  					unsigned int mask)
>  {
> @@ -380,7 +420,9 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
>  {
>  	struct ad4030_state *st = iio_priv(indio_dev);
>  
> -	if (ad4030_is_common_byte_asked(st, mask))
> +	if (st->avg_len)
> +		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
> +	else if (ad4030_is_common_byte_asked(st, mask))
>  		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
>  	else
>  		st->mode = AD4030_OUT_DATA_MD_24_DIFF;
> @@ -394,6 +436,7 @@ static int ad4030_conversion(struct ad4030_state *st,
>  			     const struct iio_chan_spec *chan)
>  {
>  	unsigned int bytes_to_read;
> +	unsigned long cnv_nb = 1UL << st->avg_len;
>  	unsigned char byte_index;
>  	unsigned int i;
>  	int ret;
> @@ -406,10 +449,12 @@ static int ad4030_conversion(struct ad4030_state *st,
>  	/* Mulitiply by the number of hardware channels */
>  	bytes_to_read *= st->chip->num_channels;
>  
> -	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> -	ndelay(AD4030_TCNVH_NS);
> -	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> -	ndelay(st->chip->tcyc);
> +	for (i = 0; i < cnv_nb; i++) {
> +		gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +		ndelay(AD4030_TCNVH_NS);
> +		gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +		ndelay(st->chip->tcyc);
> +	}
>  
>  	ret = spi_read(st->spi, st->rx_data.raw, bytes_to_read);
>  	if (ret)
> @@ -508,6 +553,12 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_RANGE;
>  
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4030_average_modes;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ad4030_average_modes);
> +		return IIO_AVAIL_LIST;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -544,6 +595,10 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
>  				return ret;
>  			return IIO_VAL_INT;
>  
> +		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +			*val = ad4030_get_avg_frame_len(indio_dev);
> +			return IIO_VAL_INT;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -566,6 +621,9 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
>  			return ad4030_set_chan_offset(indio_dev, chan->channel,
>  						      val);
>  
> +		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

Might want to check for negative values before implicitly casting val
to unsigned.

> +			return ad4030_set_avg_frame_len(indio_dev, val);
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -589,11 +647,20 @@ static int ad4030_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	unreachable();
>  }
>  
> +static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	return st->avg_len ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
> +}
> +
>  static const struct iio_info ad4030_iio_info = {
>  	.read_avail = ad4030_read_avail,
>  	.read_raw = ad4030_read_raw,
>  	.write_raw = ad4030_write_raw,
>  	.debugfs_reg_access = ad4030_reg_access,
> +	.get_current_scan_type = ad4030_get_current_scan_type,
>  };
>  
>  static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
> @@ -626,9 +693,21 @@ static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
>  	return ad4030_enter_config_mode(st);
>  }
>  
> +static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *scan_mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	/* Asking for both common channels and averaging */
> +	if (st->avg_len && ad4030_is_common_byte_asked(st, *scan_mask))
> +		return false;
> +
> +	return true;
> +}
> +
>  static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.preenable = ad4030_buffer_preenable,
>  	.postdisable = ad4030_buffer_postdisable,
> +	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
>  static int ad4030_regulators_get(struct ad4030_state *st)
> @@ -812,12 +891,29 @@ static const unsigned long ad4030_channel_masks[] = {
>  	0,
>  };
>  
> +static const struct iio_scan_type ad4030_24_scan_types[] = {
> +	[AD4030_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 24,
> +		.shift = 8,
> +		.endianness = IIO_BE,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_BE,
> +	},
> +};
> +
>  static const struct ad4030_chip_info ad4030_24_chip_info = {
>  	.name = "ad4030-24",
>  	.available_masks = ad4030_channel_masks,
>  	.available_masks_len = ARRAY_SIZE(ad4030_channel_masks),
>  	.channels = {
> -		AD4030_CHAN_IN(0, 32, 24, 8),
> +		AD4030_CHAN_IN(0, ad4030_24_scan_types),
>  		AD4030_CHAN_CMO(0),
>  		IIO_CHAN_SOFT_TIMESTAMP(2),
>  	},
> 


