Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89401DE603
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgEVL7Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 07:59:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27950 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgEVL7Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 07:59:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590148764; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=qGzkd9q/kRUvHdHEx2YNsWgNzPbVwMgN6G1JnaxM+Dw=; b=fs1eckSUDYaigj5WNLtbj3j1wZsEXjgqvq+MPjnNEXGb78PTLDg/bN1EVJTVVH8FjO+7SU/G
 BlFTvf8b4PstDo1GsiuyyHId7BIz17xDpboD6mDEDZdMgOWWnx3ue1F3/T29KXisG0plCoqb
 pmzdG7pfscdlJljxNPyg3RaBEJY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec7be9b40528fe39497defd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 11:59:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D845C433CB; Fri, 22 May 2020 11:59:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.44.159.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D0DCC433C8;
        Fri, 22 May 2020 11:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D0DCC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V4 5/5] iio: adc: Clean up ADC code common to PMIC5 and
 PMIC7
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
 <1589361736-816-6-git-send-email-jprakash@codeaurora.org>
 <CAHp75Vf-bFfrZ7uCOnXuzT+p+itkcmkE61=ezZzN8yDFQHABdw@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <ab1d038c-5ad0-4c3b-0537-6e6512432de3@codeaurora.org>
Date:   Fri, 22 May 2020 17:29:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf-bFfrZ7uCOnXuzT+p+itkcmkE61=ezZzN8yDFQHABdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 5/13/2020 3:21 PM, Andy Shevchenko wrote:
> On Wed, May 13, 2020 at 12:24 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> This commit includes the following changes:
>> Add a common function used for read_raw callback for
>> both PMIC5 and PMIC7 ADCs.
>> Add exit function for ADC.
>> Add info_property under adc_data to more efficiently
>> distinguish PMIC5 and PMIC7 ADCs.
> Something happened to the editor settings. We have lines up to 72
> (recommended) characters.
In this case, I just meant to put each change on a different line. I'll 
fix it in the next post.
>
> ...
>
>> @@ -512,6 +518,7 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>>                          &adc5_prescale_ratios[prop->prescale],
>>                          adc->data,
>>                          adc_code_volt, val);
>> +
>>                  if (ret)
>>                          return ret;
>>
> Unrelated.
I'll remove it in the next post.
>
