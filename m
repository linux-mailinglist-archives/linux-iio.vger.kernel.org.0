Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495F78B084
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjH1Mfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjH1MfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3EB6;
        Mon, 28 Aug 2023 05:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EABCA64715;
        Mon, 28 Aug 2023 12:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB550C433C8;
        Mon, 28 Aug 2023 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226105;
        bh=ZLecRXe4nCCOe6k3tzeMLLPIVj8DEPANgv8jB6rB+mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c/IrYXayzNGjfvfrBMvO0PfEbzI77z3bd3wzJCK2IJRpwE5Mmtdx+cxdkxFszqQdM
         txmm3IZvZY0D/dZd20tYrzD6nWU/Enyx49DGkSzYd746MXcGnmlo/GlAXachLiQ9Dq
         bmDsy7xO/QZcTf9Bc1u3Jy/zr74EhwWHYv8HgA1nW5GT/+GSFfbGU2gN30OmcEfjJO
         MnrJnnNC59sj7yRsRKDVPJnJxGdGDGfOrKBIvPCms9hcuK4lC55LdJeR2vw06ad6Mo
         Wz9tVFbZjr8Omqw8vZW7sWIUPDb6+83II3pF4b/PjjkfZrQCGpJEeafDuiASUTLly4
         AinriyZon7+jw==
Date:   Mon, 28 Aug 2023 13:35:25 +0100
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
Subject: Re: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Message-ID: <20230828133525.5afaea4f@jic23-huawei>
In-Reply-To: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
References: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 20:04:29 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *vz89x_chip_data for data in the match table. Simplify
> the probe() by replacing device_get_match_data() and ID lookup for
> retrieving data by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Biju,

Make sure you cc the driver authors etc.

I'll queue this one up, but Matt feel free to comment if you have time

Thanks,

Jonathan


> ---
> v1->v2:
>  * Added Rb tag from Andy.
>  * Dropped id variable removal from commit description.
> ---
>  drivers/iio/chemical/vz89x.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 13555f4f401a..5b358bcd311b 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -342,19 +342,17 @@ static const struct vz89x_chip_data vz89x_chips[] = {
>  };
>  
>  static const struct of_device_id vz89x_dt_ids[] = {
> -	{ .compatible = "sgx,vz89x", .data = (void *) VZ89X },
> -	{ .compatible = "sgx,vz89te", .data = (void *) VZ89TE },
> +	{ .compatible = "sgx,vz89x", .data = &vz89x_chips[VZ89X] },
> +	{ .compatible = "sgx,vz89te", .data = &vz89x_chips[VZ89TE] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>  
>  static int vz89x_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct vz89x_data *data;
> -	int chip_id;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -369,14 +367,10 @@ static int vz89x_probe(struct i2c_client *client)
>  	else
>  		return -EOPNOTSUPP;
>  
> -	if (!dev_fwnode(dev))
> -		chip_id = id->driver_data;
> -	else
> -		chip_id = (unsigned long)device_get_match_data(dev);
> +	data->chip = i2c_get_match_data(client);
>  
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	data->chip = &vz89x_chips[chip_id];
>  	data->last_update = jiffies - HZ;
>  	mutex_init(&data->lock);
>  
> @@ -391,8 +385,8 @@ static int vz89x_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id vz89x_id[] = {
> -	{ "vz89x", VZ89X },
> -	{ "vz89te", VZ89TE },
> +	{ "vz89x", (kernel_ulong_t)&vz89x_chips[VZ89X] },
> +	{ "vz89te", (kernel_ulong_t)&vz89x_chips[VZ89TE] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vz89x_id);

