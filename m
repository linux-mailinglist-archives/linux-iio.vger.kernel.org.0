Return-Path: <linux-iio+bounces-12113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4CA9C3AB4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D401F2203B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5015D5B8;
	Mon, 11 Nov 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVRdtczC"
X-Original-To: linux-iio@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6F156F28;
	Mon, 11 Nov 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316647; cv=none; b=ce4gjUSytLmWrPswJFF522+S7IJBhbuUR4pSZo9wXsRH5nDbwgXeKKunO3EyaBlD8GYRBvUHm2bXGze/HlzBS3kmwER53ZFjT3QLIOjTo/317T1PdEcJdNSIh86MbNfGK5/bn8emdsRnjsB4R5HGGaZ2Ro0vOUu4ZoZ9Zr7iW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316647; c=relaxed/simple;
	bh=bvrXLF4zRL++tSgKdmvsPNLgopd0QtNTW8oHkkCEVUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxICbOjNF7XEuGXDYbtnMYBO8toRSTDxqrOxamHzyPa7QhMIbH7OSVNjvfthljthkGkKy19X69rPvSI5u+AJJ9Nyc3s5o68OkS5tTWYcWozHYxgimVcdThjMT1rwq4ttCTrszJ+l2m71r+qhgXuvAcy0ppApBOpdX3u2KetilQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVRdtczC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lmrAWTJ7L/f63dhTl0exGT6OOFetDyqzZCpjFqde5yw=; b=pVRdtczCr+5BihoWwU8NqsgQAk
	8ae+PEFj8hwksRwkfOA05E3VkxsHdGY2ZZvX4+pckC/fMuhsO7NPaaCDTdxk+PSFSt+QYEbcqc5oM
	yct9C5Ef+ezdKG2Mhhfb29NAe3XcJvHqlMZXuVzZxml/AB/oJBn6hbZYXdkgD2/Y8m0Cg7opGHXuO
	4xrW2QLnITju03ylaETz+c6Twxl6z7H9Vwjp70DbC3+95V2DpskF+RdQUvxUlXQAal6ZNrceMIZRS
	wvyhmGhStGlmmRalTBN88XhPnX50UjW9M0my8gtqx/5BJ1JUtZSeuSdJCEPneZu8Oidtfi41MTGxn
	+unIybRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQXa-0000000CZzr-3YJv;
	Mon, 11 Nov 2024 09:16:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E67FD300472; Mon, 11 Nov 2024 10:16:57 +0100 (CET)
Date: Mon, 11 Nov 2024 10:16:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, megi@xff.cz,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: magnetometer: fix if () scoped_guard() formatting
Message-ID: <20241111091657.GB22801@noisy.programming.kicks-ass.net>
References: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
 <20241108180243.00000c27@huawei.com>
 <20241109112741.456ce2f9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109112741.456ce2f9@jic23-huawei>

On Sat, Nov 09, 2024 at 11:27:41AM +0000, Jonathan Cameron wrote:
> On Fri, 8 Nov 2024 18:02:43 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Fri,  8 Nov 2024 16:41:27 +0100
> > Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > 
> > > Add mising braces after an if condition that contains scoped_guard().
> > > 
> > > This style is both preferred and necessary here, to fix warning after
> > > scoped_guard() change in commit fcc22ac5baf0 ("cleanup: Adjust
> > > scoped_guard() macros to avoid potential warning") to have if-else inside
> > > of the macro. Current (no braces) use in af8133j_set_scale() yields
> > > the following warnings:
> > > af8133j.c:315:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
> > > af8133j.c:316:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
> > > 
> > > Fixes: fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202409270848.tTpyEAR7-lkp@intel.com/
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > ---
> > > I have forgot to add this patch prior to the cited Fixes: commit,
> > > so Stephen Rothwell had to reinvent it, in order to fix linux-next.
> > > original posting by Stephen Rothwell:
> > > https://lore.kernel.org/lkml/20241028165336.7b46ce25@canb.auug.org.au/
> > > ---
> > >  drivers/iio/magnetometer/af8133j.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> > > index d81d89af6283..acd291f3e792 100644
> > > --- a/drivers/iio/magnetometer/af8133j.c
> > > +++ b/drivers/iio/magnetometer/af8133j.c
> > > @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
> > >  	 * When suspended, just store the new range to data->range to be
> > >  	 * applied later during power up.
> > >  	 */
> > > -	if (!pm_runtime_status_suspended(dev))
> > > +	if (!pm_runtime_status_suspended(dev)) {  
> > 
> > I thought I replied to say don't do it this way. Ah well probably went astray
> > as I was having some email issues yesterday.
> > 
> Also, for the fixes tag to make sense this will need got through the same tree as
> that rather than IIO which doesn't have that commit yet.
> 
> Given timing I'm fine with this version getting picked up and if I care enough
> I can chase it with a tidy up to the guard() form next cycle.  
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks, I'll stick it in the locking tree then.

