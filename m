Return-Path: <linux-iio+bounces-11317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E206D9B175E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD591C21521
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7481D1F76;
	Sat, 26 Oct 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thlPECxx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088D0217F29;
	Sat, 26 Oct 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941495; cv=none; b=IACX6L1gMFNEYyjEI+kTatCSofDJ2kv/QiNYWaP6HLwCRQG3Y9ZNFstWRSbCXldgaWfYEDIFBWA2BomNEfAwhjdUHzS/nIgfccLacr8cfClqi0BXtfPMeV4f/x9+1Gvi/KJpWU9TfyyY++H8gAqYx5t7wUN+78jf/hH+k4ajzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941495; c=relaxed/simple;
	bh=qxVO3EdOnZ0Wf+fLdgdrtzazFILHCRBZiZXEXN+B2rM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLs1H4hI58bsMnoTXc+1yuGkIn+jd+Q+69sWEUH9b2cyolazLTIsAO4SeCneNLIl33GyXSOukMn+Cqcckz7wBH43HAQet+AAJbpH/7PKDcb/y1wkXYsxeyp6yBRNvMRFvG1dNkRdV7RWVnkdOMwluHZLzvupErIEvRmztp8n9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thlPECxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A135CC4CEC6;
	Sat, 26 Oct 2024 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941494;
	bh=qxVO3EdOnZ0Wf+fLdgdrtzazFILHCRBZiZXEXN+B2rM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thlPECxxESMywqALhXpfwzYZZWfn87nwV1d64TuQrkNgv+6Ub6I2wQ7XTLBCR4XRe
	 4Z/CBbZbDRRYKaCMB02D8c6L72bMgmP2aMQ5PWKcL6VOq8tutsV0Tt126FdmiAgJkl
	 SqN8RISXGixh14as4h/Xy3gxZbRU4XDBM64mmI5B5nlOdxFrL1/tUUblZciMSLQz3a
	 vGBgMavIG566xOX356vsMAm6lhHMS2qZ3V4IWPXdLrui36QnsYYe1khjkUuMvYnWeh
	 PxGyA3MVeWFVFmhka9NqBt7rqsgdEaPcSA20IVixutrQYBM3U2rS0MFc2a8i4BXlhc
	 wqr8ohbBPC7Yw==
Date: Sat, 26 Oct 2024 12:17:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 08/24] iio: accel: kxcjk-1013: Switch from CONFIG_PM
 guards to pm_ptr() etc
Message-ID: <20241026121733.4d18426e@jic23-huawei>
In-Reply-To: <20241024191200.229894-9-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-9-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:57 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied. Indeed good to get rid of remaining cases of this.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 208e701e1aed..0cc34e17a23f 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -315,7 +315,7 @@ static const char *const kxtf9_samp_freq_avail =
>  	"25 50 100 200 400 800";
>  
>  /* Refer to section 4 of the specification */
> -static __maybe_unused const struct {
> +static const struct {
>  	int odr_bits;
>  	int usec;
>  } odr_start_up_times[KX_MAX_CHIPS][12] = {
> @@ -601,7 +601,6 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
>  static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
>  {
>  	int i;
> @@ -614,7 +613,6 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
>  
>  	return KXCJK1013_MAX_STARTUP_TIME_US;
>  }
> -#endif
>  
>  static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  {
> @@ -1636,7 +1634,6 @@ static void kxcjk1013_remove(struct i2c_client *client)
>  	mutex_unlock(&data->mutex);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int kxcjk1013_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1664,9 +1661,7 @@ static int kxcjk1013_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
> -#ifdef CONFIG_PM
>  static int kxcjk1013_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1700,12 +1695,10 @@ static int kxcjk1013_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops kxcjk1013_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
> -	SET_RUNTIME_PM_OPS(kxcjk1013_runtime_suspend,
> -			   kxcjk1013_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
> +	RUNTIME_PM_OPS(kxcjk1013_runtime_suspend, kxcjk1013_runtime_resume, NULL)
>  };
>  
>  static const struct i2c_device_id kxcjk1013_id[] = {
> @@ -1734,7 +1727,7 @@ static struct i2c_driver kxcjk1013_driver = {
>  		.name	= KXCJK1013_DRV_NAME,
>  		.acpi_match_table = ACPI_PTR(kx_acpi_match),
>  		.of_match_table = kxcjk1013_of_match,
> -		.pm	= &kxcjk1013_pm_ops,
> +		.pm	= pm_ptr(&kxcjk1013_pm_ops),
>  	},
>  	.probe		= kxcjk1013_probe,
>  	.remove		= kxcjk1013_remove,


