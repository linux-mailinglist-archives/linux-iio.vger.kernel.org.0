Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BF76802B
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jul 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjG2OzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jul 2023 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjG2OzR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jul 2023 10:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB753A85;
        Sat, 29 Jul 2023 07:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F22260C5A;
        Sat, 29 Jul 2023 14:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BAC433C7;
        Sat, 29 Jul 2023 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690642509;
        bh=aWXCh7oH3xMPQNIylQC26lGC0QXdOA7J8aKGgEDAfto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gBIJ4r7E8RfXs5WdYMYalGbLDzXnWTEp9OJsPJYjJP7UfAWHPJx+Rc4JkWMKV+SEn
         wNCBAbJByB9BNeSsD6QHtb8wITfSgirFacNfXLp8LS3W5L+ID5tTeCMA7z8tHXndl6
         /g/GaIap+XYWLneQmTYI8G/cyH8uKuYY+VMSom0VblNQNGblESnGwNwIN0Yx1UvKK1
         3/YhVsCib18qJYerKWyBxD+ZkRIz/Ks6AG4bvu7LGPZu5E3Q+GYZvJPjww0qLXNDls
         BGNryV50Po3wx+vwY4m0XRh/xIOquAHEfZ+SZw8YW04NB7O3mRGR5mgkWFncyo4tPi
         qCWJlmIpVkqoA==
Date:   Sat, 29 Jul 2023 15:55:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] iio: potentiometer: mcp4018: Use
 i2c_get_match_data()
Message-ID: <20230729155514.5eb8bde6@jic23-huawei>
In-Reply-To: <20230723105209.175545-1-biju.das.jz@bp.renesas.com>
References: <20230723105209.175545-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 Jul 2023 11:52:09 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() by making similar I2C and DT-based matching table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see if we missed anything.

Thanks,

Jonathan

> ---
> v2->v3:
>  * Added .name field to MCP4018_ID_TABLE macro
>  * Replaced MCP4018_ID_TABLE(name, cfg)->MCP4018_ID_TABLE(_name, cfg)
> v1->v2:
>  * Added similar I2C and DT-based matching table.
>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
>  * Dropped error check as all tables have data pointers.
> 
> Note:
>  This patch is only compile tested.
> ---
>  drivers/iio/potentiometer/mcp4018.c | 35 ++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 89daecc90305..44678d372126 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -99,20 +99,25 @@ static const struct iio_info mcp4018_info = {
>  	.write_raw = mcp4018_write_raw,
>  };
>  
> +#define MCP4018_ID_TABLE(_name, cfg) {				\
> +	.name = _name,						\
> +	.driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> +}
> +
>  static const struct i2c_device_id mcp4018_id[] = {
> -	{ "mcp4017-502", MCP4018_502 },
> -	{ "mcp4017-103", MCP4018_103 },
> -	{ "mcp4017-503", MCP4018_503 },
> -	{ "mcp4017-104", MCP4018_104 },
> -	{ "mcp4018-502", MCP4018_502 },
> -	{ "mcp4018-103", MCP4018_103 },
> -	{ "mcp4018-503", MCP4018_503 },
> -	{ "mcp4018-104", MCP4018_104 },
> -	{ "mcp4019-502", MCP4018_502 },
> -	{ "mcp4019-103", MCP4018_103 },
> -	{ "mcp4019-503", MCP4018_503 },
> -	{ "mcp4019-104", MCP4018_104 },
> -	{}
> +	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
> +	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
> +	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4018_id);
>  
> @@ -157,9 +162,7 @@ static int mcp4018_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	data->cfg = device_get_match_data(dev);
> -	if (!data->cfg)
> -		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
> +	data->cfg = i2c_get_match_data(client);
>  
>  	indio_dev->info = &mcp4018_info;
>  	indio_dev->channels = &mcp4018_channel;

