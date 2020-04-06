Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0D19F50F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDFLru (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:47:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:10447 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727515AbgDFLrt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:47:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173669; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FgPDoydCs+DhGKztcRPMXkbqhx2Dj1OriztFjPgeMag=; b=Io+muzxg7z/GyodYqthm9m+uKkEy2sdFqtLj6JS/f0eZnVddTA3xHghvJeYTk+k84ami6Jjo
 o1W8pdS+IzrE1ft5rEESlCevUlsOv1lP7cau6vcEI4pXzaH/kIplO6o/7IyHTusGeGGnqBRj
 +HrmFo5/riEAZgQVjEMywnon2Rg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b16c6.7f69c7495ab0-smtp-out-n04;
 Mon, 06 Apr 2020 11:47:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BC51C433D2; Mon,  6 Apr 2020 11:47:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2F5BC433BA;
        Mon,  6 Apr 2020 11:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2F5BC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
 <20200331200611.GA10950@bogus>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <46f4f206-ab75-31ad-66cc-71d1e458b76e@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:17:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331200611.GA10950@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob

On 4/1/2020 1:36 AM, Rob Herring wrote:
> On Tue, Mar 24, 2020 at 09:14:10PM +0530, Jishnu Prakash wrote:
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
>>
>> In addition, add definitions for ADC channels and virtual channel
>> definitions per PMIC, to be used by ADC clients for PMIC7.
>>
>> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
>> ---
>>   drivers/iio/adc/qcom-spmi-adc5.c                 | 239 ++++++++++++++++++++-
>>   drivers/iio/adc/qcom-vadc-common.c               | 260 +++++++++++++++++++++++
>>   drivers/iio/adc/qcom-vadc-common.h               |  14 ++
>>   include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h  |  67 ++++++
>>   include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h |  88 ++++++++
>>   include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h |  46 ++++
>>   include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h |  28 +++
>>   include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h |  28 +++
>>   include/dt-bindings/iio/qcom,spmi-vadc.h         |  78 ++++++-
> DT headers go in the binding patch(es).
I'll move these to the bindings patch in the next post.
>
>>   9 files changed, 843 insertions(+), 5 deletions(-)
>>   create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>>   create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>>   create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>>   create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>>   create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
