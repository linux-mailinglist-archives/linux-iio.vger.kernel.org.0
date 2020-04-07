Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0E1A115A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgDGQ36 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 12:29:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQ36 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 12:29:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so4624858wre.5;
        Tue, 07 Apr 2020 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Wh+IvUc3DeAnnMIbLtY/uy0lszH3oLkUHUCVMoP6fwk=;
        b=btq/mjS/OdeudDUsgt4r3Qe4QTx/aK2wYEi/y06q2lEGwpps1LweXIbBJ9w+WCIl3B
         1BUSsmf0c3Dm1iWL9CjzIZF6jU00xNIG4UMTtnAmfsk/y9RVaJt9h8GFpi+WhHFicBwW
         JC1GJytC+oKSZMAitPx39BGPCZ552unJrPF9Tvs7toz+2+heYYWByoAi+qPvtQLZFhY+
         zKuq6UBiZGrjKUvnUwUUt3lmStTLuBNGefj65PG12Nq6fkl7AcLjSHO/+x2GYv+XoL7R
         ORqEKnSRnyge4MDPVmk2DleLzE5/f+xrt2FWJjqJnHRPUWQPWizFzxCcVwNZfRIL97fF
         9/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wh+IvUc3DeAnnMIbLtY/uy0lszH3oLkUHUCVMoP6fwk=;
        b=c4wKTH7OPDRf8/rJIEQ+skmjbhBQDIQC36yCjNQ1XfkJVqmFS/7v5yYvILMMtIB+w6
         0BJNqo8Ca3eEoF5wDKq654zCQ+D9/jnccOkc+vLRMMLGiZxGTZgRolHLskplJ6JFaWWy
         qidybXYmJVvq+7f+qVQWRsdVhqG7JXQOIIuRyc7rwxA6sQbWAU4A5Q9hNh4EPDT2o9aD
         F/M3vSPaNJXBnWYF0hMQMOHRvHc58TbxFtPnuULar6bxUoEiEKf4+SKas2vG9Msn5QSy
         ZzD6wbfFr4IFdDxBi08lBW9FYEJQRPbk5FzWp/wx0O5EMBZtk04AIJ7XmdM1Xb0DXBdC
         Zkww==
X-Gm-Message-State: AGi0PuYO8bU7bIfx3o418kIM1i+3mdn/Aq9kCGI1/uRJ0BKUztblhNIL
        snIQ0Chcuu7zw8TrrGvIr4vh4lyy
X-Google-Smtp-Source: APiQypJAja1nV/r7nPykalrGELfrqZVJMRh3+qKHRzCZZRNqAebNU+XiPPAJmPa0DEWeAfF5Rwcj1w==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr3817160wrl.201.1586276995322;
        Tue, 07 Apr 2020 09:29:55 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6774.dip0.t-ipconnect.de. [91.63.103.116])
        by smtp.gmail.com with ESMTPSA id 145sm1915427wma.1.2020.04.07.09.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:29:54 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-2-sravanhome@gmail.com> <20200327080013.GG603801@dell>
 <d449b567-bd5c-168d-83af-5ba38771f75a@gmail.com>
 <20200330064630.GA30614@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <e4412378-1423-a48e-9176-f0d48f6000c4@gmail.com>
Date:   Tue, 7 Apr 2020 18:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330064630.GA30614@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 30/03/20 8:46 am, Lee Jones wrote:
> On Fri, 27 Mar 2020, saravanan sekar wrote:
>> On 27/03/20 9:00 am, Lee Jones wrote:
>>> On Sun, 22 Mar 2020, Saravanan Sekar wrote:
>>>
>>>> Add device tree binding information for mp2629 mfd driver.
>>>>
>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>>>>    1 file changed, 60 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>>> new file mode 100644
>>>> index 000000000000..314309ea91ac
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>>>> @@ -0,0 +1,60 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> Are these links supposed to work?
>> Not really, but as far my understanding needed for dt-bindings check
> Rob, why are these here if they just result in 404s?
>
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    #include <dt-bindings/input/linux-event-codes.h>
>>>> +    i2c {
>>> i2c@0x????????
>> Its a I2C controller node, I don't think address is needed. Mention like
>> this my previous other driver patches,
> This doesn't sound right.
>
> How do you control/operate the controller?
>
> Surely you read/write from/to registers?


Indeed, but each SoC will have different address so which address to 
mention here.
For me it should be like &i2c {}, anyhow I respect maintainers review (I 
can give RPi I2c bus address used for testing)
and wait for Rob's reply

>
>> dt_binding_check is also passed
>>
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        pmic@4b {
>>>> +            compatible = "mps,mp2629";
>>>> +            reg = <0x4b>;
>>>> +
>>>> +            interrupt-controller;
>>>> +            interrupt-parent = <&gpio2>;
>>>> +            #interrupt-cells = <2>;
>>>> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
>>>> +        };
>>>> +    };
