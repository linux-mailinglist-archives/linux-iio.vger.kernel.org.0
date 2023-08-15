Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84177CDC5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjHOOEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbjHOOE1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:04:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C03199A
        for <linux-iio@vger.kernel.org>; Tue, 15 Aug 2023 07:04:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31771bb4869so5058962f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Aug 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692108264; x=1692713064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Kt0D/0mRQreIolmu1hBGOuZHW1/1RKuyPYj9Zm0N6s=;
        b=SMC442GCemEBCZ7/mhbAiZoYbQlrOMVJSUIxAfyTqvayKZv6V1N8mFuvKcnTY2N3/h
         0uYw8m8ueZaV8kdWRhVOUQZOSms7Yo3cB6a/X2MxoHYEh4OJUwCQQmy2DNs6wYvXG14a
         uk9mwmSeYchwZ5EbAs6fjBY6zV4GMudMD97U87DHpFl+foJWy/fgTCYqthgUfrIlrXhX
         +yZcV41GwyiqRMW4hNaStImc7vkWKGAo6+9clTdsBH8xlzMgFfmwdSl4op0Yard8ZSsl
         FvtCtktilGibC9yHSwp/sqovGuQIVMyS8TroZaoqM+EmIQmqa2JTzZlBRCOKEnHpNA9Q
         e3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108264; x=1692713064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kt0D/0mRQreIolmu1hBGOuZHW1/1RKuyPYj9Zm0N6s=;
        b=JNJmIFHflturJCV7veTWmbrKLfKcb6oHQcRb0DtNrASHguA9myCHombIwAHh0za0NQ
         jzpPe9dsloyNYNc5Ow2QzNdfBoA92SlTSS06mqqdu0EQJUQEkPFb7CHRE0m6AhP7lRGP
         t0SgowJv69xtC7hC7oLralKUlE0k7whTqSvWkUdYRLgHKOH80woEoHK3QGsmptFRXuWT
         W7ZUFg1bgGa2XFBboxbcUyLe+T10b2bwSekhmY0c8YTT1JnfA3aYpI3KBzWkcWP83JaD
         q4OWGa7N1eCPx0Gje8LPUbWUuI5pGrB9XE7FHkN4eNUDVqlA75eTBvAiNKmmYV54Cl9d
         dFAQ==
X-Gm-Message-State: AOJu0Yx4YnGPv7oDKvD+EJ6gItzub8rI6JT/XQ8vGhXyAWQyhsDLTtJM
        19Lp+V3KN+yxPW1Tt/ZCxLinf1cpyiiI0tIAP+E=
X-Google-Smtp-Source: AGHT+IFEaEWHbfPxRqBmaj7JYEStaKa2v/AYKLUSsJi0+/geq6vNo0xOD/LDvxNcVz0OdPOUS6zE7g==
X-Received: by 2002:adf:dec2:0:b0:317:5a99:4549 with SMTP id i2-20020adfdec2000000b003175a994549mr8804116wrn.0.1692108264384;
        Tue, 15 Aug 2023 07:04:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y1-20020a05600c364100b003fbb06af219sm17941603wmq.32.2023.08.15.07.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:04:23 -0700 (PDT)
Message-ID: <628ea167-b61b-b8fd-df67-2871f867ad33@linaro.org>
Date:   Tue, 15 Aug 2023 16:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] iio: dac: ad5755: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
References: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
 <20230811163324.00003b3c@Huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230811163324.00003b3c@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/08/2023 17:33, Jonathan Cameron wrote:
> On Thu, 10 Aug 2023 13:19:32 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> When compile tested with W=1 on x86_64 with driver as built-in:
>>
>>   ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I'd rather see the table used as relying on the fallback path via the spi_match_id table
> is fragile as two tables may not have equivalent entries in the long run.
> Entry missing in the spi_driver.driver structure.
> 
> Bonus points for adding the match data to the of table and making them all pointers
> there and in spi_device_id table + using spi_get_device_match_data()

... and now I remember that I already sent such patch some time ago and
you already said this to me. Uh, sorry for sending the same thing again.
I'll fix it in spare time as you described.

Best regards,
Krzysztof

