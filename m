Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB581AF169
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDRPBW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgDRPBW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 11:01:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2288C061A0C;
        Sat, 18 Apr 2020 08:01:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so941840wme.1;
        Sat, 18 Apr 2020 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Q4NvKOF4jokQzr+OFpyWKzZTT39+gDgdtnGFKi9DkQI=;
        b=f0gkVGdXy41TzPhlrnd9xVSLChePuts8KGhjCc/8ct72yDST2hg0iG5jdzLgg6oQXn
         Dkg+JzpLhacK2grOpHsahRZ7CzV28WUUoanTMeTyRgmvtuv5bc5iR38qAVLZQe45C+KX
         soSD2MQ4B1VUDmWZ1n15dWrOilf2T06CuaQSwIIUiPy9hj4OS+8yFyXpvHUPFAbSdUvR
         TOawihRwaeoBvdKGcG0AigCYbFnTiD8F19JE+I9mKZSQjaOxZEVWglozlkHjgxilx0Bu
         g8iiCQ/BVIH60BvQZGbks/ZKooIgRHq7MTvRtxDV9cbVT2vsi4q0ah4qNs505OyyC3Bk
         CypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q4NvKOF4jokQzr+OFpyWKzZTT39+gDgdtnGFKi9DkQI=;
        b=QxKGz2tdcroFWeHR4A5JadwrgAPiMiNlQmQlRA56UZMq9bnaltF5c97UGqhNl5Psi/
         0GbLuSFeI3WqkBkvVrM+VC/rpQhsqu3WL8hgFpmJzAl6aLSou9otI/KtkpVAGhWc5RsU
         4QkMVO1XU6NoE1qAUHqnDzKKBT8jjas2E5I5g+158WbW+tCtxdF+buCJHs6ljGdlk52i
         yod4Y+UujU+zVHFu87YbWnYMtI4DKVgoYV0+hSRG3eu8JYc4uaIlR5IV/b25sXqOMJUh
         i4knmX13y4ZpTPvmuoTWnk9AJi0WvQ0dhlhJDEz4VRuYpuspx19P8zveb74SmxJJynLu
         16WQ==
X-Gm-Message-State: AGi0PuaeD084MUulrFX3gIZg4kHpVt0JcQ2gbb7QxOANouod74Z+s/Ua
        tplr5BcLE1JIvNHT/6Li0NNevKBn
X-Google-Smtp-Source: APiQypIN5NA6KodHBPEMoP6z2563/KeKGH3tYCZJZyg8FuCfNLIrq0LIntKIVGKusFMVERbX3kGbJg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr8498490wmd.95.1587222079707;
        Sat, 18 Apr 2020 08:01:19 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F7F19.dip0.t-ipconnect.de. [91.63.127.25])
        by smtp.gmail.com with ESMTPSA id y10sm11922561wma.5.2020.04.18.08.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:01:18 -0700 (PDT)
Subject: Re: [PATCH v10 1/6] dt-bindings: mfd: add document bindings for
 mp2629
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-2-sravanhome@gmail.com>
 <20200418155308.681df38f@archlinux>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <50ffb42e-4080-415e-dd3d-e38f7b0a6071@gmail.com>
Date:   Sat, 18 Apr 2020 17:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418155308.681df38f@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 18/04/20 4:53 pm, Jonathan Cameron wrote:
> On Fri, 17 Apr 2020 10:49:58 +0200
> Saravanan Sekar <sravanhome@gmail.com> wrote:
>
>> Add device tree binding information for mp2629 mfd driver.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>> new file mode 100644
>> index 000000000000..b25b29259d67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
>> +
>> +maintainers:
>> +  - Saravanan Sekar <sravanhome@gmail.com>
>> +
>> +description: |
>> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
>> +  wireless camera and portable devices. Chip is controlled over I2C.
>> +
>> +  The battery charge management device handles battery charger controller and
>> +  ADC IIO device for battery, system voltage
>> +
>> +properties:
>> +  compatible:
>> +    const: mps,mp2629
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +    description:
>> +      The first cell is the IRQ number, the second cell is the trigger type.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-controller
>> +  - "#interrupt-cells"
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/input/linux-event-codes.h>
>> +    i2c@7e205000 {
> I thought the general trend for i2c devices was to leave the i2c
> part 'vague'.
>
>      i2c {
>            #address-cells = <1>;
>            #size-cells = <0>;
>           
>            pmic@4b.. etc
I agree with you and initial patch was as like above, but Lee was 
somehow unhappy and not satisfied with

my explanations. Please find more info on v4.

> Guess it doesn't matter if example contains too much information. Rob?
>
> Otherwise looks good to me.
>
> Thanks,
>
> Jonathan
>   
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        reg = <0x7e205000 0x200>;
>> +
>> +        pmic@4b {
>> +            compatible = "mps,mp2629";
>> +            reg = <0x4b>;
>> +
>> +            interrupt-controller;
>> +            interrupt-parent = <&gpio2>;
>> +            #interrupt-cells = <2>;
>> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
>> +        };
>> +    };
