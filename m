Return-Path: <linux-iio+bounces-23720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1709FB443A4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7CA188B00C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56012DD60E;
	Thu,  4 Sep 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgCxiFYj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906522B5A5
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004778; cv=none; b=iMBjIGCxKkkSvUpk8LZnj490DYz5CP6KNo89gm9RwgnqQrxvG8E4D9uWOYUil2sqo+ot3jSIa/QH1qNP+uLdOK7SshQK9O/hiTVq4wYH5t8u6/OZ9hrmO4PiOhwFhtMxYULkiGCBl6F5NJ6csYZesg5VMYrAFtgfPp6KYErgKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004778; c=relaxed/simple;
	bh=7fvOz14syBHStBNZy4sYRSSBrNYheDkpZc1heoV3si8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amtxxCzR1NDla5rHwKEKJhB3ZMxL9AxbxlH6NYII4ql5emyG9zQ4x41QEO2MClX7OWrWv/9glBRgNoy6pn/XAB4iiP4jQ2J/zMs1THZfdB/l4ggRHPzgopZOo6CeImlqK8sacoo2DCiyuDYk5i2t2TsAoSVq3Lx+OghllTbHMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgCxiFYj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd16c484dso6379725e9.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757004775; x=1757609575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFh89iR809PVR/b4+ILAvd+FMJiKpRfITsgR1aQ1ciM=;
        b=fgCxiFYjvONXUxH8Fv4gWtI7BDc3qzsItZayOnkLbCWNz0bRUceFWIRlUB0j0b+CCP
         5/3qUH4o8HiPDFngtrez6Pubh1XTKk96vLJNMv9PNV7mK+axW/iJDwAhDUQXhfo+30ap
         Ntp/CRPHIuZgnc3xYw/l6/nYotOZjuLpcSVgeoT3dlgdj9xgqehvsT0/W1J1kMf0StRQ
         1N9MRJ2xUOrDrgARXTcRlYnQn8JBznw+qXOrPXX8tXGoVTjd68UTPoLJSoLniNpk6P4w
         Pb87SN2BNka5AF/SNem9VdXQy+wLqhTlO4C5OnvKZaqG31m9kDEoIBupqgUc6HoDq5/P
         BrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004775; x=1757609575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFh89iR809PVR/b4+ILAvd+FMJiKpRfITsgR1aQ1ciM=;
        b=gXApL/hogxsWi7ymqSo9dI85ouMsjQe/yYnejTreXSyP4AVrKrKuZZJAYx7RhL8cYd
         8yAqi+6CzoW0pziMUkLa+qHovHtdhOyVQfb5HhyHHBvfDe5FdZGzUuMy/D89yC1y0ncM
         8uKC7h1fW3OgdY7Vv+D7h8wB3+3d84ZHSPuOvOVWsVIV/MTmR8+nqLxtNwoj89aUIqQJ
         2ZfYOyBC90GxLj/RVoqYzLIzMTwvYG3KDCpK8bu2eC642GQVanIlAnnlauubu2caH+8X
         Hnk6g3p/s/6u1O3eHy1NeD+Fvy2eAfbEqUR/e12EFSWW/LbOx1UjruGzX+qOud53+nhr
         MwKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhOKPvSPwKG8TUdI7aA2x7h5CvBhn9Azic2WcWF1BrymY2YpfCaEFq7vcHdcuid/fj8FrV2kuIqdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWMBC2MEEVHYHNHZMx7fJu59oP+MJPwBVMxj3OsCrJAVoDgJj
	Mpv9T7uHpzuBcUu4imEjRW3vxJGr6jxb17/yPugzxyYvtyEz8NH3LwFklJfjnzDWHN8=
X-Gm-Gg: ASbGnctLVKyjkACw4RPkJthcjGlX68qwiaMpOFGqG/AiUxEs9JuuPLkO3Any4x7jMtf
	MDYXvySFIYSpAnrUAOIBHPsSJTZM+8kmh/rkaWQJ1MgSP48PS4x38rckC79yKnBIvAnVgHZOPII
	qwqHscyqv0hXx+YIDb4ss6n1gjBxyYvCQHefgJ/sctN9Tua/jCO7OUe7ZmumLQw/oTtIyFQQOrl
	pop2IX8gpzpqx9YLSLzv2TLdjhZvGqHtBstZqq8yZDQO119z4HjOcowaJfI0WyiuvJdADmeuZao
	pSaf7pOhsHNdp66VteCNEEf6tA/UPY9R7H54RaLqXyRHh6NR5n4Yx1DkxXlAJ+6IlQnMYF33Lcm
	iRI9761/Dl6PMVde85dlK32fnijqU9EHkqtoSYxKm329aRKHjmkbN0Gxx4HLdIwbVnSPtQmay/n
	MRyoL/p5AJD9N+QwafqZcSTak=
X-Google-Smtp-Source: AGHT+IF/3UAqS8oVgCQ/U/GWGmEsXBPfC2dj5lpBtR7xMDWEaxaLpTFZgIdSL6vjxf+WzDQruLwXDQ==
X-Received: by 2002:a05:600c:3baa:b0:45b:8b3e:9f7b with SMTP id 5b1f17b1804b1-45b8b3ea15cmr138645635e9.3.1757004774916;
        Thu, 04 Sep 2025 09:52:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9? ([2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm91433315e9.0.2025.09.04.09.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 09:52:54 -0700 (PDT)
Message-ID: <9d4e7851-a874-413b-974c-d499ed59f553@linaro.org>
Date: Thu, 4 Sep 2025 18:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
 <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
 <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 09:33, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 05:28:09PM +0200, Daniel Lezcano wrote:
>> On 03/09/2025 13:48, Andy Shevchenko wrote:
>>> On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:

[ ... ]

>>>> +	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),
>>>
>>> Why not readl_poll_timeout()?
>>>
>>>> +				NXP_SAR_ADC_WAIT_US,
>>>> +				NXP_SAR_ADC_CAL_TIMEOUT_US,
>>>> +				true, REG_ADC_MSR(base));
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>>> +	if (!(msr & REG_ADC_MSR_CALFAIL))
>>>> +		return 0;
>>>
>>> I would expect standard pattern — "errors first", but here either works.
>>
>> Does it mean this chunk of code can be preserved or do you prefer an error
>> block followed with a return 0 ?
> 
> Up to you. Only the question above (readl_poll_timeout() use) stays unanswered
> so far.

It is a typo, it should be readl_poll_timeout() as you suggested

[ ... ]


Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

