Return-Path: <linux-iio+bounces-14379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADBA127BE
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9BC166C63
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68891531E2;
	Wed, 15 Jan 2025 15:42:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0686336;
	Wed, 15 Jan 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955755; cv=none; b=MBjw/YmB70EEgx0SDrg1kFIOCNUUvu4lOFGyRRNfhlxzZQdh/5phrC4A3iO2DR1Exg3zmG51kTV4SkfPEU+A2yUTfkNqEBhDugt+i2EUd3DiF4r85H+5fHj46pUUZSL2yBBIUB+wIhymXKewI1EbHSerF4dxUnAS7MGIsZ8a2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955755; c=relaxed/simple;
	bh=BlVdU7WbYhvFxgN82gszB+ccPfkJ489wTLwOA0UK4QQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5z1PD8CDZegnY1gtHoukyz8VDmtt0YqdqGNlkwyJMhqPylhNMirSPooz7ZYqJURFiPkHHf41zhMShBDyz8nradnUUsctU1F7R12ExVSb2gFN8/BCejxK/eCRTkIJxWL/rHGxMrBHnCssOQSYIjlubkjbyqyJWSDQYAwWXX3VjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY99T6H3Hz6K5q1;
	Wed, 15 Jan 2025 23:37:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 60330140A35;
	Wed, 15 Jan 2025 23:42:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 16:42:28 +0100
Date: Wed, 15 Jan 2025 15:42:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: Jonathan Cameron <jic23@kernel.org>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <lars@metafoo.de>,
	<ulf.hansson@linaro.org>, <linux-iio@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <20250115154227.00000760@huawei.com>
In-Reply-To: <bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
	<20250104135225.2573285b@jic23-huawei>
	<44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
	<20250111131409.36bebfd3@jic23-huawei>
	<bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
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

