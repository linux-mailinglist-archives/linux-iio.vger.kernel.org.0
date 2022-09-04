Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5E5AC59F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiIDROn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiIDROl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 13:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EB14038
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AD960FBA
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 17:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795BCC433D6;
        Sun,  4 Sep 2022 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311679;
        bh=vU4L1nMph1Mdf4cD85/zPUrhNx8umPAAj0pZ89YLjHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jXnfsU1k2GL7xrLOUtOftQzYGiHBzOOTyMejibXJ0NbSMxn+CycaYC3APueVTVBXB
         wYRBWBLBooAE6tAxFhJV77pCj3MKiu6TKLQtdJPz3RFC80aowcnqcQronB58T/emyO
         kPQslp4PVWPVA7KggpFaWMxx+7V6dQaInMqXQHNbWwjIhIA29XWbRrjqcWBi8IBnqc
         CONN3fB6OyyMF+VvACTftZpBul9kj7zyXxI19BttpkYqSG03YX5nAXxnXde5rY//Is
         ynPo6tYnB7hklrxAbE/+IB0bWSQCNmb+s0qiAUDw1GSCGL5yH7NNg/Tfztwi7Isf1D
         m4gJSg3XP8lRQ==
Date:   Sun, 4 Sep 2022 17:40:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: max1363: Drop provision to provide an IIO
 channel map via platform data
Message-ID: <20220904174032.7fbd7673@jic23-huawei>
In-Reply-To: <20220821161058.2207185-1-jic23@kernel.org>
References: <20220821161058.2207185-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Aug 2022 17:10:58 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Back in the days of board files, platform data was used to provide
> information on the mapping from ADC channel to an analog signal
> from another device. We've long since moved to doing this via
> device tree. Hence drop the support from the max1363 driver which is
> the only driver still providing this.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one is trivial enough that I'll take it without review.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if I'm wrong :)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1363.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index eef55ed4814a..a28cf86cdce8 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -29,7 +29,6 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/driver.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -1595,11 +1594,6 @@ static int max1363_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	ret = devm_iio_map_array_register(&client->dev, indio_dev,
> -					  client->dev.platform_data);
> -	if (ret < 0)
> -		return ret;
> -
>  	st = iio_priv(indio_dev);
>  
>  	mutex_init(&st->lock);

