Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90978B54B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjH1QXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjH1QX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD00D9;
        Mon, 28 Aug 2023 09:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E130639B1;
        Mon, 28 Aug 2023 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E008C433C8;
        Mon, 28 Aug 2023 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239804;
        bh=o/jFXI+4PDQqaeii6lhru0BhuK2E9c2qYS8zBrR1sFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6ANAuBFVVYtd85obqEVowYAknHVkQjFv5eynSU586jX8dW5ar1f+CJKNVDHC3vIA
         9RCC+BIA8k7sd3NNdiaaYhnxmDbgOPVxFZ9wJpIjgzPfBJtJw01+klP9uEjckrnofJ
         y1VPod0yVBTZj9BQJ4EKib4094uoR7V/k4GZ6oUyjR+6zQftG6+srBeiJlqTjbsv1j
         5zh2vESR/WIgKb7hxUq9/OKCZ7arR/8fRLoJ96ahCUrYJXGzHdcEAKx7gfgmqGotLN
         G0FqInt+y4I/ztuMuf6yRL9sd0UacaLfdPPpJPJ4nAROutqNXT2bViEA6TdKYZlhIw
         jg7If4xM26Pvw==
Date:   Mon, 28 Aug 2023 17:23:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt4001: Use i2c_get_match_data()
Message-ID: <20230828172343.021b00e9@jic23-huawei>
In-Reply-To: <20230812151908.188696-1-biju.das.jz@bp.renesas.com>
References: <20230812151908.188696-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Aug 2023 16:19:08 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace device_get_match_data()->i2c_get_match_data() to extend matching
> support for ID table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

This is fairly harmless (I think) but if Stefan or anyone else has a comment
I won't be pushing this out as non rebasing until after rc1.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/light/opt4001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index 502946bf9f94..6cf60151b3d8 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -412,7 +412,7 @@ static int opt4001_probe(struct i2c_client *client)
>  	if (dev_id != OPT4001_DEVICE_ID_VAL)
>  		dev_warn(&client->dev, "Device ID: %#04x unknown\n", dev_id);
>  
> -	chip->chip_info = device_get_match_data(&client->dev);
> +	chip->chip_info = i2c_get_match_data(client);
>  
>  	indio_dev->channels = opt4001_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);

