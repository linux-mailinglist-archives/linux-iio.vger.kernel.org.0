Return-Path: <linux-iio+bounces-10734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982C9A43D9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 18:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8DFB21650
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0E202656;
	Fri, 18 Oct 2024 16:29:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CD152E02;
	Fri, 18 Oct 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268998; cv=none; b=bY1MGXby/hYnqmuq5a4Y6tUH/5r17YFSrVmk7flILYYXMOUcHox1oP/k6YbPTFvUeUwfy+q/y5WL4zvJPM0i4UT0NDtqgIJdjs54MQIMzb7dfR1vCG+Nvq5AdO05nzaKqDLixH3tYoie49tY7XCH1vSSaQOR8ck4evM062GVS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268998; c=relaxed/simple;
	bh=FizASOhVozhFDyaimVemVEZSpNhdefrUQIWSJpxFtxc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwnCdEYxC7GMvn+qKN3MrfPda7FHmZb4dTWCPsQ8nl/dLEfeUmIfACNLx3SGCb51wc8YL0hFuNq0ag9aA761IxafoHFq8NHXfvAmIX8cAv3U+vnI5r1nez24QOF1tXnyueGNunXLv3CS+OWUGhYqTzOsHp40IMGmTd0Ad6sAmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVVRf6z8Xz6J86m;
	Sat, 19 Oct 2024 00:25:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 182441400F4;
	Sat, 19 Oct 2024 00:29:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 18:29:51 +0200
Date: Fri, 18 Oct 2024 17:29:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, David Lechner
	<dlechner@baylibre.com>, Dan Williams <dan.j.williams@intel.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael
 Hennerich <michael.hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
Message-ID: <20241018172949.00001a47@Huawei.com>
In-Reply-To: <26605fd6-0ed5-44f9-981e-d378a192bf0d@intel.com>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
	<20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
	<20241018111503.GC36494@noisy.programming.kicks-ass.net>
	<26605fd6-0ed5-44f9-981e-d378a192bf0d@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Oct 2024 14:31:43 +0200
Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:

> On 10/18/24 13:15, Peter Zijlstra wrote:
> > On Tue, Oct 01, 2024 at 05:30:18PM -0500, David Lechner wrote:  
> >> Add a new if_not_cond_guard() macro to cleanup.h for handling
> >> conditional guards such as mutext_trylock().
> >>
> >> This is more ergonomic than scoped_cond_guard() for most use cases.
> >> Instead of hiding the error handling statement in the macro args, it
> >> works like a normal if statement and allow the error path to be indented
> >> while the normal code flow path is not indented. And it avoid unwanted
> >> side-effect from hidden for loop in scoped_cond_guard().
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>  
> 
> So this is guard()() with error handler for cond class of locks.
> I would name such guard_or_err(), or guard_or_err_block(), to make it
> obvious why there is a block attached (so bad we could not ENFORCE that
> there is a block atached).
> 
> Then, having it, it would make sense to not only limit guard_or_err() to
> cond class of locks, but also forbid plain guard() with cond locks
> (instead just discouraging it in the doc).
> 
> >> ---
> >>   include/linux/cleanup.h | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> >> index 038b2d523bf8..682bb3fadfc9 100644
> >> --- a/include/linux/cleanup.h
> >> +++ b/include/linux/cleanup.h
> >> @@ -273,6 +273,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >>    *	an anonymous instance of the (guard) class, not recommended for
> >>    *	conditional locks.
> >>    *
> >> + * if_not_cond_guard(name, args...) { <error handling> }:
> >> + *	convenience macro for conditional guards that calls the statement that
> >> + *	follows only if the lock was not acquired (typically an error return).
> >> + *
> >>    * scoped_guard (name, args...) { }:
> >>    *	similar to CLASS(name, scope)(args), except the variable (with the
> >>    *	explicit name 'scope') is declard in a for-loop such that its scope is
> >> @@ -304,6 +308,13 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >>   
> >>   #define __guard_ptr(_name) class_##_name##_lock_ptr
> >>   
> >> +#define __if_not_cond_guard(_name, _id, args...)	\
> >> +	CLASS(_name, _id)(args);			\
> >> +	if (!__guard_ptr(_name)(&_id))
> >> +
> >> +#define if_not_cond_guard(_name, args...) \
> >> +	__if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
> >> +
> >>   #define scoped_guard(_name, args...)					\
> >>   	for (CLASS(_name, scope)(args),					\
> >>   	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)  
> > 
> > 
> > So if I stick this on top of:
> > 
> >    https://lkml.kernel.org/r/20241011121535.28049-1-przemyslaw.kitszel@intel.com  
> 
> I have v4 that fixes non-cond version. Apologies it took me that long.
> [v4] 
> https://lore.kernel.org/netdev/20241018113823.171256-1-przemyslaw.kitszel@intel.com
> 
> I have tested it also with the unrechable() calls removed, as suggested
> by David Lechner here:
> https://lore.kernel.org/netdev/0f4786e9-d738-435d-afb9-8c0c4a028ddb@baylibre.com
> 
> > 
> > then I can add the below:
> > 
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -277,6 +277,8 @@ static inline class_##_name##_t class_##
> >    *	convenience macro for conditional guards that calls the statement that
> >    *	follows only if the lock was not acquired (typically an error return).
> >    *
> > + *	Only for conditional locks.
> > + *
> >    * scoped_guard (name, args...) { }:
> >    *	similar to CLASS(name, scope)(args), except the variable (with the
> >    *	explicit name 'scope') is declard in a for-loop such that its scope is
> > @@ -290,7 +292,6 @@ static inline class_##_name##_t class_##
> >    *      acquire fails.
> >    *
> >    *	Only for conditional locks.
> > - *
> >    */
> >   
> >   #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
> > @@ -342,6 +343,7 @@ _label:										\
> >   		       __UNIQUE_ID(label), args)
> >   
> >   #define __if_not_guard(_name, _id, args...)		\
> > +	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
> >   	CLASS(_name, _id)(args);			\
> >   	if (!__guard_ptr(_name)(&_id))
> >   
> > 
> > That make sense to people?  
> 
> despite name, looks promising!
> 
> > 
> > I've queued these two patches:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > 
> > But lacking if_not_guard() users, the robot isn't really going to give
> > me much feedback there, I suppose...  
> 
> Couldn't you just pick the other patches, that use the newly introduced
> macro?

For a test, sure, but there is a lot of ad7380 work in flight and I'd rather
not push that back a cycle for this improvement (nice though it is!)

If it looks good, an immutable branch would be great, or I could just merge
from Peter's tree if that is stable.

Similarly there is a high risk of the CXL code changing for other reasons
this cycle, but same solution would work.

Jonathan




> 
> 
> 


