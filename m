Return-Path: <linux-iio+bounces-19711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB34ABC463
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630203AA2FF
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB8288C1C;
	Mon, 19 May 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMAy2KzO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39947286D7D;
	Mon, 19 May 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671627; cv=none; b=j6DK2c4UUSOO1cTlY712mcH8L81ULYRvyhB+DMsuo6DtG1UtB/IMbRdiziFZxyqpvlNq8LtPDNaRDLTLgL5cAD3AHxuqhqi6wS/eacO8gLClMfa349vzcODQ7ckH5/xhJjCVmiTRrhoN9TnxoG9uFOcCplyWbJeSqBAuUyrfIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671627; c=relaxed/simple;
	bh=fUpRrAMNeLqbHeFINGn8j0poE1LRhoQDokB/Bhr7IKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+hHAw7OvMFhFNZfBnDmQXtHC25bNF5d5SRnzNw8tprnyO7SK0RRPrfU3Kb9hW3MPh+QPwZQ4aRgKB30BFSYewsdnDBoXiXy1mzjCFeISrbL/Ujpxl3vyaDblBI1QNujjDHQkoNsb6Kk/HlpBDfbQDZilq6jKydP0xP/r5qFwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMAy2KzO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4511554b3a.2;
        Mon, 19 May 2025 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747671624; x=1748276424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXyF2LazM+eL6bDj3Bw72r35FZhzkjTxLMkJtuC+zas=;
        b=KMAy2KzOLHstDGeVZQpEq1VTJg54vQDPHU6Ih2U4+EivgrEo4vdyo//LENr2UGOEUx
         /2cU6ixd7Jj66dv2zWctU7ETQwcKwJb+TjuScwAaIeCKWAhBnoU/U6+JliDRoGr8hBlU
         +Js7qC/c3gye/gLZzBGz6u/NGAkt8GNHuW/t+BABvi6tec/DSP1FF/lmjMYKwhEXF9u2
         naOwH0iYXhUdIyE5p2HINnwKz2bZpMgpS9TvrzxNCDUlsZ07omwuNMUUOC3CpS0y/gLc
         D6QnnlXPdg9Z77jYVVFswK0+/oFig+OduoZR6q8CVTlG7sv/zA+6rxqaqxyvnXulWhJW
         9itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671624; x=1748276424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXyF2LazM+eL6bDj3Bw72r35FZhzkjTxLMkJtuC+zas=;
        b=rkkzC3CSjJYjNP7X+3SF96jL3+l9967e8leuYYqZloPsImiq7RE1nLdTi5h3vdvJXB
         hIVM85Vd4XzsoKSJ/LV7orB0laMq+KpP4Oh+ivGPdklyIYrpGGD2sSLX9BybfkV8xrpJ
         xmCVAZ0nLWzeRYvaQIXVlIaRxraW7Xy+LOqkEbQmLQ/15SXgLoVoDHY9MOdQF4JuR4U3
         T2EnDf8cgaCU9Tk0EJkLHvmAYdbrUpMEDQYTNiJWR3eeZlYWfnafGLLvD6d2zMdWLoPu
         rTY7fQqCoSraTgXarVdrtinUpSEYb1gpuLOW97rXr1xJXBkiIEywl6Fop2u+PEH5X1rW
         emFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU08jYjpPKJVZGKSz2R1d2xpfYMOFop6w6R+2uRvdLHyxvaBjvjX4ShY2dIDFwx2MvYSHiurhVV9mA=@vger.kernel.org, AJvYcCUF65KHbOLsAwMBTRETSiclQ0gyuInxYLhoQ9e5+j8nWeVev6k9PAIbTIEtVJLG3JLtTdOH7rYnoL4=@vger.kernel.org, AJvYcCVnd3RIZg69nrBWgoHfgV/W5YgWgKe51wudac2rtteb1KCxq1kJdPZnKK/zqobVWt/7frg2sxGM6Zbm9qV9EDtdz1w=@vger.kernel.org, AJvYcCWeSxxmLd9MHyA5sR/hNQnBJEpSnEK6yhy0AUpo3Q89gA3dLKjJayMDevHHwlcjKYXywvvfGCoX1pCrr7nJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxI89WmOhRlM3qUCpoXW24ZbdA2Q/9xOWRdhQ4bajLv3axU7A8e
	p4298N6ypN11NY+hnEW6yQQXhtwpHpYu5KzPNpZ3uHcgd7uml1kw9eoh
