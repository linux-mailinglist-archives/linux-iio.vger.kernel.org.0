Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6256B5B9A
	for <lists+linux-iio@lfdr.de>; Sat, 11 Mar 2023 13:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCKMZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Mar 2023 07:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCKMZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2023 07:25:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0771220AF
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 04:25:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k10so31034958edk.13
        for <linux-iio@vger.kernel.org>; Sat, 11 Mar 2023 04:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678537535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tqtr8iKWupVaZd5JTK6C4VW8Ms5eyCfL3EkZB3dztks=;
        b=JQELJFULBeqkyzCKxe62O1MMJy9DPCVQSq4HEicgp1vd1M3DMD1KylYRRScVQr8qfA
         dQ4wmIKy7/bfXP5eortuDPpJ2r32VUKwBM4WVip1bzL3Gz9NC3vKAzv31DAoE9WTK5wu
         cjzj1W3l30PwJWioM9m9k4b+bj2t60RTUOVls7RM9czGB6zdTw7aLKJanQLt91UIPOlP
         LGHjGQK5v1b7yFbGAzgidZMiQ1BeyOiCcW3xXHBBGXMJWnKOtQr9Aes5Nd3+vIIiGFk9
         xoZlRsmx76+qJeQwIIJyYJ9edFDtXicT26uwoz+aPjYDOLaW+Cs6yqLnOW+NKk+FebQH
         1RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqtr8iKWupVaZd5JTK6C4VW8Ms5eyCfL3EkZB3dztks=;
        b=gYxDYzVbPdgaKt56BV9M/ejyiwdjefieTexb/VHTOd4nJIlNyXjafbg1ivSWAtXuLQ
         NqWn3pbTP0JHh1AilfuAI0yU8BEP0NTCbwVLzhu46LHB9MQVAQE5Y2ihSWZdhwE8l6bm
         Bih2ouvyj50F9SQC7idFe7P9XGmMcGbLlUtzC629YPGdxyUhG9VRiHGl1Z0Bb95wftmw
         5nR7AivAUOjKP/zPk1HS+i2LfT1VdfkOWZwe2OhmwIJsvZ+6CRABUO+Y4ab7sFreceeU
         D+r4sY4gFV6oZApZD/MwDT3pc3pspOJwUroK0NBK4v9cEHdyUImWgRSQPEaf8Ku9jxzX
         ddcQ==
X-Gm-Message-State: AO0yUKXkoxEjVmhULdHDNoBM7nBpeblKo5dRBwDcNZlw4er1cu4Yit+v
        JHEMiWgZETHK5XqlZbEQWIwDow==
X-Google-Smtp-Source: AK7set8kkb9xg4gwG/LszXg3skB0/aQzhSSywlc0IySYE5HtpQbFn6JN5LTK3AnIeS4n1Jr5UeBXGg==
X-Received: by 2002:a17:906:274f:b0:87b:3d29:2990 with SMTP id a15-20020a170906274f00b0087b3d292990mr31153620ejd.9.1678537535475;
        Sat, 11 Mar 2023 04:25:35 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s1-20020a50d481000000b004bc9d44478fsm1126123edi.51.2023.03.11.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:25:35 -0800 (PST)
Message-ID: <68e9c7d9-1087-0454-6122-a88c7339ab3c@linaro.org>
Date:   Sat, 11 Mar 2023 13:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
 <20230311122208.059a81cb@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311122208.059a81cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/03/2023 13:22, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 12:14:55 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused (of_device_id is not used for device matching):
> 
> It should be used for device matching I think, so I'd rather see
> it assigned for that purpose than hiding the issue.

That would require testing and changes. The device matching is via SPI
table which has device data. Probably adding OF matching would require
bigger changes to for handling the match data.

This was intentional design in this driver, so we are not hiding here
anything.

> 
> 
>>
>>   drivers/iio/dac/ad5755.c:865:34: error: ‘ad5755_of_match’ defined but not used [-Werror=unused-const-variable=]

> 

Best regards,
Krzysztof

