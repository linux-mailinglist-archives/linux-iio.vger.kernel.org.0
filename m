Return-Path: <linux-iio+bounces-12693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14C9D9CE8
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C712846C4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC01DBB3A;
	Tue, 26 Nov 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRD1dSon"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47E182BC;
	Tue, 26 Nov 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643543; cv=none; b=lAthDVjtR7WqBPeWiWp4YlNoRgf9E6bLohUQtUV8N4BxDRztMVqU9v0a1+xQW0bZOhWqctDopkBDzpISak5Ns2k+hyIVXjy87HzxxvyDnqVAorV/baTW1TToBA72g07wDwiEZMZYaxikaajJjSWhuZhXqPR7NgPHZBq4OyKO+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643543; c=relaxed/simple;
	bh=2OlL0GsjxaKsdejys6yGzAHyzOBtwoE5UhPw64LeQTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEIEAmom4Tnn95ZmU7SlCuhse7olE1FV69RIIz1k70msK26F8IutiM9u5LyG8RKQL74pjGoxvv1wg3+mdWw1ZQRj2wy7UfkXPKSozRAww9wKrSgjDbUSrsrtoaAJK+muZ3Faf/tBY2KmkaFfrHjqepwpRNIA2/vEjnCrIR1i0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRD1dSon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F28C4CECF;
	Tue, 26 Nov 2024 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643543;
	bh=2OlL0GsjxaKsdejys6yGzAHyzOBtwoE5UhPw64LeQTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRD1dSonxcxCzafOhwLWHrsnUfqvFtGBfYuwmHBBxTcWXCsNW2yFCWaprM6iai/Za
	 z8jconqnO9bm3xzHXJWtuznKRMTOruscBm080Cc133OwJj5fIAgTmqKrggvqPIg4X3
	 0q98ZdxG028OTGVrdRKaE0c1+yjHbiUBnExjU89m2Qix/tpzTPpT1fqWoW2SdlnWcN
	 V1vNLZyAl3McXHsOumSQqZPXCyX3R72kuyg/wR4XunWfKZL4KKPx5ryVDYgX0+/av6
	 F1k7hl5vAyNcvtEEH+j+/grD+/Z8Logk+Axxwz+doHNTRX8+6r4PmFUnl7gwiAfiY0
	 nuO/oStPs5VIQ==
Date: Tue, 26 Nov 2024 17:52:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: gts: Simplify using __free
Message-ID: <20241126175214.76609ba9@jic23-huawei>
In-Reply-To: <964035d9-cccd-4e12-af71-00ca39cc3596@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
	<20241123163713.2ec03a37@jic23-huawei>
	<964035d9-cccd-4e12-af71-00ca39cc3596@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 11:16:22 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks once again for the review :)
> 
> On 23/11/2024 18:37, Jonathan Cameron wrote:
> > On Thu, 21 Nov 2024 10:20:07 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The error path in the gain_to_scaletables() uses goto for unwinding an
> >> allocation on failure. This can be slightly simplified by using the
> >> automated free when exiting the scope.
> >>
> >> Use __free(kfree) and drop the goto based error handling.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> ---
> >>
> >> Revision history:
> >>    v1 => v2:
> >>    - patch number changed because a change was added to the series.
> >>    - rebased on iio/testing to avoid conflicts with queued fixes
> >> ---
> >>   drivers/iio/industrialio-gts-helper.c | 19 ++++++++-----------
> >>   1 file changed, 8 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> >> index 291c0fc332c9..602d3d338e66 100644
> >> --- a/drivers/iio/industrialio-gts-helper.c
> >> +++ b/drivers/iio/industrialio-gts-helper.c
> >> @@ -4,6 +4,7 @@
> >>    * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
> >>    */
> >>   
> >> +#include <linux/cleanup.h>
> >>   #include <linux/device.h>
> >>   #include <linux/errno.h>
> >>   #include <linux/export.h>
> >> @@ -167,8 +168,8 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
> >>   
> >>   static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> >>   {
> >> -	int i, j, new_idx, time_idx, ret = 0;
> >> -	int *all_gains;
> >> +	int ret, i, j, new_idx, time_idx;
> >> +	int *all_gains __free(kfree) = NULL;  
> > See the docs in cleanup.h (added recently).
> > 
> > Constructor and destructor should go together.   Dan wrote good docs on this
> > (which are now in cleanup.h) so I'll not go into why!  
> 
> I went through the cleanup.h, and noticed the nice explanation for the 
> pitfall where we have multiple "scoped operations" with specific 
> ordering required. I didn't see other reasoning beyond that - I do hope 
> I didn't miss anything.
> 
> I find introducing variables mid-function very confusing. Only exception 
> for this has been introducing temporary variables at the start of a 
> block, to reduce the scope. I would still like to avoid this when it 
> isn't absolutely necessary, as it bleeds my eyes :)
> 
> I really don't see why we would have other cleanups which required 
> specific ordering with the allocated "all_gains".
> 
> Anyways, if you think we really have a problem here, would it then 
> suffice if I moved the:
> 
>          gain_bytes = array_size(gts->num_hwgain, sizeof(int));
>          all_gains = kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
>          if (!all_gains)
>                  return -ENOMEM;
> 
> to the beginning of the function, and the "int *all_gains __free(kfree) 
> = NULL;" as last variable declaration?
> 

No.  You need to follow the standard way. It is something we are
all getting used to, but all use of cleanup.h needs to follow same rules
so that reviewers find it easy to review once they are seeing lots of
instances of it.

Many indeed find this ugly but reality is it's happening all over the place
just usually hidden in a macro.  From cleanup.h look at how
guard() works for instance.


Jonathan

> (This is not optimal as we will then do the allocation even if 
> converting gains to scales failed - but I don't think this is a real 
> problem as this should never happen after the driver is proven working 
> for the first time).
> 
> > Upshot is this goes where you do the kcalloc, not up here.  
> 
> *whining* "but, but, but ... it is ugly..." :)

:)  It won't look ugly after a few years!
> 
> Yours,
> 	-- Matti


