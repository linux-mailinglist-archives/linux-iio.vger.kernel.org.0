Return-Path: <linux-iio+bounces-13893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFEA01514
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A930616399B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A21B4132;
	Sat,  4 Jan 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtfC7NPP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93F2BCF5;
	Sat,  4 Jan 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735998755; cv=none; b=jEJ8ebzlyo746skcRVoQ64YI05FKhcrLRzLmEpQcyFOzHRGdtpHPEHGp8+kps98qcHIaJJKUNOOsKGsYRH8U9BlA86/H4gu8/E6SKSUyY+hACDMcH7nCLS2nLx3pVfNU1egGAMRZsHrpg2rBu8TVP+8b4wm5AEOELkDgeG+56Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735998755; c=relaxed/simple;
	bh=fuJ6Xv6g78cSanjTIqLY4Vy63Tg6Aw6IFnUAIAbXxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIEYOrnfGjdGzueXKYdsdND/8VxLMyQutwdm+RGGWYFyHKGFNFYiSheYlr8zNdW6zUtKj4qZmaXu5qC2j8nYS89sowkD0ZkFkQbWVTq1lR9i5U2ohPtJSGjZ75as0G4oit64Kt8M/doF1iD8/9FLq+rh/3JvQbggRvMg6Yyxx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtfC7NPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4994AC4CED1;
	Sat,  4 Jan 2025 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735998754;
	bh=fuJ6Xv6g78cSanjTIqLY4Vy63Tg6Aw6IFnUAIAbXxCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LtfC7NPPIBDktZ7SSJshE5ufi41cs02gGsLtSDhcAwE1/quPk+6RG6X70gdyjK5xy
	 n4yGe6sjvvfJJEk5UjKhomMk6FVc0hRRQDRbKWPkKVat02We5MY1Op+6jSmny6AgfN
	 sOFHrKws3en2w9LqKW/yJprEc8slL8+V6Jz3JONqJOZa/e4vpzsJU8q0LNoLHQofM5
	 w7ovGSW5XDT1vz8q9YE1MW4qVCZLwi23s+YTvr70nkUkMiKjwuu552o55ThZ2fUTBT
	 quQe5ibURzfyQgEVMvPWck/V28mcvqlq4wGfnTcknR7QxBtwRNnm7nE78dSgG2C+ln
	 TUlcDmZfmioew==
Date: Sat, 4 Jan 2025 13:52:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 ulf.hansson@linaro.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <20250104135225.2573285b@jic23-huawei>
In-Reply-To: <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
	<20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 16:00:41 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+CC Rafael and linux-pm

> 
> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> of a PM domain. The code that implements the PM domains support is in
> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> the documentation, instructs genpd to use the PM clk framework while
> powering on/off attached devices.
> 
> During probe, the ADC device is attached to the PM domain
> controlling the ADC clocks. Similarly, during removal, the ADC device is
> detached from the PM domain.
> 
> The detachment call stack is as follows:
> 
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     __device_release_driver() ->
>       device_remove() ->
>         platform_remove() ->
>           dev_pm_domain_detach()
> 
> During driver unbind, after the ADC device is detached from its PM domain,
> the device_unbind_cleanup() function is called, which subsequently invokes
> devres_release_all(). This function handles devres resource cleanup.
> 
> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> triggers the action or reset function for disabling runtime PM. This
> function is pm_runtime_disable_action(), which leads to the following call
> stack of interest when called:
> 
> pm_runtime_disable_action() ->
>   pm_runtime_dont_use_autosuspend() ->

So is the only real difference that in the code below you disable runtime pm
before autosuspend?  Can you still do that with a devm callback just not
the standard one?


>     __pm_runtime_use_autosuspend() ->
>       update_autosuspend() ->
>         rpm_idle()
> 
> The rpm_idle() function attempts to runtime resume the ADC device.

Can you give a little more on that path. I'm not immediately spotting
how rpm_idle() is causing a resume

> However,
> at the point it is called, the ADC device is no longer part of the PM
> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> APIs directly modifies hardware registers, the
> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> being enabled. This is because the PM domain no longer resumes along with
> the ADC device. As a result, this leads to system aborts.
> 
> Drop the devres API for runtime PM enable.
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

See below. I'm doubtful in general about the sequence changes and
specifically you can't just remove one devm callback from a driver without
modifying a lot of other code / leaving really fragile ordering.

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 883c167c0670..f12f3daf08cc 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  
>  	pm_runtime_set_autosuspend_delay(dev, 300);
>  	pm_runtime_use_autosuspend(dev);
> -	ret = devm_pm_runtime_enable(dev);
> -	if (ret)
> -		return ret;
> +	pm_runtime_enable(dev);
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = rzg2l_adc_hw_init(dev, adc);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to initialize ADC HW\n");
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
> +		goto rpm_disable;
> +	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	if (irq < 0) {
> +		ret = irq;
> +		goto rpm_disable;
> +	}
>  
>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>  			       0, dev_name(dev), adc);
>  	if (ret < 0)
> -		return ret;
> +		goto rpm_disable;
>  
>  	init_completion(&adc->completion);
>  
> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  	indio_dev->num_channels = adc->data->num_channels;
>  
>  	return devm_iio_device_register(dev, indio_dev);
> +
> +rpm_disable:
> +	pm_runtime_disable(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	return ret;
If you have to move away from devm you must do it for all calls after
the first thing that is manually cleaned up.
As you have it here the userspace interfaces are left available at a point
well after power down.

> +}
> +
> +static void rzg2l_adc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
>  }
>  
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
>  
>  static struct platform_driver rzg2l_adc_driver = {
>  	.probe		= rzg2l_adc_probe,
> +	.remove		= rzg2l_adc_remove,
>  	.driver		= {
>  		.name		= DRIVER_NAME,
>  		.of_match_table = rzg2l_adc_match,


