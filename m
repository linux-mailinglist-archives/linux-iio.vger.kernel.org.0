Return-Path: <linux-iio+bounces-12249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF479C89F0
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7420D285ABF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB31F9ECD;
	Thu, 14 Nov 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="V6O1t6xR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mr85p00im-hyfv06021401.me.com (mr85p00im-hyfv06021401.me.com [17.58.23.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5821F9EBD
	for <linux-iio@vger.kernel.org>; Thu, 14 Nov 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587178; cv=none; b=Ir0sJeSsMdezX1+Ty+CLqgETSyr5oh90dWL4Jvt75V/lP233Jzdl2isVba/3E8zLgX5GPvPXgUdIde6eNYRC+DpeamA63RhC2DpOYVoRQw3jSrS8HU7oR1P2+e6FE8oKSYa6bC8Trhf6yMyQeRzrM/4TmrpzTMTpHcQiWXJ1SM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587178; c=relaxed/simple;
	bh=TikPXk3LtSqVeGP56dttQXFFCzAKOiP1NSO1WuA7L4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvNQGyr4xrzjYvGCsPASyzz61M8uPiNIyYTQEkk4rJ493CY1xwzENbG0yGEbUrBfEIaByv6amVLajGFAOJ7bSZVMdxY30Sh5mvkHt+SppWwVs0o9ZRIFdMExQRI7IHWX5Insb8ffg4kAbKRZNWfHGwtGggA7W/kmJsojrsuv0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=V6O1t6xR; arc=none smtp.client-ip=17.58.23.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731587176;
	bh=DzOhgRULWNgkZ4/fSQp3mEWP69NGu+TazISyLlS+uLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=V6O1t6xRsCPKRof5QmEuTjv2AUP/YFj55WjZtT/PcSd1eIJAik0pDPLLPrxiuHvQy
	 nJdcG/2ERIY7mqEJpjOFtGutEvGOktOCKTF7mUo1Abv+/ysglSp6ZdMSKwefMqwBdP
	 8/nwvx9C24F0TOkL1Qk2FtOb1qscegvtHHZyDtsMQgTCO57UyZo418QQzYAA2BHDls
	 myRjWC+jojltTTMxQofnRCLAZQUJmTDX3VNVr1P+CnPNDEGuNzoo4vFiUBkYohlbll
	 yyq+EpHuFTpAgBvmlFjTQ38FBpbW58qnSpiAfxmkXYawdmyZFTfIz5JtusEiPzfWOW
	 B1Ncy8T9YYS7Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPSA id DA5763038562;
	Thu, 14 Nov 2024 12:26:12 +0000 (UTC)
Message-ID: <ff24d6c8-581d-4dd1-8565-916d3f429ae4@icloud.com>
Date: Thu, 14 Nov 2024 20:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio, syfs, devres: devm_kmalloc not aligned to pow2 size argument
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>, Peter Rosin <peda@axentia.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>,
 Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-block@vger.kernel.org
References: <c486a1cf98a8b9ad093270543e8d2007@gmail.com>
 <c6d634d088f77abd956dbd125c26d43d@gmail.com>
 <58d77d45-d052-4431-91de-3912a9c675b5@icloud.com>
 <cf50fd85a836c32bbb828a832e22d2df@gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <cf50fd85a836c32bbb828a832e22d2df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lU515d71RXapdvWUtPpjTWOMlMmF7qXE
X-Proofpoint-GUID: lU515d71RXapdvWUtPpjTWOMlMmF7qXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_04,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=860 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411140098

On 2024/11/14 19:29, Matteo Martelli wrote:
>>>> The address of a chunk allocated with `kmalloc` is aligned to at least
>>>> ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the
>>>> alignment is also guaranteed to be at least to the respective size.
>>>>
>>>> To do so I was thinking to try to move the devres metadata after the
>>>> data buffer, so that the latter would directly correspond to pointer
>>>> returned by kmalloc. I then found out that it had been already suggested
>>>> previously to address a memory optimization [2]. Thus I am reporting the
>>>> issue before submitting any patch as some discussions might be helpful
>>>> first.
>>>>
>> no, IMO, that is not good idea absolutely.
> It’s now quite clear to me that the issue is a rare corner case, and the
> potential impact of making such a change does not justify it. However,
> for completeness and future reference, are there any additional reasons
> why this change is a bad idea?

1)
as i ever commented, below existing APIs is very suitable for your
requirements. right ?
addr = devm_get_free_pages(dev, GFP_KERNEL|__GFP_ZERO, 0);
devm_free_pages(dev,addr);

2)
touching existing API which have been used frequently means high risk?

3) if you put the important metadata at the end of the memory block.
   3.1) it is easy to be destroyed by out of memory access.
   3.2) the API will be used to allocate memory with various sizes
        how to seek the tail metadata ?  is it easy to seek it?
   3.3) if you allocate one page, the size to allocate is page size
        + meta size, it will waste memory align.

4) below simple alternative is better than your idea. it keep all
attributes of original kmalloc(). right ?

static int devres_raw_kmalloc_match(struct device *dev, void *res, void *p)
{
	void **ptr = res;
	return *ptr == p;
}

static void devres_raw_kmalloc_release(struct device *dev, void *res)
{
	void **ptr = res;
	kfree(*ptr);
}

void *devm_raw_kmalloc(struct device *dev, size_t size, gfp_t gfp)
{
	void **ptr;
	
	ptr = devres_alloc(devres_raw_kmalloc_release, sizeof(*ptr), GFP_KERNEL);
	f (!ptr)
		return NULL;
	
	*ptr = kmalloc(size, gfp);
	if (!*ptr) {
		devres_free(ptr);
		return NULL;
	}
	devres_add(dev, ptr);
	return *ptr;
}
EXPORT(...)

void *devm_raw_kfree(struct device *dev, void *p)
{
	devres_release(dev, devres_raw_kmalloc_release,
devres_raw_kmalloc_match, p);
}
EXPORT(...)

