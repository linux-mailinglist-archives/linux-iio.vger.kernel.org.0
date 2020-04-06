Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6F819F50C
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDFLrO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:47:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23474 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbgDFLrO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 07:47:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586173634; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=25p0sbzZfLtgF8ygogfJS9V2w4DtSzhD7xPuHGZQ5pY=; b=l4bNPrMiyyRCH/9jJGLuuqOCo2kPQoJDYquOz/DwwO3DJypK+TufbyGPpxAPHrQoofjblg8z
 /L47sL+mNEXrTlX97UUT0ClZy2QJP2Xc2DcyWmrzlSgZRj1vndgDbH2VVZw9pbVqJsnsCYHz
 3BObnIKUfUlijKubtwOloi94wlY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b16a7.7fcd34cdc8f0-smtp-out-n02;
 Mon, 06 Apr 2020 11:46:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62795C433BA; Mon,  6 Apr 2020 11:46:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.182.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA7A8C433F2;
        Mon,  6 Apr 2020 11:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA7A8C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
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
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
 <20200328170407.41d8ed68@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <578c81d3-c9a2-1739-bb10-21d366627893@codeaurora.org>
Date:   Mon, 6 Apr 2020 17:16:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328170407.41d8ed68@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 3/28/2020 10:34 PM, Jonathan Cameron wrote:
> On Tue, 24 Mar 2020 21:14:10 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
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
> A few additions from me.
>
>> ---
> ...
>
> I'll address your comments in the next post.
