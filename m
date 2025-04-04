Return-Path: <linux-iio+bounces-17622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35630A7C244
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892AE7A688F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8DA20E01B;
	Fri,  4 Apr 2025 17:18:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C11D9A79;
	Fri,  4 Apr 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787105; cv=none; b=t7K/YSkGK6GNOXJ6kthwU/6fn89kzmj9ERT+NzAN6lhIGDl1nEJaCjqN1elskaV6+1+iv6iFHylo4gqtwJ8lO3FSpSXrXXPhTcjKC76jqbkH5RMv+Da3WQjWz9o/9V7+Wo1iZ6YuKMSuH1YGV5wGhLMDT7CZgx7IkVO6sSeQiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787105; c=relaxed/simple;
	bh=Rt41I0mzz8tXTxW+b2Zg2LkNB5uLygFHxSEy52L5pPY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efSchbxTwA2MA8SJNgJCstNSOFs0z+yqIce3p2QwnKPuDj8H5knZewYu1Rh2gMlf2VTUMdvMRDMz4lOFHUPs0gKMGoJIBP76et9Db0BsJiBmTjoWDVB1RRT4XCJlUxMqB9+W6BVWWIy/gqlqPLjOthNBh5tPBSG1TlseZt/8ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTlfT3g9jz6L51l;
	Sat,  5 Apr 2025 01:17:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77CEC1407F5;
	Sat,  5 Apr 2025 01:18:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 19:18:19 +0200
Date: Fri, 4 Apr 2025 18:18:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: switch to use generic name
 irq get
Message-ID: <20250404181818.000051ad@huawei.com>
In-Reply-To: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-2-72ed5100da14@tdk.com>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
	<20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-2-72ed5100da14@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 04 Apr 2025 17:52:03 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Use generic fwnode_irq_get_byname() for getting interrupt pin using
> interrupt name.
> Only INT1 is supported by the driver currently.
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 13 +++++++++++--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  |  2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  2 +-
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 18787a43477b89db12caee597ab040af5c8f52d5..f893dbe6996506a33eb5d3be47e6765a923665c9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -426,7 +426,7 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval);
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  			    inv_icm42600_bus_setup bus_setup);
>  
>  struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index ef9875d3b79db116f9fb4f6d881a7979292c1792..bfdd7cd5fafae87ad7c6204f6dd3bef17935b3f9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -683,12 +683,13 @@ static void inv_icm42600_disable_pm(void *_data)
>  	pm_runtime_disable(dev);
>  }
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  			    inv_icm42600_bus_setup bus_setup)
>  {
>  	struct device *dev = regmap_get_device(regmap);
>  	struct inv_icm42600_state *st;
> -	int irq_type;
> +	struct fwnode_handle *fwnode;
> +	int irq, irq_type;
>  	bool open_drain;
>  	int ret;
>  
> @@ -697,6 +698,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  		return -ENODEV;
>  	}
>  
> +	/* get INT1 only supported interrupt */
> +	fwnode = dev_fwnode(dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
This needs to 'then' - possibly with a dev_info() - fallback to
using 
	fwnode_irq_get(fwnode, 0);
to get what would have previously been in spi->irq , i2c->irq etc
as I assume there is DT out in the wild without the names provided.

Jonathan

> +
>  	irq_type = irq_get_trigger_type(irq);
>  	if (!irq_type)
>  		irq_type = IRQF_TRIGGER_FALLING;
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 04e440fe023aa3869529b0f0be003ea0544bfb8d..38cc0d7834fcb96dabc401f29d613cf9fc75b8f5 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -67,7 +67,7 @@ static int inv_icm42600_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip, client->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_i2c_bus_setup);
>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> index 2bd2c4c8e50c3fe081e882aca6c64736510b474c..f40a09c4cbfc673e76922d13d61a3634785300ec 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -64,7 +64,7 @@ static int inv_icm42600_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> +	return inv_icm42600_core_probe(regmap, chip,
>  				       inv_icm42600_spi_bus_setup);
>  }
>  
> 


