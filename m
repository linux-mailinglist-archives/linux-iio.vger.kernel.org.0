Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789C6D3162
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDAOfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAOfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:35:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6F21C1DE;
        Sat,  1 Apr 2023 07:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7256B80B2D;
        Sat,  1 Apr 2023 14:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD48C433EF;
        Sat,  1 Apr 2023 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680359730;
        bh=Tu8K35e0xCyUqOn3xpFP8zgE3x43uoz1kDGNmUP3YLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IRJwFDfjLJ7GtNbBo4oyMIs+uxn/9V+OgqAguZvfmAw/M5CqIGaEj2TrRKbfanpoK
         jAIPPFUXNX5dj28ocYhf3AFeIBlewTemCBpKv9naP7+A9WwqDseWVTnLN0NR5Wl4Dh
         kkKIywOwqEMY05EirGAgU15f11GUBPzBDBr6MLPmmIWyKu4Q7b506EzvbHQUTc/PSR
         IkiX3ZCf45ftaZV81XwntN7Kj9Ic/wk6XP69qMiRaZwQ5T3aQbsyGsQdw7TOvvBOQR
         HC7wLAVVv/NmHNjXPNNNJ+7GSHSsvnbWs073iGe5SMu5JEZ0MEVMcmzUZgC/EWr5d8
         Gbe3L09qxONaQ==
Date:   Sat, 1 Apr 2023 15:50:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Eugen Hristev <eugen.hristev@collabora.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix an error code in
 at91_adc_allocate_trigger()
Message-ID: <20230401155039.6b6a8e4f@jic23-huawei>
In-Reply-To: <5d728f9d-31d1-410d-a0b3-df6a63a2c8ba@kili.mountain>
References: <5d728f9d-31d1-410d-a0b3-df6a63a2c8ba@kili.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Mar 2023 07:35:32 +0300
Dan Carpenter <error27@gmail.com> wrote:

> The at91_adc_allocate_trigger() function is supposed to return error
> pointers.  Returning a NULL will cause an Oops.
> 
> Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Seems obvious enough I've queued this up in the iio-fixes branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index b5d0c9ee284c..2a9fdc5b7edf 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1409,7 +1409,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
>  	trig = devm_iio_trigger_alloc(&indio->dev, "%s-dev%d-%s", indio->name,
>  				iio_device_id(indio), trigger_name);
>  	if (!trig)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	trig->dev.parent = indio->dev.parent;
>  	iio_trigger_set_drvdata(trig, indio);

