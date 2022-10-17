Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C865600674
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 07:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJQFyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJQFyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 01:54:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BAB558C4
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:54:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g1so15861048lfu.12
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZOverPqCDAqeZ+Y5Xs211oGhj2qDphnVZOVuA2EkWE=;
        b=SOM8HVNCKNt5anZsqW8LnHEerTYgca8En0NtIZRbPlAnMEeeOZhI5V4tvXgDvlNxyO
         Ll+edF4X8ZjzMJB+3iiIkYjdQ7EalUfZ0Rped/CCOZaPs8bM5oiyYUbqirFlHHolzIiC
         fSsHcVkRF9GkUF/98OupDDHHCr1IC09zGJbn2xEjYSAEk+pU+HD8QlXgIw2gXmWh4jgV
         dUysRkBtNUU7pr2v3SA+Dx4wNpA0KFqhjiQ3VC9AX6nKLYooKiQQkEbiN9LReTYRTpcc
         87vaTQQJ/oK8+ej1Mb/fwkEABAcGKP6oHaH7wGF8XaFu+pPq85L2xlDy3XpZ6ncZ7tOx
         o8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZOverPqCDAqeZ+Y5Xs211oGhj2qDphnVZOVuA2EkWE=;
        b=tMgV63+Gsaua80Y81g9Boul815xgbmyhe7TssG8bxJ25eO4ZFarxmaUuzLsRmp2HZe
         V5MJihrfMRnRuFZDqSs1PYLeIUon6va3J+GO8W6i+B8v2JIaOKzUeIqDPJABEGgzW3uV
         FZtQQJC3EbsQb6eqmbbZwmAloMOhm9VgArbYh2npK71Fx644cZF5wQxCvBOKLRK+tGx0
         OFMzxcAPqTO4uyqDIJkBbJndu6JWpCuqEXqIXtkXY5whlHX96p0/xaasMjWWb7AA3Qgq
         UxbjSwSuUzo539vLdREaMHe5YlM7eaLSqxxvKGWt3rw/fELHp/ERqXXqLkIK4Cu9FdqW
         WmHQ==
X-Gm-Message-State: ACrzQf1RsC2pyLZez96W5Tf7bN3heNEpoR3F+lNV5yxRnFrA5YUg6b4J
        m9Qoua81gJxsSm3uhNwCSE4=
X-Google-Smtp-Source: AMsMyM6grbRBheKH9Sz8sjWRLB8p3NuyKz0lm/efFiBhFd/gzTgxrlReJ8TT78+YJVE/ClxEU2cwow==
X-Received: by 2002:a05:6512:2618:b0:4a2:1d98:f41a with SMTP id bt24-20020a056512261800b004a21d98f41amr3723442lfb.78.1665986039880;
        Sun, 16 Oct 2022 22:53:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id q24-20020a194318000000b004a46f92ef06sm791529lfa.46.2022.10.16.22.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:53:59 -0700 (PDT)
Message-ID: <dbde96d5-4e82-6aed-17eb-7f309b8d1dcd@gmail.com>
Date:   Mon, 17 Oct 2022 08:53:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/14] iio: humidity: hts211: Use
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
 <20221016163409.320197-10-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-10-jic23@kernel.org>
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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/humidity/hts221.h      |  2 --
>   drivers/iio/humidity/hts221_core.c | 27 ++++-----------------------
>   2 files changed, 4 insertions(+), 25 deletions(-)
> 
-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

