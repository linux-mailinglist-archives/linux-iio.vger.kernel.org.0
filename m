Return-Path: <linux-iio+bounces-12099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FB9C2F97
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 22:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1480C1C2108F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD71A0BF2;
	Sat,  9 Nov 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ReTnYzKA"
X-Original-To: linux-iio@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732682E628
	for <linux-iio@vger.kernel.org>; Sat,  9 Nov 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731186664; cv=none; b=IKlRY/dxSgnWexo9CtUsrUcoWSbY+fm0+yIbu3ovJ8Eo7HhA2jPkzRVO95Y/xkYxCb1qhOURDi3WvRroGEP251MafrBxkDWOrVH/hh46JYZIGez+gcIDdNM87jfP6g1rvTlWOBwkvxNxIbl70Qfp0SctseqDhRgcwUSS0+7O4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731186664; c=relaxed/simple;
	bh=OSGp+o9sm4rA8egovf6qzFSLKDbiMjs7j3NS2oNGMNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orbvtg3pCNw573rFBcZ5XRtyRtUO5w5lT3hqGobffv7aj3KC/1//7pmrZVnE5eZJ3rb9J9qizXLwkahKnOcas+aYtu1xjistuHdKsKTFR81gBU8AFTgyKUoyFrAyyD0Q9ijvXk4KsFmEdxvhjgE17d+5HwWFVEccLLBNDREXN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ReTnYzKA; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731186663;
	bh=vlcvqP3g3jhVveFyLoQp5nyZcFaxJKwBE3uaOe3Pk+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=ReTnYzKApneWE3k8wOYswbJzIHZVCAzIAnpzy/Wy+P1R3XUBXO+e8K8nBiYFImHvX
	 Y32yOCnyMI5g76mnrWhT6YwrLdkBDMnMDoCnjaZfS2l7zkDecu9URHCViRQcG+0l2v
	 r07/THzdpWACOykh0t84lfFL6DJVl+r0a91TxQ92Hil8AOXWAfgUhGh5u+zNrkyw0z
	 RBHlRw7OJcaqUHgRhjrC5YPjTCfU8d2x7t9uHlVbk3OtQN/24PCwFSdya8+wLTBUPV
	 HCrfvr8VQVzf7PE8XsZtarJ4n3IAKqfcFf6tJopIefmDY7l9LMW3FoqJlLzwLR6nFg
	 9SCQ/A2Ivebxw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id D8FB7A0164;
	Sat,  9 Nov 2024 21:10:57 +0000 (UTC)
Message-ID: <58d77d45-d052-4431-91de-3912a9c675b5@icloud.com>
Date: Sun, 10 Nov 2024 05:10:53 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
To: Matteo Martelli <matteomartelli3@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>,
 Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-block@vger.kernel.org
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
 <c6d634d088f77abd956dbd125c26d43d@gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <c6d634d088f77abd956dbd125c26d43d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GYISZ6Ywl379103HIRfHooemgYBYVHDV
X-Proofpoint-GUID: GYISZ6Ywl379103HIRfHooemgYBYVHDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_21,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411090184

