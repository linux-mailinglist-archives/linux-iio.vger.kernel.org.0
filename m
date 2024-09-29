Return-Path: <linux-iio+bounces-9874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCC989549
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222F21F22BFB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0616EBEC;
	Sun, 29 Sep 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nodB1Uyq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D41DFF0;
	Sun, 29 Sep 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612479; cv=none; b=lAtrw3qDX8QufH600+Qi0Vy3IL6CHRI5QOqr1wuZ9HbmW4Chgo3cVUsGi/x2WY6JMfHUPKHxOE15g3imM3YNiCFZzn1AXDVjtCD525vGocaP8l2EizD5pirb3HYmBxdnEyb9TDcTlHRmNAZUqp/P0MeOAjaykuPV85r9xUKIPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612479; c=relaxed/simple;
	bh=EBg56fBxKkATly0fYo3X2MNQssGVaUEyOrr+QwaiP2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKE9y6+Qkc1Fmeye1e1TtVtkiYeEIEV7fs2oq6pfEubYCCDH+Qrx+dRZTVI0GcSSZtqxCB8MOK5t+io1+7fIQZP8Dsn+qHKCQDp4myDoVHXySHBy0G2hBNcLRlEoEIQ9xPVgaDIAgBGYWI/GTFbIkqZQasO7v467WNGLSLfdK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nodB1Uyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF61DC4CEC5;
	Sun, 29 Sep 2024 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727612478;
	bh=EBg56fBxKkATly0fYo3X2MNQssGVaUEyOrr+QwaiP2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nodB1UyqnazKim7Tlx6TA45GZ40YPv7iTa0wXUJmUC8wDaFuJ2e+qF3V5T4pTFIJ1
	 1g51zhPKP2+UZQON61tjiZGpYW6n2t2E40xe3hYVddspiffuvJOvEUkiPWabndD9I5
	 jlrHzhaYT4LaAjc5043fa81rJpnHniu21P8OUCMfbVtRfSEdxzwulgnQ3eApQlB1AA
	 Y6S3yzQx+CVRuFc77NWXcHNgcWntKr7W4yHe2BN92aXdXmmZrhUGugg3hBavBRtpCz
	 +AqjyROwVrpmMKkGnqhOaijcTvHeqIhMZnLwZtWvpA97GnXzxmvbj3WgvAL3j58KsO
	 k5iApke28su8w==
Date: Sun, 29 Sep 2024 13:21:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 10/10] iio: backend: adi-axi-dac: add registering of
 child fdt node
Message-ID: <20240929132109.6162d69d@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-10-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-10-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Change to obtain the fdt use case as reported in the
> adi,ad3552r.yaml file in this patchset.
> 
> The DAC device is defined as a child node of the backend.
> Registering the child fdt node as a platform devices.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
A few minor comments inline. 
> ---
>  drivers/iio/dac/adi-axi-dac.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 3ca3a14c575b..2afc1442cd5a 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
> +#include <linux/platform_data/ad3552r-axi.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -109,6 +110,8 @@ struct axi_dac_info {
>  struct axi_dac_state {
>  	struct regmap *regmap;
>  	struct device *dev;
> +	/* Target DAC platform device */
> +	struct platform_device *dac_pdev;
>  	/*
>  	 * lock to protect multiple accesses to the device registers and global
>  	 * data/variables.
> @@ -757,6 +760,32 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
>  	}
>  }
>  
> +static int axi_dac_create_platform_device(struct axi_dac_state *st,
> +					  struct fwnode_handle *child)
> +{
> +	struct ad3552r_axi_platform_data pdata = {
> +		.bus_reg_read = axi_dac_bus_reg_read,
> +		.bus_reg_write = axi_dac_bus_reg_write,
> +	};
> +	struct platform_device_info pi = {
> +		.parent = st->dev,
> +		.name = fwnode_get_name(child),
> +		.id = PLATFORM_DEVID_AUTO,
> +		.fwnode = child,
> +		.data = &pdata,
> +		.size_data = sizeof(pdata),
> +	};
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_register_full(&pi);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +

Register a devm cleanup here via devm_add_action_or_reset()
(see below for why)

> +	st->dac_pdev = pdev;
> +
> +	return 0;
> +}
> +
>  static const struct iio_backend_ops axi_dac_generic_ops = {
>  	.enable = axi_dac_enable,
>  	.disable = axi_dac_disable,
> @@ -791,13 +820,22 @@ static const struct regmap_config axi_dac_regmap_config = {
>  	.max_register = 0x0800,
>  };
>  
> +static void axi_dac_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct axi_dac_state *st = dev_get_drvdata(dev);
> +
> +	if (st->dac_pdev)
> +		platform_device_unregister(st->dac_pdev);

Use a devm_add_action_or_reset() So we don't need to introduce
a remove just to handle an optional bit of cleanup.
Also makes it much less likely we'll introduce ordering bugs
as the driver gets more complex in future.


> +}
> +
>  static int axi_dac_probe(struct platform_device *pdev)
>  {
>  	struct axi_dac_state *st;
>  	void __iomem *base;
>  	unsigned int ver;
>  	struct clk *clk;
> -	int ret;
> +	int ret, val;
>  
>  	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
>  	if (!st)
> @@ -871,6 +909,17 @@ static int axi_dac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to register iio backend\n");
>  
> +	device_for_each_child_node_scoped(&pdev->dev, child) {
> +		/* Processing only reg 0 node */

Pull int val; in here as not used outside of this scope.
Also, should only do this at all for compatibles that we know this
makes sense for.  Use some part specific flag to make that decision.


> +		ret = fwnode_property_read_u32(child, "reg", &val);
> +		if (ret || val != 0)
> +			continue;
> +
> +		ret = axi_dac_create_platform_device(st, child);
> +		if (ret)
> +			continue;
> +	}
> +
>  	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
> @@ -901,6 +950,7 @@ static struct platform_driver axi_dac_driver = {
>  		.of_match_table = axi_dac_of_match,
>  	},
>  	.probe = axi_dac_probe,
> +	.remove = axi_dac_remove,
>  };
>  module_platform_driver(axi_dac_driver);
>  
> 


