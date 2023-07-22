Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639A75DDBF
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGVRSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVRSs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 13:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9FE67;
        Sat, 22 Jul 2023 10:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63AD060BA1;
        Sat, 22 Jul 2023 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6A0C433C7;
        Sat, 22 Jul 2023 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690046324;
        bh=t4+kCmEDyUPWdZFi2LYAdvFdBKJJZ/byJ8zxGmhWFoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3BeA9fEe9fMac6/4CW6U87outT7hi4vHg/ATE6ThbBsMK1VD9yWcuG0N2upC3dYO
         RgjkYEJ5tYLOJ2qpPH3xRQgd4bexTAQdLELC+AFdJjzIKtzoTYGC1YhY5JOwkbHmxz
         NYsqNuzSLGe3KVg5R3W7WQ71Wkr6nNzgWu+9B+ByogZxlsL2avN7IkAB0IiEAv2zAQ
         XQUojOScBLqZYCp1/9NbTRxyiYUcHdp14t6jMwXGTm2XLU7p5l8AOVHAKuFMk+tJM9
         cRu6I41phrcRi3Nm9CYZTHuSFpZuLH3tDbn2P8WkoKGYR6sNdPe/gcBXqT+mFYkdIK
         x2j0J6pHvnmSg==
Date:   Sat, 22 Jul 2023 18:18:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
 i2c_get_match_data()
Message-ID: <20230722181839.085b6609@jic23-huawei>
In-Reply-To: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Jul 2023 08:16:03 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() by making similar I2C and DT-based matching table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Applied to the togreg branch of iio.git and pushed out as testing for
autobuilders to have a poke at it.

Thanks,

Jonathan

> ---
> v1->v2:
>  * Added similar similar I2C and DT-based matching table.
>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
>  * Dropped error check as all tables have data pointers.
> 
> Note:
>  This patch is only compile tested.
> ---
>  drivers/iio/potentiometer/mcp4018.c | 34 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 89daecc90305..b064e86ecce8 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info = {
>  	.write_raw = mcp4018_write_raw,
>  };
>  
> +#define MCP4018_ID_TABLE(name, cfg) {				\
> +	name, .driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
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
> @@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client *client)
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

