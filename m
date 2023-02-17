Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8B69B364
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 20:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBQTwW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 14:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBQTwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 14:52:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0995B2CB
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:52:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x4so2748642lfq.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLN8EHWMZbEwfgxuuCKgoIF7WasdJnh1zx+KDV2g+iY=;
        b=ofbm7qIBKahun2A6fVILrQPjVgee8qazvjec1a1BQepch4IOFwaPBRxnRg4byQSvKN
         9F32RioN+mbLq7wiTvbj8HSrkqGonPO0cNUByhzI/mGRQFyAB/yPHNbM8cVOG+VKvGDu
         7YKWGWhmTbkBhtb1oW26imEI9NAC+bXFMX6eyEBhemHrOLKo/e0wzokZ/LKA/V9KBGzG
         RZULst/ZS3DmZLUZwke43Tr2v7NUzm2DFV3JnNtxPBLmSJmg6zktl+fA9iDUz6L24o2i
         MtxliTQNq/QFtTidbWGvEPp4nfpYi/WrfXrFZi4w8I0OY1PW0pFy7Vssceipt5UE500u
         evIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLN8EHWMZbEwfgxuuCKgoIF7WasdJnh1zx+KDV2g+iY=;
        b=HJveg1vCiYVFJr04FfEUf5Hy+g7i8qYilcCiARhG8J5UZjsySRMBpMx5YCiGtaAsHW
         ESRfgNYHXJAF/uKdL+K4FXoRUMARP1Cr4yhjkJltLE2vRAIl48rwh7H7K9bbAOdZThsy
         btgq0ctdTUM0KtROlBXnqswt8LGweD4vwI5+Z8VP0Lk0lt20vS7PFYVCGHL6nRChW5ny
         4DNvGnjNBVwLF4VtiNBb+MTXKO/Zaxho4UhrZyZwI5/wacDf7mo9kM3ClgiKURCAIyw7
         la3f29CD0Sb2q/J6SE15NqbYgM3rNmfsxACezC6fxCyEckT5R++Y3RnCRNMApzfihZdn
         WLbg==
X-Gm-Message-State: AO0yUKWKYum7iMlO7UayEvT2ZEDk3USl0XYWTLwqiwrsM5FaIXUYQLvt
        A92Wypzrg+EEIgvKDXTKY8c=
X-Google-Smtp-Source: AK7set9tdzxnC+cKY+6nDpikxHLRugZCyJpJ23LrZ+NTs98nS6Xr7r0CzMkMImkEebjlHj6FL6qaNg==
X-Received: by 2002:a19:f50a:0:b0:4cb:c11:d01f with SMTP id j10-20020a19f50a000000b004cb0c11d01fmr581804lfb.22.1676663536453;
        Fri, 17 Feb 2023 11:52:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id r28-20020ac252bc000000b004d988f59633sm757021lfm.161.2023.02.17.11.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 11:52:15 -0800 (PST)
Message-ID: <1a565f66-7e2a-9ec5-441a-d33ef420cfab@gmail.com>
Date:   Fri, 17 Feb 2023 21:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] iio: accel: kionix-kx022a: Get the timestamp from the
 driver's private data in the trigger_handler
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
 <d81610c45af55b1c5eab5d0597f71650ff908203.1676661174.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d81610c45af55b1c5eab5d0597f71650ff908203.1676661174.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/17/23 21:19, Mehdi Djait wrote:
> The trigger_handler gets called from the IRQ thread handler using
> iio_trigger_poll_chained() which will only call the bottom half of the
> pollfunc and therefore pf->timestamp will not get set.
> 
> Use instead the timestamp from the driver's private data which is always
> set in the IRQ handler.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/kionix-kx022a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f866859855cd..1c3a72380fb8 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -864,7 +864,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
>   	if (ret < 0)
>   		goto err_read;
>   
> -	iio_push_to_buffers_with_timestamp(idev, data->buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(idev, data->buffer, data->timestamp);
>   err_read:
>   	iio_trigger_notify_done(idev->trig);
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

