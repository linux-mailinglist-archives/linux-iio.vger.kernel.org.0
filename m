Return-Path: <linux-iio+bounces-14607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDEA1D5EF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F863A24F9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E21FF1AE;
	Mon, 27 Jan 2025 12:32:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE44430;
	Mon, 27 Jan 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737981178; cv=none; b=aTV/fk3Z1RbxxuJK8kPDejOoBJ/eHzArNGKRR9xhzKpUzzEFZH7Mhjk0F6vNOSlezSOzcD/m/Ih9b+4vOart1vWkUdgaCtiImmeBHdT359yGavRRoYk3FWFgeMylti/73ujVfLINU2lC7dC2jKrkeWlbOi/ukGwDL9Dh8bxFOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737981178; c=relaxed/simple;
	bh=Q9A0tZM4tp7Ov928s5DzDKtrr9Bj/LCV2rz5XG6VF0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGGLAwriQ5CIufxLhp0XyIyB4fh90pOQo7zZQHN9EGRYvYlfgaAgmbUOqsK99xxBr4raJd5bDhHf0vtBjALHu/n2SLsEA1Mmskkdx/C1t14xrR5vYq/bwrCdMMmPzPxT6a9q9iWYOFULCbjf7ad5wnfu42QVZrh9EnC8VWI4mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhSVG1Yxpz6K99p;
	Mon, 27 Jan 2025 20:32:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 68FE31400C8;
	Mon, 27 Jan 2025 20:32:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 13:32:51 +0100
Date: Mon, 27 Jan 2025 12:32:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron
	<jic23@kernel.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <20250127123250.00002784@huawei.com>
In-Reply-To: <CAPDyKFrqDfYEQHk0RsRi2LnMw_HgGozMW9JP9xmkAq52O7eztg@mail.gmail.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
	<20250104135225.2573285b@jic23-huawei>
	<44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
	<20250111131409.36bebfd3@jic23-huawei>
	<bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
	<CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
	<20250117155226.00002691@huawei.com>
	<CAPDyKFpQUMOFtA-QCbYdaeKSDGJpnjcA+tiKZ=kzmrjYRtFZdw@mail.gmail.com>
	<20250124184137.0000047a@huawei.com>
	<CAPDyKFrqDfYEQHk0RsRi2LnMw_HgGozMW9JP9xmkAq52O7eztg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 27 Jan 2025 11:47:44 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> [...]
> 
> > > > > > Do consider OK to change the order in pm_runtime_disable_action() to get
> > > > > > rid of these issues, e.g.:
> > > > > >
> > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > index 2ee45841486b..f27d311d2619 100644
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > > > >
> > > > > >  static void pm_runtime_disable_action(void *data)
> > > > > >  {
> > > > > > -       pm_runtime_dont_use_autosuspend(data);
> > > > > >         pm_runtime_disable(data);
> > > > > > +       pm_runtime_dont_use_autosuspend(data);
> > > > > >  }
> > > > > >
> > > > > > though I see a rpm_resume() call is still possible though pm_runtime_disable().  
> > > > >
> > > > > I am still worried about keeping the device runtime enabled during a
> > > > > window when we have turned off all resources for the device. Typically
> > > > > we want to leave the device in a low power state after unbind.
> > > > >
> > > > > That said, I would rather just drop the devm_pm_runtime_enable() API
> > > > > altogether and convert all users of it into
> > > > > pm_runtime_enable|disable(), similar to what your patch does.  
> > > >
> > > > That is making a mess of a lot of automated cleanup for a strange
> > > > runtime pm related path.  This is pain a driver should not have
> > > > to deal with, though I'm not clear what the right solution is!
> > > >
> > > > Key is that drivers should not mix devm managed cleanup and not, so
> > > > that means that anything that happens after runtime pm is enabled
> > > > has to be torn down manually.  One solution to this might be to
> > > > always enable it late assuming that is safe to do so there is
> > > > never anything else done after it in the probe path of a driver.  
> > >
> > > The problem is that runtime PM isn't really comparable to other
> > > resources that we are managing through devm* functions.
> > >
> > > Enabling runtime PM for a device changes the behaviour for how
> > > power-mgmt is handled for the device. Enabling/disabling of runtime PM
> > > really needs to be explicitly controlled by the driver for the device.  
> >
> > I'm sorry to say I'm not yet convinced.  
> 
> Okay, let me try one more time. :-)

+CC Greg as the disagreement here is really a philosophy of what
devm cleanup is relative to remove.  Perhaps Greg or Rafael can
given some guidance on the intent there.

Mind you I think I found another subsystem working around this
and in a somewhat more elegant, general way (to my eyes anyway!)

https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L630
https://lore.kernel.org/all/YFf1GFPephFxC0mC@google.com/

+CC Dmitry.

I2C creates an extra devres group and releases it before devm_pm_domain_detach()
As all devm calls from the driver end up in that group, they are released
before dev_pm_domain_detach()


> 
> >
> > Devm callbacks are explicitly registered by the driver so that they
> > are unwound in a specific order.  Many other parts of driver
> > registration rely on this ordering.  This does not seem different
> > for runtime PM than anything else.  
> 
> If you compare clocks, for example. It's the driver that is in full
> control of the clock gating/ungating. When the ->remove() callback
> runs, the driver typically makes sure that it leaves the clock gated.
> Then it doesn't really matter when the clock resource gets released.
> The point is, the driver is in full control of the resource.

Not a good example. devm_clk_get_enabled() does not gate the clock until
the devm cleanup. The assumption being that nothing that affects
it runs between the remove() and devm cleanup.  So pretty much identical
to the runtime pm case.  They being that you have to obey ordering so
that if you need to run something after the clock is disabled then
you register that callback before you call devm_clk_get_enabled()

> 
> If runtime PM would remain enabled beyond the call to the ->remove()
> callback, it would mean that the driver's runtime PM callbacks could
> be called too. For example, userspace via sysfs may at any point
> decide to runtime resume the device. In other words, we may end up
> calling the runtime PM callbacks in the driver, when they are not
> intended to be called. In the worst case, I guess we could even end up
> trying to control resources (like a clock) from the ->runtime
> _resume() callback, when the references to these resources may already
> have been released.

This is all about what we consider remove. To me, with devm_ manged cleanup
in place, both remove() and devm_ cleanup count as parts of that remove
process.  

One option I did wonder about was having a devm_pm_domain_attach()
A little cheeky but I think the call in platform_probe() is late enough
that we don't run into the checks on no devm_ calls before driver probe.

That would shuffle the dev_pm_domain_detach() to the end of the
devm_ cleanup.  Mind you the i2c approach above seems better.

Jonathan

> 
> >
> > Superficially the issue here looks to me to be that a non devm
> > cleanup is inserted by the bus->remove() callback into drivers
> > that are otherwise relying on explicit ordering provided
> > by managed cleanup.
> >
> > I appreciate there may be no trivial solution.
> >
> > Maybe we can minimize that impact by always doing runtime pm last
> > in any probe() function?  Can that work here?
> >
> >  
> > >
> > > If there are cleanups to be made for runtime PM, beyond disabling
> > > runtime PM, we could instead consider adding that code in
> > > pm_runtime_reinit().  
> >
> > I'm not familiar enough to comment on this option beyond it being
> > after devres_release_all() so, maybe?  It seems superficially
> > a better point in the sequence.
> >
> > Jonathan  
> > >
> > > [...]  
> 
> Kind regards
> Uffe


