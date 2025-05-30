Return-Path: <linux-iio+bounces-20051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E4AC94A5
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC34D1BA5EA1
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121E2367B6;
	Fri, 30 May 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nnFgPntZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE24229B3D
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625718; cv=none; b=s4xDjoIedjYplUtJFsN8T9ppbCiM31DDdVYJ0pRXDqvOw5P5W5UG3eIWxbeEqdokpL6qvQ/8BPyeVKfmZ9MS+HsARAZuu3trNs0W0cUaP78fosyv3i2RoGcXUbqoUyCcsRD3CYur1Wk2ffQEBOiU4agmFaEvsdUb6iJoBrEnWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625718; c=relaxed/simple;
	bh=wX0obJuWwWvBhFCj6J1Giw1HxQdDFBK1JTnke8Tc1q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx6r5OycBKsDqYf039RnBZJu1kWMNbbg34sRCr0RnyV3jMg6PJxlGuGnfIeZc98EAKRspKbCrFXkYZ07STSLGQW2go329xCZKZQAPKJbMTKQw6WCfqw5LNHDjfmE6TOdjPN4/cBYPsGT4zhg83G5pxGA2PtIPM25LxKzY6G5uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nnFgPntZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso2435797b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748625716; x=1749230516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fx3LNtc1BL1NPZaSnlXRzmMDR51HZrm8EkyfaUNT3Vo=;
        b=nnFgPntZOYUnKp2l5ic/2a9SbrYgstFUrEqAwuHT1KMqdz8GdcuL5iH5oWPuRz5C3Y
         RulgW/UFoVeQD1kpxwsUU6j0IIKVjIv3TGcpb1Nkh3pPChNFhNy6L+79K6zHpBoTU0cB
         kgyfPWKp4zanxFfA61oMhiCHIZHWfBhYWd0GSHhf+SMZlS9v3RzB3fyAE/FYb2M0y0oc
         OEyWkQkUeYJFZRyfkA50vyvmpeR9NKouw9YidAIpzeOHNMXXROIuitlR6Rmujdd7E8O8
         YTL7fMSePXCpvVtXFpvBViDy0bbdxF+zWsn5Y/GYYoZhV9MUUtd0ikpxM9Lcb3t6bTSg
         2mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625716; x=1749230516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx3LNtc1BL1NPZaSnlXRzmMDR51HZrm8EkyfaUNT3Vo=;
        b=rQNp4gNw1Ei89Iomf9I8qd9f+1V5Zz05CrEBFq3oknYLiJjLy8Im5gRY7DCZ5lcSFx
         Roh2JSqxesYKGxnm7Aiek5LCM8aXw8s0y4bhliaxWQAlw+TYRoEw0hNekMb90VPukskK
         rDwgImreSJRo1IYF1/vcCtSYb1kvaWbA9RZ1Vi2sD/ylJom+w49uIxb0P+CLUJ5a2plD
         jiAqzc5Yw6Yu7IVNg5ntIeVaYkwO4XxwybS+sUIRH6H4I7b52Dt4lE61JDFI7yh1O9z6
         xElOqhRxyqxHkMKZt0JdqSat0sqA3aMv1qsfDvvnLU2jW2rgvqcAUHO/aCNXnFy2j+Cp
         byoQ==
X-Gm-Message-State: AOJu0YxtOProaCrjWPx84FYJMM/LpcqvvG7iaH8njGCCk07mzw6uD7hK
	0GRuPbJMykyOzVWPraGaBfhsobEf0rkIjR0QLbvOvf9vixK9/j5uJHkLe7lfLsgN18dNZVNbUjC
	YgBl3
X-Gm-Gg: ASbGncsxbK7Aui7Ui4fLvO8WmiZV6Cm72ZUUoA/SUQ0mY+7TLQZNKWw0L++rV4X0jl1
	h0HweiRG9g+FWFPPeHG4D1LyNkJ798y2P0zWQI1bm4gQxDM4lpFBqa4C5m2y8LbfzVxmND/oABx
	c8uEonukpqfereeXrBvW0rUwVpLuUr+UoZrC1LnxOcW4MrgN2mdWc5aUosEJD5SniX+eY30qr8M
	oBDcNTOM637NWovJ5wmsMYOQTIhBsRfPRIcLKOdM690xzDxCZOeh7aTw/tsZc4Pn/T33giEWOZH
	QMYO1Hi4cor7E9dXhgL29fpKkgnfVLjcZ+lpH84fulDwN1UkT8zk6cufCUveo3CYhoQroaC8gCX
	dN3uC6C5nfAFuRFMF6PXDgEqMwLYyvfvZ+re4BKk=
X-Google-Smtp-Source: AGHT+IGxQ4vx/p7gFcrPUXmfUl5nW4TgCsxZE4dbab/ZMJxQ+jpblaeElxTMSWbhudFctt+RNP7NeA==
X-Received: by 2002:a05:6808:448d:b0:3f3:e9d5:7790 with SMTP id 5614622812f47-4067962bf6bmr2154323b6e.6.1748625704848;
        Fri, 30 May 2025 10:21:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40678ce830fsm453255b6e.31.2025.05.30.10.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:21:44 -0700 (PDT)
Message-ID: <ad5b68b3-75f3-440b-80ef-6fc58128767c@baylibre.com>
Date: Fri, 30 May 2025 12:21:43 -0500
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
> +
> +		r_gain = 0;
> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);

ret is assigned but not checked

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

