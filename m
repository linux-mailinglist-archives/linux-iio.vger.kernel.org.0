Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670E69BB0E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBRQuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRQuo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 11:50:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68116AE3;
        Sat, 18 Feb 2023 08:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6900BB80502;
        Sat, 18 Feb 2023 16:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A073EC433D2;
        Sat, 18 Feb 2023 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676739040;
        bh=r2PYFoa1LeJkdoAVtv+Fd/pRC5ZdP+VNwx+M+lsmMB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhObycJfmetXDMiU4s1nJi0S1RtRIsPXfnJjquagHVLdqWYfRxx6962ypkTdBNbJT
         LoQ3mdlRMRFjFRS4IGMsbMmnBOtFa/sFqcK778aeD+cVniYaszTUmeC4wBcP7qc9/g
         Z3uhUyAAab9pJH5V9Ni4X/yEXgTVTmjUkDEL8htq917tg6DHMT9Rcg59sqZajGq7BU
         H0NjuktQowQ+uxpEvOsFHnTTPP/1vs1iqB0nv7PoR6bPF+skKF0XSjj3nnlo2j2qI3
         XiE0Z/uqXVD9PBQBsUyt/rWbAIUTTqlJ+XhX4Li0l5GoF05IVo/OeGVH1QhvO4UxBD
         At39Iz9iYhE+g==
Date:   Sat, 18 Feb 2023 17:04:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20230218170459.1aac6919@jic23-huawei>
In-Reply-To: <20230217093711.1891564-4-m.felsch@pengutronix.de>
References: <20230217093711.1891564-1-m.felsch@pengutronix.de>
        <20230217093711.1891564-4-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Feb 2023 10:37:10 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> The TMP116 is the predecessor of the TMP117. The TMP116 don't support
> custom offset calibration data, instead this register is used as generic
> EEPROM storage as well.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

I failed to notice that the handling of fallback compatibles (not
related to the fact we can't use them for the TMP116 as discussed)
is less than ideal in the original driver.

Given it already doesn't work, I'm fine with handling that in a
a separate patch though if you would prefer. If you don't get to
it I might eventually do so.  There are a lot of cases of this
in IIO, but mostly we don't bother fixing them unless we are touching
the driver for other reasons.

I can fix the trivial alphabetical order thing up whilst applying.

Thanks,

Jonathan


> ---
> v3:
> - use switch case within probe() as well
> - don't hide smbus_read error within tmp117_identify()
> - add dedicated compatible
> 
> v2:
> - no changes
> 
>  drivers/iio/temperature/tmp117.c | 46 ++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index f9b8f2b570f6b..728538fbaf9ba 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -31,9 +31,11 @@
>  #define TMP117_REG_DEVICE_ID		0xF
>  
>  #define TMP117_RESOLUTION_10UC		78125
> -#define TMP117_DEVICE_ID		0x0117
>  #define MICRODEGREE_PER_10MILLIDEGREE	10000
>  
> +#define TMP116_DEVICE_ID		0x1116
> +#define TMP117_DEVICE_ID		0x0117
> +
>  struct tmp117_data {
>  	struct i2c_client *client;
>  	s16 calibbias;
> @@ -105,6 +107,13 @@ static const struct iio_chan_spec tmp117_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
> +};
> +
> +static const struct iio_chan_spec tmp116_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  };
>  
> @@ -120,25 +129,29 @@ static int tmp117_identify(struct i2c_client *client)
>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
>  	if (dev_id < 0)
>  		return dev_id;
> -	if (dev_id != TMP117_DEVICE_ID) {
> -		dev_err(&client->dev, "TMP117 not found\n");
> +
> +	switch (dev_id) {
> +	case TMP116_DEVICE_ID:
> +	case TMP117_DEVICE_ID:
> +		return dev_id;
> +	default:
> +		dev_err(&client->dev, "TMP116/117 not found\n");

More a comment on the original code rather than your changes, but we should fix
if whilst here...

So this is always fun.  Ideally if we don't match a known device we should trust
the compatible provided.  The intent here is that if a new device turns up
with a different ID and does indeed have a valid fallback compatible then
the driver should work. It's fine to warn, but we shouldn't fail the probe.

As such a dance is needed.  First we need to associate some data with the
device IDs (see below)

>  		return -ENODEV;
>  	}
> -	return 0;
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

Fallback ID related. See above. If this happens we should not error out,
but rather fallback on assumption that the provided compatible is correct
even though we don't know the new dev_id.  So look up the data here.
Prefer data from the device_property_get_match_data() and if that fails
fallback to i2c_client_get_device_id() and the data field from that.


> +		return dev_id;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -148,24 +161,35 @@ static int tmp117_probe(struct i2c_client *client)
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
> +	case TMP116_DEVICE_ID:
> +		indio_dev->channels = tmp116_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(tmp116_channels);
> +		indio_dev->name = "tmp116";
> +		break;
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
>  	{ .compatible = "ti,tmp117", },
> +	{ .compatible = "ti,tmp116", },

Alphabetical order preferred.

Data here as below.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tmp117_of_match);
>  
>  static const struct i2c_device_id tmp117_id[] = {
>  	{ "tmp117", 0 },
> +	{ "tmp116", 0 },
Follow on from above: This needs data to distinguish the two so we can
support future fallback compatibles to one of these.
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp117_id);

