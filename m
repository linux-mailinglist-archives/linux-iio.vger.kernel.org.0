Return-Path: <linux-iio+bounces-16424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB6A501C7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547B3174633
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D024E4B0;
	Wed,  5 Mar 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFdDkeg8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D1C2ED;
	Wed,  5 Mar 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184496; cv=none; b=C2LwAdMF0LmChy6EYemKNtJi/1GsOIcm0cxEDmBe2hJcksruUkuIkJRA/Aj8tWtfwv7U1AX3NfSKHJi4V+ikWP9NygZDCHwWQeOoZU/QFC6SoT7PNEQ//68ZnU4iAdMY0WQPTDLBjC5pIGJY0vqTbrx2gMFzY/g5Kepitx2WV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184496; c=relaxed/simple;
	bh=jvmchGdxVGZyNaODpuI7O279K1I8sOZ+LNSQ2rbqPXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRP8Zg50Sol8i+i+qxzXdu3KdnuzKcUg32bUr0xvJSqRUq/J/PYi3q/mZsx1JjgFvBAmxc0UT4rgqc+GGlF5BExvvt+puJJqb9QFwSy5pfi9xmbsmb8VoASE84Rd/qdiVWeNX18udC/IxpRoeL4reUGoqG2TVLdv3UlwdhNjgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFdDkeg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93567C4CED1;
	Wed,  5 Mar 2025 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184494;
	bh=jvmchGdxVGZyNaODpuI7O279K1I8sOZ+LNSQ2rbqPXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HFdDkeg8z5rr3Fue3DZgzCahgYCn6+S26dFM/oXCROCNHPq/q4QHiu/STez0WcVGD
	 EZxO1pqBuJTu7AXJuUGu3Eo130kDAidx0qZws1ccSkINkdh7dQ30Bqy3VW3CU4xv6Z
	 0tE2GFISgDSCEUyzMJgYmvea7fJEu1mxtk+9JNNkoGT79M2mHrru0fvjx6eWjUg1Hp
	 nhjFiap1xObsb5SVhb87A6p5aZy9k0S8MqFxjPUUa0thQuRTOKaowGBLtim179vGFH
	 hyZUTk0t+JyF9jlNzl1RNh70anXLVTto8XukqbucLkHMtsBgYkq7ONY/kpgKQLJeHe
	 1X7wkY1bDnu1A==
Date: Wed, 5 Mar 2025 14:21:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, gregkh@linuxfoundation.org, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: rzg2l_adc: Open a devres group
Message-ID: <20250305142122.626336c3@jic23-huawei>
In-Reply-To: <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
	<20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 14:06:06 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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
>     __pm_runtime_use_autosuspend() ->
>       update_autosuspend() ->
>         rpm_idle()
> 
> The rpm_idle() function attempts to runtime resume the ADC device. However,
> at the point it is called, the ADC device is no longer part of the PM
> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> APIs directly modifies hardware registers, the
> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> being enabled. This is because the PM domain no longer resumes along with
> the ADC device. As a result, this leads to system aborts.
> 
> Open a devres group in the driver probe and release it in the driver
> remove. This ensures the runtime PM is disabled (though the devres group)
> after the rzg2l_adc_remove() finishes its execution avoiding the described
> scenario.
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

+CC Greg KH given the in driver suggestion was his and I think
this discussion is not necessarily over!  Also Dmitry for his info.

