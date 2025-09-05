Return-Path: <linux-iio+bounces-23813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987FB4640D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD707A5B24
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D328688D;
	Fri,  5 Sep 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uzU2HdaD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E017E55A
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102372; cv=none; b=e7yqk7p5EjvGERK3Boi7NH68xCutPXCFqrOx2FEpJyDkGfGsOQlMwTOiaEOFnTciA29CeMMj0dIOvBTwZmFyNqxeb5C+Js678/GatQGG020KDhZ7TeU4zrKdIYCUj6pKD/s0426fp/sjaKJwDKRfqW8wCVbu2LBJs+DrsrzrZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102372; c=relaxed/simple;
	bh=a/JV8A5G5nUlEZdYoKuMxsVvh45VgOaostPKBr7+uLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKaD4GuT+PwSJO06zewD+HG+Pz5pG5I9ke+eOHXhC6at8cxC85PnzxIE1Fnswv8kN5qYX5U2Ef3P3WaSKIhqBS967YMa9uI/bqjMo7cFCLF4ih++2Gsj4pIb0dHeqJHZMxQqX3HQleDxH9epI1L6bHQqo0C8SFDpn/A6E6WPhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uzU2HdaD; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61e1c0229b3so736704eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757102368; x=1757707168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFR/qTe+EjunSfm8G+3G1jdMJoO0CoueuRNYqBhRg2g=;
        b=uzU2HdaD4ZbysLu+TPYfrLl4L0Ovmi4mOoyWrLcU/6/6EsvR12mRGV4XTFyJrC6FkN
         bIL5aMjbvWkC+FFAESkHI76rHvAAmGKcgfllYPpprWy0YprBrAGK3rn8Ny/Qkt/Iu+Do
         gAZ5nzPQ0+x1kT97yM15tAoUT/Aq1LZEzbk88/GNMlsSNXqW9+KAoj3guyQz8fPtqGEm
         nObR45dbd79YzESzywlo1mvkz9n1ByabcgPbW3G/ODIsmJEYSbZ/zRETsA3wGQY8jepQ
         nRkAt0K0p2yCmEHSf1vecQUS3jAGNK/Zu1+fM0Q3vgaJltkaP+e5ZSWw0HOnn2/jTdJc
         37iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102368; x=1757707168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFR/qTe+EjunSfm8G+3G1jdMJoO0CoueuRNYqBhRg2g=;
        b=E/7AYZGK6jRhJVk++AjWAEdMjrUGkBqh4pfLVUHJYx+M5yGKjEQXobUDMi9IBx0Cby
         5b+aF9sArHhLYZzlRg8zEDOXXVHC2jk2yvsR6CEQFUZMrqvB0Sv6xnU+bwgeVjMkpcSP
         Nk4oHaJshXcZ1+a2f5/s6UChqdOmiNZO+tqOdsDC5rHaXJMOuwyu44T6BFa0RvDQ/wBb
         WL7ZsHILDQICbF4xzBfocksdomtrf623Kqy9D/cw5AN9QbLBdke/EBU1zRbvXtAn+yy4
         gZ56g+hh1Y5bXlyfxUvGskhH6ZLhJegdjn3mki9hpUgco7zUkIgfott9tGpYRSrribWq
         y8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgj/F9BvOlua7G19H1jOZMHqHNIh/Ef+tWpzgRfwXI2stbOrcH6Y0LP4cColjOvsTCadCah05tmL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOM8UHpeCmQqAXmPei5k+UxXQj8pBIcHzuQk95OslFR17S8qh
	lkfWLdvD2hzMzWxZW7x074jXGvoDprDADG+bBeaqyrDJpSbyKYVNS4NbpDTCoH3cZJr1/qvOgmd
	Ciz9Q
X-Gm-Gg: ASbGncsmlTFXKh1D3w1YdMWLMSqWVXGzHQRQmSlrcARwsMbFMWuC1mQrrsFMmMTM3me
	L/U29rRVBGfnFDgd5jOO4NsEQS36l7liLETWj7Cg14HC3lHTYCyVvMUs6h3+a24GYkaoto48+fL
	Y4+2XksmXDfFytcwExBpHdjNbEmCk163GuGqwLlXCEJ+AFTYm/FFokSOyYa3G772byEkjxvb8re
	uoztyQI12b9VQgf6UQ2SUM/nSWfmsiQroTRTwehCQVHAbZ6yZQcZJselUNRoMIahE9VnAKwRpdi
	SGQPPaYrdmneqVkL7L8z8n7P1bTiooa9HxPDz2RESFEQfMWODHwZsGsV6nHWEnEktZn7Kupm+5B
	t06TXaUSLf+/Go+wFBtVRA8q8dhJ4Xr2WhrVCO3aFhWNQHhanf5z41ndUsSmMO6DH6fvR/0Ld
