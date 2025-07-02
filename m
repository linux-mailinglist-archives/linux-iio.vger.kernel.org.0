Return-Path: <linux-iio+bounces-21248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190CAF5C48
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381FF3B507B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5A30E836;
	Wed,  2 Jul 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rpglmKEv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58830B9AC
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468842; cv=none; b=XUI/DWtTkzyYiJBlJyOn2NVQODr5+skOIVuGQoLTnxA+2kEqbNqcq4P91sDAu0D1GZtP+Xr/dhBFJBw1f2vSvGpMOHXW4FLSk6je3qPRBcEeHY7Mmz5+qYXQLq2P0u15UVHdeme0CTRUgX7rrisaFWmBeVe7DVCubVKYFiW7r+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468842; c=relaxed/simple;
	bh=cn2NRI5mu8mp2JvptDQmdNR3iEYDCKiW6RwP36IdYcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRgdVd/AXAeTQUQT07LcDnHhdlECfoEQ2BmUCj6N4XHiKLWQTXHqUWmLN9F5ukylfwOICLQ+1srdRsaojo5stbtN1/NkIg3NNESWyzN+i0Is5e6AxOZn88HCXimQFkVazJLCwiRIJlSsKpfoUuyIH4B+MrRDidrMQ05NjaEoVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rpglmKEv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6118c1775dbso2082552eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751468840; x=1752073640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+yF8Byfsy0CuO73SgfsROHb/6ylMyJG4365Xzkg/tU=;
        b=rpglmKEvds1+pdW7sRoDilSXNV5TzQif0EQwoG8XN2LeqUU2czx1bgjNhLhrW4lDYo
         eP+ZKGkcTeq06R/knz5JOXuOfAH6J4HzfFpwDV1OygWgLfshsYK5zD+HoaZahX+vF1qC
         BkgyYnKmlyUNlwOle0bSVvcKOW5CobavEyL0Pb4ElGjUCGVdWp+e8HO8ZMZCjiSFnT17
         OBrF1tOZyLob92vmiYSDTZP9ZYqwmuwuEzbZ7kuylC9LSXXSuxNJXnHoKGzo4JQXFAsi
         O1ZOI2CU91ZqVDCs0Iecuic4KsUe6Duv4c7xidaTRd08/dsNKTg31q3DRM9uv21BAswI
         ZqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468840; x=1752073640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+yF8Byfsy0CuO73SgfsROHb/6ylMyJG4365Xzkg/tU=;
        b=LydBJw4CL6Uvt9oJIv0rkVIn1nef02fEvpD0q/OG5huaw110Rj7fBx5/pnxSsVbxYc
         Exr+WINh3jOQtPGc6dMhY9rimi3kBHshXYR2mYhC5goAZ/JiGCwfAR7F1B0me1EpIL5S
         yJ5Y25vjVniwrKUVR40kBci0f6tYhumWkn7EDAPy0gACSV53iRkJAZ+t1q5gTeAW7z0f
         ANGBxLzWUdW6KUAHkBeT1v8UlH5QNmlh1iEU9Q+pLwdmgWHtsDNmmTOVKKuCP5lctwVD
         v4v+su58IBCaSC07GzQ2oqymQ+RKgPcH7/SIosHY4SGVzpurzCQSYLrPwG4zJUcDwHfd
         8zfA==
X-Forwarded-Encrypted: i=1; AJvYcCWHd37wT1KkAAsRs1MkmJSALqudI5FQZg1OaywL8fi+5+S9+Umw1ThfPsC1j2iFOhJy2zYMMVLP7M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytyxyCe77r2RrUUS+LVD1TG/69Dhjlj1ChG+NblSZoJ/li1IJu
	+4cTd4TIftTjf3wtynl4sGMJdKLXKxh0RoB8DHahS74cTEY20jf2e6MWxmTTJY4/MJ4=
X-Gm-Gg: ASbGnctm+tMvJhFOQyfEqLzAnQpSWCaUEt9tw2IN4oV/EdIBQIaDRJ5H128m31TGvAU
	46cSq4niENwJaZxLAPKo+bRBn+nWHRhmCYYGkB44QfRJqYWd+aAzuk3dWRU9Xi9iS76GGK2+q5p
	rDPjmtm+VdbvEKah6Fsj//jDpHbTJ6cQuXkANVYZuPt/wGn0jx0DSA+3Ww3I5HT77mlGtP5rO3x
	rTgXd6VPQOyO5F6WgoLEI1ddm2WXk5XyK1qq4Nu3Iq6X3nGBvkeYYfpko4aJOnvqc8OZCoOyCT8
	bJWzNdd6AkB0VjTJof7fyvZ7UoEJdVoAdc5o0xB9AIuaoDvSSJNhWCMm+WdpWNgECTA3OxbN7YA
	xLHzfjRvh/s4k8OPJzKzd1IiTHTXssLPBA8xeuhk=
X-Google-Smtp-Source: AGHT+IE1PW5FUH+qwlJtTOdD0wGyWz6EDOBzlYeJCn84Z90rIwVxi1VgT+rOkeUbBg33/zG427zvaQ==
X-Received: by 2002:a05:6820:1994:b0:611:9a4d:fc44 with SMTP id 006d021491bc7-61201244fcfmr2268633eaf.3.1751468839839;
        Wed, 02 Jul 2025 08:07:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474da2sm1700798eaf.6.2025.07.02.08.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:07:18 -0700 (PDT)
Message-ID: <3778ad13-3b62-4f68-946d-b861b0df4272@baylibre.com>
Date: Wed, 2 Jul 2025 10:07:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Robert Budai <robert.budai@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
 <aGVIBVsFPcVw3lN6@smile.fi.intel.com> <aGVJPRmn1-HUBb40@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aGVJPRmn1-HUBb40@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 9:59 AM, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 05:53:57PM +0300, Andy Shevchenko wrote:
>> On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:
>>> Rework the clock rate range test to test if sync_mode_data != NULL
>>> instead of testing if the for loop index variable. This makes it easier
>>> for static analyzers to see that we aren't using an uninitialized
>>> sync_mode_data [1].
>>
>> But at the same time it makes it not to be the usual pattern.,,
> 
> Reading the static analyser output I think the first hunk is only what we need,
> but this is still false positive and it's problem of that static
> analyser. Have you filed a bug there? (My point is that modifying the code for
> the advantage of false positives of some static analyser is wrong road to go
> in my opinion.)
> 

I agree that we shouldn't fix this _only_ to make the static analyzer
happy. But I had to think quite a bit harder to see that the existing
code was correct compared to what I have proposed here.

But if this is a common pattern that I just haven't learned to identify
at a glance yet and everybody else can easily see that the existing code
is correct, then perhaps it isn't worth the change.


