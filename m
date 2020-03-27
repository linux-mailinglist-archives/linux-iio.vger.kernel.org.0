Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B651960B7
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 22:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgC0VuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 17:50:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35399 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgC0VuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 17:50:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id f74so3172438wmf.0;
        Fri, 27 Mar 2020 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UPYvtOj75J2/EwYyRdsACxnYCpxt8+KWK2M/XYoASio=;
        b=pdZXvd9Su0kL4ajBpbQhIkICRXk2LvR6We+EPwTHlA28wJaFShzFPgUbQyfbIvQYzS
         qCb2jxZWlZtGMMB3i0soOBxEFuDWb5OOmYFnzDsUdohbwTn78iISXAdr1A3RR2TZyIA9
         6sQXZhxryqyw/L1N0zaEiV4vTw3auzSzz/W4Y7T62olfteXivjxc24cBLIRiFW3e59tc
         nJ88HMCApPVEI103oSLypkeNgbqgajMKdi5VBM0GM50k7Z80YAtNVZYzDg8s1zHxQokt
         a7Via6LDcTS7TX2h9m2eJe+ZSFgE4aAMInaO7jb6oU23HjKwVQkFvxVy6+caePWjWE8r
         zoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UPYvtOj75J2/EwYyRdsACxnYCpxt8+KWK2M/XYoASio=;
        b=ilAKCsV6fL3V1JbOYYZ3Dy4c8ywmX+BlYPZfMFYLDveJrpayr9b97numhWPMr2EawY
         dVmZpyV5H0bvGDwQj2JKZycU0q8uLKrdinNSEcJ9VD9pWsA8sJDA4vpOVpCeV1iGUBJp
         qyLJj1+RUqUoWffnJciohJHO57OGC2wbScFu7mITDK6YsTp0qLVW1nwDFYrinOiQN2uU
         tVWAkPHeY+QnwrutDq3lfR9TVKmFs3GEolRaPG2qvHwLMb5YZ1LWT7NmMKHwG3Rc82xT
         btuWlQGPvNuCKaM1jZwmj8OqLbxKtH2ddb7h750ksejb9ywImaYCKccHzRKkzguMd+Q1
         Kwrw==
X-Gm-Message-State: ANhLgQ2go0q9UYo2tmCC6mhoYVeFMC9+IXDiiSQ4AoSWI7fS/Q++68QP
        KkNThrLs8wo3eRvkFrxkEei1f7UxF74=
X-Google-Smtp-Source: ADFU+vvVtGIYGBhSlwePa09L/Ha1FQ2QJKkWLyhkmtaIy0xTyRFUFl97hefC/dNNhN9s8W0M89esSw==
X-Received: by 2002:a1c:56d5:: with SMTP id k204mr869388wmb.13.1585345812891;
        Fri, 27 Mar 2020 14:50:12 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F7536.dip0.t-ipconnect.de. [91.63.117.54])
        by smtp.gmail.com with ESMTPSA id a2sm10228275wrp.13.2020.03.27.14.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 14:50:11 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-2-sravanhome@gmail.com> <20200327080013.GG603801@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <d449b567-bd5c-168d-83af-5ba38771f75a@gmail.com>
Date:   Fri, 27 Mar 2020 22:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327080013.GG603801@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 27/03/20 9:00 am, Lee Jones wrote:
> On Sun, 22 Mar 2020, Saravanan Sekar wrote:
>
>> Add device tree binding information for mp2629 mfd driver.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>> new file mode 100644
>> index 000000000000..314309ea91ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> Are these links supposed to work?
Not really, but as far my understanding needed for dt-bindings check
>> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
>> +
>> +maintainers:
>> +  - Saravanan Sekar <sravanhome@gmail.com>
>> +
>> +description: |
>> +  MP2629 is an PMIC providing battery charging and power supply for smartphones,
> s/an/a/
>
>> +  wireless camera and portable devices. Chip is contrlled over I2C.
> Spell check!
>
>> +  The MFD device handles battery charger controller and ADC IIO device for
>> +  battery, system voltage
> MFD isn't a thing.  We made it up.  Please describe it as it is in the datasheet.
>
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
>> +    i2c {
> i2c@0x????????

Its a I2C controller node, I don't think address is needed. Mention like 
this my previous other driver patches,

dt_binding_check is also passed

>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
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
