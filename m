Return-Path: <linux-iio+bounces-14638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C6A1DBFF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6840A165978
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7F18C930;
	Mon, 27 Jan 2025 18:24:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB071F60A;
	Mon, 27 Jan 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002271; cv=none; b=jGnSdXAq0cFKCic1Q+oM31jyWg0Rr4I0//Shntlni8QfYTYmTUx7lgiRLTgCyPrRGZBXFhXlZCC6CrPNMWMU958E8Jpk6qjJwVinSkO35OA0CUK0VV5n10EhwlSBWHqx+rdKo/jvDuitykhHfDh+4xClYh1HzNF7YxPBhc9U3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002271; c=relaxed/simple;
	bh=Ocgrby39zYD+gB37RMFk3KQ8gTxLYp5ua4xEOWPRXT8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWoOf1QtAUSl4MgOHLBq8G50QgK+f4BNGgii3AxYY0TbjWTqPO2rc7dhtjqQwfAXafSl99QaD1AvCI3Wy847+9nra0Wq0mmJR2QfRIiAtid+erixlnW0tEXpj6mEuqwvKWUhXUEDODDs00e1blbVsizjEomF/idYllw53ENAAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhcHt540Mz6K9FS;
	Tue, 28 Jan 2025 02:23:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 96323140A35;
	Tue, 28 Jan 2025 02:24:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 19:24:24 +0100
Date: Mon, 27 Jan 2025 18:24:23 +0000
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
Message-ID: <20250127182423.000013a7@huawei.com>
In-Reply-To: <CAPDyKFoCx3jQOptPrY0CYNpH1R+fszF3MUQLSTn_nreyi5-vPw@mail.gmail.com>
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
	<20250127123250.00002784@huawei.com>
	<CAPDyKFoCx3jQOptPrY0CYNpH1R+fszF3MUQLSTn_nreyi5-vPw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 27 Jan 2025 16:02:32 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Mon, 27 Jan 2025 at 13:32, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 27 Jan 2025 11:47:44 +0100
> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >  
> > > [...]
> > >  
> > > > > > > > Do consider OK to change the order in pm_runtime_disable_action() to get
> > > > > > > > rid of these issues, e.g.:
> > > > > > > >
> > > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > > index 2ee45841486b..f27d311d2619 100644
> > > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > > > > > >
> > > > > > > >  static void pm_runtime_disable_action(void *data)
> > > > > > > >  {
> > > > > > > > -       pm_runtime_dont_use_autosuspend(data);
> > > > > > > >         pm_runtime_disable(data);
> > > > > > > > +       pm_runtime_dont_use_autosuspend(data);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > though I see a rpm_resume() call is still possible though pm_runtime_disable().  
> > > > > > >
> > > > > > > I am still worried about keeping the device runtime enabled during a
> > > > > > > window when we have turned off all resources for the device. Typically
> > > > > > > we want to leave the device in a low power state after unbind.
> > > > > > >
> > > > > > > That said, I would rather just drop the devm_pm_runtime_enable() API
> > > > > > > altogether and convert all users of it into
> > > > > > > pm_runtime_enable|disable(), similar to what your patch does.  
> > > > > >
> > > > > > That is making a mess of a lot of automated cleanup for a strange
> > > > > > runtime pm related path.  This is pain a driver should not have
> > > > > > to deal with, though I'm not clear what the right solution is!
> > > > > >
> > > > > > Key is that drivers should not mix devm managed cleanup and not, so
> > > > > > that means that anything that happens after runtime pm is enabled
> > > > > > has to be torn down manually.  One solution to this might be to
> > > > > > always enable it late assuming that is safe to do so there is
> > > > > > never anything else done after it in the probe path of a driver.  
> > > > >
> > > > > The problem is that runtime PM isn't really comparable to other
> > > > > resources that we are managing through devm* functions.
> > > > >
> > > > > Enabling runtime PM for a device changes the behaviour for how
> > > > > power-mgmt is handled for the device. Enabling/disabling of runtime PM
> > > > > really needs to be explicitly controlled by the driver for the device.  
> > > >
> > > > I'm sorry to say I'm not yet convinced.  
> > >
> > > Okay, let me try one more time. :-)  
> >
> > +CC Greg as the disagreement here is really a philosophy of what
> > devm cleanup is relative to remove.  Perhaps Greg or Rafael can
> > given some guidance on the intent there.
> >
> > Mind you I think I found another subsystem working around this
> > and in a somewhat more elegant, general way (to my eyes anyway!)
> >
> > https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L630
> > https://lore.kernel.org/all/YFf1GFPephFxC0mC@google.com/
> >
> > +CC Dmitry.
> >
> > I2C creates an extra devres group and releases it before devm_pm_domain_detach()
> > As all devm calls from the driver end up in that group, they are released
> > before dev_pm_domain_detach()
> >  
> 
> How would that address the problem I pointed out with runtime PM
> below? This problem isn't limited to attaching/detaching PM domains.

It's associated with anything that happens after a driver remove is done.
We just disagree on when that remove is finished. There is nothing special about
the remove() callback, that is just part of remove process.
No magic transition of state that allows new things to happen follows
the device driver remove finishing. Sure you can get the remove
handling ordering wrong whether devm is in use or not.  The trick is
almost always to never mix devm and not.  Once you need a single bit of
manual unwinding stop with the devm and do everything beyond that point
by hand (in probe order, before that point in remove order)

