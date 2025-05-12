Return-Path: <linux-iio+bounces-19471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA2AB3BAE
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549A37A82F5
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC9235348;
	Mon, 12 May 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lwdLh4Y8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82A1EDA11
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062590; cv=none; b=lAIp6yd08Ch7sT9hxdxgXS6sy2v67FpkO/TFyvZtKVnQdfgBUr0Zhym90kbRiulb4uDci3JKjIX1kfr1kEY+vyPCK3IxKivJf0lgITMoZRXb73nYGWBDdyntr3Gy/83yTDZb0YkdXh1Fr/YsGHnaUkqRi74Nc3aUe8lP0UrLqZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062590; c=relaxed/simple;
	bh=k60H86/2TOfisvhuVVqcLzOZmbD3frwSLryqfVsbxkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pwd23fb3ve4h7dN1HgDDS51uFk35nhsikgmlbQcmUv7h/lK62/kBxAji06Jw5y5MBjqk4fQbdmT4ImmQ1OjX26yK402q3UAEyGzG0GsrV1NWXjpcf2EYJhL40IUvgZ/WyNoUP2P4p0GmGiPXbyIdiDxULpXmP+jIhNwZYTiUExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lwdLh4Y8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fbaa18b810so1161267b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062588; x=1747667388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2Y26Nzcl7Qs/OhOSkM2rPMa1VcnEkiaJ844dzirBYo=;
        b=lwdLh4Y806ei7O+4IsIsSdPS7BWMVBBKGeOLMdkZJZ7jIqETK+kZxIRpNlxunJ49mF
         /nQNzJTCAP9N6e3P45w2qYFz6Fth88I3fJMVTK2/f0RFWWPdIY7U0B+Al6JSdHUNIKUJ
         TnXJevZ1nGQVbp+oiD47IKqYQXIHqNMJQZTUiE/PchyOWMMEolgfhOxg8hbLOa2XZg0s
         dIrxEWZ9V2Zgi7OIH8kiAslF/bTlRoNv4zEtPu+nA5OLoWJ8lSeChE8mamqA96CxPMPV
         2Lyg+Riliul7w7dOER6tdNxSXfvBOwzDbagVn9JSaXWTFrGFDwa9c2chXchzCWNOhvt3
         Fe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062588; x=1747667388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2Y26Nzcl7Qs/OhOSkM2rPMa1VcnEkiaJ844dzirBYo=;
        b=r09QaEVF1YJSFYrMEmvJHC/7ugmr2EylG1s9cbpi0hYfPjD7lPdgCtxj68PdQt8yVR
         KoLy20nAsORJbU6Eo7Rs/9piPwc4FVwhxrH44pOPtJIX83RgPB80qtFaFC1eFsVomTy/
         WetvEsefB9mBSRIru1EgZEXXqkfLSrgYw3PLnOjds1b0wbBMEe13nOtGaBiJ5n1xWtJO
         ad0dsQyw2kspdi4gJEspukjNESUnLaaiDcw/BXUtIdtgSuMKRJztzwK8rKA1GWjrObaX
         IcLLULN/p3duyt9rTBj/oxpUYEGdLNKmTwFJ1p1BYyJbhYvaaPuJ1pSYijZKvcbRmm16
         CY8g==
X-Forwarded-Encrypted: i=1; AJvYcCUw8WAEW+Hawd0v6pTMvIXfoD+qL6gzsifUY8tzMg3fbXOUI0FwWp1qxD2U/etYD9uCRZMzIA/c2y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqr3d8mAKFem+VvYtKoD2dTDygAC2bGT9uelWeQTqg30HrSj0n
	GP8sLViPmXjfhFyQFfoSnU8ppR0NaALX8rFBA2dDhTxkAAqy3Vt0upMsCnVFwM8=
X-Gm-Gg: ASbGnctvkYyG6KkBWql3ptKFc+cMyQcEEGz9y1OyCrm1eWc7LypCt2LB9b048jkyjw9
	WcPnrDHWIaJzWA+EJx2VyBWLs/NcX/++zDpAQoWfpmE+cYDwSu63wFzXtEosov/UX+d2gzlVTmu
	mEkwhQV7kOMQNxdwdwzZJlDbNC/fluQxwbCculAe+lVaJmD/ey1pW3oCsJ8Zw4Vd9c2F3URdElM
	tqW3c9+lxYJs+pnNFKOXzgchCImUx4F2JMYiWxunTTeCl4B8Ug0U7OY/NpWyd8arIE0gAd5bqwk
	gburEbE3eORBw+rD7R+ERVstXX82Q8ZRFGigSgMrfmeslGN9q17gmD9Uuwd/Ddu0tOu0HNyDJ1S
	MS2JahSKHVsb0PvdI44lZxPLM/E5L7OJ+ULA1X2o=
