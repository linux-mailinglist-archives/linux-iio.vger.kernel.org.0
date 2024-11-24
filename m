Return-Path: <linux-iio+bounces-12590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4AB9D779A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6F1B31874
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97D126BEE;
	Sun, 24 Nov 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUnxLn4+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760851016;
	Sun, 24 Nov 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470872; cv=none; b=SA3TLCO7ni0ybjOSMWbaoohJRXTzSzLbtyqJSmr7tDmSlKJZCQSrYWnx8kFKzd4l2cmUoNyrToDZ5jzm2qdntZFUghusY0sj/QtcpQUJYLImakODuneJ858JyBzna8Wn3qqsqCZovu7aCzduPxXB86QjpdOHwQ9O42juqV7gBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470872; c=relaxed/simple;
	bh=z/kOx4/x0l7tBGEIaO5SI2WToCFQJBg4W0BW4MoUJBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UR6p+Z98DVxjGOZPLOoc2DoLVAnU5S/+NATRh45IkPok9FS0MZ+P9Eg5BZXkuTBQ04CJgtanidN7INvXwq1MTbYcbMPVguSXAV/4o6AFD5wCoukGsG2wzIzcezvOlDVodcCgeKPodBRJxXI7igJsM/MX8NjWuORvEOxK6JPhjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUnxLn4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70569C4CED1;
	Sun, 24 Nov 2024 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732470871;
	bh=z/kOx4/x0l7tBGEIaO5SI2WToCFQJBg4W0BW4MoUJBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUnxLn4+e1nBEJORpzIhlkuGEhmE6Uk9Hf2A0ha2nXuMxwcvQ+BkwSJyIPp54Iron
	 OIK/HfR/G/AU3gU0fC+FAuOdOw+uJoLyBQFmzve9jA6sW94BlrvhS34BV6OqDsCgaw
	 pTPzvMjUuLtOc60E32H5v55mWixibeMWsRnSV6o5GXUL2lBvPtpSIbsnhc8IIl1oRM
	 0kMllXoX/a46W3iGtlBPUO0Sq45zB+tlhmvlgAVgqfXgMtGjqmn4SxNqIjNx3cfO8X
	 TZEQj2BthHB0upNQZ390cfA5cfMyHAe/yPjvKLv4ROPKGkTXWV3RXVKkw/0PNzh3N6
	 xlTJr+L0Vt4ZQ==
Date: Sun, 24 Nov 2024 17:54:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Charles Han <hanchunchao@inspur.com>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike
 Looijmans <mike.looijmans@topic.nl>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Yu
 Jiaoliang <yujiaoliang@vivo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-ads1298: Add NULL check in ads1298_init()
Message-ID: <20241124175423.5ee15c6a@jic23-huawei>
In-Reply-To: <ba5e2b95-12d9-490b-b58d-131dedba6446@web.de>
References: <20241118090208.14586-1-hanchunchao@inspur.com>
	<ba5e2b95-12d9-490b-b58d-131dedba6446@web.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 11:08:47 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > devm_kasprintf() can return a NULL pointer on failure,but this
> > returned value in ads1298_init() is not checked.
> > Add NULL check in ads1298_init(), to handle kernel NULL
> > pointer dereference error.  
> 
> Another wording suggestion:
> A devm_kasprintf() call can return a null pointer on failure.
> But such a return value was not checked in this function implementation.
> Thus add a corresponding check so that a null pointer dereference
> will be avoided.
> 
> 
> Regards,
> Markus

I tweaked it to slightly shorter form.

Applied and marked for stable.

Thanks,

Jonathan

