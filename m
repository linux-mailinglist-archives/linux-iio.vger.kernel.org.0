Return-Path: <linux-iio+bounces-20080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0BEAC9BD5
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170F3BD949
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3586323;
	Sat, 31 May 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceM3X11a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF5187876;
	Sat, 31 May 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748710763; cv=none; b=h29teyGpqzs6C1/AToUTBTAqd83zbDwSTDqcS/P26zn+pAu+SdQuk4MzsGGG6NfTkHPs+GWY57UKwEB6Du77PaJqs+tSvu8HmWP9gx+PUNjW0igp+5JglMaCJiJBO85LbWPtNvgtCyWGK9gQA7S1YVsQSRezQJJsp2wyi1nTkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748710763; c=relaxed/simple;
	bh=020HNIG7VGv4tWglrR3QM9zbyoK4KILepGoPbR3KKYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sq9mt2PVf+TXHi6ksZaf3HkhyXzyp+15ZCyLlBse1vxsPpPsb+1XaMpHpfp5MdkIx3lRcsv1pgWpo7SxplWNI8kiD35fk6HcBE1AC74i6ukvc+eRRfJdG+1gyYsD3EKXrw92p4VStp1zAuk2VlbkFosyS9G0A+BYF3+kSGe8lMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceM3X11a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB6C4CEE3;
	Sat, 31 May 2025 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748710762;
	bh=020HNIG7VGv4tWglrR3QM9zbyoK4KILepGoPbR3KKYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ceM3X11ayXqkmDcFAw3UJfnl2nF43MG7ei8iTLYD7TLfUJ7byPXpdGkuh3vNXvavC
	 0WtgSPcGjJFRqc1xtVrhjp1ogdKWeZas7Zk2Oomz+qcdn4Yu/IlGVQMyRTkOCOqnIi
	 l0UaB8D/nMcmPRI5C24/gOqwTcycjE7ifiq3qG9/LVodanzD5g70CdyBrIAXlzFegR
	 rWDuhGP4/EublgUfn4P6CzvB0YHMw3P3lbL+ZST+iBod7tnuz2ZIyjlCAhExcc9x0b
	 WW+YHMvBNBOieV2Zl/Us4b8ZzYIj6U7nHvZSZiII4FKlkkPZbEwZPHWE4GOTptrAY/
	 uBwQPZbBN02Xw==
Date: Sat, 31 May 2025 17:59:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alex Lanzano <lanzano.alex@gmail.com>, Andy
 Shevchenko <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Danila Tikhonov <danila@jiaxyga.com>, Greg KH <gregkh@linuxfoundation.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Justin Weiss <justin@justinweiss.com>
Subject: Re: [PATCH v2 1/2] iio: bmi270: suspend and resume triggering on
 relevant pm operations
Message-ID: <20250531175913.251d64d3@jic23-huawei>
In-Reply-To: <20250525142530.71955-2-benato.denis96@gmail.com>
References: <20250525142530.71955-1-benato.denis96@gmail.com>
	<20250525142530.71955-2-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 16:25:29 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> Prevent triggers from stop working after the device has entered sleep:
> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.
> 
> Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com

This is a tag, so no blank line here.

I've fixed this in both patches and applied them to the to testing branch of iio.
Currently I'm not planning to rush these in but I could treat them as fixes if
general view is that I should.

> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Tested-by: Justin Weiss <justin@justinweiss.com>
> ---
>  drivers/iio/imu/bmi270/bmi270.h      |  2 ++
>  drivers/iio/imu/bmi270/bmi270_core.c | 20 ++++++++++++++++++++
>  drivers/iio/imu/bmi270/bmi270_i2c.c  |  2 ++
>  drivers/iio/imu/bmi270/bmi270_spi.c  |  2 ++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index d94525f6aee8..a6c4204032fc 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -20,4 +20,6 @@ struct device;
>  int bmi270_core_probe(struct device *dev, struct regmap *regmap,
>  		      const struct bmi270_chip_info *chip_info);
>  
> +extern const struct dev_pm_ops bmi270_core_pm_ops;
> +
>  #endif  /* BMI270_H_ */
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 2e4469f30d53..b54658f972ad 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -982,6 +982,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->available_scan_masks = bmi270_avail_scan_masks;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmi270_info;
> +	dev_set_drvdata(data->dev, indio_dev);
>  
>  	ret = bmi270_trigger_probe(data, indio_dev);
>  	if (ret)
> @@ -997,6 +998,25 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap,
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi270_core_probe, "IIO_BMI270");
>  
> +static int bmi270_core_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return iio_device_suspend_triggering(indio_dev);
> +}
> +
> +static int bmi270_core_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return iio_device_resume_triggering(indio_dev);
> +}
> +
> +const struct dev_pm_ops bmi270_core_pm_ops = {
> +	RUNTIME_PM_OPS(bmi270_core_runtime_suspend, bmi270_core_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi270_core_pm_ops, "IIO_BMI270");
> +
>  MODULE_AUTHOR("Alex Lanzano");
>  MODULE_DESCRIPTION("BMI270 driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 44699ab58909..c77839b03a96 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -4,6 +4,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  
>  #include "bmi270.h"
> @@ -52,6 +53,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct i2c_driver bmi270_i2c_driver = {
>  	.driver = {
>  		.name = "bmi270_i2c",
> +		.pm = pm_ptr(&bmi270_core_pm_ops),
>  		.acpi_match_table = bmi270_acpi_match,
>  		.of_match_table = bmi270_of_match,
>  	},
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index 88a77aba5e4f..19dd7734f9d0 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -3,6 +3,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> @@ -79,6 +80,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct spi_driver bmi270_spi_driver = {
>  	.driver = {
>  		.name = "bmi270",
> +		.pm = pm_ptr(&bmi270_core_pm_ops),
>  		.of_match_table = bmi270_of_match,
>  	},
>  	.probe = bmi270_spi_probe,


