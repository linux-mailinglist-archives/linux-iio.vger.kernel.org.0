Return-Path: <linux-iio+bounces-14438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99478A15926
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83721692E6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9A1AAA1A;
	Fri, 17 Jan 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FinCwFGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127201A8F84
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150343; cv=none; b=qFmZn/sFgGJ51GJ8JZWz1YY0eSfPQCaLx7DQV0sKI5dILXIp9fCzDFTMNhmCVGyKptvalHFcQa6qZfpbBmp/O72+k/gxe4mUN32YsJpVx8RaeqXo5DpFeqnasamgka1A+McBjmy9uvdtN9GPyUue4iQ7tQDpvajRrY6wx3xkjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150343; c=relaxed/simple;
	bh=42ZclBCmMMxfREeBFX3MvxJLMXEmuRt6Y4lAfcNMvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tKiesoCupwWRs13WGwEFbqGQKV5hLB24uuKSMNUNeym2UUJAw53vxh1Sbd+SefFHJLmDxahu/TRvKg06Nk5pknps370oGrSdMflSefejaKQquoAEpeZsLftPgkqrvYHMZPRcHMEz/BX+e7PnwXJa9a3cOIa+irkKY8jWGJCgnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FinCwFGn; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2adc2b6837eso845444fac.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737150340; x=1737755140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEHgvB4+/pUa8EYaY3HZEDkJbWxXbz1BDJZaymb+qzM=;
        b=FinCwFGnQneopHSd9QXRpynldYDKG8aGCPeHfBskUQf12qm+UBhDKC597nliwmgaAs
         +TiUbp6ced1jj6QAhjmpZc1nLVFCx0LZouUlhc46fsb8ppuh5MRW9mxrd1fHkK+Q90R4
         hZ3mugN9yhQinZeZ11z2maXiUDItnDGa2sXuZJvGHtzQRDedSeBvtVAWljPr/OLUIskB
         IGyrnWZmBfPfnpZkGxKgAMGcdrXIjHxEbfJAE4yf8R8XpwHnjpNQs0Qc4C3plPpQVVav
         BP6RhJzwJIwK7QwSb3sjdJdAElsG85IS/VEkAPtSD4DpMd4ZRuwXbr0zf5pNKUysRAvl
         Wq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737150340; x=1737755140;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEHgvB4+/pUa8EYaY3HZEDkJbWxXbz1BDJZaymb+qzM=;
        b=hbK0TA36RI5Q0Qs5YdnEM/HN46QuTuJREviG/AQ4bil2DtpM8Dw9uepylocsL0XYEo
         mUZfH/NJxVjwW1u5i0gz5Rqov2yWjJ/vt6j+QKBPNBNLb11lyRVaI1mW44lS2zcu+RzZ
         +jvYLfWIEe+pWxUVNqEOYsE42mAZny4mgqzYrRGWOHQWRySQuw/strd84ym+UsX7RS/U
         T8qJdfSWqmBgOcgIBoD4PrtimpJTGqxN+Hu8DPzcMCvpJ0CkMHBXM590nH9Gw3M4OGGd
         btQBDjgXwLKuR/f4ALqWRtHWYGvdQi+MKD3V3l20S2b1awfl65SnOLDhelk+RbeNTt+y
         6RwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLrUBOI16F4dtNo4HjBSdab44Wki+uIfOFFs9zC4bz6jlSP8ynOBKQcL8pnjo4XEQFZ9/L2DNbUqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Komre+EWO7pt6PFag0gDkRrHYqWRjMLJUxi23jE5FPeto3gE
	3UCujk3MLXdg9dutOF8GKGt2nKKNgOgEAVskEA0s1POkKU/NLaGT4CwZkOY9X44=
X-Gm-Gg: ASbGnct3I5m02odwIV664B5K51dC0WBPs2Brxd9Un4QVmA7q86O/k/G2XUorL60mVb+
	tPlfPshjuLpbMkIxEXD9PnylU3534DJyE7y7hZVsvDvzbkjfwPa/YVz4T8rKdzIJDjkZ5GgkGPl
	UvQf4PaocDSrhWddMxBg4k1laLtHsFdosKdm8gpyJ7+Hf5QCxwUoEC45IWjNvwFEC1vAFZ13iM4
	fw2qO6D3G2NYgxkGwEITFtlocdh3d8u9Z4gabsAupVnmCxU3d7szPSJnwNOK8I4DnUR1mtPQG0X
	+Gi/AYUxep90kQwgtA==
