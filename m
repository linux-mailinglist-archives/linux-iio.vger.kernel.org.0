Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAB17FEDB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Mar 2020 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCJNmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Mar 2020 09:42:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgCJNmi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Mar 2020 09:42:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E796A65C9C3E845E1FD;
        Tue, 10 Mar 2020 21:42:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Mar 2020
 21:42:22 +0800
Subject: Re: [PATCH -next] iio: ping: set pa_laser_ping_cfg in of_ping_match
To:     Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>
References: <20200304113423.26920-1-yuehaibing@huawei.com>
 <20200304115546.GA8509@arbad> <20200307153000.3b6db32a@archlinux>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <ae1a8102-e923-15a3-3bc0-3baea5258580@huawei.com>
Date:   Tue, 10 Mar 2020 21:42:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200307153000.3b6db32a@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020/3/7 23:30, Jonathan Cameron wrote:
> On Wed, 4 Mar 2020 12:55:46 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
>> Acked-by: Andreas Klinger <ak@it-klinger.de>
> Applied to the fixes-togreg branch of iio.git.
> 
> Btw this is also in mainline I believe, so the -next is probably an
> inappropriate marking.

Got it, will notice this next time, thanks!

> 
> Thanks,
> 
> Jonathan
> 
>>
>> YueHaibing <yuehaibing@huawei.com> schrieb am Mi, 04. Mär 19:34:
>>> pa_laser_ping_cfg should be set in of_ping_match
>>> instead of pa_ping_cfg.
>>>
>>> Fixes: 7bb501f49ddb ("iio: ping: add parallax ping sensors")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/iio/proximity/ping.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
>>> index 34aff10..12b893c 100644
>>> --- a/drivers/iio/proximity/ping.c
>>> +++ b/drivers/iio/proximity/ping.c
>>> @@ -269,7 +269,7 @@ static const struct iio_chan_spec ping_chan_spec[] = {
>>>  
>>>  static const struct of_device_id of_ping_match[] = {
>>>  	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
>>> -	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
>>> +	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg},
>>>  	{},
>>>  };
>>>  
>>> -- 
>>> 2.7.4
>>>
>>>   
> 
> 
> .
> 

