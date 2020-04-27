Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89BD1B94D6
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 03:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgD0BQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 21:16:22 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:42850 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgD0BQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 21:16:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D139320138DE;
        Mon, 27 Apr 2020 09:09:40 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MvDMbBypFzTg; Mon, 27 Apr 2020 09:09:40 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id A98B220139B7;
        Mon, 27 Apr 2020 09:09:40 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.18])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 89849C019FB;
        Mon, 27 Apr 2020 09:09:39 +0800 (HKT)
Subject: Re: [PATCH v5 3/3] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
 <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
 <20200425203556.4c051fad@archlinux>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <49b05b32-ba6a-50fe-a4a2-96248e672576@gtsys.com.hk>
Date:   Mon, 27 Apr 2020 09:09:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200425203556.4c051fad@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 26/4/2020 3:35 am, Jonathan Cameron wrote:
> On Mon, 20 Apr 2020 12:26:08 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
>> Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> There is something odd going on with indentation but otherwise looks fine to me.
> However we need to leave time for a final DT review.
>
> Thanks,
>
> Jonathan
I will wait for the review, and fix the indent together with / or without any 
changes
lining up. I think a good Idea to get a yaml extension for my 'vim'.

Cheers,

Chris

>> ---
>> v5:
>> correct require section
>> set maintainer of analog.com
>> v4..v2: no change
>>
>>   .../bindings/iio/dac/lltc,ltc2632.yaml        | 76 +++++++++++++++++++
>>   .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
>>   2 files changed, 76 insertions(+), 49 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>> new file mode 100644
>> index 000000000000..b0043144fbc4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
>> +
>> +maintainers:
>> +  - Michael Hennerich <michael.hennerich@analog.com>
>> +
>> +description: |
>> +  Bindings for the Linear Technology LTC2632/2634/2636 DAC
>> +  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - lltc,ltc2632-l12
>> +      - lltc,ltc2632-l10
>> +      - lltc,ltc2632-l8
>> +      - lltc,ltc2632-h12
>> +      - lltc,ltc2632-h10
>> +      - lltc,ltc2632-h8
>> +      - lltc,ltc2634-l12
>> +      - lltc,ltc2634-l10
>> +      - lltc,ltc2634-l8
>> +      - lltc,ltc2634-h12
>> +      - lltc,ltc2634-h10
>> +      - lltc,ltc2634-h8
>> +      - lltc,ltc2636-l12
>> +      - lltc,ltc2636-l10
>> +      - lltc,ltc2636-l8
>> +      - lltc,ltc2636-h12
>> +      - lltc,ltc2636-h10
>> +      - lltc,ltc2636-h8
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 2000000
>> +
>> +  vref-supply:
>> +    description:
>> +	  Phandle to the external reference voltage supply. This should
>> +      only be set if there is an external reference voltage connected to the VREF
>> +      pin. If the property is not set the internal reference is used.
> Odd intent going on there.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    vref: regulator-vref {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "vref-ltc2632";
>> +        regulator-min-microvolt = <1250000>;
>> +        regulator-max-microvolt = <1250000>;
>> +        regulator-always-on;
>> +    };
>> +
>> +    spi_master {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      dac: ltc2632@0 {
>> +        compatible = "lltc,ltc2632";
>> +        reg = <0>;    /* CS0 */
>> +        spi-max-frequency = <1000000>;
>> +        vref-supply = <&vref>;
>> +      };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> deleted file mode 100644
>> index 1ab9570cf219..000000000000
>> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
>> +++ /dev/null
>> @@ -1,49 +0,0 @@
>> -Linear Technology LTC2632/2634/2636 DAC
>> -
>> -Required properties:
>> - - compatible: Has to contain one of the following:
>> -	lltc,ltc2632-l12
>> -	lltc,ltc2632-l10
>> -	lltc,ltc2632-l8
>> -	lltc,ltc2632-h12
>> -	lltc,ltc2632-h10
>> -	lltc,ltc2632-h8
>> -	lltc,ltc2634-l12
>> -	lltc,ltc2634-l10
>> -	lltc,ltc2634-l8
>> -	lltc,ltc2634-h12
>> -	lltc,ltc2634-h10
>> -	lltc,ltc2634-h8
>> -	lltc,ltc2636-l12
>> -	lltc,ltc2636-l10
>> -	lltc,ltc2636-l8
>> -	lltc,ltc2636-h12
>> -	lltc,ltc2636-h10
>> -	lltc,ltc2636-h8
>> -
>> -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
>> -apply. In particular, "reg" and "spi-max-frequency" properties must be given.
>> -
>> -Optional properties:
>> -	- vref-supply: Phandle to the external reference voltage supply. This should
>> -	  only be set if there is an external reference voltage connected to the VREF
>> -	  pin. If the property is not set the internal reference is used.
>> -
>> -Example:
>> -
>> -	vref: regulator-vref {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "vref-ltc2632";
>> -		regulator-min-microvolt = <1250000>;
>> -		regulator-max-microvolt = <1250000>;
>> -		regulator-always-on;
>> -	};
>> -
>> -	spi_master {
>> -		dac: ltc2632@0 {
>> -			compatible = "lltc,ltc2632-l12";
>> -			reg = <0>; /* CS0 */
>> -			spi-max-frequency = <1000000>;
>> -			vref-supply = <&vref>; /* optional */
>> -		};
>> -	};

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html

