Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB00550529
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiFRNnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFRNnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 09:43:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2551B781
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 06:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24368B8015A
        for <linux-iio@vger.kernel.org>; Sat, 18 Jun 2022 13:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65DCC3411A;
        Sat, 18 Jun 2022 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655559791;
        bh=K1zNY65Zan+BY++OJcrxwlKIZT+10vWrqGTTsQbVpv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nF81YZ1HrZziAN0CCAL3u1PxJ60mmKqKBHEH4O8sAn972gmLA+sIItIF7dvuGaf+2
         sBBoUzEWGV4qpDLkH//FofEVcX3QJ7F6B/ZRxGZELcWLQxLcq9ExOFogtrZbm06XEA
         sIo4xmL6DpHZqg8EtUN6Zpk2hN+pUZV6+YPw1O1JHOa5vvmY8GHeDBVCLsjoocpfh/
         EL59dN7tyOoqUHOS+t4XGjbaLEf+VNFNuIfGFWC3tiaBhqaNvqt0UdCnV2n7XXUka8
         4fhG523vvKgRIw2ONjkabbLbhJMA7csj2uAcwrn3ehA4Po6zuzpvchimqtjctmvYKV
         DvKJwZC7x/O6Q==
Date:   Sat, 18 Jun 2022 14:52:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio:light:tsl2563: Replace flush_scheduled_work()
 with cancel_delayed_work_sync().
Message-ID: <20220618145229.5c8fd452@jic23-huawei>
In-Reply-To: <3381176e-2f86-24ba-a8ba-c4ce8f416086@I-love.SAKURA.ne.jp>
References: <4c2df9f0-89db-cfe8-b2ac-54c991f9fa4e@I-love.SAKURA.ne.jp>
        <3381176e-2f86-24ba-a8ba-c4ce8f416086@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Jun 2022 23:52:59 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Commit 9e61d901155bcd4e ("iio: light: tsl2563: Remove
> flush_scheduled_work") replaced cancel_delayed_work() +
> flush_scheduled_work() with cancel_delayed_work_sync() for only
> tsl2563_probe() side.
> 
> Do the same thing for tsl2563_remove() side, which was added by
> commit 388be4883952872b ("staging:iio: tsl2563 abi fixes and interrupt
> handling").
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Changes in v2:
>   Use cancel_delayed_work_sync() instead of introducing a dedicated WQ.
Nice.  This does the job without the complexity or overhead of a dedicated
work queue.  

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathqan

> 
> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> using a macro") for background.
> 
>  drivers/iio/light/tsl2563.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 0a278eea36ca..4d89ac3a5bbc 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -803,12 +803,11 @@ static int tsl2563_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  	if (!chip->int_enabled)
> -		cancel_delayed_work(&chip->poweroff_work);
> +		cancel_delayed_work_sync(&chip->poweroff_work);
>  	/* Ensure that interrupts are disabled - then flush any bottom halves */
>  	chip->intr &= ~0x30;
>  	i2c_smbus_write_byte_data(chip->client, TSL2563_CMD | TSL2563_REG_INT,
>  				  chip->intr);
> -	flush_scheduled_work();
>  	tsl2563_set_power(chip, 0);
>  
>  	return 0;