X-Google-Smtp-Source: AGHT+IHrWZAfY+N1YltqPls1oooCUeyySmDXIao13oIEZyC3bZ7RXj+c/hOWdD0RPsOMElf8sT7uvw==
X-Received: by 2002:a05:6871:d307:b0:278:1f2:a23f with SMTP id 586e51a60fabf-2b1c0a2db12mr2432720fac.13.1737150338630;
        Fri, 17 Jan 2025 13:45:38 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8f773cdsm1341030fac.32.2025.01.17.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 13:45:37 -0800 (PST)
Message-ID: <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
Date: Fri, 17 Jan 2025 15:45:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250117130702.22588-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 7:07 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct iio_scan_type *scan_type;
> +	unsigned int tmp;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);

This is ignoring possible error return.

> +
> +	tmp = ((u64)scale_tbl * MICRO) >> scan_type->realbits;
> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +...

> +static int ad4851_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->cnv_trigger_rate_hz / st->osr;

Needs to be:

		*val = st->cnv_trigger_rate_hz;
		*val2 = st->osr;

for IIO_VAL_FRACTIONAL.

> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_get_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_get_oversampling_ratio(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4851_set_sampling_freq(st, val * st->osr);

Since we are using IIO_VAL_FRACTIONAL on read, we should handle val2 here to
allow for a decimal component.

	val * st->osr + val2 * st->osr / MICRO


Also, should return -EINVAL if (val < 0 || val2 < 0) to avoid negative values
being turned into large numbers when casting to unsigned.


> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_set_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_set_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +
> +#define AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> +		BIT(IIO_CHAN_INFO_SCALE),					\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_shared_by_all_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.indexed = 1,								\
> +	.differential = diff,							\
> +	.channel = ch,								\
> +	.channel2 = ch,								\
> +	.scan_index = index,

channel, channel2 and scan_index get written over in ad4851_parse_channels()
so can be omitted here.

> +
> +/*
> + * In case of AD4858_IIO_CHANNEL the scan_type is handled dynamically during the
> + * parse_channels function.
> + */
> +#define AD4858_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec **ad4851_channels,
> +				 const struct iio_chan_spec ad4851_chan,
> +				 const struct iio_chan_spec ad4851_chan_diff)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels;
> +	unsigned int num_channels, reg;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret || reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,
> +					     "Missing/Invalid channel number\n");

This allows returning 0 on error which will lead to an invalid state. Probably
best to split this into two messages/returns.

> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*channels = ad4851_chan_diff;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			channels->channel2 = reg;

Typically we don't set channel == channel2 for differential channels.

> +
> +		} else {
> +			*channels = ad4851_chan;
> +			channels->scan_index = index++;
> +			channels->channel = reg;

These two lines are the same in each branch, so can be pulled out of the if
statement to avoid duplicating them.

> +		}
> +		channels++;
> +
> +		st->bipolar_ch[reg] = fwnode_property_read_bool(child, "bipolar");
> +
> +		if (st->bipolar_ch[reg]) {
> +			channels->scan_type.sign = 's';
> +		} else {
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	*ad4851_channels = channels;

At this point, channels is pointing to memory we didn't allocate (because of
channels++). As in the previous review, I suggest we just get rid of the output
parameter since indio_dev->channels already has the correct pointer.

It's less chance for mistakes like this and avoids needing to provide an unused
arg in ad4857_parse_channels().

> +
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);

The only difference between these is the diff bit, so seems simpler to just
have one template and dynamically set the bit instead.

> +
> +	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan,
> +				     ad4851_chan_diff);
> +}
> +...

> +static const struct iio_info ad4851_iio_info = {
> +	.debugfs_reg_access = ad4851_reg_access,
> +	.read_raw = ad4851_read_raw,
> +	.write_raw = ad4851_write_raw,
> +	.update_scan_mode = ad4851_update_scan_mode,
> +	.get_current_scan_type = &ad4851_get_current_scan_type,

Inconsistent use of & on function pointer.

> +	.read_avail = ad4851_read_avail,
> +};
> +

