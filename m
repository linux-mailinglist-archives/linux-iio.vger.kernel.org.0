Return-Path: <linux-iio+bounces-10784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151CB9A4E7F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331821C2120B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B621373;
	Sat, 19 Oct 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQV/OI6R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D83182BC;
	Sat, 19 Oct 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346964; cv=none; b=Z7Up3czChmSAENU1TbHY2NZ4+uXhS973HTDeQTl2QjUwZ9JNX0yfSQqY85w+HvMrgSNRtt/h+Ppm5fyGFWH794/wlsvnxYeX9liws8wtoz++4KrEHh9vpqsiEd7I3BTlKJqMNC6omlnlhQvNxgI4juWgwrMCRVbCRnRmReySHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346964; c=relaxed/simple;
	bh=dqsVozCgrEHEen6yxrbRaDQKmtbYKIR0HqsyRxEaZag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doO9X68gvaiD4Xt+O3qDMWhfa6L5wFz0cdHjCXPHhmWSy5RnPYilFIHRtQ4tJBy0xZInExNehlfYCIWgho2inrVFKuwXdoMSeBkj1141KY3UhKAHK60h425CAtXkHwTQROu4Xa2U1MffFX0ZwfYsJsPxlVzc8oCssugrfTPVRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQV/OI6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B6BC4CEC5;
	Sat, 19 Oct 2024 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729346964;
	bh=dqsVozCgrEHEen6yxrbRaDQKmtbYKIR0HqsyRxEaZag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eQV/OI6R7IHWLlLNMyp2km7X9PpEYnvODq/mhizl648pbRn6YPbvgQjKoExDxU3h4
	 ceo4ktHfn0F58Aas9J6Ev2Ywzc1rsLEON1m5ESYCxd/bEWpDkNyeHxaHXej+n8dgdI
	 v9CzDshLLKvuudoNBmd9Yd0oFwQGsRBEmDOK8oEwqqDKzDcN4EKfRNA7JOuhodRPJv
	 GZRw86ZwEAKSjJKqHuqf/EQU6caxmOClyeDdvyLAN4BXTJo2HgrdftsALsIscWN+xa
	 VQ/Z6Gf3+xXdu8tH3AZh78KEOUiOo2kobt9fvZyMH5Lox2l32Qx6LUtFFLnraeyU2O
	 QEYxAQWVeRWdA==
Date: Sat, 19 Oct 2024 15:08:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helper: Fix memory leaks in
 iio_gts_build_avail_scale_table()
Message-ID: <20241019150855.418a11e6@jic23-huawei>
In-Reply-To: <8671e3dc-dda6-4a45-864e-b01c668cd9d9@gmail.com>
References: <20241011095512.3667549-1-ruanjinjie@huawei.com>
	<20241012171559.2c118a2f@jic23-huawei>
	<8671e3dc-dda6-4a45-864e-b01c668cd9d9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 09:26:54 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jinjie, Jonathan,
> 
> On 12/10/2024 19:15, Jonathan Cameron wrote:
> > On Fri, 11 Oct 2024 17:55:12 +0800
> > Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >   
> >> modprobe iio-test-gts and rmmod it, then the following memory leak
> >> occurs:
> >>
> >> 	unreferenced object 0xffffff80c810be00 (size 64):
> >> 	  comm "kunit_try_catch", pid 1654, jiffies 4294913981
> >> 	  hex dump (first 32 bytes):
> >> 	    02 00 00 00 08 00 00 00 20 00 00 00 40 00 00 00  ........ ...@...
> >> 	    80 00 00 00 00 02 00 00 00 04 00 00 00 08 00 00  ................
> >> 	  backtrace (crc a63d875e):
> >> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
> >> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
> >> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
> >> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
> >> 	    [<000000000315bc18>] 0xffffffdf052a6488
> >> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
> >> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
> >> 	    [<00000000f505065d>] kthread+0x2e8/0x374
> >> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
> >> 	unreferenced object 0xffffff80cbfe9e70 (size 16):
> >> 	  comm "kunit_try_catch", pid 1658, jiffies 4294914015
> >> 	  hex dump (first 16 bytes):
> >> 	    10 00 00 00 40 00 00 00 80 00 00 00 00 00 00 00  ....@...........
> >> 	  backtrace (crc 857f0cb4):
> >> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
> >> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
> >> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
> >> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
> >> 	    [<000000007d089d45>] 0xffffffdf052a6864
> >> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
> >> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
> >> 	    [<00000000f505065d>] kthread+0x2e8/0x374
> >> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
> >> 	......
> >>
> >> It includes 5*5 times "size 64" memory leaks, which correspond to 5 times
> >> test_init_iio_gain_scale() calls with gts_test_gains size 10 (10*size(int))
> >> and gts_test_itimes size 5. It also includes 5*1 times "size 16"
> >> memory leak, which correspond to one time __test_init_iio_gain_scale()
> >> call with gts_test_gains_gain_low size 3 (3*size(int)) and gts_test_itimes
> >> size 5.
> >>
> >> The reason is that the per_time_gains[i] is not freed which is allocated in
> >> the "gts->num_itime" for loop in iio_gts_build_avail_scale_table().
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>  
> > Hi Jinjie,
> > 
> > Your explanation looks correct to me.  I'll wait a while though to give Matti time
> > to take a look as well.  
> 
> Sorry for late reply - I spent last couple of days walking through the 
> swamps and forests in the wilderness.
> 
> Something was bothering me with this. I browsed through the code and all 
> the allocations and I'm not able to see why these arrays shouldn't be 
> freed. I did even go through the versions I've sent on list trying to 
> find out what bothers me.
> 
> Well, I found nothing. The version 2 had some code which looped through 
> these arrays freeing them - in an error path - but not in successful 
> case. It seemed as if I had thought these values had to be maintained - 
> but I really can't see why.
> 
> So - thanks. I suppose leaving the memory not freed is just a bug :) 
> Nice that you killed this one :)
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

