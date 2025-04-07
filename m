Return-Path: <linux-iio+bounces-17718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEFA7D3AB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA063AD00B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDD224890;
	Mon,  7 Apr 2025 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSElE8Sh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4F224235;
	Mon,  7 Apr 2025 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005138; cv=none; b=oFRjmNpkE0Wlael/F3MyiPQ+62Obau0iCRrus5M+mh+ueSB58uf9V2Mq4AEELSxcYHnJ4MhYUxeuHw8Jc2qja2H7lx712HTtKfdlnCFPYZ7YpAXS7dED0n8DCuch98iAbaTXsbJ60YOL4+qV0ehhmwgyAndspG9Em5cbHCE3fKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005138; c=relaxed/simple;
	bh=jBaeYUzJAGugTJHPn0N6Y2WgGPRzJv8LCxUPcOYqkZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7C4rcUzAuVDstvLGawSL+DLbLzpvD5I4rCIqyDCybjHD1h9L1Jr6m4q7QhkuQSPyMzH3zAe3BY2zF+MPlVo1BULc9+5tMtWD8rnGLZRUsIZ8kDSIocDTyqjzQ83uTe2gEYKQFJZRDf4BGuN9mTpnNko9SyDOtS3stKuLPt3GiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSElE8Sh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b166fa41bso4369190e87.0;
        Sun, 06 Apr 2025 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744005135; x=1744609935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1x9OzLiUk0YHaHOhzgSUQSq/4r9AGAfSiHxrDKxb61s=;
        b=VSElE8ShoXyvb9X2GtO+rKG3JQ8P45VtKPW8GSmwZ3Zl8aOc1020dIEh87y48x7qFv
         um8baY6soJy+CdKkXQUnUH+DL57sTiC/EN+S4C7WFI/4n/8kYqfTlhMUyuA/Hr+i2ymn
         16pSHD0CC63JU6AYxFsCuW9X2UyslU6dGctPJUG6jyJb7bciToyCqnsXYUZiEaoaI0FI
         h2iJxjOYLjXM+19+KqLt1XkGjJMEKeTFWkk7ebaVBgfQBZpLEqM2/fzSUnfPEZ3pK7me
         GBIs1XNUsou7Bz9Yw6zeMFnFDiYrk2HuRudLX/LQtrjAROkRX5BFDJcGGl2K+oImCjwo
         SWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005135; x=1744609935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1x9OzLiUk0YHaHOhzgSUQSq/4r9AGAfSiHxrDKxb61s=;
        b=NGTeX0QCjfP/UiOs9XU+/MgGcLUkkZoTjiEsLmRHdIrxjkxEo89Lp+dyeMRJU+hpFY
         lrphQXLrl5usnhqYTlIe6w4BR91bSTK6JQaQXh8UJE+K36Ps+Y4HQEm9pmd6fsMkgyEm
         TpSHQ67TzHtXyCxMyMfcQVZaXfwPoEXxDKoThx7h6Jo4BaOlYSOlsKd4UqAS9zb0NdSA
         vKnxnKMuLwiKAhzPnwlev4TK+ETRRAivg+63TswrkeypFrUBYIkcECu49YlilkMpIgdZ
         D3oiH3JvbYbmFKQ9eWGvC2/HiyJi9TEym/giyUtdgb1t8vcn0GIZlPMqeJoatSho2kKo
         8sug==
X-Forwarded-Encrypted: i=1; AJvYcCX4DkGo9fSwCpwGGxi+GWNyVWBjHLEGwUpexC9ahbW56AxVi0uh9KZv42bIw9ZvXcDgjqGOiHsQ0GVV@vger.kernel.org, AJvYcCXV4VGyK09QQqRVek1qzRHSICvrjv5zNyOHFBImFfrgqnsOLBKKP6Mlvq3ZwYxQ4GXEXXfrvE2SITIv@vger.kernel.org, AJvYcCXhV0s622/MBZUQmMtdIQISIWEoMydci3EP38zRDr6TAfOtfd509AOOnKWmVPsU8CRZRemHCY0/aro/DKdw@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKl0pFWVwDuCW/Af7v6i7srTSvxPhghLLFV+q/f0qhsEM4/Rq
	WRJQLv92pBWGBOxnBKfWULZRa2h44FsJ0eckLk4rUxp1osQBLWMc
X-Gm-Gg: ASbGncs3WTHNeM+W/H5u6jVqFBPPs2NhzyQbHc+7pziw4i1M5eZEREHLnKLTd/Nb3E+
	H+UjFOWZpoZ1AQijleqJahD2mVueVyigIGbOqRrn6iQYRvYepHt9T+HpnrqloHd4YNRECLUfs8c
	SfDsOhQ/r4BwsOL0e7cUoQvEuutpAL2w0J8eZAwaMt4DOsG4tVv0tnKrM6zOsc9CMx3Muiuex44
	5GaP8t4+L+rHQ7Q0QDEHh3Qhq4Kma/0f4jZIxpETpzwfdOSWejqDO1iu6vJCwrJVKWlAvNzhQXP
	5S/4HouVnB7tOJhactmk3WIysVDBtWnsMtUkwN+uOKf0WrPGFAeJya+88s20mhgoVyBLRSQ3tAG
	kf2zQcLCujMq5MIzY/aB/iMG2aw==
X-Google-Smtp-Source: AGHT+IGnaYMdNKDkJ9NFjy01KX8Te8EQ1pIMZ50jtMW/2GYwNw8hqmck+TBwlME8jZTEY4rV0FFhYw==
X-Received: by 2002:a05:6512:138f:b0:54b:117c:a06e with SMTP id 2adb3069b0e04-54c2335e5ecmr2960739e87.55.1744005134439;
        Sun, 06 Apr 2025 22:52:14 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314b87fsm14683621fa.57.2025.04.06.22.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 22:52:13 -0700 (PDT)
