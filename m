Return-Path: <linux-iio+bounces-17294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F4A73750
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2939189FC73
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA3218EB4;
	Thu, 27 Mar 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HM/hzUZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89F217F31
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094079; cv=none; b=eYQs+CGaTUxjc7Y8OSFg8AfSSVtU/BvKiSxG5XHJP2u7fQLQlOoXPVy8iRkhAaeSiV9fvOh2EEpmj7a5a2yAPXOKTQ1dyFKrIKltyx2jflPjlAP2RHUjQFIszJ1P00A+0geMFOUl5ChPDmbjpc4lPk0sbPXNna91xtyWgojhlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094079; c=relaxed/simple;
	bh=aOfxn5mgE9VF/7lv2LBNAtzbuQYVXJk5r4Ndca/elB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAj0fyYCIZec+MvSN97q07EXGCtdvFQi6VkxCvyk438++A+zD3uJgniFn72MRbcQ2GpfgySYitgPirgLl2gu0IABkjZuTU9Bt9xLS27zIzRprDgSZs9l3LL9/83+oCa1lqQbkwDB+IkvgYTwrVZBiviDwC3Ou1xb395pmzAMx8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HM/hzUZF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so9687365e9.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1743094075; x=1743698875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0r5iu1FJ68bGA/0f6QmBB5qaVR7pLp/IQdv0KKrJY70=;
        b=HM/hzUZFRECqdW4TxTopHMTrG0Dsyj1uAJU7rSa9zfUidL/pjPFV/fxJkQrPmgDael
         41fF/LSyxdTuu2znQBKUehtTfM2SfhigvYTN+nIiNREEbQpP2k/V2LxnHy7Adb+0Oz9s
         PmgiWOfq9Y4s50ob/g7OVNox0BBS6/JyqfGxJka2xS9sZpbMz7Ome1ZmnKE0JHYKnYyA
         ike7mAYkKPGKZO7ofrG6wNztW2u7RbXWptUfzQUiUgoqSy/UUmrEUF+LfK/Bep2aHOKX
         6esfCHM/5LpuaqWkV7ur8qUfLnh+RLQDMmZtvHM5kjqFL9GZGNZIGarKORvdpWAcYvJD
         uigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094075; x=1743698875;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0r5iu1FJ68bGA/0f6QmBB5qaVR7pLp/IQdv0KKrJY70=;
        b=w4v8aTwWeicVvL1PBTeddfFIgrT1VNKigtSd45QSLif3B7RAfxL1btuSaAVqYLibTi
         d0y0nhYG9aSECqWoAUb5Lhdbj1mY04k6l/FCBmpTuYR24vGbHD8QSVTg0Kvz27tlBoch
         1bJMwAb8r1vaFIDAch0s9wJdJOwZw/PzrhUNOP1y57KPjfXJjt4pZFawHm1QBbYMfNeK
         uZpQj2D63QZXwACVtA/bhwhKbhyXpW8jDiub8+HO7vuvllrUdzHoOl/YZbcKKceGBv4S
         /QPVLnecNDf3DLhGtM5HTx9B/5NWfw0wPrmkCOqi6NwJyVprKiy3tcAdU1Y7xb8V5gbi
         7TdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKIqTEf6GFDZnGFD0AGfGQSd/4Uleyhk6kjbZ+OSsnluNocKtY7gegkUJqIa42obae9paOfzpB2rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQxNzBBtBvrEnYiOfqcrtnFx7hH4cYSX/C5LaUM6Kwg7RlGAx
	AeI9a/BWe876r1cYJtKTMvDs+7dICRKU+Cjxi7BTgBfH549NauAzKcXBofzQxxM=
