Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8755981E
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jun 2022 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiFXKpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jun 2022 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiFXKpN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2022 06:45:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F47C86C
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 03:45:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so3879584ejb.4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=2t+7HTFw4Am9k5wfnt+zpTYwsim5TZ2i9yEsItPpeso=;
        b=xcoXh7yCPrSwwOXsVEte8S9NR0zXlkpvvmSX4mcTWFeTdYGxCOjXXMGpaIaqsIAE1K
         bp0d/k4GmQ8d8KFLm3LHJNOZx0WMiu4WZUX7HLNDAsZEJN1sptGsrLYyPxjY9ktKrSY+
         anicQhYWBm83eN/+nf24xt/88s2e96BqLLMqqV5kNG1Cun51WNovucO46nd97ihvrKZF
         dnLW7i1sNcOp3Mp4GU7oElU9RGuLLHZTaYOd/EiSoahcaoQ1ovR0ARSV/9WojV7BCFK1
         Svcita+pSItq8jdZ6ZzrgytfqP0wj21BQU9Nqu6VjwpUbWuvEYZFpH+8A2yDStdJm384
         PEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=2t+7HTFw4Am9k5wfnt+zpTYwsim5TZ2i9yEsItPpeso=;
        b=Dx7bHT4pRN5mXDJmdAri+3P+4Ve8/N2B33joORwO2dgsoXOq3yXb6kM51uudcQ4rYF
         YrMq3nQsWNGwzrniYIGqmODvzSxdMNvYpWcyRF2qRGyZepS4bjL6zYaRcOFrxB+Og2Fx
         gMMvqFKD7bx8rOuR2ypQAWMryAYg/FUOT5KmaA4c+pz56dOAk/I2ifjrDaz5ma4hlqDf
         k5usaYmdd66wDFjM5Mtaij7MysShbz8cmrjcxhVcEVgvgt1L+HC7lNZez8yW91wk+zRz
         vqXBXObdq8evaPe7CuFTqYdm9yDD+kImqSm7jIOfPvWVRXbHwQNfbOkE4xpTFYmpB79S
         r7yA==
X-Gm-Message-State: AJIora+lP04MJALgIrlVPvt86kncRpYI0XUbSB1z9tRYIMSDfndt/VH5
        7vgyiZ4h4BsafvesnepqDDMFBg==
X-Google-Smtp-Source: AGRyM1tk6j4mNtQk9qRRyVUy6ecFx8pKAt3xM74yrIfZScw1NM4v+j/hr8GYVIcM+2p5oRpQfs7mBA==
X-Received: by 2002:a17:906:2dd:b0:712:1293:3dd8 with SMTP id 29-20020a17090602dd00b0071212933dd8mr12766549ejk.448.1656067509878;
        Fri, 24 Jun 2022 03:45:09 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b006fe921fcb2dsm906732ejb.49.2022.06.24.03.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:45:09 -0700 (PDT)
Message-ID: <237b1ecc-9a87-b37f-46fd-4612a7ae56f6@linaro.org>
Date:   Fri, 24 Jun 2022 12:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 03/14] dt-bindings: leds: mt6370: Add Mediatek mt6370
 current sink type LED indicator
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-4-peterwu.pub@gmail.com>
 <aec8ecdb-7c76-1261-216b-b40e450d1bf8@linaro.org>
In-Reply-To: <aec8ecdb-7c76-1261-216b-b40e450d1bf8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/06/2022 12:35, Krzysztof Kozlowski wrote:
> On 23/06/2022 13:56, ChiaEn Wu wrote:
>> From: ChiYuan Huang <cy_huang@richtek.com>
>>
>> Add Mediatek mt6370 current sink type LED indicator binding documentation.
>>
>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>> ---
>>
>> v3
>> - Use leds-class-multicolor.yaml instead of common.yaml.
>> - Split multi-led and led node.
>> - Add subdevice "led" in "multi-led".
>> ---
>>  .../bindings/leds/mediatek,mt6370-indicator.yaml   | 77 ++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>> new file mode 100644
>> index 0000000..45030f3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LED driver for MT6370 PMIC from MediaTek Integrated.
>> +
>> +maintainers:
>> +  - Alice Chen <alice_chen@richtek.com>
>> +
>> +description: |
>> +  This module is part of the MT6370 MFD device.
>> +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
>> +
>> +allOf:
>> +  - $ref: leds-class-multicolor.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt6370-indicator
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^multi-led@[0-3]$":
>> +    type: object
> 
> Here as well unevaluatedProperties:false (on the type level)

Ah, no, it does not work currently. Your code looks good.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
