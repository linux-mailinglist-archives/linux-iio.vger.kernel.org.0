Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7E78B0DC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjH1MpW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjH1MpN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC412F;
        Mon, 28 Aug 2023 05:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0733864756;
        Mon, 28 Aug 2023 12:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596CDC433C8;
        Mon, 28 Aug 2023 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226708;
        bh=WmY31YydSwmcgBW6beCZTPKl9JWQgHn1z4t0rMd5igA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FYOUBhkpzNjo2CNeN3b1SAAVGqFTM+7uhcUsLzve0g03HQrr3/2QN9e6icM2hfOnU
         9z0x7eHHgrdY08BgCBym6Q/HA5RBxlyUrsHRDP+rDBVWvGdZMoqdObgENjrRaMqGui
         a76eVbLZZ6F1FXf5Z9HfzRCyPMFr1p7er5gSxrhaZkDyqHuVXegSDbVV3o4GKy5pdW
         1JbtkT1T9nBQPObL+x47XSLPLuhgAntzPGNxi2GSaQGh13ZQ9ltlfEkT5fcaH5g8b5
         4Qp0qZfgpe5NQgWxUugMTw2rt4a9KDikNZ8zYeWBhQX8Zt+jZA0Wjt7YWWGL3/aWQL
         o+5gawZ0UoaFA==
Date:   Mon, 28 Aug 2023 13:45:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: mcp4725: Use i2c_get_match_data()
Message-ID: <20230828134527.412c18cf@jic23-huawei>
In-Reply-To: <20230818174905.324623-3-biju.das.jz@bp.renesas.com>
References: <20230818174905.324623-1-biju.das.jz@bp.renesas.com>
        <20230818174905.324623-3-biju.das.jz@bp.renesas.com>
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

On Fri, 18 Aug 2023 18:49:05 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace local variable chip_id with struct iio_chan_spec for device data
> and use its .ext_info for chip identification. After this replace
> device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

The use of ext_info on a channel is messy.  Please just define
a clearly named flag in chip_info to make it simpler to maintain
and extend.

Jonathan

> ---
> v1->v2:
>  * No change.
> ---
>  drivers/iio/dac/mcp4725.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 33a61f65bc25..f9ce01c4cc53 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -386,7 +386,7 @@ static int mcp4725_probe(struct i2c_client *client)
>  	struct mcp4725_data *data;
>  	struct iio_dev *indio_dev;
>  	struct mcp4725_platform_data *pdata, pdata_dt;
> -	int chip_id;
> +	const struct iio_chan_spec *ch;
>  	u8 inbuf[4];
>  	u8 pd;
>  	u8 ref;
> @@ -398,10 +398,8 @@ static int mcp4725_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> -	if (dev_fwnode(&client->dev))
> -		chip_id = (uintptr_t)device_get_match_data(&client->dev);
> -	else
> -		chip_id = id->driver_data;
> +	ch = i2c_get_match_data(client);
> +
>  	pdata = dev_get_platdata(&client->dev);
>  
>  	if (!pdata) {
> @@ -414,7 +412,7 @@ static int mcp4725_probe(struct i2c_client *client)
>  		pdata = &pdata_dt;
>  	}
>  
> -	if (chip_id == MCP4725 && pdata->use_vref) {
> +	if (ch->ext_info == mcp4725_ext_info && pdata->use_vref) {

I think this will end up being hard to maintain.

Please define a mcp4725_chip_info structure and put the channels in there
+ a flag that says if the device in question supports an external reference.

>  		dev_err(&client->dev,
>  			"external reference is unavailable on MCP4725");
>  		return -EINVAL;
> @@ -455,12 +453,12 @@ static int mcp4725_probe(struct i2c_client *client)
>  
>  	indio_dev->name = id->name;
>  	indio_dev->info = &mcp4725_info;
> -	indio_dev->channels = &mcp472x_channel[chip_id];
> +	indio_dev->channels = ch;
>  	indio_dev->num_channels = 1;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* read current DAC value and settings */
> -	err = i2c_master_recv(client, inbuf, chip_id == MCP4725 ? 3 : 4);
> +	err = i2c_master_recv(client, inbuf, ch->ext_info == mcp4725_ext_info ? 3 : 4);
>  
>  	if (err < 0) {
>  		dev_err(&client->dev, "failed to read DAC value");
> @@ -470,10 +468,10 @@ static int mcp4725_probe(struct i2c_client *client)
>  	data->powerdown = pd > 0;
>  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
> -	if (chip_id == MCP4726)
> +	if (ch->ext_info == mcp4726_ext_info)
>  		ref = (inbuf[3] >> 3) & 0x3;

Add a flag to the chip_info structure for whatever we are controlling here
and then have
if (info->x_is_supported)
	...


>  
> -	if (chip_id == MCP4726 && ref != data->ref_mode) {
> +	if (ch->ext_info == mcp4726_ext_info && ref != data->ref_mode) {

I think this can also use the vref bool I suggest adding above.

>  		dev_info(&client->dev,
>  			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
>  			data->ref_mode, ref, data->ref_mode);
> @@ -511,8 +509,8 @@ static void mcp4725_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id mcp4725_id[] = {
> -	{ "mcp4725", MCP4725 },
> -	{ "mcp4726", MCP4726 },
> +	{ "mcp4725", (kernel_ulong_t)&mcp472x_channel[MCP4725] },
> +	{ "mcp4726", (kernel_ulong_t)&mcp472x_channel[MCP4726] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4725_id);
> @@ -520,11 +518,11 @@ MODULE_DEVICE_TABLE(i2c, mcp4725_id);
>  static const struct of_device_id mcp4725_of_match[] = {
>  	{
>  		.compatible = "microchip,mcp4725",
> -		.data = (void *)MCP4725
> +		.data = &mcp472x_channel[MCP4725]
>  	},
>  	{
>  		.compatible = "microchip,mcp4726",
> -		.data = (void *)MCP4726
> +		.data = &mcp472x_channel[MCP4726]
>  	},
>  	{ }
>  };

