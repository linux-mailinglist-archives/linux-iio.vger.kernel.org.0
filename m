Return-Path: <linux-iio+bounces-17347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8639A75AA1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B98188805B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C531D6DDA;
	Sun, 30 Mar 2025 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaQMAsEA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39001CCEE0;
	Sun, 30 Mar 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743348697; cv=none; b=BB/Ou7aSUTHS0zcBxikZcHcyCDOCVN6ohwdJcKNBufdOncf3p79i/glWyQviyoKMkEV6dLOvnNI4SaRM6Tnl8XE6CaAG110vFkzLNlLZYRSADFoRF71O85+BDrBQDSSxXk+S89rT2PFiTwKUNzaEBhX6EhZj7Chf6UlPlIVGtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743348697; c=relaxed/simple;
	bh=g03jbp7OLEUrX+3q+HBShOudsI/sqirZ7xduEGn4uwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM4rH8KKpCpJLRB0syL4UWua5ABjdrISpq9255BiXBdH38nHFKZc+VE6tVAV49bxXlSnAUR0OjX2ZmiCiYghBD/Tdu4y7fDie7LeoSZcAKms2j+uBjHfi0R1uh2JARMcNlU+d31TWjZymYxAIM+ewe1cbm6A4m0yzI2glMG3zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaQMAsEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A37C4CEDD;
	Sun, 30 Mar 2025 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743348696;
	bh=g03jbp7OLEUrX+3q+HBShOudsI/sqirZ7xduEGn4uwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RaQMAsEANQJE1E0lLZFqRb7fBMKW2Dbj08NpeIQGIwdwto091KuzldHN9f4u6C1o8
	 2MDzPcloVnvIX+mYH3jaif6lLQKTwdQcYYNnCTLJgPQD4phbSLfzMaZWW9alUy/hK7
	 h5lvxVbc+4ZiP8/4VSilzZ5x3NR9EBT/XSYQPbdj6/CVSmBv0nB5ngoPrhPDAs2AAe
	 4f1lUlVRE91iXB9aBWCdzJ+rbxUGKHfR015ViJaAXMvf9zMWsyZh/FjHxYoZJgyPPA
	 MmJjI0i4eovEACeOgcERV2+BVzdJpsn1ZLMOmTmSQGEwjjZTP0kjMxrdDyau/ZiBrG
	 oIFULPvVp03FQ==
Date: Sun, 30 Mar 2025 16:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <20250330163129.02f24afb@jic23-huawei>
In-Reply-To: <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
	<2025021539-untrained-prompter-a48f@gregkh>
	<4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
	<8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
	<20250305140309.744866b2@jic23-huawei>
	<Z8k8lDxA53gUJa0n@google.com>
	<f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 18:47:53 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Rafael,
