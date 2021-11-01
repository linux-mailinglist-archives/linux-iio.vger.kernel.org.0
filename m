Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDA4417FA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhKAJmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 05:42:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4044 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhKAJkB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 05:40:01 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HjSWJ1kTyz67tX9;
        Mon,  1 Nov 2021 17:33:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 10:37:23 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 09:37:23 +0000
Date:   Mon, 1 Nov 2021 09:37:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/11] IIO: Bring core header includes up to date.
Message-ID: <20211101093722.000011ba@Huawei.com>
In-Reply-To: <20211031205618.67cf9ffd@jic23-huawei>
References: <20211003153306.391766-1-jic23@kernel.org>
        <20211031170854.6990d79e@jic23-huawei>
        <20211031171206.75960513@jic23-huawei>
        <CAHp75Vc3m8+iFX+aufv6f79GcR+GCFSrmnb8R95fYHng=tGE8g@mail.gmail.com>
        <20211031205618.67cf9ffd@jic23-huawei>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 20:56:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 31 Oct 2021 22:21:44 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sun, Oct 31, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Sun, 31 Oct 2021 17:08:54 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:    
> > > > On Sun,  3 Oct 2021 16:32:55 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:    
> > 
> > ...
> >   
> > > > Given ongoing churn in core kernel includes as Andy cleans them up, I've
> > > > pushed this particular work out on a branch at
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=iio-iwyu-cleanups
> > > >
> > > > This will get me 0-day exposure and allow me to keep moving these
> > > > forwards as the core kernel headers change.    
> > 
> > Thanks! I'm in favour of the work. Here are few things though:
> > - blank line in between of the groups of headers (like before iio/*)  
> 
> Ok. I was trying to leave style in keeping with what was there in drivers,
> but fair enough can standardise on that.
> 
> > - fixing properly bitops.h and other typos (hope lkp will tell you about)  
> 
> Huh. I'll watch out for that as getting clean builds...
Or not ;)  Seems I did the normal stupid thing of adding just one more tweak
and forgot to build before pushing out.

Indeed, the build bot did it's job perfectly!

Jonathan

> 
> > - thinking more about the list of very-low-level includes (see below)  
> 
> Agreed.  I'm not sure on some of these - one of the big reasons this is a
> work in progress.
> 
> > 
> > On top of that, the main idea behind header usage is to make sure we
> > have no circular and other hell dependencies in the *headers*, C-files
> > can go with more relaxed rules (but again, I'm in favour of the series
> > and effort).  
> 
> Agreed, but added advantage of this tooling is identifying the entirely
> pointless includes - of which there are lots.  Getting rid of those was
> my main motivation in this.
> 
> Getting the balance right is going to be the trick and I'd rather a tool
> that told us (more or less) that we have things correct than rely on 'common practice'.  
> 
> >   
> > > > I would like to start merging 'some' of these in the meantime and
> > > > there are some precursor cleanup patches that I'll pull out separately.
> > > >
> > > > Perhaps most 'useful' is the top patch in that branch which is the iwyu
> > > > mapping file I've put together to get it to make more reasonable suggestions.
> > > > Note that there are some cases where the answer isn't obvious and some
> > > > where you can't push iwyu to do the right thing.
> > > >
> > > > One example is struct regmap which is deliberately opaque.
> > > > iwyu always wants a forwards definition of it in all files where pointers
> > > > to it occur, but personally I think including linux/regmap.h is sufficient
> > > > as that will always have the forwards definition needed.
> > > >
> > > > Note this branch will rebase frequently and may well eat babies.
> > > > In particularly I will be cherry picking Andy and anyone else's work
> > > > to the top of it and making changes through the rest of the patches as
> > > > that affects them.
> > > >
> > > > I'm not particularly expecting feedback, but I do want to avoid duplicate
> > > > work.  I'm also likely to 'fixing' new code as it comes in based on this
> > > > toolchain - I may main in reviews or just fix it whilst applying (and tell
> > > > people obviously!)
> > > >
> > > > Long term plan here is to bring consistency to includes with benefits
> > > > of resilience and hopefully reducing just how much code is actually pulled
> > > > in whilst compiling.    
> > >
> > > I forgot to mention that I've take a stricter view since doing this series
> > > so it needs an update even in the tree above. This mostly affects
> > > err.h, errno.h, stddef.h and types.h    
> > 
> > I don't think we need to include stddef.h to every C file, it should
> > be guaranteed via something like types.h or so.  
> 
> There are places with stddef.h but not types.h required. I debated which
> way to go on that and hence ended up with both for now, but it's obviously easy
> to tweak.
> 
> It may be that long term we look to have a standard kernel iwyu mapping file.
> It's possible to build in a fair bit of flexibility but maybe we'll need to
> tweak the tool to allow us even more.
> 
> Jonathan
> 
> 
> >   
> > > I'll update those in that tree sometime this week.    
> >   
> 

