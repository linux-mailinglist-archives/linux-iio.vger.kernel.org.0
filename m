Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A172F4FD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jun 2023 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbjFNGh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jun 2023 02:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbjFNGg4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2023 02:36:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8B1FD8
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 23:36:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98220bb31c6so61921966b.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686724610; x=1689316610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XElC6rJY+nGGxGJnZgLE09h9gOSS2v7GKSOK1qVdyVI=;
        b=fuAfEz2EgreON8JdOjjBrnjF7OA2dMgDAfL5ynlmQeA/mwKnHTuxrooKd6fGZhUAqp
         B6mMgA9b3lFbHLucy7PJiRP5QWK//A5kX1FTr/SSHuHEPDGMAWcHQMFZT6K5MSVyairJ
         TvjkPlEvPsMYYMygo//Bl8ZHXeGwVQfkkyWZBleJ/7GH2CIUJgEhb5wQK8IHyU7d1lLg
         Pi/ubGy0dOacMObD0O1eKxBCXzwObmzooCr9o/L032KqR5zdQrxvE75a4WfwwnqYvyR9
         4mnaoWJXVOY00p7l6KZZ6rNQDw08opKOS5HMnKx3R7Kkzpx6zrSJXzThwsWNskSIul80
         Lo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724610; x=1689316610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XElC6rJY+nGGxGJnZgLE09h9gOSS2v7GKSOK1qVdyVI=;
        b=HW/cASDn2dYxs02AbNAJMmwpoVJNqnZfcqOapXbPE8vYIB3bz0xpyoKI+Mla0Yer1a
         QI1T65RMAKQmcGLK1w3bP8EGDTxqf0QG75qSebaYdfli0ytOMvvJnEu1w/8GBWLEMCnf
         4EUv8w5u3IUUOaoj9yvRq9nylfM65edmdfqlSjHegsojQ6n7xhMHcMX6rehOt6bH83j6
         X3vQNgbKT2Zz4Lhy5UkI7lSutpGq0E4yRGW9+7sPBbNOBGHoB9KOmbIfcwzGc2AcSdF7
         GEKACuo61GSE1k2uygznAGsrfy270GmpUFPSVyLbktBrco7Muy4RMkPUbN901oziuucx
         sGeA==
X-Gm-Message-State: AC+VfDypiNqLUXDrEPU+wm1cwql+3lX9F38DzlElQFyEvas8v6Yr/IvQ
        r76msch+niJZD63kpM/Qp2emRA==
X-Google-Smtp-Source: ACHHUZ6MVTaz0VOwHMtzsEIlG4WyydULbVPqO89wCd+1+ZrO53ZwmsoyGzTwRRX1Zvb/wR/3lvCaZg==
X-Received: by 2002:a17:907:2d07:b0:982:6bba:79c5 with SMTP id gs7-20020a1709072d0700b009826bba79c5mr802844ejc.72.1686724610122;
        Tue, 13 Jun 2023 23:36:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b0096f738bc2f7sm7647403ejv.60.2023.06.13.23.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 23:36:49 -0700 (PDT)
Message-ID: <28cba091-48d0-846d-4996-64e71be275f2@linaro.org>
Date:   Wed, 14 Jun 2023 08:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: ROHM BU27010 RGBC + flickering sensor
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1686650184.git.mazziesaccount@gmail.com>
 <98e0b6fba7ff7515b541a517296d5b89dc73ce5b.1686651445.git.mazziesaccount@gmail.com>
 <22dadcf6-9879-efb2-9987-7f286b38b93b@linaro.org>
 <fac025f6-6187-2258-9d49-61799754294f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fac025f6-6187-2258-9d49-61799754294f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/06/2023 07:32, Matti Vaittinen wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: rohm,bu27010
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply: true
>>
>> Isn't vdd-supply required for the hardware to work? How does it get the
>> power otherwise?
> 
> The BU27010 works by magic smoke. When smoke leaks out the sensor no 
> longer works.
> 
> Ehh, I think you are right. My thinking was that it is not uncommon for 
> people to not have all fixed regulators present in device-tree. But I 
> agree, this does not mean we should encourage that. I'll add supply to 
> the list of the required properties.
> 
If the device actually requires a regulator, it should be required by
the bindings, even if it leads to dummies or fixed regulators on the
board DTS.

Best regards,
Krzysztof

