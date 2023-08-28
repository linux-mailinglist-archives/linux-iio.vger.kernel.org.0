Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8919D78AF32
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjH1Lni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjH1LnL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477FE7;
        Mon, 28 Aug 2023 04:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E7B6140C;
        Mon, 28 Aug 2023 11:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C2C433CC;
        Mon, 28 Aug 2023 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222986;
        bh=72TztgUYNH11IGNCSOKuN1rbP+ed/poncefHEK1ZlE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=doDGZ3wiO4uuyKpoRYrvbiz4DAEiBNJLIB7Zx/3hJad6559ugCD0Iak3sK4Z4c8vf
         MEDgnit+9GKyTiFSHmeLp9pIupuOKyDaPcbjf2af+ync33cPSomkMB87B9NwFresRX
         3xon8JBcqcAT7FeEZMTc5EZ9SDODkR9ao6s0/BvobV5pSsjjxoDNhzgmGSiEX1uOWy
         QRMLp/ZgUmw1rYNDZwsjisfDH8jNewc3ZhLQTsuIybvjtwBZvGHhoImUTbByOa0jum
         efPYwT2krD//HSkKZyRGOhvKzdyV62nt5gk4iXiziOHzNkymoYc0vWDIpJTu75MyVB
         s0Z1L4gDZshbQ==
Date:   Mon, 28 Aug 2023 12:43:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: atlas-ezo-sensor: Simplify probe()
Message-ID: <20230828124325.44589f84@jic23-huawei>
In-Reply-To: <20230818183128.334233-1-biju.das.jz@bp.renesas.com>
References: <20230818183128.334233-1-biju.das.jz@bp.renesas.com>
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

On Fri, 18 Aug 2023 19:31:28 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simplify the probe() by replacing device_get_match_data() and ID lookup
> match by i2c_get_match_data() as we have similar I2C and DT-based matching
> table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

J
> ---
> v1->v2:
>  * Dropped the sentence for removing id from commit description.
>  * Added Rb tag from Andy.
> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index 8fc926a2d33b..761a853a4d17 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -203,7 +203,6 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
>  
>  static int atlas_ezo_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	const struct atlas_ezo_device *chip;
>  	struct atlas_ezo_data *data;
>  	struct iio_dev *indio_dev;
> @@ -212,10 +211,7 @@ static int atlas_ezo_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	if (dev_fwnode(&client->dev))
> -		chip = device_get_match_data(&client->dev);
> -	else
> -		chip = (const struct atlas_ezo_device *)id->driver_data;
> +	chip = i2c_get_match_data(client);
>  	if (!chip)
>  		return -EINVAL;
>  

