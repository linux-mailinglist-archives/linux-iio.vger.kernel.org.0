Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B15315DA
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2019 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEaUJ6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 May 2019 16:09:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46043 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfEaUJ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 May 2019 16:09:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so5098315qkj.12;
        Fri, 31 May 2019 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UVgt0vwEj7EAXy/j4qPK77xL+oH2BUtF2/YFZzbt1nE=;
        b=O9KKxO12fFVFOyC/LX/kfokc+aOsPKSKZdV1lTR5Xn08biFb0Xem4ZuqQJM6fQLSj+
         M1bvaAl1mZnMkcfsfdSkj33OCJdogMMWt1QpXd2/Z+H72ilHfFRCZh5LeTB40jTFDyLa
         nqdqiBmnRKKLgcAnJJQOTjnmGbQGp1OCu2TEV+jp6RI+l7uHFbNuACQ1MUXD8o5XrnSF
         0Fc8/Kz+TG44tgf6mMfNJdEaIg6Y6/JEOKV/Le2N4P91F2cEOh9sCiCKpLc+0cF9fQeg
         WVbcKiJ70Bseq7ZO0ZLiClObCXxVQTHQNUYTHMTtrkErpz93I9pawmK4fPoBdl5PkMNh
         tfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UVgt0vwEj7EAXy/j4qPK77xL+oH2BUtF2/YFZzbt1nE=;
        b=bgvzb16jxZuqG00sw91bxOaGFRQgmfmLOz1WUJqrTux9cekGp19pRP8MlZY6d0K0u2
         8cAxaWLw8Lhayt2Ak2azZ++zuqvsOJygE8482lcqRqWHu0HD0GWuFGARnBe2wjhYn9hX
         K9QHERddiQ4exEvP9/l4/te4e58dlfXo9GJLEIQupu9f/gI4Mc262lOgL545gWbLDLzS
         fDI5YhvAb5rNbGh3N31KJ+xfN3q6ATFkXHaGPZzys3YaJqaKZ/TVjpWioIDmn/6IOhwY
         do/nvs2iu2eGIc80hfuF/NYRB0PLs1nNwJ1X4cbP/8MqWonEsDmhph9cQ+mNc3ACHVfa
         tXIA==
X-Gm-Message-State: APjAAAU786yTUQQXi4RqjPFVSrGBSQLJ7k8ytEGdiHyyEKpcdnSrSkHT
        Nan2GDAc71M7UxNlkaiR974=
X-Google-Smtp-Source: APXvYqymW1cVo6+LlPBjEpmjRf0EtIZns9ZrSlsJ5Z5b59JmVAJascjO1fJgJivZYri/211PDW+Eqg==
X-Received: by 2002:a37:de06:: with SMTP id h6mr10540356qkj.322.1559333396485;
        Fri, 31 May 2019 13:09:56 -0700 (PDT)
Received: from [172.19.65.94] ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c9sm5434994qtc.39.2019.05.31.13.09.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:09:55 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: iio: accel: adxl372: switch to YAML bindings
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
 <20190519122418.7722641b@archlinux>
 <CA+U=DsrvRcAARa+jZB8GKQ+q+wWWqAh7dmnHymLd9cpFGC2QSw@mail.gmail.com>
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
Message-ID: <504cc8e0-b94e-5418-ef8f-8b28f668ab6a@gmail.com>
Date:   Fri, 31 May 2019 17:09:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DsrvRcAARa+jZB8GKQ+q+wWWqAh7dmnHymLd9cpFGC2QSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks, Alexandru. We're going to send a new version for this patch.

On 20/05/2019 07:46, Alexandru Ardelean wrote:
> On Sun, May 19, 2019 at 8:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Sat, 18 May 2019 18:55:42 -0300
>> Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:
>>
>>> Convert the old device tree documentation to yaml format.
>>>
>>> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
>>> Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
>>> Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
>>> ---
>>>
>>> Hello,
>>> We've added Stefan Popa as maintainer of the yaml documentation of this driver
>>> because we found through git that he was the author of the older documentation.
>>
>> Definitely going to need an Ack from Stefan for that ;)
> 
> CC-ing my work-email
> There are some issues with it and mailing lists; I'll hopefully sort
> them out in the next weeks.
> 
> Stefan is out-of-office.
> He'll take a look when he comes back.
> 
> I'll add a few notes until then.
> 
> I'd still like Stefan's ack to be final.
> 
>>
>> I've not really gotten yaml formats into my head yet, but from a quick
>> look I think this is fine.  I will however be looking for review from others
>> on these.
>>
>> Thanks,
>>
>> Jonathan
>>
>>>
>>>   .../bindings/iio/accel/adi,adxl372.yaml       | 66 +++++++++++++++++++
>>>   .../devicetree/bindings/iio/accel/adxl372.txt | 33 ----------
>>>   2 files changed, 66 insertions(+), 33 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> 
> Also update the MAINTAINERS file when changing this.
> For reference, many things can be borrowed from the ADXL345, which is
> similar (from a dt-binding doc perspective only).
> 
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
>>> new file mode 100644
>>> index 000000000000..a6e2893d2ab1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
>>> @@ -0,0 +1,66 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl372.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
>>> +
>>> +maintainers:
>>> +  - Stefan Popa <stefan.popa@analog.com>
>>> +
>>> +description: |
>>> +  Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
>>> +  both I2C & SPI interfaces
>>> +    https://www.analog.com/en/products/adxl372.html
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,adxl372
>>> +
>>> +  reg:
>>> +    description: the I2C address or SPI chip select number for the device
> 
> no need to add a description for reg
> it's a standard property
> 
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    description:
>>> +      interrupt mapping for IRQ as documented in
>>> +      Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
> no need to describe this either
> 
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
> 
> I think interrupts is also required.
> 
>>> +
>>> +examples:
>>> +  - |
>>> +        #include <dt-bindings/gpio/gpio.h>
>>> +        #include <dt-bindings/interrupt-controller/irq.h>
>>> +        i2c0 {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                /* Example for a I2C device node */
>>> +                accelerometer@53 {
>>> +                        compatible = "adi,adxl372";
>>> +                        reg = <0x53>;
>>> +                        interrupt-parent = <&gpio>;
>>> +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> +                };
>>> +        };
>>> +  - |
>>> +        #include <dt-bindings/gpio/gpio.h>
>>> +        #include <dt-bindings/interrupt-controller/irq.h>
>>> +        spi0 {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +
>>> +                accelerometer@0 {
>>> +                        compatible = "adi,adxl372";
>>> +                        reg = <0>;
>>> +                        spi-max-frequency = <1000000>;
>>> +                        interrupt-parent = <&gpio>;
>>> +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> +                };
>>> +        };
> 
> Rest looks good.
> 
>>> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
>>> deleted file mode 100644
>>> index a289964756a7..000000000000
>>> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
>>> +++ /dev/null
>>> @@ -1,33 +0,0 @@
>>> -Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
>>> -
>>> -http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
>>> -
>>> -Required properties:
>>> - - compatible : should be "adi,adxl372"
>>> - - reg: the I2C address or SPI chip select number for the device
>>> -
>>> -Required properties for SPI bus usage:
>>> - - spi-max-frequency: Max SPI frequency to use
>>> -
>>> -Optional properties:
>>> - - interrupts: interrupt mapping for IRQ as documented in
>>> -   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> -
>>> -Example for a I2C device node:
>>> -
>>> -     accelerometer@53 {
>>> -             compatible = "adi,adxl372";
>>> -             reg = <0x53>;
>>> -             interrupt-parent = <&gpio>;
>>> -             interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> -     };
>>> -
>>> -Example for a SPI device node:
>>> -
>>> -     accelerometer@0 {
>>> -             compatible = "adi,adxl372";
>>> -             reg = <0>;
>>> -             spi-max-frequency = <1000000>;
>>> -             interrupt-parent = <&gpio>;
>>> -             interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> -     };
>>
