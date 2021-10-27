Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6087643CD88
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhJ0PdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 11:33:04 -0400
Received: from vern.gendns.com ([98.142.107.122]:33144 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237741AbhJ0PdD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 11:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cv3IcHnNlahP+LezCFcTvbfUlcwZLi0+li0AqGLVFGE=; b=kBd4OUVOWU8PuBf4IQZg37wSWb
        XKc3sF3eABsVwpEE50St+lRS+P8v6zXC1pNn6dMnTqT0n9T7IEhNb9c6m1CQr+Dm1StOqljILhy31
        MygNt9PmmdW6QH/4R7uKygrkCmccxIj6dX0sx+/cyeL4WGsBCg/kuJXAih8SfaDMo2tBGP1yHChVf
        R6dLbHxoPp2imcSois+aBI154KXcE1rEULTnxKOko90cZJce2Ws0JP7x8EaLNHXh9RfcweGmu+BOx
        AhrS1VjA1sKMFFeOlHCVQzFimHgPZm2Gy8U1K4dCAo0A18kj9NZ815zVLmSi+BHkGorkphcVeB5Sr
        Tg4VjUpQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42878 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfksm-0001ad-OS; Wed, 27 Oct 2021 11:30:36 -0400
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-5-david@lechnology.com> <YXj1xc6DdeOrUKjW@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <6e96cdd9-d1f1-6861-59eb-c4e6b9a2ffb9@lechnology.com>
Date:   Wed, 27 Oct 2021 10:30:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXj1xc6DdeOrUKjW@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/27/21 1:46 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:39PM -0500, David Lechner wrote:
>> This documents new unit timer sysfs attributes for the counter
>> subsystem.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Hello David,
> 
> The unit timer is effectively a Count in its own right, so instead of
> introducing new sysfs attributes you can just implement it as another
> Count in the driver. Count 0 is "QPOSCNT", so set the name of this new
> Count 1 as "Unit Timer" (or the datasheet naming if more apt) to
> differentiate the Counts. You can then provide the "unit_timer_enable",
> "unit_timer_period", and "unit_timer_time" functionalities as respective
> Count 1 extensions ("enable" and "period") and Count 1 "count".
> 
> If you believe it appropriate, you can provide the raw timer ticks via
> the Count 1 "count" while a nanoseconds interface is provided via a
> Count 1 extension "timeout" (or something similar).
> 

Sounds reasonable.

