Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D131BA40E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0MyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:54:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52863 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbgD0MyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 08:54:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587992056; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=bNxhDdEWNv8+M5j4zfOz6+JAfDWxx5aDTnOG/7aC93Y=; b=aTDoioBoFwVaa8akPSm+S5oPsjmhBIFEk/YWrsVj5+S5Jr18Al3wGVaccAT6Xl9466NgUC6N
 9R5B8EapKpDcqql7Cq9f40Ltu+ryqhJ0bndoJ3mx+zX0qfd5RvMEys/FUTa4dYs/m2nVuYJ+
 GSPO+5dUnHIoOR3ok1LKc2iS0sg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6d5ed.7fef6158dc70-smtp-out-n04;
 Mon, 27 Apr 2020 12:54:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4893C4478C; Mon, 27 Apr 2020 12:54:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.245.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD4DCC433CB;
        Mon, 27 Apr 2020 12:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD4DCC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V2 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-2-git-send-email-jprakash@codeaurora.org>
 <20200418172200.58a10116@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <0e840b20-c215-f446-b467-476d913005d1@codeaurora.org>
Date:   Mon, 27 Apr 2020 18:23:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418172200.58a10116@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

On 4/18/2020 9:52 PM, Jonathan Cameron wrote:
> On Wed, 15 Apr 2020 14:47:44 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
>> Convert the adc bindings from .txt to .yaml format.
>>
> I read patch 2 before this one for some reason but same question applies here
> Given we are now enforcing a lot of the values explicitly are we better
> off dropping the text description of that.  It looks to me like a potential
> place to get out of sync given the information is a bit further down.
I'll remove the redundant parts of the descriptions in the next post.