On Wed, 15 Jan 2025 15:37:57 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Jonathan,
> 
> Thank you for your input!
> 
> On 11.01.2025 15:14, Jonathan Cameron wrote:
> > On Mon, 6 Jan 2025 11:18:41 +0200
> > Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >   
> >> Hi, Jonathan,
> >>
> >>
> >> On 04.01.2025 15:52, Jonathan Cameron wrote:  
> >>> On Fri,  3 Jan 2025 16:00:41 +0200
> >>> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>     
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>    
> >>> +CC Rafael and linux-pm
> >>>     
> >>>>
> >>>> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> >>>> of a PM domain. The code that implements the PM domains support is in
> >>>> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> >>>> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> >>>> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> >>>> the documentation, instructs genpd to use the PM clk framework while
> >>>> powering on/off attached devices.
> >>>>
> >>>> During probe, the ADC device is attached to the PM domain
> >>>> controlling the ADC clocks. Similarly, during removal, the ADC device is
> >>>> detached from the PM domain.
> >>>>
> >>>> The detachment call stack is as follows:
> >>>>
> >>>> device_driver_detach() ->
> >>>>   device_release_driver_internal() ->
> >>>>     __device_release_driver() ->
> >>>>       device_remove() ->
> >>>>         platform_remove() ->
> >>>>           dev_pm_domain_detach()
> >>>>
> >>>> During driver unbind, after the ADC device is detached from its PM domain,
> >>>> the device_unbind_cleanup() function is called, which subsequently invokes
> >>>> devres_release_all(). This function handles devres resource cleanup.
> >>>>
> >>>> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> >>>> triggers the action or reset function for disabling runtime PM. This
> >>>> function is pm_runtime_disable_action(), which leads to the following call
> >>>> stack of interest when called:
> >>>>
> >>>> pm_runtime_disable_action() ->
> >>>>   pm_runtime_dont_use_autosuspend() ->    
> >>>
> >>> So is the only real difference that in the code below you disable runtime pm
> >>> before autosuspend?    
> >>
> >> No, the difference is that now, the driver specific runtime PM APIs are not
> >> called anymore (through the pointed call stack) after the ADC was removed
> >> from it's PM domain.  
> > 
> > By my reading they are only not called now because you turn autosuspend off
> > after disabling runtime PM.  
> 
> Sorry, I wanted to say that the runtime PM APIs are not called anymore from
> devm_action_release(), though this call stack:
> 
> [   24.801195] Call trace:
> [   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
> [   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
> [   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
> [   24.818580]  __rpm_callback+0x48/0x198
> [   24.822319]  rpm_callback+0x68/0x74
> [   24.825798]  rpm_suspend+0x100/0x578
> [   24.829362]  rpm_idle+0xd0/0x17c
> [   24.832582]  update_autosuspend+0x30/0xc4
> [   24.836580]  pm_runtime_disable_action+0x40/0x64
> [   24.841184]  devm_action_release+0x14/0x20
> [   24.845274]  devres_release_all+0xa0/0x100
> [   24.849361]  device_unbind_cleanup+0x18/0x60
> 
> This is because I dropped the devm_pm_runtime_enable() which registers the
> pm_runtime_disable_action(), which is called at the time the
> device_unbind_cleanup() is called, which is called when the ADC is not
> anymore part of its PM domain.
> 
> If I change the order in remove function proposed in this patch, thus do:
> 
> +static void rzg2l_adc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  }
> 
> nothing changes with the behavior of this patch. There will be no issue if
> the device is runtime suspended/resumed through the
> pm_runtime_dont_use_autosuspend() because at the time the
> rzg2l_adc_remove() is called the ADC is still part of the PM domain.
> 
> 
> 
> >   
> >>
> >>  
> >>>  Can you still do that with a devm callback just not
> >>> the standard one?    
> >>
> >> No. It doesn't matter if we call the standard devm callback or driver
> >> specific one. As long as it is devm it will impact us as long as the driver
> >> specific runtime PM APIs are called through devres_release_all() after
> >> dev_pm_domain_detach(). And at that time the PM domain may be off along
> >> with its clocks disabled.  
> > 
> > As above, I think that this is only the case because of the reordering
> > of those two calls, not something more fundamental.  
> 
> I tried having a local devm function (the following diff applied with this
> patch reverted) identical with pm_runtime_disable_action():
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 22a581c894f8..459cc9c67eec 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -423,6 +423,12 @@ static int rzg2l_adc_hw_init(struct device *dev,
> struct rzg2l_adc *adc)
>         return ret;
>  }
> 
> +static void rzg2l_pm_runtime_disable(void *data)
> +{
> +       pm_runtime_dont_use_autosuspend(data);
> +       pm_runtime_disable(data);
> +}
> +
>  static int rzg2l_adc_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -463,7 +469,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> 
>         pm_runtime_set_autosuspend_delay(dev, 300);
>         pm_runtime_use_autosuspend(dev);
> -       ret = devm_pm_runtime_enable(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret = devm_add_action_or_reset(dev, rzg2l_pm_runtime_disable, dev);
>         if (ret)
>                 return ret;
> 
> With this the issue is still reproducible.
> 
> However, changing the order of functions in rzg2l_pm_runtime_disable() and
> having it like:
> 
> +static void rzg2l_pm_runtime_disable(void *data)
> +{
> +       pm_runtime_disable(data);
> +       pm_runtime_dont_use_autosuspend(data);
> +}
> 
> 
> leads to no failure when doing unbind/bind.
> 
> However, I see the pm_runtime_disable() can still call rpm_resume() under
> certain conditions. It can still lead to failures if it is called after the
> device was remove from its PM domain.
> 
> > 
> > In driver remove flow, device_unbind_cleanup9() is called
> > just after device_remove() which is calling the dev->driver_remove()
> > callback. There are no runtime pm related calls in between that I can see.  
> 
> On my side the device_remove() is calling dev->bus->remove() which is
> platform_remove(), which calls the dev_pm_domain_detach(). The
> dev_pm_domain_detach() detaches the ADC from it's PM domain. Because of
> this, accessing now the ADC registers after a runtime resume leads to
> failures pointed in this patch (as of my investigation) (as the ADC is not
> anymore part of its PM domain and its PM domain is not started anymore
> though runtime PM APIs).
> 
> A similar issue was found while I was adding thermal support for RZ/G3S,
> explained in
> https://lore.kernel.org/all/20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com
> 
> 
> Jonathan, Rafael, Ulf, all,
> 
> Do consider OK to change the order in pm_runtime_disable_action() to get
> rid of these issues, e.g.:
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2ee45841486b..f27d311d2619 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> 
>  static void pm_runtime_disable_action(void *data)
>  {
> -       pm_runtime_dont_use_autosuspend(data);
>         pm_runtime_disable(data);
> +       pm_runtime_dont_use_autosuspend(data);
>  }
> 
> though I see a rpm_resume() call is still possible though pm_runtime_disable().

This isn't the right fix.  I was just trying to get to the bottom of why
your fix worked and reordering was a false path. If we go ahead with this
patch, then put them in the same order as in pm_runtime_disable_action()
and add a nice big comment on why we have to do them manually.

Now you've talked me through the call of platform_remove() I can see the
dev_pm_domain_detach(). It seems odd that is called before 
the devres manged part of device tear down.

The change here to me smells like a hack to get around that and looks
like a bad idea from a maintenance point of view.

Rafael/all, right approach or should we do something else?

Jonathan


> 
> Thank you,
> Claudiu
> 
> > 
> > So you are moving these calls a little earlier but not in a fashion that
> > seems to have any involvement with anything else.
> > 
> > 
> > Call stack being
> > device_release_driver_internal()  
> > -> __device_release_driver()
> >   -> device_remove() where you are now calling the disables  
> >    .. some dma stuff  
> >   -> device_unbind_cleanup() where the calling of disables previously was.  
> > 
> > other than that unrelated DMA stuff there is nothing between the
> > two calls. 
> > 
> > There is runtime PM stuff before any of this, but not in the crucial
> > portion this code affects.
> > 
> > So I am thinking the only change that actually matters is the trivial
> > reorder mentioned above.
> > 
> > 
> > 
> > 
> >   
> >>  
> >>>
> >>>     
> >>>>     __pm_runtime_use_autosuspend() ->
> >>>>       update_autosuspend() ->
> >>>>         rpm_idle()
> >>>>
> >>>> The rpm_idle() function attempts to runtime resume the ADC device.    
> >>>
> >>> Can you give a little more on that path. I'm not immediately spotting
> >>> how rpm_idle() is causing a resume    
> >>
> >> It is not in particular about the resume. Runtime suspend/resume after
> >> devres_release_all() will be affected.
> >>
> >> In particular, the rpm_idle() can call rpm_suspend() (called on the out
> >> label of rpm_idle()) and rpm_suspend() may call the driver specific
> >> runtime_suspend API through the following code (from the rpm_suspend()
> >> function):
> >>
> >>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> >>
> >>
> >>
> >>         dev_pm_enable_wake_irq_check(dev, true);
> >>
> >>         retval = rpm_callback(callback, dev);
> >>
> >>         if (retval)
> >>
> >>                 goto fail;
> >>
> >>
> >>
> >> The full stack generated when running:
> >> # cd /sys/bus/platform/drivers/rzg2l-adc
> >> # while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done
> >>
> >> is as follows:
> >>
> >> [   24.801195] Call trace:
> >> [   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
> >> [   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
> >> [   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
> >> [   24.818580]  __rpm_callback+0x48/0x198
> >> [   24.822319]  rpm_callback+0x68/0x74
> >> [   24.825798]  rpm_suspend+0x100/0x578
> >> [   24.829362]  rpm_idle+0xd0/0x17c
> >> [   24.832582]  update_autosuspend+0x30/0xc4
> >> [   24.836580]  pm_runtime_disable_action+0x40/0x64
> >> [   24.841184]  devm_action_release+0x14/0x20
> >> [   24.845274]  devres_release_all+0xa0/0x100
> >> [   24.849361]  device_unbind_cleanup+0x18/0x60
> >> [   24.853618]  device_release_driver_internal+0x1ec/0x228
> >> [   24.858828]  device_driver_detach+0x18/0x24
> >> [   24.862998]  unbind_store+0xb4/0xb8
> >> [   24.866478]  drv_attr_store+0x24/0x38
> >> [   24.870135]  sysfs_kf_write+0x44/0x54
> >> [   24.873795]  kernfs_fop_write_iter+0x118/0x1a8
> >> [   24.878229]  vfs_write+0x2ac/0x358
> >> [   24.881627]  ksys_write+0x68/0xfc
> >> [   24.884934]  __arm64_sys_write+0x1c/0x28
> >> [   24.888846]  invoke_syscall+0x48/0x110
> >> [   24.892592]  el0_svc_common.constprop.0+0xc0/0xe0
> >> [   24.897285]  do_el0_svc+0x1c/0x28
> >> [   24.900593]  el0_svc+0x30/0xd0
> >> [   24.903647]  el0t_64_sync_handler+0xc8/0xcc
> >> [   24.907821]  el0t_64_sync+0x198/0x19c
> >> [   24.911481] Code: 910003fd f9403c00 f941bc01 f9400020 (b9400000)  
> > 
> > Thanks, that was helpful.
> >   
> >>
> >>
> >> Digging it further today: on the Renesas RZ/G3S we implement the power
> >> domain on/off and we register the PM domain with GENPD_FLAG_PM_CLK. The
> >> on/off PM domain functionality is implemented though the clock controller
> >> MSTOP functionality which blocks the bus access to the specific IP (in this
> >> particular case to the ADC).
> >>
> >> The issue is reproducible when doing:
> >> # cd /sys/bus/platform/drivers/rzg2l-adc
> >> # while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done
> >>
> >> I noticed today that doing single manual unbind+bind doesn't always leads
> >> to aborts. It may be related to the fact that, as I noticed, the genpd
> >> power off is called asynchronously as a work (through
> >> genpd_power_off_work_fn()).
> >>
> >> I also noticed today what when there is no on/off functionality implemented
> >> on the PM domain we have no failures (as the MSTOP is not implemented and
> >> the bus access to the specific IP is not blocked as there is no PM domain
> >> on/off available).  
> > 
> > The PM domain stuff is only called later in device_unbind_cleanup()
> > so I don't see the relevance. All the code you are modifying is
> > done before that happens.
> > 
> > Jonathan
> > 
> >   
> >>
> >>
> >>  
> >>>     
> >>>> However,
> >>>> at the point it is called, the ADC device is no longer part of the PM
> >>>> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> >>>> APIs directly modifies hardware registers, the
> >>>> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> >>>> being enabled. This is because the PM domain no longer resumes along with
> >>>> the ADC device. As a result, this leads to system aborts.
> >>>>
> >>>> Drop the devres API for runtime PM enable.
> >>>>
> >>>> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>    
> >>>
> >>> See below. I'm doubtful in general about the sequence changes and
> >>> specifically you can't just remove one devm callback from a driver without
> >>> modifying a lot of other code / leaving really fragile ordering.
> >>>
> >>> Jonathan
> >>>     
> >>>> ---
> >>>>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
> >>>>  1 file changed, 24 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> >>>> index 883c167c0670..f12f3daf08cc 100644
> >>>> --- a/drivers/iio/adc/rzg2l_adc.c
> >>>> +++ b/drivers/iio/adc/rzg2l_adc.c
> >>>> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >>>>  
> >>>>  	pm_runtime_set_autosuspend_delay(dev, 300);
> >>>>  	pm_runtime_use_autosuspend(dev);
> >>>> -	ret = devm_pm_runtime_enable(dev);
> >>>> -	if (ret)
> >>>> -		return ret;
> >>>> +	pm_runtime_enable(dev);
> >>>>  
> >>>>  	platform_set_drvdata(pdev, indio_dev);
> >>>>  
> >>>>  	ret = rzg2l_adc_hw_init(dev, adc);
> >>>> -	if (ret)
> >>>> -		return dev_err_probe(&pdev->dev, ret,
> >>>> -				     "failed to initialize ADC HW\n");
> >>>> +	if (ret) {
> >>>> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
> >>>> +		goto rpm_disable;
> >>>> +	}
> >>>>  
> >>>>  	irq = platform_get_irq(pdev, 0);
> >>>> -	if (irq < 0)
> >>>> -		return irq;
> >>>> +	if (irq < 0) {
> >>>> +		ret = irq;
> >>>> +		goto rpm_disable;
> >>>> +	}
> >>>>  
> >>>>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
> >>>>  			       0, dev_name(dev), adc);
> >>>>  	if (ret < 0)
> >>>> -		return ret;
> >>>> +		goto rpm_disable;
> >>>>  
> >>>>  	init_completion(&adc->completion);
> >>>>  
> >>>> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >>>>  	indio_dev->num_channels = adc->data->num_channels;
> >>>>  
> >>>>  	return devm_iio_device_register(dev, indio_dev);
> >>>> +
> >>>> +rpm_disable:
> >>>> +	pm_runtime_disable(dev);
> >>>> +	pm_runtime_dont_use_autosuspend(dev);
> >>>> +	return ret;    
> >>> If you have to move away from devm you must do it for all calls after
> >>> the first thing that is manually cleaned up.
> >>> As you have it here the userspace interfaces are left available at a point
> >>> well after power down.    
> >>
> >> I see, thank you for pointing it.
> >>
> >> And thank you for checking this,
> >> Claudiu
> >>  
> >>>     
> >>>> +}
> >>>> +
> >>>> +static void rzg2l_adc_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +	struct device *dev = &pdev->dev;
> >>>> +
> >>>> +	pm_runtime_disable(dev);
> >>>> +	pm_runtime_dont_use_autosuspend(dev);
> >>>>  }
> >>>>  
> >>>>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> >>>> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> >>>>  
> >>>>  static struct platform_driver rzg2l_adc_driver = {
> >>>>  	.probe		= rzg2l_adc_probe,
> >>>> +	.remove		= rzg2l_adc_remove,
> >>>>  	.driver		= {
> >>>>  		.name		= DRIVER_NAME,
> >>>>  		.of_match_table = rzg2l_adc_match,    
> >>>     
> >>
> >>  
> >   
> 
> 
> 


