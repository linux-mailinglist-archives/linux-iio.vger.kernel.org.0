Return-Path: <linux-iio+bounces-19385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C19AB16F4
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029479E37CB
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C5296720;
	Fri,  9 May 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="f0GjcgKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D2295DA2
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799946; cv=none; b=KQLtjKz0onuWFsMLbfuW7vhfy1wp7teVGlWgrFD19LK+qdIshiglBPK0kcecV7PID4SnxOZdjKBN6imeLRQsQc1SNia7Xr0AS7PflF/C0LZRSTMWlRJKEDT5WRrXuKSFNAr+mOSxiFW83vZ5DrPGm9ovT+5HT7JTgTuRG7OM31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799946; c=relaxed/simple;
	bh=3mZ5hAbvTCuIpHvCHnGp5N48F8JXYf8gvrfdJsvnFVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNXp99KPbgCukDDXRiSLOZmbMFo+0O+rifMIMMKucE7jtEZ7ZykM5Iy4w4vx6j1VCM/yv8ia+/9pVTyYBsa+INnFJcJpX6yknV7Ub5/BAmj8qCB9ggDUU0iYYejxSkk+lPYSaVxm1e1fXcM7SmwFNUe7bZ1mD4RaBAwtQvVBUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=f0GjcgKX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3451969a12.3
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746799942; x=1747404742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i38qSpFJPSTwazTHcNnfuMY71y9hs8KYKhkMQ5X3D4Q=;
        b=f0GjcgKXD8ka5seM/mzwDj+ps5CIWrIcXLShb/2CU7Gkt6mKvohSD6slvYQGQSCUlG
         PFbTw/Rac3tjYG30SxnkKw9dWi8YZRZnoPDpG9xPV8aWDdCAHTABICmVEgmZILxXLMG7
         lmmRxzGkty+q/t0+m0+Jb3y0phXraOhvPcpjtNhDkt5i/0993PqbtyVMyC4IRYc2CIJT
         zWuUPJDm/NS/VyFvdWuAlyBSrDDVjoi97rVrVRGsdgyb98yR5OPZ+8gGtJpRW2zqUWAW
         cbkrAz5oYjBucG7HtoieEJMaHOPcrzyJCQ2nVBsWTOyD1O7HBI7VsCWkifOj/OMTG6AR
         xv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799942; x=1747404742;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i38qSpFJPSTwazTHcNnfuMY71y9hs8KYKhkMQ5X3D4Q=;
        b=gxZvbZCj5ptAsR2iydIDydoVnjYL6YctGWo+gOT+pMMEIm+qSKXhPQ0Plx1tkytldZ
         ellgBjriyoYdmaerK9HC/Ed5FO2v+MP95aha8yrA2A1H76Y7AZbbXCZCBvVdOiT7QFjL
         3QaGmQdL0pcDE6EndbYGdj14VhXbsSGFq6hq+TvdmsCaxcvLe7wWiKIkdvk30tTFNMAK
         O0ZCwjigkdsAb+gsHF/IQ8cQ5IpRyT0p25gCbsKRD2gl/nK3Ps/hgmiUsLxlHAku9yaZ
         Kmi3gr6qcPhgWOaoBc79mSmRxKMnF5wJruFAVYnnTC4kqrAKnCy2MYH+LTcv4s+1dZkW
         52ng==
X-Forwarded-Encrypted: i=1; AJvYcCUTZjqvdiG4Zh3OqlJrNJG3qSv5oKmFBp9a5Y0376npM+GXeTt0glYW9GAq5RAAP5knBIv+G84mMyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZqw3XGtHygssM/EOCgFZ5crSlijcNfNkmP8dtAqJI0TOybhi
	IrDaDEv8JvV8gWWgKQ7ObuEcfY4hT3yiBwYNueSs3JUAoyLiHTzZXF2pns7ff9M=
X-Gm-Gg: ASbGnctn3eiBcktqk9ydhQku0/s1+EqQJJMkFF9rP2vyQjWKu2miosu5HsgXBhxCeXA
	PsXnIq4JVUolEDNcvMzHZcFuNw4XwDFlDEXQFcuNY3PNKpKzDxJx+dhCsJFpmHkfuD32FYaatD9
	broUQ2119BZ8w47k+hul5E52t26M95KDzv8ahIytbbCFkOwUXSEKl5zMGn6V469Z+RH3OsVWehj
	+82A4Xk5+eq/MB24bpO3/CnzSdhMW9DvWkvoFLM9f2ZI7X0DbJzeCxbViFXsry4gywbO5XI/nln
	Ah9zjgIqIWj5R2AkXmn7kP4zPLQ6AZl6jJxsAVjLcPRYSbJU
X-Google-Smtp-Source: AGHT+IHT3Dv/9vkIs0ra+NCFrMJz3T4UtPvNv1hS8WbA/UJp4/Pj2uNQCPPyYHPEBj5bGRWVd9KKSA==
X-Received: by 2002:a17:906:e20b:b0:ac3:f1dc:f3db with SMTP id a640c23a62f3a-ad218fc86a9mr284052266b.13.1746799941942;
        Fri, 09 May 2025 07:12:21 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2198532d7sm155288566b.170.2025.05.09.07.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:12:21 -0700 (PDT)
