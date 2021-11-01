Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8623C4421C1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 21:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKAUkR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 1 Nov 2021 16:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKAUkQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Nov 2021 16:40:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F358461053;
        Mon,  1 Nov 2021 20:37:40 +0000 (UTC)
Date:   Mon, 1 Nov 2021 20:42:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/11] IIO: Bring core header includes up to date.
Message-ID: <20211101204212.0d1711b0@jic23-huawei>
In-Reply-To: <20211101093722.000011ba@Huawei.com>
References: <20211003153306.391766-1-jic23@kernel.org>
        <20211031170854.6990d79e@jic23-huawei>
        <20211031171206.75960513@jic23-huawei>
        <CAHp75Vc3m8+iFX+aufv6f79GcR+GCFSrmnb8R95fYHng=tGE8g@mail.gmail.com>
        <20211031205618.67cf9ffd@jic23-huawei>
        <20211101093722.000011ba@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


...

> > > > > Long term plan here is to bring consistency to includes with benefits
> > > > > of resilience and hopefully reducing just how much code is actually pulled
> > > > > in whilst compiling.      
> > > >
> > > > I forgot to mention that I've take a stricter view since doing this series
> > > > so it needs an update even in the tree above. This mostly affects
> > > > err.h, errno.h, stddef.h and types.h      
> > > 
> > > I don't think we need to include stddef.h to every C file, it should
> > > be guaranteed via something like types.h or so.    
> > 
> > There are places with stddef.h but not types.h required. I debated which
> > way to go on that and hence ended up with both for now, but it's obviously easy
> > to tweak.

Picking up on this particular example, I assumed it already would be included
in something that was pretty much always present (such as types.h) but it isn't...

So maybe I misinterpreted your comment and you are suggesting it would make
sense to include stddef.h in types.h?

Just looking at include/linux
we have about 49 instances of stddef.h being included, 91 of types.h but only
16 of both...

From the few I looked at I suspect main reason it's needed is for the
definition of NULL though lots of other headers are getting that indirectly.
Naturally this is one of the mega list in kernel.h but at least there is
no chance of a loop.

I'm open to suggestions on how to proceed.

Jonathan



> > 
> > It may be that long term we look to have a standard kernel iwyu mapping file.
> > It's possible to build in a fair bit of flexibility but maybe we'll need to
> > tweak the tool to allow us even more.
> > 
> > Jonathan
> > 
> >   
> > >     
> > > > I'll update those in that tree sometime this week.      
> > >     
> >   
> 

