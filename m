Return-Path: <linux-iio+bounces-10721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12109A3D0F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D061F25AC6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 11:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312D2022CE;
	Fri, 18 Oct 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvsi4u95"
X-Original-To: linux-iio@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467352010E2;
	Fri, 18 Oct 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250111; cv=none; b=hCs6sY2dpekuRmrLyox2jbtxv7TYW76ba+j+yiTzs3rdEQ5m6D4PYqaS6N9mVbkIU9miqVZbnf16co57z9z3z9Rrn4XxHQJJo9vl8W85mdRVAWpxxt1CktfDfKvmgWWXO2jV8dxB+flnd9tNIDfDsdVbIKXc3BlCbdv/wW7dILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250111; c=relaxed/simple;
	bh=H9VbsKpLJ9wA5zYLB2VDqJsFVuIZuq/l/10T5Z+X44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJgI7RsGs3pplah16AmmRcy1rXQKq7iqiXpMsmPmWgi33X+jpD0LXGKsR3I75TBgZSNMfo2oxRy9VVVciLIaxRgiSOehpNVMmczAA782J+6N4EaDyEXp7boWq9SPDatgIt0C/mzPgx09g4ZkfyXxPSo/ZxqLhRE32DvafLY8isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvsi4u95; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxnHwneT1xAzY8649PF0fR25ciSRedSmGB++Tg52HxQ=; b=qvsi4u95S4N1NjtzPIjvcZ2+qm
	vBW/PJSzCycTBe78fX3bVZXJHNSLFGD9n/r27ucHtsexpYmbOVgkXupC8CpAvNstEDVG4XN3XrRxa
	yKqVGt4f1MSa5AaGqAnER4ZaGw/S+sC+Sv4wUFJDt1f8ToBX/3sW4KecfL59JI5S2v1mx9cnM3eyF
	Tv3cjcS+FkgvCcqL3Et9VsHMp6NPOJxW3Mg9O3VvfJ9jrX2PdNnqJNSVr66qokQjbVlQz7W24bvRu
	BH2IDoP6a6ANVG1dJVcxmVXNq/ZwgqeYa/8N0KTI5DHgHxURPrCx2QEBINLTWj3xbzJTiMfg4bDsu
	wEHSyRXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kwh-0000000D4SM-1VKa;
	Fri, 18 Oct 2024 11:15:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9B7A33005AF; Fri, 18 Oct 2024 13:15:03 +0200 (CEST)
Date: Fri, 18 Oct 2024 13:15:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-cxl@vger.kernel.org, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
Message-ID: <20241018111503.GC36494@noisy.programming.kicks-ass.net>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>

On Tue, Oct 01, 2024 at 05:30:18PM -0500, David Lechner wrote:
> Add a new if_not_cond_guard() macro to cleanup.h for handling
> conditional guards such as mutext_trylock().
> 
> This is more ergonomic than scoped_cond_guard() for most use cases.
> Instead of hiding the error handling statement in the macro args, it
> works like a normal if statement and allow the error path to be indented
> while the normal code flow path is not indented. And it avoid unwanted
> side-effect from hidden for loop in scoped_cond_guard().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  include/linux/cleanup.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 038b2d523bf8..682bb3fadfc9 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -273,6 +273,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *	an anonymous instance of the (guard) class, not recommended for
>   *	conditional locks.
>   *
> + * if_not_cond_guard(name, args...) { <error handling> }:
> + *	convenience macro for conditional guards that calls the statement that
> + *	follows only if the lock was not acquired (typically an error return).
> + *
>   * scoped_guard (name, args...) { }:
>   *	similar to CLASS(name, scope)(args), except the variable (with the
>   *	explicit name 'scope') is declard in a for-loop such that its scope is
> @@ -304,6 +308,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
>  
> +#define __if_not_cond_guard(_name, _id, args...)	\
> +	CLASS(_name, _id)(args);			\
> +	if (!__guard_ptr(_name)(&_id))
> +
> +#define if_not_cond_guard(_name, args...) \
> +	__if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
> +
>  #define scoped_guard(_name, args...)					\
>  	for (CLASS(_name, scope)(args),					\
>  	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)


So if I stick this on top of:

  https://lkml.kernel.org/r/20241011121535.28049-1-przemyslaw.kitszel@intel.com

then I can add the below:

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -277,6 +277,8 @@ static inline class_##_name##_t class_##
  *	convenience macro for conditional guards that calls the statement that
  *	follows only if the lock was not acquired (typically an error return).
  *
+ *	Only for conditional locks.
+ *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -290,7 +292,6 @@ static inline class_##_name##_t class_##
  *      acquire fails.
  *
  *	Only for conditional locks.
- *
  */
 
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
@@ -342,6 +343,7 @@ _label:										\
 		       __UNIQUE_ID(label), args)
 
 #define __if_not_guard(_name, _id, args...)		\
+	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
 	CLASS(_name, _id)(args);			\
 	if (!__guard_ptr(_name)(&_id))
 

That make sense to people?

I've queued these two patches:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

But lacking if_not_guard() users, the robot isn't really going to give
me much feedback there, I suppose...

