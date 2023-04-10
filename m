Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15C6DC9B3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDJRHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDJRHJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 13:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE12125
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 10:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F53361548
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 17:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4646CC433EF;
        Mon, 10 Apr 2023 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681146420;
        bh=CjHoIBOuqCgmwVdPHpvh5e8OLGo/zYX54nFI4UVucmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TlG8jYy3nA2Wo97X2ZJe7G/47xQCquEU8nQaD3aK43lnoEJ30//UfHlJuJom7zzFW
         y0z+LmvtnMQRNrTzbI3IafALd9ZjFjbrvOckenUxzoMRYrrfedLEsf8ByYIQGqnY6y
         8jCLzawVkx3nkN93Bc2BrtJ1Y+Sos3lo67oJN98fTJoikwyNMWA2xF10b6W9A1sEZy
         YSDX0CDWGYjh3YbasBzSzFpJXNxcheV2q7AsnWf57FXIX0T1lQhw0YQNy59qip4Q8r
         jAIlp1kmw/PYa4QkpybOx1zomAlupFq3+6gfaR5YTunQRjDTpZ6ECzdiMCt5q8gWF8
         59RlLBefMQVHA==
Date:   Mon, 10 Apr 2023 18:22:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: imu: lsm6dsx: Support SMO8B30 ACPI ID for
 LSM6DS3TR-C
Message-ID: <20230410182220.62b66260@jic23-huawei>
In-Reply-To: <20230130201018.981024-2-jic23@kernel.org>
References: <20230130201018.981024-1-jic23@kernel.org>
        <20230130201018.981024-2-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 20:10:17 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ID seen in the wild and it is a valid ST micro ID.
> An offset of 1 for the device ID enum is needed when adding support for
> retrieving the ID from device_get_match_data() to allow detection of
> NULL pointer and fallback to i2c_device_id table.
> 
> DSDT chunk cropped for relevant parts.
> 
>    Scope (_SB.PCI0.I2C5)
>     {
>         Device (DEV)
>         {
>             Name (_HID, EisaId ("SMO8B30"))  // _HID: Hardware ID
>             Name (_CID, EisaId ("SMO8B30"))  // _CID: Compatible ID
>             Name (_UID, Zero)  // _UID: Unique ID
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.PCI0.I2C5",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                 })
>                 Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_._CRS.RBUF */
>             }
> 
>             Method (ROTM, 0, NotSerialized)
>             {
>                 Name (RBUF, Package (0x03)
>                 {
>                     "0 -1 0",
>                     "1 0 0",
>                     "0 0 1"
>                 })
>                 Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
>             }
> ...
> 
> Link: https://lore.kernel.org/all/20230129182441.082f29d0@jic23-huawei/
> Reported-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'd forgotten about these.  Still I have another few
patches waiting on dependency unwinding so will need to do a second
pull request later this week (first one will probably be tomorrow).

I've applied this pair and pushed out as testing for 0-day to take
an initial look at them.

Note I will definitely be rebasing though as need the tree to move
forwards for the palmas series.

Thanks

Jonathan

> ---
> 
> Since initial posting in thread added missing {} to terminate the
> list of IDs and MODULE_DEVICE_TABLE() so that autoloading of the
> driver works (thanks Darrell!)
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h     |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 499fcf8875b4..2617ce236ddc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -39,7 +39,7 @@
>  #define ST_ISM330IS_DEV_NAME	"ism330is"
>  
>  enum st_lsm6dsx_hw_id {
> -	ST_LSM6DS3_ID,
> +	ST_LSM6DS3_ID = 1,
>  	ST_LSM6DS3H_ID,
>  	ST_LSM6DSL_ID,
>  	ST_LSM6DSM_ID,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index df5f60925260..8ae5a485ce7d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -23,10 +23,15 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
>  
>  static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> -	int hw_id = id->driver_data;
> +	int hw_id;
>  	struct regmap *regmap;
>  
> +	hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
> +	if (!hw_id)
> +		hw_id = i2c_client_get_device_id(client)->driver_data;
> +	if (!hw_id)
> +		return -EINVAL;
> +
>  	regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {
>  		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
> @@ -129,6 +134,12 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>  
> +static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
> +	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
> +
>  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
>  	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
> @@ -161,6 +172,7 @@ static struct i2c_driver st_lsm6dsx_driver = {
>  		.name = "st_lsm6dsx_i2c",
>  		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
>  		.of_match_table = st_lsm6dsx_i2c_of_match,
> +		.acpi_match_table = st_lsm6dsx_i2c_acpi_match,
>  	},
>  	.probe_new = st_lsm6dsx_i2c_probe,
>  	.id_table = st_lsm6dsx_i2c_id_table,