X-Gm-Gg: ASbGncvUM/9JGhS5c9O7rUZw/0Gf372Ux4XNjrzKEWS3CLtIKC18xzOlGu5/sQEyzb5
	eavuGRzzGGhLahdNJAMrjuvVOnzY7snuuiWduXlKT8GmGX5C0zEhu1HvMTa29isi3CzyPNHVgQM
	rHHeXSjpYWeKFXpJyUvZ86Rkc7ndCzihpxCMMof6eqE2F0o5Mur+LqudBGAQODwnrHT36cqKk7B
	5tcrgvsyyWoQw9Ejnv/X7BVRu+J5uhnCNAtX7arL9pCnBIPIwY67hATTJGfVSIEo9ee/BSEjWZi
	AMpppuVY4xp6ymA2HDaVuxYowr4bVayOSP4Zpb2iCL2cG7Cbgg==
X-Google-Smtp-Source: AGHT+IHSBGX4Y5M8NtDAplQHx8qiKYGxdS+9tGHmNjifEPJfPQ6Ut6UyXm7sDnsyCe4mbsxwAvckdg==
X-Received: by 2002:a05:6a00:a88f:b0:73e:1e24:5a4e with SMTP id d2e1a72fcca58-742acd734fdmr20641543b3a.24.1747671624114;
        Mon, 19 May 2025 09:20:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e134:a6aa:27:6156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de0d9sm6437649b3a.32.2025.05.19.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:20:23 -0700 (PDT)
Date: Mon, 19 May 2025 09:20:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <6r7n73kdi4xjqkw7tavjnw3xavwciimt7tb3buidh7os2xif3m@sded6wz4rjx5>
References: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei>
 <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <20250511120157.30e2ca7b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511120157.30e2ca7b@jic23-huawei>

