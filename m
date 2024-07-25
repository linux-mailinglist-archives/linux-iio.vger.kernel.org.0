Return-Path: <linux-iio+bounces-7875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EF93C0CE
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FE3282C22
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AD199243;
	Thu, 25 Jul 2024 11:28:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA561991CF;
	Thu, 25 Jul 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906898; cv=none; b=IVy2PNGSQ+wOmb2elDDf3mR07wWdqXcdQXSxNj2GY5jPyYEc1YOhpTqN+GsGPTMzx4bXdX21988zbkzQ2ifo1Nz+Wf1owGdy5PkAQuMl2jZXiy0S3OD6NdLdR8QRzF525Et90q5nv0VJFEpAXf7WWrPrPUJQBFEpVtQH32h/Zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906898; c=relaxed/simple;
	bh=VAANHyNGA5/VJjDnDk2/qJvUM2HJY5E5xRGSD6Q5CKg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzwoqJFqR7CVlCGYzSmubVgPnBaYPxElgYPn2rjcWuWTF/qTOMKffrhN+lblvQVvzORLwIB/fG5SBHnT2mVVR1+I2j3quXCyLrQ8k9nkEa6MtfMMf5X3CgJzVPHo1r3Bx49xN4fptibAeJo+g36L7sI/QYaeXrgGcHTe9kMFXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WV7r75W2Fz6K5n7;
	Thu, 25 Jul 2024 19:26:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A74E21400C9;
	Thu, 25 Jul 2024 19:28:12 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 12:28:12 +0100
Date: Thu, 25 Jul 2024 12:28:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Denis Benato <benato.denis96@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Luke D . Jones" <luke@ljones.dev>, Jonathan
 LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH 2/2] iio: bmi323: suspend and resume triggering on
 relevant pm operations
Message-ID: <20240725122811.00004769@Huawei.com>
In-Reply-To: <20240725002641.191509-3-benato.denis96@gmail.com>
References: <20240725002641.191509-1-benato.denis96@gmail.com>
	<20240725002641.191509-3-benato.denis96@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Jul 2024 02:26:41 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> Prevent triggers from stop working after the device has entered sleep:
> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323.h      |  1 +
>  drivers/iio/imu/bmi323/bmi323_core.c | 29 ++++++++++++++++++++++++++++
>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
>  drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
>  4 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
> index dff126d41658..209bccb1f335 100644
> --- a/drivers/iio/imu/bmi323/bmi323.h
> +++ b/drivers/iio/imu/bmi323/bmi323.h
> @@ -205,5 +205,6 @@
>  struct device;
>  int bmi323_core_probe(struct device *dev);
>  extern const struct regmap_config bmi323_regmap_config;
> +extern const struct dev_pm_ops bmi323_core_pm_ops;
>  
>  #endif
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index d708d1fe3e42..b318544957de 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -2121,6 +2121,35 @@ int bmi323_core_probe(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> +#if defined(CONFIG_PM)
> +static int bmi323_core_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +

I want to think about patch 1 for a few days. In meantime.

> +	int ret = iio_device_suspend_triggering(indio_dev);

	return iio_device_suspend_triggering(indio_dev);

> +
> +	return ret;
> +}
> +
> +static int bmi323_core_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	int ret = iio_device_resume_triggering(indio_dev);
> +
> +	return ret;

	return iio_device_resume_triggering(indio_dev);

> +}
> +
> +#endif
> +
> +const struct dev_pm_ops bmi323_core_pm_ops = {
> +#if defined(CONFIG_PM)

SET_RUNTIME_PM_OPS() is defined to nothing if CONFIG_PM is
not enabled so these protections aren't needed.


> +	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
> +			   bmi323_core_runtime_resume, NULL)
> +#endif
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
> +
>  MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
>  MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 52140bf05765..79c9b029a209 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
>  static struct i2c_driver bmi323_i2c_driver = {
>  	.driver = {
>  		.name = "bmi323",
> +		.pm = &bmi323_core_pm_ops,

pm_ptr() to let the compiler drop bmi323_core_pm_ops if
!CONFIG_PM

>  		.of_match_table = bmi323_of_i2c_match,
>  		.acpi_match_table = bmi323_acpi_match,
>  	},
> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> index 7b1e8127d0dd..ec3238d93862 100644
> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
>  static struct spi_driver bmi323_spi_driver = {
>  	.driver = {
>  		.name = "bmi323",
> +		.pm = &bmi323_core_pm_ops,
>  		.of_match_table = bmi323_of_spi_match,
>  	},
>  	.probe = bmi323_spi_probe,


