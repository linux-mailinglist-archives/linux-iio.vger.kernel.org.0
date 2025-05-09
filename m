Return-Path: <linux-iio+bounces-19380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4BAB128B
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AEA4A4BCA
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC62900AF;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rRT6by3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889D28FAAC
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791504; cv=none; b=hJtx+Li0ReP6W2Pb7cbB6gqGKS0bP8gIadFN/8iO9Pd4Iv5ackjE1sJB3XtlPrxY/eOMH8tQdFIie6j6ZyF65n/hD8xsTVnSZNMnaxPHz0oi00GKh1VDyzJszyYR+RaoLknOAGWur4o+mscVofPmC9HfV7l38wcv+meWHGJ9zSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791504; c=relaxed/simple;
	bh=94hSLVwahZL6uSGp/GCIw7ak3VmONi+Q3s+hjbITQj8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cXtpqHWSdvPdjwoDT2Os113uhY15h2zllaOHvjaWSgj3qBtEmLHwJBM0c27lbFToIYT3UHtX7KZnyXRpVjM7G/Seizi0kMUVUNvHRJDeUM5tkZaDeHFwpNI/gQZol/eoquFWp6v89Vnj0cdGwFYZ85Ws47xSVfPGC2GeDKaG0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rRT6by3M; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fab81d6677so3815028a12.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746791500; x=1747396300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HcCUAVth4/4X0ivCD1jla215xTKz2P8JDpUcQkYuzX4=;
        b=rRT6by3MuduwkSN/H4fHg3R3x+qWcNizG+URaLmW2ISNy7GYhh1fpzPFZ2G9ffPYyG
         izXnmui2iSTjI7TCX9BMj3pUeYywAHM/XTvh6qShsaZv7ZCfu5a9LmdeEdkWdQqHieBL
         885NsSYTtAVhqY4H/WcTuZLEhEu2Hs8NH69GoHtqgg9WVluFkkvlEjNo8US434zLjjE3
         9b9lUJByaoj/bm96D6m7jyu11BYEwGfxmkreqcvheUE1HT6/3KG89LlLTNICJ9ZSBMup
         vyXtV3ld8DkwKMs3j1IEaG9tbV8pTI6UDmLVZzJcr6fAofr+FdURv02Ky4LCzDjHihrF
         rgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746791500; x=1747396300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcCUAVth4/4X0ivCD1jla215xTKz2P8JDpUcQkYuzX4=;
        b=GYZ/+4jLUGP1k8+6iICPtpLLjqq3i/sm5ytnoFywaicybzi/8Gm/mKA+5NzpRWTJoB
         F9FHx92tMGRcMRJaMdm/dIWgrANsr+4qJ6z8NKae80rzfXOmhc4e8DNKBHqzu+QHMYL3
         Xkcin4QgF1gXdvGV+fYGDlomBa4PA9f+3j1QhetncjtmH+8z6t3EeHgWawNuZsoQ5pcR
         x7f6qzvE2CRstJM8qMANwkJE1TWuDSYgK0aNMmmaPOAShdadLsSB0qyMbFhynSdheO5n
         efIG6EhM7aTRHDPDRSKqMAZWQjti271vE7KV7mmhRZfebJ44EfpyaUiyqIL/xGBBE7Qw
         odWg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0iXa18ihqUfyS69wcHLK9ISiUWf7vpSeP0M4CQNls8eX/r6L0XO+UaHuVS1jkH6axFlmemoxFOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeV2KKffDkmKhhj8+bV/hquKdtrgOXzNO4zRMOxR2tYId/Lg/
	2gqTjHk9PzLSD7fsNYR6IqlBbPBvVfN5U5jqK9gbuG0TSzU8TWxG9j+8WsHvRO0=
X-Gm-Gg: ASbGncvVC9+hyB3CFcivSNatRo/DgCu7uSzSFTh5Ea514cBUOPxmOmPS6AkFdI++Bm/
	hKc8rGcDecsF1vkuKylDPoIsF+rpkuAeuZ8pbYsEfSDYeEg4cRx3S9P3sYPr9+iB3fvvlaScLr6
	Y3kONTlEPBCqba2CM/8Lu3mQ/4A8yMHMN2k8/MotblmMEdwtuFdvf3TR5B8yFUd6iG7uaDYEGpA
	iCtPvpFQQfDiNRKA8FkOeTg1tMLpzE0EvZMF2t4NmuNh8bMbUUtQeOSeta54AR4YrurT/kr0TQA
	XdWrGM0qflTs0rW7tPskoTajP9WpCG2JgmfcR/3yu/46LWH/
