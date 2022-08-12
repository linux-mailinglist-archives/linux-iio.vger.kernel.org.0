Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38475910DD
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiHLMkV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiHLMkU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 08:40:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E71F61B
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 05:40:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v2so1189435lfi.6
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YIfVk5qV6IbraaZwFyYTdjJsLosoEwiwnWTuuewGKd0=;
        b=VwWImj/vpxXTYulf5oM9HbksWEM7P3NAlvpGxheI3yGdygbm5LJrFQhnHXqdOYmNJy
         6nuA76C8u27+Kfdws/QR02EKqu2s25lH1omR3Gz9oXyzQ8YpP512w6uD5zyHIz6ykGyu
         Tnj4yq7mvkNxK2C234kaIngg9FjiXjvqYBmWELtltMbiB4qoiJMrK4UdfL41o9t1OtVc
         q6x0KoPOWCZxdFw2XfQr591ZmhOenocyiL19LUDkCFDxvN+88WH7lsvSefxsgpIdUkUq
         37noCLlhTMwLcMRHd5Kq9HAyVvydyXA2pbhdWAPu817QV3hMaQf52ZFB+nwnZSJg8haV
         ZkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YIfVk5qV6IbraaZwFyYTdjJsLosoEwiwnWTuuewGKd0=;
        b=UaPPLcEcJvqYoXHoKw4wwCeMFwc7/bDiO6btY7QIeJV9qqXX2bTD4gEZKQ+3hVSlHg
         hBr2Hw6tVg5Zu0pAmPKRVAFu+6tb5rtcivAggtwkHpJKQLwpvRCfSwAKkrsSycVy5mtg
         yy8JT0g8j4Fx7guGXV1b0XEaNeePF823erkVXnVPiYpc6MA9loL0wAcAvRNdMKoNCIlW
         pp9y7RiyyalkM1SQH4nasyRWsGqfhUhyTcavYfSE4OVXdLhHNU/d9sgw5FdIrDLnX9fE
         /Z/FI3LbYcGE+ZC81K8vBEHgUb6OkO+kzAIqpRNYZ3e7G6ub+MZg0O3QT1h3eCEih2wi
         e8OQ==
X-Gm-Message-State: ACgBeo1SzBTU08BAKICd6awPT40Ka9uYl6DmUrga/yRdro+VeAPEMFfv
        qobAZVm5vy7El4WFuS9nGohjzQ==
X-Google-Smtp-Source: AA6agR4UqqikmP8ZbS4wWLYJAG6gvzcVxMKj9RfEA9uWOeRHCu89xYNR9VJlR6rA/hDlVVzFQscGbw==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr1208711lfu.602.1660308016982;
        Fri, 12 Aug 2022 05:40:16 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b0048cf0fef301sm196719lfr.301.2022.08.12.05.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:40:16 -0700 (PDT)
Message-ID: <039fc122-613c-093f-f89a-6479f76825dd@linaro.org>
Date:   Fri, 12 Aug 2022 15:40:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Content-Language: en-US
To:     Bough Chen <haibo.chen@nxp.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
 <1659517947-11207-2-git-send-email-haibo.chen@nxp.com>
 <8afe7812-7dbd-7257-2a55-b4ae49f47381@linaro.org>
 <VI1PR04MB4016C146F9C8EF90557B362F909F9@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <d8fec5ab-2e03-4df0-f858-4a83c6f23233@linaro.org>
 <VI1PR04MB40163F952AD90A73664A560A90679@VI1PR04MB4016.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB40163F952AD90A73664A560A90679@VI1PR04MB4016.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/08/2022 14:51, Bough Chen wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年8月4日 15:11
