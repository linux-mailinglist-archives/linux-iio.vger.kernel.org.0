Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F31E67BE
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405211AbgE1Qtf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:49:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60961 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405105AbgE1Qte (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 12:49:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684574; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=X89xsDaOFRdGrU4xaHY0/NaYtl9HOEBQ8tbCfVlGxxI=; b=TJJE0JHsQH4JcwUqzF4F0lw7eqOIVBrL6AzQ22egnSfF5/kwtgap+I7yOGRo9L8V63o3Rxdk
 vPA3LMg9hUSuUsLaXcmo7lCKBIoUiS/prENrALqgfZSwnNY+u229TXFS/I7AkOWDkzAf1XSD
 BwaHCUwe6PTY9q21F5ZjCXpFtOs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ecfeb9cbf0e32d254271082 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:49:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 314F0C433CA; Thu, 28 May 2020 16:49:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.47.99.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33BCAC433C9;
        Thu, 28 May 2020 16:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33BCAC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V5 5/5] iio: adc: Clean up ADC code common to PMIC5 and
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
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
 <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
 <CAHp75VeAoOahk2BDSZjCBUnJGb-Nn-ewQXDDkuj8v6_c3m1YZA@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <96c607e2-59e0-0d7b-92b4-5baa86c19ac2@codeaurora.org>
Date:   Thu, 28 May 2020 22:19:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeAoOahk2BDSZjCBUnJGb-Nn-ewQXDDkuj8v6_c3m1YZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 5/22/2020 9:11 PM, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> This commit includes the following changes:
>>
>> Add a common function used for read_raw callback for both PMIC5
>> and PMIC7 ADCs.
>>
>> Add exit function for ADC.
>>
>> Add info_property under adc_data to more efficiently distinguish
>> PMIC5 and PMIC7 ADCs.
> ...
>
>> -       if (of_device_is_compatible(node, "qcom,spmi-adc7"))
>> -               indio_dev->info = &adc7_info;
>> -       else
>> -               indio_dev->info = &adc5_info;
>> +       platform_set_drvdata(pdev, adc);
> Ping-pong style of series. Can we convert to .info before we introduce
> above check for compatibility?
Yes, I'll add the .info property in a different patch before adding the 
PMIC7 support, that way it can be used directly instead of the above 
check being removed.
>
>