X-Google-Smtp-Source: AGHT+IGamPIMN3SMlof91E6fX5EdgWJKMxdjC7rJ6OPUPdUmImzkNAFqy3X6YNXm9ZrbNwPpZZ+lQw==
X-Received: by 2002:a05:6808:2213:b0:400:b402:2403 with SMTP id 5614622812f47-4037feaedc9mr7710176b6e.32.1747062587418;
        Mon, 12 May 2025 08:09:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d2ae5sm1554451b6e.15.2025.05.12.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:09:45 -0700 (PDT)
Message-ID: <86d73027-6ab2-4751-8839-e7905a6b4e34@baylibre.com>
Date: Mon, 12 May 2025 10:09:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] iio: adc: ad4080: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
 <20250509105019.8887-10-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250509105019.8887-10-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 5:50 AM, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static const char *const ad4080_filter_type_iio_enum[] = {
> +	[FILTER_NONE]      = "none",
> +	[SINC_1]           = "sinc1",
> +	[SINC_5]           = "sinc5",
> +	[SINC_5_COMP]      = "sinc5+pf1",
> +};
> +
> +static const int ad4080_dec_rate_iio_enum[] = {

Would make more sense to call this _avail instead of _iio_enum.

> +	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
> +};
> +
> +static const char * const ad4080_power_supplies[] = {
> +	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
> +};
> +
> +struct ad4080_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const unsigned int (*scale_table)[2];
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct ad4080_state {
> +	struct regmap			*regmap;
> +	struct clk			*clk;

clk isn't used outside of probe and can be removed.

> +	struct iio_backend		*back;
> +	const struct ad4080_chip_info	*info;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	unsigned int			num_lanes;
> +	unsigned int			dec_rate;
> +	unsigned long			clk_rate;
> +	enum ad4080_filter_type		filter_type;
> +	bool				lvds_cnv_en;
> +};
> +

...

> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		dec_rate = ad4080_get_dec_rate(indio_dev, chan);

Need to check return value for negative error code.

> +		if (st->filter_type == SINC_5_COMP)
> +			dec_rate *= 2;
> +		if (st->filter_type)
> +			*val = DIV_ROUND_CLOSEST(st->clk_rate, dec_rate);
> +		else
> +			*val = st->clk_rate;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = ad4080_get_dec_rate(indio_dev, chan);

Ditto.

Also, should set *val = 1 in the case of st->filter_type == FILTER_NONE.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

This has no effect when st->filter_type == FILTER_NONE and should only
allow 1 in that case.

> +		return ad4080_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +static int ad4080_set_filter_type(struct iio_dev *dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int mode)
> +{
> +	struct ad4080_state *st = iio_priv(dev);
> +	unsigned int dec_rate;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	dec_rate = ad4080_get_dec_rate(dev, chan);

Again, need to check for negative error code.

> +
> +	if (mode >= SINC_5 && dec_rate >= 512)
> +		return -EINVAL;
> +
> +	ret = iio_backend_filter_type_set(st->back, mode);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
> +				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +				 FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
> +					    mode));
> +	if (ret)
> +		return ret;
> +
> +	st->filter_type = mode;
> +
> +	return 0;
> +}
> +
> +static int ad4080_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

Would make sense to have a separate case for st->filter_type == FILTER_NONE
simialar to suggestions above. 1 is the only available value in that case.

Also, in the st->filter_type != FILTER_NONE case, would make sense to set
*length based on st->filter_type since 256 is the max value for the sinc5
filters.

> +		*vals = ad4080_dec_rate_iio_enum;
> +		*length = ARRAY_SIZE(ad4080_dec_rate_iio_enum);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->regmap);
> +	unsigned int id;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_INTERFACE_CONFIG_A_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AD4080_CHIP_ID)
> +		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +
> +	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			      AD4080_GPIO_CONFIG_A_GPO_1_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			   FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK, 3));

Would be nice to have a macro or comment to explain what 3 is here so that
we don't have to look at the datasheet to figure out that this is configuring
the pin as "Filter Result Ready (Active Low)".

I would also expect to have some devictree bindings that describe that GPIO 1
on the ADC is connected to the sync_n input of the ad408x (AXI ADC) IP block.
Or at the very least, some comments here explaining that this is the assumed
default and if we ever add another backend or someone wants to wire up a part
a bit differently, then we might need to make this more generic.


> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->lvds_cnv_en)
> +		return 0;
> +
> +	ret = regmap_update_bits(st->regmap,
> +				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> +				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK, 7));

Similar here, it looks like the 7 here is the result of some calulation
based on the external CLK signal, So I would expec to see that caluclation
done in code using st->clk_rate or explain why hard-coding 7 is OK and
how that value was calculated.

> +	if (ret)
> +		return ret;
> +
> +	if (st->num_lanes > 1) {
> +		ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				      AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_set_bits(st->regmap,
> +			      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +			      AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN);
> +	if (ret)
> +		return ret;
> +
> +	return ad4080_lvds_sync_write(st);
> +}
> +

