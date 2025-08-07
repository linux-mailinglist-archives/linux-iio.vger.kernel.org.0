Return-Path: <linux-iio+bounces-22405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516EB1DAFD
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CED17CEE4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002D1C5D72;
	Thu,  7 Aug 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="riyxmJM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372EBA34
	for <linux-iio@vger.kernel.org>; Thu,  7 Aug 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581654; cv=none; b=YA6i37sSSRoTicwsRwh/zYc+ck70x7TXyyQjRYV72aZ3xA2vqVDayVNIiI6kRiFojBWmyc3FikG10A7gQk19KWxuYNxOYIvDVdHjYhatpO4AOgitODzWX+7Vg170VkdSGZf2LObGGSTdsSmoKJ65Tba+hnznQmWBzaN7ztlZ3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581654; c=relaxed/simple;
	bh=Oxi5eWJU7s2SlcsiqYRHQ35AuzWO3Fb6jKMq/IZZdFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS4YzhuGMY6P0J9555nALUe0UUdDLWMV5v+NwTFy9HwtOOb+Bsvr7eu7ioETHBRLdBSvwRtwc0LTTP1oMPTi8G+ls7aJIYs+D5g2yxW/CccJNvI4RfkrMaNaXRPDySTftyJ07esaobeavDpgtlVGztLIrgi+VfKu5Tow0ASb+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=riyxmJM4; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61585dfc8f8so417732eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Aug 2025 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754581651; x=1755186451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9w+Mm/aT3ZlnWlb1RihW8NtCtGTA4ZWXS9cDDH/vP8=;
        b=riyxmJM4z0XrZ30wsE/HKcssC1KgKp4HhYHze9HkQVW96+jiE6ZYLcyFTyiM/cbjEv
         jQ8Qe+e3wqvseyZALXPj/MkJTpgmMAaiGcShjsWYuzbHdHUdhY4AoW7LAGLwKTTiStc3
         stUiZR9n/tYGLgHEocT0K4br+cr7XNJpUzZojK7mdLloHT2W6pm9BncZQjU13WDzdRUg
         MVoDceZpD5wHnOGFhcdK48bTKDBfAuv16BNumER2WmXioOrHWTUuhs0sTPty3LHw/5yS
         ErL7FXPZx4vvr3U4xCbKog1BJ4NisfawbN1Bm6lDH3mATToQN7lpZBq+Qy+nVuh6jfo3
         lj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754581651; x=1755186451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9w+Mm/aT3ZlnWlb1RihW8NtCtGTA4ZWXS9cDDH/vP8=;
        b=WXtHYEu6PDhjyH0Y0wMsRaJ9b8ub1od79kxJ5QaYUCuWvKEh5PNPqNtGySkhABVQ76
         K6LR4HYp6Ki9rV5BOzZmhXVzE7gKqLUKE10MePIgH5kXJpPbj6zjc+XkapbY1vE9LyE2
         mhcUJOHnCdlmhMv3SLkSPMwmrRuBlKInuM7ghGbiPsfGI3NfDXZI6qjhDnYEo4CTIkIh
         CW/QTtYKEN43YoI95HtGxXDTIk/vjiLLe9FJwWLhvY5l5I5TC0OT313kdJ0r/gO1YcVN
         g31wTW+ecMRIg6HqM1WY3ZMeco3i5Ax2umXCGozFukMPZ/GoAg7NRAUejqjVw1iaueMS
         OTHg==
X-Gm-Message-State: AOJu0Yw05cKs+kFdmzNVccdreFFPc/s1vfonc7XaK/+BAG2p77glGQfw
	InAXt5kDDZ0aB2/0fbW2kqIcuQe0Hmo2bw0+K+7D2sm0U3IpxzJvddV52lXwics4/3Y=
X-Gm-Gg: ASbGncs+o4K15YSsNQAaajJdWrG3RQYRBMdpbtnGbQLZR1JBCN0tOImIqJxif3H1bS8
	TK4ivWTg3DjZba9f/ZDvBAYLKaI5xO/EcPhkR6PU7a+90zGY9dWsy/eU3sLwO9yebuAgqzRQf9k
	PX0ADiRttQ/WeiqZZzkYn95QNjosnqW8LSEUAD3GG2bjQcEmwmbjk+xe6oi88ED+mpsX3zk3Zm2
	aaLhXCL+ygJvpaYSuC8ZVS2FLJOQKWOPlZImFeDOfNxbtT4YyEcGTMMewSY6dDQvQ2Rrkic3vZF
	pxmyod/zTSMyxupV3xU9Vyp/zG0+se4Wj/WkIEgOpompZmujvgbe5u83FtCG0hIfPYZqdysY2ne
	Li7aGLiIil/v/TzWESJP2nekQ7eP537F5+DsSMU1HkRQhlAXJKRFJkyWquOkzgH4xUAHXh6M+Cl
	M=
X-Google-Smtp-Source: AGHT+IH/jQmRIhTYgqXAQJlVNBbxOFGgfnuGhsoGMmbqNIfHN5FNVDYK+7XSfSv6eCDpXoSo9hgqBA==
X-Received: by 2002:a05:6820:822:b0:615:a91b:8e7b with SMTP id 006d021491bc7-61b7a7ab42fmr159249eaf.4.1754581651349;
        Thu, 07 Aug 2025 08:47:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ce54:d09f:5709:ac85? ([2600:8803:e7e4:1d00:ce54:d09f:5709:ac85])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61984046280sm2642947eaf.30.2025.08.07.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 08:47:30 -0700 (PDT)
Message-ID: <aef22644-2869-4888-8fc6-f14859917dcd@baylibre.com>
Date: Thu, 7 Aug 2025 10:47:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: adc: ad799x: reference voltage capability
To: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250807074850.130831-1-stefano.manni@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250807074850.130831-1-stefano.manni@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/25 2:48 AM, Stefano Manni wrote:
> This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> in order to add the capability of the chip to have an
> external reference voltage into the chip_info struct.
> And so avoid ugly conditional checks on the chip id.
> 
> In addition the AD7994 is marked to have the external
> reference voltage as well.
> 
> Changes in v2 compared to v1 [1]:
> * remove has_vref from the chips that do not support it,
>   rely on the default false value
> * remove useless message "Supplied reference not supported"
>   shown for all the chips with has_vref = false
> * refactor check on regulator being err or zero
> * add external reference to ad7994 as oneliner
> 
> [1] https://lore.kernel.org/linux-iio/20250806090158.117628-1-stefano.manni@gmail.com/
> 
> Stefano Manni (2):
>   iio: adc: ad799x: add reference voltage capability to chip_info
>   iio: adc: ad799x: add reference voltage to ad7994
> 
>  drivers/iio/adc/ad799x.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>


