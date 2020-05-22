Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFF1DE5FF
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEVL6q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 07:58:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16478 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729030AbgEVL6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 07:58:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590148723; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=fsJxXs8/dXjYa6fAo5MdTVonpyH/JuFRjIc5f4aYvL4=; b=LtsOLL+7R7j1ZFy2L1MEY9L1mspCN+bvhoJDne/YbLPb2o96Wc3h8HdUHYi2cwB/3ZvTE8QC
 PPK3oys+vPuH0kQybeewpU3c40ZqrM5SihX6Hp2xYIFlAJYPmpc9k8OtnOemKl5a8jsRbYq9
 CTjeMwC4Ac1lyRUkJcPg/17zoiQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec7be72e79e24225dc33a47 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 11:58:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 43E9BC43395; Fri, 22 May 2020 11:58:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.44.159.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49E81C433C8;
        Fri, 22 May 2020 11:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49E81C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V4 4/5] iio: adc: Update error checks and debug prints
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
 <1589361736-816-5-git-send-email-jprakash@codeaurora.org>
 <CAHp75Vex+hm2pVat_VVH5gAqPDbm-VQMes56wC=RUcQeM=z7vA@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <9accb386-0b4c-ca3c-09e9-c2610ea20bfa@codeaurora.org>
Date:   Fri, 22 May 2020 17:28:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vex+hm2pVat_VVH5gAqPDbm-VQMes56wC=RUcQeM=z7vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 5/13/2020 3:19 PM, Andy Shevchenko wrote:
> On Wed, May 13, 2020 at 12:23 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> Change pr_err/pr_debug statements to dev_err/dev_dbg for
>> increased clarity. Also clean up some return value checks.
> 'Also' on the commit message == 'split this to two'.
I'll do the ret value changes in the third patch in my next post, 
according to your comment there.
> But here is a ping pong style of patches (you introduce a problem in
> one patch and fix it in the following).
I'll try to avoid this in the next post
>
