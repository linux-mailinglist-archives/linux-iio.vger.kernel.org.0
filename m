Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE26006AD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJQG0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJQG0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 02:26:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C27552DC7
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:26:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b18so12714287ljr.13
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLlSjPOha0bRMNkyaEpt0McUjrdBOn8HnBMEtPT32xU=;
        b=kIFCV9zFDsYWOmacOTS34dzN8o434LcUFmfM4qtWGkdaHvncPObVBgXcK1Y2HlYjkF
         eRsOEUFdVEU7fjfxY+k5RBBmrOaaKVjY/9jiRa/ahQVeHGwcWHR+/C6fl+1nt6J07V3D
         vushIKytQIkXiR0oLX40fIxrQ0xiEojXZXoZX8jek0KX/YCC79NPxxPcjF8TpKRlYI1E
         kz115tl13S0kkHAKtbSiuuQuDVvl0OfOZB3nR8cqnozhYBIif7Olrs8QI4idpC12NSVn
         FnpHg7aaISpRrJG/XxtNsNA0gBpPj7Ig6wn3sThZkjKcrSN6wAEcTTRj5+E18o7pYgog
         6bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLlSjPOha0bRMNkyaEpt0McUjrdBOn8HnBMEtPT32xU=;
        b=rj5eeHOAOcaj1wXJAnVuBx+9nN4MPGBegzB1FjBhabZbGkq/phVaxkbnNNvXE6Isw4
         GCuvXe2VvR3pTVvA2z5T7COMvc93fmb96Iv9T7HW/1UInBS9JeNABih3mY/050yLoK+s
         Ll+bdt6f6asmPWqzRH3L6crIwXuGyfyTXSjsfWAyMbdNpI3vuc7n4cjxBinDtqJLzKpT
         BsB4MPPEZ/NlnMcQbuBoW0Upzyjn2wDW7ZcIveqojefNYpJjJ0OnZPEEVW850ko0oc+f
         f6+6BgWR+seizGBKI2O0ufkJSUzLfQjvmfQlwCuCv5QzUhYLnie8IY2VohcCmkHmLUHb
         SOdg==
X-Gm-Message-State: ACrzQf3I3vIb08FWpBWph7kdS3uiPQkkUFRdgXPN+dJA4htDTa5x3Blk
        AjRKk8jkwN3pR3ASZos0/vU=
X-Google-Smtp-Source: AMsMyM5OaGJB0hrAoux1N3cqBUQPpYjNbyoTwN1q1cum46C3GhujS3388UwOFWeqZpwhUqAO9bWV/w==
X-Received: by 2002:a05:651c:1501:b0:26f:ae50:56f8 with SMTP id e1-20020a05651c150100b0026fae5056f8mr3609194ljf.274.1665987977826;
        Sun, 16 Oct 2022 23:26:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eb7c8000000b0026d920a8114sm1317891ljo.100.2022.10.16.23.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:26:17 -0700 (PDT)
Message-ID: <95ebffcf-f118-d8a9-be8a-b265ddd53bb4@gmail.com>
Date:   Mon, 17 Oct 2022 09:26:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-14-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 13/14] iio: pressure: ms5611: Use
 devm_regulator_get_enable()
In-Reply-To: <20221016163409.320197-14-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/16/22 19:34, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver only turns the power on at probe and off via a custom
> devm_add_action_or_reset() callback.

I think this one did not use devm_add_action_or_reset()

> The new devm_regulator_get_enable()
> replaces this boilerplate code. Some additional refactoring to drop
> now unnecessary unwinding after this change.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>   drivers/iio/pressure/ms5611.h      |  3 ---
>   drivers/iio/pressure/ms5611_core.c | 32 +++++-------------------------
>   2 files changed, 5 insertions(+), 30 deletions(-)
> 

// snip

> @@ -477,7 +456,6 @@ void ms5611_remove(struct iio_dev *indio_dev)
>   {
>   	iio_device_unregister(indio_dev);
>   	iio_triggered_buffer_cleanup(indio_dev);
> -	ms5611_fini(indio_dev);
>   }
>   EXPORT_SYMBOL_NS(ms5611_remove, IIO_MS5611);

Just a thought but maybe the whole remove() could be done using devm()? 
(As far as I can say the current flow works. AFAICS the devm unwinding 
is done after the remove() has been ran. But perhaps it would be cleaner 
if the remove() would not need to be exported at all.)

With, or without the remove() removed, if commit description is fixed:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

