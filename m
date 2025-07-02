Return-Path: <linux-iio+bounces-21247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057CAF5C1E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEEA1BC2842
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667F285C8B;
	Wed,  2 Jul 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ttuknxK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048851E5B6D
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468667; cv=none; b=KyQSjTLNr+D7QAjl8ubNWFm/b/ZbtxTdPMnoJzqkEMQ4Nq1F2TWRcX52asJqIjKR8GsJr4JfpQAgICjCHpL2GkVMIVOkiH09DJvLz22M95GjgGiDGPfSryXLsd/H5I+Vq0OVrV7yaPh3bsl4531barKb3aW57z6QwEF52T7WY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468667; c=relaxed/simple;
	bh=+1Y6ZNOjjbezKMVrD98UVg4jqhd2A4KkLJqkx9x2Baw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx77RYDxfxbOAM/+oe4R0OI9Pf3TwWriu6UtEaTX4B/5KfZPGzrWJq2BtrTY7gFzeJN+v2ifUZUJ5TbJJB8mhJmEV3A9oj0RkJoxT1fP27eA3fXyRiZEMT/obAZfY9+RBsVtQYb/rFoW+eZ8SFKEtpMP7tBx5qN8NAStRse+z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ttuknxK9; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ea2fee5471so5937fac.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751468665; x=1752073465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpSkZNRj+KNJmdYaS5yXC0vQwBvPJpgN8lcF/7GiAl8=;
        b=ttuknxK98Vt3loy6Us3Hs02Rl0a4FcCwv8We5fMr0+10SedIQrpSr1JkDw3BUvLhCQ
         vCrTsZ0APQJAIGU8vE14VL/2rx923USjgEFaiTzWx+icUnWuNr/4I8/Kd/p+F7evkmEj
         K0dfjGMAQ35tYZV22CK9urHHG87q0Zvxj7VJZScJ461DF+B1QMdjhzoJEW4lyNbkkARd
         p9QL2sctCB/QX2bw6f+uV5WuOdesQJVXxHOaE0eGU5R1uybr5kgugB5NDKYr2dEcHQTW
         hWm5rxIHjX+r60CkFduv6q36EcNObTf2Gwc1b83/NVlCo7RPQArLvta8wLFh4VkrEuZ6
         KQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468665; x=1752073465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpSkZNRj+KNJmdYaS5yXC0vQwBvPJpgN8lcF/7GiAl8=;
        b=DH2opXPTWIfii0W3+0X1G4vjKbD3FWLFi+MirLh8speew7YLEVs/V53GBvkFlwyW3X
         VDC5VMwPHMX/QHxDQoPh91WC5zPCRmjFY3cI4VCnaE9eMElFt5xGYHjIy7EvsHtZb8se
         LYMBClVA/L6uc0IKzMKpH0pbnocnzMC514ItfnYhrZ96TTRrltTk37M7Lv3CSynebrh0
         ChuQtZTiD70EoPglHw4FcpfW+Mlgk1yGDB147Es7sAUK55uHhhmFOiMWEHFK7UtyEIpD
         pohNRDl5mL5GzPzgGop3E9Ye5oaXGHvlmPCsi8gWJrgGqbqIxPwpJLWrGH7waFqN12ev
         Iq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa3s7Q6kfade4mfK6bgXlMlNSZb1HZwnAoeGhJ9mCnlMzFE3NnrJ43FXqcBi1qylOKZawFlDVNwBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvqmf5cAPg9/Oe/+Bova2s+ef6lDburdavCJlx5FjCUhAr8tf
	HDOVramPm/8hRxKH4it1aZQYt4GYtyLBc3q3pb5qbm2bht2b+T7ISmAyUsa52JljN80=
X-Gm-Gg: ASbGncu/we90jFdRjlSi9xLSVbXgMmLmR/5R11VnqPGwkv5K8Yz82iFmS4lSk3GXvI4
	XE7ueM0tlqh5Gj9bZxrRq6F/ri+m7HTzyjNTpxdYoLDQ1/gEEPYSmBNRmeXLKHxhj5BBwhGIb/m
	zza82rsZqgRfhsUgC2NHidJMz7BbLC/GWBFvpEBn0mq+uqS0sJPB+xUqtTuoPUSPGl2plzmFNYJ
	5Qa++6NR178CMl+IgP/WtSNN3d+BCIwBpNkhmnhgdbNHWWuM4FZXkhKNscWSCNK8llMEMbTJMK/
	ek+cZmpBV2GON1yLfts4aJjlBVOmcTy7+/8o93HQ5B65zmCXaGa1dAXfM/ql2vra+y/4F7P4Q9e
	VmqAJq/S04PUQzd7WHXl7HgWQoCpBsE0HErL9n5j8BbIqRHgIcA==
X-Google-Smtp-Source: AGHT+IFce9C5ghIoSx3a2rGe/4a+oNnev+bEZ9sPLErCFoyKvHyn2elLjaO6JeBMAX7wGFfiUCYBRw==
X-Received: by 2002:a05:6871:796:b0:2d4:dc79:b92 with SMTP id 586e51a60fabf-2f6472a600cmr2079285fac.6.1751468664770;
        Wed, 02 Jul 2025 08:04:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb124960sm2543365a34.66.2025.07.02.08.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:04:24 -0700 (PDT)
Message-ID: <e474db53-1b52-48b0-9253-2f62a3861bb4@baylibre.com>
Date: Wed, 2 Jul 2025 10:04:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Akshay Bansod <akbansd@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702135855.59955-1-akbansd@gmail.com>
 <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
 <aGVIcBLgXZj_YR7B@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aGVIcBLgXZj_YR7B@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 9:55 AM, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 09:16:51AM -0500, David Lechner wrote:
>> On 7/2/25 8:58 AM, Akshay Bansod wrote:
>>> Update the sysfs interface for sampling frequency and scale attributes.
>>> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
>>> and recommended for use in sysfs.
> 
> ...
> 
>>> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
>>>  				 odr_table->odr_avl[i].milli_hz / 1000,
>>>  				 odr_table->odr_avl[i].milli_hz % 1000);
>>
>> Let's keep checkpatch happy and change the indent of the wrapped lines to
>> line up with ( since the ( moved.
> 
> While I see the point, wouldn't be better to have 1000 replaced with MILLI
> at the same time?
> 

For anything with 3 zeros, I don't consider MILLI better (or worse).
Science shows that the average human can easily see 3 or 4 things
without having to count them [1]. So it is only when we start getting
more 0s than that is when I think we should be picky about using macros
instead.

And in this particular case, we are converting milli to micro so `1000`
should be replaced by `(MICRO / MILLI)` if we are going to do that.

[1]: https://www.scientificamerican.com/article/your-brain-finds-it-easy-to-size-up-four-objects-but-not-five-heres-why/