X-Google-Smtp-Source: AGHT+IEHh2lFTOh4uKfrurbVep0wcCUizsaolUYPgwaH94RRZXYqurYKFtUABG/PLJ82S8PBBjhL+A==
X-Received: by 2002:a05:6808:1244:b0:439:8e9:637c with SMTP id 5614622812f47-43b29b4c490mr6359b6e.25.1757102368483;
        Fri, 05 Sep 2025 12:59:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-438237053d2sm2290875b6e.30.2025.09.05.12.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:59:28 -0700 (PDT)
Message-ID: <cf18ede2-2077-41f4-a49c-adb3c13c4c44@baylibre.com>
Date: Fri, 5 Sep 2025 14:59:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] iio: accel: BMA220 add LPF cut-off frequency
 mapping
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-7-petre.rodan@subdimension.ro>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901194742.11599-7-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:47 PM, Petre Rodan wrote:
>  - add mapping for the low pass filter cut-off frequency.
>  - make valid values visible for both the cut-off frequency and the scale.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/accel/bma220_core.c | 60 ++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 86347cf8ab1e..e60acd62cf96 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -4,6 +4,15 @@
>   *
>   * Copyright (c) 2016,2020 Intel Corporation.
>   * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
> + *
> + *
> + * Device register to IIO ABI mapping:
> + *
> + * Register                  | IIO ABI (sysfs)                | valid values
> + * --------------------------+--------------------------------+---------------
> + * scale (range)             | in_accel_scale                 | see _available
> + * cut-off freq (filt_config)| in_accel_filter_low_pass_...   | see _available
> + * ---------------------------------------------------------------------------
>   */
> 
>  #include <linux/bits.h>
> @@ -135,13 +144,23 @@
> 
>  #define BMA220_DEVICE_NAME			"bma220"
> 
> +#define BMA220_COF_1000HZ			0x0
> +#define BMA220_COF_500HZ			0x1
> +#define BMA220_COF_250HZ			0x2
> +#define BMA220_COF_125HZ			0x3
> +#define BMA220_COF_64HZ				0x4
> +#define BMA220_COF_32HZ				0x5
> +
>  #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |\
> +	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
>  	.scan_index = index,						\
>  	.scan_type = {							\
>  		.sign = 's',						\
> @@ -172,6 +191,7 @@ struct bma220_data {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct mutex lock;
> +	u8 lpf_3db_freq_idx;
>  	u8 range_idx;
>  	struct iio_trigger *trig;
>  	struct {
> @@ -188,6 +208,18 @@ static const struct iio_chan_spec bma220_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> 
> +/*
> + * Available cut-off frequencies of the low pass filter in Hz.
> + */
> +static const int bma220_lpf_3db_freq_hz_table[][2] = {
> +	[BMA220_COF_1000HZ] = {1000, 0},
> +	[BMA220_COF_500HZ] = {500, 0},
> +	[BMA220_COF_250HZ] = {250, 0},
> +	[BMA220_COF_125HZ] = {125, 0},
> +	[BMA220_COF_64HZ] = {64, 0},
> +	[BMA220_COF_32HZ] = {32, 0},

If all of these are integer values, why do we need 2-D table?

> +};
> +
>  static const unsigned long bma220_accel_scan_masks[] = {
>  	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>  	0
> @@ -309,6 +341,11 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
>  		*val = bma220_scale_table[index][0];
>  		*val2 = bma220_scale_table[index][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		index = data->lpf_3db_freq_idx;
> +		*val = bma220_lpf_3db_freq_hz_table[index][0];
> +		*val2 = bma220_lpf_3db_freq_hz_table[index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;

Why not IIO_VAL_INT?

>  	}
> 
>  	return -EINVAL;
> @@ -353,6 +390,22 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
>  				"failed to set measurement range\n");
>  		data->range_idx = index;
> 
> +		return 0;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		index = bma220_find_match(bma220_lpf_3db_freq_hz_table,
> +					  ARRAY_SIZE(bma220_lpf_3db_freq_hz_table),
> +					  val, val2);
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_FILTER,
> +					 BMA220_FILTER_MASK,
> +					 FIELD_PREP(BMA220_FILTER_MASK, index));
> +		if (ret < 0)
> +			dev_err(data->dev,
> +				"failed to set low pass filter\n");

Should `return ret;` here rather than logging error.

> +		data->lpf_3db_freq_idx = index;
> +
>  		return 0;
>  	}
> 
> @@ -370,6 +423,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		*length = ARRAY_SIZE(bma220_scale_table) * 2;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (const int *)bma220_lpf_3db_freq_hz_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(bma220_lpf_3db_freq_hz_table) * 2;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> --
> 2.49.1
> 