X-Gm-Gg: ASbGncsiXEr1AoswRYt8J1VOPmuFubYl+TL+B6yDdFH1htJGSjiea7usbRCzL9pUcSN
	ICGAjNRWJuhpBvGsPiS32DL512as/eVlDMryuzeahjhKw+l/gytcdTTKIosVJtI3EZkv+M1Glwf
	qHUoddeSrvvof5676ytcdHWPRFm1nWfMSSn3wVDv8wVFI+5zCrfJiT/fRS+hdRiMp5a+8guYFCV
	offGUuk2hLfkVcjvxaKYW8je3d7KFfzMoMAsjD0/cx72oHL3z0v6S0Fo3eb/C8aMtym5hj7Yn3P
	j9W2VAtIm0nfUWtVqjhj7Nc3TxXNSfOo6nFZn2Bfb+SxhP4evVs8ug==
X-Google-Smtp-Source: AGHT+IEa4CUHB1B0pJWkADFnSE+HCVcC5iAPyJjsFaHAQo/pLP32apYf9UUzNa7vuVzz77Lcimbpkg==
X-Received: by 2002:a05:600c:1c9e:b0:43c:fc04:6d34 with SMTP id 5b1f17b1804b1-43d8ed9e52cmr4581185e9.20.1743094074830;
        Thu, 27 Mar 2025 09:47:54 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm50200f8f.3.2025.03.27.09.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:47:54 -0700 (PDT)
Message-ID: <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
Date: Thu, 27 Mar 2025 18:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
 <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei> <Z8k8lDxA53gUJa0n@google.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <Z8k8lDxA53gUJa0n@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Rafael,

On 06.03.2025 08:11, Dmitry Torokhov wrote:
> On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:
>> On Wed, 19 Feb 2025 14:45:07 +0200
>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>>> Hi, Daniel, Jonathan,
>>>
>>> On 15.02.2025 15:51, Claudiu Beznea wrote:
>>>> Hi, Greg,
>>>>
>>>> On 15.02.2025 15:25, Greg KH wrote:  
>>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:  
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>>>>> clocks are managed through PM domains. These PM domains, registered on
>>>>>> behalf of the clock controller driver, are configured with
>>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>>>>> also have power_on/power_off support implemented. After the device PM
>>>>>> domain is powered off any CPU accesses to these domains leads to system
>>>>>> aborts.
>>>>>>
>>>>>> During probe, devices are attached to the PM domain controlling their
>>>>>> clocks and power. Similarly, during removal, devices are detached from the
>>>>>> PM domain.
>>>>>>
>>>>>> The detachment call stack is as follows:
>>>>>>
>>>>>> device_driver_detach() ->
>>>>>>   device_release_driver_internal() ->
>>>>>>     __device_release_driver() ->
>>>>>>       device_remove() ->
>>>>>>         platform_remove() ->
>>>>>> 	  dev_pm_domain_detach()
>>>>>>
>>>>>> During driver unbind, after the device is detached from its PM domain,
>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>>>>> devres_release_all(). This function handles devres resource cleanup.
>>>>>>
>>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>>>>> cleanup process triggers the action or reset function for disabling runtime
>>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>>>>> following call stack of interest when called:
>>>>>>
>>>>>> pm_runtime_disable_action() ->
>>>>>>   pm_runtime_dont_use_autosuspend() ->
>>>>>>     __pm_runtime_use_autosuspend() ->
>>>>>>       update_autosuspend() ->
>>>>>>         rpm_idle()
>>>>>>
>>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>>>>> at the point it is called, the device is no longer part of a PM domain
>>>>>> (which manages clocks and power states). If the driver implements its own
>>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>>>>> driver - while also relying on the power domain subsystem for power
>>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>>>>> since the device is no longer part of a PM domain at this point, the PM
>>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>>>>> Renesas SoCs.
>>>>>>
>>>>>> Another identified case is when a subsystem performs various cleanups
>>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>>>>> A known example is the thermal subsystem, which may call driver-specific
>>>>>> APIs to disable the thermal device. The relevant call stack in this case
>>>>>> is:
>>>>>>
>>>>>> device_driver_detach() ->
>>>>>>   device_release_driver_internal() ->
>>>>>>     device_unbind_cleanup() ->
>>>>>>       devres_release_all() ->
>>>>>>         devm_thermal_of_zone_release() ->
>>>>>> 	  thermal_zone_device_disable() ->
>>>>>> 	    thermal_zone_device_set_mode() ->
>>>>>> 	      struct thermal_zone_device_ops::change_mode()
>>>>>>
>>>>>> At the moment the driver-specific change_mode() API is called, the device
>>>>>> is no longer part of its PM domain. Accessing its registers without proper
>>>>>> power management leads to system aborts.
>>>>>>
>>>>>> Open a devres group before calling the driver probe, and close it
>>>>>> immediately after the driver remove function is called and before
>>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>>>>> reset functions are executed immediately after the driver remove function
>>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>>>>> being called when the device is no longer part of its power domain.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> ---
>>>>>>
>>>>>> Hi,
>>
>> Hi Claudiu, Greg,
>>
>> Sorry, I missed this thread whilst travelling and only saw it because
>> of reference from the in driver solution.
>>
>>>>>>
>>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>>>>> approaches in [1], [2] as he considered it may lead to dificult to
>>>>>> maintain code and code opened to subtle bugs (due to the potential of
>>>>>> mixing devres and non-devres calls). He pointed out a similar approach
>>>>>> that was done for the I2C bus [4], [5].
>>>>>>
>>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>>>>> patch tries to revive it by proposing a similar approach that was done
>>>>>> for the I2C bus.
>>>>>>
>>>>>> Please let me know you input.  
>>>>>
>>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>>>>> have drivers mixing them and side affects happening and lots of
>>>>> confusion.  Your change here is only going to make it even more
>>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
>>>>> about iio devices NOT on the platform bus?)  
>>
>> In some cases they are already carrying the support as per the link
>> above covering all i2c drivers.  I'd like to see a generic solution and
>> I suspect pushing it to the device drivers rather than the bus code
>> will explode badly and leave us with subtle bugs where people don't
>> realise it is necessary. 
>>
>> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
>> is a lot nastier looking than what we have here. I'll review that in a minute
>> to show that it need not be that bad, but none the less not pleasant.
>>
>> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
>> similar)
> 
> We should not expect individual drivers handle this, because this is a
> layering violation: they need to know implementation details of the bus
> code to know if the bus is using non-devres managed resources, and
> adjust their behavior. Moving this into driver core is also not
> feasible, as not all buses need it. So IMO this should belong to
> individual bus code.
> 
> Instead of using devres group a bus may opt to use
> devm_add_action_or_reset() and other devm APIs to make sure bus'
> resource unwinding is carried in the correct order relative to freeing
> driver-owned resources.

