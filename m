Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8276819F4E8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgDFLm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:42:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:48203 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgDFLm1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:42:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173347; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uLA+aP168I0ocVcL3/x2EZUaB7OeJIyHoWNUAc8lggA=; b=nQh+pg6BFscBUiK9sp+IS4Bc5xADYGr26Tv/ZAxoggFdo6YXQr5xmOnLVIClpf+gun+L0NbP
 leBiDB9YOTC4DoNSKAKHa1xqqfflCXdr+GfrGbpGSr+gXmRcUWtZzHVjPH1fnzloU3CtjCFe
 6PbUiCZCINQYmmPBZxx0iP+Rts0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b15a2.7f40aa4c8260-smtp-out-n04;
 Mon, 06 Apr 2020 11:42:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2728CC4478F; Mon,  6 Apr 2020 11:42:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01F4BC433D2;
        Mon,  6 Apr 2020 11:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01F4BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to .yaml
 format
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
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-2-git-send-email-jprakash@codeaurora.org>
 <20200328165113.6fdeedd3@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <f53cd9f7-333d-9bc7-b545-236e0b9efcac@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:11:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328165113.6fdeedd3@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 3/28/2020 10:21 PM, Jonathan Cameron wrote:
> On Tue, 24 Mar 2020 21:14:08 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
>> Convert the adc bindings from .txt to .yaml format.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> Hi Jishnu,
>
> Looks to me like we can tighten the checks a fair bit in here rather
> than just using uint32s
>
> Now, my yaml isn't great so I won't try to say how, but there are plenty
> of examples in tree.
>
> Thanks,
>
> Jonathan
>
> +
> +      qcom,decimation:
> +        description: |
> +            This parameter is used to decrease ADC sampling rate.
> +            Quicker measurements can be made by reducing decimation ratio.
> +            - For compatible property "qcom,spmi-vadc", valid values are
> +              512, 1024, 2048, 4096. If property is not found, default value
> +              of 512 will be used.
> +            - For compatible property "qcom,spmi-adc5", valid values are 250, 420
> +              and 840. If property is not found, default value of 840 is used.
> +            - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
> +              512 and 1024. If property is not present, default value is 1024.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> Should ideally verify all the values against models etc rather than a uint32 binding.
I'll add constraints for all properties for which it's applicable in the 
next post.
>
>> +
>> +      qcom,pre-scaling:
>> +        description: |
>> +            Used for scaling the channel input signal before the signal is
>> +            fed to VADC. The configuration for this node is to know the
>> +            pre-determined ratio and use it for post scaling. Select one from
>> +            the following options.
>> +            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
>

>> +
>> +examples:
>> +  - |
>> +      /* VADC node */
>> +      pmic_vadc: vadc@3100 {
> Should really be using generic names, so adc@3100 preferred.
I'll change it in the next post.