On 2024/11/8 17:04, Matteo Martelli wrote:
> On Mon, 28 Oct 2024 13:04:10 +0100, matteomartelli3@gmail.com wrote:
>> Hi everyone,
>>
>> I found an issue that might interest iio, sysfs and devres, about a
>> particular usage of devm_kmalloc() for buffers that later pass through
>> sysfs_emit() or sysfs_emit_at(). These sysfs helpers require the output
>> buffer to be PAGE_SIZE aligned since commit 2efc459d06f1 ("sysfs: Add
>> sysfs_emit and sysfs_emit_at to format sysfs output"). Such requirement
>> is satisfied when kmalloc(PAGE_SIZE, ...) is used but not when
>> devm_kmalloc(PAGE_SIZE,...) is used as it actually returns a pointer to
>> a buffer located after the devres metadata and thus aligned to
>> PAGE_SIZE+sizeof(struct devres).
>>
>> Specifically, I came across this issue during some testing of the
>> pac1921 iio driver together with the iio-mux iio consumer driver, which
>> allocates a page sized buffer to copy the ext_info of the producer
>> pac1921 iio producer driver. To fill the buffer, the latter calls
>> iio_format_value(), and so sysfs_emit_at() which fails due to the buffer
>> not being page aligned. This pattern seems common for many iio drivers
>> which fill the ext_info attributes through sysfs_emit*() helpers, likely
>> necessary as they are exposed on sysfs.
>>
>> I could reproduce the same error behavior with a minimal dummy char
>> device driver completely unrelated to iio. I will share the entire dummy
>> driver code if needed but essentially this is the only interesting part:
>>
>> 	data->info_buf = devm_kzalloc(data->dev, PAGE_SIZE, GFP_KERNEL);
>> 	if (!data->info_buf)
>> 		return -ENOMEM;
>>
>> 	if (offset_in_page(data->info_buf))
>> 		pr_err("dummy_test: buf not page algined\n");
>>
>> When running this, the error message is printed out for the reason above.
>>
>> I am not sure whether this should be addressed in the users of
>> devm_kmalloc() or in the devres implementation itself. I would say that
>> it would be more clear if devm_kmalloc() would return the pointer to the
>> size aligned buffer, as it would also comply to the following kmalloc
>> requirement (introduced in [1]):
>>
>> The address of a chunk allocated with `kmalloc` is aligned to at least
>> ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
>> alignment is also guaranteed to be at least to the respective size.
>>
>> To do so I was thinking to try to move the devres metadata after the
>> data buffer, so that the latter would directly correspond to pointer
>> returned by kmalloc. I then found out that it had been already suggested
>> previously to address a memory optimization [2]. Thus I am reporting the
>> issue before submitting any patch as some discussions might be helpful
>> first.
>>

no, IMO, that is not good idea absolutely.

>> I am sending this to who I think might be interested based on previous
>> related activity. Feel free to extend the cc list if needed.
> 
> Adding some more context to better understand the impact of this.
> 
> With a trivial grep it looks like there are only few instances where
> devm_k*alloc() is used to allocate a PAGE_SIZE buffer:
> 
> $ git grep -n 'devm_.*alloc.*(.*PAGE_SIZE'
> block/badblocks.c:1584:         bb->page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> drivers/iio/multiplexer/iio-mux.c:287:          page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> drivers/mtd/nand/raw/mxc_nand.c:1702:   host->data_buf = devm_kzalloc(&pdev->dev, PAGE_SIZE, GFP_KERNEL);
> drivers/usb/gadget/udc/gr_udc.c:1987:           buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
> sound/soc/sof/debug.c:277:              dfse->buf = devm_kmalloc(sdev->dev, PAGE_SIZE, GFP_KERNEL);
> 
> What takes my attention is the bb->page in blocks/badblocks.c, being the
> buffer named "page" maybe it is supposed to be page aligned?
> 
> Also in [3] it was suggested to add the page alignment check for
> sysfs_emit() and sysfs_emit_at(), but I haven't found why that's
> necessary. My guess is for optimizations to avoid the buffer to spread
> in more than one page. Is this correct? Are there other reasons? Can
> anyone add more details? I think it would help to understand whether
> page alignment is necessary in the other instances of devm_k*alloc().
> 
> Beside page alignment, there are plenty of devm_k*alloc() around the
> code base, is there any way to spot whether any of those instances
> expect the allocated buffer to be aligned to the provided size?
> 
> If this is a limited use-case it can be worked around with just regular
> k*alloc() + devm_add_action_or_reset() as Jonathan suggested. However, I
> still think it can be easy to introduce some alignment related bug,
> especially when transitioning from k*alloc() to devm_k*alloc() in an old
> implementation since it can be assumed that they have the same alignment
> guarantees. Maybe some comment in the devres APIs or documentation would
> help in this case?
> 
> Any thoughts?
>

why not to use existing APIs?

addr = devm_get_free_pages(dev, GFP_KERNEL|__GFP_ZERO, 0);
devm_free_pages(dev,addr);

>>
>> [1]: https://lore.kernel.org/all/20190826111627.7505-3-vbabka@suse.cz/
>> [2]: https://lore.kernel.org/all/20191220140655.GN2827@hirez.programming.kicks-ass.net/
> 
> [3]: https://lore.kernel.org/all/743a648dc817cddd2e7046283c868f1c08742f29.camel@perches.com/
> 
> Best regards,
> Matteo Martelli
> 


