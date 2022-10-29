Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380696122E8
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ2MZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ2MZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:25:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C94357CF;
        Sat, 29 Oct 2022 05:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0B6BB80B71;
        Sat, 29 Oct 2022 12:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52B0C433C1;
        Sat, 29 Oct 2022 12:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046303;
        bh=9qMpJ1y9eGfmTrnQqr5LXMLGKzhUvuTMOkPRaAcikGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMd4O99FNhrTA5RP6K/vXTCBF4kWXUbI/7T7HW/Ja5rP7vm9bcD6nlbB44Dgpan1N
         0mmmTqsymRQiDdv6AF++ADLj5Sabfg7WDOVNtKKVl70GBgvPIwiXcpiKtwzuJXLw3A
         mbKaSWq4N7mra4oUFZdqhx9iSBmFnjcHTjWPg6bxlTTMHk3mBLXu8yxQPOreOiLxMl
         OeTmFB3C+LRCrOu7woVsRJy/hnzbsMRXg2Q9SKiJW1nSE86aACiTklCkZnaFOS1e+g
         zpVGQEHS6J4zvLh2oEdFS02dkFT1jhUqwZiL+kOxP2NyQW2xV9m5GEiBlavJdUr0pk
         7jNOjgtNNbJ5g==
Date:   Sat, 29 Oct 2022 13:36:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 5/8] mfd: mp2629: Add support for mps mp2733 battery
 charger
Message-ID: <20221029133658.7801a26a@jic23-huawei>
In-Reply-To: <20221029093000.45451-6-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
        <20221029093000.45451-6-sravanhome@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Oct 2022 11:29:57 +0200
Saravanan Sekar <sravanhome@gmail.com> wrote:

> mp2733 is updated version of mp2629 battery charge management
> device for single-cell Li-ion or Li-polymer battery. Additionally
> supports USB fast-charge and higher range of input voltage.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

There is a small ordering issue wrt to the next patch.

Ideal way to solve that is to introduce the new infrastructure
for the chip ID, but not the new ID itself until after the next
patch ensures we don't apply the wrong mask.

Jonathan

> ---
>  drivers/mfd/mp2629.c       | 5 ++++-
>  include/linux/mfd/mp2629.h | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
> index f4c5aa06f38c..57db0f5009b9 100644
> --- a/drivers/mfd/mp2629.c
> +++ b/drivers/mfd/mp2629.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/mp2629.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> @@ -43,6 +44,7 @@ static int mp2629_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	ddata->dev = &client->dev;
> +	ddata->chip_id = (uintptr_t)device_get_match_data(&client->dev);
>  	i2c_set_clientdata(client, ddata);
>  
>  	ddata->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
> @@ -60,7 +62,8 @@ static int mp2629_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id mp2629_of_match[] = {
> -	{ .compatible = "mps,mp2629"},
> +	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
> +	{ .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mp2629_of_match);
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> index 89b706900b57..ee0e65720c75 100644
> --- a/include/linux/mfd/mp2629.h
> +++ b/include/linux/mfd/mp2629.h
> @@ -9,9 +9,15 @@
>  #include <linux/device.h>
>  #include <linux/regmap.h>
>  
> +enum mp2xx_chip_id {
> +	CHIP_ID_MP2629,
> +	CHIP_ID_MP2733,
> +};
> +
>  struct mp2629_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	enum mp2xx_chip_id chip_id;
>  };
>  
>  enum mp2629_adc_chan {

