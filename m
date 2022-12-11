Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FC649440
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLKM4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 07:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLKM4b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 07:56:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2811156;
        Sun, 11 Dec 2022 04:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C79EB80A6C;
        Sun, 11 Dec 2022 12:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2372C433F2;
        Sun, 11 Dec 2022 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670763387;
        bh=doFg1fDXmbZbizKOhBWBV3HDplFBJsinGc2gZYNLYS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eu5xzWxDP7mDenloTq8xfjIb2v7Ke380A2AEtMZ7BgWv/y71Te6ssrQ06m3A8YAsU
         M31lHlJRaygBV4jB3goom0yM/t1OnsqjAbQGS4zaHvMRzvigBof15EVxzKIBFREehG
         UXdbEzIAQIsurIRXJfXSdTEG/V9XyFTlMYf3tYQtkyRMxC9lBdurKqNR0k4NvWaF2T
         gg8l0IuqerlthzIKSZhhCg+U7AjPLnG9q9Sx0jCJ/TyZKMvdFqO4maWV5sQtUk5oYc
         k9OGGYCcDTxpy06rwR1Re44C8JzX+Cdt6Wt/ft22uLTYnYYOXYzQ141294iDOMvpgz
         imV/X23LgpMcg==
Date:   Sun, 11 Dec 2022 13:09:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/2] iio: accel: add the new entry in driver for
 FXLS8967AF
Message-ID: <20221211130920.47f1c684@jic23-huawei>
In-Reply-To: <20221207162045.669958-1-han.xu@nxp.com>
References: <20221207162045.669958-1-han.xu@nxp.com>
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

On Wed,  7 Dec 2022 10:20:44 -0600
Han Xu <han.xu@nxp.com> wrote:

> Add this new device entry in the driver id table.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
Hi Han,

I went to apply this and discovered the FXLs8974CF_DEVICE_ID etc
isn't yet present in the upstream driver.  Have a I missed a patch
set somewhere?

One comment inline.


> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 17a6f4f4e06c..ddeb1b153499 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -127,6 +127,7 @@
>  #define FXLS8962AF_DEVICE_ID			0x62
>  #define FXLS8964AF_DEVICE_ID			0x84
>  #define FXLS8974CF_DEVICE_ID			0x86
> +#define FXLS8967AF_DEVICE_ID			0x87
Fine with these being in numeric value order...
>  
>  /* Raw temp channel offset */
>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> @@ -772,6 +773,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8967af] = {

I'd rather everything else was in 'alphabetical order as anyone looking down
the lists will expect that ordering rather than one based on IDs that they
probably won't have reason to know.

> +		.chip_id = FXLS8967AF_DEVICE_ID,
> +		.name = "fxls8967af",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> +	},
>  };
>  
>  static const struct iio_info fxls8962af_info = {
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index 4a755a39d702..fd21f524e04f 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -31,6 +31,7 @@ static const struct i2c_device_id fxls8962af_id[] = {
>  	{ "fxls8962af", fxls8962af },
>  	{ "fxls8964af", fxls8964af },
>  	{ "fxls8974cf", fxls8974cf },
> +	{ "fxls8967af", fxls8967af },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> @@ -39,6 +40,7 @@ static const struct of_device_id fxls8962af_of_match[] = {
>  	{ .compatible = "nxp,fxls8962af" },
>  	{ .compatible = "nxp,fxls8964af" },
>  	{ .compatible = "nxp,fxls8974cf" },
> +	{ .compatible = "nxp,fxls8967af" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index 45c7e57412e0..7de924d15694 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -12,6 +12,7 @@ enum {
>  	fxls8962af,
>  	fxls8964af,
>  	fxls8974cf,
> +	fxls8967af,
>  };
>  
>  int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);

