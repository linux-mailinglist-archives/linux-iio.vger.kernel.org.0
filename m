Return-Path: <linux-iio+bounces-20050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E06AC949C
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98215055C7
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8423770A;
	Fri, 30 May 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WNOPIDUV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3700229B3D
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625598; cv=none; b=RCSGZqTg/gzDhnSwl0KK+W00bdMzmRCbjHHQElTBgD6hLUFqMbSHQS/AxgvwKCas1kTG5sthjkYP1sX98Vpd5tJfjwu1x50cYxuAM/FXqrShIS9Jh9TxmzYZZjEIPw2NvVSfkBiNkjoZGHfrh0G2ojhr+RQZCXY+g5MpGr2HorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625598; c=relaxed/simple;
	bh=HMRcBPxFLRL8zWucCrFR6eiWaxDm26zk91Pn6r5m0SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAtyZTZnN+bCi9Q2hBAa1Y3/bfh9TZZCrsH7+FbmAfe3jHTHECIHXl97p3jkt1uY0S5wBhFl38JwcBgg++ghN3E4jkh+neppN7vFDF1ynAX0X3wNH3sIuAkKeT7McQa26EOcjWwY8Hyp0uYpX8HDCPFOAvsG9RP+Pf2OiKVXaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WNOPIDUV; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-735ae68cc78so1374430a34.1
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748625596; x=1749230396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hl3zg7f8gq+l5qG5ruPbpuE3dBxZAj6EU7u8jCcyDSI=;
        b=WNOPIDUVeE2YKlkm2fPv+ED5hpEx6PWHF8ZiHSCxWdwOrJ7623nA+M19KKjbcoxFep
         K+ozGP8NWQ9bLv/xYGTqMHGJNsF1We7RpJ8pPKyygIO7nMA5Sk7jn48AhHXxk72mqFxC
         Kqdcp/Pw9xMnx6cS5Xb5qbDiZVxHZ0MKAT9aCQLcvqIwwD5hpiUgYgVGTV8/A5U0YphU
         UetP+NzoM5RNdEvFLbWwRW2dfi85OSj2yYhErEo9SkYPBPKFM7M3tFCba24sV6+RADY7
         ynerLCbEJj2jrvP35cQlnPX2FwSLmy+OL85Wkzks+490s9XTZpiZQsm+HvXjAP77OHuE
         fEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625596; x=1749230396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl3zg7f8gq+l5qG5ruPbpuE3dBxZAj6EU7u8jCcyDSI=;
        b=nxNSyGpNBywdFvuisEL/tRscGybw0k10hzbAiwLWDHxu4S+obBM5/dDQx5BuY7DYvk
         DLLO4TjUf4hxaFunW098DEnS6sTbo7x4v89Pze1xe448A8ucpS7ImBgFxqrMWiAAWNoR
         r5ICMAdhEPEosqdyB5td1/9chuaGkKDpgWxfeksc0M/wQmiuVaaZ1bQ2UT/6300NQBk6
         7eaDKzw3aWjXQZ225lKMmA8zP79bmWAoj5UxMZceY60H3256+x+t+KclclkLGlK+kcSX
         tCQEYAeVWfgA3DNZ7B3ojHqT0xkGfHrAKQFtaLORGbutfAX+4hOfsSsBiZqV3XAk8cU+
         hgFA==
X-Gm-Message-State: AOJu0Yxsum7SuoLy8iXJs73FOret+kHgpTYODYchyE+6POuF3Qarh0+t
	RZ2rFbWBswE5vli3aIbFGZ0QrzupSG3HmL8cHI/zDQb9HlZlDX1YaIeuwZ3DMEBzeH4=
X-Gm-Gg: ASbGncuW2/xPmj+6rmeX+vM/WBL+8DmeDHrAKiJAdiXUNY+YHPUYMwr+5gPi1puLBey
	ZKJcOB1y8tLNMKd8A9YR7CpK+Lg6gCdIxTK8M2xg/N18s4ZsHPN6DUjvqBhQSB/S7QpYVN9XNx4
	0mVHsSfDok+KUycGwmuJtLMSWiT4UYgvA/MX9kiseZAJRTtEH2ytfVweTMX+ZifDd+2T9YCbxci
	qzhNi5NIoFqie2HE1Pza8PpAesmA7wHdeG7nWcDjAjLH6FNIICn71l9f05YPbbzvbpJw311hVrA
	wh7nn/ehemwyrvnFDn7hXsHi4eHjz7Jck8avLgb8YzhsRzf17UKK0Y8rj1PowqJgmClnUHYe9yU
	s/gj9tZBNwjzaZgigbU+uebvRSZmg
X-Google-Smtp-Source: AGHT+IFn+WqN0pov0ImkTs3JeWNX+a1ksqlo179uhSF9zJMLQZ+WbUztQFApqGLg2Obw3Fz5phANlw==
X-Received: by 2002:a05:6871:4f14:b0:2d5:2534:ac19 with SMTP id 586e51a60fabf-2e9211a87e7mr2245882fac.4.1748625595764;
        Fri, 30 May 2025 10:19:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e9067a57afsm719360fac.11.2025.05.30.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:19:55 -0700 (PDT)
Message-ID: <a6693794-1c21-41df-80e7-69c4242f394f@baylibre.com>
Date: Fri, 30 May 2025 12:19:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
 <20250526-wip-bl-ad7606-calibration-v7-6-b487022ce199@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-6-b487022ce199@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 5:03 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.
> 
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

...

> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int num_channels = st->chip_info->num_adc_channels;
> +	struct device *dev = st->dev;
> +	int ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		u32 reg, r_gain;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* Chan reg is a 1-based index. */
> +		if (reg < 1 || reg > num_channels)
> +			return ret;

Shouldn't this return -EINVAL? Otherwise, it will return success for an
out of range reg number and skip any addition child nodes.

> +
> +		r_gain = 0;
> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);
> +		if (r_gain > AD7606_CALIB_GAIN_MAX)
> +			return -EINVAL;
> +
> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

