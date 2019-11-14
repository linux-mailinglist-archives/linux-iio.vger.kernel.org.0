Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DFFC79E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNNcZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 08:32:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44809 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNNcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 08:32:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so2637559plb.11;
        Thu, 14 Nov 2019 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m897Sc/TCpNfpCZcjpt3zqQuCiizN0RjeXnE+VTOhXg=;
        b=vcrvANUW6Bth2Stll4poF0aBRK11/VFy2+WgiUtYhkecW7uril+FSHmbJv14CSMrjR
         YZcOq4sRbPQ8PyJgvfnIBn9+6VVLvkKItfRHe5BhaPM5KY3RkJyPHtEYsysfiAB4mIPw
         US+3NRjelv5WMjFzMCxTiNDtwxJFoepa75a9RoDulbQyrrtSZnoOmo1jgSV/jVMs3cRp
         ffhIZ8bbUbygc5DKMdX78e7qpzxm0nxMrkXYamzHdICtEl+OdTNyOI1roOTMSOKLmoPT
         9bV2fmbc1nthO/S8D1xvBlrdH7lVMdcJ+Ew6K5ncqyPYEwFD90m1sAADisOWULmp4mOi
         btbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m897Sc/TCpNfpCZcjpt3zqQuCiizN0RjeXnE+VTOhXg=;
        b=PZ8KBYIUcVo81M4q/zirlNLWvUsAFh3y2Wj7DUJgSIFtiFol6WgHHaFUiC/dip7e0o
         LGCDYCdsP5T1gtHqb4yqSjN3U5RnXMcSLzO9HtjEj0zQet4EnjW50qU+PoKOgkGA8HvR
         Md5WYHmedjelfoY0q2HbTtULF1Nb6/zl6NrOMFMa680Va/2mAoGSpb2piLdOYzFfo+vW
         dZ1tldQVaYwB5Pc6FUE+oh3l97y+Sa/i1uA7avN+pLo7QTX1mMts9NSHTJwO9YhEFelJ
         QVLhwLhIxg8zYTgarF4TQJp0q+xgL9TJle+voIWa2wSVvAPtHAZrYE0uBMTSpslDmN5n
         BxZw==
X-Gm-Message-State: APjAAAU0uWGC70CvdSJuWuVttgCr2UtGba52vAK5dBauCxbCWRkAvA+e
        IFJf2pMqcyQi9b5lmqc3vkv2MyIdEpQ=
X-Google-Smtp-Source: APXvYqwCzn1udvbXzA1aHaNnhd6owTDrqDlBljVWluXUA67p6km2KTkEu3DGvmhPoZbOLNYPo4ObNw==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr9340410plq.161.1573738342560;
        Thu, 14 Nov 2019 05:32:22 -0800 (PST)
Received: from [0.0.0.0] ([97.64.17.87])
        by smtp.gmail.com with ESMTPSA id j5sm7316528pfe.100.2019.11.14.05.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 05:32:21 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add support for AD5940
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
 <20191110162608.21b40714@archlinux>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <7ac0ec98-b405-6450-fc38-ac6a47fd6d3e@gmail.com>
Date:   Thu, 14 Nov 2019 21:32:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110162608.21b40714@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/11/19 12:26 AM, Jonathan Cameron wrote:
> On Fri,  8 Nov 2019 21:09:44 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
>> Add yaml devicetree description file and a header file for
>> helping configure positive and negtive input of AD5940.
>>
>> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> Ouch. This is a very complex device, so I'm guessing this is the tip
> of the iceberg when it comes to the eventual binding.
> For reference of others this has a similarly complex DAC and
> TIA + some excitation voltage generators (DDS).
> 
> Anyhow, a few comments inline but I'll definitely be looking for
> a dt maintainer input on this one.
> 
> Thanks,
> 
> Jonathan
> 

Thanks, this is the first part support of the driver.

