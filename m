Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149862E281
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 18:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiKQREH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 12:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiKQREG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 12:04:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7771F0C
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 09:04:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x21so3480594ljg.10
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rcfJXOF5ifBFUjd2geW98xewo/95sxmBMcJPBTeN2Y=;
        b=VHbJini2+mabpf93vJs6ceDoWQ9oZdhQzuBKllPncG0HrweB0yXX/Q0i7Mth7o6rg1
         /7FYjIThxy5+ww57eEbDdaZYMxz8839DIkd5x1uOL9W93OJk3dh7WYikICXO3ATkggif
         gFCZmVzy9UT3RtgaEYxqnzdkWKpzhvALkafGb6V2TkxI6HbnpUjYqPfDStPvczGj6Y07
         lIcf/6OD/9MKe8wzSVwjJ6lkaGCCD4YCZ7w26HUO0CGJH8YjUZ2iWZqRg1FUQRV5b+B6
         /RmjoIDgbo4095B/xd3ZWMLV4yyEi49wgwGnnhFD0jkvSdZNI+izUCfIcZhDICGPy536
         BrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rcfJXOF5ifBFUjd2geW98xewo/95sxmBMcJPBTeN2Y=;
        b=PBoJDglFj+weDPnw+EzCLDJ8t4pb9DrwwRou01Ku78Yxa9M62u4+kmmt67IKgHfIYt
         JaykYoiHSwEFVeFOyX7c9Vwtv2pTNik6AfpQnlwDocFKsS91X4AqmURn1mgps60aeJOk
         jk0XGebruiUYRh3D9Pq7P760O0UjbNwyAnZZAvnFPh1Ot/b8MdnqAzMEIhZ5KbDbl8K+
         imOqFRzHxdIIY6slXt6ckmSFXTCSu/VCmnziacF/8E4Tb+kui+WqXCCTIGM+bBHJ0Xae
         YnHLk/6ovXflgjaLNCMUyZ9/PgCxyP2I3F7wMlkBJIPVl7W/NEwLBay8bneoir2TxL1g
         llCg==
X-Gm-Message-State: ANoB5pn3/pt94IUx16XbLoDj5Tgs9bufkLg0ZznDl2tYuiyIU1S63t+Q
        xs2WV1fK290aQFgw7SDm0UQGmQ==
X-Google-Smtp-Source: AA0mqf6StVAYjmXqjSXaaTzm6Eh60Phtd39Vi34NBxWJGQT0G8I7ysS/869001rhSYNCsB1ABAgsyQ==
X-Received: by 2002:a2e:a911:0:b0:277:44b2:6b9c with SMTP id j17-20020a2ea911000000b0027744b26b9cmr1291565ljq.26.1668704643204;
        Thu, 17 Nov 2022 09:04:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b17-20020a2ebc11000000b002775d0ae776sm292258ljf.14.2022.11.17.09.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 09:04:02 -0800 (PST)
Message-ID: <db76b0f9-ead4-4900-648c-45b8bd7b9355@linaro.org>
Date:   Thu, 17 Nov 2022 18:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
 <20221115174355.00004a01@Huawei.com>
 <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
 <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
 <467929c1-b405-507b-033d-bdc7abce703f@wolfvision.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <467929c1-b405-507b-033d-bdc7abce703f@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/11/2022 18:01, Michael Riesch wrote:
> Hi Krzysztof,
> 
> On 11/17/22 17:17, Krzysztof Kozlowski wrote:
>> On 17/11/2022 17:12, Gerald Loacker wrote:
>>>>
>>>>> +
>>>>> +  compatible:
>>>>> +    const: ti,tmag5273
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  "#io-channel-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  ti,angle-enable:
>>>>> +    description:
>>>>> +      Enables angle measurement in the selected plane.
>>>>> +      0 = OFF
>>>>> +      1 = X-Y (default)
>>>>> +      2 = Y-Z
>>>>> +      3 = X-Z
>>>>
>>>> This feels like something we should be configuring at runtime rather that
>>>> DT, or is it driven by board design or similar?
>>>>
>>>
>>> We use this sensor for a zoom wheel application, there is an EVM from TI
>>> for this as well. So this is for setting the mounting position of the wheel.
>>
>> That's ok, but does not explain why choice of angle measurement should
>> be a property of the hardware. I could imagine configuring device to
>> measure sometimes X-Y and sometimes X-Z, depending on the use case. Use
>> case can change runtime.
> 
> If I may chime in here: in our use case the angle channel is used
> directly as an input to adc-joystick, so that the combination of the two
> is an input device. We feel that in this scenario this angle measurement
> setting *has* to be a hardware property because the correct function of
> the input device depends on the correct choice of the angle property
> (which does not change during runtime, of course).
> 
> If we were to create a different input device in which the magnetometer
> was tilted by 90° (for example), then the angle property could be easily
> changed in the device tree. The user space, on the other hand, couldn't
> possibly know the correct angle property.
> 
> That said, I agree that there may be use cases in which the angle
> property should be changed during runtime. Would it be acceptable to
> create an IIO property that is initialized by the device tree property?
> (Please note that the implementation of the IIO property may not be in
> our scope, though)

It's fine. Thanks for the explanations. For runtime-configurable setups
this still can be changed via some other interface.

Best regards,
Krzysztof

