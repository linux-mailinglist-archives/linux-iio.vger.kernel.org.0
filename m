Return-Path: <linux-iio+bounces-13486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837409F2387
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01A31885F3C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD716F0E8;
	Sun, 15 Dec 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfpwKc02"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDD1487F6;
	Sun, 15 Dec 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734263862; cv=none; b=pyGDiWGGVTKmfwyOub8L+HZtFj8+tye1tofeWPkOAn0RDLUzCE7xObsQ4smEJjOUB22urYViwiVDoRtNO9TzvGWWLLZVHPQTWCI0qlY2RblfEQCquUDNEfBixgt+DK68pl/S8FkKZfNks6Md/puZtoOFWBQyGtRzwkjnIWGNyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734263862; c=relaxed/simple;
	bh=LlywyhwJ2uCFPB9hkqjwadkFoNCPIN3RVsuInxNHtmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2FU39CeTi8/7Me0TMubV5AFDOUk6apMA6JZyJBADJ8y+AEciZotkUCMQQQvxVFS/q+6+leo/1sKcDQQlCVcnIrqPikyI70Bx0QvJIVGnqqUDMtnKlqWez0Cc2t3AVzts/bksABBWIjBWDrTyjUEuQOpvZHhF3ctRrSmNjXd4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfpwKc02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E11BC4CECE;
	Sun, 15 Dec 2024 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734263862;
	bh=LlywyhwJ2uCFPB9hkqjwadkFoNCPIN3RVsuInxNHtmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WfpwKc02O9ZvpLlyzTBA/2D1BMHK8omkw+K6GPMi94L9sczxAXCVK9dj3f5IxiK0s
	 l81p44WjICgLkWZS/xYIPQcHNb10eXlfjUzKqQ10GI0+mI9SgSM5yHFL6t/A34rmpT
	 xczBEpANP0Sjx+m5NIRcuERIBP6kSIafFh5Ss4QeqOnCe0li5+kWi8I7M7qhIa/y3c
	 /GEwWBgApyENhX2r/dB3WVqzETXHMrk92jFtnWH8U4TdbQr9FYO9CB85YJEsfNI5P1
	 N0tECGyW9VfqQHzNtxENcRraRcG/6iOa1wN/vQ7v5M3T177uPpgEfC2ToxETt+zgip
	 LEAOng+ZYNIsA==
Date: Sun, 15 Dec 2024 11:57:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH v2 5/9] iio: adc: adi-axi-adc: Add platform children
 support
Message-ID: <20241215115730.4d62effe@jic23-huawei>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-5-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
	<20241210-ad7606_add_iio_backend_software_mode-v2-5-6619c3e50d81@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:46:45 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This is a preparation for the next commit adding support for register
> read and write functions on AD7606.
> Since sometimes a bus will be used, it has been agreed during ad3552's
> driver implementation that the device's driver bus is the backend, whose
> device node will be a child node.
> To provide the special callbacks for setting the register, axi-adc needs
> to pass them to the child device's driver through platform data.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 75 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index c7357601f0f8..7ff636643e56 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -80,7 +80,18 @@
>  	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
>  	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
>  
> +struct axi_adc_info {
> +	unsigned int version;
> +	const struct iio_backend_info *backend_info;
> +	bool bus_controller;
> +	const void *pdata;
> +	unsigned int pdata_sz;
> +};
> +
>  struct adi_axi_adc_state {
> +	/* Target ADC platform device */
> +	struct platform_device *adc_pdev;
> +	const struct axi_adc_info *info;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	/* lock to protect multiple accesses to the device registers */
> @@ -325,6 +336,40 @@ static const struct regmap_config axi_adc_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> +static void axi_adc_child_remove(void *data)
> +{
> +	struct adi_axi_adc_state *st = data;

With changes suggested below, the parameter becomes the pdev itself
and you can do this a one liner as we don't need the local variable.

> +
> +	platform_device_unregister(st->adc_pdev);
> +}
> +
> +static int axi_adc_create_platform_device(struct adi_axi_adc_state *st,
> +					  struct fwnode_handle *child)
> +{
> +	struct platform_device_info pi = {
> +		.parent = st->dev,
> +		.name = fwnode_get_name(child),
> +		.id = PLATFORM_DEVID_AUTO,
> +		.fwnode = child,
> +		.data = st->info->pdata,
> +		.size_data = st->info->pdata_sz,
> +	};
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	st->adc_pdev = pdev;
> +
> +	ret = devm_add_action_or_reset(st->dev, axi_adc_child_remove, st);
I'd be tempted to move this up above setting of st->adc_pdev and use
the pdev pointer as the parameter.

That way we don't end up with slightly odd (though harmless)
case of st->adc_pdev set to state data if we hit the error path and have
unregistered it.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.enable = axi_adc_enable,
>  	.disable = axi_adc_disable,
> @@ -370,7 +415,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
>  				     "failed to init register map\n");
>  
> -	expected_ver = device_get_match_data(&pdev->dev);
> +	st->info = device_get_match_data(&pdev->dev);
> +
> +	expected_ver = &st->info->version;
>  	if (!expected_ver)

That check is wrong.  It's st->info that in theory might not be set
(in practice it always is, but the check is meant to be on devie_get_match_data
result).


>  		return -ENODEV;
>  
> @@ -408,6 +455,25 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to register iio backend\n");
>  
> +	if (st->info->bus_controller) {
> +		device_for_each_child_node_scoped(&pdev->dev, child) {
> +			int val;
> +
> +			/* Processing only reg 0 node */
> +			ret = fwnode_property_read_u32(child, "reg", &val);
> +			if (ret || val != 0)
> +				continue;
> +			ret = fwnode_property_read_u32(child, "io-backends",
> +						       &val);
> +			if (ret)
> +				continue;
> +
> +			ret = axi_adc_create_platform_device(st, child);
> +			if (ret)
> +				continue;

You continue either way, so unless there will be more code here to come, just
don't check ret.

			/* Continue even on error */
			axi_adc_create_platform_device(st, child);

However, I'm not sure why it makes sense to carry on if this has failed.


> +		}
> +	}
> +
>  	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
> @@ -416,11 +482,14 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
> +static const struct axi_adc_info adc_generic = {
> +	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
> +	.backend_info = &adi_axi_adc_generic,
> +};
>  
>  /* Match table for of_platform binding */
>  static const struct of_device_id adi_axi_adc_of_match[] = {
> -	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
> +	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
>  	{ /* end of list */ }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
> 


