Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3348475DD71
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGVQZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 12:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B792699;
        Sat, 22 Jul 2023 09:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A7960AF7;
        Sat, 22 Jul 2023 16:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CA0C433C7;
        Sat, 22 Jul 2023 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690043127;
        bh=FCh6mMfH98pmylSNo+FT45c0lEWjtiwrsQV0G3r1acQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KrGl0mTBGGyq56JkR2vPaAwMwRMontw3bv93Om3qkanmCv7IJzEtiqPckz1SrGfzH
         WxZj8UtSyKhiDgTmsH78+B0ZRCrBi3Rse+Ulk86yq4T8vbVmXdN1rkpdu2bIWONCD3
         193G7TD68XoNvSDPGgeTkgtai9u5MAIICs3xPxqrJB6Wl+B96xA+yp3n1BYy7NFZe1
         uXh9JB309vC75PZNKzk0AsIFIEx6eN6IigFspQzdBj79uka9GDEFLM2WAYxZwL1d9l
         fUZDXhtpcoIvH0a199tlJdEqFaPGyG1OKZqrJXPhYmiyhBNocPzLwZSK4SQB+jfWCn
         1pIJDQghfIJVA==
Date:   Sat, 22 Jul 2023 17:25:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: accel: adxl355: Simplify probe()
Message-ID: <20230722172521.3b4e34cf@jic23-huawei>
In-Reply-To: <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
        <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jul 2023 18:52:15 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simplify the probe() by replacing of_device_get_match_data() and
> i2c_match_id() by i2c_get_match_data() as we have similar I2C
> and DT-based matching table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Applied to the togreg branch of iio.git, initially pushed out as testing
for 0-day to take a look at.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl355_i2c.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> index d5beea61479d..32398cde9608 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -24,19 +24,10 @@ static int adxl355_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	const struct adxl355_chip_info *chip_data;
> -	const struct i2c_device_id *adxl355;
>  
> -	chip_data = device_get_match_data(&client->dev);
> -	if (!chip_data) {
> -		adxl355 = to_i2c_driver(client->dev.driver)->id_table;
> -		if (!adxl355)
> -			return -EINVAL;
> -
> -		chip_data = (void *)i2c_match_id(adxl355, client)->driver_data;
> -
> -		if (!chip_data)
> -			return -EINVAL;
> -	}
> +	chip_data = i2c_get_match_data(client);
> +	if (!chip_data)
> +		return -ENODEV;
>  
>  	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
>  	if (IS_ERR(regmap)) {

