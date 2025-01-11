Return-Path: <linux-iio+bounces-14131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE0A0A3CC
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214003AA3E1
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833819DF98;
	Sat, 11 Jan 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFwgoUlq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C57139D;
	Sat, 11 Jan 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601259; cv=none; b=HlqecI76lYVofupVGjipyaT0kZFFj1JlurTi7PQDawGdE6jDo/0ygpY5DycQLu4hI42M1j0TjLRjATWS9mXIWg6PVSKHA4VaYZEDUZNv322QqkAfX7PGHzkXxef0FLmZAIis0dmKvWo4Ac0i/g5IRkwKKrUuXKpMxJXigIMrOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601259; c=relaxed/simple;
	bh=k4EXJXOLhq+59iAPaw0HeeVFSgJjpZl7H1P5fD8HAL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU10b4X9W8e+wK5N0TAV8MbThbddMniMOiKSfHwVIeYUl1Bnc8yBqAtKEH0xvg/pXcIdH/EYG2eXOGPNSD+pzBCCj6ptlL2JdZOraQwksjyREHWeu0JK+kmTOr1jdy5LCAIaN6P5D5edWWsrH9tXPm8MtV0EFAkgdUfGAc2ykOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFwgoUlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7028C4CED2;
	Sat, 11 Jan 2025 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736601258;
	bh=k4EXJXOLhq+59iAPaw0HeeVFSgJjpZl7H1P5fD8HAL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFwgoUlqSQ37227n86OHU3nbBw4l95vu9WyBT5Bbje+iLNdVoe+VCZgfv0Rcp1rkX
	 EImtwAw4gU2CnhVgMLGU5hLJhPWZQxHw5gNGX2lWkc6RWDPIvA9AV3XM4tP08syn/B
	 4WYsNhSi0m7X7dLn1l9DL9GC1omBYWV/bxk6i9797K+Nf3ywVNsJ8ylKKQOMLzRdvH
	 tn1xbpsQkXljVTWe1Wb7BDG4s4UnF5jIkRkBPvrzmmvlUk4ox88u5kbFbqaxxpAbIJ
	 xVipYwayfeHyHbSyFycsmnKWmrjjj6ay/gcodGJ3/6U5zubycB7XkUXxIq6d7xevWM
	 eyIbe4NQzcxFA==
Date: Sat, 11 Jan 2025 13:14:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 ulf.hansson@linaro.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <20250111131409.36bebfd3@jic23-huawei>
In-Reply-To: <44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
	<20250104135225.2573285b@jic23-huawei>
	<44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 11:18:41 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Jonathan,
> 
> 
> On 04.01.2025 15:52, Jonathan Cameron wrote:
> > On Fri,  3 Jan 2025 16:00:41 +0200
> > Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >   
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
> > +CC Rafael and linux-pm
> >   
> >>
> >> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> >> of a PM domain. The code that implements the PM domains support is in
> >> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> >> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> >> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> >> the documentation, instructs genpd to use the PM clk framework while
> >> powering on/off attached devices.
> >>
> >> During probe, the ADC device is attached to the PM domain
> >> controlling the ADC clocks. Similarly, during removal, the ADC device is
> >> detached from the PM domain.
> >>
> >> The detachment call stack is as follows:
> >>
> >> device_driver_detach() ->
> >>   device_release_driver_internal() ->
> >>     __device_release_driver() ->
> >>       device_remove() ->
> >>         platform_remove() ->
> >>           dev_pm_domain_detach()
> >>
> >> During driver unbind, after the ADC device is detached from its PM domain,
> >> the device_unbind_cleanup() function is called, which subsequently invokes
> >> devres_release_all(). This function handles devres resource cleanup.
> >>
> >> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> >> triggers the action or reset function for disabling runtime PM. This
> >> function is pm_runtime_disable_action(), which leads to the following call
> >> stack of interest when called:
> >>
> >> pm_runtime_disable_action() ->
> >>   pm_runtime_dont_use_autosuspend() ->  
> > 
> > So is the only real difference that in the code below you disable runtime pm
> > before autosuspend?  
> 
> No, the difference is that now, the driver specific runtime PM APIs are not
> called anymore (through the pointed call stack) after the ADC was removed
> from it's PM domain.