On Sun, May 11, 2025 at 12:01:57PM +0100, Jonathan Cameron wrote:
> Rafael,
> 
> Sorry for top posting but this issue needs your input.
> 
> 
> On Fri, 9 May 2025 17:12:19 +0300
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
> > Hi, Ulf,
> > 
> > Thank you for your input!
> > 
> > On 09.05.2025 16:07, Ulf Hansson wrote:
> > > On Fri, 9 May 2025 at 13:51, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:  
> > >>
> > >> Hi, Rafael, Ulf, PM list,
> > >>
> > >>
> > >> On 09.04.2025 19:12, Claudiu Beznea wrote:  
> > >>> Hi, Rafael,
> > >>>
> > >>> On 30.03.2025 18:31, Jonathan Cameron wrote:  
> > >>>> On Thu, 27 Mar 2025 18:47:53 +0200
> > >>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >>>>  
> > >>>>> Hi, Rafael,
> > >>>>>
> > >>>>> On 06.03.2025 08:11, Dmitry Torokhov wrote:  
> > >>>>>> On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:  
> > >>>>>>> On Wed, 19 Feb 2025 14:45:07 +0200
> > >>>>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >>>>>>>  
> > >>>>>>>> Hi, Daniel, Jonathan,
> > >>>>>>>>
> > >>>>>>>> On 15.02.2025 15:51, Claudiu Beznea wrote:  
> > >>>>>>>>> Hi, Greg,
> > >>>>>>>>>
> > >>>>>>>>> On 15.02.2025 15:25, Greg KH wrote:  
> > >>>>>>>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:  
> > >>>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>>>>>>>>>
> > >>>>>>>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
> > >>>>>>>>>>> clocks are managed through PM domains. These PM domains, registered on
> > >>>>>>>>>>> behalf of the clock controller driver, are configured with
> > >>>>>>>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> > >>>>>>>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
> > >>>>>>>>>>> also have power_on/power_off support implemented. After the device PM
> > >>>>>>>>>>> domain is powered off any CPU accesses to these domains leads to system
> > >>>>>>>>>>> aborts.
> > >>>>>>>>>>>
> > >>>>>>>>>>> During probe, devices are attached to the PM domain controlling their
> > >>>>>>>>>>> clocks and power. Similarly, during removal, devices are detached from the
> > >>>>>>>>>>> PM domain.
> > >>>>>>>>>>>
> > >>>>>>>>>>> The detachment call stack is as follows:
> > >>>>>>>>>>>
> > >>>>>>>>>>> device_driver_detach() ->
> > >>>>>>>>>>>   device_release_driver_internal() ->
> > >>>>>>>>>>>     __device_release_driver() ->
> > >>>>>>>>>>>       device_remove() ->
> > >>>>>>>>>>>         platform_remove() ->
> > >>>>>>>>>>>         dev_pm_domain_detach()
> > >>>>>>>>>>>
> > >>>>>>>>>>> During driver unbind, after the device is detached from its PM domain,
> > >>>>>>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
> > >>>>>>>>>>> devres_release_all(). This function handles devres resource cleanup.
> > >>>>>>>>>>>
> > >>>>>>>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
> > >>>>>>>>>>> cleanup process triggers the action or reset function for disabling runtime
> > >>>>>>>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
> > >>>>>>>>>>> following call stack of interest when called:
> > >>>>>>>>>>>
> > >>>>>>>>>>> pm_runtime_disable_action() ->
> > >>>>>>>>>>>   pm_runtime_dont_use_autosuspend() ->
> > >>>>>>>>>>>     __pm_runtime_use_autosuspend() ->
> > >>>>>>>>>>>       update_autosuspend() ->
> > >>>>>>>>>>>         rpm_idle()
> > >>>>>>>>>>>
> > >>>>>>>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
> > >>>>>>>>>>> at the point it is called, the device is no longer part of a PM domain
> > >>>>>>>>>>> (which manages clocks and power states). If the driver implements its own
> > >>>>>>>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
> > >>>>>>>>>>> driver - while also relying on the power domain subsystem for power
> > >>>>>>>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
> > >>>>>>>>>>> since the device is no longer part of a PM domain at this point, the PM
> > >>>>>>>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
> > >>>>>>>>>>> Renesas SoCs.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Another identified case is when a subsystem performs various cleanups
> > >>>>>>>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
> > >>>>>>>>>>> A known example is the thermal subsystem, which may call driver-specific
> > >>>>>>>>>>> APIs to disable the thermal device. The relevant call stack in this case
> > >>>>>>>>>>> is:
> > >>>>>>>>>>>
> > >>>>>>>>>>> device_driver_detach() ->
> > >>>>>>>>>>>   device_release_driver_internal() ->
> > >>>>>>>>>>>     device_unbind_cleanup() ->
> > >>>>>>>>>>>       devres_release_all() ->
> > >>>>>>>>>>>         devm_thermal_of_zone_release() ->
> > >>>>>>>>>>>         thermal_zone_device_disable() ->
> > >>>>>>>>>>>           thermal_zone_device_set_mode() ->
> > >>>>>>>>>>>             struct thermal_zone_device_ops::change_mode()
> > >>>>>>>>>>>
> > >>>>>>>>>>> At the moment the driver-specific change_mode() API is called, the device
> > >>>>>>>>>>> is no longer part of its PM domain. Accessing its registers without proper
> > >>>>>>>>>>> power management leads to system aborts.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Open a devres group before calling the driver probe, and close it
> > >>>>>>>>>>> immediately after the driver remove function is called and before
> > >>>>>>>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
> > >>>>>>>>>>> reset functions are executed immediately after the driver remove function
> > >>>>>>>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
> > >>>>>>>>>>> being called when the device is no longer part of its power domain.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>>>>>>>>> ---
> > >>>>>>>>>>>
> > >>>>>>>>>>> Hi,  
> > >>>>>>>
> > >>>>>>> Hi Claudiu, Greg,
> > >>>>>>>
> > >>>>>>> Sorry, I missed this thread whilst travelling and only saw it because
> > >>>>>>> of reference from the in driver solution.
> > >>>>>>>  
> > >>>>>>>>>>>
> > >>>>>>>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
> > >>>>>>>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
> > >>>>>>>>>>> approaches in [1], [2] as he considered it may lead to dificult to
> > >>>>>>>>>>> maintain code and code opened to subtle bugs (due to the potential of
> > >>>>>>>>>>> mixing devres and non-devres calls). He pointed out a similar approach
> > >>>>>>>>>>> that was done for the I2C bus [4], [5].
> > >>>>>>>>>>>
> > >>>>>>>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
> > >>>>>>>>>>> patch tries to revive it by proposing a similar approach that was done
> > >>>>>>>>>>> for the I2C bus.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Please let me know you input.  
> > >>>>>>>>>>
> > >>>>>>>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
> > >>>>>>>>>> have drivers mixing them and side affects happening and lots of
> > >>>>>>>>>> confusion.  Your change here is only going to make it even more
> > >>>>>>>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
> > >>>>>>>>>> about iio devices NOT on the platform bus?)  
> > >>>>>>>
> > >>>>>>> In some cases they are already carrying the support as per the link
> > >>>>>>> above covering all i2c drivers.  I'd like to see a generic solution and
> > >>>>>>> I suspect pushing it to the device drivers rather than the bus code
> > >>>>>>> will explode badly and leave us with subtle bugs where people don't
> > >>>>>>> realise it is necessary.
> > >>>>>>>
> > >>>>>>> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
> > >>>>>>> is a lot nastier looking than what we have here. I'll review that in a minute
> > >>>>>>> to show that it need not be that bad, but none the less not pleasant.
> > >>>>>>>
> > >>>>>>> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
> > >>>>>>> similar)  
> > >>>>>>
> > >>>>>> We should not expect individual drivers handle this, because this is a
> > >>>>>> layering violation: they need to know implementation details of the bus
> > >>>>>> code to know if the bus is using non-devres managed resources, and
> > >>>>>> adjust their behavior. Moving this into driver core is also not
> > >>>>>> feasible, as not all buses need it. So IMO this should belong to
> > >>>>>> individual bus code.
> > >>>>>>
> > >>>>>> Instead of using devres group a bus may opt to use
> > >>>>>> devm_add_action_or_reset() and other devm APIs to make sure bus'
> > >>>>>> resource unwinding is carried in the correct order relative to freeing
> > >>>>>> driver-owned resources.  
> > >>>>>
> > >>>>> Can you please let us know your input on the approach proposed in this
> > >>>>> patch? Or if you would prefer devm_add_action_or_reset() as suggested by
> > >>>>> Dmitry? Or if you consider another approach would fit better?
> > >>>>>
> > >>>>> Currently there were issues identified with the rzg2l-adc driver (driver
> > >>>>> based solution proposed in [1]) and with the rzg3s thermal driver (solved
> > >>>>> by function rzg3s_thermal_probe() from [2]).
> > >>>>>
> > >>>>> As expressed previously by Jonathan and Dimitry this is a common problem
> > >>>>> and as the issue is due to a call in the bus driver, would be better and
> > >>>>> simpler to handle it in the bus driver. Otherwise, individual drivers would
> > >>>>> have to be adjusted in a similar way.
> > >>>>>  
> > >>>>
> > >>>> Rafael,
> > >>>>
> > >>>> Greg suggested we ask for your input on the right option:
> > >>>>
> > >>>> https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
> > >>>> (that thread has the other option).  
> > >>>
> > >>> Can you please let us know your opinion on this?  
> > >> Can you please let us know if you have any suggestions for this?  
> > > 
> > > It's been a while since I looked at this. Although as I understand it,
> > > the main issue comes from using devm_pm_runtime_enable().  
> > 
> > Yes, it comes from the usage of devm_pm_runtime_enable() in drivers and the
> > dev_pm_domain_detach() call in platform_remove() right after calling
> > driver's remove function.
> > 
> > On the platform I experienced issues with, the dev_pm_domain_detach() drops
> > the clocks from the device power domain and any subsequent PM runtime
> > resume calls (that may happen in the devres cleanup phase) have no effect
> > on enabling the clocks. If driver has functions registered (e.g. through
> > devm_add_action_or_reset()), or driver specific runtime PM functions that
> > access directly registers in the devres cleanup phase this leads to system
> > aborts.
> > 
> > 
> > > 
> > > As I have tried to argue before, I think devm_pm_runtime_enable()
> > > should *not* be used. Not here, not at all. Runtime PM isn't like any
> > > other resources that we fetch/release. Instead, it's a behaviour that
> > > you turn on and off, which needs to be managed more carefully, rather
> > > than relying on fetch/release ordering from devres.
> > > 
> > > That said, I would convert the driver to use pm_runtime_enable() and
> > > pm_runtime_disable() instead.  
> > 
> > I've tried this approach previously but it resulted in more complicated
> > code and thus, Jonathan wasn't happy with it [1].
> 
> Yes. I (and others as per the various threads) fundamentally disagree that
> runtime pm is special (in this aspect - it's special in many other good
> ways).
> 
> In the common, simple use case for runtime PM at the point or probe and
> remove it is exactly like any other resource that we enable then disable.
> What happens between those stages isn't particularly relevant here. We
> have other resources also go through state changes between probe and
> remove and those sequences are easy to manage.  Where more complex
> management is necessary then indeed not using this call is of course the
> way to go. Those just aren't the common cases I see.
> 
> Removing this call adds considerable potential code complexity to many
> drivers which may be trivially solved through the approaches that have
> been suggested and have been in use for some time on several bus types.
> 
> That code complexity has nothing to with this call at all but to do with
> needing to drop lots of other devm management because of the potential
> for races that any mix and match of devm and other entails.
> 
> I'd approximate that every time we stop using devm_pm_runtime_enable()
> we add 10-20 lines of code that is just there because that call can't
> be used. That code will come with a review burden and related bugs and
> potentially applies in 100-1000s of drivers.
> 
> Fundamentally we need a clear statement on which way to go from Rafael
> and either to proceed with a common solution across all buses that encounter
> this issue, or rip out the existing uses in other buses. (or a 3rd way?)
> Mix and match depending on bus type is not a sensible way to proceed.
> 
> > 
> > Another approach I've tried was to have devres group opened/closed in the
> > driver itself [2], [3] but it was postponed as this approach may have a chance.
> 
> The in driver approach is unfortunately a sticking plaster, working around
> it in each driver.  Maybe that's the best we can do.  Pushing the burden
> of infrastructure a driver can't see (because is in the bus layer) down
> to drivers is messy at best and most like a source of future bugs.
> Removing a specific devm_ helper doesn't stop people rolling their own with
> no awareness of this weird subtlety.
> 
> More fundamentally I don't personally think a bus driver should ever
> be doing things that in it's own probe and remove that can result in races
> wrt to devm handling in the drivers.  We should not be making driver writers
> jobs hard.  The solutions Dmitry used for other buses resolve that in a more
> general fashion, at the point where we know if it is necessary (next to
> the bus driver calls that are at issue) so to me look like a good way to go.
> (this is one of the approaches Claudiu has posted for platform devices).

We should stop thinking about this as a particular problem with
devm_pm_runtime_enable(). Any non-trivial bus probe()/remove() code
(going beyond simply calling driver's probe and remove) will run into
this problem. In HID we had an issue with bus core closing the
underlying transport device and releasing transfer buffers (memory
buffers) too early, before the driver had a chance to clean up properly,
resulting in UAF.

Thanks.

-- 
Dmitry

