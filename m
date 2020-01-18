Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9128D14174B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgARLls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgARLls (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:41:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30BB24694;
        Sat, 18 Jan 2020 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579347707;
        bh=6tljXsAw2fOLboN98Fjvuses261leqDgRz+OcJ7YGio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGa7Vbquyf/UYUgZ3f4qZNBKkLOOEy5joYz84+9i/8Q6N3OCI/FQuDYYiqzNgWDFg
         sQ2oD9cF4Hr91SscOsVDyeScX0tprZJDzKu6hnhswPiwQuYnIVGTMIP9Xk53OiN4Ns
         kl7uWZEeB9W6hd8Nm3cQJSDiDbmgKax0py0iD/Us=
Date:   Sat, 18 Jan 2020 11:41:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio: magnetometer: ak8975: Convert to use
 device_get_match_data()
Message-ID: <20200118114143.08943791@archlinux>
In-Reply-To: <20200115174425.70728-2-andriy.shevchenko@linux.intel.com>
References: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
        <20200115174425.70728-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jan 2020 19:44:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert to use device_get_match_data() instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan


> ---
>  drivers/iio/magnetometer/ak8975.c | 39 +++++++++++++------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 8e50e073bcbf..3c881541ae72 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -203,11 +203,11 @@ static long ak09912_raw_to_gauss(u16 data)
>  
>  /* Compatible Asahi Kasei Compass parts */
>  enum asahi_compass_chipset {
> +	AKXXXX		= 0,
>  	AK8975,
>  	AK8963,
>  	AK09911,
>  	AK09912,
> -	AK_MAX_TYPE
>  };
>  
>  enum ak_ctrl_reg_addr {
> @@ -245,7 +245,7 @@ struct ak_def {
>  	u8 data_regs[3];
>  };
>  
> -static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
> +static const struct ak_def ak_def_array[] = {
>  	{
>  		.type = AK8975,
>  		.raw_to_gauss = ak8975_raw_to_gauss,
> @@ -781,19 +781,6 @@ static const struct acpi_device_id ak_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
>  #endif
>  
> -static const char *ak8975_match_acpi_device(struct device *dev,
> -					    enum asahi_compass_chipset *chipset)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -	*chipset = (int)id->driver_data;
> -
> -	return dev_name(dev);
> -}
> -
>  static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  {
>  	struct ak8975_data *data = iio_priv(indio_dev);
> @@ -852,9 +839,11 @@ static int ak8975_probe(struct i2c_client *client,
>  	struct ak8975_data *data;
>  	struct iio_dev *indio_dev;
>  	struct gpio_desc *eoc_gpiod;
> +	const void *match;
> +	unsigned int i;
>  	int err;
> +	enum asahi_compass_chipset chipset;
>  	const char *name = NULL;
> -	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
>  
>  	/*
>  	 * Grab and set up the supplied GPIO.
> @@ -884,23 +873,27 @@ static int ak8975_probe(struct i2c_client *client,
>  		return err;
>  
>  	/* id will be NULL when enumerated via ACPI */
> -	if (id) {
> +	match = device_get_match_data(&client->dev);
> +	if (match) {
> +		chipset = (enum asahi_compass_chipset)(match);
> +		name = dev_name(&client->dev);
> +	} else if (id) {
>  		chipset = (enum asahi_compass_chipset)(id->driver_data);
>  		name = id->name;
> -	} else if (ACPI_HANDLE(&client->dev)) {
> -		name = ak8975_match_acpi_device(&client->dev, &chipset);
> -		if (!name)
> -			return -ENODEV;
>  	} else
>  		return -ENOSYS;
>  
> -	if (chipset >= AK_MAX_TYPE) {
> +	for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
> +		if (ak_def_array[i].type == chipset)
> +			break;
> +
> +	if (i == ARRAY_SIZE(ak_def_array)) {
>  		dev_err(&client->dev, "AKM device type unsupported: %d\n",
>  			chipset);
>  		return -ENODEV;
>  	}
>  
> -	data->def = &ak_def_array[chipset];
> +	data->def = &ak_def_array[i];
>  
>  	/* Fetch the regulators */
>  	data->vdd = devm_regulator_get(&client->dev, "vdd");

