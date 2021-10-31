Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0244410D8
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhJaUyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 16:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJaUyU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Oct 2021 16:54:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A464B60E98;
        Sun, 31 Oct 2021 20:51:47 +0000 (UTC)
Date:   Sun, 31 Oct 2021 20:56:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 00/11] IIO: Bring core header includes up to date.
Message-ID: <20211031205618.67cf9ffd@jic23-huawei>
In-Reply-To: <CAHp75Vc3m8+iFX+aufv6f79GcR+GCFSrmnb8R95fYHng=tGE8g@mail.gmail.com>
References: <20211003153306.391766-1-jic23@kernel.org>
        <20211031170854.6990d79e@jic23-huawei>
        <20211031171206.75960513@jic23-huawei>
        <CAHp75Vc3m8+iFX+aufv6f79GcR+GCFSrmnb8R95fYHng=tGE8g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 22:21:44 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Oct 31, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 31 Oct 2021 17:08:54 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Sun,  3 Oct 2021 16:32:55 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > Given ongoing churn in core kernel includes as Andy cleans them up, I've
> > > pushed this particular work out on a branch at
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=iio-iwyu-cleanups
> > >
> > > This will get me 0-day exposure and allow me to keep moving these
> > > forwards as the core kernel headers change.  
> 
> Thanks! I'm in favour of the work. Here are few things though:
> - blank line in between of the groups of headers (like before iio/*)

Ok. I was trying to leave style in keeping with what was there in drivers,
but fair enough can standardise on that.

> - fixing properly bitops.h and other typos (hope lkp will tell you about)

Huh. I'll watch out for that as getting clean builds...

> - thinking more about the list of very-low-level includes (see below)

Agreed.  I'm not sure on some of these - one of the big reasons this is a
work in progress.

> 
> On top of that, the main idea behind header usage is to make sure we
> have no circular and other hell dependencies in the *headers*, C-files
> can go with more relaxed rules (but again, I'm in favour of the series
> and effort).

Agreed, but added advantage of this tooling is identifying the entirely
pointless includes - of which there are lots.  Getting rid of those was
my main motivation in this.

Getting the balance right is going to be the trick and I'd rather a tool
that told us (more or less) that we have things correct than rely on 'common practice'.  

> 
> > > I would like to start merging 'some' of these in the meantime and
> > > there are some precursor cleanup patches that I'll pull out separately.
> > >
> > > Perhaps most 'useful' is the top patch in that branch which is the iwyu
> > > mapping file I've put together to get it to make more reasonable suggestions.
> > > Note that there are some cases where the answer isn't obvious and some
> > > where you can't push iwyu to do the right thing.
> > >
> > > One example is struct regmap which is deliberately opaque.
> > > iwyu always wants a forwards definition of it in all files where pointers
> > > to it occur, but personally I think including linux/regmap.h is sufficient
> > > as that will always have the forwards definition needed.
> > >
> > > Note this branch will rebase frequently and may well eat babies.
> > > In particularly I will be cherry picking Andy and anyone else's work
> > > to the top of it and making changes through the rest of the patches as
> > > that affects them.
> > >
> > > I'm not particularly expecting feedback, but I do want to avoid duplicate
> > > work.  I'm also likely to 'fixing' new code as it comes in based on this
> > > toolchain - I may main in reviews or just fix it whilst applying (and tell
> > > people obviously!)
> > >
> > > Long term plan here is to bring consistency to includes with benefits
> > > of resilience and hopefully reducing just how much code is actually pulled
> > > in whilst compiling.  
> >
> > I forgot to mention that I've take a stricter view since doing this series
> > so it needs an update even in the tree above. This mostly affects
> > err.h, errno.h, stddef.h and types.h  
> 
> I don't think we need to include stddef.h to every C file, it should
> be guaranteed via something like types.h or so.

There are places with stddef.h but not types.h required. I debated which
way to go on that and hence ended up with both for now, but it's obviously easy
to tweak.

It may be that long term we look to have a standard kernel iwyu mapping file.
It's possible to build in a fair bit of flexibility but maybe we'll need to
tweak the tool to allow us even more.

Jonathan


> 
> > I'll update those in that tree sometime this week.  
> 

