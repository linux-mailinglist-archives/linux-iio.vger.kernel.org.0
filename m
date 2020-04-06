Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEE19F507
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgDFLqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:46:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22736 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727793AbgDFLqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:46:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173607; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=21Usv+7OlYJnY+NURtDJjs/B1ZBay7aqmLhPGZSU41c=; b=DTnFFPczwTQh3UmJcmMBsOGSUbeGPQe/kgWL91Y/dHlp0060bZsWq5RzgYUiut0u+SGuLiNG
 CG990hg6E8v/+3vGliu4Hqnf1fqBg2bF3rLCUeuNfuhKlgGGcntWFiHBwsqVdbS3i1P83Q5x
 4KjEhu8xJEVpuadGsUVRuSg5Fk0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b1691.7f5dc86ee0d8-smtp-out-n01;
 Mon, 06 Apr 2020 11:46:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3441C4478F; Mon,  6 Apr 2020 11:46:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C61FCC43636;
        Mon,  6 Apr 2020 11:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C61FCC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
 <CAHp75Vfk1DZ+bz6h_prm6Tp7kXos6jio5JCpg6=wvGRmDPTBsw@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <6bf90d8c-48e6-9a07-7688-aa3890ebcd0d@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:16:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfk1DZ+bz6h_prm6Tp7kXos6jio5JCpg6=wvGRmDPTBsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 3/24/2020 10:03 PM, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 5:46 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
>>
>> In addition, add definitions for ADC channels and virtual channel
>> definitions per PMIC, to be used by ADC clients for PMIC7.
> ...
>
>> +#define ADC_CHANNEL_OFFSET                     0x8
>> +#define ADC_CHANNEL_MASK                       0xff
> GENMASK()
I'll fix this and the other simple changes in the next post.
>
> ...
>
>> +#define ADC_APP_SID                            0x40
>> +#define ADC_APP_SID_MASK                       0xf
> GENMASK()
>
>> +#define ADC7_CONV_TIMEOUT                      msecs_to_jiffies(10)
> Useless.
I'm not sure what you mean by this. It is used in the API 
adc7_do_conversion.
> ...
>
> + if (of_device_is_compatible(node, "qcom,spmi-adc7")) {
>> +               indio_dev->info = &adc7_info;
>> +               adc->is_pmic7 = true;
>> +       } else {
>> +               indio_dev->info = &adc5_info;
>> +       }
> Hmm... I would rather put this as driver_data in ID structure(s).
I'll remove the check for the compatible string, using driver data, in 
the next post.
>
> ...
>
>> +static int adc5_exit(struct platform_device *pdev)
>> +{
>> +       struct adc5_chip *adc = platform_get_drvdata(pdev);
>> +
>> +       mutex_destroy(&adc->lock);
> Are you sure you will have no race conditions? Does this driver use IRQs?
The driver does use an IRQ. Will fix this in the next post.
>
>