>> ---
>>  .../bindings/iio/adc/adi,ad5940.yaml          | 240 ++++++++++++++++++
>>  include/dt-bindings/iio/adc/adi,ad5940.h      |  52 ++++
>>  2 files changed, 292 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
>>  create mode 100644 include/dt-bindings/iio/adc/adi,ad5940.h
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
>> new file mode 100644
>> index 000000000000..f7f034fdd8ec
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad5940.yaml
>> @@ -0,0 +1,240 @@
>> +# SPDX-License-Identifier: GPL-2.0
> For new bindings, preference is to include a dual license
> (GPL-2.0-only OR BSD-2-Clause)
> 
> If Analog is fine doing this that would be great.
> 

I'll consult my mentor about this.

>> +# Copyright 2019 Analog Devices Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5940.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD5940 Device Tree Bindings
>> +
>> +maintainers:
>> +  - Song Qiang <songqiang1304521@gmail.com>
>> +
>> +description: |
>> +  Analog Devices AD5940 High Precision, Impedance, and Electrochemical Front End.
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5940.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ad5940
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vref-supply:
>> +    description:
>> +      The regulator to be used to supply the reference voltage.
>> +    maxItems: 1
> 
> It's worth taking a look at similar patch reviews to pick up on things
> that are common issues.  Rob has pointed out a few times recently that
> vref-supply can only ever have one item, so no need for maxItems.
> 

That's right, thanks.

>> +
>> +  adi,interrupt-io:
>> +    description:
>> +      Output GPIO index of interrupt controller of AD5940.
>> +    maxItems: 1
> 
> I'm fairly sure an enum can only have one entry so don't think this is
> needed.
> 
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +      - enum: [0, 3, 6, 7]
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - adi,interrupt-io
>> +
>> +patternProperties:
>> +  # 'channel@0-255'
> 
> Really?  That is a lot of channels.  Superficially it looks like a much
> smaller number of possibilities from the datasheet.
> 

This device has some positive inputs and some negative inputs. A channel
here is a combination of one positive input and one negative input.
These channels I listed in examples are only suggested combinations in
the datasheet, while other combinations are all possible. So I was
thinking to not limit the total count of channels here. I failed to find
examples of doing this kind of stuff in the tree.

yours,
Song Qiang

