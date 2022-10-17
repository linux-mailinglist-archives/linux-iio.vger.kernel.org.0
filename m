Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAF60066B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJQFsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 01:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJQFsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 01:48:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D654C96
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:48:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r14so15887860lfm.2
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Plo5s4qeimizZiBn1uDtEdO36IqFrP0uWNOzobOMbw=;
        b=oFVL+5bit/sQvvBuC8RBLfoeRmmQnWG5tPJNiGI5P65+y/6Cooa4bO1fSwZ1iRfeWc
         9H91WaL0NW9R4yBGUy1ZEbrwWoyne5VHhTREOfrKi7sD4d5zQNJ042Bk8Cz6P91dxudT
         LI/SlxcRfftzaVFJTS+x9nAajjT6NTYjvfXQMD4nCr8fC3FiQYTZ7ylL2CFHds6WBjft
         o2ZEYQX6Za1qbzYa1Akihcnnd6egpU82mnKnhk53fznRPfH154Tirl0QeCcxE+vz0mCz
         N54Q7WjR+AjQzco0UH6OsXhtcM1ZohGu+wJljLikuu2vvbME+cBFeRK97p6qWqkNCoSc
         nKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Plo5s4qeimizZiBn1uDtEdO36IqFrP0uWNOzobOMbw=;
        b=v7ARN9W1ZG/l3TVWUM+/2ygXT/SiHwFQLyoz9CIK/QFluNWoYE5Co88yqnZTJNcVCX
         8gK1p6oUsyiXta+9muWLGZcC2iKuIpFbFI2pb+5qL2WQHqqvlzesAwSp1a4hHe+SKNcR
         FGJ0/bOBDAkHz+GlOQEivxIFbyq4Kcgi6sA1mFSVjQ90iYHxTv2357Hr0DXAu5qozSQN
         AfcJZnqhJK6bWKyQITiLXAuTze2rL9qdnSAO6uz8eqfciKtTJNwANRfuau2tFRNGAlru
         q8POnMq9SixuLrDSMuoVYLWCYf6l/CRLF05iMBRGyfvd7Bzh6Z1Y92E558P5vxbUz7s1
         FcJg==
X-Gm-Message-State: ACrzQf3Zvz4RGhXoTpDdqEfFmHIU/uztfFs8ZnN1seCS+rUIEUDb08TZ
        Ydb0u2sARtVEin3BUy0zFDA=
X-Google-Smtp-Source: AMsMyM6sru5xsZULNhWJUgPnXg7L2kHIoWb/VjCkV4gG1JA7KAr4UKo0xpxb7h0iYtsMnIWUOpX7Gg==
X-Received: by 2002:ac2:4adc:0:b0:4a2:6db4:9fa8 with SMTP id m28-20020ac24adc000000b004a26db49fa8mr3432405lfp.6.1665985686481;
        Sun, 16 Oct 2022 22:48:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id q22-20020ac246f6000000b00492dba3c85asm1279194lfo.220.2022.10.16.22.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:48:06 -0700 (PDT)
Message-ID: <955186d2-4c40-c5cf-d916-089e46952f6d@gmail.com>
Date:   Mon, 17 Oct 2022 08:48:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 08/14] iio: frequency: ad9523: Use
 devm_regulator_get_enable()
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
 <20221016163409.320197-9-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-9-jic23@kernel.org>
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
> devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
> replaces this boilerplate code.
> 
> Note that in event of an error on the devm_regulator_get() the driver
> would have continued without enabling the regulator which is probably
> not a good idea.  So here we handle any error as a reason to fail the
> probe(). In theory this may expose breakage on a platform that was
> previously papered over but it seems low risk.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/frequency/ad9523.c | 22 +++-------------------
>   1 file changed, 3 insertions(+), 19 deletions(-)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

