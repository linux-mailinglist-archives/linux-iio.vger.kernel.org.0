Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367A1E67C5
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405226AbgE1QuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:50:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48063 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405186AbgE1QuW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 12:50:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684622; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HtAusP7H7FCOmXD0AJPhL0pz3Yk6Y+AVzGbR3KNH1U8=; b=dQH9ntwhZArib7ZVl2bzYE/peCVcDtN9XcQkpIRoku4bQXTSOkhytuymsPL/tIrkqGOHFDad
 yeqvno0EUUDkzD5nMiGcTFGLvrGsvR4h5X8AIL0BcqNzAP8sNVIOAUKmOvNXyCxaPcl9hY3R
 sjvExdUFRteQd5FedHFsu3sA3w4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ecfebc44776d1da6da45730 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:50:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A06C6C433CA; Thu, 28 May 2020 16:50:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.47.99.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54FB0C433C9;
        Thu, 28 May 2020 16:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54FB0C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V5 5/5] iio: adc: Clean up ADC code common to PMIC5 and
 PMIC7
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
 <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
 <20200524130440.250edb2e@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <0078a610-fed8-7a18-ecd1-27b8eb5a8feb@codeaurora.org>
Date:   Thu, 28 May 2020 22:20:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524130440.250edb2e@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 5/24/2020 5:34 PM, Jonathan Cameron wrote:
> On Fri, 22 May 2020 19:54:12 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
>> This commit includes the following changes:
>>
>> Add a common function used for read_raw callback for both PMIC5
>> and PMIC7 ADCs.
>>
>> Add exit function for ADC.
> Hi Jishnu,
>
> I don't understand why one is needed, and if it is you can't do
> what you have here without introducing some nasty races.
> So if you need it clearly explain why in comments in the code
> and also consider how it may race with new requests coming in etc
> as the userspace interfaces are still visible.
>
> Move the eoc_irq addition to the structure here as well as makes
> no sense in earlier patch.
>
> Thanks,
>
> Jonathan
>
>
>> Add info_property under adc_data to more efficiently distinguish
>> PMIC5 and PMIC7 ADCs.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   drivers/iio/adc/qcom-spmi-adc5.c   | 81 +++++++++++++++++++++-----------------
>>   drivers/iio/adc/qcom-vadc-common.h |  1 +
>>   2 files changed, 46 insertions(+), 36 deletions(-)
>>
>>   
>> +static int adc5_exit(struct platform_device *pdev)
>> +{
>> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
>> +
>> +	if (adc->irq_eoc >= 0)
>> +		disable_irq(adc->irq_eoc);
> So here you are disabling an irq?  Why.  We should be removing it
> cleanly in the managed flow shortly anyway.  If you did do this
> here for some reason I'm not thinking of then you would have
> a race against the userspace being removed on the unwind
> of the iio device register.
>
>> +	return 0;
>> +}
>> +
You're right about the exit function, the actions done in it are not 
strictly required, so I'll remove it in the next post.
