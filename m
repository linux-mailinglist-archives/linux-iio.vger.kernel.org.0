Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D85BD1C9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiISQEO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 12:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiISQDs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 12:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADB13E85
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 09:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D5061551
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 16:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B8C433C1;
        Mon, 19 Sep 2022 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603348;
        bh=FGQ4eMVPI+svVp5BcrG88hFV6YmjZHrNQxo96180fN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eQNrjFHPjsNNXfBUfyTbkpk/tF6tUjTUO5lHXDpOPO+APV0UXePGDoc2S+1KJ/zBI
         0fYVNsIz9wOUfCGrk9eFulBngfnpopDBUoR1T+vIM2Ok12P0wi9JDEBb7XXlA+d6Hw
         F8nJ/1IrxtXEeeXFFaCPbGLXKXsZlD8aNjQDAuFWJTtGCyUKYNjgStvSIOlIbnU6bM
         o8WE/9NU4KbRRUDwOmXgBvBdq25aqXVnS6I00p7Ud2/8Vf0Zh9TpuBUU7MdgmnICfo
         v0TV3pa05NxSWTlvKtlJAmwEISHcTzXqx87PPlwhoTj2WKq2cncAjTHN3qk3Y5zRO4
         yqMbcQtBeNmRw==
Date:   Mon, 19 Sep 2022 17:02:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3300: Silent no spi_device_id warning
Message-ID: <20220919170232.549ca9f6@jic23-huawei>
In-Reply-To: <20220919150019.823401-1-weiyongjun@huaweicloud.com>
References: <20220919150019.823401-1-weiyongjun@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 19 Sep 2022 15:00:18 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
Hi Wei Yongjun

"Silence" rather than "Silent" in the patch title.
> 
> Add spi_device_id entries to silent following SPI warning:
silence

Please add the extra info that Lars asked for to all these patches:
the main aim here is to ensure driver module autoloading works.

Code in this patch is fine.

Jonathan

> 
> SPI driver sca3300 has no spi_device_id for murata,scl3300
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iio/accel/sca3300.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index eaa0c9cfda44..693fbe8d6cb9 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -679,12 +679,20 @@ static const struct of_device_id sca3300_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
>  
> +static const struct spi_device_id sca3300_ids[] = {
> +	{ "sca3300" },
> +	{ "scl3300" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, sca3300_ids);
> +
>  static struct spi_driver sca3300_driver = {
> -	.driver = {
> +	.driver   = {
>  		.name		= SCA3300_ALIAS,
>  		.of_match_table = sca3300_dt_ids,
>  	},
> -	.probe	= sca3300_probe,
> +	.probe	  = sca3300_probe,
> +	.id_table = sca3300_ids,
>  };
>  module_spi_driver(sca3300_driver);
>  

