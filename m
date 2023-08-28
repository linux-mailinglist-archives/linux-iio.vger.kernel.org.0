Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6335778B1D1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjH1Nak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjH1NaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461CA7;
        Mon, 28 Aug 2023 06:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A4E64408;
        Mon, 28 Aug 2023 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184BAC433C8;
        Mon, 28 Aug 2023 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693229417;
        bh=Ifq7zOgFpd0EXUe7VG4FHRz4+K8yZQwaaObHuZ+JBF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QVjse6Rd2HH3cQKN6mpZvd9POzlA3KHwNJpN+e5Sq9F3cBxMs1pR42LC1o7Fgv+v5
         VuYVdOgY6SxfrbsRJ41qYtUPZbZHNv1GbGeNL96eZhQv1WNS9uHxcSnex9bb60biH8
         Vh3+3yj5opL7XfMBVjzzUmJaP0i95p8fXet7wPld5qso/8K8XIt0TbhOztGB8cPdrR
         nZMr0gHeDZ8udRQ0m8BuWEKi61OLvgTZjh+Tkkbn7ydS2FE793CLOzR9+5aTiyoaGR
         GqKALMiShPBsy8kYk0ePozKprCzQg0ClKdHixNsZ+BNIb6cqxIhZHWeG6ItD+f8LEh
         M6c/2KhEw3wUg==
Date:   Mon, 28 Aug 2023 14:30:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
Message-ID: <20230828143037.68e3e3bb@jic23-huawei>
In-Reply-To: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
References: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
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

On Sat, 12 Aug 2023 09:32:04 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju

So, there is an issue in this driver that I've been wanting fixed for a while
that is related to the fact we only pass through an enum and then map it
to the relevant structure internally. This driver doesn't handle fall back compatibles
and adds a look up that we shouldn't need.

Assuming we don't have incompatible parts with the same WhoAmI value
(it has happened in past *sigh)
What should be happening here is:
1) The match tables contain pointers to appropriate entries of st_lsm6dsx_sensor_settings[]
2) We then assume that that info isn't available and try matching whoami against all devices
   possibly with a short cut for the value matching what is expected.
   If it is the one we expect. Good.
   If it is a different whoami but we know about it. Good - maybe print some info as that's
   probably some outdated firmware..
   If we have no idea print a message and muddle on with the data provided by the id table
   as that's probably a fallback compatible case where the whoami is different but the chip
   is fully compatible.

Key to this is that we should just point into st_lsm6dsx_sensor_settings but that needs some
mess probably via externs pointers with definitions in the header, but set in the core file,
to avoid having to make that huge structure directly visible.

Not a nice one to solve and I'm open to other suggestions on how to tidy this up.

