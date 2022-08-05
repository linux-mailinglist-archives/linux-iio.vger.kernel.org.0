Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB658A6C5
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiHEHL0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiHEHLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 03:11:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC88018362
        for <linux-iio@vger.kernel.org>; Fri,  5 Aug 2022 00:10:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y23so2102499ljh.12
        for <linux-iio@vger.kernel.org>; Fri, 05 Aug 2022 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=100CdEkhDrosnmQz7EudbC8ZWfUwtalSJ5D3M18Q6FY=;
        b=QC830ppYy9m2gC8NTb7waklpSdUNcb+Jxp4muQSkcH91nbEqv6CEzgsLVXhngw6luL
         GJ/IRTssrkJi2Vkp34a97meDQzyhAjGMZfWjEsYuV1VETpWJt31UsJVhaSVZEcse34Vb
         VaV5RLaHXMRR/sdZzNt86nqSoBTEpREwhLKBQ5jfqtTEXvGWaTf3iBVE3SMWx292BnVL
         tOcqoE/klRPV9FcB26tahB7ikUlUko1JJmT8BIpb6GE3Dgrsbnsex2H+nZQD21soVnf+
         vZ0yBkgqzLPA6hF3F6EvP9n4NbC5rz2n1IpNWIXBAO8O16sFapdeG/d9DuUL3IxhWc35
         /Lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=100CdEkhDrosnmQz7EudbC8ZWfUwtalSJ5D3M18Q6FY=;
        b=g1w/40u8ipwxWz451Ur7fLS/QtlVKEGiAud6LFrZUqhUArt6FUTrvpefQG+Dt22DHk
         W8zIKQYjXffP188aKswMf9lzNpdE+x1653Xdz8CGYGuI/U5QHZGKgixUhoUu9h5XJi0n
         tHhRGM2kAzWcQP/6P6iIujLBfaNkGqGb+LnasYaOd2g8GzPgHCSfkrwzlNttuaqhGjd0
         cPKtS/9GXW01qlLo3tDTU7fOdm+eAcFefh3Xo3HxXd8mErAF7v7d3OBPdQe8vg4c3gZQ
         FTfoDHCPQkAI/ZDGVTuMGWAoRBZfSDbxmqfcvrZQvl55vgznZ4tMlyIM7qMbrsQ2zPHr
         OTGQ==
X-Gm-Message-State: ACgBeo2UwtQjBYu9kfVjBWdhvcwwuYIVgQHLNpoypjbeeSRzwcpR24K6
        9Qwqzpx0aikhz5bBmztQ7aO4/duGqzwuY99nkMM=
X-Google-Smtp-Source: AA6agR7bAellR9/ZAGMxlXj+T/e5BasXnChRj/qcqk+9/FSr4g+EdL9aKZIDF7BARWF/PCScbmh0xw==
X-Received: by 2002:a05:651c:1a1f:b0:25d:af55:1a2b with SMTP id by31-20020a05651c1a1f00b0025daf551a2bmr1726953ljb.49.1659683449294;
        Fri, 05 Aug 2022 00:10:49 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id e5-20020ac25465000000b0048ae518364dsm369552lfn.148.2022.08.05.00.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:10:47 -0700 (PDT)
Message-ID: <cbd36b1b-1ddf-2d6b-40aa-88c40a41b526@linaro.org>
Date:   Fri, 5 Aug 2022 09:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: correct number
 of pins
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
 <20220731133034.034dced1@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220731133034.034dced1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/07/2022 14:30, Jonathan Cameron wrote:
> On Wed, 27 Jul 2022 16:01:48 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> BMG160 has two interrupt pins to which interrupts can be freely mapped.
>> Correct the schema to express such case and fix warnings like:
>>
>>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> We may need more than this.  What if only INT2 is wired?  

Right, thanks for pointing it out.

> I'd expect such
> a device's binding to include interrupt-names to cover that case.
> We'd also need a bunch of driver code to route the resulting interrupts.

Yes, which is a bit out of scope of fixing schema/DTS. The driver
supports only one interrupt and bindings are unspecific, so I think the
author just did not care about making it correct.

> 
> I think the snag is that adding such support will break existing bindings using the
> below.

I can prepare more relaxed version of the patch.

Best regards,
Krzysztof