> 
> On 06.03.2025 08:11, Dmitry Torokhov wrote:
> > On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:  
> >> On Wed, 19 Feb 2025 14:45:07 +0200
> >> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >>  
> >>> Hi, Daniel, Jonathan,
> >>>
> >>> On 15.02.2025 15:51, Claudiu Beznea wrote:  
> >>>> Hi, Greg,
> >>>>
> >>>> On 15.02.2025 15:25, Greg KH wrote:    
> >>>>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:    
> >>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>>
> >>>>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
> >>>>>> clocks are managed through PM domains. These PM domains, registered on
> >>>>>> behalf of the clock controller driver, are configured with
> >>>>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> >>>>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
> >>>>>> also have power_on/power_off support implemented. After the device PM
> >>>>>> domain is powered off any CPU accesses to these domains leads to system
> >>>>>> aborts.
> >>>>>>
> >>>>>> During probe, devices are attached to the PM domain controlling their
> >>>>>> clocks and power. Similarly, during removal, devices are detached from the
> >>>>>> PM domain.
> >>>>>>
> >>>>>> The detachment call stack is as follows:
> >>>>>>
> >>>>>> device_driver_detach() ->
> >>>>>>   device_release_driver_internal() ->
> >>>>>>     __device_release_driver() ->
> >>>>>>       device_remove() ->
> >>>>>>         platform_remove() ->
> >>>>>> 	  dev_pm_domain_detach()
> >>>>>>
> >>>>>> During driver unbind, after the device is detached from its PM domain,
> >>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
> >>>>>> devres_release_all(). This function handles devres resource cleanup.
> >>>>>>
> >>>>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
> >>>>>> cleanup process triggers the action or reset function for disabling runtime
> >>>>>> PM. This function is pm_runtime_disable_action(), which leads to the
> >>>>>> following call stack of interest when called:
> >>>>>>
> >>>>>> pm_runtime_disable_action() ->
> >>>>>>   pm_runtime_dont_use_autosuspend() ->
> >>>>>>     __pm_runtime_use_autosuspend() ->
> >>>>>>       update_autosuspend() ->
> >>>>>>         rpm_idle()
> >>>>>>
> >>>>>> The rpm_idle() function attempts to resume the device at runtime. However,
> >>>>>> at the point it is called, the device is no longer part of a PM domain
> >>>>>> (which manages clocks and power states). If the driver implements its own
> >>>>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
> >>>>>> driver - while also relying on the power domain subsystem for power
> >>>>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
> >>>>>> since the device is no longer part of a PM domain at this point, the PM
> >>>>>> domain's runtime PM APIs will not be called. This leads to system aborts on
> >>>>>> Renesas SoCs.
> >>>>>>
> >>>>>> Another identified case is when a subsystem performs various cleanups
> >>>>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
> >>>>>> A known example is the thermal subsystem, which may call driver-specific
> >>>>>> APIs to disable the thermal device. The relevant call stack in this case
> >>>>>> is:
> >>>>>>
> >>>>>> device_driver_detach() ->
> >>>>>>   device_release_driver_internal() ->
> >>>>>>     device_unbind_cleanup() ->
> >>>>>>       devres_release_all() ->
> >>>>>>         devm_thermal_of_zone_release() ->
> >>>>>> 	  thermal_zone_device_disable() ->
> >>>>>> 	    thermal_zone_device_set_mode() ->
> >>>>>> 	      struct thermal_zone_device_ops::change_mode()
> >>>>>>
> >>>>>> At the moment the driver-specific change_mode() API is called, the device
> >>>>>> is no longer part of its PM domain. Accessing its registers without proper
> >>>>>> power management leads to system aborts.
> >>>>>>
> >>>>>> Open a devres group before calling the driver probe, and close it
> >>>>>> immediately after the driver remove function is called and before
> >>>>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
> >>>>>> reset functions are executed immediately after the driver remove function
> >>>>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
> >>>>>> being called when the device is no longer part of its power domain.
> >>>>>>
> >>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Hi,  
> >>
> >> Hi Claudiu, Greg,
> >>
> >> Sorry, I missed this thread whilst travelling and only saw it because
> >> of reference from the in driver solution.
> >>  
> >>>>>>
> >>>>>> Although Ulf gave its green light for the approaches on both IIO [1],
> >>>>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
> >>>>>> approaches in [1], [2] as he considered it may lead to dificult to
> >>>>>> maintain code and code opened to subtle bugs (due to the potential of
> >>>>>> mixing devres and non-devres calls). He pointed out a similar approach
> >>>>>> that was done for the I2C bus [4], [5].
> >>>>>>
> >>>>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
> >>>>>> patch tries to revive it by proposing a similar approach that was done
> >>>>>> for the I2C bus.
> >>>>>>
> >>>>>> Please let me know you input.    
> >>>>>
> >>>>> I'm with Jonathan here, the devres stuff is getting crazy here and you
> >>>>> have drivers mixing them and side affects happening and lots of
> >>>>> confusion.  Your change here is only going to make it even more
> >>>>> confusing, and shouldn't actually solve it for other busses (i.e. what
> >>>>> about iio devices NOT on the platform bus?)    
> >>
> >> In some cases they are already carrying the support as per the link
> >> above covering all i2c drivers.  I'd like to see a generic solution and
> >> I suspect pushing it to the device drivers rather than the bus code
> >> will explode badly and leave us with subtle bugs where people don't
> >> realise it is necessary. 
> >>
> >> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
> >> is a lot nastier looking than what we have here. I'll review that in a minute
> >> to show that it need not be that bad, but none the less not pleasant.
> >>
> >> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
> >> similar)  
> > 
> > We should not expect individual drivers handle this, because this is a
> > layering violation: they need to know implementation details of the bus
> > code to know if the bus is using non-devres managed resources, and
> > adjust their behavior. Moving this into driver core is also not
> > feasible, as not all buses need it. So IMO this should belong to
> > individual bus code.
> > 
> > Instead of using devres group a bus may opt to use
> > devm_add_action_or_reset() and other devm APIs to make sure bus'
> > resource unwinding is carried in the correct order relative to freeing
> > driver-owned resources.  
> 
> Can you please let us know your input on the approach proposed in this
> patch? Or if you would prefer devm_add_action_or_reset() as suggested by
> Dmitry? Or if you consider another approach would fit better?
> 
> Currently there were issues identified with the rzg2l-adc driver (driver
> based solution proposed in [1]) and with the rzg3s thermal driver (solved
> by function rzg3s_thermal_probe() from [2]).
> 
> As expressed previously by Jonathan and Dimitry this is a common problem
> and as the issue is due to a call in the bus driver, would be better and
> simpler to handle it in the bus driver. Otherwise, individual drivers would
> have to be adjusted in a similar way.
> 

Rafael,

Greg suggested we ask for your input on the right option:

https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
(that thread has the other option).

Jonathan

> Thank you,
> Claudiu
> 
> [1]
> https://lore.kernel.org/all/20250324122627.32336-2-claudiu.beznea.uj@bp.renesas.com/
> [2]
> https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/
> 
> >   
> >>  
> >>>>
> >>>> You're right, other busses will still have this problem.
> >>>>     
> >>>>>
> >>>>> Why can't your individual driver handle this instead?    
> >>
> >> In my mind because it's the bus code that is doing the unexpected part by
> >> making calls in the remove path that are effectively not in the same order
> >> as probe because they occur between driver remove and related devres cleanup
> >> for stuff registered in probe.
> >>  
> >>>>
> >>>> Initially I tried it at the driver level by using non-devres PM runtime
> >>>> enable API but wasn't considered OK by all parties.
> >>>>
> >>>> I haven't thought about having devres_open_group()/devres_close_group() in
> >>>> the driver itself but it should work.    
> >>>
> >>> Are you OK with having the devres_open_group()/devres_close_group() in the
> >>> currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
> >>> proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?  
> >>
> >> I guess it may be the best of a bunch of not particularly nasty solutions...  
> > 
> > We need to update _ALL_ platform drivers using devm then, and this is
> > clearly not scalable.
> > 
> > Thanks.
> >   
> 


