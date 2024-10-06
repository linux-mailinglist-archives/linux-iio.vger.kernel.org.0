Return-Path: <linux-iio+bounces-10229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3288991E24
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816201F21262
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3E15B12A;
	Sun,  6 Oct 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpOF+3ce"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A33749A;
	Sun,  6 Oct 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214523; cv=none; b=PVeurNNpvE6U2cQFT1mj02/HkK3euvkV7yRr9F7iAqVRKSq5Dtmrv2KE6Jh3E3hEbgFrZJwY5k+8tXvqR5EGqKB8HYX7XnlmJbv2cIsDNt6DosxSjmRHgE2LdlrjdG9ho5cdPsAB7XO1xepuyPgv7kezBbwGd1xOx3Lcd5eJIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214523; c=relaxed/simple;
	bh=vm8eY+BU311AHCaREAHligi98wJqXCCZCoNjq2NIjdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXSTUwxg8PWs4HQ0xz9LlkEuqhSxgDzS1BPf6TynWkRB8jFgjzLDG0yhSPx6qX8FC9Py3OlKHCcOOvfaVuD603keF1o4argGj/PHMhbcfU4ErKFKh1nmXdx54n2YBmNKhy1Y73T06tqg0RkgNdWFdwDgBYBXYl9UAYZXac6g5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpOF+3ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E4EC4CEC5;
	Sun,  6 Oct 2024 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728214522;
	bh=vm8eY+BU311AHCaREAHligi98wJqXCCZCoNjq2NIjdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OpOF+3cezH/oUNwE/hBTbRJka9sOhe8f1A3Q1t9JE2g1GbO75XjLcZoCFFvUTRr6y
	 VoxKyrLEphJpUTujQ2j4vlWV9HCz12kHAdgJYoD79GXWnxX1u8BePuTfZOp0/idhL7
	 mV3MXBiObS6Z4W71UB1E+NwG/HiCliEyCrdAMRXsEzI59BK7sWPhMHDHXuuzCd6euw
	 BeAz5Iu0eoPC5L95ksrzdg1HAS7gPIzyzfrx//ufpCxXs26U96av/Qm+6/glZxKgLi
	 9McA1Vjrm4PAdk8W2100rbf9h1mw2al+MUE+kJWs9LIaZVIBfQPB/1c+mDB3BKIORg
	 +mCmpHbhhBbvA==
Date: Sun, 6 Oct 2024 12:35:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
 <ira.weiny@intel.com>, "Fabio M. De Francesco"
 <fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH 0/3] cleanup: add if_not_cond_guard macro
Message-ID: <20241006123513.42b7d4ec@jic23-huawei>
In-Reply-To: <66fcac2dbde60_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
	<66fcac2dbde60_964f229426@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 19:13:01 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> David Lechner wrote:
> > So far, I have not found scoped_cond_guard() to be nice to work with.
> > We have been using it quite a bit in the IIO subsystem via the
> > iio_device_claim_direct_scoped() macro.
> > 
> > The main thing I don't like is that scoped_cond_guard() uses a for loop
> > internally. In the IIO subsystem, we usually try to return as early as
> > possible, so often we are returning from all paths from withing this
> > hidden for loop. However, since it is a for loop, the compiler thinks
> > that it possible to exit the for loop and so we end up having to use
> > unreachable() after the end of the scope to avoid a compiler warning.
> > This is illustrated in the ad7380 patch in this series and there are 36
> > more instance of unreachable() already introduced in the IIO subsystem
> > because of this.
> > 
> > Also, scoped_cond_guard() is they only macro for conditional guards in
> > cleanup.h currently. This means that so far, patches adopting this are
> > generally converting something that wasn't scoped to be scoped. This
> > results in changing the indentation of a lot of lines of code, which is
> > just noise in the patches.
> > 
> > To avoid these issues, the natural thing to do would be to have a
> > non-scoped version of the scoped_cond_guard() macro. There was was a
> > rejected attempt to do this in [1], where one of the complaints was:
> >   
> > > > -       rc = down_read_interruptible(&cxl_region_rwsem);
> > > > -       if (rc)
> > > > -               return rc;
> > > > +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);  
> > >
> > > Yeah, this is an example of how NOT to do things.
> > >
> > > If you can't make the syntax be something clean and sane like
> > >
> > >         if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
> > >                 return -EINTR;
> > >
> > > then this code should simply not be converted to guards AT ALL.  
> > 
> > [1]: https://lore.kernel.org/all/170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > I couldn't find a way to make a cond_guard() macro that would work like
> > exactly as suggested (the problem is that you can't declare a variable
> > in the condition expression of an if statement in C). So I am proposing
> > a macro that reads basically the same as the above so it still reads
> > almost like normal C code even though it hides the if statement a bit.
> > 
> >         if_not_cond_guard(rwsem_read_intr, &cxl_region_rwsem)
> >                 return -EINTR;
> > 
> > The "not" is baked into the macro because in most cases, failing to
> > obtain the lock is the abnormal condition and generally we want to have
> > the abnormal path be the indented one.  
> 
> I think you could also take the "cond" out of the name because that is
> implied by the fact it's an 'if'.
> 
> So, calling this "if_not_guard ()", for the series, you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...but it's ultimately up to Peter and Linus if they find this "if ()"
> rename acceptable. 

This is a nice improvement to my eyes anyway and I hope will be fine
with Linus and Peter.  Whilst I like the cond guard stuff for the
simplifications it has brought in the IIO code, it is clunky in
some cases as you've pointed out.

Thanks for driving this forwards.


> If it is I would suggest the style should be treat it
> as an "if ()" statement and add this to .clang-format:
> 
> diff --git a/.clang-format b/.clang-format
> index 252820d9c80a..ae3511a69896 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -63,6 +63,8 @@ DerivePointerAlignment: false
>  DisableFormat: false
>  ExperimentalAutoDetectBinPacking: false
>  FixNamespaceComments: false
> +IfMacros:
> +  - 'if_not_guard'
>  
>  # Taken from:
>  #   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \
> 
> 
> Last note, while the iio conversion looks correct to me, I would feel
> more comfortable if there was a way to have the compiler catch that
> plain "guard(iio_claim_direct)" usage is broken. Perhaps declaring
> iio_device_claim_direct_mode() as __must_check achieves that effect?

That would be good to catch. We've not had many missuses but there
have been one or two that have shown up in review.

Jonathan



