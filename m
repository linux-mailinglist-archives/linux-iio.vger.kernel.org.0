Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC36469BB31
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 18:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBRRPr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBRRPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 12:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4012BD2
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 09:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469F260BA6
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 17:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC282C433EF;
        Sat, 18 Feb 2023 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676740543;
        bh=qG778IwKFPh1l1Zg0yWKZeBdZy5FLWDH9HqVWtdzyzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lhIYVauJzlGxeSkJ4z6Z8EPWqOaGeD1SAU4i00SBwnsfAASdraSUBZgk/IlsjpQ75
         fV3MjiWyjvGYe/h05k95siuLqLs3xw3bMDAQ6ZoPqcYnpCctaEQo07RCKgRWa+bV6b
         ZpVd5ak1sWa3ClhWs4Jki8S7aKs4SEUUP7gLnm3lm6cAbf2hEq2lxO4JtZBZRVkrmi
         36m74gYJAI+v1JMWX8TB41CxocCizJP7KT87MyHa0CpYX3sq2gixR4SnLd2kzS6TKF
         9+hovclYz+djYcPgDWH2pcqsN/190fj+sx5PqNWmwmwrF5oI/pyh5k4IZOMI/9H4k8
         16UtUHgmwfZLg==
Date:   Sat, 18 Feb 2023 17:30:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH v2] iio: accel: kionix-kx022a: Get the timestamp from
 the driver's private data in the trigger_handler
Message-ID: <20230218173003.435d3a8a@jic23-huawei>
In-Reply-To: <20230218135111.90061-1-mehdi.djait.k@gmail.com>
References: <20230218135111.90061-1-mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Feb 2023 14:51:11 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> The trigger_handler gets called from the IRQ thread handler using
> iio_trigger_poll_chained() which will only call the bottom half of the
> pollfunc and therefore pf->timestamp will not get set.
> 
> Use instead the timestamp from the driver's private data which is always
> set in the IRQ handler.
> 
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
You should have picked up Matti's Reviewed-by tag from v1.
I've done so whilst applying (I might well not have noticed it if I'd not just
read that thread)

I've also added a Link tag to the below mentioned discussion (first email
with a shorter link.

Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Add Fixes tag 
> 
> Relevant discussion: https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f 
> 
>  drivers/iio/accel/kionix-kx022a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f866859855cd..1c3a72380fb8 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -864,7 +864,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
>  err_read:
>  	iio_trigger_notify_done(idev->trig);
>  

