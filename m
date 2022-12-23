Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417465531F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiLWROF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiLWROE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:14:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811EDEE02;
        Fri, 23 Dec 2022 09:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E52C0B820E4;
        Fri, 23 Dec 2022 17:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF59C433D2;
        Fri, 23 Dec 2022 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671815640;
        bh=dwEik7RgM7nCQvfwXXmf5xrglwz239U9WH7gWpBC7yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ixxJr1pXq53Gv4z5od6qWG/RvB6G8oUpHXXZx62Tj8l5XM3sukHV6iWnncM3p0rGI
         87h1sQGa53NNH3RLIgz68spLbLfuhPOAW2VVAAJVuXVn/HPbXjviCr0XL6RsNhYpmi
         o2iwZrg4tcDdCOFI7bocZqkwR9LLW2Fi4sdI5P/qG2P7b6NI0gMdfQ7WKQEeUrRkDW
         HbQ54s8iGmHPYqv9GXf62cNuUe9Iux2PJhYYK9kYsUxnmjIXtSAFMek7Jibbgsv9Ut
         v0pFwo561dqcwaT0p5x21b1r0ltwf681XsX6DhSkfawJ2OtuDxrklErmcUx88VZd7U
         0Rxvn4/bSqrtA==
Date:   Fri, 23 Dec 2022 17:27:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/4] iio: accel: add fxls8974cf support
Message-ID: <20221223172708.6bb84943@jic23-huawei>
In-Reply-To: <20221213171536.1880089-2-han.xu@nxp.com>
References: <20221213171536.1880089-1-han.xu@nxp.com>
        <20221213171536.1880089-2-han.xu@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Tue, 13 Dec 2022 11:15:32 -0600
Han Xu <han.xu@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> FXLS8974CF is similar with FXLS8962AF, the only difference is the
> device id change to 0x86.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
As per the discussion on bindings, we should establish
1) Is this driver going to support devices that have different channel descriptions
   If not - rip that support out as it is misleading.
2) Drop the error return if we don't match IDs.  Assume that it is infact yet another
   compatible part and use whatever it was said to be compatible with.
   If they are all compatible, just use the first element for this - things
   get more complex if there are multiple sets of compatible parts.

either way, we should drop the driver_data in fxls8962af_id[] as it's not used
anyway and that will avoid the complexity of the dt binding discussion.

> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 0d672b1469e8..98811e4e16bb 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -126,6 +126,7 @@
>  
>  #define FXLS8962AF_DEVICE_ID			0x62
>  #define FXLS8964AF_DEVICE_ID			0x84
> +#define FXLS8974CF_DEVICE_ID			0x86
>  
>  /* Raw temp channel offset */
>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> @@ -764,6 +765,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8974cf] = {
> +		.chip_id = FXLS8974CF_DEVICE_ID,
> +		.name = "fxls8974cf",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> +	},
>  };
>  
>  static const struct iio_info fxls8962af_info = {
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index 22640eaebac7..17dd56756ff9 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
>  static const struct i2c_device_id fxls8962af_id[] = {
>  	{ "fxls8962af", fxls8962af },
>  	{ "fxls8964af", fxls8964af },
> +	{ "fxls8974cf", fxls8974cf },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> @@ -37,6 +38,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
>  static const struct of_device_id fxls8962af_of_match[] = {
>  	{ .compatible = "nxp,fxls8962af" },
>  	{ .compatible = "nxp,fxls8964af" },
> +	{ .compatible = "nxp,fxls8974cf" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index 9cbe98c3ba9a..45c7e57412e0 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -11,6 +11,7 @@ struct device;
>  enum {
>  	fxls8962af,
>  	fxls8964af,
> +	fxls8974cf,
>  };
>  
>  int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);