> 
> >  
> > >  
> > > >
> > > > Devm callbacks are explicitly registered by the driver so that they
> > > > are unwound in a specific order.  Many other parts of driver
> > > > registration rely on this ordering.  This does not seem different
> > > > for runtime PM than anything else.  
> > >
> > > If you compare clocks, for example. It's the driver that is in full
> > > control of the clock gating/ungating. When the ->remove() callback
> > > runs, the driver typically makes sure that it leaves the clock gated.
> > > Then it doesn't really matter when the clock resource gets released.
> > > The point is, the driver is in full control of the resource.  
> >
> > Not a good example. devm_clk_get_enabled() does not gate the clock until  
> 
> I was not referring to devm_clk_get_enable(), but rather just devm_clk_get().
> 
> To me devm_clk_get_enable() is another interface that we should avoid.
> For example, what if the clock is already gated when the ->remove()
> callback runs? Then we need to ungate the clock just to make the
> devres path happy so it doesn't gate an already gated clock. And this,
> just to save one or two lines of code.

If someone is using a clock that is gated by other calls in the driver
that then indeed the use of devm_clk_get_enabled() is inappropriate
or they turn they do need to enable the clock and turn it off again
as you mention which is a mess but often needs doing anyway as we
commonly need some clocks at least to put a device into a low power
state.

> 
> Don't get me wrong, I certainly like the devm* functions in general,
> but it's not a good fit for everything.

For anything that a driver otherwise calls in remove() they are
a direct equivalent that is just called automatically. (though apparently
not quite in platform drivers!) If you have a sequence that is
sufficiently complex they may not be a good fit. I just don't think
that the sequence in this driver (and many others) is complex.
The driver code (with the above change from i2c ported to platform code
to fix the specific problem) is a lot simpler before Claudia's v2 to
change the handling. 32 lines added to work around this...

> 
> > the devm cleanup. The assumption being that nothing that affects
> > it runs between the remove() and devm cleanup.  So pretty much identical
> > to the runtime pm case.  They being that you have to obey ordering so
> > that if you need to run something after the clock is disabled then
> > you register that callback before you call devm_clk_get_enabled()
> >  
> > >
> > > If runtime PM would remain enabled beyond the call to the ->remove()
> > > callback, it would mean that the driver's runtime PM callbacks could
> > > be called too. For example, userspace via sysfs may at any point
> > > decide to runtime resume the device. In other words, we may end up
> > > calling the runtime PM callbacks in the driver, when they are not
> > > intended to be called. In the worst case, I guess we could even end up
> > > trying to control resources (like a clock) from the ->runtime
> > > _resume() callback, when the references to these resources may already
> > > have been released.  
> >
> > This is all about what we consider remove. To me, with devm_ manged cleanup
> > in place, both remove() and devm_ cleanup count as parts of that remove
> > process.  
> 
> There is no straightforward process here, if you would keep runtime PM
> enabled beyond ->remove(). Things can happen in parallel.

How?  Nothing magic happens when a driver remove() ends.
So there is no difference at all in a driver calling runtime pm disable
in that code or in devres cleanup that happens immediately after that
in the bus driver remove.

> 
> In that case, drivers would need to extend their runtime PM callbacks
> to cope with more complicated conditions, as resources that those use
> may have been released. Moreover, how can we make sure that the device
> is put into a low power state after the ->remove() has been called?

This is a fair question.  Also one commonly handled by drivers using devm
though perhaps not for the reason you are thinking.  Key is that most
drivers should not rely at all on runtime PM being built let alone
enabled. 

Solution is normally a devm_add_action_or_reset() call that
registers a call to put the device into a low power state.

Sequence is normally something like:

1) enable clks etc.
2) Turn the power on.
3) device setup
4) enable runtime PM after setting the state to active. Let autosuspend
   do it's work.

On remove (all devm_ managed).
5) disable runtime PM.
6) Turn the power off (may involve a check on whether it is already
   off though in many cases it's idempotent so we don't bother checking).
7) disable clocks.

in this particular driver I'm assuming that the low power state is
handled via the reset lines being put back into reset by the
the unwind of the two
devm_reset_control_get_exclusive_deasserted() calls.


> 
> >
> > One option I did wonder about was having a devm_pm_domain_attach()
> > A little cheeky but I think the call in platform_probe() is late enough
> > that we don't run into the checks on no devm_ calls before driver probe.
> >
> > That would shuffle the dev_pm_domain_detach() to the end of the
> > devm_ cleanup.  Mind you the i2c approach above seems better.  
> 
> Again, this isn't limited to PM domains.

All comes down to when you think driver remove is finished.
I think the answer to that in the above i2c scheme is after the
release of the devres group, not after end of remove call.

Anything that the bus driver does will then occur after the
device driver devres cleanup is done.  That puts all cleanup
in device driver remove() immediately before the devres cleanup
of anything setup in probe(), making manual unwinding and automatic
unwinding effective the same.

So for me the right fix here is to make the same thing happen
for platform devices as for i2c ones.

Jonathan


> 
> [...]
> 
> Kind regards
> Uffe