X-Google-Smtp-Source: AGHT+IFrGDRXG6FAVEd4uSESGaBsfaTJHvGQG8PV98kRwmaQFMuRJod0R5mnXx5DDPecf/kyISoRWw==
X-Received: by 2002:a17:907:97d2:b0:ad1:77aa:503 with SMTP id a640c23a62f3a-ad219124207mr305429066b.36.1746791500229;
        Fri, 09 May 2025 04:51:40 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bdd63sm138709266b.154.2025.05.09.04.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 04:51:39 -0700 (PDT)
Message-ID: <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
Date: Fri, 9 May 2025 14:51:38 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
 <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei> <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
Content-Language: en-US
In-Reply-To: <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Rafael, Ulf, PM list,


On 09.04.2025 19:12, Claudiu Beznea wrote:
> Hi, Rafael,
> 
> On 30.03.2025 18:31, Jonathan Cameron wrote:
>> On Thu, 27 Mar 2025 18:47:53 +0200
>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>>> Hi, Rafael,
>>>
>>> On 06.03.2025 08:11, Dmitry Torokhov wrote:
>>>> On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:  
>>>>> On Wed, 19 Feb 2025 14:45:07 +0200
>>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>>  
>>>>>> Hi, Daniel, Jonathan,
>>>>>>
>>>>>> On 15.02.2025 15:51, Claudiu Beznea wrote:  
>>>>>>> Hi, Greg,
>>>>>>>
>>>>>>> On 15.02.2025 15:25, Greg KH wrote:    
>>>>>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:    
>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>>
>>>>>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>>>>>>>> clocks are managed through PM domains. These PM domains, registered on
>>>>>>>>> behalf of the clock controller driver, are configured with
>>>>>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>>>>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>>>>>>>> also have power_on/power_off support implemented. After the device PM
>>>>>>>>> domain is powered off any CPU accesses to these domains leads to system
>>>>>>>>> aborts.
>>>>>>>>>
>>>>>>>>> During probe, devices are attached to the PM domain controlling their
>>>>>>>>> clocks and power. Similarly, during removal, devices are detached from the
>>>>>>>>> PM domain.
>>>>>>>>>
>>>>>>>>> The detachment call stack is as follows:
>>>>>>>>>
>>>>>>>>> device_driver_detach() ->
>>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>>     __device_release_driver() ->
>>>>>>>>>       device_remove() ->
>>>>>>>>>         platform_remove() ->
>>>>>>>>> 	  dev_pm_domain_detach()
>>>>>>>>>
>>>>>>>>> During driver unbind, after the device is detached from its PM domain,
>>>>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>>>>>>>> devres_release_all(). This function handles devres resource cleanup.
>>>>>>>>>
>>>>>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>>>>>>>> cleanup process triggers the action or reset function for disabling runtime
>>>>>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>>>>>>>> following call stack of interest when called:
>>>>>>>>>
>>>>>>>>> pm_runtime_disable_action() ->
>>>>>>>>>   pm_runtime_dont_use_autosuspend() ->
>>>>>>>>>     __pm_runtime_use_autosuspend() ->
>>>>>>>>>       update_autosuspend() ->
>>>>>>>>>         rpm_idle()
>>>>>>>>>
>>>>>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>>>>>>>> at the point it is called, the device is no longer part of a PM domain
>>>>>>>>> (which manages clocks and power states). If the driver implements its own
>>>>>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>>>>>>>> driver - while also relying on the power domain subsystem for power
>>>>>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>>>>>>>> since the device is no longer part of a PM domain at this point, the PM
>>>>>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>>>>>>>> Renesas SoCs.
>>>>>>>>>
>>>>>>>>> Another identified case is when a subsystem performs various cleanups
>>>>>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>>>>>>>> A known example is the thermal subsystem, which may call driver-specific
>>>>>>>>> APIs to disable the thermal device. The relevant call stack in this case
>>>>>>>>> is:
>>>>>>>>>
>>>>>>>>> device_driver_detach() ->
>>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>>     device_unbind_cleanup() ->
>>>>>>>>>       devres_release_all() ->
>>>>>>>>>         devm_thermal_of_zone_release() ->
>>>>>>>>> 	  thermal_zone_device_disable() ->
>>>>>>>>> 	    thermal_zone_device_set_mode() ->
>>>>>>>>> 	      struct thermal_zone_device_ops::change_mode()
>>>>>>>>>
>>>>>>>>> At the moment the driver-specific change_mode() API is called, the device
>>>>>>>>> is no longer part of its PM domain. Accessing its registers without proper
>>>>>>>>> power management leads to system aborts.
>>>>>>>>>
>>>>>>>>> Open a devres group before calling the driver probe, and close it
>>>>>>>>> immediately after the driver remove function is called and before
>>>>>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>>>>>>>> reset functions are executed immediately after the driver remove function
>>>>>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>>>>>>>> being called when the device is no longer part of its power domain.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Hi,  
>>>>>
>>>>> Hi Claudiu, Greg,
>>>>>
>>>>> Sorry, I missed this thread whilst travelling and only saw it because
>>>>> of reference from the in driver solution.
>>>>>  
>>>>>>>>>
>>>>>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>>>>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>>>>>>>> approaches in [1], [2] as he considered it may lead to dificult to
>>>>>>>>> maintain code and code opened to subtle bugs (due to the potential of
>>>>>>>>> mixing devres and non-devres calls). He pointed out a similar approach
>>>>>>>>> that was done for the I2C bus [4], [5].
>>>>>>>>>
>>>>>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>>>>>>>> patch tries to revive it by proposing a similar approach that was done
>>>>>>>>> for the I2C bus.
>>>>>>>>>
>>>>>>>>> Please let me know you input.    
>>>>>>>>
>>>>>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>>>>>>>> have drivers mixing them and side affects happening and lots of
>>>>>>>> confusion.  Your change here is only going to make it even more
>>>>>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
>>>>>>>> about iio devices NOT on the platform bus?)    
>>>>>
>>>>> In some cases they are already carrying the support as per the link
>>>>> above covering all i2c drivers.  I'd like to see a generic solution and
>>>>> I suspect pushing it to the device drivers rather than the bus code
>>>>> will explode badly and leave us with subtle bugs where people don't
>>>>> realise it is necessary. 
>>>>>
>>>>> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
>>>>> is a lot nastier looking than what we have here. I'll review that in a minute
>>>>> to show that it need not be that bad, but none the less not pleasant.
>>>>>
>>>>> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
>>>>> similar)  
>>>>
>>>> We should not expect individual drivers handle this, because this is a
>>>> layering violation: they need to know implementation details of the bus
>>>> code to know if the bus is using non-devres managed resources, and
>>>> adjust their behavior. Moving this into driver core is also not
>>>> feasible, as not all buses need it. So IMO this should belong to
>>>> individual bus code.
>>>>
>>>> Instead of using devres group a bus may opt to use
>>>> devm_add_action_or_reset() and other devm APIs to make sure bus'
>>>> resource unwinding is carried in the correct order relative to freeing
>>>> driver-owned resources.  
>>>
>>> Can you please let us know your input on the approach proposed in this
>>> patch? Or if you would prefer devm_add_action_or_reset() as suggested by
>>> Dmitry? Or if you consider another approach would fit better?
>>>
>>> Currently there were issues identified with the rzg2l-adc driver (driver
>>> based solution proposed in [1]) and with the rzg3s thermal driver (solved
>>> by function rzg3s_thermal_probe() from [2]).
>>>
>>> As expressed previously by Jonathan and Dimitry this is a common problem
>>> and as the issue is due to a call in the bus driver, would be better and
>>> simpler to handle it in the bus driver. Otherwise, individual drivers would
>>> have to be adjusted in a similar way.
>>>
>>
>> Rafael,
>>
>> Greg suggested we ask for your input on the right option:
>>
>> https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
>> (that thread has the other option).
> 
> Can you please let us know your opinion on this?
Can you please let us know if you have any suggestions for this?

Thank you,
Claudiu

