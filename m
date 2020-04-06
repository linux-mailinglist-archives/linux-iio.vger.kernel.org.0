Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1600719F4F6
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgDFLpJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:45:09 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53717 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727575AbgDFLpJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:45:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173508; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+xk7CgP6jiYAclcZ7ZI86n32dohhOX6V7T6Ac0tw6Ns=; b=NQON4ozBpIFKkDlVowCwFO4PcKSzka7l8o61ozWCz3mbYZPAVXLHW4FHu+5y6FsZrOxOQdVQ
 XGNeFQA0ACRWkVSWpv+XBb0o5je5k+PBMsLGGexRzNnAHPbmmkL/oGUV46HUTXLoIuGMplYn
 kNwI58qyUNfxeuBEsXm/Ekcgsew=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b163b.7f7f4da0b228-smtp-out-n01;
 Mon, 06 Apr 2020 11:44:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7009BC433BA; Mon,  6 Apr 2020 11:44:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E02AC433D2;
        Mon,  6 Apr 2020 11:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E02AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to .yaml
 format
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>, linux-iio@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-2-git-send-email-jprakash@codeaurora.org>
 <CAHLCerML7vR9X_YxAg=S71n2NiY88toZyGDhxZaUZAvnNX2P+g@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <69b882b0-56ad-1b93-0a9d-2c7f96dd9d32@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:14:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerML7vR9X_YxAg=S71n2NiY88toZyGDhxZaUZAvnNX2P+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Amit,

On 4/3/2020 5:34 PM, Amit Kucheria wrote:
>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - '#io-channel-cells'
>> +
>> +patternProperties:
>> +  "^[a-z0-9-_@]$":
>> +    type: object
>> +    description: |
>> +      Represents the external channels which are connected to the ADC.
>> +      For compatible property "qcom,spmi-vadc" following channels, also known as
>> +      reference point channels, are used for result calibration and their channel
>> +      configuration nodes should be defined:
>> +      VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
>> +      VADC_GND_REF and VADC_VDD_VADC.
> Instead of this note for "qcom,spmi-vadc", you can enforce this
> through checks in YAML grammar.
>
> A simple example can be found in
> Documentation/devicetree/bindings/thermal/qcom-tsens.yaml. Look for
> the if, then, else clause which determines how many interrupts need to
> be defined.

I have gone through tsens and other examples, but I'm not able to get a 
way to apply this kind of constraint, on what child nodes should be present.

In this case, the constraint would have to be that for compatible 
property "qcom,spmi-vadc", there should be at least four child nodes and 
those four should have their "reg" property fixed to the channel values 
mentioned above. I can see how to apply constraints on a single property 
like interrupts in tsens, but I'm not sure if there is a way to specify 
a lower limit to the number of child nodes or something like "there 
should be at least one child node with value 0x9 for its "reg" 
property". I could not find any examples with constraints placed on  
number of occurrences of a child node.

Can you please share an example of such a constraint if you are aware of 
any or suggest some way by which this kind of constraint can be specified?

>
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          ADC channel number.
>> +          See include/dt-bindings/iio/qcom,spmi-vadc.h
>> +
>> +      label:
>> +        description: |
>> +            ADC input of the platform as seen in the schematics.
>> +            For thermistor inputs connected to generic AMUX or GPIO inputs
>> +            these can vary across platform for the same pins. Hence select
>> +            the platform schematics name for this channel. It is required
>> +            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/string
> You shouldn't need allOf here.
>
> Just a "$ref: /schemas/types.yaml#/definitions/string" should be fine.
> And move it above the description.
>
> Same for all the uses of allOf below.
I'll make the change in the next post.
>
>
>> +      qcom,decimation:
>> +        description: |
>> +            This parameter is used to decrease ADC sampling rate.
>> +            Quicker measurements can be made by reducing decimation ratio.
>> +            - For compatible property "qcom,spmi-vadc", valid values are
>> +              512, 1024, 2048, 4096. If property is not found, default value
>> +              of 512 will be used.
>> +            - For compatible property "qcom,spmi-adc5", valid values are 250, 420
>> +              and 840. If property is not found, default value of 840 is used.
>> +            - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
>> +              512 and 1024. If property is not present, default value is 1024.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +
> As pointed out by Jonathon, please enforce these by keying off the
> compatible property.
I'll do this for all properties for which it's applicable in the next post.
>
>> +      qcom,pre-scaling:
>> +        description: |
>> +            Used for scaling the channel input signal before the signal is
>> +            fed to VADC. The configuration for this node is to know the
>> +            pre-determined ratio and use it for post scaling. Select one from
>> +            the following options.
> Please improve this description from the old binding. Does <1 3> mean
> the signal is scaled 3x or 1/3x?
<1 3> means it is scaled down to 1/3rd of actual value. I'll add to the 
description in the next post.
>
>> +            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
>> +            If property is not found default value depending on chip will be used.
>> +        allOf:
>> +          - $ref: /schemas/types.yaml#/definitions/uint32
>> +