By my reading they are only not called now because you turn autosuspend off
after disabling runtime PM.

> 
> 
> >  Can you still do that with a devm callback just not
> > the standard one?  
> 
> No. It doesn't matter if we call the standard devm callback or driver
> specific one. As long as it is devm it will impact us as long as the driver
> specific runtime PM APIs are called through devres_release_all() after
> dev_pm_domain_detach(). And at that time the PM domain may be off along
> with its clocks disabled.

As above, I think that this is only the case because of the reordering
of those two calls, not something more fundamental.

In driver remove flow, device_unbind_cleanup9() is called
just after device_remove() which is calling the dev->driver_remove()
callback. There are no runtime pm related calls in between that I can see.

So you are moving these calls a little earlier but not in a fashion that
seems to have any involvement with anything else.


Call stack being
device_release_driver_internal()
-> __device_release_driver()
  -> device_remove() where you are now calling the disables
   .. some dma stuff
  -> device_unbind_cleanup() where the calling of disables previously was.

other than that unrelated DMA stuff there is nothing between the
two calls. 

There is runtime PM stuff before any of this, but not in the crucial
portion this code affects.

So I am thinking the only change that actually matters is the trivial
reorder mentioned above.





> 
> > 
> >   
> >>     __pm_runtime_use_autosuspend() ->
> >>       update_autosuspend() ->
> >>         rpm_idle()
> >>
> >> The rpm_idle() function attempts to runtime resume the ADC device.  
> > 
> > Can you give a little more on that path. I'm not immediately spotting
> > how rpm_idle() is causing a resume  
> 
> It is not in particular about the resume. Runtime suspend/resume after
> devres_release_all() will be affected.
> 
> In particular, the rpm_idle() can call rpm_suspend() (called on the out
> label of rpm_idle()) and rpm_suspend() may call the driver specific
> runtime_suspend API through the following code (from the rpm_suspend()
> function):
> 
>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> 
> 
> 
>         dev_pm_enable_wake_irq_check(dev, true);
> 
>         retval = rpm_callback(callback, dev);
> 
>         if (retval)
> 
>                 goto fail;
> 
> 
> 
> The full stack generated when running:
> # cd /sys/bus/platform/drivers/rzg2l-adc
> # while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done
> 
> is as follows:
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
> [   24.853618]  device_release_driver_internal+0x1ec/0x228
> [   24.858828]  device_driver_detach+0x18/0x24
> [   24.862998]  unbind_store+0xb4/0xb8
> [   24.866478]  drv_attr_store+0x24/0x38
> [   24.870135]  sysfs_kf_write+0x44/0x54
> [   24.873795]  kernfs_fop_write_iter+0x118/0x1a8
> [   24.878229]  vfs_write+0x2ac/0x358
> [   24.881627]  ksys_write+0x68/0xfc
> [   24.884934]  __arm64_sys_write+0x1c/0x28
> [   24.888846]  invoke_syscall+0x48/0x110
> [   24.892592]  el0_svc_common.constprop.0+0xc0/0xe0
> [   24.897285]  do_el0_svc+0x1c/0x28
> [   24.900593]  el0_svc+0x30/0xd0
> [   24.903647]  el0t_64_sync_handler+0xc8/0xcc
> [   24.907821]  el0t_64_sync+0x198/0x19c
> [   24.911481] Code: 910003fd f9403c00 f941bc01 f9400020 (b9400000)

Thanks, that was helpful.

> 
> 
> Digging it further today: on the Renesas RZ/G3S we implement the power
> domain on/off and we register the PM domain with GENPD_FLAG_PM_CLK. The
> on/off PM domain functionality is implemented though the clock controller
> MSTOP functionality which blocks the bus access to the specific IP (in this
> particular case to the ADC).
> 
> The issue is reproducible when doing:
> # cd /sys/bus/platform/drivers/rzg2l-adc
> # while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done
> 
> I noticed today that doing single manual unbind+bind doesn't always leads
> to aborts. It may be related to the fact that, as I noticed, the genpd
> power off is called asynchronously as a work (through
> genpd_power_off_work_fn()).
> 
> I also noticed today what when there is no on/off functionality implemented
> on the PM domain we have no failures (as the MSTOP is not implemented and
> the bus access to the specific IP is not blocked as there is no PM domain
> on/off available).

The PM domain stuff is only called later in device_unbind_cleanup()
so I don't see the relevance. All the code you are modifying is
done before that happens.

Jonathan


> 
> 
> 
> >   
> >> However,
> >> at the point it is called, the ADC device is no longer part of the PM
> >> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> >> APIs directly modifies hardware registers, the
> >> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> >> being enabled. This is because the PM domain no longer resumes along with
> >> the ADC device. As a result, this leads to system aborts.
> >>
> >> Drop the devres API for runtime PM enable.
> >>
> >> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
> > 
> > See below. I'm doubtful in general about the sequence changes and
> > specifically you can't just remove one devm callback from a driver without
> > modifying a lot of other code / leaving really fragile ordering.
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
> >>  1 file changed, 24 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> >> index 883c167c0670..f12f3daf08cc 100644
> >> --- a/drivers/iio/adc/rzg2l_adc.c
> >> +++ b/drivers/iio/adc/rzg2l_adc.c
> >> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >>  
> >>  	pm_runtime_set_autosuspend_delay(dev, 300);
> >>  	pm_runtime_use_autosuspend(dev);
> >> -	ret = devm_pm_runtime_enable(dev);
> >> -	if (ret)
> >> -		return ret;
> >> +	pm_runtime_enable(dev);
> >>  
> >>  	platform_set_drvdata(pdev, indio_dev);
> >>  
> >>  	ret = rzg2l_adc_hw_init(dev, adc);
> >> -	if (ret)
> >> -		return dev_err_probe(&pdev->dev, ret,
> >> -				     "failed to initialize ADC HW\n");
> >> +	if (ret) {
> >> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
> >> +		goto rpm_disable;
> >> +	}
> >>  
> >>  	irq = platform_get_irq(pdev, 0);
> >> -	if (irq < 0)
> >> -		return irq;
> >> +	if (irq < 0) {
> >> +		ret = irq;
> >> +		goto rpm_disable;
> >> +	}
> >>  
> >>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
> >>  			       0, dev_name(dev), adc);
> >>  	if (ret < 0)
> >> -		return ret;
> >> +		goto rpm_disable;
> >>  
> >>  	init_completion(&adc->completion);
> >>  
> >> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
> >>  	indio_dev->num_channels = adc->data->num_channels;
> >>  
> >>  	return devm_iio_device_register(dev, indio_dev);
> >> +
> >> +rpm_disable:
> >> +	pm_runtime_disable(dev);
> >> +	pm_runtime_dont_use_autosuspend(dev);
> >> +	return ret;  
> > If you have to move away from devm you must do it for all calls after
> > the first thing that is manually cleaned up.
> > As you have it here the userspace interfaces are left available at a point
> > well after power down.  
> 
> I see, thank you for pointing it.
> 
> And thank you for checking this,
> Claudiu
> 
> >   
> >> +}
> >> +
> >> +static void rzg2l_adc_remove(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +
> >> +	pm_runtime_disable(dev);
> >> +	pm_runtime_dont_use_autosuspend(dev);
> >>  }
> >>  
> >>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> >> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> >>  
> >>  static struct platform_driver rzg2l_adc_driver = {
> >>  	.probe		= rzg2l_adc_probe,
> >> +	.remove		= rzg2l_adc_remove,
> >>  	.driver		= {
> >>  		.name		= DRIVER_NAME,
> >>  		.of_match_table = rzg2l_adc_match,  
> >   
> 
> 


