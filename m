Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F51BA416
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0MzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:55:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34031 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbgD0MzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 08:55:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587992112; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=4mP6dQFWPdpAhTmO8LPPmv6P1d3SYXdgzN2cqvje2UY=; b=cbz4Hp9QhhDqGxrRKnhk2OQ5CzAjGuYgLUFU9QX+JdY57AtEdIvNvmUUcxrK+S6bjXBHXDPz
 62HkcwN7B3RqJR12KCDoFRReNnJlybcU3DyJs7b5l1kYEEjzxwgRrVxYwdp/Ftxosl8lXu46
 qkY7esSgCTr8vTwFsSTBP3htQB0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea6d630.7f19aebbe618-smtp-out-n02;
 Mon, 27 Apr 2020 12:55:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 152D0C44788; Mon, 27 Apr 2020 12:55:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.100] (unknown [157.44.245.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04E9DC433F2;
        Mon, 27 Apr 2020 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04E9DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V2 2/3] iio: adc: Add PMIC7 ADC bindings
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
 <1586942266-21480-3-git-send-email-jprakash@codeaurora.org>
 <20200418171845.4ae85c57@archlinux>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <0a945e45-3e48-0f6f-3c62-b2a476ae0339@codeaurora.org>
Date:   Mon, 27 Apr 2020 18:25:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418171845.4ae85c57@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 4/18/2020 9:48 PM, Jonathan Cameron wrote:
> On Wed, 15 Apr 2020 14:47:45 +0530
> Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> We are enforcing them in the binding. Does it make sense to put them here as well?
> Just seems like something that will get out of sync to me.
I'll remove the redundant parts of the descriptions in the next post.
>
