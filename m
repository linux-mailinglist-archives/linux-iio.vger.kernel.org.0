Return-Path: <linux-iio+bounces-12066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334009C2D79
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F55B20EE1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D71178395;
	Sat,  9 Nov 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONo6cqzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A031BC3F;
	Sat,  9 Nov 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157673; cv=none; b=VA3mgzWTa5kKuk8q+Qk6XV32YJZGn6LMdZI+vKAdSQjOWOosau7NLmZkFXgjSA/PodsRoJ8nCZhY/dJj6WtQQ0ALYUL2yBTe+bDaeRYIoCdsQTquoVP7+6Z2zprVWe+UJtmuhSpo0iQsvIgK3PRa4rRajR7QYfyQHqHIftMi/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157673; c=relaxed/simple;
	bh=mz3ygL6ghAPSUR/rvz1iMEHA/Q0JA2uc2oWEHYtRe2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub8tHb3RHdF8KT3dPrPAQHxyho38G7JcCZyw6S3pFayRYbJpfcY4j2DUJRv/cXPln7A5Wxk4f9JFjcCy0XT+STADoe0uglD9+jSzewPswZjS9vSUxJTxgm78a0r1XkLSBAG91S7Ix8hndQjUw5lZyagwENyP8VrSY34WKl2ZWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONo6cqzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6006FC4CECE;
	Sat,  9 Nov 2024 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731157672;
	bh=mz3ygL6ghAPSUR/rvz1iMEHA/Q0JA2uc2oWEHYtRe2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONo6cqzl1B3eIQxU+RO+qwWqJiCLizjHEYjHV/dXk9C/7qg3vSh6/iEagXj+u0JPe
	 wEFDZNDyQzFQk0vPidjDYfVSgi26pi18eY+1qSwgoTfEBnqoNkfUNyrvrdM8XSlJZ+
	 qnTahBu38us7xIpd5PM1jgxQQR0E/AXAVHsCMXfcYaxMqZaOtexUHWo6LN2bwA6EQS
	 zHlqT1Tk/XrQDuPeRVLuAiLDESdoxhwaiHNhNz551ELWxpyxKuQCMVdN3cnPk4UClf
	 uA5Xsc/M27rdI0oUAcQQ6ZuTDNwBTiF3KAHSzllXt9HgJftoFa0gwcM+ily94l9vDx
	 vFno64oZ6i7pg==
Date: Sat, 9 Nov 2024 13:07:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC
 DRIVER), imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610
 ADC DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <20241109130746.4620e3f1@jic23-huawei>
In-Reply-To: <20241107191842.3002319-1-Frank.Li@nxp.com>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 14:18:40 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> Use devm_* and dev_err_probe() simplify probe function and remove
> vf610_adc_remove(). Change type of 'vref_uv' to int because
> regulator_get_voltage() return type is int.
> 
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
One comment inline. 

> ---
> Change from v2 to v3
> - change vref_uv to int from u32 to fix below warning

That's not the nicest way to fix the issue. See below.

> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/
> smatch warnings:
> drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.
> 
> vim +857 drivers/iio/adc/vf610_adc.c
> 
> Change from v1 to v2
> - add Haibo's review tag
> ---
>  drivers/iio/adc/vf610_adc.c | 79 ++++++++++---------------------------
>  1 file changed, 20 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 4d83c12975c53..a6a0ada8a102f 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -160,7 +160,7 @@ struct vf610_adc {
>  	/* lock to protect against multiple access to the device */
>  	struct mutex lock;
>  
> -	u32 vref_uv;
> +	int vref_uv;
>  	u32 value;
>  	struct regulator *vref;
>  
> @@ -823,10 +823,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> -	if (!indio_dev) {
> -		dev_err(&pdev->dev, "Failed allocating iio device\n");
> -		return -ENOMEM;
> -	}
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
>  
>  	info = iio_priv(indio_dev);
>  	info->dev = &pdev->dev;
> @@ -842,27 +840,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(info->dev, irq,
>  				vf610_adc_isr, 0,
>  				dev_name(&pdev->dev), indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
>  
> -	info->clk = devm_clk_get(&pdev->dev, "adc");
> -	if (IS_ERR(info->clk)) {
> -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> -						PTR_ERR(info->clk));
> -		return PTR_ERR(info->clk);
> -	}
> +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
> +				     "failed getting clock, err = %ld\n",
> +				     PTR_ERR(info->clk));
>  
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(info->vref))
>  		return PTR_ERR(info->vref);
>  
> -	ret = regulator_enable(info->vref);
> -	if (ret)
> -		return ret;
> -
> -	info->vref_uv = regulator_get_voltage(info->vref);
> +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
> +	if (info->vref_uv < 0)
> +		return info->vref_uv;
whilst I've suggested not doing this in this fashion anyway so this code will probably
go away but in general prefer this sort of handling done as

	ret = devm_regulator_get_enable_read_voltage();
	if (ret < 0)
		return ret;

	info->vref_uv = ret;

so that we don't bounce a potential error code through a state variable and have
to change the type as you have done here.
>  
>  	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
>  
> @@ -879,52 +872,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = vf610_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
>  
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Could not prepare or enable the clock.\n");
> -		goto error_adc_clk_enable;
> -	}
> -
>  	vf610_adc_cfg_init(info);
>  	vf610_adc_hw_init(info);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> -					NULL, &iio_triggered_buffer_setup_ops);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
> -		goto error_iio_device_register;
> -	}
> +	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
> +					      NULL, &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
>  
>  	mutex_init(&info->lock);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Couldn't register the device.\n");
> -		goto error_adc_buffer_init;
> -	}
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
>  
>  	return 0;
> -
> -error_adc_buffer_init:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_iio_device_register:
> -	clk_disable_unprepare(info->clk);
> -error_adc_clk_enable:
> -	regulator_disable(info->vref);
> -
> -	return ret;
> -}
> -
> -static void vf610_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct vf610_adc *info = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	regulator_disable(info->vref);
> -	clk_disable_unprepare(info->clk);
>  }
>  
>  static int vf610_adc_suspend(struct device *dev)
> @@ -972,7 +934,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
>  
>  static struct platform_driver vf610_adc_driver = {
>  	.probe          = vf610_adc_probe,
> -	.remove         = vf610_adc_remove,
>  	.driver         = {
>  		.name   = DRIVER_NAME,
>  		.of_match_table = vf610_adc_match,


