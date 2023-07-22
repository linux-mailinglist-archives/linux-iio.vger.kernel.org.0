Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341F75DD73
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGVQ2j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQ2i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 12:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329226A9;
        Sat, 22 Jul 2023 09:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 608CC60B9B;
        Sat, 22 Jul 2023 16:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57ECC433C8;
        Sat, 22 Jul 2023 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690043316;
        bh=a7Am5jOvCdeaPUWBUAahtldabtEuXNfLtiMia1cPLu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JsO85xLTj1DQzJU8GUuocN86gBCCMT/eTRwxpgHZ7h+w/2dJui5mhgjtdVhU7i2Qg
         5C6amDKNs+kIe30X9eSzXks7G5yLxbnidbLEM95A36XH1DBy8I2ABZ2DjGcMi7Lefd
         Rz07Bag2HeI2/62U7y3SsnT2vBMJXSc32b57NRqal0wbJ/MGVqRFaSWIzEW8u6N8+H
         xEWBy/kDR5MCQDvIVsjwUCjv/p7TFc7HbE/TQWPhbzIPNQODZJAn5xYFwe2IPErEhT
         Kmp1cJ3e/iSjS0gu9svpFrat9DWgi9YS9YINlm4eRT38nyU51LWqGuaTI1as5TasVL
         /sSCYFunRFsoQ==
Date:   Sat, 22 Jul 2023 17:28:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
Message-ID: <20230722172832.04ad7738@jic23-huawei>
In-Reply-To: <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
        <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
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

On Sun, 16 Jul 2023 18:52:16 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() as we have similar I2C and DT-based matching table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/accel/adxl313_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> index 524327ea3663..6d252190207b 100644
> --- a/drivers/iio/accel/adxl313_i2c.c
> +++ b/drivers/iio/accel/adxl313_i2c.c
> @@ -65,9 +65,9 @@ static int adxl313_i2c_probe(struct i2c_client *client)
>  	 * Retrieves device specific data as a pointer to a
>  	 * adxl313_chip_info structure
>  	 */
> -	chip_data = device_get_match_data(&client->dev);
> +	chip_data = i2c_get_match_data(client);
>  	if (!chip_data)
> -		chip_data = (const struct adxl313_chip_info *)i2c_match_id(adxl313_i2c_id, client)->driver_data;
> +		return -ENODEV;
>  
>  	regmap = devm_regmap_init_i2c(client,
>  				      &adxl31x_i2c_regmap_config[chip_data->type]);

This driver looks buggy:

static const struct i2c_device_id adxl313_i2c_id[] = {
	{ .name = "adxl312", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
	{ }
};

MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);

static const struct of_device_id adxl313_of_match[] = {
	{ .compatible = "adi,adxl312", .data = &adxl31x_chip_info[ADXL312] },
	{ .compatible = "adi,adxl313", .data = &adxl31x_chip_info[ADXL313] },
	{ .compatible = "adi,adxl314", .data = &adxl31x_chip_info[ADXL314] },
	{ }
};

Odd that the i2c_device_id table always uses ADXL312

That would only have previously applied if we failed to match on the of one
(which only happens in somewhat obscure cases)

Can we fix that first then apply this cleanup on top?

Thanks,

Jonathan
