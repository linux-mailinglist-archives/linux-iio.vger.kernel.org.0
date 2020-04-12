Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFB1A5FA5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgDLSAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgDLSAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 14:00:06 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1937C0A3BF8;
        Sun, 12 Apr 2020 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cz+sECi5B33RA2Hk3YBuRFj9oUh57xTGLg7pjrXt1hE=; b=MdWd9PfDOwHlAOT+K+IpO6rrgb
        ubDeyh2oEPp/pcaZ9g1jKb5kHeNNvE2RibAmJo6tRbeskxtRQ7Ztbgm32Vv6DKyyiEYl2k7LL4ZP/
        Fh1CkDGTBIMRGJJKJjY46Ci5/nC5qi4VbJ+PpvpFqI+6Ztgt+K2XAAJP/ke3n+rvov6obZi6fBD/o
        PHMf3VlmtAAaPwlUTLnjjtXoeTKL1aCscOH1T1UlHAPRe3yqSpFo22gcZx95/nbm8Bm9LeDzKpNMm
        QX3TzI18a3/IooWQuEUP74lvbO+7hiTqlbRT0twUmR2NcTzVMRcFRBlk9+fAvNy47m9XcmXngeCfA
        uhlfU+fA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jNgoR-0007Vk-80; Sun, 12 Apr 2020 19:54:31 +0200
Received: from [82.135.69.30] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jNgoQ-000Pmc-Vl; Sun, 12 Apr 2020 19:54:31 +0200
Subject: Re: [PATCH] iio: buffer: remove null-checks for 'indio_dev->info'
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200407145918.6833-1-alexandru.ardelean@analog.com>
 <20200412143008.3fa722a9@archlinux>
 <950bed7e142e7aa1cbd74fe15e560fe7d584af95.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1f16c600-0181-438c-8741-7a2438e3209f@metafoo.de>
Date:   Sun, 12 Apr 2020 19:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <950bed7e142e7aa1cbd74fe15e560fe7d584af95.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25780/Sun Apr 12 13:57:54 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/12/20 4:31 PM, Ardelean, Alexandru wrote:
> On Sun, 2020-04-12 at 14:30 +0100, Jonathan Cameron wrote:
>> [External]
>>
>> On Tue, 7 Apr 2020 17:59:18 +0300
>> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>>
>>> Checking for 'indio_dev->info' is an impossible condition, since an IIO
>>> device should NOT be able to register without that information.
>>> The iio_device_register() function won't allow an IIO device to register if
>>> 'indio_dev->info' is NULL.
>>>
>>> If that information somehow becomes NULL, then we're likely busted anyway
>>> and we should crash the system, if we haven't already.
>>>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> I'm glad there was a comment in there to remind me of what was going on here.
>>
>> This is the result of an ancient set from (I think) Lars hardening IIO
>> against forced removal.
>>
>> The indio_dev->info == NULL is deliberately set to true by the IIO core
>> during device remove in order to deal with any inflight data.
>>
>> Reference counting should ensure the device doesn't go away but we need
>> to avoid actually doing anything if this occurs.  That pointer was a
>> convenient option to avoid having to add an explicit flag or 'going away'.
>>
>> Now, it's possible we don't need this any more due to other changes but
>> I certainly don't want to remove it without that being very thoroughly
>> verified!
>>
> Agreed.
> Thanks for the info.
>
> Will think about this a bit later.
>
> Thanks
> Alex

I'm pretty sure we need this. It is to handle the case when the device 
is removed while there a still open file handles. This is necessary 
since we can't stop a physical device from being remove.


E.g. thing a USB device, if somebody pulls it out you can't access it 
anymore. This means you can do any USB requests anymore, but there might 
still be an open file handle. So that means even while the physical 
device has already been removed the open file still has a reference to 
the iio_dev, which means it is kept around and it is possible to do 
read(), poll(), ... on it.

In fact as soon as the remove() callback has finished the underlying 
device is gone, even the module that implements the code might have been 
removed. So we must make sure to not call into any of the callbacks 
anymore. For this reason we set info to NULL.


- Lars


>
>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>>   drivers/iio/industrialio-buffer.c | 19 +------------------
>>>   1 file changed, 1 insertion(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-
>>> buffer.c
>>> index e6fa1a4e135d..c96071bfada8 100644
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -54,10 +54,6 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev,
>>> struct iio_buffer *buf,
>>>   	size_t avail;
>>>   	int flushed = 0;
>>>   
>>> -	/* wakeup if the device was unregistered */
>> This comment makes it clear this isn't as 'obvious' as it might at first seem
>> ;)
>>
>>> -	if (!indio_dev->info)
>>> -		return true;
>>> -
>>>   	/* drain the buffer if it was disabled */
>>>   	if (!iio_buffer_is_active(buf)) {
>>>   		to_wait = min_t(size_t, to_wait, 1);
>>> @@ -109,9 +105,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char
>>> __user *buf,
>>>   	size_t to_wait;
>>>   	int ret = 0;
>>>   
>>> -	if (!indio_dev->info)
>>> -		return -ENODEV;
>>> -
>>>   	if (!rb || !rb->access->read)
>>>   		return -EINVAL;
>>>   
>>> @@ -131,11 +124,6 @@ ssize_t iio_buffer_read_outer(struct file *filp, char
>>> __user *buf,
>>>   
>>>   	add_wait_queue(&rb->pollq, &wait);
>>>   	do {
>>> -		if (!indio_dev->info) {
>>> -			ret = -ENODEV;
>>> -			break;
>>> -		}
>>> -
>>>   		if (!iio_buffer_ready(indio_dev, rb, to_wait, n / datum_size)) {
>>>   			if (signal_pending(current)) {
>>>   				ret = -ERESTARTSYS;
>>> @@ -171,7 +159,7 @@ __poll_t iio_buffer_poll(struct file *filp,
>>>   	struct iio_dev *indio_dev = filp->private_data;
>>>   	struct iio_buffer *rb = indio_dev->buffer;
>>>   
>>> -	if (!indio_dev->info || rb == NULL)
>>> +	if (rb == NULL)
>>>   		return 0;
>>>   
>>>   	poll_wait(filp, &rb->pollq, wait);
>>> @@ -1100,11 +1088,6 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>>>   		goto out_unlock;
>>>   	}
>>>   
>>> -	if (indio_dev->info == NULL) {
>>> -		ret = -ENODEV;
>>> -		goto out_unlock;
>>> -	}
>>> -
>>>   	ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
>>>   
>>>   out_unlock:


