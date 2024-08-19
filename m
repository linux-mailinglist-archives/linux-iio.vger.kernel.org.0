Return-Path: <linux-iio+bounces-8621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E29574F8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85031C23E9F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35F1DF66D;
	Mon, 19 Aug 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E18kVlsu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04E1DD38D
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097046; cv=none; b=HLuDuy2KKO/9dPXs04ADtwvENC1MVm39ljepHty7PEESoAKLCDdMvCOSRJBjFYKivOgrNYMlEJaeawYb+hfsFZ7td52YLNrY8VfboAJbYUmqMWGKzJn/vH9kYBcSz2BiEDq1WMOD4uVTXM1QFTGZG/+BGIUgXnBPJA8KTvTbyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097046; c=relaxed/simple;
	bh=jO29POK3z1BLcm8HkuO4Cegavmvack2+hlF/5WU8GyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRqI5kLOXbAAu+7q/ByQedl/jtz2NF2I484TOPoJTe+LY6LUfAmPd68w4Bj5I9H30a/rF6GO8lzuv3DaFaNS/cwKll4E1VM11kTPVvOKS/yT3sBdY+nI6N4hlE3LhnN1f5+I7UvgRy2uhOzzT0V/+nlxJ1zqUp/gt1bO2EGKif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E18kVlsu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db1eb76702so3438340b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724097043; x=1724701843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqNKkZ9AVI01Zp+n7dR1XvaLaD7tPIHVV7B+MTLeBAk=;
        b=E18kVlsu68n83V4oKQO8Bnzmr3KPy/JftPTi0ffB1y9kSsPVVGuZxBRAk6pn76ksfl
         D7cll/PwJYj+IU+mZJWk66N5yZzJUTM35nF1UjPXzD93KykJjcImAcLUc0IvELiGiDpZ
         6L0JhdPc0MdBeOUR3i2Pk5dH/wz2zUigJtJVmGn2TigOweSx3771bbd6Eji5GFwF+lPC
         WcFYbnpDn9IpFHh3S9Yl7C5EwmOczSnLiDkF88ntQylH7t+PllLRTL4t/Q+PG0MLjx8f
         K7Pl+c60afKryQy8Pr2mP6cYElhqYcimrHUraVTyCtpRxKGuIx2zdyvyzI+W+TgIaVy6
         8AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097043; x=1724701843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqNKkZ9AVI01Zp+n7dR1XvaLaD7tPIHVV7B+MTLeBAk=;
        b=ng6SYzoC6vhQwvEIo1hU8SpwsKKTBXhvdUBPFfBsHBrZE1uf8PMZsvVCaOWBuRa77m
         6oZK4a/gfsfB8y4tudCDOmnzyrGCOvM0wAkJ6JHxzFA29d4zWv5uvk6iMo6RKsDyEKog
         q+YMCb4BTGlu+n0mDeP5Qpp3LZnF6pJl6b96ZzeHDsBtGAc3j795XjAYIZAYlF0D+ly7
         tjJTWjMPsJVFiGO2IXun5emilxg7BlDjOfOxzYPJnxZtMn6JXQE31pf0wK2A/pM857v1
         XEEEd1CiE/mUs9kMVpBDQFWha9kykooOWDPe9uVym63yq8VMZFE/69xKCR0uNL7iu7ao
         dsqA==
X-Gm-Message-State: AOJu0Yx2A5E5UsrGP0BTDln6LAdDyRH45ptlzqJBByGQqCkRYA8rNEwe
	bw2Ihh5UYBI3w7b+Wy8//ecoK2cVIKMnOaKkSK5SxnhFO5KQ8II1MPw6ZiwGld0=
X-Google-Smtp-Source: AGHT+IH3NZLD6naQAd620byBrGpPpV42gGrLR816WbcxoFuLqgsRjryfMf5ic8YQKRyhO2VYJrpXow==
X-Received: by 2002:a05:6870:7f0c:b0:269:2708:aff6 with SMTP id 586e51a60fabf-2701c37eb7emr14217799fac.16.1724097043320;
        Mon, 19 Aug 2024 12:50:43 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2702589f29bsm2487392fac.19.2024.08.19.12.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:50:42 -0700 (PDT)
Message-ID: <386eec54-025a-460e-8ad0-d1ae87ab7c85@baylibre.com>
Date: Mon, 19 Aug 2024 14:50:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: ABI: audit calibscal and calibbias attributes
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
 <20240817155203.4525f9f3@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240817155203.4525f9f3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/24 9:52 AM, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 12:22:09 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> While preparing to add some new variants of the calib{scale,bias} and
>> calib{scale,bias}_available attributes, we noticed that quite a few
>> of the existing attributes were not documented.
> Thanks for tidying these up.
> 
> There are some scripts about (I think Mauro Carvalho Chehab wrote them) that
> scan sysfs on a particular machine and report missing docs, but we've
> never put in place anything that looks at the code to figure them out.

Thanks for the tip. Currently, 

	./scripts/get_abi.pl undefined --search-string=iio

doesn't catch anything because we have documented the directory

	What: /sys/bus/iio/devices/iio:deviceX

which gets translated to the regex

	/sys/.*/iio\:device.*

which matches everything under the iio:device directory.

Maybe `[XYZ]` should get converted to `[^/]*` instead of `.*`?

> 
> Gut feeling, too fiddly to maintain such a script for constructed attributes
> my maybe could be done for const ones with the standard macros
> (so pretty much nothing in IIO :)
> 
> Applied,
> 
> Jonathan
> 
> 
>>
>> ---
>> David Lechner (4):
>>       iio: ABI: document calibscale_available attributes
>>       iio: ABI: sort calibscale attributes
>>       iio: ABI: add missing calibscale attributes
>>       iio: ABI: add missing calibbias attributes
>>
>>  Documentation/ABI/testing/sysfs-bus-iio | 64 ++++++++++++++++++++++++++-------
>>  1 file changed, 51 insertions(+), 13 deletions(-)
>> ---
>> base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
>> change-id: 20240815-iio-abi-calib-audit-fcc21b1c6892
> 


