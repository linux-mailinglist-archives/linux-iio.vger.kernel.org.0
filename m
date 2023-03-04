Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD066AABC8
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCDSS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 13:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDSS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 13:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E169CC38;
        Sat,  4 Mar 2023 10:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA8FAB80025;
        Sat,  4 Mar 2023 18:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E41C433D2;
        Sat,  4 Mar 2023 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677953933;
        bh=+C1QoL465S0DAWnHmb+L3BJQ0GC03oKwtV2RZFdpm+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ze4whC1mREMSC+Bg+JwcKRIqNgIAfStzcwtEs2DxvTOfkPn1Ry7LcN1QbqsIETif4
         nZJ/neYd7l+HDEPAFB4CaqLT3AW+vg3+bKPRgpevPoci7anK9E2a47DDwkGaUR7Iry
         zA3NNaxWS55zILE62lT1qOsxZ6sRW7Q8JuGdeSjbAi44Lr4vkx1yTHJH8qujeyF34K
         JFVmV++yMLibkMRb2I3bnh15uOFpLucBWz0KdMeLSDJzlaQne2W7RZQV0i43QAMs1w
         MJXSQYTyYYMmY/gXZeiMHLYSdpTIrf9LbZYpqvFcxJQ/nkKujYtreU9Xbr2mQ8CFS/
         N+5PmJWR8gJ+Q==
Date:   Sat, 4 Mar 2023 18:18:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/5] iio: temperature: tmp117: improve fallback
 capabilities
Message-ID: <20230304181848.5020a8a6@jic23-huawei>
In-Reply-To: <20230228090518.529811-3-m.felsch@pengutronix.de>
References: <20230228090518.529811-1-m.felsch@pengutronix.de>
        <20230228090518.529811-3-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 28 Feb 2023 10:05:15 +0100
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
> ---
> v6:
> - no changes
> v5:
> - identify: make use of v6.2 available i2c_client_get_device_id()
> - identify: adapt dev_err() message
> - probe: keep ret variable
> v4:
> - new patch to implement possible fallback (Jonathan)
> 
>  drivers/iio/temperature/tmp117.c | 44 ++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index f9b8f2b570f6b..8a3992d9ee937 100644
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
> @@ -115,23 +116,40 @@ static const struct iio_info tmp117_info = {
>  
>  static int tmp117_identify(struct i2c_client *client)
>  {
> +	const struct i2c_device_id *id;
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
> +	id = i2c_client_get_device_id(client);
This particular path is a bit of an oddity as unlike the dt one we don't expect
to get a case where the part present doesn't match. However, I guess it might happen
if someone updates to a newer part number but for some reason doesn't update their
board file or other use of this type of id.  That extra flexibility doesn't really
hurt us so might as well leave it here.

So looking at this again, I'm fine with the prints you have here.

Jonathan

> +	if (id)
> +		return id->driver_data;
> +
> +	dev_err(&client->dev, "Failed to identify unsupported device\n");
> +
> +	return -ENODEV;
>  }
>  
>  static int tmp117_probe(struct i2c_client *client)
>  {
>  	struct tmp117_data *data;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, dev_id;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
> @@ -140,6 +158,8 @@ static int tmp117_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	dev_id = ret;
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -148,24 +168,28 @@ static int tmp117_probe(struct i2c_client *client)
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
>  static const struct of_device_id tmp117_of_match[] = {
> -	{ .compatible = "ti,tmp117", },
> +	{ .compatible = "ti,tmp117", .data = (void *)TMP117_DEVICE_ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tmp117_of_match);
>  
>  static const struct i2c_device_id tmp117_id[] = {
> -	{ "tmp117", 0 },
> +	{ "tmp117", TMP117_DEVICE_ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp117_id);