Can you please let us know your input on the approach proposed in this
patch? Or if you would prefer devm_add_action_or_reset() as suggested by
Dmitry? Or if you consider another approach would fit better?

Currently there were issues identified with the rzg2l-adc driver (driver
based solution proposed in [1]) and with the rzg3s thermal driver (solved
by function rzg3s_thermal_probe() from [2]).

As expressed previously by Jonathan and Dimitry this is a common problem
and as the issue is due to a call in the bus driver, would be better and
simpler to handle it in the bus driver. Otherwise, individual drivers would
have to be adjusted in a similar way.

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250324122627.32336-2-claudiu.beznea.uj@bp.renesas.com/
[2]
https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/

> 
>>
>>>>
>>>> You're right, other busses will still have this problem.
>>>>   
>>>>>
>>>>> Why can't your individual driver handle this instead?  
>>
>> In my mind because it's the bus code that is doing the unexpected part by
>> making calls in the remove path that are effectively not in the same order
>> as probe because they occur between driver remove and related devres cleanup
>> for stuff registered in probe.
>>
>>>>
>>>> Initially I tried it at the driver level by using non-devres PM runtime
>>>> enable API but wasn't considered OK by all parties.
>>>>
>>>> I haven't thought about having devres_open_group()/devres_close_group() in
>>>> the driver itself but it should work.  
>>>
>>> Are you OK with having the devres_open_group()/devres_close_group() in the
>>> currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
>>> proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?
>>
>> I guess it may be the best of a bunch of not particularly nasty solutions...
> 
> We need to update _ALL_ platform drivers using devm then, and this is
> clearly not scalable.
> 
> Thanks.
> 


