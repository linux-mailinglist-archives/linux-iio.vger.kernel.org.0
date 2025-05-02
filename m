Return-Path: <linux-iio+bounces-18972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E41AA6DE2
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1817E0E8
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698A2144C9;
	Fri,  2 May 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrDZoCOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4952581;
	Fri,  2 May 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177554; cv=none; b=Rl6GXmSm+m6qlqzOh6+rbmxXcBDqwAbiKgEoyGzeVbdBv9G5MT1TIE95s2VPSZBxjUXtFoCKGZcAClVTUdYaHTYyXhRs9qkcIQKdgX8VL/lQ8erL3iBchLP0yRbHlucCWRvePD6a9OhumxFh+9xJ8G63U/sgOJ3pDZjrElAiEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177554; c=relaxed/simple;
	bh=MFpxA82+s0xDYFhqNWYy4401pZNByCJq1VYxaSbaCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAwBraBz8xmKWGgLLaw3bav2vKvbgoh0HaSnYtAkzHkSykx/GloyGj7ISJvpHxOEAr2zSGXaO9dYbIpwBj51yqBxYgHWBP2kXKP20r3n8lDiVBJ5mmoqxthbL9DPELJLksBg6r8wl6GGmruisFdZSiOn9cH73uRCV6LVAWovV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrDZoCOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8141DC4CEE4;
	Fri,  2 May 2025 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746177553;
	bh=MFpxA82+s0xDYFhqNWYy4401pZNByCJq1VYxaSbaCDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TrDZoCOmRCpk7nxiyJBMG1RLedCB3iaScef4VBEnLYC49Ysz6ZwvYJ+XHaS7YKSBu
	 ulgM3sW4Kc6cOUxCP6O2Ht3pFbN0FbOHbcAqGiWe6M2O5Cq7C9U0kzC/bHuSBR6HcV
	 PdwkKLjQtkMhyH3l23IahYw9RAnjIYf6Um0rVFIk1xE8MXumNMdltLAE+UXiGVdSJR
	 lHA09fl5nnOK0YVAxrpFFjX4gLJQZCQmIrXW44txTQdXrYZB+nfp4oAD2WZO9lVhWj
	 Qgcpb500DJzlC/L2LuUrMN0lTr3/guxuk2hpBaTIyA4ZabQOymwrKMg3Qo1YQ6VkKp
	 v5oAPF3k/p6jQ==
Date: Fri, 2 May 2025 10:19:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/1] thermal: thermal-generic-adc: add temperature
 sensor channel
Message-ID: <20250502101907.6350fa25@jic23-huawei>
In-Reply-To: <20250430055807.11805-2-clamor95@gmail.com>
References: <20250430055807.11805-1-clamor95@gmail.com>
	<20250430055807.11805-2-clamor95@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 08:58:07 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
+CC linux-iio for info and maybe some more eyes.

> ---
>  drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index ee3d0aa31406..7c844589b153 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -7,6 +7,7 @@
>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
>   */
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -73,6 +74,58 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
>  	.get_temp = gadc_thermal_get_temp,
>  };
>  
> +static const struct iio_chan_spec gadc_thermal_iio_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info gadc_thermal_iio_info = {
> +	.read_raw = gadc_thermal_read_raw,
> +};
> +
> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
> +{
> +	struct gadc_thermal_info *gtinfo;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gtinfo));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	gtinfo = iio_priv(indio_dev);
> +	memcpy(gtinfo, gti, sizeof(*gtinfo));
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &gadc_thermal_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = gadc_thermal_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
>  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
>  						 struct gadc_thermal_info *gti)
>  {
> @@ -153,7 +206,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>  
>  	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>  
> -	return 0;
> +	return gadc_iio_register(&pdev->dev, gti);
>  }
>  
>  static const struct of_device_id of_adc_thermal_match[] = {


