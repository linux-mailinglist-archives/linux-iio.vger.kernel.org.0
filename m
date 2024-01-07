Return-Path: <linux-iio+bounces-1455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D31B8264F8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 17:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4718A1F225DC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4113AD2;
	Sun,  7 Jan 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcNi4Nzf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9713ADE
	for <linux-iio@vger.kernel.org>; Sun,  7 Jan 2024 16:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BCEC433C8;
	Sun,  7 Jan 2024 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643805;
	bh=q3qIpHB1K9BAC+/WN8dmTxiW7y2EWWvHRFag4FVR6u8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HcNi4NzfqpCQhTmHUjAt3TdZSTyBufCFA0yEMvs9lOSTCvlNSXxSXrQLB70TiaWFA
	 sNIM/wkslqCnUYp/geDnlnqyc11U9qgly1WU1CZ5RgnVOLaQjfxy2mpzELPixLs2sE
	 /qNaNpiQo56nBitImy3bwEYaTf7aKzuWmKZCdhqZZqQShQ5xpldmBO7HcnWHxEnHjt
	 2EFjfMOjTWRAZi944LYoaWl+2GkJAbeIJLrZMD+wO8x2cg02v5rVxRoOQdSUIAvd+A
	 2mOTqhpcyhG5hIQ/mlw6fufs0nM1cAv1bOBFTcU6qtiH791BWUeTDSXGS9wR8CT3og
	 NYJqJSk/0bvjQ==
Date: Sun, 7 Jan 2024 16:10:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: da280: Simplify id-matching
Message-ID: <20240107161001.45bed0f3@jic23-huawei>
In-Reply-To: <20240104160152.304100-1-hdegoede@redhat.com>
References: <20240104160152.304100-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jan 2024 17:01:52 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> da280_match_acpi_device() is a DIY version of acpi_device_get_match_data(),
> so it can be dropped.
> 
> And things can be simplified further by using i2c_get_match_data() which
> will also check i2c_client_id style ids.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
LGTM
Applied to the togreg branch of iio.git but note I will be rebasing that
on rc1 once it is available.  So in meantime this is only pushed out as
testing to give 0-day a head start.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Add a new da280_match_data struct to hold the name + num_channels and
>   use that instead of the da280_chipset enum
> - Error check i2c_get_match_data() returning NULL
> 
> Handle i2c_get_match_data() returning NULL on missing match-data
> ---
>  drivers/iio/accel/da280.c | 64 +++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 572bfe9694b0..756e2ea7c056 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -23,8 +23,6 @@
>  #define DA280_MODE_ENABLE		0x1e
>  #define DA280_MODE_DISABLE		0x9e
>  
> -enum da280_chipset { da217, da226, da280 };
> -
>  /*
>   * a value of + or -4096 corresponds to + or - 1G
>   * scale = 9.81 / 4096 = 0.002395019
> @@ -47,6 +45,11 @@ static const struct iio_chan_spec da280_channels[] = {
>  	DA280_CHANNEL(DA280_REG_ACC_Z_LSB, Z),
>  };
>  
> +struct da280_match_data {
> +	const char *name;
> +	int num_channels;
> +};
> +
>  struct da280_data {
>  	struct i2c_client *client;
>  };
> @@ -89,17 +92,6 @@ static const struct iio_info da280_info = {
>  	.read_raw	= da280_read_raw,
>  };
>  
> -static enum da280_chipset da280_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return -EINVAL;
> -
> -	return (enum da280_chipset) id->driver_data;
> -}
> -
>  static void da280_disable(void *client)
>  {
>  	da280_enable(client, false);
> @@ -107,16 +99,21 @@ static void da280_disable(void *client)
>  
>  static int da280_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> -	int ret;
> +	const struct da280_match_data *match_data;
>  	struct iio_dev *indio_dev;
>  	struct da280_data *data;
> -	enum da280_chipset chip;
> +	int ret;
>  
>  	ret = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
>  	if (ret != DA280_CHIP_ID)
>  		return (ret < 0) ? ret : -ENODEV;
>  
> +	match_data = i2c_get_match_data(client);
> +	if (!match_data) {
> +		dev_err(&client->dev, "Error match-data not set\n");
> +		return -EINVAL;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -127,23 +124,8 @@ static int da280_probe(struct i2c_client *client)
>  	indio_dev->info = &da280_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = da280_channels;
> -
> -	if (ACPI_HANDLE(&client->dev)) {
> -		chip = da280_match_acpi_device(&client->dev);
> -	} else {
> -		chip = id->driver_data;
> -	}
> -
> -	if (chip == da217) {
> -		indio_dev->name = "da217";
> -		indio_dev->num_channels = 3;
> -	} else if (chip == da226) {
> -		indio_dev->name = "da226";
> -		indio_dev->num_channels = 2;
> -	} else {
> -		indio_dev->name = "da280";
> -		indio_dev->num_channels = 3;
> -	}
> +	indio_dev->num_channels = match_data->num_channels;
> +	indio_dev->name = match_data->name;
>  
>  	ret = da280_enable(client, true);
>  	if (ret < 0)
> @@ -168,17 +150,21 @@ static int da280_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
>  
> +static const struct da280_match_data da217_match_data = { "da217", 3 };
> +static const struct da280_match_data da226_match_data = { "da226", 2 };
> +static const struct da280_match_data da280_match_data = { "da280", 3 };
> +
>  static const struct acpi_device_id da280_acpi_match[] = {
> -	{"NSA2513", da217},
> -	{"MIRAACC", da280},
> -	{},
> +	{ "NSA2513", (kernel_ulong_t)&da217_match_data },
> +	{ "MIRAACC", (kernel_ulong_t)&da280_match_data },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>  
>  static const struct i2c_device_id da280_i2c_id[] = {
> -	{ "da217", da217 },
> -	{ "da226", da226 },
> -	{ "da280", da280 },
> +	{ "da217", (kernel_ulong_t)&da217_match_data },
> +	{ "da226", (kernel_ulong_t)&da226_match_data },
> +	{ "da280", (kernel_ulong_t)&da280_match_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, da280_i2c_id);


