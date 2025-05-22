Return-Path: <linux-iio+bounces-19803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BAAC0DBB
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7543B1CAF
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF828C5B0;
	Thu, 22 May 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SqIMqXp8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5528C017
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922909; cv=none; b=NXsSIbvRFY4ggr+ruxQB2CH01eQCXqOET5klgU7Lj/24O3z5spnHumPdDjjAswlQrMClAyObr75VTTAJAvFVNfDhaHqEzU7kU9R83VGbjVwkubuFfJ5ZJVEbNIEBRqKO4RGJHzlKRPehec0n0OduZQQeaiF44dR+VDrLJBsiHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922909; c=relaxed/simple;
	bh=sKRWtQLFM3BikSvuSI0I19AZjAJ0USpkd0DsiZKT94U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbRriHyVFI5x1VJdz4/EfQvlfR1/ScTS+e/pR/AfBw5gqBhds+1u3RFxLlCFsUJao+cDrQWjLT2hvmGiWGdonDNZpFzKTjd/y5KnC2eSzDW5zz8U/S71XHMs23F1v/63+cec7JqOP0mHhKvB3YASPb7mSL6kCo2P3UNAY723kMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SqIMqXp8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56e993ae9so908716466b.3
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747922905; x=1748527705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JnH/UvNq6EudFKnyGLwmWgVhkOUt6Qi43wiQBrg6GA=;
        b=SqIMqXp8kcAF/NL86NhVrDxBbqFmslLjxoDXTcEY0739VQDpNh2Eq5tW0hoqg20N6L
         Udm3AHQKchknm09I49NFqQ+2U6qMbHQAH68gh0QrZs5dQ1wE2I5RW8AiLBG+g9p0groO
         eB+fJ8B1DY4bxHgzn3BJ5ixePDPBL2VgQ86tVpReLWiJf38ei98NAI6gyHhqOWG8+x0H
         WEeH93U2HIH6LLnjB7TQtwhsxJ8RBW1Ah5AZbK0HJS5JYEZvSOHfcv0AZk3VlvtZzOSt
         Q2OlxGNzgz5jVBatwPd3BzKktAOHZtxUEekWyB3Z0ipQOV5B0/LLurbgecBhCOFUVclu
         T1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922905; x=1748527705;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JnH/UvNq6EudFKnyGLwmWgVhkOUt6Qi43wiQBrg6GA=;
        b=KxJLoclB4ZD4KjKulrR/kHuqBTH4mejAWjCb2MlI2E3OR9BMOrpazoO1egO5q0hXOw
         ycQjyNrng+xFO9dA+0TOy6+dpoRm9hNhENeRN+UZIIP6NjkPcyZs32HHCScRu+SO6bJf
         ZAVza60YwF+xJdyQuUuZCGzDjbAaeWKCmRZ5a7234YRUzT/6XRX2Q9GjoxXdILNpvt+1
         SX4sfNlJK3jzcK3goW3v5wBX0QId4/0SGH4qlK7EDmoqesOxImIOm2dqGN1daw+Qsa/g
         vDkAiz2Qp3Uj/c0WgcsC1P6ftYWmZS/vREBudQqxEDbN6XKZyEfo1TpbNheTWxuU2Urq
         /Diw==
X-Forwarded-Encrypted: i=1; AJvYcCVCctBAd9DQhsH41O0TUFQUNJrGheHamMyqFZ6nzzZTKeKx8tIWFQXumJJUqMgsF5wiVTPp/J7LPkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGQ0ZcEsK96h/JNm1faAUwCapaA9L+V84LRE5PUmG1MUguFE6
	bEKrmUkK9WnZiP0FZ8wA7wUoAjEO4dI+jC2vCJX66FPy7lly5YHZq/YSSghOik20tac=
X-Gm-Gg: ASbGncuaTmMub1RsB5Av21JKbnakRqop72j5K4JwWLGlSaFlFcLjEV0m3u8vczcnzAj
	dGvXVv61vXHd7a+7XdvDN6318sf6Vdt1DlRDcHJJWtGcSuOzw8Vt4PkYxN+/XpHdhBcDXkZEZvI
	GtBnR+V6IujPoh96bZRq7s5Qe0GVec5k07kguR6CbtPvcQUWKkGwAEAddP/yhiEUwteq/sA8ZNm
	ASygJux118hYmc9GEYzCOkcrtuPwH38ICEn78tqU3SfrpQ2gq2Ls2FowSUvTBESGIWi6eRG0tD8
	j0wT02JCEDMcnYk30jJBrWxbftHZMzemS/51zQKdy7L+wvEWwGGranWxPAn6qoImOVg3/Q==
