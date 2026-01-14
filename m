Return-Path: <linux-iio+bounces-27791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DBD20411
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 17:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F2763088DF2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ADB3A4AD7;
	Wed, 14 Jan 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bot3ecRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C13A4AC4
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408741; cv=none; b=ZA5JaR3vMwdUBhZhfqxVWf7Pm+WRx3uvEwI3JF084xReoA6f4KYT40Pc19W7ZWAsuFdcDnpF1p17nUwoZs1Z/tZN4A4YwEAxV8W8JtRY8YV/4xQwycarVr9TjE3uUBWXuizVmoZwYGXKNgH5wHFYArhxOX63lzZz+GmLSs2sqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408741; c=relaxed/simple;
	bh=JCUV58cUqQKhCjdeo/XygWeSJIfKra0j28AlW6+loGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAbEl1yc/LL5SZ4DYALT6Whu/dPo9xeGU+fPeBTfT3FjsLW3hsDJwGQqnx9ZjfyHwY6OB1M5k3P2Khl8D+Y+NEQVpcdUnbBxkdIbQIpXLQLDXBAaOqJUG1T9anU/tfCsMLTFMsuOPj+zMZpiQ60BMAnJWxSpZi37DIxrHxBQmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bot3ecRr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc3056afso21885f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768408736; x=1769013536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kz9SH3CkZz+PQQkAjq5SbvfDuE757gp5ylXm52bn0UQ=;
        b=bot3ecRr/tikhJxHe8k6PPUFR7TOxUap1cxNxaivX//Veeh/pEXVRyINzg+OTZ66xy
         mKUIYsCRFL3qC1RSALTBCw37Umva0hjBcg3rEPlCLr3qEDXp/OuUvM5UJpNq7SnpizL2
         l39I8wizkYhNKTbTLcaGfBUXhpdJXh+b1+LWt1Pmtly75Eg6k3Hwkox35YroZzY25esj
         7Zqs6NduJZTHABCDK5Gi6hiqOY6Wx8cUAaEwdVcGroRX8iFO3Ao6Gpms0Zj+zfnkDJQb
         UbvXodfD8kC2p0C45qGsn0YaXJjM46UFk9iJq96jqJ6vrhXVs1XOrvmRUk8+xhek4hzO
         e5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408736; x=1769013536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz9SH3CkZz+PQQkAjq5SbvfDuE757gp5ylXm52bn0UQ=;
        b=MCN6wip/ABoNep3SToUi3MQB6LQcgQ2+Fq8pndmS0F2Wr8GX6NqOXbpxyAKABRsG95
         2K3RCwUZCdlLlm4W5YbHKKKU2Ip9IWKHd0Rg6EeIp/xieGEDsguam0kfbXYOoU7na9PE
         IzpTl09ch9wUxDPA9UsdnK8tO22WLY0LBLrT668OZxLP6HJARhK0IN386VeiUgtZf9i2
         57Zxto75OlvTTUOB7cAmYHauVs9ImqQ/tcR1uLFwo65wairKLjBlJsWmKX1FpRuliZwD
         T1LV2plwdLf044UcTagUFd0GFO61dZIxPU3LpgEIlODgsOHpPSa0mQULMdqvwPWac+MR
         +w4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVugrYJenenZ7lsZWclBbClF1KYO4JzqvIoFPEj4DR4cUzZL369jpNXhJZmjAr4G/EGJ6P+Z3dro0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRXHUF3p2f1UVFEFOoa3xegd0rSmIuT4U5AIJZncsbmjsXgqQ
	4O1aUXGGDkWpiweUQi5CLGBNTVqr/fdEkJ2JugMb/gVq3Eb1I6mfnHR0sJXfoGMX/74=