Message-ID: <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
Date: Fri, 9 May 2025 17:12:19 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 dakr@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, bhelgaas@google.com
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
 <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei> <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

Thank you for your input!

On 09.05.2025 16:07, Ulf Hansson wrote:
> On Fri, 9 May 2025 at 13:51, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Rafael, Ulf, PM list,
>>
>>
>> On 09.04.2025 19:12, Claudiu Beznea wrote:
>>> Hi, Rafael,
>>>
>>> On 30.03.2025 18:31, Jonathan Cameron wrote:
>>>> On Thu, 27 Mar 2025 18:47:53 +0200
>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>
>>>>> Hi, Rafael,
>>>>>
>>>>> On 06.03.2025 08:11, Dmitry Torokhov wrote:
>>>>>> On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:
>>>>>>> On Wed, 19 Feb 2025 14:45:07 +0200
>>>>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>>>>
>>>>>>>> Hi, Daniel, Jonathan,
>>>>>>>>
>>>>>>>> On 15.02.2025 15:51, Claudiu Beznea wrote:
>>>>>>>>> Hi, Greg,
>>>>>>>>>
>>>>>>>>> On 15.02.2025 15:25, Greg KH wrote:
>>>>>>>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:
>>>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>>>>
>>>>>>>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>>>>>>>>>> clocks are managed through PM domains. These PM domains, registered on
>>>>>>>>>>> behalf of the clock controller driver, are configured with
>>>>>>>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>>>>>>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>>>>>>>>>> also have power_on/power_off support implemented. After the device PM
>>>>>>>>>>> domain is powered off any CPU accesses to these domains leads to system
>>>>>>>>>>> aborts.
>>>>>>>>>>>
>>>>>>>>>>> During probe, devices are attached to the PM domain controlling their
>>>>>>>>>>> clocks and power. Similarly, during removal, devices are detached from the
>>>>>>>>>>> PM domain.
>>>>>>>>>>>
>>>>>>>>>>> The detachment call stack is as follows:
>>>>>>>>>>>
>>>>>>>>>>> device_driver_detach() ->
>>>>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>>>>     __device_release_driver() ->
>>>>>>>>>>>       device_remove() ->
>>>>>>>>>>>         platform_remove() ->
>>>>>>>>>>>         dev_pm_domain_detach()
>>>>>>>>>>>
>>>>>>>>>>> During driver unbind, after the device is detached from its PM domain,
>>>>>>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>>>>>>>>>> devres_release_all(). This function handles devres resource cleanup.
>>>>>>>>>>>
>>>>>>>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>>>>>>>>>> cleanup process triggers the action or reset function for disabling runtime
>>>>>>>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>>>>>>>>>> following call stack of interest when called:
>>>>>>>>>>>
>>>>>>>>>>> pm_runtime_disable_action() ->
>>>>>>>>>>>   pm_runtime_dont_use_autosuspend() ->
>>>>>>>>>>>     __pm_runtime_use_autosuspend() ->
>>>>>>>>>>>       update_autosuspend() ->
>>>>>>>>>>>         rpm_idle()
>>>>>>>>>>>
>>>>>>>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>>>>>>>>>> at the point it is called, the device is no longer part of a PM domain
>>>>>>>>>>> (which manages clocks and power states). If the driver implements its own
>>>>>>>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>>>>>>>>>> driver - while also relying on the power domain subsystem for power
>>>>>>>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>>>>>>>>>> since the device is no longer part of a PM domain at this point, the PM
>>>>>>>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>>>>>>>>>> Renesas SoCs.
>>>>>>>>>>>
>>>>>>>>>>> Another identified case is when a subsystem performs various cleanups
>>>>>>>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>>>>>>>>>> A known example is the thermal subsystem, which may call driver-specific
>>>>>>>>>>> APIs to disable the thermal device. The relevant call stack in this case
>>>>>>>>>>> is:
>>>>>>>>>>>
>>>>>>>>>>> device_driver_detach() ->
>>>>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>>>>     device_unbind_cleanup() ->
>>>>>>>>>>>       devres_release_all() ->
>>>>>>>>>>>         devm_thermal_of_zone_release() ->
>>>>>>>>>>>         thermal_zone_device_disable() ->
>>>>>>>>>>>           thermal_zone_device_set_mode() ->
>>>>>>>>>>>             struct thermal_zone_device_ops::change_mode()
>>>>>>>>>>>
>>>>>>>>>>> At the moment the driver-specific change_mode() API is called, the device
>>>>>>>>>>> is no longer part of its PM domain. Accessing its registers without proper
>>>>>>>>>>> power management leads to system aborts.
>>>>>>>>>>>
>>>>>>>>>>> Open a devres group before calling the driver probe, and close it
>>>>>>>>>>> immediately after the driver remove function is called and before
>>>>>>>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>>>>>>>>>> reset functions are executed immediately after the driver remove function
>>>>>>>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>>>>>>>>>> being called when the device is no longer part of its power domain.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>
>>>>>>> Hi Claudiu, Greg,
>>>>>>>
>>>>>>> Sorry, I missed this thread whilst travelling and only saw it because
>>>>>>> of reference from the in driver solution.
>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>>>>>>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>>>>>>>>>> approaches in [1], [2] as he considered it may lead to dificult to
>>>>>>>>>>> maintain code and code opened to subtle bugs (due to the potential of
>>>>>>>>>>> mixing devres and non-devres calls). He pointed out a similar approach
>>>>>>>>>>> that was done for the I2C bus [4], [5].
>>>>>>>>>>>
>>>>>>>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>>>>>>>>>> patch tries to revive it by proposing a similar approach that was done
>>>>>>>>>>> for the I2C bus.
>>>>>>>>>>>
>>>>>>>>>>> Please let me know you input.
>>>>>>>>>>
>>>>>>>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>>>>>>>>>> have drivers mixing them and side affects happening and lots of
>>>>>>>>>> confusion.  Your change here is only going to make it even more
>>>>>>>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
>>>>>>>>>> about iio devices NOT on the platform bus?)
>>>>>>>
>>>>>>> In some cases they are already carrying the support as per the link
>>>>>>> above covering all i2c drivers.  I'd like to see a generic solution and
>>>>>>> I suspect pushing it to the device drivers rather than the bus code
>>>>>>> will explode badly and leave us with subtle bugs where people don't
>>>>>>> realise it is necessary.
>>>>>>>
>>>>>>> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
>>>>>>> is a lot nastier looking than what we have here. I'll review that in a minute
>>>>>>> to show that it need not be that bad, but none the less not pleasant.
>>>>>>>
>>>>>>> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
>>>>>>> similar)
>>>>>>
>>>>>> We should not expect individual drivers handle this, because this is a
>>>>>> layering violation: they need to know implementation details of the bus
>>>>>> code to know if the bus is using non-devres managed resources, and
>>>>>> adjust their behavior. Moving this into driver core is also not
>>>>>> feasible, as not all buses need it. So IMO this should belong to
>>>>>> individual bus code.
>>>>>>
>>>>>> Instead of using devres group a bus may opt to use
>>>>>> devm_add_action_or_reset() and other devm APIs to make sure bus'
>>>>>> resource unwinding is carried in the correct order relative to freeing
>>>>>> driver-owned resources.
>>>>>
>>>>> Can you please let us know your input on the approach proposed in this
>>>>> patch? Or if you would prefer devm_add_action_or_reset() as suggested by
>>>>> Dmitry? Or if you consider another approach would fit better?
>>>>>
>>>>> Currently there were issues identified with the rzg2l-adc driver (driver
>>>>> based solution proposed in [1]) and with the rzg3s thermal driver (solved
>>>>> by function rzg3s_thermal_probe() from [2]).
>>>>>
>>>>> As expressed previously by Jonathan and Dimitry this is a common problem
>>>>> and as the issue is due to a call in the bus driver, would be better and
>>>>> simpler to handle it in the bus driver. Otherwise, individual drivers would
>>>>> have to be adjusted in a similar way.
>>>>>
>>>>
>>>> Rafael,
>>>>
>>>> Greg suggested we ask for your input on the right option:
>>>>
>>>> https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
>>>> (that thread has the other option).
>>>
>>> Can you please let us know your opinion on this?
>> Can you please let us know if you have any suggestions for this?
> 
> It's been a while since I looked at this. Although as I understand it,
> the main issue comes from using devm_pm_runtime_enable().