>> To: Bough Chen <haibo.chen@nxp.com>; jic23@kernel.org; lars@metafoo.de;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de
>> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
>> <linux-imx@nxp.com>; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
>> NXP IMX93 ADC
>>
>> On 04/08/2022 03:05, Bough Chen wrote:
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: 2022年8月3日 18:20
>>>> To: Bough Chen <haibo.chen@nxp.com>; jic23@kernel.org;
>>>> lars@metafoo.de;
>>>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>>>> shawnguo@kernel.org; s.hauer@pengutronix.de
>>>> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
>>>> <linux-imx@nxp.com>; linux-iio@vger.kernel.org;
>>>> devicetree@vger.kernel.org
>>>> Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add binding
>>>> documentation for NXP IMX93 ADC
>>>>
>>>> On 03/08/2022 11:12, haibo.chen@nxp.com wrote:
>>>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>>>
>>>>> The IMX93 SoC has a new ADC IP, so add binding documentation for NXP
>>>>> IMX93 ADC.
>>>>>
>>>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>>>> ---
>>>>>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 65
>>>> +++++++++++++++++++
>>>>>  1 file changed, 65 insertions(+)
>>>>>  create mode 100644
>>>>> Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..e0eac5aa81d7
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> @@ -0,0 +1,65 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
>>>>> +---
>>>>> +$id:
>>>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fde
>>>>> +vi
>>>>>
>>>>
>> +cetree.org%2Fschemas%2Fiio%2Fadc%2Fnxp%2Cimx93-adc.yaml%23&amp;d
>>>> ata=0
>>>>>
>>>>
>> +5%7C01%7Chaibo.chen%40nxp.com%7Ca11cd128f8814929684b08da7539b
>>>> dbc%7C68
>>>>>
>>>> +6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637951188101491669%
>>>> 7CUnknown
>>>>>
>>>> +%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>>>> WwiLC
>>>>>
>>>>
>> +JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JFNr4telb4AovE62YaHQu
>>>> KNr1ywL%2
>>>>> +Blc0dJMFNN1OA1U%3D&amp;reserved=0
>>>>> +$schema:
>>>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fde
>>>>> +vi
>>>>>
>>>>
>> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Chaib
>>>> o.che
>>>>>
>>>> +n%40nxp.com%7Ca11cd128f8814929684b08da7539bdbc%7C686ea1d3bc2
>>>> b4c6fa92c
>>>>>
>>>> +d99c5c301635%7C0%7C0%7C637951188101491669%7CUnknown%7CTWF
>>>> pbGZsb3d8eyJ
>>>>>
>>>>
>> +WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>>>> 7C300
>>>>>
>>>>
>> +0%7C%7C%7C&amp;sdata=A1PPlSkOsS7nWFOPAokyA1F8%2BYFSZj5dY%2FO
>>>> blm0U4UA%
>>>>> +3D&amp;reserved=0
>>>>> +
>>>>> +title: NXP ADC found on the imx93 SoC
>>>>
>>>> How different it is from ADC in imx8qxp?
>>>
>>> They are totally two different ADC IP, no similar with each other.
>>
>> Each submitter responds like that... how much different? What is different?
>> Driver has lots of copied pieces, so actually could be unified as well.
> 
> HI Krzysztof,
> 
> Sorry for the delay, high loading on my current work.
> 
> For the difference, in general,
>  First, the register define is totally different.
>  Second, the ADC architecture is different, For imx8qxp, it contains ADC input ctrl + ADC core + ADC out control
>         For imx93 ADC, it called SAR_ADC, contain ADCD + ADCA, in detail, it also contain calibration/self-test/watch dog timer IP logic, 
>  Third, different conversion mode, 8QXP ADC support single and continue conversion, support average conversion.
>         For imx93 ADC, it support normal mode, include single and average conversion, inject mode, hardware trigger mode.
> 
> These two drivers architecture looks similar, because they all under IIO subsystem.
> 
> For 8qxp ADC, it's feature list in RM:
> ? Support up to 16 analog inputs
> ? Support five conversion pairs, can work simultaneously, with different conversion
> priority.
> ? Word size is 12-bits.
> ? Support Single and Continue conversion.
> ? Support Compare mode and channel auto disable if data match the requirement.
> ? Support Average conversion, Support flexible 4, 8, 16, 32 number of conversion
> data.
> ? Configurable sample time and conversion speed / power. The ADC core clock can
> vary from 300 kHz to 6 MHz, and the maximum sample rate is 1/6 ADC core clock.
> ? Conversion complete, hardware average complete, compare, DMA, time out flag and
> interrupt.
> ? Automatic compare with interrupt for less than, greater than, and equal to, within
> range, or out-of-range, programmable value.
> 
> For imx93 ADC, it's feature list in RM
> ? 4'd12-bit resolution
> ?Multiple modes of starting conversion (Normal, Injected)
> —Normal mode supports One-Shot and Scan (continuous) conversions
> —Injected mode supports One-Shot conversions only
> ?Software-initiated conversions in Normal and Injected modes, or external hardware trigger
> ?Two different abort features for either a single or chain conversion in Normal and Injected modes
> ?Independent data registers for each channel contain information about mode of conversion, data validity, overwrite status, and conversion data
> ?Alternate analog watchdog thresholds (threshold selected through input ports)
> ?Programmable DMA enables for each channel
> ?Individual interrupt flags for the following conditions:
> —End of conversion of a single channel for Normal and Injected modes
> —End of chain conversion for both Normal and Injected modes
> —Watchdog threshold violations
> ?Programmable presampling for channels
> ?Auto-Clock-Off feature for improved power performance
> ?Power-Down mode to place the SAR_ADC in power-down state
> ?Programmable clock prescaler for SAR_ADC (bus clock, or bus clock divided by two or four)
> ?Software-initiated calibration
> ?Self-test feature

By pasting big pieces of description from RM you do not prove what are
the differences and it is not my task to find that one line which shows
the decisive difference (e.g. support or lack of support for DMA).

Best regards,
Krzysztof
