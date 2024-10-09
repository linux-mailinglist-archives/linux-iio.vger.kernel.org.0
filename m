Return-Path: <linux-iio+bounces-10383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC122997786
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878121F234BA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048251E1A14;
	Wed,  9 Oct 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Espne5v8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF32119;
	Wed,  9 Oct 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509489; cv=none; b=j/XumFDKH9OEChV8Nh9EKsz5tyqUQ15n5K0lxqewlYytJQ49eb0PjqNRgNFW8RYwZllB4nJhK+7nobxTnuZPjJebYQSrS8VoF/AtH9HeHYbcwx0gDBLuUlAC4lo+48MWbQfxkuR9V/riYgFOWGVokHbXnBocPBoEc2/4fv4/z7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509489; c=relaxed/simple;
	bh=//zTy4UpgvpMhiM/XLBdEkqk315aai76inbYAwOg2iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LM4SR7TJCFwpEM18AQ7zHrC5gr2rekdnSyOwjlNz8re+L+NQ8PnebDg+alPqRy7wCTl8YS3cebHaLcQYNabkO54V/6kQ0T/+mplEseGuXYTRbQDbRjjz9QBNG2qGK78lPHAoPhwKZhXElVosG/0xcN6whZT7qaH7hh1/rkSSeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Espne5v8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d325beee2so108166f8f.2;
        Wed, 09 Oct 2024 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728509486; x=1729114286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH6wGAFhOB6srobU+680PWFL7Rl7n2W1X6InnwCuKD8=;
        b=Espne5v8NdIypHuxFL+vX23yua3GB7jrcWICZF3I/jX6PlS4rEGpJPjTy03SE6YDuI
         PXSGEtU+F3UklxBzZz0AY4iNwnr1nWbJCjfCVvET5DiCk7aTyUuHEry28gcbntfp6VXU
         +T1cYpNxvoUm7c+w6q6K1hnYJQMtOJ70zF7CHnN9sg7TdjqdqH2U8GbMW4CwobqfI4qt
         fOpSPtFyj0juqhzB26UBntKwW9270k9GIcI+V6LGNS6dwub52Qd61oYGw//tY4/8C/oS
         ZgfeJ00BZgAGKYH5SvK/OiYPxosg3Ahmn/gVjl344gJF5fZ4EuQiFZ+r0MjHU52DTgCU
         8q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728509486; x=1729114286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH6wGAFhOB6srobU+680PWFL7Rl7n2W1X6InnwCuKD8=;
        b=Fx0ukR+wBgDvDmcMdKDa0oe6FG+FRemfsW0j3QglndNx9HFdE6xNw4Q5BIPcxsvjxM
         mA7svvTC940zMtGjs5UJj9+Y+UWxh3/ndcvbRUsOT3KKDZ40xcu/E76KnfoT3xe/eFue
         w3qnbfQ1H8rMe2Q3oQ1G9D6BSJpgPMZveau+jX3BH6IeEvGQ0ts07zYzMaCD1SwBvh5t
         qysGtlAd0In7U4aeeTv3pnPHEDZWM3487U7Hbt9VhZ1klAg2XNuy82lNeOIJVEpGw0Hi
         JQm1xSzLdEeTdgfWkL7Z+awFYrukJIf3TVtuMDSAvqNlcGYxvDhmjL+gDQCBwIRqWU0N
         dJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCULrzNWDlDH6lwnrE5bPcPCL7KxXGD5r33GfAxHmK/JIT8Ru6QfvIwj8Jbyx7hCuONaMC7X0LRSRd4=@vger.kernel.org, AJvYcCUsyK7ms0WdOziZ3ewpA2dYrxcnaarBPB8FxgJHsIdfxUQY/xchkeHI3FB/ThvG0iDeBo2GyqR01rWbumNf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vvoTmiSbtbPXTckCJv3InYqAZl37X5ZV9HQV+YDV11sG7psG
	jdw9TA2scw5LmU2PyYXJgSYtcILdbi36IcFyiPjdSIxsZnhiJ4Kl
X-Google-Smtp-Source: AGHT+IElj7f1i8wI1OZNrsFktsrjPKw7XmpY1ZsUX2Jm/s1Br/mRzeFkfOJUM+2vjknbLf3K5iJD/w==
X-Received: by 2002:a5d:564c:0:b0:37d:373c:ed24 with SMTP id ffacd0b85a97d-37d3aa23c8fmr2510699f8f.4.1728509485428;
        Wed, 09 Oct 2024 14:31:25 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:268e:1448:f66b:a421? (2a02-8389-41cf-e200-268e-1448-f66b-a421.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:268e:1448:f66b:a421])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cc7sm11367605f8f.61.2024.10.09.14.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 14:31:24 -0700 (PDT)
Message-ID: <f356d311-ea83-4318-8b47-15f39944e913@gmail.com>
Date: Wed, 9 Oct 2024 23:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4695: Add missing Kconfig select
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2024 23:23, David Lechner wrote:
> Add select IIO_BUFFER and select IIO_TRIGGERED_BUFFER to the Kconfig for
> the ad4695 driver.
> 
> Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I didn't see this one in the recent series with similar changes [1][2],
> so here is another one.
> 
> [1]: https://lore.kernel.org/linux-iio/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com/
> [2]: https://lore.kernel.org/linux-iio/20241003-iio-select-v1-0-67c0385197cd@gmail.com/
> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 85b82a708c36..98d441d6cc5c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -52,6 +52,8 @@ config AD4695
>  	tristate "Analog Device AD4695 ADC Driver"
>  	depends on SPI
>  	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD4695 and similar
>  	  analog to digital converters (ADC).
> 
> ---
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> change-id: 20241009-iio-adc-ad4695-fix-kconfig-279c9ef8d9ef
> 
> Best regards,

I guess the kernel I ran when I found the issues did not have triggered
buffers for the ad4695, which was (more ore less) recently added. Good
catch!

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

