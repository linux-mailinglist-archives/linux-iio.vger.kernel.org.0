Return-Path: <linux-iio+bounces-14427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B53A1533A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 16:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBC23AB269
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5819AA5D;
	Fri, 17 Jan 2025 15:52:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D15B984;
	Fri, 17 Jan 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129152; cv=none; b=QXb2omXrBRJ0sf8stIcigHehuPCabZrWYNLOmV1H6svjB1FNzx+m8mjDRJos1WRHcxgcQt8ctv/uAkUhg4xnvpZE+f91dZsmRbMkjbuE7aQtgPQoHHrApaowmquPShdXZjdCST/Teusv9Nd4mhC5cGlFvlMZ43Qf2iWGhH6ncqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129152; c=relaxed/simple;
	bh=HX2Va6vjl0bgnSZ4gX9xBC1bNpYbi7IFvGHFb0zVLIw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my66KxhfbIYF33hrpQDl+IKErNq+NTRzaLZMhywljbvyLsclK20FIBLOVzkTMC/xSXY8wDNvNq6dhlvdr245yrB+rCjlSPwHae2OePRzaXVlFz6mEx2lAkJ2kvRtz4E2EdpgahAoixpJBZVJsmfWuMVRm2Oci6/TW9YuUaFIGGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZPMv13b5z6FGht;
	Fri, 17 Jan 2025 23:50:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 044AB1409EA;
	Fri, 17 Jan 2025 23:52:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 16:52:27 +0100
Date: Fri, 17 Jan 2025 15:52:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron
	<jic23@kernel.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <20250117155226.00002691@huawei.com>
In-Reply-To: <CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
	<20250104135225.2573285b@jic23-huawei>
	<44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
	<20250111131409.36bebfd3@jic23-huawei>
	<bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
	<CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
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

