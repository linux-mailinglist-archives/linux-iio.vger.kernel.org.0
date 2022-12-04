Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7647641D5D
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLDOPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 09:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiLDOO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 09:14:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD7F16489
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 06:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E909860E00
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 14:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E5C433C1;
        Sun,  4 Dec 2022 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670163294;
        bh=LAgsXLX28aWgpbVLA5cmQLopihBVJWWySyKT3xtcXmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbWEn0HI1I56bOgM384loMhYK8wq6deBUXuHLoLYK4QeVmNnwZfX/wbzL+L+n5+D8
         bzBmmdKrcAmsnzxZt8SxDuJvW/JrnNhJNID7Qj3+KSg0zv8apBRH0nEG/jfz8tKmK7
         rr5Sz+WpOrp43gDyJbmpdfemG/9ZCvpJWzuWwJVNAeyozJMU19YDUhjX9Ao7ffaNcq
         NHSQWdh4V22QxxeV6xJQfpwjIcN4BN8JVPgNYH9CKRRJS8CPRitQRdtvOMogvXMGar
         qGiVwRuv7KwX06+kaJlKQGaX93YoOy9n9HVPSe0yfwl0A3IJHSXueTbB8aiCglTUxH
         c/CsemKDoukgg==
Date:   Sun, 4 Dec 2022 14:27:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <yangyingliang@huawei.com>, <guohanjun@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: berlin2-adc: Add missing of_node_put() in
 error path
Message-ID: <20221204142740.56a46ef9@jic23-huawei>
In-Reply-To: <20221129020316.191731-1-wangxiongfeng2@huawei.com>
References: <20221129020316.191731-1-wangxiongfeng2@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 29 Nov 2022 10:03:16 +0800
Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:

> of_get_parent() will return a device_node pointer with refcount
> incremented. We need to use of_node_put() on it when done. Add the
> missing of_node_put() in the error path of berlin2_adc_probe();
> 
> Fixes: 70f1937911ca ("iio: adc: add support for Berlin")
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Applied. 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/berlin2-adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 3d2e8b4db61a..a4e7c7eff5ac 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -298,8 +298,10 @@ static int berlin2_adc_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> -	if (!indio_dev)
> +	if (!indio_dev) {
> +		of_node_put(parent_np);
>  		return -ENOMEM;
> +	}
>  
>  	priv = iio_priv(indio_dev);
>  

