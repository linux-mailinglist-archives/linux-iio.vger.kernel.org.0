Return-Path: <linux-iio+bounces-14954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B47A26707
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 23:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4355C165ED0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C242116F7;
	Mon,  3 Feb 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f+6XVLDT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BE210F5A
	for <linux-iio@vger.kernel.org>; Mon,  3 Feb 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738622533; cv=none; b=QN7ULOLbiqpi7oAYPTO0usU7ISAThf29KdbHmcrQHTVPWLrTVFLZyI2lHXvtZQVRutpUMn+Op1eOkiC3zRviyqbh3q7qCPx2beBEdd5FDWUVnf+DNKgokIYSDAtoZoLCXHLIFhCa0y2tCMasOR5IivCCkKvIt0vlt37ffARAg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738622533; c=relaxed/simple;
	bh=SXY/ut4HPZGjQfV0TdHI+owQ/8IPFSL6uBL1jYm5kIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lPhsSuhqOqBe6x7c6c/7akll5PK5r2wGduqzCzmXKiCjbMKDhHnnz1qRxEdTJY8wDYitxaJNO00lPG9UdelA6pxmob85DDYVUVfC0azWERuvL1lR9jVkx5b39Xh+Bo7w0fL2rD7hOQc6QxMbyjCJTQ9Qi8zJnuyul0A0MbqB6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f+6XVLDT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb8db8ae9aso2080148b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2025 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738622530; x=1739227330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJnIfOP7+jSlUs29FECy5//ffpMPbLe/6pSEbA38u3M=;
        b=f+6XVLDTnechdqBluVSaw5ZSyuaeMkrWSCzOIU0YoBMQyd87gOtCjssN32aN+ldeTf
         Pqh8ZBTqzNfmbgqz8hLrf9IbtyuDBZUxTWVY+fqhFSHs5igqV7RjkcH7Y5SfBThQ1NTt
         SzNIzm6rbA39f7faGwOlb9dJlqlzH741aSKQE3djTpu4XuWwdeeO/UYTHQ1H+J2WM+js
         ThAahDQZCxFRBTEMnq3hBwH0xepC+q9gT3cezWS2iVYCsDliAiqK/tP2BwYEnLqCp5y+
         Z4GnsPhmf3k+bEox8ce/qAQWKkQ+E0UGsmCcpAGFrm5FZPiB85WjnAW9bnFJr2PiSY1h
         VYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738622530; x=1739227330;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJnIfOP7+jSlUs29FECy5//ffpMPbLe/6pSEbA38u3M=;
        b=bXClYGrJ8yxzEUbFwSiPMKS9VmS+REnvLTTv+pWlsYkJhwbJGYDg3nfmbxcfCQJPM8
         pddtwlfDmvJVzGrHjco5DiBqAfSU3v8CG/nmko2ZInd7u8Wf/AWnEXi7f53Sw3bTfPVM
         wFQTl9lb9Q7avDb1d+e4ZYKwPDVr13F7p60hclXnIMJUJvXpXYb0xvBvaRVi8n6h3nV6
         MU/KdVwl70MsB7DFvTTml69S8i8ebRzf0Ufq2GPvAOR7horF4PiCuWnulkELALGMepdz
         wW482s7x5txzhjj+t3ugXREqZKSMnvODVt2E8OMSPQItgRdgE5xDRx6fNS6cYxkeE1tX
         /86w==
X-Forwarded-Encrypted: i=1; AJvYcCU+abTlUCj3/aCJhMVxNckhYLrlgq9finOHiGFMqqE2KcSeIhWf9522chK+8bi6DbbdMbQdpBKIECU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZaW7CqDOgnIQ5ohbfCwxQzWGdMTlDX/dC80OfVzorrxOU/fs
	5d9uk82uaqc16qZUpJEuIr+Djn8FqKILhE6zOKaA2ZexKkC4Ckhx0cwNUoHV7Gs=
X-Gm-Gg: ASbGnct9bPJXW2Cb9u7EcPKdXotTsPiLV5px0blEaB1jjYx81c42eYt56PC4TAUChkl
	K30uUY9RNTx+5OFMqPM6o4tqNSUhA3FHXcwz6Xb/Vyso/LXca6i0KW4NTycL/9bKmrmmu8wlIXu
	GYeVQ3MVkzmikqrvHtoa6raWfndgmbn0jnzsxBTMrkTY5iFgyeiZzn7CkJlvTR1BKhBhQXSssTv
	72tsCdYfggH8Ji25fOR7VrAAV/h6k77PBrpN4/ZfaGAFOeIUUuiVHbaCr3nJHCAm/TZOZ/pvPe3
	oDREJB1z7Cg/GulphcxMN0c7Hq7f0qYyz41S2eag+eUd9oJC7ajg
X-Google-Smtp-Source: AGHT+IGPg3Ki4+QlI+PnxMX8N884nW9RTygynBG8qVyReXZuEsEhrg1HOrCB1+xLT/4DE7U7CBVGQQ==
X-Received: by 2002:a05:6808:2f16:b0:3e7:df63:15bc with SMTP id 5614622812f47-3f323a184cdmr15101787b6e.12.1738622530456;
        Mon, 03 Feb 2025 14:42:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333523efcsm2731729b6e.8.2025.02.03.14.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 14:42:09 -0800 (PST)
Message-ID: <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
Date: Mon, 3 Feb 2025 16:42:08 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-9-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250127105726.6314-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 4:57 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

I think we have the important bits sorted now (i.e. userspace-facing stuff).
Just noticed a few minor things in the latest revision.


> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (st->pd_gpio) {
> +		/* To initiate a global reset, bring the PD pin high twice */
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1000);
> +	} else {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				      AD4851_SW_RESET);
> +		if (ret)
> +			return ret;

Do we also need fsleep() after software reset?

> +	}
> +

...

> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec ad4851_chan)
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
> +		if (reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid channel number\n");

Need to check ret first, otherwise reg may be unintialized.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		*channels = ad4851_chan;
> +		channels->scan_index = index++;
> +		channels->channel = reg;
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			channels->channel2 = reg + st->info->max_channels;
> +			channels->differential = 1;
> +		}
> +
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
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL;
> +
> +	return ad4851_parse_channels(indio_dev, ad4851_chan);
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL;
> +	int ret;
> +
> +	ad4851_channels = (struct iio_chan_spec *)indio_dev->channels;
> +
> +	ret = ad4851_parse_channels(indio_dev, ad4851_chan);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ad4851_channels->has_ext_scan_type = 1;
> +		if (fwnode_property_present(child, "bipolar")) {

fwnode_property_read_bool() 

(to be consistent with same check in ad4851_parse_channels())

> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_b;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
> +
> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_u;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}
> +