On Wed, 15 Jan 2025 16:29:15 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Wed, 15 Jan 2025 at 14:37, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >
> > Hi, Jonathan,
> >
> > Thank you for your input!
> >
> > On 11.01.2025 15:14, Jonathan Cameron wrote:  
> > > On Mon, 6 Jan 2025 11:18:41 +0200
> > > Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >  
> > >> Hi, Jonathan,
> > >>
> > >>
> > >> On 04.01.2025 15:52, Jonathan Cameron wrote:  
> > >>> On Fri,  3 Jan 2025 16:00:41 +0200
> > >>> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > >>>  
> > >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
> > >>> +CC Rafael and linux-pm
> > >>>  
> > >>>>
> > >>>> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> > >>>> of a PM domain. The code that implements the PM domains support is in
> > >>>> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> > >>>> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> > >>>> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> > >>>> the documentation, instructs genpd to use the PM clk framework while
> > >>>> powering on/off attached devices.
> > >>>>
> > >>>> During probe, the ADC device is attached to the PM domain
> > >>>> controlling the ADC clocks. Similarly, during removal, the ADC device is
> > >>>> detached from the PM domain.
> > >>>>
> > >>>> The detachment call stack is as follows:
> > >>>>
> > >>>> device_driver_detach() ->
> > >>>>   device_release_driver_internal() ->
> > >>>>     __device_release_driver() ->
> > >>>>       device_remove() ->
> > >>>>         platform_remove() ->
> > >>>>           dev_pm_domain_detach()
> > >>>>
> > >>>> During driver unbind, after the ADC device is detached from its PM domain,
> > >>>> the device_unbind_cleanup() function is called, which subsequently invokes
> > >>>> devres_release_all(). This function handles devres resource cleanup.
> > >>>>
> > >>>> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> > >>>> triggers the action or reset function for disabling runtime PM. This
> > >>>> function is pm_runtime_disable_action(), which leads to the following call
> > >>>> stack of interest when called:
> > >>>>
> > >>>> pm_runtime_disable_action() ->
> > >>>>   pm_runtime_dont_use_autosuspend() ->  
> > >>>
> > >>> So is the only real difference that in the code below you disable runtime pm
> > >>> before autosuspend?  
> > >>
> > >> No, the difference is that now, the driver specific runtime PM APIs are not
> > >> called anymore (through the pointed call stack) after the ADC was removed
> > >> from it's PM domain.  
> > >
> > > By my reading they are only not called now because you turn autosuspend off
> > > after disabling runtime PM.  
> >
> > Sorry, I wanted to say that the runtime PM APIs are not called anymore from
> > devm_action_release(), though this call stack:
> >
> > [   24.801195] Call trace:
> > [   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
> > [   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
> > [   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
> > [   24.818580]  __rpm_callback+0x48/0x198
> > [   24.822319]  rpm_callback+0x68/0x74
> > [   24.825798]  rpm_suspend+0x100/0x578
> > [   24.829362]  rpm_idle+0xd0/0x17c
> > [   24.832582]  update_autosuspend+0x30/0xc4
> > [   24.836580]  pm_runtime_disable_action+0x40/0x64
> > [   24.841184]  devm_action_release+0x14/0x20
> > [   24.845274]  devres_release_all+0xa0/0x100
> > [   24.849361]  device_unbind_cleanup+0x18/0x60
> >
> > This is because I dropped the devm_pm_runtime_enable() which registers the
> > pm_runtime_disable_action(), which is called at the time the
> > device_unbind_cleanup() is called, which is called when the ADC is not
> > anymore part of its PM domain.
> >
> > If I change the order in remove function proposed in this patch, thus do:
> >
> > +static void rzg2l_adc_remove(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +
> > +       pm_runtime_dont_use_autosuspend(dev);
> > +       pm_runtime_disable(dev);
> >  }
> >
> > nothing changes with the behavior of this patch. There will be no issue if
> > the device is runtime suspended/resumed through the
> > pm_runtime_dont_use_autosuspend() because at the time the
> > rzg2l_adc_remove() is called the ADC is still part of the PM domain.
> >
> >
> >  
> > >  
> > >>
> > >>  
> > >>>  Can you still do that with a devm callback just not
> > >>> the standard one?  
> > >>
> > >> No. It doesn't matter if we call the standard devm callback or driver
> > >> specific one. As long as it is devm it will impact us as long as the driver
> > >> specific runtime PM APIs are called through devres_release_all() after
> > >> dev_pm_domain_detach(). And at that time the PM domain may be off along
> > >> with its clocks disabled.  
> > >
> > > As above, I think that this is only the case because of the reordering
> > > of those two calls, not something more fundamental.  
> >
> > I tried having a local devm function (the following diff applied with this
> > patch reverted) identical with pm_runtime_disable_action():
> >
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index 22a581c894f8..459cc9c67eec 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -423,6 +423,12 @@ static int rzg2l_adc_hw_init(struct device *dev,
> > struct rzg2l_adc *adc)
> >         return ret;
> >  }
> >
> > +static void rzg2l_pm_runtime_disable(void *data)
> > +{
> > +       pm_runtime_dont_use_autosuspend(data);
> > +       pm_runtime_disable(data);
> > +}
> > +
> >  static int rzg2l_adc_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> > @@ -463,7 +469,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >
> >         pm_runtime_set_autosuspend_delay(dev, 300);
> >         pm_runtime_use_autosuspend(dev);
> > -       ret = devm_pm_runtime_enable(dev);
> > +       pm_runtime_enable(dev);
> > +
> > +       ret = devm_add_action_or_reset(dev, rzg2l_pm_runtime_disable, dev);
> >         if (ret)
> >                 return ret;
> >
> > With this the issue is still reproducible.
> >
> > However, changing the order of functions in rzg2l_pm_runtime_disable() and
> > having it like:
> >
> > +static void rzg2l_pm_runtime_disable(void *data)
> > +{
> > +       pm_runtime_disable(data);
> > +       pm_runtime_dont_use_autosuspend(data);
> > +}
> >
> >
> > leads to no failure when doing unbind/bind.
> >
> > However, I see the pm_runtime_disable() can still call rpm_resume() under
> > certain conditions. It can still lead to failures if it is called after the
> > device was remove from its PM domain.
> >  
> > >
> > > In driver remove flow, device_unbind_cleanup9() is called
> > > just after device_remove() which is calling the dev->driver_remove()
> > > callback. There are no runtime pm related calls in between that I can see.  
> >
> > On my side the device_remove() is calling dev->bus->remove() which is
> > platform_remove(), which calls the dev_pm_domain_detach(). The
> > dev_pm_domain_detach() detaches the ADC from it's PM domain. Because of
> > this, accessing now the ADC registers after a runtime resume leads to
> > failures pointed in this patch (as of my investigation) (as the ADC is not
> > anymore part of its PM domain and its PM domain is not started anymore
> > though runtime PM APIs).
> >
> > A similar issue was found while I was adding thermal support for RZ/G3S,
> > explained in
> > https://lore.kernel.org/all/20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com
> >
> >
> > Jonathan, Rafael, Ulf, all,
> >
> > Do consider OK to change the order in pm_runtime_disable_action() to get
> > rid of these issues, e.g.:
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 2ee45841486b..f27d311d2619 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> >
> >  static void pm_runtime_disable_action(void *data)
> >  {
> > -       pm_runtime_dont_use_autosuspend(data);
> >         pm_runtime_disable(data);
> > +       pm_runtime_dont_use_autosuspend(data);
> >  }
> >
> > though I see a rpm_resume() call is still possible though pm_runtime_disable().  
> 
> I am still worried about keeping the device runtime enabled during a
> window when we have turned off all resources for the device. Typically
> we want to leave the device in a low power state after unbind.
> 
> That said, I would rather just drop the devm_pm_runtime_enable() API
> altogether and convert all users of it into
> pm_runtime_enable|disable(), similar to what your patch does.

That is making a mess of a lot of automated cleanup for a strange
runtime pm related path.  This is pain a driver should not have
to deal with, though I'm not clear what the right solution is!

Key is that drivers should not mix devm managed cleanup and not, so
that means that anything that happens after runtime pm is enabled
has to be torn down manually.  One solution to this might be to
always enable it late assuming that is safe to do so there is
never anything else done after it in the probe path of a driver.

Jonathan

> 
> >
> > Thank you,
> > Claudiu  
> 
> [...]
> 
> Kind regards
> Uffe
> 


