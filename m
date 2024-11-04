Return-Path: <linux-iio+bounces-11893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F69BB6FB
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14B31F2394D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E51304B0;
	Mon,  4 Nov 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c98vcCDI"
X-Original-To: linux-iio@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741A8BEE;
	Mon,  4 Nov 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728874; cv=none; b=tQvEfM0xGBm9vsEKK3hsAarsr8M92+2UcA9I5QTnvn5C6TvPWySMFcs6VoAOI1uze8BCWcZyJB4CbsHw2vqBmNzNJwb2pqZYSzEV4Gd4BZ8osJSXLdqJkD5gk8IdZ+JTlzo8FlCXzZan6y3EUsCvbxFgP0rZy2bqeeGCn1P6UGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728874; c=relaxed/simple;
	bh=hYwWE6NSgcNV54B1JYLg3MC+AgkpywJBzoMNETV4gyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXSukgcYABOQPpaWwrxhS4N4OzJEIQRKihDQDO3CU3ipZUcKyR2fDwCYj6UUe+EvCUds6mvXiQBbhMMuVY5ACGB23+FociLlrwZkFNkNe9Znnv/K5gfcab57CSvBkKqJCD0ArvdKcYgb1AAoUXNp5XjPQZGrTNHVeJCXMYsaIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c98vcCDI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/9WKCT0vx39Ceviq8KsWhLeea2L5rBVepa8c56heqKo=; b=c98vcCDIrWnXOfKLZO0yXX66AJ
	yVyjghqAnlZKmkWjAC6ruTsEfVlkBhuN8dcgk3DQ77wMlvu2DrlsivAN+m7VaCOdn2QTfLUvqeUPo
	jHDZu4NmjLEcKKwFd1bOzbs2TwVzv4nkhWcnYp/Q6uB7kTdT8kN8N+AyqRfxwxt5JBHDuXx8Ci7N8
	b/ha1C0ttMvCMCGMDtbrpay4gt3eoGL6pDW+gobvM86CmUtVEOvzOVJqnR94TJaO3Vhkk86Q18MKB
	Et5RcE3YOJoHzhuJ+Er3YFRq8C8+cGVxdnNG4L7kcT6j2k42F931LK6hGOOI6N+XuCm91c8sY88h3
	Jla4Knig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xdi-0000000BLB4-34O0;
	Mon, 04 Nov 2024 14:01:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6121030042E; Mon,  4 Nov 2024 15:01:06 +0100 (CET)
Date: Mon, 4 Nov 2024 15:01:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>, megi@xff.cz,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20241104140106.GF24862@noisy.programming.kicks-ass.net>
References: <20241028165336.7b46ce25@canb.auug.org.au>
 <20241101141952.4990f238@canb.auug.org.au>
 <dd740dda-a03e-4f3a-bb46-e551f0799c50@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd740dda-a03e-4f3a-bb46-e551f0799c50@intel.com>


It might help if we put the relevant maintainers on Cc?

On Mon, Nov 04, 2024 at 02:37:57PM +0100, Przemek Kitszel wrote:
> On 11/1/24 04:19, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Mon, 28 Oct 2024 16:53:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > 
> > > After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > > 
> > > drivers/iio/magnetometer/af8133j.c: In function 'af8133j_set_scale':
> > > drivers/iio/magnetometer/af8133j.c:315:12: error: suggest explicit braces to avoid ambiguous 'else' [-Werror=dangling-else]
> > >    315 |         if (!pm_runtime_status_suspended(dev))
> > >        |            ^
> > > cc1: all warnings being treated as errors
> > > 
> > > Probably caused by commit
> > > 
> > >    fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> > > 
> > > I have applied the following for today but I wonder if there may be
> > > others.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Mon, 28 Oct 2024 16:01:15 +1100
> > > Subject: [PATCH] fix up for "cleanup: Adjust scoped_guard() macros to avoid
> > >   potential warning"
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >   drivers/iio/magnetometer/af8133j.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> > > index d81d89af6283..acd291f3e792 100644
> > > --- a/drivers/iio/magnetometer/af8133j.c
> > > +++ b/drivers/iio/magnetometer/af8133j.c
> > > @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
> > >   	 * When suspended, just store the new range to data->range to be
> > >   	 * applied later during power up.
> > >   	 */
> > > -	if (!pm_runtime_status_suspended(dev))
> > > +	if (!pm_runtime_status_suspended(dev)) {
> > >   		scoped_guard(mutex, &data->mutex)
> > >   			ret = regmap_write(data->regmap,
> > >   					   AF8133J_REG_RANGE, range);
> > > +	}
> > >   	pm_runtime_enable(dev);
> > 
> > I am still applying this patch.
> > 
> 
> This patch of yours is necessary, could you make it permanent?
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

