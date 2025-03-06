Return-Path: <linux-iio+bounces-16453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9BA54296
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F00C18921E3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0261A00F0;
	Thu,  6 Mar 2025 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP9aphnF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AC199E88;
	Thu,  6 Mar 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241499; cv=none; b=MiR8jbCdS0wBnOD8HCnHhFMu1/P8g9pwXaUVBDW3DOELJMuPxcGWUXrJLJ042p8Qn+Q4oZztNafwf1sDmiYQd0NBMekmaTD5GSIfmOFlfjcOxAQKhQ0a/xx0lu7Xrek0rr7a81BcXu6rjYA+C6gTPL8sqaZjw8eBeCFuhnCE6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241499; c=relaxed/simple;
	bh=ei1+/3pNAoKCfDids2GIkiEwFfJgQrBzJx/gdVvtS+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBoMG1hWNfhmT9VW2EO4bgF5hFWMK87PxYHzFU700eKP4/Jie+aClgurzcC5DHfF2L5VhPewJBoLy7sX1R2fB6cBmqhZ5Sq8vpLclqMnkKvPH3B6oSNRpzBYWT9fnp6YuTd9xEzYRlCiQ0uWgemfcifL8ajgoOAQOXoLb3Ls6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP9aphnF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso472439a91.1;
        Wed, 05 Mar 2025 22:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741241497; x=1741846297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkWm0QuhqxjNcZB7EyUE4PLFKrbQuhRvZKwwayUqK28=;
        b=SP9aphnFg9Bt3GFR6xwdbgfWNp+eMWzBIzpuhs1ncUPkAPGfLZb3iQEzLaBfrQ8/45
         MVIIlT/XyLjwqlCwsWs0TqfVTBO0hBr453K8sAKdd/CtzbeJtD0HYZ6+pPAyq2YAotxZ
         CxOCjYUR87IYV18f9duw34ZvnqqcCVfHUlP6ecbibciDSL9ITy4aYg/gYs/RHd6pbNN3
         cc3nX2Wx0xXEdZNXEQKgeeDp1Gnf2oCJHWSDmpO3DcAJBdqFmlcgxux3EIroN48/wWRr
         g+z+p5ct+to1vwp2CKXKnnB7lRf8YDZt/qFjolr8FqXSeoQdZSIVLt0Hv6nPcST48cFx
         avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741241497; x=1741846297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkWm0QuhqxjNcZB7EyUE4PLFKrbQuhRvZKwwayUqK28=;
        b=t80WR7KPrhyCazAM1XMwbhJ4wnPzhFU6JuHk8DGLChCEc8YdLpXeyyriskz63zlp9j
         dJgIyWF3HZviuCwvPvWkMGvaGxDmcjvSTAAHPGrYqLN+653071N28VKrVIcbeHeKqYqH
         jc4x7AyTKher9J38e+P2TY+CvHZz9H/DlJ71VCZNHNW5Zq56IsQiGkjB/sJ1uW7nIBO/
         CJuIpD1IdcwxKh9K5RG3D0Dm1fk9Xo0y8/2hBgwvfvoTovj6/vBPzCipWq33R/uMsmI+
         KOqXsG7blIHWU4SgAkqiAV5/TWihYPjKaIxlvlets9FTICX+zpTg7hwfPCp4S09IhoTB
         ZyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH/zLdUZIOh0DFhbBVHTwXfDQr7W5rZmh7DigWXE69myrpcBi7VzMtwHB+Wqzoeut2/eMszVSb5Oo=@vger.kernel.org, AJvYcCV7en8N0VyL09RLM2HBzqBp2p/zrhXZKP7CJHpllrpVcDE1P/VWXW+MZd7zuMLwUuc2fk5ZvvXPL2Q=@vger.kernel.org, AJvYcCVugpA79hoT7/zCfhA9nTuXjPyktJS96aXmpyq/t+mGqPmszBPMq5BNaWgfyrbBBk0k5GHsJp3CWg3olYd8@vger.kernel.org, AJvYcCWFN7+THbJnEitiEnc88QY27Z961lB30wY2wNWdxGH7n/QBzNYKD317AXg34ESjEj9WkTjTH3SGc5UKzt9v4+1OvUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+hxluOXL/OT7H1qI0nzMx7ccmnLdtlZrPfYRSUve/sXBvu/X
	G1GJqBe2YwH37Sf42b9/L121Ng+T3m0Gplb+2x0d62J4VBLdkNEdG1GqkA==
