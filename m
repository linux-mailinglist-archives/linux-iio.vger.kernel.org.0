Return-Path: <linux-iio+bounces-16421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29504A50147
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFC03AA45B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349724A050;
	Wed,  5 Mar 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/ZYHIog"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A033C9;
	Wed,  5 Mar 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183405; cv=none; b=XRW0rEF6PGrOkEeJnJ5ixuGbzkUtZdsnT3NR5wnaGPS5gWDtGwMfkL9aOF33CJW9QmBYBmyioi9lxLV1ocjhnYJcp/uwyYw+zj2GJNvjCpepFm3GLMrJk/dwFTOQETqMJSH3ZxnEF7FCpxwkdGFnwA+YuOede63dosbzG7T8EC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183405; c=relaxed/simple;
	bh=degM1ilBkxGMxnY06GEy2rlEgKGpr79Xcavi569inws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrbJ+JzwHGXoQy1bWWALoGEYawcFE/rraWaUnrAROpKzll0WjFr2lNYT0GmMi9roHShJm704Qc493Xpt+CtyYMXxn05b6ZVCYTxFZGu6CPJRKo/5ntqTte1kqaZihCkL6SHgPTJJAlYdLM/PX6hgk64NFl1+FdW1NF5QAV7i6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/ZYHIog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA87C4CED1;
	Wed,  5 Mar 2025 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741183405;
	bh=degM1ilBkxGMxnY06GEy2rlEgKGpr79Xcavi569inws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/ZYHIogC8FLJEDR3mKyn77xcKFyuo+jvktPp+nAX6YQ2yUf3aTR75K9mo8tlX9PY
	 4yy1M8DaROc8xTJX1ZfxTKnN0irPwky428nivT0SqYGy/H1PQDZnws+drq07qZ5hz7
	 Rb55tv8yh97pB4EuSly1iCJXHGm/dqyAXcsN7DB3+Ft5uDAV/k8mhe9wQ0Z2bXFZV3
	 +WMITPVF/Se7zJe0e516SpPnLId9BfSBMU5oPJLVRvu1AJTAmHRq7+F1cPKv1kwDks
	 E7UV7cP4KjaUUlvYAqVY+KkTIsU7nE7uDeCWk0M4b485yibadM/MghWFOmo9vgRIzW
	 rurHGrv04jGqQ==
Date: Wed, 5 Mar 2025 14:03:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
 dakr@kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <20250305140309.744866b2@jic23-huawei>
In-Reply-To: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
	<2025021539-untrained-prompter-a48f@gregkh>
	<4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
	<8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 14:45:07 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Daniel, Jonathan,
