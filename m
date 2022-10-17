Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280F860067B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 07:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJQF4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 01:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJQF4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 01:56:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80E558E4
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:56:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id be13so261747lfb.4
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1HCS8JDhB0vIx+R9wPJXqBcVpvkbCvdPjWczZNWvHg=;
        b=QIKP0fh6ikRXizVHrV5d6JG0SYSGjJI4YQpijxCzVgtpI9m8fhPmc43DN4mahw2+Gn
         X/jeltNjW2oTBeoZpuc2a7EyhaWtE8rTXBsX7rKFlI6WZA5KaN/Sr5ZJmBefJBmK36aB
         1DtbSmG7LkUXsew/cUP3cjcvz7WusZrUhVbLD/Pirav7p9RR8dcufUty3jCY1ZF98WI9
         On5NwhW3kIdxZwORNPgXDEMZAqgJm/hEaFwqPZ8OzpB0FruoQEtve5Km4rFpaJwMgnTs
         XnWApSEZ61q+ILJ2oANaOK4AYiVgZgzqPpyK17RMbdf3E0SmqTtzuZ5rq+v77Jx4Ujx/
         ze9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1HCS8JDhB0vIx+R9wPJXqBcVpvkbCvdPjWczZNWvHg=;
        b=K3Wn/lk/uGnbVN0lxAYsw1mPxfQblcWrJkBEC+wThXkVjPdT0+RhIENcwY17VbKQgN
         p7lPxhJJsUq+saWYEHBS7A5phPVZlJULMlb22rym8fW1i1TZg+6lyMXibje3dXKM1Er+
         mnuu2tx+UepWCYWaahxvNvh4vJY3NLb5XfB0Suz5sOPI/qVHhHfrt9bye6Er5qm7moyG
         YLuKHpvlptwT4ZrWNg3Z1h2Yt/AwYp6jezH8APlk/VLCufwUu3W39KBlKVBO4yBigml6
         pfjHeBr0UH5sLnyNTV9fIMP7xRYY7Q1wGSabfvIJ7ciptpqmnfnT7dYeJaL6Tw40u+kW
         CIRA==
X-Gm-Message-State: ACrzQf0XUMH+PFL4BcN3Dl34oyZWBQnK207TTmmKV4BP8JySfIVQRczi
        1vHIq9oTmuv0foCv1q6dKA4=
X-Google-Smtp-Source: AMsMyM7CeQeXQ9VDUOutB0wW+qf1U07q078jMtFH7vQ2DuWiNCJJE8YTEqE/0h+DPlGMU7xrKUScKw==
X-Received: by 2002:a05:6512:6ce:b0:4a2:530a:33d0 with SMTP id u14-20020a05651206ce00b004a2530a33d0mr3546793lff.270.1665986179263;
        Sun, 16 Oct 2022 22:56:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b0026fc79fd67dsm1351551ljc.74.2022.10.16.22.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:56:18 -0700 (PDT)
Message-ID: <3c1a2155-716b-ca43-776c-77e3387d77f3@gmail.com>
Date:   Mon, 17 Oct 2022 08:56:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 10/14] iio: light: ltr501: Use
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
 <20221016163409.320197-11-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-11-jic23@kernel.org>
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
> This driver only turns the power for some regulators on at probe and off
> via a custom devm_add_action_or_reset() callback. The new
> devm_regulator_bulk_get_enable() replaces all this boilerplate code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/light/ltr501.c | 27 ++++-----------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

