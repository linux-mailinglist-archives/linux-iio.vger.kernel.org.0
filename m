Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF517BD484
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbfIXVrA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 17:47:00 -0400
Received: from vern.gendns.com ([98.142.107.122]:36022 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395520AbfIXVrA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Sep 2019 17:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y20jkuyfwNqpSR2V0Kr3ygDPO21LfiHOLBF8Xp06nG0=; b=dwNu2ljbolNZMeRFXjxpTUxAGg
        jJQNr8we6Gswm5oeJqv0+6jFlFa9+dXIR7v/AoDMJCwQxngHloQ4BQ3Ju8ChdiLMYKvyfIcifswWC
        a4BiaVROBdCICzw5tEw0bPjRo1fQQD7Vqqw5aCO/8OHpax5BEjX13dZcodQtB3B4A+YRhbI1rOf0U
        IDc2hBw/VwKwzWTNxTr45io8lP8LR80XoE+1hvb28Dqfmpn+SXclZlHncoiayNc1tW9GCuxMvYbeX
        xWuc9RNuBzAsoaFTF1mR+RcOQOLrTs3ObpZIp06hFvHrc853jehxKqtDCl61Y60ZgrcbBFPJggDqS
        mLUlWubg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:46584 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1iCse9-0003MA-IJ; Tue, 24 Sep 2019 17:46:57 -0400
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
 <20190922233538.GA3119@icarus>
From:   David Lechner <david@lechnology.com>
Message-ID: <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
Date:   Tue, 24 Sep 2019 16:46:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922233538.GA3119@icarus>
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
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/22/19 6:35 PM, William Breathitt Gray wrote:
> On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
>> Add support for Intel PSE Quadrature Encoder
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> ---
>>
>> Changes since v1:
>> 	- Many more private sysfs files converted over to counter interface
>>
>>
>> How do you want me to model this device's Capture Compare Mode (see
>> below)?
> 
> Hi Felipe,
> 
> I'm CCing Fabien and David as they may be interested in the timestamps
> discussion. See below for some ideas I have on implementing this.
> 

Could be an interesting read (thread from my first counter driver):

https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/

What would be useful to me is something like the buffer feature in iio
where a timestamp is associated with a count and stored in a buffer so that
we can look at a window of all values recorded in the last 20ms. Being able
to access this via mmap would be very helpful for performance (running on
300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
unless it is a rare event, like a watchdog timeout.
