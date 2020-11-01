Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2927C2A2045
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 18:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgKARU4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 12:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKARUz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 12:20:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4EF2231B;
        Sun,  1 Nov 2020 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604251254;
        bh=I93y1z49Kk0Fd9T4szvukYN9LyWR1JVfBJJppslZeSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=veFbtSCJWH/yhIgPP3Mh+p6x/fX+IO09v0DA14w+51aQqv3oCEwNrbG7lSXRqh/zr
         n5JygDA71iEK8PmJqQdRNjI0OE/FjpIC1o8oBkeXzWp2B0w8r9Y9L+OEABGhaZd0Ko
         uOPGrYCrtPyKK54qDPvJDcEhCVG6DJYNERnE0a8E=
Date:   Sun, 1 Nov 2020 17:20:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201101172049.04bea85b@archlinux>
In-Reply-To: <20201031224735.atjih4opb6w57r6y@Rk>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
        <20201029144007.77d967b0@archlinux>
        <CAHp75Vc829u6XPPA+eE=_AFZSPF+yVqT7nUXxtzkwx7-xLLrCg@mail.gmail.com>
        <20201030143410.pbixjo2cllhd27zp@Rk>
        <20201031110511.515a2f0f@archlinux>
        <20201031224735.atjih4opb6w57r6y@Rk>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Nov 2020 06:47:35 +0800
Coiby Xu <coiby.xu@gmail.com> wrote:

> On Sat, Oct 31, 2020 at 11:05:11AM +0000, Jonathan Cameron wrote:
> >On Fri, 30 Oct 2020 22:34:10 +0800
> >Coiby Xu <coiby.xu@gmail.com> wrote:
> >  
> >> On Thu, Oct 29, 2020 at 07:06:40PM +0200, Andy Shevchenko wrote:  
> >> >On Thu, Oct 29, 2020 at 4:42 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> >> >> On Thu, 29 Oct 2020 15:48:56 +0800
> >> >> Coiby Xu <coiby.xu@gmail.com> wrote:  
> >> >  
> >> >> Please put a cover letter on your next series explaining the context.
> >> >> In this particular case some of the replies you have gotten are
> >> >> general at it is a lot easier to find these sorts of things via
> >> >> replying to the cover letter.  
> >> >
> >> >Looking at the number of duplicate messages I would suggest that one
> >> >needs to go through documentation on how to use git format-patch and
> >> >git send-email.
> >> >  
> >>
> >> Thank you for the suggestion! Actually it's a tree-wide change and it
> >> seems the kernel community prefer individual patches or series for
> >> subsystems having the same maintainer over a huge patch set so I wrote
> >> some scripts to automate the process. That's why you see ~50 emails
> >> with almost the same commit message. The only difference of these
> >> commit messages is the name of PM macro.  
> >
> >When doing a bit set like this, it's worth sending out a small subset
> >first to shake out issue like those seen here.
> >
> >Once those get merged then send out out the reset.
> >  
> Thank you for the suggestion! Actually I've held off another ~150
> emails and these ~200 emails were only part of work. I thought it's
> better to reach 4 or 5 subsystem to collect sufficient feedbacks
> considering some subsystems may respond slow. But I didn't realize a
> better way is to cut down the size of patch set sent to a subsystem.

Keep it sub 20 per subsystem and it shouldn't matter too much, but perhaps
always send to just one subsystem first as you may get very fast responses!

Then if it looks good after a few days, your approach of targeting a few
more subsystems would make sense.

Jonathan

> >Thanks,
> >
> >Jonathan
> >  
> >>  
> >> >--
> >> >With Best Regards,
> >> >Andy Shevchenko  
> >>
> >> --
> >> Best regards,
> >> Coiby  
> >  
> 
> --
> Best regards,
> Coiby

