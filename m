Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9C58982E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiHDHLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 03:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiHDHK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 03:10:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB5606BB
        for <linux-iio@vger.kernel.org>; Thu,  4 Aug 2022 00:10:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x39so19955480lfu.7
        for <linux-iio@vger.kernel.org>; Thu, 04 Aug 2022 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YG61Uivcd4S6kTpt4q1QPuOIXbaUzpil99F6obZc9l0=;
        b=Qdg6+LvUzoow/uebeV0lrwLhW/Ek8fN5tvdYyw1unnHWxJiag1xYtmbUHzByicpFUs
         A1nLNIOZ7mY//ZeC9JcMWq+K4+ZNFJgGPyUFonZ4l9hfNCmNbvi4G2nIAy+ppIObb6Df
         VYbrC+hUYeYpLjNOLOcLvl/OXfQe7E0yRWbUO9PszAuqMWDXkfGIgKGK4OU2xQ77v2hV
         9vqFrTbl/hNqOuraHyZEteF3sYwfZ2Ecqc2a7TRT0kEENK87Qoq4e44BNWlq/jshB2GY
         1qJ/ZQj2RovCVJ1rScEmXxuHr1xAv9sMVoDWROqZ+4bYzwwKyX8MvJOsRgeQEt660+qA
         vUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YG61Uivcd4S6kTpt4q1QPuOIXbaUzpil99F6obZc9l0=;
        b=pOZQuupNKYAUDEDpY0pNy/HDgPN1UWA5+qIujnn68ZxHzJvjXxFYvpkU8XtQwmiz9P
         c5XzTOn6q3Hvm2lVwVCqAzd1hIxi0rT/hAN5J39SNvhWGvIvqZlZIKXdYv6dAMdGlmOU
         WUGwQ8PSn/ctBKk/QrV8dyAKJznD1CJK6H0u5ox5Y3wHKZJYX1haSsHxKmMWYwxtlR9X
         4g8Zdrywtex2Qqw1DzeGWxDIGJHYDV4FPX7yAs9w5xLXtgS9sEBcNFjP+eloQOPk3EAR
         8GgxB+j1kTUogLo/ZF3vDtQGMAJ8sWL5o9oOH1WGISYAtRJP31R/hzSuzTDjuRjTJ9o9
         I1Gg==
X-Gm-Message-State: ACgBeo1njbOfn53D6fIkqmUBF3UBhM9EfEz8gC4GR9Vj2MxJLBc/wCIl
        JJqQf9wVmz++HUpIOfaPMeKdiA==
X-Google-Smtp-Source: AA6agR5yMU9o7QNtV/y9ouJt6QHnOa6F6f9WtivIiZi0peKgzPE9TZ2w3zFvWrOxxDmX8XsrZ7Xh7Q==
X-Received: by 2002:a05:6512:118b:b0:46b:a9ae:3a3b with SMTP id g11-20020a056512118b00b0046ba9ae3a3bmr229216lfr.188.1659597054255;
        Thu, 04 Aug 2022 00:10:54 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id r2-20020a19ac42000000b0048af9576d30sm26950lfc.83.2022.08.04.00.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:10:52 -0700 (PDT)
Message-ID: <d8fec5ab-2e03-4df0-f858-4a83c6f23233@linaro.org>
Date:   Thu, 4 Aug 2022 09:10:49 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB4016C146F9C8EF90557B362F909F9@VI1PR04MB4016.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/08/2022 03:05, Bough Chen wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年8月3日 18:20
>> To: Bough Chen <haibo.chen@nxp.com>; jic23@kernel.org; lars@metafoo.de;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de
>> Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
>> <linux-imx@nxp.com>; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
>> NXP IMX93 ADC
>>
>> On 03/08/2022 11:12, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> The IMX93 SoC has a new ADC IP, so add binding documentation for NXP
>>> IMX93 ADC.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 65
>> +++++++++++++++++++
>>>  1 file changed, 65 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> new file mode 100644
>>> index 000000000000..e0eac5aa81d7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>> @@ -0,0 +1,65 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>>
>> +cetree.org%2Fschemas%2Fiio%2Fadc%2Fnxp%2Cimx93-adc.yaml%23&amp;d
>> ata=0
>>>
>> +5%7C01%7Chaibo.chen%40nxp.com%7Ca11cd128f8814929684b08da7539b
>> dbc%7C68
>>>
>> +6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637951188101491669%
>> 7CUnknown
>>>
>> +%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiLC
>>>
>> +JXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JFNr4telb4AovE62YaHQu
>> KNr1ywL%2
>>> +Blc0dJMFNN1OA1U%3D&amp;reserved=0
>>> +$schema:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>>
>> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Chaib
>> o.che
>>>
>> +n%40nxp.com%7Ca11cd128f8814929684b08da7539bdbc%7C686ea1d3bc2
>> b4c6fa92c
>>>
>> +d99c5c301635%7C0%7C0%7C637951188101491669%7CUnknown%7CTWF
>> pbGZsb3d8eyJ
>>>
>> +WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>> 7C300
>>>
>> +0%7C%7C%7C&amp;sdata=A1PPlSkOsS7nWFOPAokyA1F8%2BYFSZj5dY%2FO
>> blm0U4UA%
>>> +3D&amp;reserved=0
>>> +
>>> +title: NXP ADC found on the imx93 SoC
>>
>> How different it is from ADC in imx8qxp?
> 
> They are totally two different ADC IP, no similar with each other.

Each submitter responds like that... how much different? What is
different? Driver has lots of copied pieces, so actually could be
unified as well.



Best regards,
Krzysztof