>> +  "^channel@([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$":
>> +    type: object
>> +    description: |
>> +      Represents the external channels which are connected to the ADC.
>> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
>> +    properties:
>> +      reg:
>> +        description:
>> +          Index of this channel, must be starting from 0.
>> +        maxItems: 1
>> +
>> +      diff-channels:
>> +        description:
>> +          Positive input and negtive input of the ADC buffer of this channel.
>> +          Input candidates are defined in include/dt-bindings/iio/adc/adi,ad5940.h.
>> +        minItems: 2
>> +        maxItems: 2
>> +        items:
>> +          - description: Positive input channel
>> +          - enum:
>> +            - AD5940_ADC_INPUTP_EXCITATION
>> +            - AD5940_ADC_INPUTP_FLOATING
>> +            - AD5940_ADC_INPUTP_HSTIA
>> +            - AD5940_ADC_INPUTP_LPTIA_LP
>> +            - AD5940_ADC_INPUTP_AIN0
>> +            - AD5940_ADC_INPUTP_AIN1
>> +            - AD5940_ADC_INPUTP_AIN2
>> +            - AD5940_ADC_INPUTP_AIN3
>> +            - AD5940_ADC_INPUTP_AVDD_2
>> +            - AD5940_ADC_INPUTP_DVDD_2
>> +            - AD5940_ADC_INPUTP_AVDD_REG_2
>> +            - AD5940_ADC_INPUTP_TEMP
>> +            - AD5940_ADC_INPUTP_VBIAS_CAP
>> +            - AD5940_ADC_INPUTP_DE0
>> +            - AD5940_ADC_INPUTP_SE0
>> +            - AD5940_ADC_INPUTP_VREF_2V5_2
>> +            - AD5940_ADC_INPUTP_VREF_1V82
>> +            - AD5940_ADC_INPUTP_P_TEMP_N
>> +            - AD5940_ADC_INPUTP_AIN4
>> +            - AD5940_ADC_INPUTP_AIN6
>> +            - AD5940_ADC_INPUTP_VZERO
>> +            - AD5940_ADC_INPUTP_VBIAS0
>> +            - AD5940_ADC_INPUTP_VCE0
>> +            - AD5940_ADC_INPUTP_VRE0
>> +            - AD5940_ADC_INPUTP_VCE0_2
>> +            - AD5940_ADC_INPUTP_LPTIA
>> +            - AD5940_ADC_INPUTP_AGND_REF
>> +
>> +          - description: Negtive input channel
>> +          - enum:
>> +              # Negtive input candidates
>> +              - AD5940_ADC_INPUTN_FLOATING
>> +              - AD5940_ADC_INPUTN_HSTIA
>> +              - AD5940_ADC_INPUTN_LPTIA
>> +              - AD5940_ADC_INPUTN_AIN0
>> +              - AD5940_ADC_INPUTN_AIN1
>> +              - AD5940_ADC_INPUTN_AIN2
>> +              - AD5940_ADC_INPUTN_AIN3
>> +              - AD5940_ADC_INPUTN_VBIAS_CA8
>> +              - AD5940_ADC_INPUTN_TEMP_N
>> +              - AD5940_ADC_INPUTN_AIN4
>> +              - AD5940_ADC_INPUTN_AIN6
>> +              - AD5940_ADC_INPUTN_VZERO
>> +              - AD5940_ADC_INPUTN_VBIAS0
>> +              - AD5940_ADC_INPUTN_EXCITATION
>> +
>> +      channel-name:
>> +        description:
>> +          Any string format name you would like to assign to this channel.
>> +        maxItems: 1
>> +
>> +    required:
>> +      - reg
>> +      - diff-channels
>> +      - channel-name
>> +
>> +examples:
>> +  - |
>> +    ad5940: ad5940@0 {
>> +      compatible = "adi,ad5940";
>> +      reg = <0>;
>> +      spi-max-frequency = <16000000>;
>> +      vref-supply = <&adc_vref>;
>> +      interrupt-parent = <&gpio>;
>> +      interrupts = <24 2>;
>> +
>> +      adi,interrupt-io = <0>;
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      channel@0 {
>> +        reg = <0>;
>> +        diff-channels = <AD5940_ADC_INPUTP_VCE0
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "Vce-Vbias";
>> +      };
>> +
>> +      channel@1 {
>> +        reg = <1>;
>> +        diff-channels = <AD5940_ADC_INPUTP_VRE0
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "Vre-Vbias";
>> +      };
>> +
>> +      channel@2 {
>> +        reg = <2>;
>> +        diff-channels = <AD5940_ADC_INPUTP_SE0
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "Vse-Vbias";
>> +      };
>> +
>> +      channel@3 {
>> +        reg = <3>;
>> +        diff-channels = <AD5940_ADC_INPUTP_DE0
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "Vde-Vbias";
>> +      };
>> +
>> +      channel@4 {
>> +        reg = <4>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN0
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain0-Vbias";
>> +      };
>> +
>> +      channel@5 {
>> +        reg = <5>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN1
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain1-Vbias";
>> +      };
>> +
>> +      channel@6 {
>> +        reg = <6>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN2
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain2-Vbias";
>> +      };
>> +
>> +      channel@7 {
>> +        reg = <7>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN3
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain3-Vbias";
>> +      };
>> +
>> +      channel@8 {
>> +        reg = <8>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN4
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain4-Vbias";
>> +      };
>> +
>> +      channel@9 {
>> +        reg = <9>;
>> +        diff-channels = <AD5940_ADC_INPUTP_AIN6
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "ain6-Vbias";
>> +      };
>> +
>> +      channel@10 {
>> +        reg = <10>;
>> +        diff-channels = <AD5940_ADC_INPUTP_LPTIA_LP
>> +                         AD5940_ADC_INPUTN_LPTIA>;
>> +        channel-name = "Low power TIA DC";
>> +      };
>> +
>> +      channel@11 {
>> +        reg = <11>;
>> +        diff-channels = <AD5940_ADC_INPUTP_LPTIA
>> +                         AD5940_ADC_INPUTN_LPTIA>;
>> +        channel-name = "Low power TIA AC";
>> +      };
>> +
>> +      channel@12 {
>> +        reg = <12>;
>> +        diff-channels = <AD5940_ADC_INPUTP_HSTIA
>> +                         AD5940_ADC_INPUTN_HSTIA>;
>> +        channel-name = "High Speed TIA";
>> +      };
>> +
>> +      channel@13 {
>> +        reg = <13>;
>> +        diff-channels = <AD5940_ADC_INPUTP_TEMP
>> +                         AD5940_ADC_INPUTN_VBIAS0>;
>> +        channel-name = "Temperature";
>> +      };
>> +    };
>> diff --git a/include/dt-bindings/iio/adc/adi,ad5940.h b/include/dt-bindings/iio/adc/adi,ad5940.h
>> new file mode 100644
>> index 000000000000..c17826f2f654
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/adi,ad5940.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides constants for configuring the AD5940 AFE
>> + */
>> +
>> +#ifndef _DT_BINDINGS_IIO_ADC_AD5940_H
>> +#define _DT_BINDINGS_IIO_ADC_AD5940_H
>> +
>> +#define AD5940_ADC_INPUTN_FLOATING	0
>> +#define AD5940_ADC_INPUTN_HSTIA		1
>> +#define AD5940_ADC_INPUTN_LPTIA		2
>> +#define AD5940_ADC_INPUTN_AIN0		4
>> +#define AD5940_ADC_INPUTN_AIN1		5
>> +#define AD5940_ADC_INPUTN_AIN2		6
>> +#define AD5940_ADC_INPUTN_AIN3		7
>> +#define AD5940_ADC_INPUTN_VBIAS_CA8	10
>> +#define AD5940_ADC_INPUTN_TEMP_N	11
>> +#define AD5940_ADC_INPUTN_AIN4		12
>> +#define AD5940_ADC_INPUTN_AIN6		14
>> +#define AD5940_ADC_INPUTN_VZERO		16
>> +#define AD5940_ADC_INPUTN_VBIAS0	17
>> +#define AD5940_ADC_INPUTN_EXCITATION	20
>> +
>> +#define AD5940_ADC_INPUTP_FLOATING	0
>> +#define AD5940_ADC_INPUTP_HSTIA		1
>> +#define AD5940_ADC_INPUTP_LPTIA_LP	2
>> +#define AD5940_ADC_INPUTP_AIN0		4
>> +#define AD5940_ADC_INPUTP_AIN1		5
>> +#define AD5940_ADC_INPUTP_AIN2		6
>> +#define AD5940_ADC_INPUTP_AIN3		7
>> +#define AD5940_ADC_INPUTP_AVDD_2	8
>> +#define AD5940_ADC_INPUTP_DVDD_2	9
>> +#define AD5940_ADC_INPUTP_AVDD_REG_2	10
>> +#define AD5940_ADC_INPUTP_TEMP		11
>> +#define AD5940_ADC_INPUTP_VBIAS_CAP	12
>> +#define AD5940_ADC_INPUTP_DE0		13
>> +#define AD5940_ADC_INPUTP_SE0		14
>> +#define AD5940_ADC_INPUTP_VREF_2V5_2	16
>> +#define AD5940_ADC_INPUTP_VREF_1V82	18
>> +#define AD5940_ADC_INPUTP_P_TEMP_N	19
>> +#define AD5940_ADC_INPUTP_AIN4		20
>> +#define AD5940_ADC_INPUTP_AIN6		22
>> +#define AD5940_ADC_INPUTP_VZERO		23
>> +#define AD5940_ADC_INPUTP_VBIAS0	24
>> +#define AD5940_ADC_INPUTP_VCE0		25
>> +#define AD5940_ADC_INPUTP_VRE0		26
>> +#define AD5940_ADC_INPUTP_VCE0_2	31
>> +#define AD5940_ADC_INPUTP_LPTIA		33
>> +#define AD5940_ADC_INPUTP_AGND_REF	35
>> +#define AD5940_ADC_INPUTP_EXCITATION	36
>> +
>> +#endif /* _DT_BINDINGS_IIO_ADC_AD5940 */
> 
