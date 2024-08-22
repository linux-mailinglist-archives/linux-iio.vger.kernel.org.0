Return-Path: <linux-iio+bounces-8697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCD95BF10
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 21:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C69285026
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF591D04AA;
	Thu, 22 Aug 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DnCAU3Kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB21474D3
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724355804; cv=none; b=NkbErlJzkeZUKWZo7rU7E70hcm++z/QNL2yw1CzVKHqKIVxH1YqdsvDsaCUI1XZkwtns4Ei9bxU7gJbD73o/wGatVFMC1wQ8axwIy+qEmhBx41wfTefXFoyXKpNkSx9cfzgypKJGTml3BonFJVtHHT11XCyeiqGTbjsj9iygWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724355804; c=relaxed/simple;
	bh=QT7aJlEY8Rv4tVUsadFB7WX2kBMAnPwke95aKAAGiGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btp6/Lrs9q56kiSy+/IU3izB+26nxWEVJgwBIwhWa1gddlqtPZbm/DUbvCNb1ecOiWRIgtqsfKfI4Nd+F77dTF4LsYs97n10aWChoxsND5HpjpeYqu/uIK4QVwhS4A1MGOil15e/H8AcTlAwxtLk6M61LWm+VXyZ+s9KsLSRG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DnCAU3Kf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093997dffdso641618a34.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724355800; x=1724960600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0IEyTvUOt9NE+jKWzvSdPx4thYKWyDYS1DC+M4ZgJQ=;
        b=DnCAU3KfSschA2J3hPcLgJ8fCBIZX3mYvGXQ6/e0WqHv2E9fk5xD2soDjR1iOoAuZb
         gjigXmCZCldsByu6iRbUlQYpubWW74+tCj+dsk6yoE2aj839ECsgxyEiWpmPTb9tt4Sv
         P2QIkVE+UuaO1FdPeeo+UgQ7/Nuz7L9hCyD+Pqtq5j/jPRP7PIxew2H/19LQmFE85U5v
         TqHpQJIOKx7KOhE4cII4FtahTmyKXBQTBgBHm6KRYu+oxH4yWtayPJEIJUYmKaOBJdJE
         Zh5F/N+MOQCG4D+ypM8zRtcQh+ZYqJyV4Sq3cytjW+NVAW3wHk+piqixWYNIJomjaBoI
         SUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724355800; x=1724960600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0IEyTvUOt9NE+jKWzvSdPx4thYKWyDYS1DC+M4ZgJQ=;
        b=lpstg3OOsTqdDxbV35oRJNkFnEf3SJIcZYDGbZ94akboSx1rGMRI5hGZDJzgjRsjy4
         5IdNUmI7Y46Xl17bSDa8FrLKT4NeEeGOeairXiZDLYpvDglDhI42rvUUph/ZVgwvi9EQ
         jN3oYwa1DvBNxyoqJBORJJdriGquTR73hj/nzSALz5meUhH7XrSExK5dKYSMVIl84XFn
         PYammwlA1FUhmc9JG/HBLiJScONfMKJgnphuc9tIx006eZew/uiGaNrJ5clcnr1qgkiR
         hXlRxmDiRzi0Xnku6Xk87sU08OPgY3o95bMQtb1dQwNcr/Oh4vHfbLBa6e0wj8Fu60wP
         NHwg==
X-Gm-Message-State: AOJu0Yzurt1qp9X/od+iQ5lvoNKoOfMvV9TFQLnNQ8a0Z1y+9IXhZYaf
	TtQLFUvcms6nf/e+614Xo7It70GtOIWPvt+fcIqBWuQkNWhL22ZcUDUGrtP4v4o=
X-Google-Smtp-Source: AGHT+IHbSe5f9F2QWD6j7jhfMbrWsYlapf/V7JFmavdB7hkWybVFOzvMOkLk0BzckqinXTYLfqqhlw==
X-Received: by 2002:a05:6808:4492:b0:3d6:2fe3:35ff with SMTP id 5614622812f47-3de19ca9aa4mr6998902b6e.14.1724355800403;
        Thu, 22 Aug 2024 12:43:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225d71b8sm401581b6e.51.2024.08.22.12.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 12:43:19 -0700 (PDT)
