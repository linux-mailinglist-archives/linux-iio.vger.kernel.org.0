Return-Path: <linux-iio+bounces-25716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FAC23AB8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751FC4F3462
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A192FE567;
	Fri, 31 Oct 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrpmTPir"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543C2F260C
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897790; cv=none; b=rTzK/nmChWyj2r8VIW5tjZ443vIQNcHZHKx++xIiw57LYuZtThmsox48jsrOOXMAT2c1ZIus5Nmgycz8CorFeoElYSWK7+vRmrgKYQoUL9AyumzeMeuWLrrchrGqeigOJ+hymhPWATidW56qpWBbWvu4jPM/YoaLTurvD6zfays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897790; c=relaxed/simple;
	bh=rP/EAMI45WYJlvg0iRFxgh/OmWO0tg41yWxJgWgYAAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSJRRSK8bRLaSyQNSFFIXrHXR3HtO8Smf/tNbfhWO+IRvzATyPCNZ5IUbfsY/HizePeUFDcbpVALBkluU+62rmTHQ0ctUFgA0xOhzW98BVHeziYdwWqi718Px59Icedi8L963DDwW6bSb9PBWEToSrWNu+SEVc19+RmZho6rK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrpmTPir; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso15794105e9.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761897783; x=1762502583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuxiUkBLx8vKlnec9/5CywDzn8GdyQUbr0sVZo29GFE=;
        b=PrpmTPirpG7QvI3eiWvG2RVErrKFQJCllGhmqkOf4oIeeMGoi/eejISvRZO6cNHrnG
         j87SMro0V3O+zfgFdDaUXl3qqeyKIhAMX32ZQCF/gWwQdU5LO+d3Tg3gjLjblA4LldZ/
         FfDYx5DzE+XFX6Tuy4KDHp2W1JJF/wAOnBHBFAJR7ToPX8DQai0zILIe/I2Qmy9V7nTo
         gbMiceQOfxWZiKt3Pi74MSBEkfWrTcSYmpL1GDsSazZCpgKR7tOw6YyXYc+STRtydoQb
         DWOKytn/eVYM7Ur82NrKQ1ztIk4wcb2KywgUtMyxs9s3s8BiaXwqu3MhR06mc4Gme26d
         nH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897783; x=1762502583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuxiUkBLx8vKlnec9/5CywDzn8GdyQUbr0sVZo29GFE=;
        b=q6QtmmJS6VgutXQ/XoAcpyiy93vcxp4QUcf3kKXK37rAHIDxdo+Pm+aN5gHsJvIbIA
         QpY7ErvaUaxHnsdFoCzYVg8+DEf9Yu4l6jORAAgztDkE7Z6n9ObZmVkZ1ih96z93Z9WH
         SgtgFveLGhyzQvGc6hLkgtTnRx+Z5WEiJgSzKyOVka6iLIj4O/sukF/M8v65Tj75hPVN
         bU23yTWWzH6WVOgRx0LUwUAESaiU8derPULa/0BuB+8YUa8KOEoRvi5FpJVpslsdbIxW
         c1SSZeB9+n4O+yebdf5j6NF75pxSveN12nU5OsFb1HMa0jXAHNg0eZsGuJahQPCQccio
         wQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCPZLkeHqhrjxfZFVkoS9f8cb0sG/2oNqZpjyfg+ojByeqUE9lyaytq5SQGmjrCjg4aSeNIU+xABs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaAoERx3Z9SnVOHLGOT4Dwcm1k1yVsG1DiYotKSjlMKEn3K6i
	WTf8xiQIg+llZ4yC7caHg0DFLtSwWlcatfJVX2ST9pVzz9JbDFfJV2BrHajNCElu/hM=
X-Gm-Gg: ASbGncsUPw7XbMxHn4xTBOWiUxXC8DQ4l2R1CVdU0szzj31AlxgBBYDCUyeglPbU2YK
	ph54A2/1uD1yv6vx7jUhTTrKCD3V3Zay/3qC/BG/TVE+BSU9vmLl4swGEYEctwpNRjQh/6HSUE0
	mGsYpemCp4ZR1Y5/6/Ziox6C1noWGrEQXC7txJrHSRRinZIpk0gZHFh7hNJ3fYvqXVfbpY8rZcR
	3aOmSp8VTsY7HwfP0kRp4yZGM8hrV095y/cwJhHsvqo73hcU7oEs6jDVbw/LVHtiPYaBdkcv2yk
	1WUkhzx1dT6sYz2VuCBLUf37xsJ2Xj8JPY4xG+X9F1qb2h+GtPmp9Weg/+Wu46LSjC3GDflntg4
	wqjOJAXW8iX/K4PiBJvZmeP/9OU0Veu/jqEG9nDul1OGpJvOVNgmNFdqJVFSklt4SkQmOUAJtyo
	lzwP2ShRSsyEqq5zxC7re1SMMc1UN7Nfh66SUa+d2jUgIN4f904ekr8KlZE66w
X-Google-Smtp-Source: AGHT+IErZEMZ8RsUWbyCgbeb1Q5ZNzR29K+yKSMn2AYjlqALM0mnJriWuWEedLWtLw+5aAf7+4a+8A==
X-Received: by 2002:a05:600c:3149:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-477308e5d8amr25954095e9.34.1761897782651;
        Fri, 31 Oct 2025 01:03:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2b:468c:c228:91bf? ([2a05:6e02:1041:c10:2b:468c:c228:91bf])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429c114ca0csm2361827f8f.21.2025.10.31.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:03:02 -0700 (PDT)
Message-ID: <2316cd4e-737d-4596-b713-2f29928ab26c@linaro.org>
Date: Fri, 31 Oct 2025 09:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aQMvqHGN7r6babgw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 10:28, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
>> On 10/18/25 22:12, Andy Shevchenko wrote:
>>> On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
> 
> ...
> 
>>>> +#include <linux/circ_buf.h>
>>>
>>> Why not kfifo?
>>
>> I'm sorry but I don't get your comment.
>>
>> Do you mean why not use kfifo.h or use kfifo API and change all the code
>> using the circ_buf by the kfifo ?
> 
> Yes, I mean why use circ_buf API and not kfifo API.

Ok, thanks for the clarification.

At the first glance, the resulting code with the kfifo API would look 
nicer. However, on one side, the current code was largely tested and it 
is running on a production system, on the other side the IIO framework 
will evolve with the cyclic DMA support and this driver would be 
converted to it when ready.

I can convert to kfifo but if it is changed again for the new IIO cyclic 
DMA, I'm not sure it is worth the effort.


[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