Jonathan


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 126 ++++++++++++--------
>  1 file changed, 74 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 911444ec57c0..a2def435c9c2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -16,6 +16,30 @@
>  
>  #include "st_lsm6dsx.h"
>  
> +static const int lsm6ds3 = ST_LSM6DS3_ID;
> +static const int lsm6ds3h = ST_LSM6DS3H_ID;
> +static const int lsm6dsl = ST_LSM6DSL_ID;
> +static const int lsm6dsm = ST_LSM6DSM_ID;
> +static const int ism330dlc = ST_ISM330DLC_ID;
> +static const int lsm6dso = ST_LSM6DSO_ID;
> +static const int asm330lhh = ST_ASM330LHH_ID;
> +static const int lsm6dsox = ST_LSM6DSOX_ID;
> +static const int lsm6dsr = ST_LSM6DSR_ID;
> +static const int lsm6ds3tr_c = ST_LSM6DS3TRC_ID;
> +static const int ism330dhcx = ST_ISM330DHCX_ID;
> +static const int lsm9ds1_imu = ST_LSM9DS1_ID;
> +static const int lsm6ds0 = ST_LSM6DS0_ID;
> +static const int lsm6dsrx = ST_LSM6DSRX_ID;
> +static const int lsm6dst = ST_LSM6DST_ID;
> +static const int lsm6dsop = ST_LSM6DSOP_ID;
> +static const int asm330lhhx = ST_ASM330LHHX_ID;
> +static const int lsm6dstx = ST_LSM6DSTX_ID;
> +static const int lsm6dsv = ST_LSM6DSV_ID;
> +static const int lsm6dsv16x = ST_LSM6DSV16X_ID;
> +static const int lsm6dso16is = ST_LSM6DSO16IS_ID;
> +static const int ism330is = ST_ISM330IS_ID;
> +static const int asm330lhb = ST_ASM330LHB_ID;
> +
>  static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -23,12 +47,10 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
>  
>  static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
>  {
> -	int hw_id;
> +	const int *hw_id;
>  	struct regmap *regmap;
>  
> -	hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
> -	if (!hw_id)
> -		hw_id = i2c_client_get_device_id(client)->driver_data;
> +	hw_id = i2c_get_match_data(client);
>  	if (!hw_id)
>  		return -EINVAL;
>  
> @@ -38,136 +60,136 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
> +	return st_lsm6dsx_probe(&client->dev, client->irq, *hw_id, regmap);
>  }
>  
>  static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  	{
>  		.compatible = "st,lsm6ds3",
> -		.data = (void *)ST_LSM6DS3_ID,
> +		.data = &lsm6ds3,
>  	},
>  	{
>  		.compatible = "st,lsm6ds3h",
> -		.data = (void *)ST_LSM6DS3H_ID,
> +		.data = &lsm6ds3h,
>  	},
>  	{
>  		.compatible = "st,lsm6dsl",
> -		.data = (void *)ST_LSM6DSL_ID,
> +		.data = &lsm6dsl,
>  	},
>  	{
>  		.compatible = "st,lsm6dsm",
> -		.data = (void *)ST_LSM6DSM_ID,
> +		.data = &lsm6dsm,
>  	},
>  	{
>  		.compatible = "st,ism330dlc",
> -		.data = (void *)ST_ISM330DLC_ID,
> +		.data = &ism330dlc,
>  	},
>  	{
>  		.compatible = "st,lsm6dso",
> -		.data = (void *)ST_LSM6DSO_ID,
> +		.data = &lsm6dso,
>  	},
>  	{
>  		.compatible = "st,asm330lhh",
> -		.data = (void *)ST_ASM330LHH_ID,
> +		.data = &asm330lhh,
>  	},
>  	{
>  		.compatible = "st,lsm6dsox",
> -		.data = (void *)ST_LSM6DSOX_ID,
> +		.data = &lsm6dsox,
>  	},
>  	{
>  		.compatible = "st,lsm6dsr",
> -		.data = (void *)ST_LSM6DSR_ID,
> +		.data = &lsm6dsr,
>  	},
>  	{
>  		.compatible = "st,lsm6ds3tr-c",
> -		.data = (void *)ST_LSM6DS3TRC_ID,
> +		.data = &lsm6ds3tr_c,
>  	},
>  	{
>  		.compatible = "st,ism330dhcx",
> -		.data = (void *)ST_ISM330DHCX_ID,
> +		.data = &ism330dhcx,
>  	},
>  	{
>  		.compatible = "st,lsm9ds1-imu",
> -		.data = (void *)ST_LSM9DS1_ID,
> +		.data = &lsm9ds1_imu,
>  	},
>  	{
>  		.compatible = "st,lsm6ds0",
> -		.data = (void *)ST_LSM6DS0_ID,
> +		.data = &lsm6ds0,
>  	},
>  	{
>  		.compatible = "st,lsm6dsrx",
> -		.data = (void *)ST_LSM6DSRX_ID,
> +		.data = &lsm6dsrx,
>  	},
>  	{
>  		.compatible = "st,lsm6dst",
> -		.data = (void *)ST_LSM6DST_ID,
> +		.data = &lsm6dst,
>  	},
>  	{
>  		.compatible = "st,lsm6dsop",
> -		.data = (void *)ST_LSM6DSOP_ID,
> +		.data = &lsm6dsop,
>  	},
>  	{
>  		.compatible = "st,asm330lhhx",
> -		.data = (void *)ST_ASM330LHHX_ID,
> +		.data = &asm330lhhx,
>  	},
>  	{
>  		.compatible = "st,lsm6dstx",
> -		.data = (void *)ST_LSM6DSTX_ID,
> +		.data = &lsm6dstx,
>  	},
>  	{
>  		.compatible = "st,lsm6dsv",
> -		.data = (void *)ST_LSM6DSV_ID,
> +		.data = &lsm6dsv,
>  	},
>  	{
>  		.compatible = "st,lsm6dsv16x",
> -		.data = (void *)ST_LSM6DSV16X_ID,
> +		.data = &lsm6dsv16x,
>  	},
>  	{
>  		.compatible = "st,lsm6dso16is",
> -		.data = (void *)ST_LSM6DSO16IS_ID,
> +		.data = &lsm6dso16is,
>  	},
>  	{
>  		.compatible = "st,ism330is",
> -		.data = (void *)ST_ISM330IS_ID,
> +		.data = &ism330is,
>  	},
>  	{
>  		.compatible = "st,asm330lhb",
> -		.data = (void *)ST_ASM330LHB_ID,
> +		.data = &asm330lhb,
>  	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>  
>  static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
> -	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
> +	{ "SMO8B30", (kernel_ulong_t)&lsm6ds3tr_c, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
>  
>  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
> -	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> -	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
> -	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
> -	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
> -	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
> -	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> -	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
> -	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
> -	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> -	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> -	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> -	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> -	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
> -	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
> -	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
> -	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> -	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
> -	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
> -	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
> -	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
> -	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
> -	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
> -	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> +	{ ST_LSM6DS3_DEV_NAME, (kernel_ulong_t)&lsm6ds3 },
> +	{ ST_LSM6DS3H_DEV_NAME, (kernel_ulong_t)&lsm6ds3h },
> +	{ ST_LSM6DSL_DEV_NAME, (kernel_ulong_t)&lsm6dsl },
> +	{ ST_LSM6DSM_DEV_NAME, (kernel_ulong_t)&lsm6dsm },
> +	{ ST_ISM330DLC_DEV_NAME, (kernel_ulong_t)&ism330dlc },
> +	{ ST_LSM6DSO_DEV_NAME, (kernel_ulong_t)&lsm6dso },
> +	{ ST_ASM330LHH_DEV_NAME, (kernel_ulong_t)&asm330lhh },
> +	{ ST_LSM6DSOX_DEV_NAME, (kernel_ulong_t)&lsm6dsox },
> +	{ ST_LSM6DSR_DEV_NAME, (kernel_ulong_t)&lsm6dsr },
> +	{ ST_LSM6DS3TRC_DEV_NAME, (kernel_ulong_t)&lsm6ds3tr_c },
> +	{ ST_ISM330DHCX_DEV_NAME, (kernel_ulong_t)&ism330dhcx },
> +	{ ST_LSM9DS1_DEV_NAME, (kernel_ulong_t)&lsm9ds1_imu },
> +	{ ST_LSM6DS0_DEV_NAME, (kernel_ulong_t)&lsm6ds0 },
> +	{ ST_LSM6DSRX_DEV_NAME, (kernel_ulong_t)&lsm6dsrx },
> +	{ ST_LSM6DST_DEV_NAME, (kernel_ulong_t)&lsm6dst },
> +	{ ST_LSM6DSOP_DEV_NAME, (kernel_ulong_t)&lsm6dsop },
> +	{ ST_ASM330LHHX_DEV_NAME, (kernel_ulong_t)&asm330lhhx },
> +	{ ST_LSM6DSTX_DEV_NAME, (kernel_ulong_t)&lsm6dstx },
> +	{ ST_LSM6DSV_DEV_NAME, (kernel_ulong_t)&lsm6dsv },
> +	{ ST_LSM6DSV16X_DEV_NAME, (kernel_ulong_t)&lsm6dsv16x },
> +	{ ST_LSM6DSO16IS_DEV_NAME, (kernel_ulong_t)&lsm6dso16is },
> +	{ ST_ISM330IS_DEV_NAME, (kernel_ulong_t)&ism330is },
> +	{ ST_ASM330LHB_DEV_NAME, (kernel_ulong_t)&asm330lhb },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);