Message-ID: <48ad0f2b-e937-43f0-a620-164eeb45723e@baylibre.com>
Date: Thu, 22 Aug 2024 14:43:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
To: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 7:45 AM, Esteban Blanc wrote:
> AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
> interleaved bit per bit on SDO line.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  drivers/iio/adc/ad4030.c | 197 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 173 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index e1e1dbf0565c..dbba5287b630 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -32,6 +32,8 @@
>  #define AD4030_REG_PRODUCT_ID_H				0x05
>  #define AD4030_REG_CHIP_GRADE				0x06
>  #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
> +#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
> +#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
>  #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
>  #define AD4030_REG_SCRATCH_PAD			0x0A
>  #define AD4030_REG_SPI_REVISION			0x0B
> @@ -159,10 +161,14 @@ struct ad4030_state {
>  	struct {
>  		union {
>  			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> -			struct {
> -				s32 val;
> -				u32 common;
> -			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];
> +			union {
> +				s32 diff[AD4030_MAX_HARDWARE_CHANNEL_NB];
> +				struct {
> +					s32 diff;
> +					u32 common;
> +				} __packed
> +				buffered_common[AD4030_MAX_HARDWARE_CHANNEL_NB];
> +			};
>  		};
>  	} rx_data __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -171,7 +177,7 @@ struct ad4030_state {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
> -	.channel = _idx * 2 + 2,					\
> +	.channel = _idx * 3 + 2,					\

I'm guessing * 3 should have actually been in the first patch?
Seems odd to change it now.

>  	.scan_index = _idx * 2 + 1,					\
>  	.extend_name = "Channel" #_idx " common byte part",		\
>  	.scan_type = {							\
> @@ -194,8 +200,8 @@ struct ad4030_state {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
> -	.channel = _idx * 2,						\
> -	.channel2 = _idx * 2 + 1,					\
> +	.channel = _idx * 3,						\
> +	.channel2 = _idx * 3 + 1,					\
>  	.scan_index = _idx * 2,						\
>  	.extend_name = "Channel" #_idx " differential part",		\
>  	.differential = true,						\
> @@ -412,7 +418,7 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
>  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  					unsigned int mask)
>  {
> -	/* Common byte channel is after the "real" differential sample channel */
> +	/* Common byte channels are after each differential channel */
>  	return mask & AD4030_COMMON_BYTE_CHANNELS_FILTER;
>  }
>  
> @@ -420,18 +426,69 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
>  {
>  	struct ad4030_state *st = iio_priv(indio_dev);
>  
> -	if (st->avg_len)
> +	if (st->avg_len) {
>  		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
> -	else if (ad4030_is_common_byte_asked(st, mask))
> -		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
> -	else
> +	} else if (ad4030_is_common_byte_asked(st, mask)) {
> +		switch (st->chip->precision_bits) {
> +		case 16:
> +			st->mode = AD4030_OUT_DATA_MD_16_DIFF_8_COM;
> +			break;
> +
> +		case 24:
> +			st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
>  		st->mode = AD4030_OUT_DATA_MD_24_DIFF;

nit: maybe better to rename this one to AD4030_OUT_DATA_MD_DIFF
or AD4030_OUT_DATA_MD_DIFF_ONLY since it can be 16 or 24 bits
depending on the chip?

> +	}
>  
>  	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
>  				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
>  				st->mode);
>  }
>  
> +/*
> + * @brief Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
> + * 1 bit for first number, 1 bit for the second, and so on...
> + */
> +static void ad4030_extract_interleaved(u8 *src, u32 *ch0, u32 *ch1)
> +{
> +	u8 h0, h1, l0, l1;
> +	u32 out0, out1;
> +	u8 *out0_raw = (u8 *)&out0;
> +	u8 *out1_raw = (u8 *)&out1;
> +
> +	for (int i = 0; i < 4; i++) {
> +		h0 = src[i * 2];
> +		l1 = src[i * 2 + 1];
> +		h1 = h0 << 1;
> +		l0 = l1 >> 1;
> +
> +		h0 &= 0xAA;
> +		l0 &= 0x55;
> +		h1 &= 0xAA;
> +		l1 &= 0x55;
> +
> +		h0 = (h0 | h0 << 001) & 0xCC;
> +		h1 = (h1 | h1 << 001) & 0xCC;
> +		l0 = (l0 | l0 >> 001) & 0x33;
> +		l1 = (l1 | l1 >> 001) & 0x33;
> +		h0 = (h0 | h0 << 002) & 0xF0;
> +		h1 = (h1 | h1 << 002) & 0xF0;
> +		l0 = (l0 | l0 >> 002) & 0x0F;
> +		l1 = (l1 | l1 >> 002) & 0x0F;
> +
> +		out0_raw[i] = h0 | l0;
> +		out1_raw[i] = h1 | l1;
> +	}
> +
> +	*ch0 = out0;
> +	*ch1 = out1;
> +}
> +
>  static int ad4030_conversion(struct ad4030_state *st,
>  			     const struct iio_chan_spec *chan)
>  {
> @@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_state *st,
>  	if (ret)
>  		return ret;
>  
> -	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> +	if (st->chip->num_channels == 2)
> +		ad4030_extract_interleaved(st->rx_data.raw,
> +					   &st->rx_data.diff[0],
> +					   &st->rx_data.diff[1]);
> +
> +	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> +	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
>  		return 0;
>  
>  	byte_index = BITS_TO_BYTES(chan->scan_type.realbits);
> -	for (i = 0; i < st->chip->num_channels; i++)
> -		st->rx_data.buffered[i].common = ((u8 *)&st->rx_data.buffered[i].val)[byte_index];
> +	/* Doing it backward to avoid overlap when reordering */
> +	for (i = st->chip->num_channels - 1; i > 0; i--) {
> +		st->rx_data.buffered_common[i].diff = st->rx_data.diff[i];
> +		st->rx_data.buffered_common[i].common = ((u8 *)&st->rx_data.diff[i])[byte_index];
> +	}
>  
>  	return 0;
>  }
> @@ -489,9 +555,9 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
>  		goto out_error;
>  
>  	if (chan->channel % 2)
> -		*val = st->rx_data.buffered[chan->channel / 2].common;
> +		*val = st->rx_data.buffered_common[chan->channel / 2].common;
>  	else
> -		*val = st->rx_data.buffered[chan->channel / 2].val;
> +		*val = st->rx_data.diff[chan->channel / 2];

Doesn't this need to change since `* 2` was changed to `* 3` for the channel
value?

Better would be to make use of chan->address to store the actual number we need
and use that directly instead of reverse engineering the relation of chan->channel
to input pin number.

>  
>  out_error:
>  	ad4030_enter_config_mode(st);
> @@ -582,14 +648,17 @@ static int ad4030_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  
>  		case IIO_CHAN_INFO_CALIBSCALE:
> -			ret = ad4030_get_chan_gain(indio_dev, chan->channel,
> -						   val, val2);
> +			ret = ad4030_get_chan_gain(indio_dev,
> +						   chan->scan_index / 2,
> +						   val,
> +						   val2);
>  			if (ret)
>  				return ret;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  
>  		case IIO_CHAN_INFO_CALIBBIAS:
> -			ret = ad4030_get_chan_offset(indio_dev, chan->channel,
> +			ret = ad4030_get_chan_offset(indio_dev,
> +						     chan->scan_index / 2,

Similar to above, we could use chan->address here instead of having to
know the relationship between scan_index and input pin.

>  						     val);
>  			if (ret)
>  				return ret;
> @@ -614,11 +683,14 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
>  	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  		switch (info) {
>  		case IIO_CHAN_INFO_CALIBSCALE:
> -			return ad4030_set_chan_gain(indio_dev, chan->channel,
> -						    val, val2);
> +			return ad4030_set_chan_gain(indio_dev,
> +						    chan->scan_index / 2,
> +						    val,
> +						    val2);
>  
>  		case IIO_CHAN_INFO_CALIBBIAS:
> -			return ad4030_set_chan_offset(indio_dev, chan->channel,
> +			return ad4030_set_chan_offset(indio_dev,
> +						      chan->scan_index / 2,
>  						      val);
>  
>  		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> @@ -801,10 +873,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
>  
>  static int ad4030_config(struct ad4030_state *st)
>  {
> +	int ret;
> +	u8 reg_modes;
> +
>  	st->offset_avail[0] = (int)BIT(st->chip->precision_bits - 1) * -1;
>  	st->offset_avail[1] = 1;
>  	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
>  
> +	if (st->chip->num_channels > 1)
> +		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
> +				       AD4030_LANE_MD_INTERLEAVED);
> +	else
> +		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
> +				       AD4030_LANE_MD_1_PER_CH);
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
> +	if (ret)
> +		return ret;
> +
>  	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
>  		return regmap_write(st->regmap, AD4030_REG_IO,
>  				AD4030_REG_IO_MASK_IO2X);
> @@ -891,8 +977,16 @@ static const unsigned long ad4030_channel_masks[] = {
>  	0,
>  };
>  
> +static const unsigned long ad4630_channel_masks[] = {
> +	/* Differential only */
> +	BIT(0) | BIT(2),

nit: for order consistency with GENMASK

	BIT(2) | BIT(0),

> +	/* Differential with common byte */
> +	GENMASK(3, 0),
> +	0,
> +};
> +
>  static const struct iio_scan_type ad4030_24_scan_types[] = {
> -	[AD4030_SCAN_TYPE_NORMAL] = {
> +	[AD4030_OUT_DATA_MD_24_DIFF] = {

Accidental replacement?

>  		.sign = 's',
>  		.storagebits = 32,
>  		.realbits = 24,
> @@ -908,6 +1002,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
>  	},
>  };
>  
> +static const struct iio_scan_type ad4030_16_scan_types[] = {
> +	[AD4030_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 16,
> +		.shift = 16,
> +		.endianness = IIO_BE,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_BE,
> +	}
> +};
> +
>  static const struct ad4030_chip_info ad4030_24_chip_info = {
>  	.name = "ad4030-24",
>  	.available_masks = ad4030_channel_masks,
> @@ -923,14 +1034,52 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
>  	.tcyc = AD4030_TCYC_ADJUSTED_NS,
>  };
>  
> +static const struct ad4030_chip_info ad4630_16_chip_info = {
> +	.name = "ad4630-16",
> +	.available_masks = ad4630_channel_masks,
> +	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
> +	.channels = {
> +		AD4030_CHAN_IN(0, ad4030_16_scan_types),
> +		AD4030_CHAN_CMO(0),
> +		AD4030_CHAN_IN(1, ad4030_16_scan_types),
> +		AD4030_CHAN_CMO(1),
> +		IIO_CHAN_SOFT_TIMESTAMP(4),
> +	},
> +	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
> +	.precision_bits = 16,
> +	.num_channels = 2,
> +	.tcyc = AD4030_TCYC_ADJUSTED_NS,
> +};
> +
> +static const struct ad4030_chip_info ad4630_24_chip_info = {
> +	.name = "ad4630-24",
> +	.available_masks = ad4630_channel_masks,
> +	.available_masks_len = ARRAY_SIZE(ad4630_channel_masks),
> +	.channels = {
> +		AD4030_CHAN_IN(0, ad4030_24_scan_types),
> +		AD4030_CHAN_CMO(0),
> +		AD4030_CHAN_IN(1, ad4030_24_scan_types),
> +		AD4030_CHAN_CMO(1),
> +		IIO_CHAN_SOFT_TIMESTAMP(4),
> +	},
> +	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
> +	.precision_bits = 24,
> +	.num_channels = 2,
> +	.tcyc = AD4030_TCYC_ADJUSTED_NS,
> +};
> +
>  static const struct spi_device_id ad4030_id_table[] = {
>  	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
> +	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
> +	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad4030_id_table);
>  
>  static const struct of_device_id ad4030_of_match[] = {
>  	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
> +	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
> +	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ad4030_of_match);
> 


