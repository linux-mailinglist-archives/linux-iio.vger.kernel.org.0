Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686576A2F7F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Feb 2023 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBZMwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Feb 2023 07:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBZMwl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2023 07:52:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885811646;
        Sun, 26 Feb 2023 04:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46415B80B7C;
        Sun, 26 Feb 2023 12:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7975CC433D2;
        Sun, 26 Feb 2023 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677415955;
        bh=oEQsjh8Gi31+5wH5xx1MJkmxpc3pijYr5zWuKl/aPzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PyHv21EgYDcD0G6sQucjz6ObfE4Z3fXq49xfVkFUumDc7edBeciQdk+hZYvaskZmc
         yKPJjD0xISbCw8m1i0FJCgPqYKWnJCz6eSaMJxwtkgoAGiFK7KzPgJoj4JHU4957iY
         79x9z/CYHVAVqMdJVDZC72SWQX6xzVOGNK//K7DdbAyxLP3P3Qf/eSe77n9ZZLd6OT
         O+myq6Egyb7L3dT8zL8w3aBI75gJHgg0m24h1NBdZ1kgvUXEGkcf6qvGmtyHt5eBHx
         L0N/XEoQNYp98FUrRIOFROnUEpbftDTTEckQmchkVq2LXU9ohiH20h5GXj4r69uLpA
         RZTqZlm9YRTMg==
Date:   Sun, 26 Feb 2023 13:07:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 2/5] iio: temperature: tmp117: improve fallback
 capabilities
Message-ID: <20230226130700.5b0d650f@jic23-huawei>
In-Reply-To: <20230220122552.925216-3-m.felsch@pengutronix.de>
References: <20230220122552.925216-1-m.felsch@pengutronix.de>
        <20230220122552.925216-3-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Feb 2023 13:25:49 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Don't error if the device-id found don't match the device-id for the
> TMP117 sensor since other TMPxxx might be compatible to the TMP117. The
> fallback mechanism tries to gather the required information from the
> of_device_id or from the i2c_client information.
> 
> The commit also prepares the driver for adding new devices more easily
> by making use of switch-case at the relevant parts.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Hi Marco,

Thanks for doing this.  A small things inline.

> ---
> v4:
> - new patch to implement possible fallback (Jonathan)
> 
>  drivers/iio/temperature/tmp117.c | 67 +++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index f9b8f2b570f6b..4ddb8cf9a29ab 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
> +#include <linux/property.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -113,32 +114,60 @@ static const struct iio_info tmp117_info = {
>  	.write_raw = tmp117_write_raw,
>  };
>  
> +static const struct of_device_id tmp117_of_match[] = {
> +	{ .compatible = "ti,tmp117", .data = (void *)TMP117_DEVICE_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tmp117_of_match);
> +
> +static const struct i2c_device_id tmp117_id[] = {
> +	{ "tmp117", TMP117_DEVICE_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tmp117_id);

As below.  There is an easy way to avoid having to move these.

> +
>  static int tmp117_identify(struct i2c_client *client)
>  {
> +	unsigned long match_data;
>  	int dev_id;
>  
>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
>  	if (dev_id < 0)
>  		return dev_id;
> -	if (dev_id != TMP117_DEVICE_ID) {
> -		dev_err(&client->dev, "TMP117 not found\n");
> -		return -ENODEV;
> +
> +	switch (dev_id) {
> +	case TMP117_DEVICE_ID:
> +		return dev_id;
>  	}
> -	return 0;
> +
> +	dev_info(&client->dev, "Unknown device id (0x%x), use fallback compatible\n",
> +		 dev_id);
> +
> +	match_data = (uintptr_t)device_get_match_data(&client->dev);
> +	if (match_data)
> +		return match_data;
> +
> +	match_data = i2c_match_id(tmp117_id, client)->driver_data;

Whilst correct, i2c_client_get_device_id() avoids the need
to move tmp117_id up to where you have by getting to that table via
the driver structure. That will simplify this patch a fair bit.

> +	if (match_data)
> +		return match_data;
> +
> +	dev_err(&client->dev, "error: No valid fallback found\n");

This is a little misleading as fallback only applies to the device tree
path.  Also, not a lot of point in putting error in the text of
a dev_err.  Perhaps just "Unsupported device".


> +
> +	return -ENODEV;
>  }
>  
>  static int tmp117_probe(struct i2c_client *client)
>  {
>  	struct tmp117_data *data;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int dev_id;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> -	ret = tmp117_identify(client);
> -	if (ret < 0)
> -		return ret;
> +	dev_id = tmp117_identify(client);
> +	if (dev_id < 0)
> +		return dev_id;

I'd keep it in ret until you know it's good.  Reduces churn and is nicer
code in general, though one more line.

	dev_id = ret;

>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -148,28 +177,20 @@ static int tmp117_probe(struct i2c_client *client)
>  	data->client = client;
>  	data->calibbias = 0;
>  
> -	indio_dev->name = "tmp117";
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &tmp117_info;
>  
> -	indio_dev->channels = tmp117_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> +	switch (dev_id) {
> +	case TMP117_DEVICE_ID:
> +		indio_dev->channels = tmp117_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> +		indio_dev->name = "tmp117";
> +		break;
> +	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> -static const struct of_device_id tmp117_of_match[] = {
> -	{ .compatible = "ti,tmp117", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, tmp117_of_match);
> -
> -static const struct i2c_device_id tmp117_id[] = {
> -	{ "tmp117", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, tmp117_id);
> -
>  static struct i2c_driver tmp117_driver = {
>  	.driver = {
>  		.name	= "tmp117",

