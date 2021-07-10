Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6323C3542
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhGJPqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 11:46:15 -0400
Received: from vern.gendns.com ([98.142.107.122]:53572 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhGJPqP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 11:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MkQ/Slfts7ACEfWSN/fpQzxSSjabaiQStVowDOxpxEc=; b=z+zONT8Jj4Iy/OXEkcL3LY6jcM
        eRSGZXlyfS6KcTgQ8SnUBI17hNj7oee+zC2i4wlxfLlfi4HM5/DyLDDrsTSVJG859csv8B4zuy5+l
        c4sBVP1GFnYYhXHiPpB5A3sqJkte1gStaqRnZpQPUrVj6Xux27LU+nMVlOIu9qFVwCqyca/iWFiZC
        6yvBdcV22zxsJmTSKIDxLRiD1s53g9byv8i1OYhZZXiY+6lMVEXHkLZSI4pp+b6B5gvMT8FVFbyiF
        Z7tEn+7fjLw+XY7dLTIE5MhSZ8vvlqC3wimHuEt+BLkVdpZA0axXnxhp89t9pqmBVUtjBTQhXkNLo
        8KuWrxLg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45586 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2F8J-00GUFW-Jv; Sat, 10 Jul 2021 11:43:26 -0400
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
 <1a624011-0b43-ac42-be53-a42f81923e5a@linux.intel.com>
 <YOl1frCrophjhk7y@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <fbf1ba4c-412b-fe22-0e79-76e968a00fb4@lechnology.com>
Date:   Sat, 10 Jul 2021 10:43:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOl1frCrophjhk7y@shinobu>
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

On 7/10/21 5:25 AM, William Breathitt Gray wrote:
>> and after that
>>
>> [   16.564403] ================================================
>> [   16.570725] WARNING: lock held when returning to user space!
>> [   16.577044] 5.13.0-next-20210706+ #4 Not tainted
>> [   16.582198] ------------------------------------------------
>> [   16.588507] cat/331 is leaving the kernel with locks still held!
>> [   16.595214] 1 lock held by cat/331:
>> [   16.599103]  #0: ffff888102bb3630
>> (&counter->chrdev_lock){+.+.}-{3:3}, at: counter_chrdev_open+0x21/0x60
>> [counter]
>>
>> Jarkko
> I'm not sure how to resolve this warning. The purpose of this lock is to
> limit chrdev to a single open at a time. To accomplish this I grab this
> lock in counter_chrdev_open() and hold it until counter_chrdev_release()
> is called. Is there a better way to accomplish this?

How about using an atomic flag, e.g test_and_set_bit()?
