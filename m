Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B151D2288F3
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgGUTMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUTME (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:12:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398FC061794;
        Tue, 21 Jul 2020 12:12:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so10672738pls.5;
        Tue, 21 Jul 2020 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Fdlp9DORPzdta4JRV0XH4gAQ0mHcGnc6TC0R5XXa18=;
        b=rvRvGId6o5z5zQgFTJ8cxd6GIUCu5tjVu5+y03qaNt7WboTj/4FgC2xikj0SdA2vA8
         Qc4+NtS0iaa1CLrkH6mUKP8a1o+mwCZmERr00mD0YfPpLTpd4lUSuWe+N05fffv9BAms
         cCnxBok/YZAKUoojqFnu1jcaDnAn70t8wx2bH+zTS855oIHzapQDIZM3iM2BRBbo8taX
         RqYohYeXQvX2+Ff6CkkQgt6oFuJnoNFefcodNzxM45dEVJgHvYg2njvhn1Sm8IulVrkQ
         dihRpf6nchaVXkBxtWpz+mKjmgRKMinosegFLni1uIgOyrv1+IOsuGPRKpHJMF6sST9G
         lDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Fdlp9DORPzdta4JRV0XH4gAQ0mHcGnc6TC0R5XXa18=;
        b=ROiki6k2KNcbTFkEN5mbvo2UJI31sBRyZ1nqviGLS+798vqlBnVnrWwCPMtZEL7c/q
         Ul2iXQyoBEY094F8u55Hm7JIntZCAaSDpK4UK8gdG76pLv4F98PeAzUGIWqTo060Ld+E
         K1I8+HnqDeGj7klD2ZsFhXeVeHlfWSQR2HvjHDaiPWZurc7XVFHNnoxVhoTtmbAM0QQN
         sl1juHHo+ixAI7HyZbrP/XlU+Mq0x73+vnMgISZDwVUlYpfMfWwrNFiefp1rnGPOR5IZ
         /oIPcP12d5XRFSte69BzSBJ+gDoG9RPoYWbtEAkuezAGn8irto3kDGGKKfRVhjPjByt2
         C1xw==
X-Gm-Message-State: AOAM530nfZjqOc+Q1kHsPLP6qHACOOYeEnQxbGaMmVqkgqwpgyJGu8w8
        AfBtbtvQKzRotvi5f+rmelWFsimgfvY=
X-Google-Smtp-Source: ABdhPJwf2idKN7yTZXi9tr+MvKcjpBbDm5w0uu5qCUbtEww9sbt+cjAsOH9nqwhU4SiEeF6QA0hf8w==
X-Received: by 2002:a17:90a:2427:: with SMTP id h36mr6176260pje.229.1595358723288;
        Tue, 21 Jul 2020 12:12:03 -0700 (PDT)
Received: from ?IPv6:2409:4072:593:314e:d028:8959:a8a3:a7bc? ([2409:4072:593:314e:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id x7sm20602441pfp.96.2020.07.21.12.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:12:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-bindings: iio: gyro: Add DT binding doc for
 ADXRS290
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200715092821.14625-1-nish.malpani25@gmail.com>
 <20200720121633.7a9e5cd7@archlinux> <20200721024127.GA3429416@bogus>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <02a49136-8e1b-dff0-51d3-90c93a6e6c8d@gmail.com>
Date:   Wed, 22 Jul 2020 00:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200721024127.GA3429416@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathon & Rob,

Thanks for the review. Comments inline...

On 21/07/20 8:11 am, Rob Herring wrote:
> On Mon, Jul 20, 2020 at 12:16:33PM +0100, Jonathan Cameron wrote:
>> On Wed, 15 Jul 2020 14:58:21 +0530
>> Nishant Malpani <nish.malpani25@gmail.com> wrote:
>>
>>> Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.
>>>
>>> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
>>> ---
>>>   .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 52 +++++++++++++++++++
>>>   MAINTAINERS                                   |  1 +
>>>   2 files changed, 53 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>>> new file mode 100644
>>> index 000000000000..a997d945fdb0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +# Copyright 2020 Analog Devices Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/gyroscope/adi,adxrs290.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope
>>> +
>>> +maintainers:
>>> +  - Nishant Malpani <nish.malpani25@gmail.com>
>>> +
>>> +description: |
>>> +  Bindings for the Analog Devices ADXRS290 dual-axis MEMS gyroscope device.
>>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,adxrs290
>>
>> I think we can use const here as only one item currently.
> 
> Yep. Really depends if you expect to add more.
> 
I'm not aware if we'll be adding more. For now, made it a 'const' in v2.

>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-max-frequency:
>>> +    maximum: 5000000
>>> +
>>> +  spi-cpol: true
>>> +
>>> +  spi-cpha: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - spi-max-frequency
>>> +  - spi-cpol
>>> +  - spi-cpha
> 
> Add:
> 
> additionalProperties: false
> 
Okay. Acked in v2.

Regards,
Nishant Malpani

>>> +
>>> +examples:
>>> +  - |
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        gyro@0 {
>>> +                   compatible = "adi,adxrs290";
>>> +                   reg = <0>;
>>> +                   spi-max-frequency = <5000000>;
>>> +                   spi-cpol;
>>> +                   spi-cpha;
>>> +        };
>>> +    };
>>> +...
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index dd02cfc410e8..0bb8ac90fba1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1103,6 +1103,7 @@ M:	Nishant Malpani <nish.malpani25@gmail.com>
>>>   L:	linux-iio@vger.kernel.org
>>>   S:	Supported
>>>   F:	drivers/iio/gyro/adxrs290.c
>>> +F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>>>   
>>>   ANALOG DEVICES INC ASOC CODEC DRIVERS
>>>   M:	Lars-Peter Clausen <lars@metafoo.de>
>>
