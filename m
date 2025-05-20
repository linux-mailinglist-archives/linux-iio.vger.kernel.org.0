Return-Path: <linux-iio+bounces-19743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F2ABE358
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4B3A5DD7
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC2F27AC30;
	Tue, 20 May 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFbCkwb+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB051C5F10;
	Tue, 20 May 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768118; cv=none; b=GR04IV+Km8trNNiBAg/rdtH7FY8xAu6YR1pAiaA7XkHFZZZJCYoyd4F3/8W87oI6zsJrGhxS/ZVJwmKXlGXAQ9x81QvxLKZzuLK1C8VcYY/hvGoI2GScaxdN7tsOsTR2eSEqRNtu7fCdXrCNLiVERpPccl/seP7iLZAwYIRFyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768118; c=relaxed/simple;
	bh=CSNTKQTCteZoO7cckjRlOzhkByjiYe8neyWXkxZxMBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaljluwBI5EOy9bYgbQx4G409DCzHBGc3U4J3kHI1lQ0MEfRD/FmqfP1I5Wp4ETWcYvsThnhkJSonwigZA9+gCIPsWmoOkjerowuaY8FLbcvdre2VgHjPh/LeGmUxi8b7Qeat6aMyEMDlCWXOv1NRZwPkMPBK3PxPS+Lgy5JcqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFbCkwb+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74068f95d9fso5365871b3a.0;
        Tue, 20 May 2025 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768116; x=1748372916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqlcH96iSCswYPhO83dojFmUU9wnimuW4cTsR396Z4k=;
        b=jFbCkwb+KFCEjvpElCG2rW0WYnlHEr5/HzHxNszG8VONAA+ST/SJaMtwhxKtVt5yXp
         KrR6rOIS9W3JMTvNyfPcVHSSYPpbTtbv537LpQzCT6Jx1p0NPNtZ4UIlR8r8FqXptLhO
         Mp/F+zYOtibF54PAbbVP+1fP2jH+3bF6lpM2UVVmt+5uaXKKx1NcKtox8/F4LP5PxEjg
         j7Vunt3RxGlEQtqMM/E3XTmsTaTZgE+e8Yga0LO/geTvDtYRJY+cTK0LjKk1g8Uhxput
         3JIY/KYXQEe3SS/rVDHfc4woumWNzXZIorJPL09IkLjYXOeFlwBV7Al3Lk7h2tmDSVFP
         EBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768116; x=1748372916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqlcH96iSCswYPhO83dojFmUU9wnimuW4cTsR396Z4k=;
        b=VI0Bbc5oL3Dpb4OEo6ICh1hfldoyZIQW/5rV4uzVTxMu+iFxZymfmuSX43J4gZID2M
         i9wM7h08c2CGeor66no35djKThOBWJFEoQxMBcG6dBC2q7YDT9cp+wjkN5azpErOMlJP
         nLDn2gc/uIshwll9dCo2CDCPXkagRqrW+pQCr0l87gNsDly71deGxJ9dZK5A85BhUG9v
         5jMWlFFuVDKvpfV8cf5YypeIQkkCuLFGe07YjevyMxnqvSyKb3VvLeBU4OwoeCKp4UPs
         fQF3B510Oe9sdRVtk4d+aOhSazLxuVngEnj6StmKMTFC1D7BYYpQvW3VHWzUka35JUSW
         0UAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHWZCdSakwRyYpRmIUcdNl0+R7Ckfv2x1E8ZZRtNkabdDQcUwP2jRZjJVSKbHvNoiYJbO82YZqMRBxpAR2VeIf2tM=@vger.kernel.org, AJvYcCVzQ64ANEt5PphQZbmkM2CcfNsP7oJHkhxLsWCsJmkrRc3m7Jg+yiOLgcH7b34WSfhs2xYh2E/kWxX2EjDZ@vger.kernel.org, AJvYcCW3/W+5CeDraQtoKYCIYzDCSwl4QBnEvi5mMJbKEsumbHv+c+YklbXWUrVz7hWlekrJsh4U5rNVIhg=@vger.kernel.org, AJvYcCXlNsII0afp36wwOJaxzbymxjCfBWOp02DDeoWqTs6SsR7L81qNCFCVLqziqtG9pUNysFLlJ/D8r4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yl+Sn1FWpgM56yglu9O0fsXNTVvmMJugnDAGfFtc1tVkVPgk
	lZ26vRU792YWLpfeJiq7kCMZbq8nClGq7HN6iIzc8e0F10/b1faS4+K3