X-Gm-Gg: ASbGncsPqne0Fg0q/gb3orsrlnWQfQRGIRE8ImKaWpzeQ32RQuxY7CXHK63PUgBfRUZ
	sS1fcJQmK45uridxAaXxxtrNUdjIOO21dL5ILW6QGWTWnzxRsk7s9DbicVknzF/wpqGt9uRp2NE
	lhZO+wbra9Rh30cO2SuhEHqZ6nK/Z7v0R5ZWxttxlKb9j+ikK5rWAd3as32R56Y6f8TAsb+6SLr
	JLcuaW7epzJo7w5h6V537TAwQK0+Z8PD/VDMW24s4u53eX2rMFutbU05pr4vnbK5om/nF91EdEz
	fM/YQJ0+XH39wCI+Bm1j7U/CMGIka+k0TJpSqxV967t65A==
X-Google-Smtp-Source: AGHT+IHdfafGauLvn1MT/jJjAnr6oLjiusoYXSi01nU2drwDh34FcbF0ln8yvQwWcDckUbZiGT37jg==
X-Received: by 2002:a17:90a:d64e:b0:2fe:9fd4:58f4 with SMTP id 98e67ed59e1d1-2ff497533d7mr11156646a91.16.1741241496693;
        Wed, 05 Mar 2025 22:11:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:423c:abab:b1b0:64e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff35966689sm2585833a91.0.2025.03.05.22.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:11:36 -0800 (PST)
Date: Wed, 5 Mar 2025 22:11:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
	dakr@kernel.org, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <Z8k8lDxA53gUJa0n@google.com>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
 <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
 <20250305140309.744866b2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305140309.744866b2@jic23-huawei>

