Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACEB646A13
	for <lists+linux-iio@lfdr.de>; Thu,  8 Dec 2022 09:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiLHIEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Dec 2022 03:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLHIEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2022 03:04:53 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF9554E2;
        Thu,  8 Dec 2022 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Type:In-Reply-To:Subject:Cc:To:From:
        Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References;
        bh=B4lX7Is3GLlD2F8OGLEZmROa9XN25sI+U9vajJTw5+0=; b=VLatFCjjlI0I4rWZpYXQJHzTMa
        yfwXzvchJkQzVpwc4dxXDvk1PHOjORO/CeVufUAMY3UONKz4s2g3II2W+4VycUagDw7MmakNItM/a
        f9pJTo0Kr3yDATqqVF77w1jWsHa7b7Ng78YEXlkNaotnfUFYZwqu8aZ1C/5taGAchtlineLNEdRvY
        M+9wMl3cvmyn2mlni/+LC3P02KTw33Mvrh6vg4QOeq70MpxuckljFXPs7NMAIOGF2fe3DZppu6aby
        fZz3Ku3nCIbqkHfDCGbvn1Tn1qgd4BNqvyG1A21e0yP5EBcxn3BEEUrtVYdIkEfvJ5ygcwZXVFD0A
        JRUzCluQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1p3BXQ-000MIs-UY; Thu, 08 Dec 2022 08:41:48 +0100
Received: from [192.168.0.30] (helo=webmail.your-server.de)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1p3BXQ-000IoF-Ht; Thu, 08 Dec 2022 08:41:48 +0100
Received: from 2a06.4004.10DF.0001.15d4.557d.AD03.f652.static6.kviknet.net
 (2a06.4004.10DF.0001.15d4.557d.AD03.f652.static6.kviknet.net
 [2a06:4004:10df:1:15d4:557d:ad03:f652]) by webmail.your-server.de (Horde
 Framework) with HTTPS; Thu, 08 Dec 2022 08:41:48 +0100
Date:   Thu, 08 Dec 2022 08:41:48 +0100
Message-ID: <20221208084148.Horde.VelCJlguEqv9w4LL58tGw8C@webmail.your-server.de>
From:   sean@geanix.com
To:     Han Xu <han.xu@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/2] iio: accel: add the new entry in driver for
 FXLS8967AF
In-Reply-To: <20221207162045.669958-1-han.xu@nxp.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.7/26743/Wed Dec  7 09:17:04 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Quoting Han Xu <han.xu@nxp.com>:

> Add this new device entry in the driver id table.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
>
> diff --git a/drivers/iio/accel/fxls8962af-core.c  
> b/drivers/iio/accel/fxls8962af-core.c
> index 17a6f4f4e06c..ddeb1b153499 100644
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
> @@ -772,6 +773,12 @@ static const struct fxls8962af_chip_info  
> fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8967af] = {
> +		.chip_id = FXLS8967AF_DEVICE_ID,
> +		.name = "fxls8967af",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> +	},
>  };
>
>  static const struct iio_info fxls8962af_info = {
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c  
> b/drivers/iio/accel/fxls8962af-i2c.c
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
>  int fxls8962af_core_probe(struct device *dev, struct regmap  
> *regmap, int irq);
> --
> 2.25.1



