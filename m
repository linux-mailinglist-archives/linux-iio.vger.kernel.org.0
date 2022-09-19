Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6155BD1BA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISQCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiISQCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 12:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8783C140
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 09:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863A361D7F
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 16:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955FC433C1;
        Mon, 19 Sep 2022 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603243;
        bh=A+3EukwgL0OyGcKkFjYvXR0rTgLe3A5nROhfEQwhIFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEmvoffYBR4Rcy7yOhSaoSuoeqADRnCqYOPXxIeeFIl+ycstNHKdK6vF3pEc07WXP
         IBZUGFV5T+y7V0Exwnbfl0WVculKmswGvnQZwtbqVPXFURg0l936DR5X2xA0qqE25j
         Nm6hJhPxKLvEKVIsZ05NQsBTsw0w6Sp5VTU0cgFg8XNlr5D2phfkGDds6O1hGYYuD7
         5JM0isFeaprMKYsymVb+r+r02cTHGW8OJMULE+Y4q5Yth+CvZtWPLf5GqGBx7y5SW3
         hj2B/VSeIKmRv9ylGNC+a+MU1U+rF5sVGR0KOODwv+ccn9D/wJS6AjSWogj/y+PFLV
         rG+jnba4rY50Q==
Date:   Mon, 19 Sep 2022 17:00:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad9467: Silent no spi_device_id warnings
Message-ID: <20220919170048.0686b29c@jic23-huawei>
In-Reply-To: <20220919150003.823364-1-weiyongjun@huaweicloud.com>
References: <20220919150003.823364-1-weiyongjun@huaweicloud.com>
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

On Mon, 19 Sep 2022 15:00:03 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add spi_device_id entries to silent following SPI warnings:
> 
> SPI driver ad9467 has no spi_device_id for adi,ad9265
> SPI driver ad9467 has no spi_device_id for adi,ad9434

As for other drivers with similar pattern, please make use of
the spi_device_id->driver_data to provide the chip_info pointer
if the of_device_get_match_data() returns NULL.

A side effect of adding this spi_device_id table is that
it enables board file and other non firmware based forms
of device instantiation.

Jonathan
 
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iio/adc/ad9467.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 7534572f7475..67decbf2e119 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -447,12 +447,21 @@ static const struct of_device_id ad9467_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad9467_of_match);
>  
> +static const struct spi_device_id ad9467_ids[] = {
> +	{ "ad9265", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9265] },
> +	{ "ad9434", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9434] },
> +	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9467] },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, ad9467_ids);
> +
>  static struct spi_driver ad9467_driver = {
>  	.driver = {
>  		.name = "ad9467",
>  		.of_match_table = ad9467_of_match,
>  	},
>  	.probe = ad9467_probe,
> +	.id_table = ad9467_ids,
>  };
>  module_spi_driver(ad9467_driver);
>  

