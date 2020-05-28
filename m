Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB05E1E67B7
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405101AbgE1QsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:48:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62151 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405185AbgE1QsW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 12:48:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684502; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=V/FjvseqBj5P84s0e9IFl/BbQIRhxvHn2iqA2kw9C+0=; b=izXgEXURFisG/Zn2wTY/eyssNpohPP1Kj2aevMDtokdWoLcP+8WpNbpKSDlHmufVR3nsfzHi
 KN8YjXHv38l2c5249eefeehYaBs0yZU4h+lY3QiDULvAVjAaIuL/6XasvHg3nxJ0Y2E0dsUk
 b8I9tSsgdYA+gPhwISrcPULcEVs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ecfeb49bf0e32d254267fe9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:48:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77984C433CA; Thu, 28 May 2020 16:48:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.47.99.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27BD1C433C9;
        Thu, 28 May 2020 16:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27BD1C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V5 3/5] iio: adc: Add support for PMIC7 ADC
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
 <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
 <20200524125925.41102b3b@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <795197a7-a43f-a2b6-9096-8ceb3ea7946c@codeaurora.org>
Date:   Thu, 28 May 2020 22:17:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200524125925.41102b3b@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 5/24/2020 5:29 PM, Jonathan Cameron wrote:
> On Fri, 22 May 2020 19:54:10 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   drivers/iio/adc/qcom-spmi-adc5.c   | 231 ++++++++++++++++++++++++++++++--
>>   drivers/iio/adc/qcom-vadc-common.c | 260 +++++++++++++++++++++++++++++++++++++
>>   drivers/iio/adc/qcom-vadc-common.h |  14 ++
>>   3 files changed, 496 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
>> index 21fdcde..e1482fd 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
> ...
>> @@ -110,6 +120,7 @@ struct adc5_channel_prop {
>>   	enum adc5_cal_method	cal_method;
>>   	enum adc5_cal_val	cal_val;
>>   	unsigned int		decimation;
>> +	unsigned int		sid;
>>   	unsigned int		prescale;
>>   	unsigned int		hw_settle_time;
>>   	unsigned int		avg_samples;
>> @@ -140,6 +151,7 @@ struct adc5_chip {
>>   	bool			poll_eoc;
>>   	struct completion	complete;
>>   	struct mutex		lock;
>> +	int			irq_eoc;
> This is introduced but doesn't seem to be used...
I'll remove it in the next post.
>
>>   	const struct adc5_data	*data;
>>   };
>>   
>> @@ -155,6 +167,8 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
>>   	{.num =  1, .den = 16}
>>   };
>>   
> ...
>
>>   static int adc5_prescaling_from_dt(u32 num, u32 den)
>>   {
>>   	unsigned int pre;
>> @@ -285,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
>>   
>>   	/* Read registers 0x42 through 0x46 */
>>   	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>> -	if (ret < 0)
>> +	if (ret)
>>   		return ret;
> As Andy mentioned, this is better in a separate patch. It's just adding
> noise to this patch which is actually doing things...
I'll split it out into a separate patch in the next post.
>
>>   
>>   	/* Digital param selection */
>> @@ -314,6 +333,47 @@ static int adc5_configure(struct adc5_chip *adc,
>>   	return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>>   }
>>   
> Thanks,
>
> Jonathan
