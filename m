Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE60D17A331
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCEKeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 05:34:11 -0500
Received: from www381.your-server.de ([78.46.137.84]:37700 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCEKeL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 05:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IZDIDcAsD/+MtQ6OgW2dCs7MZLssCvVkDO7Sf2CJc+M=; b=jldVkt3Q96LJnbhNrSNoZdiOAT
        C3qeSKqNB46A5kK4gqEn+U7VaTLbSkBmJtuRcmPQAv8Z2XqEu7SFOzA3OJzpiw5fSR43wmVF3HjEv
        kFiTSNpqvR/Hwe/W7D8642kLIo5F2+6zTi8lkPFQLhDnqPx3gzN9Kf1GlWtXqv1tp4E8NtNoKQaie
        5nGSE89xltJeioo+i5WRjyvC7yy1a1/PTFBaTlYRrQ3f2C8i086JIAnQESoe+MqwjOsV8OWCvJrXa
        ibW+q3wwe6N83K1OjbMdym8Pnm35fPR9ZKgoRoE0Bfbj4RSd2FMT2bmUsKYEh62LPCvrRp5489Utq
        1k1f0sOA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1j9npO-0007m7-1m; Thu, 05 Mar 2020 11:34:06 +0100
Received: from [93.104.100.159] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1j9npN-000TFJ-K0; Thu, 05 Mar 2020 11:34:05 +0100
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200225124152.270914-1-nuno.sa@analog.com>
 <20200225124152.270914-6-nuno.sa@analog.com>
 <20200303211045.31f977bb@archlinux>
 <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
Date:   Thu, 5 Mar 2020 11:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25741/Wed Mar  4 15:15:26 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/4/20 7:00 PM, Sa, Nuno wrote:
> On Tue, 2020-03-03 at 21:10 +0000, Jonathan Cameron wrote:
>> [External]
>>
>> On Tue, 25 Feb 2020 13:41:52 +0100
>> Nuno Sá <nuno.sa@analog.com> wrote:
>>
>>> Document the ADIS16475 device devicetree bindings.
>>>
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>> One thing inline on the burst mode stuff.
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>>   .../bindings/iio/imu/adi,adis16475.yaml       | 130
>>> ++++++++++++++++++
>>>   MAINTAINERS                                   |   1 +
>>>   2 files changed, 131 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>>> b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>>> new file mode 100644
>>> index 000000000000..c0f2146e000c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>>> @@ -0,0 +1,130 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADIS16475 and similar IMUs
>>> +
>>> +maintainers:
>>> +  - Nuno Sá <nuno.sa@analog.com>
>>> +
>>> +description: |
>>> +  Analog Devices ADIS16475 and similar IMUs
>>> +
>>> https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16475.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,adis16475-1
>>> +      - adi,adis16475-2
>>> +      - adi,adis16475-3
>>> +      - adi,adis16477-1
>>> +      - adi,adis16477-2
>>> +      - adi,adis16477-3
>>> +      - adi,adis16470
>>> +      - adi,adis16465-1
>>> +      - adi,adis16465-2
>>> +      - adi,adis16465-3
>>> +      - adi,adis16467-1
>>> +      - adi,adis16467-2
>>> +      - adi,adis16467-3
>>> +      - adi,adis16500
>>> +      - adi,adis16505-1
>>> +      - adi,adis16505-2
>>> +      - adi,adis16505-3
>>> +      - adi,adis16507-1
>>> +      - adi,adis16507-2
>>> +      - adi,adis16507-3
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  spi-cpol: true
>>> +
>>> +  spi-max-frequency:
>>> +    maximum: 2000000
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    oneOf:
>>> +      - const: sync
>>> +      - const: direct-sync
>>> +      - const: pulse-sync
>>> +      - const: scaled-sync
>>> +
>>> +  reset-gpios:
>>> +    description:
>>> +      Must be the device tree identifier of the RESET pin. If
>>> specified,
>>> +      it will be asserted during driver probe. As the line is
>>> active low,
>>> +      it should be marked GPIO_ACTIVE_LOW.
>>> +    maxItems: 1
>>> +
>>> +  adi,scaled-output-hz:
>>> +    description:
>>> +      This property must be present if the clock mode is scaled-
>>> sync through
>>> +      clock-names property. In this mode, the input clock can have
>>> a range
>>> +      of 1Hz to 128HZ which must be scaled to originate an
>>> allowable sample
>>> +      rate. This property specifies that rate.
>>> +    minimum: 1900
>>> +    maximum: 2100
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - spi-cpha
>>> +  - spi-cpol
>>> +
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - adi,adis16500
>>> +          - adi,adis16505-1
>>> +          - adi,adis16505-2
>>> +          - adi,adis16505-3
>>> +          - adi,adis16507-1
>>> +          - adi,adis16507-2
>>> +          - adi,adis16507-3
>>> +
>>> +then:
>>> +  properties:
>>> +    clock-names:
>>> +      oneOf:
>>> +        - const: sync
>>> +        - const: direct-sync
>>> +        - const: scaled-sync
>>> +
>>> +    adi,burst32-enable:
>>> +      description:
>>> +        Enable burst32 mode. In this mode, a burst reading
>>> contains calibrated
>>> +        gyroscope and accelerometer data in 32-bit format.
>> Why is this in DT?  Is it not a runtime decision
>> (ideally automatically selected)
> So, you mean just have this mode by default on parts that support it?

Maybe lets start with explaining what burst32 mode is, so everybody is 
on the same page.

The way registers are usually accessed for this chip is that you first 
write the address you want to read on the SPI bus and then read the 
selected register. This can be quite slow though if you want to read 
multiple registers and is too slow to be able to read all the data at 
full data rate. So there is a special burst mode which allows to read 
all the data registers in one go.

Now by default the data registers are 16-bit. But there is an internal 
decimation filter and the extra bits produced by the decimation filter 
go into additional data registers making the data 32-bit wide. The chip 
allows to configure whether to read the only 16-bit MSBs or the full 
32-bit register.

So the decision whether a user wants to use 32-bit or 16-bit depends on 
whether the extra 16-bit are needed or if they are even available. E.g. 
if the decimation filter is off there wont be any extra bits.

This means ideally it would be user configurable whether to use 16-bit 
or 32-bit burst mode, since it is application specific. The problem is 
we don't have an interface for changing the bit width of a buffer 
channel. Adding such an interface would require quite a bit of effort 
since the assumption currently is that the bit width does not chance. 
E.g. libiio assumes this and would stop working if it did change.

Maybe as a compromise for now. Use 32-bit burst when there is actually 
meaningful data is the LSBs, i.e. the decimation filter is used and 
disable it otherwise. And then think about how to make it configurable 
as a follow up action.

In my opinion there is should not be a difference in the userspace 
interface for chips that do support 32-bit burst and those that don't. 
For devices that don't support 32-bit burst it should be emulated by 
reading the LSB bits registers manually.

- Lars