Yes, it comes from the usage of devm_pm_runtime_enable() in drivers and the
dev_pm_domain_detach() call in platform_remove() right after calling
driver's remove function.

On the platform I experienced issues with, the dev_pm_domain_detach() drops
the clocks from the device power domain and any subsequent PM runtime
resume calls (that may happen in the devres cleanup phase) have no effect
on enabling the clocks. If driver has functions registered (e.g. through
devm_add_action_or_reset()), or driver specific runtime PM functions that
access directly registers in the devres cleanup phase this leads to system
aborts.


> 
> As I have tried to argue before, I think devm_pm_runtime_enable()
> should *not* be used. Not here, not at all. Runtime PM isn't like any
> other resources that we fetch/release. Instead, it's a behaviour that
> you turn on and off, which needs to be managed more carefully, rather
> than relying on fetch/release ordering from devres.
> 
> That said, I would convert the driver to use pm_runtime_enable() and
> pm_runtime_disable() instead.

I've tried this approach previously but it resulted in more complicated
code and thus, Jonathan wasn't happy with it [1].

Another approach I've tried was to have devres group opened/closed in the
driver itself [2], [3] but it was postponed as this approach may have a chance.

At the moment I have 2 drivers waiting for a resolution on this [2], [3]
and I recently posted a new one [4] that uses driver specific local devres
group to avoid this issue.


Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com
[2]
https://lore.kernel.org/all/20250324122627.32336-2-claudiu.beznea.uj@bp.renesas.com
[3]
https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/
[4]
https://lore.kernel.org/all/20250430103236.3511989-6-claudiu.beznea.uj@bp.renesas.com

