Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1738D6A6
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 19:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhEVRhJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 13:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhEVRhJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 13:37:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC4C6100B;
        Sat, 22 May 2021 17:35:41 +0000 (UTC)
Date:   Sat, 22 May 2021 18:37:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/8] iio: accel: bmc150: Move check for second ACPI
 device into a separate function
Message-ID: <20210522183703.4328c4d8@jic23-huawei>
In-Reply-To: <20210521171418.393871-4-hdegoede@redhat.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
        <20210521171418.393871-4-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 May 2021 19:14:13 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Move the check for a second ACPI device for BOSC0200 ACPI fwnodes into
> a new bmc150_acpi_dual_accel_probe() helper function.
> 
> This is a preparation patch for adding support for a new "DUAL250E" ACPI
> Hardware-ID (HID) used on some devices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

A few places I'd like comments rewrapped on basis of still having
a minor preference for a 80 chars limit unless there is a reason to
do otherwise.

If this is all that turns up in the series, I can do that whilst
applying.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/bmc150-accel-i2c.c | 80 +++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 2afaae0294ee..e24ce28a4660 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -21,6 +21,51 @@
>  
>  #include "bmc150-accel.h"
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
> +	{"BOSC0200"},
> +	{ },
> +};
> +
> +/*
> + * Some acpi_devices describe 2 accelerometers in a single ACPI device, try instantiating

80 char wrap still preferred when it doesn't otherwise hurt readability.

> + * a second i2c_client for an I2cSerialBusV2 ACPI resource with index 1.
> + */
> +static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> +	struct i2c_client *second_dev;
> +	struct i2c_board_info board_info = {
> +		.type = "bmc150_accel",
> +		/*
> +		 * The 2nd accel sits in the base of 2-in-1s. Note this
> +		 * name is static, as there should never be more then 1
> +		 * BOSC0200 ACPI node with 2 accelerometers in it.

Given the lesser indent after pulling this out into a new function, it would
be good to rewrap this text as nearer to 80 chars.

> +		 */
> +		.dev_name = "BOSC0200:base",
> +		.fwnode = client->dev.fwnode,
> +		.irq = -ENOENT,
> +	};
> +
> +	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
> +		return;
> +
> +	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> +	if (!IS_ERR(second_dev))
> +		bmc150_set_second_device(client, second_dev);
> +}
> +
> +static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
> +{
> +	struct i2c_client *second_dev = bmc150_get_second_device(client);
> +
> +	i2c_unregister_device(second_dev);
> +}
> +#else
> +static void bmc150_acpi_dual_accel_probe(struct i2c_client *client) {}
> +static void bmc150_acpi_dual_accel_remove(struct i2c_client *client) {}
> +#endif
> +
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> @@ -30,7 +75,6 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
>  		i2c_check_functionality(client->adapter,
>  					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
> -	struct acpi_device __maybe_unused *adev;
>  	int ret;
>  
>  	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
> @@ -46,42 +90,16 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
> -	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
> -	 * ACPI resource with index 1. The !id check avoids recursion when
> -	 * bmc150_accel_probe() gets called for the second client.
> -	 */
> -#ifdef CONFIG_ACPI
> -	adev = ACPI_COMPANION(&client->dev);
> -	if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
> -		struct i2c_board_info board_info = {
> -			.type = "bmc150_accel",
> -			/*
> -			 * The 2nd accel sits in the base of 2-in-1s. Note this
> -			 * name is static, as there should never be more then 1
> -			 * BOSC0200 ACPI node with 2 accelerometers in it.
> -			 */
> -			.dev_name = "BOSC0200:base",
> -			.fwnode = client->dev.fwnode,
> -			.irq = -ENOENT,
> -		};
> -		struct i2c_client *second_dev;
> -
> -		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
> -		if (!IS_ERR(second_dev))
> -			bmc150_set_second_device(client, second_dev);
> -	}
> -#endif
> +	/* The !id check avoids recursion when probe() gets called for the second client. */

Won't hurt readability to wrap this to 80 chars as a multiline comment.

> +	if (!id && has_acpi_companion(&client->dev))
> +		bmc150_acpi_dual_accel_probe(client);
>  
>  	return 0;
>  }
>  
>  static int bmc150_accel_remove(struct i2c_client *client)
>  {
> -	struct i2c_client *second_dev = bmc150_get_second_device(client);
> -
> -	i2c_unregister_device(second_dev);
> +	bmc150_acpi_dual_accel_remove(client);
>  
>  	return bmc150_accel_core_remove(&client->dev);
>  }

