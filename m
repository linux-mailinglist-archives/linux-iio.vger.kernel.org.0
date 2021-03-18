Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379DA340D77
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhCRSpw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhCRSpZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 14:45:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F3C06174A;
        Thu, 18 Mar 2021 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wDTHAbgDLyZrn6d64TVhU+dRn+k3q2aStgvSBcHqsWY=; b=H+2S0MDVY0wpSrcPygVZR+ZydC
        MCqu0904GYOzNDQWWKIwE+qCzEjR6wFCqnhk9yfkabAsvH/uQVQ5d7I4DnPBtqvlE1OSKfw18+r3S
        mg2hsuBo7fiPLlbwI0AsjBiFZ3UdnWw1Kd222BbC6bRyPBGT31hzWLYAvn7QuqKQ/YfhKBUwbwtTK
        MFf027MEtJR8Ci0Eb8fcl3xFWi7FcKdHJ1gI/l1hamfBOpuZfuppAOex8h+EqAyGr9kUUIKpJOdju
        5PuOIJTy+lR5yLxUthPjTheb9zN+ig5Z9Hzk+LOPxMzTNHYCjQJqw5nm9AsR3uWfPi3xhxzWhmnH5
        fBHkeV/w==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMxdS-003Mt3-MO; Thu, 18 Mar 2021 18:44:49 +0000
Subject: Re: linux-next: Tree for Mar 16 (AD9467 & ADI_AXI_ADC)
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210316155001.699efbb4@canb.auug.org.au>
 <d3c9bca8-3709-3613-c4cd-6da2aa96c2b9@infradead.org>
 <CA+U=DspHhL=Of2axKW6FiF3oG8S7FEP4QBLEZHc5VQ4LzmvqNQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <136e564b-bc81-19b6-ca3d-6fe5bac4d429@infradead.org>
Date:   Thu, 18 Mar 2021 11:44:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DspHhL=Of2axKW6FiF3oG8S7FEP4QBLEZHc5VQ4LzmvqNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/21 1:16 AM, Alexandru Ardelean wrote:
> On Tue, Mar 16, 2021 at 11:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 3/15/21 9:50 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> News: there will be no linux-next release on Friday this week.
>>>
>>> Warning: Some of the branches in linux-next are still based on v5.12-rc1,
>>> so please be careful if you are trying to bisect a bug.
>>>
>>> News: if your -next included tree is based on Linus' tree tag
>>> v5.12-rc1{,-dontuse} (or somewhere between v5.11 and that tag), please
>>> consider rebasing it onto v5.12-rc2. Also, please check any branches
>>> merged into your branch.
>>>
>>> Changes since 20210315:
>>
>>
>> on i386 or x86_64:
>>
>> WARNING: unmet direct dependencies detected for ADI_AXI_ADC
>>   Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
>>   Selected by [y]:
>>   - AD9467 [=y] && IIO [=y] && SPI [=y]
>>
>>
>> AD9467 should not select ADI_AXI_ADC when OF is not enabled,
>> so possibly AD9467 should depend on OF.
> 
> Hmm, this becomes a bit complicated.
> We got here because we needed to add a depends on HAS_IOMEM for the
> ADI_AXI_ADC (due to the s390 arch).
> Maybe a better fix would be for AD9467 to depend on ADI_AXI_ADC.
> The AD9467 driver can't function without the ADI_AXI_ADC driver.

Yes, "depends on" works here. Please go ahead with that change.
Thanks.

> It is a little early to move this to a "high-speed ADC" subgroup.
> 
>>
>>
>> Full randconfig file is attached.
>>
>>
>> --
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy

