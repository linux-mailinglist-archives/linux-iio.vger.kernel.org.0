Return-Path: <linux-iio+bounces-10984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1669AC85B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4F8282A06
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306E1A724C;
	Wed, 23 Oct 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FMzxxAgi"
X-Original-To: linux-iio@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34D1BDDF;
	Wed, 23 Oct 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681085; cv=none; b=q1IQ3oBKDc9F+vBY07adPSr4GW2FiqQ8ZGwAarbYX1h8bTdfuwH/w+SwEvFw0WxwU9OXFdY15jQtf5geNse44gkvMwo/qPv8+LKeM8ZZ43Dz+BVTgre4pOb1ZgE7JahaqhSDMw09daysKP9OsdKprlSd1NdFq45c+l533Orpi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681085; c=relaxed/simple;
	bh=QsoXN+i8weNz43cjWTuqeOxBYCQ8z23n7z17VV98vXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgx9I52xR6E1Fj+HEisC87V6wr24+r7+Rd2rbe/ye1IMmV8TlGJrXEB4FoUBckPCnfGLFLngXK+Yo0BFd0ZvCeVYwNOCNU5FzOOoS+hgDE82OiOeSeN0Cc4tBuI9HwKmOmGFF1TQLzSFx94i2Si13r1rxQyCp+6DeV8vcVMdThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FMzxxAgi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fY2P5WH9N9bRXsoSS69lQH2QepyuWVl1r/+h4C6RTgI=; b=FMzxxAgiyJfEk70QindVAt8QPQ
	udYm4IQVe/YMUv22jc2i9ZGpRy7XpUp4RkUujASVhHWIJRTe2Tf3TFK6kN8Pkto6CUMvCEJB4Q+7e
	VGP39BTkTYGPR6wxrvLoqtkJteIzqyQVkwkUrF2yr8m0cV5x/QbxI590oG/p8387cay3xbA+HnFbv
	ZJoyZLtuSuH0u8Whse0oYrQB6zQJwIeotugcFC8naIDRNaFNf8MN8JsK4oSyz5/y3r5U52hmbjS8b
	277HKBuwjKTT5a4/TDuivnF8fYNysVBImhzt5wvv1jAKV9ZENEGUY9HKGC9vVJEiiBPKzqO6Y6xhY
	TSUqXLeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Z3u-00000002nbV-064g;
	Wed, 23 Oct 2024 10:57:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0423D30073F; Wed, 23 Oct 2024 12:57:57 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:57:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-cxl@vger.kernel.org, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
Message-ID: <20241023105757.GA9767@noisy.programming.kicks-ass.net>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
 <20241018111503.GC36494@noisy.programming.kicks-ass.net>
 <6712b717a9610_10a0a2942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6712b717a9610_10a0a2942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Oct 18, 2024 at 12:29:27PM -0700, Dan Williams wrote:
> Peter Zijlstra wrote:
> > On Tue, Oct 01, 2024 at 05:30:18PM -0500, David Lechner wrote:
> > > Add a new if_not_cond_guard() macro to cleanup.h for handling
> > > conditional guards such as mutext_trylock().
> > > 
> > > This is more ergonomic than scoped_cond_guard() for most use cases.
> > > Instead of hiding the error handling statement in the macro args, it
> > > works like a normal if statement and allow the error path to be indented
> > > while the normal code flow path is not indented. And it avoid unwanted
> > > side-effect from hidden for loop in scoped_cond_guard().
> > > 
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >  include/linux/cleanup.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> [..]
> > I've queued these two patches:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > 
> > But lacking if_not_guard() users, the robot isn't really going to give
> > me much feedback there, I suppose...
> 
> Looks good. If that branch is rebase-able it would be nice to add some
> credit tags to "cleanup: Add conditional guard helper":
> 
> Co-developed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> 
> David and I talked about that here:
> 
> http://lore.kernel.org/f4cc471a-b602-48d8-8323-15efcd602814@baylibre.com
> 
> Also feel free to add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I rebased because I had to magic in the v4 from Przemek, and I added the
above tags to the if_not_guard() thing.

I've also pushed out a locking/test branch that includes the iio
conversion for the robots.

Once I push to tip/locking/core (people will get robot mail) the commits
should be stable and can be used in other branches if so desired.

