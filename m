Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFB1D0BCE
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEMJU1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 05:20:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58709 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbgEMJU1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:20:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589361626; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=T6dxEfKekbNc9oWN1bm57JzamwT0E2LE9YYffgNFdYo=; b=FKYIdtvKo9kMcTYYURSEHJKG/F5t2oTi8Po2BCx4OSoBOHWEVus7jwt2V5plEl4q9d6PHaOk
 io6bP3aJSoepvzmVu/5jzpn0UGBIw62Sg37EVbY2DDWbp1ZthOdyn3F/85RafVXtaZPI3gRL
 /irMMX5pPCKulzQbtfnODlnHmwM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbbbd2.7fa74bc33340-smtp-out-n02;
 Wed, 13 May 2020 09:20:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5EB55C43637; Wed, 13 May 2020 09:20:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.101] (unknown [157.48.3.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDF16C433D2;
        Wed, 13 May 2020 09:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDF16C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V2 3/3] iio: adc: Add support for PMIC7 ADC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-4-git-send-email-jprakash@codeaurora.org>
 <CAHp75VegoXJmi1rDg_-ePKqoo69Jdt7NBchCTE=bPAdJqrgYQQ@mail.gmail.com>
 <68d9c770-b190-dd13-0869-fdae9fb1f16f@codeaurora.org>
 <CAHp75Vdu4HvaTg5ij=DFhwn=y_JCb9ae9L5-iV72Zk-k9CBHuw@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <aa6a8817-2ae9-5768-093b-b9f8577597c5@codeaurora.org>
Date:   Wed, 13 May 2020 14:50:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdu4HvaTg5ij=DFhwn=y_JCb9ae9L5-iV72Zk-k9CBHuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 4/27/2020 6:58 PM, Andy Shevchenko wrote:
> On Mon, Apr 27, 2020 at 3:56 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> On 4/17/2020 3:51 PM, Andy Shevchenko wrote:
>> On Thu, Apr 16, 2020 at 1:48 AM Jishnu Prakash <jprakash@codeaurora.org> wrote:
> Stop using HTML. It breaks badly the reply and discussion.
>
> ...
>
>> +static const struct adc5_data adc7_data_pmic;
>>
>> Global variable? Hmm...
>>
>> adc7_data_pmic is referenced twice before its actual definition (which was added along with corresponding adc5_data struct for PMIC5 ADC), so I have given the initial declaration here.
> Maybe you can realize how to avoid global variable at all?
There is a way to remove this, I'll make this change with some other 
changes in the fifth patch of my latest post.
>
> ...
>
>> +       buf[1] &= 0xff & ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
>>
>> What the point of 0xff & part?
>>
>> This was something you suggested in my first post:
>>
>>> +       buf[1] &= (u8) ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
>> Use '0xFF ^ _MASK' instead of casting.
>>
>> ...
>>
>>> +       buf[3] &= (u8) ~ADC5_USR_HW_SETTLE_DELAY_MASK;
>> Ditto.
>>
>> I think "0xff &" works as intended here in place of casting to (u8)...
> Does it work without casting? (Note, I suggested slightly different expression)
> I.o.w. what the problem casting solves?
I checked this part again. It looks like casting is not strictly 
required here, I'll remove it in my latest post.
>
>> +       buf[1] |= prop->avg_samples;
>> +
>> +       /* Select ADC channel */
>> +       buf[2] = prop->channel;
>> +
>> +       /* Select HW settle delay for channel */
>> +       buf[3] &= 0xff & ~ADC5_USR_HW_SETTLE_DELAY_MASK;
>>
>> Ditto.
>>
>> +       buf[3] |= prop->hw_settle_time;
>
