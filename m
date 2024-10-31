Return-Path: <linux-iio+bounces-11727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4149B85AF
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90811F2118D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADA1BC9ED;
	Thu, 31 Oct 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFqE5MEK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9C14A4F9;
	Thu, 31 Oct 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411244; cv=none; b=uQjn8mGXfz4jw2uRwZglJdfsXi80D/T7gcMigMmyXa7bttgzTYo7T4YcdnrdAFLfV2/E5kSiJyoa4O63eMy6RXmPviD4NWBmVT7/fCtFfxNbNQd5EhbQ10lHwPaywA9tBNEiP/3Ru6OhCAFmVOPuuA8GpMQNSQcSKaIhX+fsF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411244; c=relaxed/simple;
	bh=j01ox2pPpI10vAJWlnPz5AUadi7QODA0/ZcH8lLTl+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCkfXG4S/8y51CEXZRKj5IUuQcf8MB7YKONgC666EjvOVmbSnHBxjrNHv4NvNgTIXPzMYu28UvVCewh9i4WzXgcHlrx3RcmxAA22Im8Cst2VNZzbM+ZUt7C5OiW2zKFM3OFAMiZy0x9LKJTKkGLUvwGoegb4q/FS9VgqX/W9H0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFqE5MEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0638C4CEC3;
	Thu, 31 Oct 2024 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730411243;
	bh=j01ox2pPpI10vAJWlnPz5AUadi7QODA0/ZcH8lLTl+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFqE5MEKS3b7/vY4CCBTD6GBldx80qrXbn9o763Ft733afM4u3FTc1FwUb0yPo4TD
	 Q3Ot3fAr5FK7pkoX99I1BuB0+c2UygJWNkiNjFMWxH4rIgaA7XL/OkcXAVCpKpu1Jj
	 0bJvABU3h/60c0CPOqqgMpf64qE/p3sHCQ8k0lmwJuVvhNIZFeVUa/nmiS6oZShbkv
	 iWLUBlfucrcrMd9npAfHwhPRwKciR/WIoIuPhtFDTz6TdGfsfC7lrMVbJla8h5sD4v
	 lCk33Zs/8GHyde3lNxHAsQMfPn+4pn1qerAlltJxMNH7kvWn6QS8lvdgZ2DZan3HPX
	 0045zeMXUVhUw==
Date: Thu, 31 Oct 2024 21:47:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH] iio: Fix uninitialized symbol 'ret'
Message-ID: <20241031214715.50c4788d@jic23-huawei>
In-Reply-To: <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
References: <20241031014505.2313035-1-quzicheng@huawei.com>
	<5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 09:13:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Zicheng,
> 
> Thanks for the patch.
> 
> On 31/10/2024 03:45, Zicheng Qu wrote:
> > Initialize the variable ret at the time of declaration to prevent it from
> > being returned without a defined value. Fixes smatch warning:
> > drivers/iio/industrialio-gts-helper.c:256 gain_to_scaletables() error:
> > uninitialized symbol 'ret'.
> > 
> > Cc: stable@vger.kernel.org # v6.6+
> > Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > ---
> >   drivers/iio/industrialio-gts-helper.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> > index 59d7615c0f56..c5dc5b51693d 100644
> > --- a/drivers/iio/industrialio-gts-helper.c
> > +++ b/drivers/iio/industrialio-gts-helper.c
> > @@ -167,7 +167,7 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
> >   
> >   static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> >   {
> > -	int ret, i, j, new_idx, time_idx;
> > +	int i, j, new_idx, time_idx, ret = 0;
> >   	int *all_gains;
> >   	size_t gain_bytes;
> >     
> 
> So, if I read it right, this handles a (corner) case where there is no 
> times given. I am not sure how well such use has been considered because 
> the point of GTS is helping out with cases where the gain and 
> integration time both impact to scale.
> 
> How do you see the benefits of the gts if there is no such shared impact 
> to scale? Sure the gts could still provide the 'standard table format' 
> to present the gains (or times), and conversions from the register 
> values to gains (or times), and perhaps the available scale table(s) - 
> but I suppose it also brings a lot of unused code and some 
> initialization overhead. (I have a vague feeling this was discussed with 
> Jonathan during the reviews).
> 
> Reason I am asking these questions is that I wonder if the usage should 
> be limited to cases where we have both gains and times? We could check 
> this in the iio_gts_sanity_check(). (And, I am actually a bit surprized 
> this check was not implemented).
> 
> Well, initialization fixes a potential bug here and does not really cost 
> much - so big thanks to you :)
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Indeed I'm not convinced this is a a bug that can be hit, but it is
obviously good hardening so applied to the fixes togreg branch of iio.git.
Note I'd like a follow up to use __free() + early returns in this function.
Will reduce complexity and that last line will become a return 0;

> 
> Yours,
>   -- Matti Vaittinen
> 


