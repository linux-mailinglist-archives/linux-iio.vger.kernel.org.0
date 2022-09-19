Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEC5BD173
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiISPuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiISPub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:50:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DE33408
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 607A5B80AC7
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C19C433C1;
        Mon, 19 Sep 2022 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663602627;
        bh=HiC4CCvv2rW5PrX0xpMkv8VORwExllEenz47jxeMIvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YWqrZQvN4D93y9PrdxeqxBMazyd+iK+iG+9JHspBl+EgC/cXQrQYphMmVzMoJpS81
         +WgVUUWpC9Wh8YE55gTTDj9iMpOXWVbUwImGMfBgDJiIPIq4MW6EqZjLJEUD032IfC
         5IQ4HFy5z+ijyNiL9a1BELWw8cvEaXvWfe49GwrTPioka8qimdyLDMsgGUnaqppE+i
         CR3sQAr98FxJB2pZovyAvXdrX9AERdVN+N8/jfTmMjgZE8ATSjh/2gU5WkE0MUOlWt
         Qq5UyCLyNqc+6rUCfwVSk3pi1a2IYlz58+DGmae/5RNurPLKfHwjylGBQ+eOqxv3PU
         C2l1HjMWIavBA==
Date:   Mon, 19 Sep 2022 16:50:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads131e08: Silent no spi_device_id
 warnings
Message-ID: <20220919165030.541bb3ea@jic23-huawei>
In-Reply-To: <20220919150011.823383-1-weiyongjun@huaweicloud.com>
References: <20220919150011.823383-1-weiyongjun@huaweicloud.com>
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

On Mon, 19 Sep 2022 15:00:11 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add spi_device_id entries to silent following SPI warnings:
> 
> SPI driver ads131e08 has no spi_device_id for ti,ads131e04
> SPI driver ads131e08 has no spi_device_id for ti,ads131e06
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iio/adc/ti-ads131e08.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index 5235a93f28bc..9a6bc1be2877 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -926,12 +926,21 @@ static const struct of_device_id ads131e08_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ads131e08_of_match);
>  
> +static const struct spi_device_id ads131e08_ids[] = {
> +	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },

If we are going to provide this, please also modify the getting of the
const struct ads131e08_info to use spi_get_device_id(spi)->driver_data
if device_get_match_data() returned NULL.

 I don't think we have any magic in the SPI core to make that association
(maybe I missed a change there).

This is needed in case we are probing via a route that doesn't provide
firmware info via the interfaces in linux/property.h
and hence uses the spi_device_id table to get this info.


> +	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
> +	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, ads131e08_ids);
> +
>  static struct spi_driver ads131e08_driver = {
>  	.driver = {
>  		.name = "ads131e08",
>  		.of_match_table = ads131e08_of_match,
>  	},
>  	.probe = ads131e08_probe,
> +	.id_table = ads131e08_ids,
>  };
>  module_spi_driver(ads131e08_driver);
>  

