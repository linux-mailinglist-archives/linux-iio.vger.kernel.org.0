Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC81BA411
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgD0MzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:55:01 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34031 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbgD0MzB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 08:55:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587992100; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=aU5uGnk49IewT+bo/1PAo4yHKtmG2HzfokQYLJvwHEk=; b=Zisf33DMZ9oqJTFTTGpFJiRWaq9Y3lQeG8buOk7irLgq4tjihEZvNQ1Egl0ThIqCB2tqDmO7
 Nj7IYL4EEMLTvOQ1xfYh2NqD5mHAJo8lVtIKfhV8Pt+LqYl1odTbFn4w8muuZT100NYH6MWw
 fwUdVOvE4wyl9mb2zpkDpWg1E0k=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6d61e.7fb6b950a768-smtp-out-n01;
 Mon, 27 Apr 2020 12:54:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48B78C433BA; Mon, 27 Apr 2020 12:54:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.245.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6017BC433D2;
        Mon, 27 Apr 2020 12:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6017BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V2 2/3] iio: adc: Add PMIC7 ADC bindings
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-3-git-send-email-jprakash@codeaurora.org>
 <20200420220244.GA32739@bogus>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <5de6ad40-1ce6-6f53-15d8-236f0685a2bb@codeaurora.org>
Date:   Mon, 27 Apr 2020 18:24:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420220244.GA32739@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

On 4/21/2020 3:32 AM, Rob Herring wrote:
> On Wed, Apr 15, 2020 at 02:47:45PM +0530, Jishnu Prakash wrote:
>>                 of 512 will be used.
>>               - For compatible property "qcom,spmi-adc5", valid values are 250, 420
>>                 and 840. If property is not found, default value of 840 is used.
>> +            - For compatible property "qcom,spmi-adc7", valid values are 85, 340
>> +              and 1360. If property is not found, default value of 1360 is used.
> We express constraints in schema now, don't duplicate with free form
> text.
I'll remove the redundant parts of the descriptions in the next post.
>
>>               - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
>>                 512 and 1024. If property is not present, default value is 1024.
>> +    then:
>> +      patternProperties:
>> +        "^.*@[0-9a-fx]+$":
> 'x' should not be in unit-addresses.
I'll remove it in the next post.
>
>> +          properties:
>> +            qcom,decimation:
>> +              items:
> Not an array, so 'items' doesn't make sense here.
I'll remove it in the next post.
>
>> +                enum: [ 85, 340, 1360 ]
>> +                default: 1360
>> +
>>
