Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2178AF09
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjH1Lm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjH1LmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D0C3;
        Mon, 28 Aug 2023 04:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF2361D52;
        Mon, 28 Aug 2023 11:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723EBC433C7;
        Mon, 28 Aug 2023 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222917;
        bh=iq4gBSIR+gE+Y62uxblvP7ilQNnVXXtw4NFV5wzrQ6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOq1uWK4FX94GfQR74I+EW+kfrbfUARGIZ84C5+gTnB9m0nfLK7lf2GU1efm1k8tR
         DOLhGmW1IoRWRzkRCVztmJHaEOZ7RDeRBLP4RJOwYAtuAYXbRmAZd+CVkv+g7y1l1c
         QoVqTUfyhKH7U4QVZDntu7u/fe/Y1Yu4hzo8V64mg8vmKEwchjG/WLzGKKzOjDUWm7
         PgRel8UcHxH/49K5Z/vEZQicfT8Ufpqc4k4lW6u+7wSqb/p0nUhx6X7jHXt++OyuAv
         cMQbUd7OLJDBgqxdVTKJV3QNSs/zuPvNM2GNIzaCs9jfkQ5NOY/DrBAxCMU2xIVMiU
         Nw3l73445JYaw==
Date:   Mon, 28 Aug 2023 12:42:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: chemical: atlas-sensor: Convert enum->pointer
 for data in the match tables
Message-ID: <20230828124216.6ef6d056@jic23-huawei>
In-Reply-To: <20230818185531.336672-1-biju.das.jz@bp.renesas.com>
References: <20230818185531.336672-1-biju.das.jz@bp.renesas.com>
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

On Fri, 18 Aug 2023 19:55:31 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *atlas_device for data in the match table. Simplify
> the probe() by replacing device_get_match_data() and ID lookup for
> retrieving data by i2c_get_match_data().
> 
> While at it, add const qualifier to struct atlas_device and drop inner
> trailing commas from OF table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

+CC Matt

Looks good to me so applied to the togreg branch of iio.git but as with the
other patches, there is plenty of time for others to comment before
I push those out as non rebasing.

Thanks,

Jonathan

> ---
> v1->v2:
>  * Added Rb tag from Andy
>  * Dropped id variable removal sentance from commit description
>  * Dropped inner trailing commas from commit description.
> ---
>  drivers/iio/chemical/atlas-sensor.c | 32 +++++++++++++----------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index fb15bb216019..baf93e5e3ca7 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -87,7 +87,7 @@ enum {
>  struct atlas_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *trig;
> -	struct atlas_device *chip;
> +	const struct atlas_device *chip;
>  	struct regmap *regmap;
>  	struct irq_work work;
>  	unsigned int interrupt_enabled;
> @@ -353,7 +353,7 @@ struct atlas_device {
>  	int delay;
>  };
>  
> -static struct atlas_device atlas_devices[] = {
> +static const struct atlas_device atlas_devices[] = {
>  	[ATLAS_PH_SM] = {
>  				.channels = atlas_ph_channels,
>  				.num_channels = 3,
> @@ -589,30 +589,29 @@ static const struct iio_info atlas_info = {
>  };
>  
>  static const struct i2c_device_id atlas_id[] = {
> -	{ "atlas-ph-sm", ATLAS_PH_SM },
> -	{ "atlas-ec-sm", ATLAS_EC_SM },
> -	{ "atlas-orp-sm", ATLAS_ORP_SM },
> -	{ "atlas-do-sm", ATLAS_DO_SM },
> -	{ "atlas-rtd-sm", ATLAS_RTD_SM },
> +	{ "atlas-ph-sm", (kernel_ulong_t)&atlas_devices[ATLAS_PH_SM] },
> +	{ "atlas-ec-sm", (kernel_ulong_t)&atlas_devices[ATLAS_EC_SM] },
> +	{ "atlas-orp-sm", (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
> +	{ "atlas-do-sm", (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
> +	{ "atlas-rtd-sm", (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
>  
>  static const struct of_device_id atlas_dt_ids[] = {
> -	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
> -	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
> -	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
> -	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> -	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
> +	{ .compatible = "atlas,ph-sm", .data = &atlas_devices[ATLAS_PH_SM] },
> +	{ .compatible = "atlas,ec-sm", .data = &atlas_devices[ATLAS_EC_SM] },
> +	{ .compatible = "atlas,orp-sm", .data = &atlas_devices[ATLAS_ORP_SM] },
> +	{ .compatible = "atlas,do-sm", .data = &atlas_devices[ATLAS_DO_SM] },
> +	{ .compatible = "atlas,rtd-sm", .data = &atlas_devices[ATLAS_RTD_SM] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, atlas_dt_ids);
>  
>  static int atlas_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct atlas_data *data;
> -	struct atlas_device *chip;
> +	const struct atlas_device *chip;
>  	struct iio_trigger *trig;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -621,10 +620,7 @@ static int atlas_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	if (!dev_fwnode(&client->dev))
> -		chip = &atlas_devices[id->driver_data];
> -	else
> -		chip = &atlas_devices[(unsigned long)device_get_match_data(&client->dev)];
> +	chip = i2c_get_match_data(client);
>  
>  	indio_dev->info = &atlas_info;
>  	indio_dev->name = ATLAS_DRV_NAME;

