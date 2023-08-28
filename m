Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0169C78B55B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjH1Q0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjH1Q0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331113D;
        Mon, 28 Aug 2023 09:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3524D63C0B;
        Mon, 28 Aug 2023 16:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB932C433C8;
        Mon, 28 Aug 2023 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239968;
        bh=OvYV9Htm9mU/km9WRjPlS3QpfQqo2NlyVWl3AqwuPJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTMoaOBEQWHyzAdjGZbACBWr/HmrQA3Cvi2aC+eSDpXPaSiqBObYEG2SbNXQPDx06
         Z0MckpI4yhO7ZQvzeetKjAvcCBRVG+C/PVB0zoG3hxG3iSorC6u6s++e6JH5xL6aS8
         vS+0PJM3x7SssYr+QWYzODv2NfDKnpTmWBcSHBMR/PrhpkJTQnEBbrirXXFECuqzGC
         hVwiFZWAG562g2uYskXR1Fm3tzlBfywDsheLV+SFczdKiqj2Bb0zuHevWV9NGZiiXP
         VZXIzQLAUig2NhbtDdtanQpcTEWMilUJ86LtfR5Xjk80/Lnkcy0VMgizysUi+TUmkW
         mExTr0JREa3nw==
Date:   Mon, 28 Aug 2023 17:26:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] iio: temperature: tmp117: Convert enum->pointer for
 data in the match tables
Message-ID: <20230828172628.76beca65@jic23-huawei>
In-Reply-To: <20230812161154.196555-1-biju.das.jz@bp.renesas.com>
References: <20230812161154.196555-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Sat, 12 Aug 2023 17:11:54 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Add struct tmp11x_info and replace enum->struct *tmp11x_info for data in
> the match table. Drop tmp117_identify() and simplify tmp117_probe() by
> replacing device_get_match_data() and id lookup for retrieving data by
> i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

+CC Marco who has been active on this driver recently.

I'll apply it in the meantime, but still very much open to review comments.

Jonathan

> ---
>  drivers/iio/temperature/tmp117.c | 94 +++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index fc02f491688b..059953015ae7 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -42,6 +42,12 @@ struct tmp117_data {
>  	s16 calibbias;
>  };
>  
> +struct tmp11x_info {
> +	const char *name;
> +	struct iio_chan_spec const *channels;
> +	int num_channels;
> +};
> +
>  static int tmp117_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *channel, int *val,
>  			   int *val2, long mask)
> @@ -119,57 +125,54 @@ static const struct iio_chan_spec tmp116_channels[] = {
>  	},
>  };
>  
> +static const struct tmp11x_info tmp116_channels_info = {
> +	.name = "tmp116",
> +	.channels = tmp116_channels,
> +	.num_channels = ARRAY_SIZE(tmp116_channels)
> +};
> +
> +static const struct tmp11x_info tmp117_channels_info = {
> +	.name = "tmp117",
> +	.channels = tmp117_channels,
> +	.num_channels = ARRAY_SIZE(tmp117_channels)
> +};
> +
>  static const struct iio_info tmp117_info = {
>  	.read_raw = tmp117_read_raw,
>  	.write_raw = tmp117_write_raw,
>  };
>  
> -static int tmp117_identify(struct i2c_client *client)
> +static int tmp117_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id;
> -	unsigned long match_data;
> +	const struct tmp11x_info *match_data;
> +	struct tmp117_data *data;
> +	struct iio_dev *indio_dev;
>  	int dev_id;
>  
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
>  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
>  	if (dev_id < 0)
>  		return dev_id;
>  
>  	switch (dev_id) {
>  	case TMP116_DEVICE_ID:
> +		match_data = &tmp116_channels_info;
> +		break;
>  	case TMP117_DEVICE_ID:
> -		return dev_id;
> +		match_data = &tmp117_channels_info;
> +		break;
> +	default:
> +		dev_info(&client->dev,
> +			 "Unknown device id (0x%x), use fallback compatible\n",
> +			 dev_id);
> +		match_data = i2c_get_match_data(client);
>  	}
>  
> -	dev_info(&client->dev, "Unknown device id (0x%x), use fallback compatible\n",
> -		 dev_id);
> -
> -	match_data = (uintptr_t)device_get_match_data(&client->dev);
> -	if (match_data)
> -		return match_data;
> -
> -	id = i2c_client_get_device_id(client);
> -	if (id)
> -		return id->driver_data;
> -
> -	dev_err(&client->dev, "Failed to identify unsupported device\n");
> -
> -	return -ENODEV;
> -}
> -
> -static int tmp117_probe(struct i2c_client *client)
> -{
> -	struct tmp117_data *data;
> -	struct iio_dev *indio_dev;
> -	int ret, dev_id;
> -
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> -		return -EOPNOTSUPP;
> -
> -	ret = tmp117_identify(client);
> -	if (ret < 0)
> -		return ret;
> -
> -	dev_id = ret;
> +	if (!match_data)
> +		return dev_err_probe(&client->dev, -ENODEV,
> +				     "Failed to identify unsupported device\n");
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -181,33 +184,24 @@ static int tmp117_probe(struct i2c_client *client)
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &tmp117_info;
> +	indio_dev->channels = match_data->channels;
> +	indio_dev->num_channels = match_data->num_channels;
> +	indio_dev->name = match_data->name;
>  
> -	switch (dev_id) {
> -	case TMP116_DEVICE_ID:
> -		indio_dev->channels = tmp116_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(tmp116_channels);
> -		indio_dev->name = "tmp116";
> -		break;
> -	case TMP117_DEVICE_ID:
> -		indio_dev->channels = tmp117_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> -		indio_dev->name = "tmp117";
> -		break;
> -	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct of_device_id tmp117_of_match[] = {
> -	{ .compatible = "ti,tmp116", .data = (void *)TMP116_DEVICE_ID },
> -	{ .compatible = "ti,tmp117", .data = (void *)TMP117_DEVICE_ID },
> +	{ .compatible = "ti,tmp116", .data = &tmp116_channels_info },
> +	{ .compatible = "ti,tmp117", .data = &tmp117_channels_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tmp117_of_match);
>  
>  static const struct i2c_device_id tmp117_id[] = {
> -	{ "tmp116", TMP116_DEVICE_ID },
> -	{ "tmp117", TMP117_DEVICE_ID },
> +	{ "tmp116", (kernel_ulong_t)&tmp116_channels_info },
> +	{ "tmp117", (kernel_ulong_t)&tmp117_channels_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp117_id);

