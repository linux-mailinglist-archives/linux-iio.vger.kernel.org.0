Return-Path: <linux-iio+bounces-19710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F347ABC42C
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 18:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC73A5E5B
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4728A3F5;
	Mon, 19 May 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTUaQ6km"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A228A1FB;
	Mon, 19 May 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671188; cv=none; b=EW+N4wKB+jF1aLvGrd2zvZ4lhNzZuGqCwEKNR/77vlg2U5pfbRUjdrIGwjWCuqFM6iuhflGLR81XAVd5M7tR85lDATMiieRRHlw15SxTIFId9CI5IJq+Uzmt6CATZIuB0xJIr/XB1TMCpieFX7iDTKCBROZnxQkJr9tY9y7nPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671188; c=relaxed/simple;
	bh=I25GKdckGm6SRRWIzsWVH6YhY7E1W5uRH4ISHEyoW4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulnRVNCePR5UODC9ybGVPFo4EciJj0BgSPVami3w6IDa9j4VcWuDDHtjwBUPBpHwbretNUDUB191VCUnbMqQMf77dPYHxb/tkY2td0q2HgN/rVd5viIkLmx5bo025+CoM6y4PWOpcrPrJiPaMBnNdaRh0a28NsK6I/bRSxu12qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTUaQ6km; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so4358599a12.2;
        Mon, 19 May 2025 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747671186; x=1748275986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3lBWJZoV3Qw4mHVfEIHrUWnP4z2/kxa2hL6fjEfCog=;
        b=BTUaQ6kmf2zP/WDXX6BvHOj7YR2VHwTOuOIACekNsdOPdNCqsgLraH+6aMn48Khzex
         XhEZazmpXhKITvFzZYHJApnwxZZUoNZ36BrWDCDA3DBfSrNg7qcCZu6X5LtdC1K9YyoB
         3mcokk4REen+NsEvZRX1/ajaxEgkD+rV+eVFP3b4sCOy9L87ij531KTcW5yz8Wup5u69
         CATFeFAbxj+l+9b/ebsLbSeP3iDo4gnjmlh8htAzBIyOQEwolGiyhb7N6H0PEOYdMjYH
         vQHMJ1QGQi4m2MdJ2jyEuZMfDv7BGA/SirxIX+G378A6pp6mhCOt9y5wh5UGASaBlI6l
         4bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671186; x=1748275986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3lBWJZoV3Qw4mHVfEIHrUWnP4z2/kxa2hL6fjEfCog=;
        b=uOYJbr3CZqC+JmgC06BJ9qiOlYKsFQ0t+IV9WxTz7tfJjlgLMuiGvnRrSgYbJOny82
         2e4hK9cgtOd6g5c9CuCLozUpODBorY8lxaWZhbt4EXBRR+ZNQyW0PfHUoUlNbPKpQrM/
         TU+G24BUVTlZsFvheweRf+RlQkXsu6+5xFTCHfMYVBx+K5CzPiR7gGdSsMB1CtwEIMFj
         wTDGxvT0HKLQjyLY05o6dAYHvbtZX5Gvn6V2KfhTZ8j9AtthF+wTevQIfGpeJEm0kkX9
         5cjkhzuM9D/wkZ3t5IOPyRyjjhE6qsAERoXqCX+QnNZuq/MLZbyTlmL4J1kvfe6vXMyQ
         aBFg==
X-Forwarded-Encrypted: i=1; AJvYcCWBuimsttB1ZuwbsQkt6MPegJMueYPQ0hz2vBRcL4Rq10zKRadT8V1vROeQDtIuL13A80NJ/rjeX7w=@vger.kernel.org, AJvYcCWUpoBP50tyO07gi2ddCdZk7laOCJeig0HJR5hTkAvPjUGJ2kO/KGk7lxEeRFEoLWxQMANDbWOIp9Q=@vger.kernel.org, AJvYcCWatFcvnucqaCAmr4OPZD4HvoUZo0cHr2oFUL7gz5NsoxF0G7ZthMdo2MA4JYKMCv0b7Oy4s4rX9vWdAu06@vger.kernel.org, AJvYcCWuEOwEvF8cNf8fs03jo10y6DRYLsWcU6IY4JbZnQioj57rnNDRjpy6fUCafaxWuidHOyv9h05WuiLSXPw/Mv7nCRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3lSvcfFPtNYjLuB5ZQFgnXsmD8JHWL472nPII/6Cc8eel/Zk
	lbxkfs65iqYmGDFfrShufpwMfkSBlmhKr+KNvqYzbKu6HF0yctxe5mz/