On Wed, Mar 05, 2025 at 02:03:09PM +0000, Jonathan Cameron wrote:
> On Wed, 19 Feb 2025 14:45:07 +0200
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
> > Hi, Daniel, Jonathan,
> > 
> > On 15.02.2025 15:51, Claudiu Beznea wrote:
> > > Hi, Greg,
> > > 
> > > On 15.02.2025 15:25, Greg KH wrote:  
> > >> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:  
> > >>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>
> > >>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
> > >>> clocks are managed through PM domains. These PM domains, registered on
> > >>> behalf of the clock controller driver, are configured with
> > >>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
> > >>> clocks are enabled/disabled using runtime PM APIs. The power domains may
> > >>> also have power_on/power_off support implemented. After the device PM
> > >>> domain is powered off any CPU accesses to these domains leads to system
> > >>> aborts.
> > >>>
> > >>> During probe, devices are attached to the PM domain controlling their
> > >>> clocks and power. Similarly, during removal, devices are detached from the
> > >>> PM domain.
> > >>>
> > >>> The detachment call stack is as follows:
> > >>>
> > >>> device_driver_detach() ->
> > >>>   device_release_driver_internal() ->
> > >>>     __device_release_driver() ->
> > >>>       device_remove() ->
> > >>>         platform_remove() ->
> > >>> 	  dev_pm_domain_detach()
> > >>>
> > >>> During driver unbind, after the device is detached from its PM domain,
> > >>> the device_unbind_cleanup() function is called, which subsequently invokes
> > >>> devres_release_all(). This function handles devres resource cleanup.
> > >>>
> > >>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
> > >>> cleanup process triggers the action or reset function for disabling runtime
> > >>> PM. This function is pm_runtime_disable_action(), which leads to the
> > >>> following call stack of interest when called:
> > >>>
> > >>> pm_runtime_disable_action() ->
> > >>>   pm_runtime_dont_use_autosuspend() ->
> > >>>     __pm_runtime_use_autosuspend() ->
> > >>>       update_autosuspend() ->
> > >>>         rpm_idle()
> > >>>
> > >>> The rpm_idle() function attempts to resume the device at runtime. However,
> > >>> at the point it is called, the device is no longer part of a PM domain
> > >>> (which manages clocks and power states). If the driver implements its own
> > >>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
> > >>> driver - while also relying on the power domain subsystem for power
> > >>> management, rpm_idle() will invoke the driver's runtime PM API. However,
> > >>> since the device is no longer part of a PM domain at this point, the PM
> > >>> domain's runtime PM APIs will not be called. This leads to system aborts on
> > >>> Renesas SoCs.
> > >>>
> > >>> Another identified case is when a subsystem performs various cleanups
> > >>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
> > >>> A known example is the thermal subsystem, which may call driver-specific
> > >>> APIs to disable the thermal device. The relevant call stack in this case
> > >>> is:
> > >>>
> > >>> device_driver_detach() ->
> > >>>   device_release_driver_internal() ->
> > >>>     device_unbind_cleanup() ->
> > >>>       devres_release_all() ->
> > >>>         devm_thermal_of_zone_release() ->
> > >>> 	  thermal_zone_device_disable() ->
> > >>> 	    thermal_zone_device_set_mode() ->
> > >>> 	      struct thermal_zone_device_ops::change_mode()
> > >>>
> > >>> At the moment the driver-specific change_mode() API is called, the device
> > >>> is no longer part of its PM domain. Accessing its registers without proper
> > >>> power management leads to system aborts.
> > >>>
> > >>> Open a devres group before calling the driver probe, and close it
> > >>> immediately after the driver remove function is called and before
> > >>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
> > >>> reset functions are executed immediately after the driver remove function
> > >>> completes. Additionally, it prevents driver-specific runtime PM APIs from
> > >>> being called when the device is no longer part of its power domain.
> > >>>
> > >>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>> ---
> > >>>
> > >>> Hi,
> 
> Hi Claudiu, Greg,
> 
> Sorry, I missed this thread whilst travelling and only saw it because
> of reference from the in driver solution.
> 
> > >>>
> > >>> Although Ulf gave its green light for the approaches on both IIO [1],
> > >>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
> > >>> approaches in [1], [2] as he considered it may lead to dificult to
> > >>> maintain code and code opened to subtle bugs (due to the potential of
> > >>> mixing devres and non-devres calls). He pointed out a similar approach
> > >>> that was done for the I2C bus [4], [5].
> > >>>
> > >>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
> > >>> patch tries to revive it by proposing a similar approach that was done
> > >>> for the I2C bus.
> > >>>
> > >>> Please let me know you input.  
> > >>
> > >> I'm with Jonathan here, the devres stuff is getting crazy here and you
> > >> have drivers mixing them and side affects happening and lots of
> > >> confusion.  Your change here is only going to make it even more
> > >> confusing, and shouldn't actually solve it for other busses (i.e. what
> > >> about iio devices NOT on the platform bus?)  
> 
> In some cases they are already carrying the support as per the link
> above covering all i2c drivers.  I'd like to see a generic solution and
> I suspect pushing it to the device drivers rather than the bus code
> will explode badly and leave us with subtle bugs where people don't
> realise it is necessary. 
> 
> https://lore.kernel.org/all/20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com/
> is a lot nastier looking than what we have here. I'll review that in a minute
> to show that it need not be that bad, but none the less not pleasant.
> 
> +CC linux-iio to join up threads and Dmitry wrt to i2c case (and HID that does
> similar)

We should not expect individual drivers handle this, because this is a
layering violation: they need to know implementation details of the bus
code to know if the bus is using non-devres managed resources, and
adjust their behavior. Moving this into driver core is also not
feasible, as not all buses need it. So IMO this should belong to
individual bus code.

Instead of using devres group a bus may opt to use
devm_add_action_or_reset() and other devm APIs to make sure bus'
resource unwinding is carried in the correct order relative to freeing
driver-owned resources.

> 
> > > 
> > > You're right, other busses will still have this problem.
> > >   
> > >>
> > >> Why can't your individual driver handle this instead?  
> 
> In my mind because it's the bus code that is doing the unexpected part by
> making calls in the remove path that are effectively not in the same order
> as probe because they occur between driver remove and related devres cleanup
> for stuff registered in probe.
> 
> > > 
> > > Initially I tried it at the driver level by using non-devres PM runtime
> > > enable API but wasn't considered OK by all parties.
> > > 
> > > I haven't thought about having devres_open_group()/devres_close_group() in
> > > the driver itself but it should work.  
> > 
> > Are you OK with having the devres_open_group()/devres_close_group() in the
> > currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
> > proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?
> 
> I guess it may be the best of a bunch of not particularly nasty solutions...

We need to update _ALL_ platform drivers using devm then, and this is
clearly not scalable.

Thanks.

-- 
Dmitry

