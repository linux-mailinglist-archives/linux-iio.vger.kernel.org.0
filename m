Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1876309C49
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhAaNBI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 31 Jan 2021 08:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhAaMi7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:38:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CCB64DDF;
        Sun, 31 Jan 2021 12:24:31 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:24:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: iio: move Peter Meerwald-Stadler to
 CREDITS
Message-ID: <20210131122428.03b53f34@archlinux>
In-Reply-To: <CAJCx=gmC1TcnbiBXqEZX0X=V3unHJdGmvD6jtMsJjxntk7bgVw@mail.gmail.com>
References: <20210125195654.580465-1-pmeerw@pmeerw.net>
        <CAJCx=gmC1TcnbiBXqEZX0X=V3unHJdGmvD6jtMsJjxntk7bgVw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Jan 2021 01:01:20 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, Jan 25, 2021 at 12:07 PM Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> >
> > Haven't had much time lately and moved on to different things.
> > Thanks Jonathan for the gentle introduction to Linux land.
> >  

You are most welcome.

Best wishes in the future and thanks for your help. There were times
when it was only yourself and a few others who kept my head above the water!

Applied.

Jonathan


> 
> Sorry to see you go. Cheers on future endeavors!
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
> 
> 
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > ---
> >  CREDITS     | 8 ++++++++
> >  MAINTAINERS | 1 -
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/CREDITS b/CREDITS
> > index 090ed4b004a5..9b4f2fc469e4 100644
> > --- a/CREDITS
> > +++ b/CREDITS
> > @@ -2524,6 +2524,14 @@ D: Linux/PARISC hacker
> >  D: AD1889 sound driver
> >  S: Ottawa, Canada
> >
> > +N: Peter Meerwald-Stadler
> > +E: pmeerw@pmeerw.net
> > +W: https://pmeerw.net
> > +D: IIO reviewing, drivers
> > +S: Schießstandstr. 3a
> > +S: A-5061 Elsbethen
> > +S: Austria
> > +
> >  N: Dirk Melchers
> >  E: dirk@merlin.nbg.sub.org
> >  D: 8 bit XT hard disk driver for OMTI5520
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 546aa66428c9..c29bd9b90ac2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8664,7 +8664,6 @@ F:        drivers/iio/multiplexer/iio-mux.c
> >  IIO SUBSYSTEM AND DRIVERS
> >  M:     Jonathan Cameron <jic23@kernel.org>
> >  R:     Lars-Peter Clausen <lars@metafoo.de>
> > -R:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> >  L:     linux-iio@vger.kernel.org
> >  S:     Maintained
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > --
> > 2.30.0
> >  

