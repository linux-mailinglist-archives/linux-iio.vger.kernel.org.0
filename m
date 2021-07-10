Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05723C3579
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhGJQLM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 12:11:12 -0400
Received: from vern.gendns.com ([98.142.107.122]:56944 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhGJQLM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 12:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B+ZumVvqvu+0mUwwUiQ31zStVAZut8y1rEf5GPLOqS8=; b=TSONfkWJaEHlQg2MvrF2pcumkZ
        X2DLQGMS4PSWljs2brnP2gi0ctBmbjOb/9SzsWntr5wpJBhLo4NFunu06WXdMIU26C9JAnKzwIO97
        rNMl7XI1jQYqNHNDovl9nsmdF8DdA0mPdHSQj3NSMCXXMXXEh//YAh3QrBDc40qFbmYvp8QUq2O3F
        7dP+q/ZJqhFvAuT2yf8W2P9UNgn4CxtSsPglFpnB8Sbx4uvyS+SloonH3laoYfqUvWIGb9/XSxYzU
        pm6Y1ujFt3in4LpPFizU/C1JpmOj/RCHvjS1Fsenek/4grjGYnQwupo+/pxtfwjC+YBquhu9GsofB
        YLJ/HWqw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:46002 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2FWS-00GZ0l-Nv; Sat, 10 Jul 2021 12:08:23 -0400
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
From:   David Lechner <david@lechnology.com>
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
 <fbf1ba4c-412b-fe22-0e79-76e968a00fb4@lechnology.com>
Message-ID: <76cc7f77-a59c-86ef-8df9-65b877356b32@lechnology.com>
Date:   Sat, 10 Jul 2021 11:08:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fbf1ba4c-412b-fe22-0e79-76e968a00fb4@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 7/10/21 10:43 AM, David Lechner wrote:
> On 7/10/21 5:25 AM, William Breathitt Gray wrote:
>>> and after that
>>>
>>> [   16.564403] ================================================
>>> [   16.570725] WARNING: lock held when returning to user space!
>>> [   16.577044] 5.13.0-next-20210706+ #4 Not tainted
>>> [   16.582198] ------------------------------------------------
>>> [   16.588507] cat/331 is leaving the kernel with locks still held!
>>> [   16.595214] 1 lock held by cat/331:
>>> [   16.599103]  #0: ffff888102bb3630
>>> (&counter->chrdev_lock){+.+.}-{3:3}, at: counter_chrdev_open+0x21/0x60
>>> [counter]
>>>
>>> Jarkko
>> I'm not sure how to resolve this warning. The purpose of this lock is to
>> limit chrdev to a single open at a time. To accomplish this I grab this
>> lock in counter_chrdev_open() and hold it until counter_chrdev_release()
>> is called. Is there a better way to accomplish this?
> 
> How about using an atomic flag, e.g test_and_set_bit()?

Another option could be to rethink it at a higher level and avoid the
need for a lock (and sysfs attribute) altogether. For example, would it
work to (re)allocate the kfifo buffer in the COUNTER_ENABLE_EVENTS_IOCTL
callback and add a parameter to that ioctl to specify the buffer size
(with units of events rather than bytes)?