X-Google-Smtp-Source: AGHT+IHCMBXqdKSREDToijHF0Dd4OGxrQuItebItFBlt1XKnbPAI9VNU5D+hMOLVkNTSvt/yX3GJyQ==
X-Received: by 2002:a17:907:940f:b0:acf:c:22ca with SMTP id a640c23a62f3a-ad536b5a48dmr2356806666b.1.1747922905316;
        Thu, 22 May 2025 07:08:25 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278290sm1075395866b.78.2025.05.22.07.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 07:08:24 -0700 (PDT)
Message-ID: <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev>
Date: Thu, 22 May 2025 17:08:23 +0300
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 dakr@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 bhelgaas@google.com
References: <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev>
 <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 22.05.2025 14:53, Ulf Hansson wrote:
> On Thu, 22 May 2025 at 11:48, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Ulf,
>>
>> On 21.05.2025 17:57, Dmitry Torokhov wrote:
>>> On Wed, May 21, 2025 at 02:37:08PM +0200, Ulf Hansson wrote:
>>>> On Wed, 21 May 2025 at 07:41, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>>
>>>>> Hi, Ulf,
>>>>>
>>>>> On 20.05.2025 15:09, Ulf Hansson wrote:
>>>>>> For example, even if the order is made correctly, suppose a driver's
>>>>>> ->remove() callback completes by turning off the resources for its
>>>>>> device and leaves runtime PM enabled, as it relies on devres to do it
>>>>>> some point later. Beyond this point, nothing would prevent userspace
>>>>>> for runtime resuming/suspending the device via sysfs.
>>>>>
>>>>> If I'm not wrong, that can't happen? The driver_sysfs_remove() is called
>>>>> before device_remove() (which calls the driver remove) is called, this
>>>>> being the call path:
>>>>>
>>>>> device_driver_detach() ->
>>>>>   device_release_driver_internal() ->
>>>>>     __device_release_driver() ->
>>>>>       driver_sysfs_remove()
>>>>>       // ...
>>>>>       device_remove()
>>>>>
>>>>> And the driver_sysfs_remove() calls in the end __kernfs_remove() which
>>>>> looks to me like the place that actually drops the entries from sysfs, this
>>>>> being a call path for it:
>>>>>
>>>>> driver_sysfs_remove() ->
>>>>>   sysfs_remove_link() ->
>>>>>     kernfs_remove_by_name() ->
>>>>>       kernfs_remove_by_name_ns() ->
>>>>>         __kernfs_remove() ->
>>>>>
>>>>> activating the following line in __kernfs_remove():
>>>>>
>>>>> pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
>>>>>
>>>>> leads to the following prints when unbinding the watchdog device from its
>>>>> watchdog driver (attached to platform bus) on my board:
>>>>> https://p.fr33tux.org/935252
>>>>
>>>> Indeed this is a very good point you make! I completely overlooked
>>>> this fact, thanks a lot for clarifying this!
>>>>
>>>> However, my main point still stands.
>>>>
>>>> In the end, there is nothing preventing rpm_suspend|resume|idle() in
>>>> drivers/base/power/runtime.c from running (don't forget runtime PM is
>>>> asynchronous too) for the device in question. This could lead to that
>>>> a ->runtime_suspend|resume|idle() callback becomes executed at any
>>>> point in time, as long as we haven't called pm_runtime_disable() for
>>>> the device.
>>>
>>> So exactly the same may happen if you enter driver->remove() and
>>> something calls runtime API before pm_runtime_disable() is called.
>>> The driver has (as they should be doing currently) be prepared for this.
>>
>> I took the time and tried to do a comparison of the current solutions
>> (describing the bad and good things I see), trying to understand your
>> concerns with regards to RPM suspend|resume|idle while unbinding a device
>> from its driver.
>>
>> I see the following cases:
>>
>> Case 1/ the current approach when devm_pm_runtime_enable() is used in
>> driver's ->probe() with the current code base:
>>
>> - right after driver ->remove() finish its execution clocks are detached
>>   from the PM domain, through dev_pm_domain_detach() call in
>>   platform_remove()
>>
>> - any subsequent RPM resume|suspend|idle will lead to failure if the driver
>>   specific RPM APIs access directly registers and counts on PM domain to
>>   enable/disable the clocks
>>
>> - at this point, if the IRQs are shared (but not only) and devm requested
>>   the driver's IRQ handler can still be called asynchronously; driver
>>   should be prepared for such events and should be written to work for such
>>   scenarios; but as the clocks are not in the PM domain anymore and RPM is
>>   still enabled at this point, if the driver don't run runtime suspend on
>>   probe (and runtime resume/suspend on runtime), I think (because I haven't
>>   investigated this yet) it can't rely on pm_runtime_active()/
>>   pm_runtime_suspended() checks in interrupt handlers
>>   and can't decide if it can interrogate registers or not; interrogating
>>   should lead to failure at this stage as the clocks are disabled; drivers
>>   should work in such scenario and the CONFIG_DEBUG_SHIRQ is a way to check
>>   they can; I previously debugged a similar issue on drivers/net/ethernet/
>>   renesas/ravb driver where using devm_pm_runtime_enable() in probe and
>>   pm_runtime_suspended() checks in IRQ handlers was the way to make this
>>   scenario happy; at that time I wasn't able to find that
>>   dev_pm_domain_detach() have the impact discussed in this thread
>>
>> Case 2/ What is proposed in this patch: devm_pm_runtime_enable() used +
>> open devres group after dev_pm_domain_attach() (in probe) and close the
>> devres group before dev_pm_domain_attach() (in remove):
>>
>> - right after the driver ->remove() is executed only the driver allocated
>>   devres resources are freed; this happens before dev_pm_domain_deattach()
>>   is called, though the proposed devres_release_group() call in this patch
>>
>> - while doing this, driver can still get async RPM suspend|resume|idle
>>   requests; is like the execution is in the driver ->remove()
>>   but the pm_runtime_disable() hasn't been called yet
>>
>> - as the runtime PM is enabled in driver's ->probe() mostly after the HW is
>>   prepared to take requests and all the other devm resources are allocated,
>>   the RPM disable is going to be among the first things to be called by the
>>   devres_release_group()
>>
>> - then, after RPM disable, all the devres resources allocated only in the
>>   driver's ->probe() are cleaned up in reverse order, just like
>>   device_unbind_cleanup() -> devres_release_all() call in
>>   __device_release_driver() is doing, but limited only to the resources
>>   allocated by the driver itself; I personally see this like manually
>>   allocating and freeing resources in the driver itself w/o relying on
>>   devres
>>
>> - then it comes the turn of dev_pm_domain_detach() call in
>>   platform_remove(): at the time dev_pm_domain_detach() is executed the
>>   runtime PM is disabled and all the devres resources allocated by driver
>>   are freed as well
>>
>> - after the dev_pm_domain_detach() is executed all the driver resources
>>   are cleaned up, the driver can't get IRQs as it's handler was already
>>   unregistered, no other user can execute rpm suspend|resume|idle
>>   as the RPM is disabled at this time
>>
>> Case 3/ devm_pm_runtime_enabled() dropped and replaced by manual cleanup:
>> - the driver code is going be complicated, difficult to maintain and error
>>   prone
> 
> Yes, the driver's code would become slightly more complicated, but
> more importantly it would be correct.
> 
> To me it sounds like the driver's ->remove() callback could do this:
> 
> pm_runtime_get_sync()
> pm_runtime_disable()
> pm_runtime_put_noidle()