X-Gm-Gg: ASbGncu03VlSQKoXUDJ/xwsLhDTVuKfItVC6OMPozPCyR4Neu5jMJDQTSK/DhR8RLd2
	dIu+vvczUdzAG1L2Uw6/ABm6gbinFWLr59CRHrdQhNL+5RjTsDjMLIy4SN9ZE68fb37qMqFq/Eg
	z7lPC84TdJye09emO4c+/V9xH/7Rh9ywfpxQsr+hAnQb573jP5OqtF7Wek+5rvcY9Byp4c+Lvxh
	ht9B4Yy535ziIPOOi3c2YMe0FlYXkB2jirJqn7KezBkrz0lkqZhf8FtPOIRGUhfmQI4xLW9G7Fi
	kGoBlm/UB8MvCwOop1OT6bVP6suj7JOityc+11Uk+TCWp/rYxQ==
X-Google-Smtp-Source: AGHT+IE9Jpvdcj1VkVVyTLdi2qS3RsqeE/2xMS6bUF6GKIu/XOwiOtyks5a27y96IOjsocz7oQ0EXQ==
X-Received: by 2002:a05:6a20:7353:b0:215:ead1:b867 with SMTP id adf61e73a8af0-216218c3e42mr21699534637.14.1747671185568;
        Mon, 19 May 2025 09:13:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e134:a6aa:27:6156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm6400551a12.23.2025.05.19.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:13:04 -0700 (PDT)
Date: Mon, 19 May 2025 09:13:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
References: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei>
 <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>

Hi Ulf,

On Mon, May 19, 2025 at 05:02:05PM +0200, Ulf Hansson wrote:
> On Fri, 9 May 2025 at 16:12, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >
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
> 
> Okay.

This is not the root of the problem though. There is nothing really
special about power domain and runtime power management. The root of the
problem is that current code violates the order of releasing resources
by mixing devm- and normal resource management together. Usually it is
individual driver's fault, but in this case it is bus code that uses the
manual release (dev_om_domain_detach) that violates the "release in
opposite order to acquisition" rule.

> 
> >
> > On the platform I experienced issues with, the dev_pm_domain_detach() drops
> > the clocks from the device power domain and any subsequent PM runtime
> > resume calls (that may happen in the devres cleanup phase) have no effect
> > on enabling the clocks. If driver has functions registered (e.g. through
> > devm_add_action_or_reset()), or driver specific runtime PM functions that
> > access directly registers in the devres cleanup phase this leads to system
> > aborts.
> 
> So if you move away from using devm_pm_runtime_enable() things would
> be easier to manage and there is no additional new devres-management
> needed.

How exactly will it improve the situation? You still need to make sure
that you are not disabling things out of the order. You simply moving
the complexity to the driver, essentially forbidding it (and any other
driver on platform bus) from using any devm APIs. 

> 
> >
> >
> > >
> > > As I have tried to argue before, I think devm_pm_runtime_enable()
> > > should *not* be used. Not here, not at all. Runtime PM isn't like any
> > > other resources that we fetch/release. Instead, it's a behaviour that
> > > you turn on and off, which needs to be managed more carefully, rather
> > > than relying on fetch/release ordering from devres.

I disagree. It is a resource that you turn on and off, same as clocks,
regulators, interrupts, etc. We manage those during lifetime of the
device, disable them when going into low power mode/suspend, reenable
them upon resume, may disable and reenable them for other reasons.

PM is not any more special here. As long as you keep the proper order of
operations it works as well.

> > >
> > > That said, I would convert the driver to use pm_runtime_enable() and
> > > pm_runtime_disable() instead.
> >
> > I've tried this approach previously but it resulted in more complicated
> > code and thus, Jonathan wasn't happy with it [1].
> 
> I understand that you have been trying to move forward to address
> people's opinions. It's not always easy to keep everybody happy. :-)
> 
> That said, I still think this is the most viable option as it's how
> the vast majority of drivers do it today. A few lines of additional
> code shouldn't really be a big problem in my opinion.

Have you tried making such change? Again, you will need to abandon use
of most other devm APIs so that you keep the order of releasing
resources. The only devm that you can still use is devm_k*alloc(), the
rest has to be converted into unmanaged.

Thanks.

-- 
Dmitry

