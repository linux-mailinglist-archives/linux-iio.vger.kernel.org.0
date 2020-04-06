Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DD619F4FD
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgDFLpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:45:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:38613 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbgDFLpu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:45:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173549; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2+XLDFyllu+4TOOlUpzdZnIXvnsHfp4IHdrdajS4ZAc=; b=sHO5rmsFDraOBl5nHWVTYQD/qDAymFiSTEqnHpIIgBCEY0APv/Lu39MM4mqRh3AqrrUTKypd
 p2dBMonvoOSUrh0Uaz+MYMTFLELurgegpS3OrkAGNRv2IjjZ1plkRXnVMtkkJ4xDmDPw3tTp
 jE4yl7CtBlt96oWXCWuSqHmuRLU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b165e.7f88124d8d50-smtp-out-n03;
 Mon, 06 Apr 2020 11:45:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EACEFC433D2; Mon,  6 Apr 2020 11:45:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE891C433BA;
        Mon,  6 Apr 2020 11:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE891C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
 <20200328165410.7db48818@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <fe8056c5-9480-a9a3-9626-5ebab8031b08@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:15:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328165410.7db48818@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 3/28/2020 10:24 PM, Jonathan Cameron wrote:
> On Tue, 24 Mar 2020 21:14:09 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
>> Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
>> communication to ADC goes through PMK8350, which communicates with
>> other PMICs through PBS.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> index 72db14c..20f010c 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
>> @@ -13,7 +13,7 @@ maintainers:
>>   description: |
>>     SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>>     voltage. The VADC is a 15-bit sigma-delta ADC.
>> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
>> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>>     voltage. The VADC is a 16-bit sigma-delta ADC.
>>   
>>   properties:
>> @@ -23,6 +23,7 @@ properties:
>>         - qcom,spmi-adc5
>>         - qcom,spmi-adc-rev2
>>         - qcom,pms405-adc
>> +      - qcom,spmi-adc7
>>   
>>     reg:
>>       description: VADC base address in the SPMI PMIC register map
>> @@ -65,6 +66,8 @@ patternProperties:
>>           description: |
>>             ADC channel number.
>>             See include/dt-bindings/iio/qcom,spmi-vadc.h
>> +          For PMIC7 ADC, the channel numbers are specified separately per PMIC
>> +          in the PMIC-specific files in include/dt-bindings/iio/.
> That makes me thing we really should have separate compatibles.  The
> parts clearly have differences, even if we haven't needed to use them
> explicitly as yet.
I'm not sure what you mean by this. We have added a new compatible 
property "qcom,spmi-adc7" for PMIC7 ADC.
>
>>   
>>         label:
>>           description: |
>> @@ -72,7 +75,7 @@ patternProperties:
>>               For thermistor inputs connected to generic AMUX or GPIO inputs
>>               these can vary across platform for the same pins. Hence select
>>               the platform schematics name for this channel. It is required
>> -            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
>> +            for "qcom,spmi-adc5", "qcom,spmi-adc7" and "qcom,spmi-adc-rev2".
>>           allOf:
>>             - $ref: /schemas/types.yaml#/definitions/string
>>   
>>
