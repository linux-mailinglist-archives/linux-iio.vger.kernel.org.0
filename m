Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29888655326
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiLWRQ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiLWRPo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:15:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028915FC6;
        Fri, 23 Dec 2022 09:15:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D35461AA5;
        Fri, 23 Dec 2022 17:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C4EC433EF;
        Fri, 23 Dec 2022 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671815739;
        bh=LliWdZNKpNVg2RJgUFWIuernU9+SZjIMYsTHKxOFp0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hmIMI4ftC88LrtJ5mUuMvSGe5mvZ7+oNJYWm2HTtNcVOEQ0TwwSr6YC562SBsnxzM
         txN7QZ+qGMPsj7EszE8QK2Gk3d05cgNUzpQ3ZzJMzf4VvM1iNb8l8QWFA7LbY39uEi
         fsQHVqsJSm7OhrYbg5RqEB3vxSVTB7SRvi8O4Ny4zKA9rKCmLjUSTtfN0vVQojz3Rf
         dZq08VTkBAXYaeazIDhwOPsXaIztP3XRUtPuaLD9R+//qjXosLIOf9Jg9MRgV5+A/e
         pPiuatbToHprvmRbjmMALZEtrNK7iB+7pR+a7WN6qejwA8tKZdZ733oO1PT8hJ8DjP
         riE9uK+uw30sQ==
Date:   Fri, 23 Dec 2022 17:28:48 +0000
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
Subject: Re: [PATCH v3 2/4] iio: accel: add the new entry in driver for
 fxls8967af
Message-ID: <20221223172848.34a90810@jic23-huawei>
In-Reply-To: <20221213171536.1880089-3-han.xu@nxp.com>
References: <20221213171536.1880089-1-han.xu@nxp.com>
        <20221213171536.1880089-3-han.xu@nxp.com>
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

On Tue, 13 Dec 2022 11:15:33 -0600
Han Xu <han.xu@nxp.com> wrote:

> Add this new device entry in the driver id table.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> 
> ---
> changes in v2
> - change chip info orders
> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 98811e4e16bb..c3589c3084ee 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -127,6 +127,7 @@
>  #define FXLS8962AF_DEVICE_ID			0x62
>  #define FXLS8964AF_DEVICE_ID			0x84
>  #define FXLS8974CF_DEVICE_ID			0x86
> +#define FXLS8967AF_DEVICE_ID			0x87
>  
>  /* Raw temp channel offset */
>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> @@ -765,6 +766,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8967af] = {
> +		.chip_id = FXLS8967AF_DEVICE_ID,
> +		.name = "fxls8967af",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
So far all the channels /num_channels in these have pointed to same place.
Not a lot of point in having the complexity if it's not used.  I'd like
to see that dropped unless we know it is going to be used in a patch set
you expect to post soon after this one.

> +	},
>  	[fxls8974cf] = {
>  		.chip_id = FXLS8974CF_DEVICE_ID,
>  		.name = "fxls8974cf",
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index 17dd56756ff9..a8944b255a28 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
>  static const struct i2c_device_id fxls8962af_id[] = {
>  	{ "fxls8962af", fxls8962af },
>  	{ "fxls8964af", fxls8964af },
> +	{ "fxls8967af", fxls8967af },

As in previous patch, driver_data isn't used anyway so drop it.
 
>  	{ "fxls8974cf", fxls8974cf },
>  	{}
>  };
> @@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
>  static const struct of_device_id fxls8962af_of_match[] = {
>  	{ .compatible = "nxp,fxls8962af" },
>  	{ .compatible = "nxp,fxls8964af" },
> +	{ .compatible = "nxp,fxls8967af" },
>  	{ .compatible = "nxp,fxls8974cf" },
>  	{}
>  };
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index 45c7e57412e0..ba33eb2b807d 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -11,6 +11,7 @@ struct device;
>  enum {
>  	fxls8962af,
>  	fxls8964af,
> +	fxls8967af,
>  	fxls8974cf,
>  };
>  