Message-ID: <ecb2844c-feb5-47d4-b4db-12171380a9cb@gmail.com>
Date: Mon, 7 Apr 2025 08:52:12 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
To: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
 arthur.becker@sentec.com, ivan.orlov0322@gmail.com
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei> <Z_I-qwzUrTNz1DZp@mail.your-server.de>
 <20250406120825.41b2575c@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250406120825.41b2575c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/04/2025 14:08, Jonathan Cameron wrote:
> On Sun, 6 Apr 2025 10:43:23 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
>> Hi Jonathan,
>>
>> I need to pick up the meaning of scale once again for clarification.
>>
>> Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. Mär 11:50:
>>> On Sun, 16 Mar 2025 12:31:30 +0100
>>> Andreas Klinger <ak@it-klinger.de> wrote:
>>>    
>>>> +static int veml6046x00_get_scale(struct veml6046x00_data *data,
>>>> +				 int *val, int *val2)
>>>
>>> How is this related to integration time?  I'd normally expect
>>> to see that read in here somewhere as well as doubling integration
>>> time tends to double scale.
>>
>> In the documentation file "sysfs-bus-iio" it says:
>> "
>> What:           /sys/.../iio:deviceX/in_illuminanceY_raw
>> [...]
>> Description:
>>                  Illuminance measurement, units after application of scale
>>                                  and offset are lux.
>> "
>>
>> This means that the scale should be the real factor and not the gain multiplied
>> by photodiode size (PDDIV) as i implemented it so far.
>>
>> This means also that doubling integration time should halve the scale. The
>> higher raw value should lead to the same lux value.
> 
> Sounds correct.

I was CC'd due to the GTS (gain-time-scale)-helpers. The above is the 
beef of those helpers - which, attempt to aid drivers to convert the 
impact of the hardware gain + integration time into a single scale 
value. This approach has some caveats, but the goal is to fulfill the 
expectations of those user-space apps which expect only scale to change 
the gain, while also need to have the integration time controllable (for 
example to reduce the measurement time for one reason or another).

Problem is that, especially when there are multiple channels with 
separate gain control but common integration time, there will be some 
situations where the integration time change _will_ cause changes to 
"total gain (E.g. scale)" too. There may also be cases where some scale 
values can be met only with certain integration times, or where a scale 
for a channel can't be met maintaining the scale for other channels etc.

All in all, I am not sure if the 'unchangeable hardware gain' approach 
makes things as simple as possible - but as long as we want to have it, 
the GTS helpers may be of use :) There are couple of drivers using them 
- feel free to take a look. "git grep gts_ drivers/iio/light/" should 
point you the current users.

>> The documentation of the sensor (veml6046x00.pdf) provides us the calculation
>> between raw green values and lux.
>> Wouldn't it be better to give the user the real factor to be able to get lux?
> 
> Absolutely.  That's the expectation if we are providing illuminance_raw and
> illuminance_scale.
> 
>>
>> The fact that only the green channel can be used for calculation could be
>> documented in the driver.
> 
> Ah. One of these devices.  Hmm. Why do people pretend they can get from
> Green to illuminance.  That has to assume 'white light'.
> I get grumpy about this, but if it is the best we can do I guess we have
> to live with it (I might not be consistent on this).
> 
>>
>> Then i found the "in_illuminance_hardwaregain" property. It seems that this is
>> exactly what the combination of gain and PDDIV is used for.
>>
>> So what is the scale at the moment could become the hardwaregain and the scale
>> the factor from raw value to lux.
> 
> If it is useful to export it separately that works, however it's not typically
> the control attribute - those tend to be read only because, without access to
> datasheets simple software has no idea how to control them.
> 
> The alternative is the GTS helpers that attempt to figure out the best
> way to meet the user requirements in setting the integration time and amplifier
> gain when a scale is requested.
> 
> +CC Matti who is the expert on those.

Seems it doesn't take much to be an expert XD

I have understood that the simplest way to go is to always use the 
maximum integration time which provides the required scale. This should 
probably result the most accurate readings. If users for some reason 
want to explicitly set a shorter time, then the GTS helpers might be useful.

>> To sum up the suggested interface under /sys/bus/iio/devices/iio\:deviceX would
>> be something like:
>>
>> in_illuminance_hardwaregain --> set and get gain and PDDIV on the sensor
> 
> This is usually the read only one as it reflects things that aren't
> easy for a userspace program / user to tune.  They typically want to control
> integration time because it reflects noise level and scale because they want
> to avoid saturation etc and because we need it to get to the actual value
> in lux.
> 
>>
>> integration_time            --> set and get integration time on the sensor
> driving these directly is fine.
>>
>> integration_time_available  --> show available integration time values
>>
>> scale                       --> (only) get real calculation value, taken from
>>                                  sensor documenation, e.g. 1.3440
> This should remain a main control attribute.
>>
>> scale_available             --> not existing anymore
> This gets tricky but the GTS helpers will calculate it for you I think.

The GTS helpers can (or, at least should be able to) calculate the 
available_scales. AFAIR they offer two approaches for this. First one is 
listing _all_ scales which can be achieved by changing both the 
integration time and the hardware gain. The second one lists only the 
scales which can be set with the currently selected integration time.

I think that all of the current GTS users use this first approach of 
listing all the values, so the 'per time tables' - approach is not very 
thoroughly tested. Please, let me know if you hit to any hiccups.

Yours,
	-- Matti

