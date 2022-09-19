Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EE5BD17F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISP44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiISP4y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C710544
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE758B8085E
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE94C433C1;
        Mon, 19 Sep 2022 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603011;
        bh=7SXua5PPtbFYIa4WGA1/9KpwNtmF6YqxdH4oxtz+cMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r70zsNCrcMgwzrhbV4Mj8IYr0MLWOonuUSIGoi/dFs/taahXVB46lAsgRHGNxwzHS
         3LRjRvyunUHJoz97UI+517ft9hPIc3lUUVy+s2kW+j51fZfzpc+QkLoKPg9a/2QqTH
         mpDczN8o/5j0yqTy25TAAlSAfmHE3XThdqIY6GBu6oKyRRcpj5hgpCg1gmNi9JGbim
         bYqtFWQGeSGaZ3ncFeIzy4xWXxgVX1UJ8GkOuHNtHDyouKiZHQHvv+vztM4aM3E/8w
         kvM7qu5BNiIjHFM/eixGw7YIaixLQu0sinbz5KYEDW4rkqFYdiDeqPUY4QafHrWADG
         jn25U8OaYWk5Q==
Date:   Mon, 19 Sep 2022 16:56:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: Silent no spi_device_id warnings
Message-ID: <20220919165655.31b7fcb2@jic23-huawei>
In-Reply-To: <20220919145955.823346-1-weiyongjun@huaweicloud.com>
References: <20220919145955.823346-1-weiyongjun@huaweicloud.com>
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

On Mon, 19 Sep 2022 14:59:55 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add spi_device_id entries to silent following SPI warnings:
> 
> SPI driver ad7192 has no spi_device_id for adi,ad7190
> SPI driver ad7192 has no spi_device_id for adi,ad7193
> SPI driver ad7192 has no spi_device_id for adi,ad7195
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Hi Wei Yongjun,

Please also make use of the spi_get_device_id(spi)->driver_data
path to provide the chip info structure if
of_device_get_match_data() returns NULL.

Interesting that this driver has not yet been converted to
generic device properties.  Looks straight forward if anyone
wants to tidy that up as well. Just convert all the
of specific calls over to generic forms from linux/property.h

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ad7192.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d71977be7d22..029025878bb0 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1098,12 +1098,22 @@ static const struct of_device_id ad7192_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad7192_of_match);
>  
> +static const struct spi_device_id ad7192_ids[] = {
> +	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
> +	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
> +	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
> +	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, ad7192_ids);
> +
>  static struct spi_driver ad7192_driver = {
>  	.driver = {
>  		.name	= "ad7192",
>  		.of_match_table = ad7192_of_match,
>  	},
>  	.probe		= ad7192_probe,
> +	.id_table	= ad7192_ids,
>  };
>  module_spi_driver(ad7192_driver);
>  

