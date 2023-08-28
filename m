Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF378B529
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjH1QNS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjH1QNM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC011A;
        Mon, 28 Aug 2023 09:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E34F861842;
        Mon, 28 Aug 2023 16:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C0AC433C8;
        Mon, 28 Aug 2023 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239189;
        bh=JjmhmMqfpF5r3bunbB960c6WKcXtbhhdoL9h9MPdIxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AHOFa92wixfMzpJvcJVGDwE9IzNCye3SDE25aZOfjrMFTsRyIjAA1r5b5oaEohJGE
         WE9Q1TR2Y1LhRYiDisC6uoSqG/uIUrm/4hJB/Kn4Wy3MU4G7KXC59cG7yRiErK/E7G
         S4u6TRHC01VyzMqyR3eyKJwWvxOq/UGqGcuTVjNq1EhdlCjbNoINQznIqqXbwiPHtP
         vmbsk+W3lg2FRs6kifci8KpJ02+2OytVqBsuTtqwHFsRyjm9rH0Xa/Y3P6F55O/prz
         tzk8UUX6khSN/IYjtTTgvzDbzs13j9ZTPLJqwNtY8S/f1+XT6+lAWAcZpfvZXPzl/D
         eCnqQBWqc8E+w==
Date:   Mon, 28 Aug 2023 17:13:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>
Subject: Re: [PATCH] iio: chemical: sgp30: Convert enum->pointer for data in
 the match tables
Message-ID: <20230828171326.7623a254@jic23-huawei>
In-Reply-To: <20230812165730.216180-1-biju.das.jz@bp.renesas.com>
References: <20230812165730.216180-1-biju.das.jz@bp.renesas.com>
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

On Sat, 12 Aug 2023 17:57:30 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Add product_id variable to struct sgp_device and remove the local variable
> product_id in probe() and replace enum->struct *sgp_device for data in the
> match table. Simplify theprobe() by replacing device_get_match_data() and
> ID lookup for retrieving data by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
+CC Andreas (comments still welcome!)

Applied to the togreg branch of iio.git but only pushed out as testing for
now because I'll be rebasing on rc1 once available.  0-day can poke at
it in the meantime.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/sgp30.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index b509cff9ce37..21730d62b5c8 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -114,6 +114,7 @@ struct sgp_data {
>  };
>  
>  struct sgp_device {
> +	unsigned long product_id;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
>  };
> @@ -182,10 +183,12 @@ static const struct iio_chan_spec sgpc3_channels[] = {
>  
>  static const struct sgp_device sgp_devices[] = {
>  	[SGP30] = {
> +		.product_id = SGP30,
>  		.channels = sgp30_channels,
>  		.num_channels = ARRAY_SIZE(sgp30_channels),
>  	},
>  	[SGPC3] = {
> +		.product_id = SGPC3,
>  		.channels = sgpc3_channels,
>  		.num_channels = ARRAY_SIZE(sgpc3_channels),
>  	},
> @@ -491,28 +494,25 @@ static const struct iio_info sgp_info = {
>  };
>  
>  static const struct of_device_id sgp_dt_ids[] = {
> -	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
> -	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
> +	{ .compatible = "sensirion,sgp30", .data = &sgp_devices[SGP30] },
> +	{ .compatible = "sensirion,sgpc3", .data = &sgp_devices[SGPC3] },
>  	{ }
>  };
>  
>  static int sgp_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct sgp_device *match_data;
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct sgp_data *data;
> -	unsigned long product_id;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	if (dev_fwnode(dev))
> -		product_id = (unsigned long)device_get_match_data(dev);
> -	else
> -		product_id = id->driver_data;
> +	match_data = i2c_get_match_data(client);
>  
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> @@ -528,15 +528,15 @@ static int sgp_probe(struct i2c_client *client)
>  
>  	data->feature_set = be16_to_cpu(data->buffer.raw_words[0].value);
>  
> -	ret = sgp_check_compat(data, product_id);
> +	ret = sgp_check_compat(data, match_data->product_id);
>  	if (ret)
>  		return ret;
>  
>  	indio_dev->info = &sgp_info;
>  	indio_dev->name = id->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = sgp_devices[product_id].channels;
> -	indio_dev->num_channels = sgp_devices[product_id].num_channels;
> +	indio_dev->channels = match_data->channels;
> +	indio_dev->num_channels = match_data->num_channels;
>  
>  	sgp_init(data);
>  
> @@ -562,8 +562,8 @@ static void sgp_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id sgp_id[] = {
> -	{ "sgp30", SGP30 },
> -	{ "sgpc3", SGPC3 },
> +	{ "sgp30", (kernel_ulong_t)&sgp_devices[SGP30] },
> +	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
>  	{ }
>  };
>  

