Return-Path: <linux-iio+bounces-20013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9FAC81DB
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC737B49C4
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2322F749;
	Thu, 29 May 2025 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oOL386Pf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7E22DA10
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541138; cv=none; b=Y0GKMat2srgBXrAjf33Lh5zLC7cAZ+goDE4ghtZSKRijS5C0dpYPMIJGWMwTe5UwfAkcXcyftyvq1pBI+1JTIuDcyaMmeYoc3hW1qNNAlGX/A+biYMr1auq9n7CWdMVWkxppdcMYszWQJMET+ab+8TvC46RouO2kTGvaA/vVZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541138; c=relaxed/simple;
	bh=lZU9jQ+SXA+/p9RtnHyvE89sIS9AcJdWmjhJSFZMhng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el2oGi3JokwokCRVinPQdnO+7mR5u5/EZ+a3sVS7oesg/2piznv13fQr7EoNvsTKEqFff4a7kJRfXEYo+BZM+iYQL1AN40+HylaYMpgAxpEe0F2XY2ZMjaG3w7GQxHd1/dLi2bXQrIkT+Oh43lDBRjxaMac/NgIXk43+oc6BSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oOL386Pf; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60be827f2b7so568013eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748541135; x=1749145935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vC0sqM/mEIe/u85Iuk/8I2v+DAnDds+oTgi8MyInJSU=;
        b=oOL386Pf1Cz4WYZyLViDtGZExqj2zH6P+a0QroIfvAhowyqNaCsTVR5oaREHg/71ho
         5nerNe0xPDv4qcgpx2JuAZ/jFGsW9jsV12bIdRGw33ALENMy9cEtg/cNhewKBDKnjvsn
         h2kXZe6zu2TMweaUMbHqG8LxgPqvBCbhBuMTnxz/UrDJT61Mb5pQxnOGEdJTFGlAZRfk
         1lfZuXr34YqFtYJDzSQ39V0Rn1pD2C3gU9ZOPE57B9WtttuicwMdW8xRkFvL8Mytlqjb
         8Ns0cEmJ63p/VUoD+mWQwUC1IfzjQ7aV8RlB+eAcz4WMWjMhWXpQpAym/SjE8iaa0uPt
         Jsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748541135; x=1749145935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vC0sqM/mEIe/u85Iuk/8I2v+DAnDds+oTgi8MyInJSU=;
        b=oSiJSG8xqAVWMnQD7/80IX1NP2jPUZrHwq2cNYiBKHGR7wns1weVCR8qYcTj3ZqYs7
         ZCb9tychSOu0GcF4DRpTENHm6SevNvRFAarhG8tajh1sq9vqXPemgiMPfiI3Z/tvdN6D
         BUQqpJBd7WjVn6o5Df95c3hHPGI4oMQz09vPHkp0sfu/fjvFx1lG9lRRW98nxhyf0///
         g1+YUvaRMDPnxSdsdfRaAaYCcNMWh0HbIqkJSkzXNfCQITCjOJzwxWwHVyfuEcAnspUG
         3k1AXNneo+wSUYRmuwdjuXdLdXOdPV7gq513x07Ecrev7yr1VvXV36ybR2FcieCjsFUW
         lxLA==
X-Gm-Message-State: AOJu0YzdpwDC28rwUqzUJrDGkra+6dHLGJJeH5fzkk0HYQ6Qwl71Ix1d
	ZXEBvfC/zjLolPb3x86t/1JXrxzbkn3W0X1iSc5OrLYZcl7hu5LDIfAoXMyAiDr8kL0=
X-Gm-Gg: ASbGncsEZ3mjp/rDRTbKhrKg2BDDaMJtuY2ASxt9aRUINf4yQazFA20+CaKoPEvcNec
	bo+ArRz0Z+G4S2tOaWxQprTHxrW6HQoDqx7AQpLFp+enJzHdptD2baF5cXMT+wCVRUCK2FYJxK4
	yKSuUFRwV/XewcGVtXphdHEi31suJBza+7G1VOQkxriAD9YdSuaJLt3f34JqSM0CnvZdyhNWEd/
	lmdIUwbrMm4IHrMpvf+JqwIPqe3szkPCGWdmH21aSpiWY/RP5mGwV4PDD3Zu/qB5TpRTiQgv6Ht
	KtNuvDXDrz6KG0JqxMJNjERZPSaEgq3NPClF3R0qsXXMENSCZ6bikH35cEcStqx9QggAv6sPoZ/
	0WVco1M+7RvyHl5XOXLFY5JbluQ==
X-Google-Smtp-Source: AGHT+IGt4UUSwC+w2devQaz+4TwMifJlJrW3G/nBO0+JgCycpD5mxw4Ay5R9igDfQN0hx19JjOCzAA==
X-Received: by 2002:a05:687c:2ba2:b0:2e4:9c8e:f59c with SMTP id 586e51a60fabf-2e8fce259ffmr2234622fac.19.1748541135139;
        Thu, 29 May 2025 10:52:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4? ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906c11210sm351409fac.44.2025.05.29.10.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 10:52:14 -0700 (PDT)
Message-ID: <521f5868-5836-47d9-9a68-88a9d4e843f6@baylibre.com>
Date: Thu, 29 May 2025 12:52:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
 <20250529-wip-bl-ad7606-reference-voltages-v1-2-9b8f16ef0f20@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250529-wip-bl-ad7606-reference-voltages-v1-2-9b8f16ef0f20@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/25 4:13 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add optional refin voltage enabling. The property "refin-supply" is
> already available and optional in the current fdt dt_schema.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..21e63260965c32988d0ab3b8bb1201aa2396f1ba 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1335,6 +1335,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		return dev_err_probe(dev, ret,
>  				     "Failed to enable Vdrive supply\n");
>  
> +	ret = devm_regulator_get_enable_optional(dev, "refin");
> +	if (ret < 0 && ret != -ENODEV)

< 0 is probably not needed.

> +		return dev_err_probe(dev, ret, "failed to get refin voltage\n");

We aren't reading the voltage, so the message doesn't make sense.

> +
>  	st->chip_info = chip_info;
>  
>  	if (st->chip_info->oversampling_num) {
> 


