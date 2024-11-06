Return-Path: <linux-iio+bounces-11938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180349BE2F5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0D81F236A6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076751D88BF;
	Wed,  6 Nov 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwFXZbfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057C3211;
	Wed,  6 Nov 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886319; cv=none; b=UmpnzBr+jCJ4gwKTeackDWqC3YxBO53L07TyeM13M+Vr+RUMZfq8O3+CTTdeubBZUEfRIrxBuEB/6eHHGkpYrDKIIV9uvZ+YJYZv2E0ZYckz3cDryc1mYZG3Slgo2tVVWscv4Wzf9evlEjj6x4rlTBo1RmK5lZzAOe27/yZFMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886319; c=relaxed/simple;
	bh=IrjvnY9pMMzq8Aj0Nx18xgmSSg9tmfrMJz8voL6BzL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYOfql4+sOtPBaVgkV6kc3Ar8I4/YJynvP4y41igrtIqe9ta6psjGkDzGGQ45v3RU6MUjAjmsaajdOJ62VwG9uf5JHlynbC+QIslcI7sDQSDuK6hXxWOHS9sPQJu6GEauJFVe0Xn/M8aaB8Lj8DKKnLzCO9mAa6vzaQdcruH3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwFXZbfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90E6C4CECD;
	Wed,  6 Nov 2024 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730886319;
	bh=IrjvnY9pMMzq8Aj0Nx18xgmSSg9tmfrMJz8voL6BzL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NwFXZbfgLDHnYQfA5ZLZmRsRzVvSGmk5PZ6dTEVvZMAe3qGF/ouJWFlg8KZbi0QwD
	 Mgkj2n7UitYcGtEpu/vwLn4ZTlBXgIxRI0KHwuq5P4lxU5fjXG1q4OrE48btfA9Pyc
	 saKmiKSP96bwvRi7LTXQjYLS2MLRYiXto+INl4q8MFUBG/ovyLHPJ/FrxJTFXqlj6i
	 tUd9mEeJhoPmCOlNnIm6Gn78izFnczCLnLMVuz/3cNSbqEt2q4rZnFdjLP/pz0OOSX
	 pLmgsQxiUk4Fae1k/n2HzKG/vrf23bpd4960xH9DXc4qV5/F2bmRn1DAPeKrUr3SWC
	 oT/8yVQTUq9Sw==
Date: Wed, 6 Nov 2024 09:45:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, megi@xff.cz, lars@metafoo.de,
 linux-iio@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20241106094510.3234cae1@jic23-huawei>
In-Reply-To: <20241104140106.GF24862@noisy.programming.kicks-ass.net>
References: <20241028165336.7b46ce25@canb.auug.org.au>
	<20241101141952.4990f238@canb.auug.org.au>
	<dd740dda-a03e-4f3a-bb46-e551f0799c50@intel.com>
	<20241104140106.GF24862@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 15:01:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> It might help if we put the relevant maintainers on Cc?
> 
> On Mon, Nov 04, 2024 at 02:37:57PM +0100, Przemek Kitszel wrote:
> > On 11/1/24 04:19, Stephen Rothwell wrote:  
> > > Hi all,
> > > 
> > > On Mon, 28 Oct 2024 16:53:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > > > 
> > > > After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> > > > failed like this:
> > > > 
> > > > drivers/iio/magnetometer/af8133j.c: In function 'af8133j_set_scale':
> > > > drivers/iio/magnetometer/af8133j.c:315:12: error: suggest explicit braces to avoid ambiguous 'else' [-Werror=dangling-else]
> > > >    315 |         if (!pm_runtime_status_suspended(dev))
> > > >        |            ^
> > > > cc1: all warnings being treated as errors
> > > > 
> > > > Probably caused by commit
> > > > 
> > > >    fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> > > > 
> > > > I have applied the following for today but I wonder if there may be
> > > > others.
> > > > 
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Mon, 28 Oct 2024 16:01:15 +1100
> > > > Subject: [PATCH] fix up for "cleanup: Adjust scoped_guard() macros to avoid
> > > >   potential warning"
> > > > 
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >   drivers/iio/magnetometer/af8133j.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> > > > index d81d89af6283..acd291f3e792 100644
> > > > --- a/drivers/iio/magnetometer/af8133j.c
> > > > +++ b/drivers/iio/magnetometer/af8133j.c
> > > > @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
> > > >   	 * When suspended, just store the new range to data->range to be
> > > >   	 * applied later during power up.
> > > >   	 */
> > > > -	if (!pm_runtime_status_suspended(dev))
> > > > +	if (!pm_runtime_status_suspended(dev)) {
> > > >   		scoped_guard(mutex, &data->mutex)
> > > >   			ret = regmap_write(data->regmap,
> > > >   					   AF8133J_REG_RANGE, range);
> > > > +	}

Might as well flip it to a guard() given the scope is the same and it will
be a little more readable.

Otherwise I'm fine taking a patch doing this if someone can send on to
linux-iio@vger.kernel.org


I'll get to making a patch at somepoint but just back from travel
so a lot of other things on my queue today.



> > > >   	pm_runtime_enable(dev);  
> > > 
> > > I am still applying this patch.
> > >   
> > 
> > This patch of yours is necessary, could you make it permanent?
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>  