X-Gm-Gg: ASbGncvVFjSQYTVNf8lRjKqOHY7V/1zY+Fgu49nCj/jEZz8Bwfs2nMAdnZHbxqWOZwE
	TDI7lTBF2oWOqMwiU48z4JARPkCmoYA9Fy+hfsnRdSjdVHiZzVn5b2iWOZk6KmbvOot4xWDCsgF
	4mbl96VNxT1R7rwqj1QL6in4xu0eOXvFuhH4D1a+D5kPUH8Btn42ue35jPasgb93vPBtr4TjX8W
	uAf24qHMcwtUaWDHj972Jt8MHTkoCkt8Zr8zkhiM8bfOBfDbkd4a3/O/mR+fv1Hyr0bRYDUNoYs
	IJ97LTOqTmOm5rVLKFqMXW3Qe2ObdRapGoUlEFS3vmaivNEr+2pK
X-Google-Smtp-Source: AGHT+IGiB1X92EfvLP/EZtCe636Zd3m+e9TMbPk/FNEqdjKNHk8INchZMRzY1HhTuqUz/0VXqBD2bw==
X-Received: by 2002:a05:6a21:9208:b0:1f5:8479:dfe2 with SMTP id adf61e73a8af0-2170cafa32emr26628026637.6.1747768116229;
        Tue, 20 May 2025 12:08:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:533f:75df:b89f:cab5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876e62sm8483846b3a.147.2025.05.20.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:08:35 -0700 (PDT)
Date: Tue, 20 May 2025 12:08:32 -0700
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
Message-ID: <gthb7h5e3lu2lbajsra22nzlkfafxhnn4d5unpx2soxlj6bpvc@p2y6qjb5lpqd>
References: <Z8k8lDxA53gUJa0n@google.com>
 <f74085be-7b14-4551-a0a7-779318a5dc70@tuxon.dev>
 <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>

On Tue, May 20, 2025 at 02:09:36PM +0200, Ulf Hansson wrote:
> [...]
> 
> > > > >>>>>
> > > > >>>>
> > > > >>>> Rafael,
> > > > >>>>
> > > > >>>> Greg suggested we ask for your input on the right option:
> > > > >>>>
> > > > >>>> https://lore.kernel.org/all/2025032703-genre-excitable-9473@gregkh/
> > > > >>>> (that thread has the other option).
> > > > >>>
> > > > >>> Can you please let us know your opinion on this?
> > > > >> Can you please let us know if you have any suggestions for this?
> > > > >
> > > > > It's been a while since I looked at this. Although as I understand it,
> > > > > the main issue comes from using devm_pm_runtime_enable().
> > > >
> > > > Yes, it comes from the usage of devm_pm_runtime_enable() in drivers and the
> > > > dev_pm_domain_detach() call in platform_remove() right after calling
> > > > driver's remove function.
> > >
> > > Okay.
> >
> > This is not the root of the problem though. There is nothing really
> > special about power domain and runtime power management. The root of the
> > problem is that current code violates the order of releasing resources
> > by mixing devm- and normal resource management together. Usually it is
> > individual driver's fault, but in this case it is bus code that uses the
> > manual release (dev_om_domain_detach) that violates the "release in
> > opposite order to acquisition" rule.
> 
> As I said before, runtime PM is not a regular resource, but a
> behaviour that we turn on/off for a device. Enabling and disabling
> runtime PM needs to be managed more carefully in my opinion.

You also need to be careful enabling and disabling interrupts, be
careful with power supplies to make sure the chip you want to talk to is
powered up, and has clocks running.

But I think you are concentrating too much on runtime PM aspect and are
missing the bigger picture: even in the absence of runtime PM we should
not detach the device from its power domain out of order compared to
releasing other resources.

We have:

static void platform_remove(struct device *_dev)
{
	struct platform_driver *drv = to_platform_driver(_dev->driver);
	struct platform_device *dev = to_platform_device(_dev);

	if (drv->remove)
		drv->remove(dev);
	dev_pm_domain_detach(_dev, true);
}

That "dev_pm_domain_detach(_dev, true)" means that device may get
powered off. If you look at for example ACPI power domain it will end up
calling acpi_dev_pm_low_power() which may place the device into D3Cold
state. At this point you can't talk to the device.

Now, if the driver used devm APIs, all the resources acquired will be
released *after* we detach from the domain. That means that interrupts
may still be firing, custom devm callbacks may still try to communicate
with the device, etc. This can cause multitude of errors, from
relatively benign logs in dmesg to system hangs. 

To solve this is simple: make sure we take devm into account and
release all devm resources acquired after the device was attached to a
power domain before we detach the device from that power domain.

