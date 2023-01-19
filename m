Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6038673D0B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjASPGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Jan 2023 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASPGS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2023 10:06:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492B83C3;
        Thu, 19 Jan 2023 07:06:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F75461C1E;
        Thu, 19 Jan 2023 15:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0BDC433EF;
        Thu, 19 Jan 2023 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674140776;
        bh=ed/d1Vc476vyDl5PAf6BZKDeh52LAXW4QTKCR29Wwos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+qBScBy5NjwE5b+jFH2oJR4GBZxRf3rwDsZDXzMUG2u4Z2TKPAlcej+oJ8Tt8CLC
         dUshQoe7+t30T5JtUpSjXsy9Wr25/iGgjBIdZUSlncyhzLq2ZO8YXYOCUOYDTo/aD2
         VxbXCMMACZURN6ojxDnP4V2Uwuv/1lXWKpKDhKy4MjzhSc/xhdtVm2R/qig/ml6A3W
         R6Sye8BvYGnBvqMXx6OZE1oEdjF782aSwWp4nqFkZKtvjGHS0QWiH+utpz45h5JFQ1
         O7gjpD6Vb2yxR8jdIlDTc5uOETRdmJvlLdyPCS3EtpwEuuzV+Xyl23qf5ek6Qmp2+1
         9dYHPohTlge2A==
Date:   Thu, 19 Jan 2023 15:06:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 3/7] mfd: mp2629: introduce chip id machanism to
 distinguish chip
Message-ID: <Y8lcY/hhDSEw9Mt3@google.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
 <20221123175425.564042-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123175425.564042-4-sravanhome@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"Use DT API to pass through chip ID"

On Wed, 23 Nov 2022, Saravanan Sekar wrote:

> Introduce chip id machanism to distinguish chip

Please be more imaginative than simply repeating the subject line.

Also: "ID"
 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/mfd/mp2629.c       | 4 +++-
>  include/linux/mfd/mp2629.h | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
> index f4c5aa06f38c..a3fc02ad5ec1 100644
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
> @@ -60,7 +62,7 @@ static int mp2629_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id mp2629_of_match[] = {
> -	{ .compatible = "mps,mp2629"},
> +	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },


Is this value something you can ask the H/W for?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mp2629_of_match);
> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
> index 89b706900b57..072c8181b48b 100644
> --- a/include/linux/mfd/mp2629.h
> +++ b/include/linux/mfd/mp2629.h
> @@ -9,9 +9,14 @@
>  #include <linux/device.h>
>  #include <linux/regmap.h>
>  
> +enum mp2xx_chip_id {
> +	CHIP_ID_MP2629,
> +};
> +
>  struct mp2629_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	enum mp2xx_chip_id chip_id;
>  };
>  
>  enum mp2629_adc_chan {
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