> 
> On 15.02.2025 15:51, Claudiu Beznea wrote:
> > Hi, Greg,
> > 
> > On 15.02.2025 15:25, Greg KH wrote:  
> >> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:  
> >>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
> >>> clocks are managed through PM domains. These PM domains, registered on
> >>> behalf of the clock controller driver, are configured with
> >>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> >>> clocks are enabled/disabled using runtime PM APIs. The power domains may
> >>> also have power_on/power_off support implemented. After the device PM
> >>> domain is powered off any CPU accesses to these domains leads to system
> >>> aborts.
> >>>
> >>> During probe, devices are attached to the PM domain controlling their
> >>> clocks and power. Similarly, during removal, devices are detached from the
> >>> PM domain.
> >>>
> >>> The detachment call stack is as follows:
> >>>
> >>> device_driver_detach() ->
> >>>   device_release_driver_internal() ->
> >>>     __device_release_driver() ->
> >>>       device_remove() ->
> >>>         platform_remove() ->
> >>> 	  dev_pm_domain_detach()
> >>>
> >>> During driver unbind, after the device is detached from its PM domain,
> >>> the device_unbind_cleanup() function is called, which subsequently invokes
> >>> devres_release_all(). This function handles devres resource cleanup.
> >>>
> >>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
> >>> cleanup process triggers the action or reset function for disabling runtime
> >>> PM. This function is pm_runtime_disable_action(), which leads to the
> >>> following call stack of interest when called:
> >>>
> >>> pm_runtime_disable_action() ->
> >>>   pm_runtime_dont_use_autosuspend() ->
> >>>     __pm_runtime_use_autosuspend() ->
> >>>       update_autosuspend() ->
> >>>         rpm_idle()
> >>>
> >>> The rpm_idle() function attempts to resume the device at runtime. However,
> >>> at the point it is called, the device is no longer part of a PM domain
> >>> (which manages clocks and power states). If the driver implements its own
> >>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
> >>> driver - while also relying on the power domain subsystem for power
> >>> management, rpm_idle() will invoke the driver's runtime PM API. However,
> >>> since the device is no longer part of a PM domain at this point, the PM
> >>> domain's runtime PM APIs will not be called. This leads to system aborts on
> >>> Renesas SoCs.
> >>>
> >>> Another identified case is when a subsystem performs various cleanups
> >>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
> >>> A known example is the thermal subsystem, which may call driver-specific
> >>> APIs to disable the thermal device. The relevant call stack in this case
> >>> is:
> >>>
> >>> device_driver_detach() ->
> >>>   device_release_driver_internal() ->
> >>>     device_unbind_cleanup() ->
> >>>       devres_release_all() ->
> >>>         devm_thermal_of_zone_release() ->
> >>> 	  thermal_zone_device_disable() ->
> >>> 	    thermal_zone_device_set_mode() ->
> >>> 	      struct thermal_zone_device_ops::change_mode()
> >>>
> >>> At the moment the driver-specific change_mode() API is called, the device
> >>> is no longer part of its PM domain. Accessing its registers without proper
> >>> power management leads to system aborts.
> >>>
> >>> Open a devres group before calling the driver probe, and close it
> >>> immediately after the driver remove function is called and before
> >>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
> >>> reset functions are executed immediately after the driver remove function
> >>> completes. Additionally, it prevents driver-specific runtime PM APIs from
> >>> being called when the device is no longer part of its power domain.
> >>>
> >>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>> ---
> >>>
> >>> Hi,

Hi Claudiu, Greg,

Sorry, I missed this thread whilst travelling and only saw it because
of reference from the in driver solution.

> >>>
> >>> Although Ulf gave its green light for the approaches on both IIO [1],
> >>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
> >>> approaches in [1], [2] as he considered it may lead to dificult to
> >>> maintain code and code opened to subtle bugs (due to the potential of
> >>> mixing devres and non-devres calls). He pointed out a similar approach
> >>> that was done for the I2C bus [4], [5].
> >>>
> >>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
> >>> patch tries to revive it by proposing a similar approach that was done
> >>> for the I2C bus.
> >>>
> >>> Please let me know you input.  
> >>
> >> I'm with Jonathan here, the devres stuff is getting crazy here and you
> >> have drivers mixing them and side affects happening and lots of
> >> confusion.  Your change here is only going to make it even more
> >> confusing, and shouldn't actually solve it for other busses (i.e. what
> >> about iio devices NOT on the platform bus?)  

In some cases they are already carrying the support as per the link
above covering all i2c drivers.  I'd like to see a generic solution and
I suspect pushing it to the device drivers rather than the bus code
will explode badly and leave us with subtle bugs where people don't
realise it is necessary. 

https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
is a lot nastier looking than what we have here. I'll review that in a minute
to show that it need not be that bad, but none the less not pleasant.

+CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
similar)

> > 
> > You're right, other busses will still have this problem.
> >   
> >>
> >> Why can't your individual driver handle this instead?  

In my mind because it's the bus code that is doing the unexpected part by
making calls in the remove path that are effectively not in the same order
as probe because they occur between driver remove and related devres cleanup
for stuff registered in probe.

> > 
> > Initially I tried it at the driver level by using non-devres PM runtime
> > enable API but wasn't considered OK by all parties.
> > 
> > I haven't thought about having devres_open_group()/devres_close_group() in
> > the driver itself but it should work.  
> 
> Are you OK with having the devres_open_group()/devres_close_group() in the
> currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
> proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?

I guess it may be the best of a bunch of not particularly nasty solutions...

Jonathan

> 
> Thank you,
> Claudiu
> 
> [1]
> https://lore.kernel.org/all/20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com
> 
> > 
> > Thank you,
> > Claudiu
> >   
> >>
> >> thanks,
> >>
> >> greg k-h  
> >   
> 