If we do this we can also safely use devm_pm_runtime_enable() and it
will be disabled at the right time and everyone will be happy.

> 
> For example, even if the order is made correctly, suppose a driver's
> ->remove() callback completes by turning off the resources for its
> device and leaves runtime PM enabled, as it relies on devres to do it
> some point later. Beyond this point, nothing would prevent userspace
> for runtime resuming/suspending the device via sysfs. I would be quite
> worried if that happens as it certainly would lead to undefined
> behaviour.

If you have this situation that means that you have logic error in the
driver. You should not run off resources too early. devm usually helps
with that. If you do:

devm_regulator_get_enaled()
devm_clk_get_enabled()
devm_request_threaded_irq()
devm_pm_runtime_enable()

then at remove time you should see:

runtime_pm_disable()
free_irq()
clk_disable()
regulator_disable/put()

in this particular order, which should be safe. But if you start mixing
things up and let's say use clk_get() (not devm variant) and explicitly
call clk_put() in remove() you will end up with clocks disabled but
interrupts still active and trouble will ensue.

The point of devm is so that you do not simply "leave runtime PM
enabled" with other resources shut off.

> 
> >
> > >
> > > >
> > > > On the platform I experienced issues with, the dev_pm_domain_detach() drops
> > > > the clocks from the device power domain and any subsequent PM runtime
> > > > resume calls (that may happen in the devres cleanup phase) have no effect
> > > > on enabling the clocks. If driver has functions registered (e.g. through
> > > > devm_add_action_or_reset()), or driver specific runtime PM functions that
> > > > access directly registers in the devres cleanup phase this leads to system
> > > > aborts.
> > >
> > > So if you move away from using devm_pm_runtime_enable() things would
> > > be easier to manage and there is no additional new devres-management
> > > needed.
> >
> > How exactly will it improve the situation? You still need to make sure
> > that you are not disabling things out of the order. You simply moving
> > the complexity to the driver, essentially forbidding it (and any other
> > driver on platform bus) from using any devm APIs.
> 
> The driver can still use the devres APIs to "get" all resources and
> then rely on devres to "put" them. There is nothing that prevents
> that, right?

*Order* is important. You need to release everything in reverse order.

> 
> Or maybe I didn't understand the problem correctly?

If you mix devm and regular APIs it is nearly impossible to maintain the
proper order of releasing the resources.

I hope I was able to explain the issue above.

> 
> >
> > >
> > > >
> > > >
> > > > >
> > > > > As I have tried to argue before, I think devm_pm_runtime_enable()
> > > > > should *not* be used. Not here, not at all. Runtime PM isn't like any
> > > > > other resources that we fetch/release. Instead, it's a behaviour that
> > > > > you turn on and off, which needs to be managed more carefully, rather
> > > > > than relying on fetch/release ordering from devres.
> >
> > I disagree. It is a resource that you turn on and off, same as clocks,
> > regulators, interrupts, etc. We manage those during lifetime of the
> > device, disable them when going into low power mode/suspend, reenable
> > them upon resume, may disable and reenable them for other reasons.
> >
> > PM is not any more special here. As long as you keep the proper order of
> > operations it works as well.
> 
> How would you solve the issue I pointed out above?

The proper order is to disable runtime PM at the right time (which is
typically early enough as it is typically enabled late in probe()) so
there is no concern with "leaving it enabled". And again, the issue is
not limited to runtime PM, even devices that do not use runtime PM
should not be detached from their power domain too early.

> 
> >
> > > > >
> > > > > That said, I would convert the driver to use pm_runtime_enable() and
> > > > > pm_runtime_disable() instead.
> > > >
> > > > I've tried this approach previously but it resulted in more complicated
> > > > code and thus, Jonathan wasn't happy with it [1].
> > >
> > > I understand that you have been trying to move forward to address
> > > people's opinions. It's not always easy to keep everybody happy. :-)
> > >
> > > That said, I still think this is the most viable option as it's how
> > > the vast majority of drivers do it today. A few lines of additional
> > > code shouldn't really be a big problem in my opinion.
> >
> > Have you tried making such change? Again, you will need to abandon use
> > of most other devm APIs so that you keep the order of releasing
> > resources. The only devm that you can still use is devm_k*alloc(), the
> > rest has to be converted into unmanaged.
> 
> I guess I need to take a stab at this particular use case.
> 
> Looking closer, could it be that it's really the combination of
> turning on/off resources using devres (not just get/put if them) like
> clocks - and using devm_pm_runtime_enable()?

It is mixing devres and non-devres resources, yes. Not specifically
runtime PM.

Thanks.

-- 
Dmitry

