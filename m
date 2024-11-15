Return-Path: <linux-iio+bounces-12310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289B9CF25C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B76289EEB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557011BD4FD;
	Fri, 15 Nov 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KNNZC1KM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AA558BB
	for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690461; cv=none; b=FLs84R2G2YGPDfpkJgGLWDLWR8zB5QdR3kADxH6vsdqUrjdFMTdOFJOnByV3k9Npqc0MBpUAnrKKxkETYuRXciyCjJSZmQIfVUlNxP41tU0AiZZM3ZU1G2s31qfGBWjxMFUNlPhcoKmIQSLHQEdEze/Of3UET91l036JeegQ6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690461; c=relaxed/simple;
	bh=RlgLCwt0pHAzO+8y8JHjzVJt2BMGqQLKA4J3pAJFt7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peBb55HmOmiFnE6OmLo1/pefQ28hPdx0NKSaKoeNTehSl2+koV2wnRoApfzatVdznbS4YEcqMTi/x3iCGyu66G0wamuar23MChKUROdGJ70L4/ynSK4k37KzDGFaSLCZSC8cypF7pkAA5+GbjfOo5FLLBm85spldIlxZ4mDa22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KNNZC1KM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e6010a3bbfso581444b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2024 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731690457; x=1732295257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UZ4bmKiEfcrQ88X0EpormBgHcykEkWHrKLssaVp+ps=;
        b=KNNZC1KMH//UilrDoY+W3OmZrVLJKwQnRxU9ErFB2vkIXGNrMrpsRSafWnd2LllDgY
         glJOGGy3T+FWqE/5tlaK4JLxOtDPbdQ0/7WMpSaEWo6KGGnpBzQfH+mwS5G0EVRZKE1d
         mkD9QEyUeVLdGBlNFC7HtPfY84iskgtUbAOD1VP1V6ByWHVJ4/Bt43ffaWWWwUA6/8aJ
         /6Ewg1eZjmgvgGEJpdNExRx2NJB8awcKJobTHbf8IT0OgTKZC25hpZ7GKbvH4T5p23m5
         HF+44VrzVUesHsbORPYf8A0oMDtzwzIqXJUSuW8qBFNwjDlX69v8CHQrWmmbCC7Q6M1X
         0tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690457; x=1732295257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UZ4bmKiEfcrQ88X0EpormBgHcykEkWHrKLssaVp+ps=;
        b=sbWWoOGX4WGZOO4tViO+AZQNqPKCETuSG3Pak1YSK42I+QkpPdkSLQ1BPVgPxQvoju
         TdhWkalyxXyJGZguok1z1WFBgnNfOaS3J5pS0hpHk9KHGq+sdVtZ7lKz6YG85sRS8WP8
         Vb1d/J+x76kgPYrayU0/3WGDH5p3JI7y2t3HuJNGc95A6wMMg8pnpz1GlOe16EKODqOZ
         GUrExdESCaDm1/cu/eLU8NFPw42VdjHYpvnNNARXBrtaNtN6pA3Bk/2d4Eqkx4+Ys7sg
         88Ldc/Nm/9LjIF+QqrfqtZi1neJfObcvNlaJJl8vrVIM73zDmEGigavroigtJlA4t+as
         QDbQ==
X-Gm-Message-State: AOJu0Yy/w3VUxNAvZxbvmHTpK6TA3Ambu3aUe+yvIAoLBe+Bxgp9Z3t3
	ZtK0h8BmhC6ivuccLQZV/65xRZ7bRNA9gcX3UY6II4btG7N7EwmCrBwfnVXk+aw=
X-Google-Smtp-Source: AGHT+IFFqGUcRPyBDjreOCcM1rzo3LgkxNVwNrVKyhxfFUltStJRCbjgMz5dV1Tl7g+Si9O2R8j5Zg==
X-Received: by 2002:a05:6808:2020:b0:3e0:3ab7:d7ad with SMTP id 5614622812f47-3e7bc7d2f6fmr4048241b6e.22.1731690457623;
        Fri, 15 Nov 2024 09:07:37 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm629389b6e.34.2024.11.15.09.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:07:36 -0800 (PST)
Message-ID: <7e302a49-db5a-444d-aae1-3c80ab75b471@baylibre.com>
Date: Fri, 15 Nov 2024 11:07:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: adc: ad4000: Use device specific timing for SPI
 transfers
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <81370b043de208795738e5679c33de37439c0a2e.1731626099.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <81370b043de208795738e5679c33de37439c0a2e.1731626099.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 5:51 PM, Marcelo Schmitt wrote:
> The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
> timing specifications. Use device specific timing constraints to set SPI
> transfer parameters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad4000.c | 50 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 21731c4d31ee..68ac77494263 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -35,10 +35,6 @@
>  
>  #define AD4000_SCALE_OPTIONS		2
>  
> -#define AD4000_TQUIET1_NS		190
> -#define AD4000_TQUIET2_NS		60
> -#define AD4000_TCONV_NS			320

We are removing 3 but only adding 2 in the struct below?

If one of these was unused, best to mention it in the commit message.

> -
>  #define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
>  {										\
>  	.type = IIO_VOLTAGE,							\
> @@ -122,10 +118,30 @@ static const int ad4000_gains[] = {
>  	454, 909, 1000, 1900,
>  };
>  
> +struct ad4000_time_spec {
> +	int t_conv_ns;
> +	int t_quiet2_ns;
> +};
> +
> +/*
> + * Same timing specifications for all of AD4000, AD4001, ..., AD4008, AD4010,
> + * ADAQ4001, and ADAQ4003.
> + */
> +static const struct ad4000_time_spec ad4000_t_spec = {
> +	.t_conv_ns = 320,
> +	.t_quiet2_ns = 60,
> +};
> +
> +static const struct ad4000_time_spec ad4020_t_spec = {
> +	.t_conv_ns = 350,
> +	.t_quiet2_ns = 60,
> +};

t_quiet2_ns is the same in both cases, so do we actually need to
add it here instead of using a common macro? Or if it is for future
differences, mention that in the commit message.