X-Gm-Gg: AY/fxX4u5OtyrionUCFI704U7HJ6EOJLTED3CMOUKLvel6nOMiRpqeHRebp0LD8sv3x
	CfXiIYqA7H5XaHZ/H8P4HQnoN7wt+o6g31jJ9sxA2OVXBkv8YGGHvE0gKRq/9VCgcEXthhRzuMo
	P4XUi8Gt6KI/fWSqJ3rp5Qimaw44KEIGebrmOiIDxIXhOylrAzfKZJdtq+2nQmOgfnraLjickpj
	iRVVg7wZ1smm4PrVfSG2l4QrSHbGbX2kJyzKB/kAbl1pSD4IOJC7zt/m6SHlXq1UktkuC4jQf+G
	c12IFOKwNSA/FbPhZ23lJdiZFiJC4ZEDbDenQSZj3g6e2x7gKSbS9ZbkKsowqHDqU27vSZafRai
	EfKlg/w57MD50hsL+ClZyARSsnPAJPlhq/kOOQqraCGDoSkBx2qkNwIE4+N+warXggvgzPLMcJC
	gsaHEe3HxO/mBFYBeVKzQEjZoEmNLDeo2vVF5Ltp8+S3qwPL8=
X-Received: by 2002:a05:6000:616:b0:432:c37c:d83a with SMTP id ffacd0b85a97d-4342c4ffd94mr3862827f8f.15.1768408735959;
        Wed, 14 Jan 2026 08:38:55 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm207556f8f.29.2026.01.14.08.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 08:38:55 -0800 (PST)
Message-ID: <19dbdd5d-42d8-4ce6-8d8e-f91251348780@linaro.org>
Date: Wed, 14 Jan 2026 17:38:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] counter: Add STM based counter
To: Frank Li <Frank.li@nxp.com>
Cc: wbg@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 s32@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
 <20260113165220.1599038-4-daniel.lezcano@linaro.org>
 <aWaIXRLxGBh0bjuQ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aWaIXRLxGBh0bjuQ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 19:01, Frank Li wrote:
> On Tue, Jan 13, 2026 at 05:52:20PM +0100, Daniel Lezcano wrote:
>> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
>> three Cortex-M7 cores, along with a large number of timers and
>> counters. These hardware blocks can be used as clocksources or
>> clockevents, or as timestamp counters shared across the various
>> subsystems running alongside the Linux kernel, such as firmware
>> components. Their actual usage depends on the overall platform
>> software design.
>>
>> In a Linux-based system, the kernel controls the counter, which is a
>> read-only shared resource for the other subsystems. One of its primary
>> purposes is to act as a common timestamp source for messages or
>> traces, allowing correlation of events occurring in different
>> operating system contexts.
>>
>> These changes introduce a basic counter driver that can start, stop,
>> and reset the counter. It also handles overflow accounting and
>> configures the prescaler value.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +static int nxp_stm_cnt_count_read(struct counter_device *dev,
>> +				  struct counter_count *count, u64 *val)
>> +{
>> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
>> +	u32 w1, w2, cnt;
>> +
>> +	do {
>> +		w1 = atomic_read(&stm_cnt->nr_wraps);
>> +		cnt = nxp_stm_cnt_get_counter(stm_cnt);
>> +		w2 = atomic_read(&stm_cnt->nr_wraps);
>> +	} while (w1 != w2);
> 
> Still have problem. Does hardware have overflow flags? This way is just
> work for hardware overflow

No, there is no overflow flag. Just a comparator.

> CPU1
> 
> 	w1  = 0
>          count = 0xffff,ffff
> 	w2 = 0
> 
> 
> when count wrap to 0, triger irq, but irq handle have latency at CPU0,
> CPU0 have not chance to sevice irq. you can add printk at irq sevice to
> create corner case.
> 
> So CPU1 get
> 
> 	w1= 0
> 	count = 0
> 	w2=0
> 
> so counter still suddently change to 0.

Ok, so I think I'll stick to the initial implementation and just give 
the counter number instead of trying to do fancy things.


[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

