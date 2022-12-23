Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3E65532D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 18:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiLWRSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 12:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiLWRSE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 12:18:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA15F5B;
        Fri, 23 Dec 2022 09:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68728B80A26;
        Fri, 23 Dec 2022 17:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8369AC433F0;
        Fri, 23 Dec 2022 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671815881;
        bh=E6htoYRo1h77YE7046JifUKmh34bIHAt+UZTtTgDi6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qFp6OkuTKiAeYlBe52KXZzT1Mylq2610C1itrakaST4KZO1+Md/bUc7L/EcyGyo3a
         xtgTKjl0OolM+Kg6YXIvIrBgv+FmAbEutZpC4HJwGvYIK4v0c5GEGSqLtJLhTuq2h1
         qa15eTox2UeLczjro9mj/Y7oiUMf8v27ErSCqGGleVWRPyqN5zxjIjfnO2M8dEOKRD
         ROES9HLe4jrBY37Uzitudm6oM9FmEUEliWj4tFwUJ+JyjaBRf+K/MGLsY56fduyG21
         o7hemjPKkXFiYdVC7YYsAaDCYymENvsLwX/F8SKJPiSf8H4MlY/CyoiaOCxTJ1+ULv
         5tJCVaiA0i0gw==
Date:   Fri, 23 Dec 2022 17:31:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/4] iio: accel: add the new entry in driver for
 fxls8967af
Message-ID: <20221223173109.09ff4d06@jic23-huawei>
In-Reply-To: <88944b64-5e95-389f-5b47-2046c401f1b6@linaro.org>
References: <20221213171536.1880089-1-han.xu@nxp.com>
        <20221213171536.1880089-3-han.xu@nxp.com>
        <84bd582c-1dde-822c-48b7-025887fd0203@linaro.org>
        <20221214093214.00000a03@Huawei.com>
        <88944b64-5e95-389f-5b47-2046c401f1b6@linaro.org>
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

On Wed, 14 Dec 2022 10:54:00 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/12/2022 10:32, Jonathan Cameron wrote:
> > On Tue, 13 Dec 2022 19:53:30 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 13/12/2022 18:15, Han Xu wrote:  
> >>> Add this new device entry in the driver id table.
> >>>
> >>> Signed-off-by: Han Xu <han.xu@nxp.com>
> >>>
> >>> ---
> >>> changes in v2
> >>> - change chip info orders
> >>> ---
> >>>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
> >>>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
> >>>  drivers/iio/accel/fxls8962af.h      | 1 +
> >>>  3 files changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> >>> index 98811e4e16bb..c3589c3084ee 100644
> >>> --- a/drivers/iio/accel/fxls8962af-core.c
> >>> +++ b/drivers/iio/accel/fxls8962af-core.c
> >>> @@ -127,6 +127,7 @@
> >>>  #define FXLS8962AF_DEVICE_ID			0x62
> >>>  #define FXLS8964AF_DEVICE_ID			0x84
> >>>  #define FXLS8974CF_DEVICE_ID			0x86
> >>> +#define FXLS8967AF_DEVICE_ID			0x87
> >>>  
> >>>  /* Raw temp channel offset */
> >>>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> >>> @@ -765,6 +766,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
> >>>  		.channels = fxls8962af_channels,
> >>>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> >>>  	},
> >>> +	[fxls8967af] = {
> >>> +		.chip_id = FXLS8967AF_DEVICE_ID,
> >>> +		.name = "fxls8967af",
> >>> +		.channels = fxls8962af_channels,
> >>> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> >>> +	},
> >>>  	[fxls8974cf] = {
> >>>  		.chip_id = FXLS8974CF_DEVICE_ID,
> >>>  		.name = "fxls8974cf",
> >>> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> >>> index 17dd56756ff9..a8944b255a28 100644
> >>> --- a/drivers/iio/accel/fxls8962af-i2c.c
> >>> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> >>> @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
> >>>  static const struct i2c_device_id fxls8962af_id[] = {
> >>>  	{ "fxls8962af", fxls8962af },
> >>>  	{ "fxls8964af", fxls8964af },
> >>> +	{ "fxls8967af", fxls8967af },
> >>>  	{ "fxls8974cf", fxls8974cf },
> >>>  	{}
> >>>  };
> >>> @@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> >>>  static const struct of_device_id fxls8962af_of_match[] = {
> >>>  	{ .compatible = "nxp,fxls8962af" },
> >>>  	{ .compatible = "nxp,fxls8964af" },
> >>> +	{ .compatible = "nxp,fxls8967af" },
> >>>  	{ .compatible = "nxp,fxls8974cf" },    
> >>
> >> This is confusing. The I2C ID table has driver data, but OF ID table
> >> hasn't. So are they compatible or not?  
> > 
> > Due to some evilness in i2c that 'works' as long as the two arrays have
> > matching entries.  As a general rule we prefer to have the data in both, check
> > the firmware table first and only then fallback to i2c_device_id data on the
> > basis it is less fragile.
> > 
> > The evilness in i2c is that the search for match data will use the dt compatible
> > stripped of the vendor prefix and string match that against the i2c_device_id table.
> > 
> > Nice to clean this up, but not necessarily in this series (fine if it is though!)  
> 
> OK, so in fact devices are not fully compatible - I got mislead by OF
> table. I'll comment in bindings about it.

I actually took a look at the driver today. It's not using the driver_data anyway.
It does the better option of searching for a match based on the WHO_AM_I anyway.
So best option is a precursor patch dropping the driver_data from the i2c_device_id
table.
 
Oops. I was guilty of making assumptions and didn't previously check. It could have
been used as described, but wasn't.

> 
> Best regards,
> Krzysztof
> 