> ---
> 
> Changes in v3:
> - open a devres group in probe and release it in remove; the failure
>   path of probe() was also updated to close the devres group
> - dropped Ulf's Rb tag as the patch is different now
> - updated the patch description to match the new approach
> 
> Note: a generic approach was proposed in [1] to have this in the platform
> bus itself but wasn't seen acceptable.
> 
> [1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/
> 

I missed this entirely sorry!  Travelling and far too much unread email
at the moment :(

Anyhow, I don't 'love' this solution but it can be made neater and perhaps
there is a mid way point using a new generic helper that will do the job.
> Changes in v2:
> - collected Ulf's tag
> - add a comment above pm_runtime_enable() explaining the reason
>   it shouldn't be converted to devres
> - drop devres calls that request IRQ and register IIO device
>   as proposed in the review process: Ulf, I still kept you Rb
>   tag; please let me know otherwise
> 
>  drivers/iio/adc/rzg2l_adc.c | 88 ++++++++++++++++++++++++++++---------
>  1 file changed, 67 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 883c167c0670..7db04416e1cf 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -85,6 +85,7 @@ struct rzg2l_adc {
>  	struct reset_control *adrstn;
>  	const struct rzg2l_adc_data *data;
>  	const struct rzg2l_adc_hw_params *hw_params;
> +	void *devres_group_id;
>  	struct completion completion;
>  	struct mutex lock;
>  	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> @@ -429,60 +430,88 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
In cases like this easiest path (and cleanest code) is
to rename probe to __rzg2l_adc_probe() or similar and...
>  	struct device *dev = &pdev->dev;
>  	struct iio_dev *indio_dev;
>  	struct rzg2l_adc *adc;
> +	void *devres_group_id;
>  	int ret;
>  	int irq;
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> -	if (!indio_dev)
Have this code in an outer wrapper rzg2l_adc_probe()
> +	/*
> +	 * Open a devres group to allow using devm_pm_runtime_enable()
> +	 * w/o interfeering with dev_pm_genpd_detach() in the platform bus
> +	 * remove. Otherwise, durring repeated unbind/bind operations,
> +	 * the ADC may be runtime resumed when it is not part of its power
> +	 * domain, leading to accessing ADC registers without its clocks
> +	 * being enabled and its PM domain being turned on.
> +	 */
> +	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!devres_group_id)
>  		return -ENOMEM;
>  
That then calls __rzg2l_adc_probe() here and if there is an error
release the groups.  That's the minimum change I'd suggest here.

Thinking forwards about what to do if we need to do this a lot.
Maybe we can provide a platform device specific helper for this case
that takes the 'actual probe' - here the __rzg2l_adc_probe() as
a parameter and handles the devres groups stuff.  That would
probably need a suitable devres_group_id in platform device you had
in your platform bus code proposal or some more fiddly code
not stash it in the driver specific structures that with the
iio_priv() dance in IIO would become IIO specific unless we
put one in struct iio_dev.  It might also be possible to write
a complex macro that would create the relevant probe/remove()
when passed both the internal __probe() and __remove and
a snippet that accesses ((struct bob *)iio_priv(x))->devres_group_id.

Anyhow that's a job for when we have several instances of this.

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		ret = -ENOMEM;
> +		goto release_group;
> +	}
> +
>  	adc = iio_priv(indio_dev);
>  
> +	adc->devres_group_id = devres_group_id;

With above scheme of a wrapper around original probe, this line would need
to move to the wrapper.

>  	adc->hw_params = device_get_match_data(dev);
> -	if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_MAX_CHANNELS)
> -		return -EINVAL;
> +	if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_MAX_CHANNELS) {
> +		ret = -EINVAL;
> +		goto release_group;
> +	}
>  
>  	ret = rzg2l_adc_parse_properties(pdev, adc);
>  	if (ret)
> -		return ret;
> +		goto release_group;
>  
>  	mutex_init(&adc->lock);
>  
>  	adc->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(adc->base))
> -		return PTR_ERR(adc->base);
> +	if (IS_ERR(adc->base)) {
> +		ret = PTR_ERR(adc->base);
> 	+		goto release_group;
> +	}
>  
>  	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
> -	if (IS_ERR(adc->adrstn))
> -		return dev_err_probe(dev, PTR_ERR(adc->adrstn),
> -				     "failed to get/deassert adrst-n\n");
> +	if (IS_ERR(adc->adrstn)) {
> +		ret = dev_err_probe(dev, PTR_ERR(adc->adrstn),
> +				    "failed to get/deassert adrst-n\n");
> +		goto release_group;
> +	}
>  
>  	adc->presetn = devm_reset_control_get_exclusive_deasserted(dev, "presetn");
> -	if (IS_ERR(adc->presetn))
> -		return dev_err_probe(dev, PTR_ERR(adc->presetn),
> -				     "failed to get/deassert presetn\n");
> +	if (IS_ERR(adc->presetn)) {
> +		ret = dev_err_probe(dev, PTR_ERR(adc->presetn),
> +				    "failed to get/deassert presetn\n");
> +		goto release_group;
> +	}
>  
>  	pm_runtime_set_autosuspend_delay(dev, 300);
>  	pm_runtime_use_autosuspend(dev);
>  	ret = devm_pm_runtime_enable(dev);
>  	if (ret)
> -		return ret;
> +		goto release_group;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = rzg2l_adc_hw_init(dev, adc);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to initialize ADC HW\n");
> +	if (ret) {
> +		ret = dev_err_probe(&pdev->dev, ret,
> +				    "failed to initialize ADC HW\n");
> +		goto release_group;
> +	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> +	if (irq < 0) {
> +		ret = irq;
> +		goto release_group;
> +	}
>  
>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>  			       0, dev_name(dev), adc);
>  	if (ret < 0)
> -		return ret;
> +		goto release_group;
>  
>  	init_completion(&adc->completion);
>  
> @@ -492,7 +521,23 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = adc->data->channels;
>  	indio_dev->num_channels = adc->data->num_channels;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto release_group;
> +
> +	return 0;
> +
> +release_group:
> +	devres_release_group(dev, devres_group_id);
> +	return ret;
> +}
> +
> +static void rzg2l_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct rzg2l_adc *adc = iio_priv(indio_dev);
> +
> +	devres_release_group(&pdev->dev, adc->devres_group_id);
>  }
>  
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> @@ -614,6 +659,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
>  
>  static struct platform_driver rzg2l_adc_driver = {
>  	.probe		= rzg2l_adc_probe,
> +	.remove		= rzg2l_adc_remove,
>  	.driver		= {
>  		.name		= DRIVER_NAME,
>  		.of_match_table = rzg2l_adc_match,


