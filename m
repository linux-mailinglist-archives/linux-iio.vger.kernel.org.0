Return-Path: <linux-iio+bounces-9220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D849696E507
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583D5B20D97
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC401AB6D9;
	Thu,  5 Sep 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2zveC6n1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC67E56E
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571543; cv=none; b=aVcZmayLdyLEQPQpjLNfsjNZrinVow8tmULfgRoZv0RMpnor4X8p7FCaUqRynzycKKH5I8mrgpN+KTv95urp//Isvk1ZCiX2lW+17+/HU3aghWCT4jHA16YD6EaB7cTPs/8H7hJ/HBBFBldwW3F44EFso3dWIJek8CJWsJ3kGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571543; c=relaxed/simple;
	bh=HSVdh6DlK/bUQYWwhJ/DOlVdKX73tkTLOVCP3lGqjOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgrBTSaLuE7Jim8Dy1gJwzWea2Ub0vgr1cX1pSMcBTqqwVl9zBepAyAnxqAFyarDOLwDC76TCHoWL9BkBrlBJPsEX8/Jq6WysPvIGiLsrXnHFDKSvFCDy22JFpRqnVVsXhrwxoeyfm13zkmBISOXxqWIBP5JCH+U9QGaYr3rl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2zveC6n1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df0c80286dso805957b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725571540; x=1726176340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fu2LBq0wr4uCbYcpOIyALHAwFgwtVHbOrzj2MNQAIS8=;
        b=2zveC6n1qxVQJfTD0IhUJl/vozcEBRcM8NzyyhwH43dAdeU2BzKnFfEW58h12ABgij
         TCcjRBM24hSiXFKpTMzzq71Mf9Fah/jdFbtx14/72Pp4KAuN/DCZLERnJ71ZCGVzzgTU
         SSR33BpV8vg0uAYDqUQUDGp3N29zp4Ujk6G9Gmrlv7jpxewitFA7ij+5Xj/prdNFj7nS
         jybUArGsegRehyZtrlmKsBXLcHAxSOcnQWi1El1L4+5SIcF5XkC+uyB71twaGqj65BFs
         d+OvsdmX7LZ/jW3zHu7Qx+2JgCfper9zAuA/+w6nWU+Gd2uCfRItvYqy6XmHhnanXyhc
         xzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725571540; x=1726176340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu2LBq0wr4uCbYcpOIyALHAwFgwtVHbOrzj2MNQAIS8=;
        b=jF2W2fYpU01RG+2YGFZSLv4xhJZuzgVdFoGXujMwWFkrxfKt4G/V4NxMmYKKxuVD63
         jCUoRg2EdQIpEd3+eKLxb8DcNxq/LOsfqWfZz+iSJlO+aPYUCY4+OnF245vwJIIASlA3
         UqFNh6NWL5otO1grqqDLabXl8Pn+303H9o3yujDT159ALyUm9jMBq/UP7FYI30oCxuHo
         9RzPWRvLchpnEA7XAOtUGo9JCiEFwGkT8K/6A8pXjMDTC5YdSCwSI34IM/X/bG4OAi3L
         x5MyH2E2MickkAecbeVQ36R8mtoYsjjA5CaXcWaQDbnUFp2awISJbLO6+6RLm+JZhV5+
         hHXw==
X-Forwarded-Encrypted: i=1; AJvYcCXYigt9qRad6q834JC0wHQmaEHTO7hAf4M4/UbvDRHfO40ymsjfprVDh8BVWKXt2sNfPq5D6Hdjma8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoDxODcr38qpSGEjcBB7veMEHTxLAFDGYieQbABJ9dMPGDCcc
	jZX7JljSKNBxp+69kkwGitTcuo5uOHvoLMdio04HscqH8LSnrqsqblC1tlWf5O0=
X-Google-Smtp-Source: AGHT+IHdv/EbugAmJ7r5iwyOeKbvpTXIU+mFHAGXNUh55QcJGCrv3aFVWa6nJ0A/HsvDo91d7GHtsg==
X-Received: by 2002:a05:6808:2110:b0:3d9:4163:654f with SMTP id 5614622812f47-3e029f27515mr810531b6e.32.1725571540508;
        Thu, 05 Sep 2024 14:25:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865deesm3363718b6e.46.2024.09.05.14.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 14:25:40 -0700 (PDT)
Message-ID: <7ba70132-e661-4f4f-a0e3-0ed1efc1aecb@baylibre.com>
Date: Thu, 5 Sep 2024 16:25:39 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] iio: adc: ad7606: add 'bits' parameter to channels
 macros
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-2-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905082404.119022-2-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 3:23 AM, Alexandru Ardelean wrote:
> There are some newer additions to the AD7606 family, which support 18 bit
> precision.
> Up until now, all chips were 16 bit.
> 
> This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
> 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> 
> The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for IIO
> channels in SW mode.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---

...

> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 0c6a88cc4695..771121350f98 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -8,7 +8,7 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
>  
> -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
> +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = num,					\
> @@ -19,24 +19,26 @@
>  		.scan_index = num,				\
>  		.scan_type = {					\
>  			.sign = 's',				\
> -			.realbits = 16,				\
> -			.storagebits = 16,			\
> +			.realbits = (bits),			\
> +			.storagebits = (bits),			\

Technically OK in this patch since bits is still always 16 but we
can avoid changing the same line again later to:

	(bits) > 16 ? 32 : 16

if we just do that in this patch.


>  			.endianness = IIO_CPU,			\
>  		},						\
>  }

