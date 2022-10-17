Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55776600667
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJQFoQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 01:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQFoP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 01:44:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67554C91
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:44:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id x18so12684406ljm.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qJRPjP/GjwPxmkPHxIyW5T+0ZUEadjBIJapgn8Budg=;
        b=XOaJtcDvIpuin13njBxkPd+x3KkyTTYM0MhgiUp2XA8iS1C42WZwyNpoKOT0QkZQst
         hEyRmnxiWOZB0/45GaW26mkDAIq+5sZWHIesaQQkHBrfnNbfKQDvOWl3pLhbhdJ4tQDu
         hDkQU80eDG1HQweZ6OfQTHwbcctpHZVNPKg0/diFPFjmP71T7VzGZmcaVNA0r17Fnprs
         uuuZebUni1EXRaHSLGpDB93+QSpJFNDMH9HL3Ao0S0dGrjPqKTWEUtuZTsAyGaBdYS4i
         Drz29Ag0M7mTelOpKRMGlTS2Pb53ng8bBrebBPSxqdSF78f+wJjo3TcYlz7IZJ6o8tab
         rL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qJRPjP/GjwPxmkPHxIyW5T+0ZUEadjBIJapgn8Budg=;
        b=7jWh7ac0hvTd8bNbrIEUCVImXYYXHnUUW8cp9YGXvcdhMi2fIw74kZD8d7gosXN8oG
         VSNalCwZl2spme6iGJ1dM9YFpCDjNFYOOpJ/l1drc+rXHBdHzkDKlXAQ73x1ktz3JBty
         F9mbvpGDbeZSagfF0zP7wqH4xB6284mNKX+PhFUMEbFNmqsacdqaV0wUf7FWoCCpLL54
         q3/9SaqHl7CWnbsglrDKV29YAbVjajo8Ijk+nXpThIs6I1xjkCgmkw2G7ZbIH3r5QwcB
         Oz91U8se6NZEhn4y3fG2DiFFfNmvvw3w3WU8aFXwYBPMQSZ6tBGhdw4CYoCzvgVokN+u
         p47A==
X-Gm-Message-State: ACrzQf1UHQH2hHVzelUKTG6jGJeAWdHbAJFdgsVh8GUsCpiCuoMqCRfr
        bximAkkm+tSIEH1D6O5xif0=
X-Google-Smtp-Source: AMsMyM7vOPLNfIC+9M2utDentjww9cBDxs88uOj0dPSEsuydQyeahqPiHaI0ZxawN2A04qbhrUeI7g==
X-Received: by 2002:a2e:9395:0:b0:26f:a73e:1357 with SMTP id g21-20020a2e9395000000b0026fa73e1357mr3443340ljh.368.1665985451816;
        Sun, 16 Oct 2022 22:44:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id q3-20020a2eb4a3000000b00262fae1ffe6sm1350931ljm.110.2022.10.16.22.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:44:11 -0700 (PDT)
Message-ID: <a4a2a10b-a901-1ddb-8dcb-b2de6767e2e2@gmail.com>
Date:   Mon, 17 Oct 2022 08:44:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/14] iio: st_sensors: core and lsm9ds0 switch to
 devm_regulator_bulk_get_enable()
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
 <20221016163409.320197-8-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-8-jic23@kernel.org>
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
> These drivers only turns the power on at probe and off via a custom
> devm_add_action_or_reset() callback. The two regulators were handled
> separately so also switch to bulk registration.
> The new devm_regulator_bulk_get_enable() replaces all this boilerplate
> code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---

I like this change. Especially since the st_sensors_power_enable() is 
exported. Looks much safer (to me) now.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

