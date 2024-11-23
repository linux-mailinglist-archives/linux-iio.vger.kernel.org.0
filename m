Return-Path: <linux-iio+bounces-12534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FF9D699C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21915161694
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38B33080;
	Sat, 23 Nov 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCReMoGz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96F17583;
	Sat, 23 Nov 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375605; cv=none; b=s+1piSOfey+4nwt5GD5uK8nhFsB0zBiOKOOh8nz6pOmd6cDnOeK+Xmf4UjAH7p2WYmPSBYDoz/B8h0RcJMysFN+IpSP3jkQ8clGhQmuaNZl2EBBgHnM+yCTZom1BAvktB0GbVX5n/2JqQTC1AjiVq6VtJ0JZnHIqANqZZXSm1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375605; c=relaxed/simple;
	bh=0biYwIyVyr55triR7b1k2CW4N58okSMISG73ctLz4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQMaMRr61GQy2zQTxyEPDGz5p+T24H3N+B9fWLQItRaSiqv8+zVlaEO9BK/Jqshb1Q2p72UH5S792ekt0MBRi79EwMmHmev8T8tGx4dYaZBsJhMXF2SkbaDkYPQE44QGuBBIxgtgMHkK0tKNjhnjAMlEsKwpra5WiGkWcEp0+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCReMoGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC2C4CECD;
	Sat, 23 Nov 2024 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732375605;
	bh=0biYwIyVyr55triR7b1k2CW4N58okSMISG73ctLz4FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCReMoGzFC5wM2iT8hR4xtzRTfcOillkxMhFV8vaHGlrlaM8yje9cyBVlxEfqDc+f
	 2tSZk0+tU1rMBMoWAegOaIk3gGSjrMIdHqWCnNaM+9U09tVCUhEKMDSWYxJCH8ZKHG
	 fnF8SgwsqoAHJXfQSGXzG7MTAGjby5pmOA5ZyNfSlKvKE165dPV51Pq9fji9+pVDd6
	 wmR7zdu3rF96aMxerpBicoTqg/vv03Utmjmcm0+nQu1I442ZQxF6pH0c48Rh73yW89
	 Me6NgkvkbLWH/AiJsKKlDYdBLhpXrSvcY+0ErrtV/5N6xOCTJhBVPYB0AK6M7N0a1w
	 QT9hpjrhZBxHA==
Date: Sat, 23 Nov 2024 15:26:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC
 DRIVER), imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610
 ADC DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v4 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <20241123152637.27a66403@jic23-huawei>
In-Reply-To: <20241111213859.3317909-1-Frank.Li@nxp.com>
References: <20241111213859.3317909-1-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 16:38:58 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> Use devm_* and dev_err_probe() simplify probe function and remove
> vf610_adc_remove().
> 
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Hi Frank,

One (hopefully final) question inline.

Jonathan

> ---
> Change from v3 to v4
> - keep vref_uv as u32
> - keep original regulator part and only add
> devm_add_action_or_reset(&pdev->dev, vf610_adc_remove, info)
> 
> Change from v2 to v3
> - change vref_uv to int from u32 to fix below warning
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
>  drivers/iio/adc/vf610_adc.c | 79 ++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 4d83c12975c53..d4b778799755b 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -814,6 +814,14 @@ static const struct of_device_id vf610_adc_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, vf610_adc_match);
>  
> +static void vf610_adc_action_remove(void *d)
> +{
> +	struct vf610_adc *info = d;
> +
> +	if (info->vref)
> +		regulator_disable(info->vref);

Why is the check on info->vref needed?
vref is required to reach the point where this callback is registered.

> +}
> +
>  static int vf610_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -823,10 +831,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
> @@ -842,17 +848,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(info->dev, irq,
>  				vf610_adc_isr, 0,
>  				dev_name(&pdev->dev), indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
>  
> -	info->clk = devm_clk_get(&pdev->dev, "adc");
> -	if (IS_ERR(info->clk)) {
> -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> -						PTR_ERR(info->clk));
> -		return PTR_ERR(info->clk);
> -	}
> +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
>  
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(info->vref))
> @@ -862,6 +863,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);

As above, but this time if info->vref is not set, we have already returned so it 
must be set and doesn't need checking the callback.

> +	if (ret)
> +		return ret;
> +
>  	info->vref_uv = regulator_get_voltage(info->vref);
>  
>  	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
> @@ -879,52 +884,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
> @@ -972,7 +946,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
>  
>  static struct platform_driver vf610_adc_driver = {
>  	.probe          = vf610_adc_probe,
> -	.remove         = vf610_adc_remove,
>  	.driver         = {
>  		.name   = DRIVER_NAME,
>  		.of_match_table = vf610_adc_match,


