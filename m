Return-Path: <linux-iio+bounces-11329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F729B1798
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AE31C21671
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198B1D3648;
	Sat, 26 Oct 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9SmRvhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF81D3565;
	Sat, 26 Oct 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943448; cv=none; b=jHyeqOUUqrl2DPLZZudcBBIZ5WxOS/wKzIHwYqt0cuyNPb2o+5yfCT7IAYRqXC4wbaRamPr4QZb5u2/ZEphSRVkINZBpbHeC9awBDi5cPL3IosMZwjuSETUPyR2CHr8CUtD5wa7m+2K+gky8bZ0gBCskU0Gb0o3P+3dNYvLEMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943448; c=relaxed/simple;
	bh=aK82E2vFaeXQFWmctQ76NuKQdJ8A74uPxIr0gxqp9MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2VPVjfObOFi/GwZh6g++lYz2+BEMC/QRoVPwX9ASWNBGomBHOZRWpyS3+07m0Yrd4WI7HXX5qpWkPRbaLs8/eHEQVtn819lmS5z9Lx2BhcJACArVps0TGkv8nebn+fjtPm+BX/jvvBonyabaSzFjPxNpZ1NsKHIhuHDbRAqtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9SmRvhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FC5C4CEC6;
	Sat, 26 Oct 2024 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943447;
	bh=aK82E2vFaeXQFWmctQ76NuKQdJ8A74uPxIr0gxqp9MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9SmRvhiyEgjI9gWgT17t2ETUCkJFTQOYIRC+dzHBIOSi3ejNztdrmncP0SqQOfay
	 N6NkZrZ79d2sAZeYrVAtbr1ea3uVR+Cld9okR9cMWwC8zzNjapZllo6QcjWZyUvyZt
	 XkTXzEgkm5aC8zL7+Zabd8FMKfIJeaAGX40u2QkrLKFYxslQTCQbHGPqTb9yKmYFXR
	 MF+qDOiuAw2zxrTxRUU5UngU42JjZ3tC/ubgKL+VlmXggZNf9wN7jAaAxJwph1ELT+
	 NSFmesm60oxiVMmezWC2x2YcjoxcsBWUkfC4yK7BuPjLTciRmxjXbAZCoyOZ0z3i4I
	 ga2fXxTsBilmg==
Date: Sat, 26 Oct 2024 12:50:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 20/24] iio: light: isl29018: Replace a variant of
 iio_get_acpi_device_name_and_data()
Message-ID: <20241026125010.651dfe50@jic23-huawei>
In-Reply-To: <20241024191200.229894-21-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-21-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:09 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace a variant of iio_get_acpi_device_name_and_data().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
This one briefly had me confused but is indeed fine because we never
get an id match for a device coming from an ACPI binding.
There is no way to make such a match (unlike DT where the naming
is enough).

So the else is sufficient.

applied.
> ---
>  drivers/iio/light/isl29018.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index 8dfc750e68c0..526ee5619d26 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -687,20 +687,6 @@ static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
>  	},
>  };
>  
> -static const char *isl29018_match_acpi_device(struct device *dev, int *data)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -
> -	if (!id)
> -		return NULL;
> -
> -	*data = (int)id->driver_data;
> -
> -	return dev_name(dev);
> -}
> -
>  static void isl29018_disable_regulator_action(void *_data)
>  {
>  	struct isl29018_chip *chip = _data;
> @@ -716,9 +702,10 @@ static int isl29018_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct isl29018_chip *chip;
>  	struct iio_dev *indio_dev;
> +	const void *ddata;
> +	const char *name;
> +	int dev_id;
>  	int err;
> -	const char *name = NULL;
> -	int dev_id = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
> @@ -731,11 +718,11 @@ static int isl29018_probe(struct i2c_client *client)
>  	if (id) {
>  		name = id->name;
>  		dev_id = id->driver_data;
> +	} else {
> +		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
> +		dev_id = (intptr_t)ddata;
>  	}
>  
> -	if (ACPI_HANDLE(&client->dev))
> -		name = isl29018_match_acpi_device(&client->dev, &dev_id);
> -
>  	mutex_init(&chip->lock);
>  
>  	chip->type = dev_id;


