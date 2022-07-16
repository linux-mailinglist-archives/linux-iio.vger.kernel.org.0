Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3880577076
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 19:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiGPRoh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPRog (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 13:44:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A531D31D;
        Sat, 16 Jul 2022 10:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89F9CB80B06;
        Sat, 16 Jul 2022 17:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F8C34114;
        Sat, 16 Jul 2022 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657993473;
        bh=hbTBbW6QwYIosLKzqWUQvgF2opXvpQpGWz92NfHdu/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ftvWLqkC1SsT+mR7qoZ+TTUNRME6Izlsd4lTzWN2vl3Vze+diH7gtzKby47xsGDx7
         QIanX/EDgzCmwpKMM7qn5+j1Aiw03xOHLucZ1y/tw7wsy3+sDnQboA/ssgAhkK2TTB
         yRYEN+0mlqjkhaFV610/QLyzVmy1fWYwg/jlkguV8UVnr9Hr1ljC2BkjlwPSXMGjGL
         YkzguM3p5BCIGTJa+ZitFSHqOre8gcZSjQOMIojzXVKBQlMIWfc01npXivnnDRz5qo
         y2lxLTaTUvr2ytq0rdIQ3A4xSGqPoKcRRbQtQRd05gJqnS2MIF0v4LStkqWT+T8mT2
         xToVhzkHRd18g==
Date:   Sat, 16 Jul 2022 18:54:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: unlock on error path in
 max1027_read_single_value()
Message-ID: <20220716185427.21f2d660@jic23-huawei>
In-Reply-To: <YsbztVuAXnau2cIZ@kili>
References: <YsbztVuAXnau2cIZ@kili>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Jul 2022 17:54:45 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If max1027_wait_eoc() fails then call iio_device_release_direct_mode()
> before returning.
> 
> Fixes: a0e831653ef9 ("iio: adc: max1027: Introduce an end of conversion helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Queued up on a special
fixes-togreg-post-5.20-rc1 branch in iio.git as I don't think I'll get another
pull request out for this in time to intercept the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index b725d012625c..136fcf753837 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -349,8 +349,7 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev,
>  			"Failed to configure conversion register\n");
> -		iio_device_release_direct_mode(indio_dev);
> -		return ret;
> +		goto release;
>  	}
>  
>  	/*
> @@ -360,11 +359,12 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  	 */
>  	ret = max1027_wait_eoc(indio_dev);
>  	if (ret)
> -		return ret;
> +		goto release;
>  
>  	/* Read result */
>  	ret = spi_read(st->spi, st->buffer, (chan->type == IIO_TEMP) ? 4 : 2);
>  
> +release:
>  	iio_device_release_direct_mode(indio_dev);
>  
>  	if (ret < 0)

