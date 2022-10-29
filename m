Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD26122F6
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ2Mfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ2MfN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 08:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09730563
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 05:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF1460A53
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 12:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F828C433D6;
        Sat, 29 Oct 2022 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046909;
        bh=AJX5a4MWJPmhbOvE5r9oiXNCGBUcZAzbruG9Ke6mLi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PD7p5/V4BDPDfdeRV3JdxngI6j4frc8309lTX42CspPrNFA149TUxqpoZcClxD8AZ
         gJNucXkg455/YXy9gaq3K/U1l/udLatUjVQhUjXWX+PE56xd6qhxl8zn6UYmzBF75H
         hTxs7MrtwAowmxMl06xFfcJX++R9mwbZyZ5QaqtmPxHJmyY5tfezwR3Rn2iybqXJoq
         mBKFZZ+SKwqLCLAkVsJVUqcfFkKAiySmi47T9864IRSH421h/sN/Wntjl+JMhHmxlQ
         ZwVk7exRz8UBBQ1F8TStlCHQxZD/1d+GZEPiixgWqUVOiJYvHMSoXt3YY0d98RWK/0
         PnRcVk9pL0Bvg==
Date:   Sat, 29 Oct 2022 13:47:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <mripard@kernel.org>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: at91_adc: fix possible memory leak in
 at91_adc_allocate_trigger()
Message-ID: <20221029134706.5f080004@jic23-huawei>
In-Reply-To: <20221024084511.815096-1-yangyingliang@huawei.com>
References: <20221024084511.815096-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Oct 2022 16:45:11 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> If iio_trigger_register() returns error, it should call iio_trigger_free()
> to give up the reference that hold in iio_trigger_alloc(), so that it can
> call iio_trig_release() to free memory when the refcount hit to 0.
> 
> Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Seems straight forward so I'm not that bothered about getting extra tags on this.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 532daaa6f943..366e252ebeb0 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -634,8 +634,10 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
>  	trig->ops = &at91_adc_trigger_ops;
>  
>  	ret = iio_trigger_register(trig);
> -	if (ret)
> +	if (ret) {
> +		iio_trigger_free(trig);
>  		return NULL;
> +	}
>  
>  	return trig;
>  }