In my case it was just pm_runtime_disable() at the end of driver ->remove()
and pm_runtime_active() checks in IRQ handlers which didn't worked after
driver ->remove() finished execution due to disable_depth being incremented
in pm_runtime_disable(). The IRQs were devm requested.

The solution found at the that time was to use devm_pm_runtime_enable() in
probe and pm_runtime_suspended() calls in IRQ handlers.

> 
> In this way, the driver will runtime resume its device, allowing
> devres to drop/turn-off resources in the order we want.
> Except for the
> clocks, as those would be turned off via dev_pm_domain_detach() before
> the IRQ handler is freed (via devres), right?
> 
> To avoid getting the IRQ handler to be called when it can't access
> registers, we could do one of the below:
> *) Look for a condition in the IRQ handler and bail-out when we know
> we should not manage IRQs. Is using pm_runtime_enabled() sufficient,
> you think? Otherwise we need a driver specific flag, which should be
> set in ->remove().
> *) Don't use devm* when registering the IRQ handler.

That's true.

> 
> Yes, both options further contribute to making the driver code
> slightly more complicated, but if you want to solve the problem sooner
> than later, I think this is what you need to do. Yet, I think there is
> another option too, see below.
> 
>>
>> I may have missed considering things when describing the case 2 (which is
>> what is proposed by this patch) as I don't have the full picture behind the
>> dev_pm_domain_detach() call in platform bus remove. If so, please correct me.
> 
> The dev_pm_domain_attach|detach() calls in bus level code
> (probe/remove) were added there a long time ago, way before devres was
> being used like today.
> 
> Currently we also have devm_pm_domain_attach_list(), which is used
> when devices have multiple PM domains to attach too. This is *not*
> called by bus-level code, but by the driver themselves. For these
> cases, we would not encounter the problems you have been facing with
> clocks/IRQ-handler, I think - because the devres order is maintained
> for PM domains too.
> 
> That said, I think adding a devm_pm_domain_attach() interface would
> make perfect sense. Then we can try to replace
> dev_pm_domain_attach|detach() in bus level code, with just a call to
> devm_pm_domain_attach(). In this way, we should preserve the
> expectation for drivers around devres for PM domains. Even if it would
> change the behaviour for some drivers, it still sounds like the
> correct thing to do in my opinion.

This looks good to me, as well. I did prototype it on my side and tested on
all my failure cases and it works.

Thank you,
Claudiu

