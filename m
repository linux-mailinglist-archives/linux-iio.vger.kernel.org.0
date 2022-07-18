Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FF578884
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiGRReO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiGRReO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 13:34:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4134F2C649
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 10:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03617B816CE
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 17:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA88C341C0;
        Mon, 18 Jul 2022 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658165650;
        bh=kukeo4YsPB9rMZIS/+v1w7AuUCXS/kG+/u394L64V8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DELXalXKvyL02sHtVfQX0MV3zWo2RF288NvcEE5KuP1d4CLJpZY8mOizDsDPUy3rR
         3Kw46TlzNGbd9Jl5SY2JN1kMPqyNYxIuMdEjH99lqau0D550RtssN6HwDAgMhxUlSz
         mWWR0SdBXR6aDl4Grfq84aDUXYSnUaAxDdvcEDPEjD+KIn4Dfwk9Nvn0V8jNvoFwyF
         N9bskga4h1GOpu0FRA9lYiq0fsbHCOYHsdjCt4YyfAvDJtKC4a4esLPImTChjuHZ+l
         Lxl3NdPcZkENM9mI9/tAfyL22dQjCNtV4eLXqm88rcB/onZkfWGqsRaTTvNOVxItf9
         9JcMJTAH24Pbg==
Date:   Mon, 18 Jul 2022 18:44:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Drop unused parameter to
 ads124s_read()
Message-ID: <20220718184406.727900fa@jic23-huawei>
In-Reply-To: <20220626153828.589664-1-jic23@kernel.org>
References: <20220626153828.589664-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jun 2022 16:38:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The channel number is never used in this call, so don't pass it in.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one is so trivial I've picked it up without pestering anyone for review.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads124s08.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 64833156c199..4ca62121f0d1 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -193,7 +193,7 @@ static int ads124s_reset(struct iio_dev *indio_dev)
>  	return 0;
>  };
>  
> -static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
> +static int ads124s_read(struct iio_dev *indio_dev)
>  {
>  	struct ads124s_private *priv = iio_priv(indio_dev);
>  	int ret;
> @@ -242,7 +242,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> -		ret = ads124s_read(indio_dev, chan->channel);
> +		ret = ads124s_read(indio_dev);
>  		if (ret < 0) {
>  			dev_err(&priv->spi->dev, "Read ADC failed\n");
>  			goto out;
> @@ -290,7 +290,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
>  		if (ret)
>  			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
>  
> -		priv->buffer[j] = ads124s_read(indio_dev, scan_index);
> +		priv->buffer[j] = ads124s_read(indio_dev);
>  		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
>  		if (ret)
>  			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");

