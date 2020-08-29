Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12B25694F
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH2RSA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RSA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:18:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B4820707;
        Sat, 29 Aug 2020 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721479;
        bh=yLpc0Bq7J2kJf0h+UEQPJyey8SumotlKBh/LapBvpYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGmSJ59cXYPdz22vWtV+WQ26SjYKLY7rBhSiNCjMrOhwcSar98borkdNbN55aivzK
         WF3Mx4aL8jhIU+KtwA9zYRkW1wQYF6NAbsSIlFWBpJsMpQzJfDdig4gmLW5049R1TM
         ObIpu/HIYpzlxl5sS+nlU3sMXbUQIpM9xjPhKnBI=
Date:   Sat, 29 Aug 2020 18:17:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
Message-ID: <20200829181754.52d3cc3b@archlinux>
In-Reply-To: <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
        <20200829161230.398e0051@archlinux>
        <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Aug 2020 09:56:41 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Sat, Aug 29, 2020 at 8:12 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 28 Aug 2020 17:01:18 -0700
> > Douglas Anderson <dianders@chromium.org> wrote:
> >  
> > > On one board I found that:
> > >   probe of 5-0028 returned 1 after 259547 usecs
> > >
> > > There's no reason to block probe of all other devices on our probe.
> > > Turn on async probe.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > NOTE: I haven't done any analysis of the driver to see _why_ it's so
> > > slow, only that I have measured it to be slow.  Someone could
> > > certainly take the time to profile / optimize it, but in any case it
> > > still won't hurt to be async.  
> >
> > Hmm. It is vanishingly rare to use that flag  
> 
> My guess is that people just haven't been spending as much time
> optimizing boot performance recently.  I've been trying to do this and
> finding that there are quite a few drivers that could benefit from
> this flag.
> 
> In theory this flag should probably be on by default and it looks like
> that was Dmitry's original intention but the state of the world 5
> years ago was that it wasn't quite ready for this.  I think, in
> particular, drivers that are more core to the system (IOMMUs, clocks,
> regulators, etc) may not have been ready, but misc peripherals should
> be no problem.

That fits with my understanding.  Would be great to have it on
by default though I guess it could make for some really hard to debug
race conditions.


> 
> 
> > so I'm not particularly
> > keen on starting to deploy it when we don't know why a particular
> > driver is taking so long.  I agree it should be safe but I don't
> > like oddities I don't understand!
> >
> > There are some sleeps in there but they are all of the order of a few
> > msecs.
> >
> > Could it be there is a regulator that is coming up very slowly?
> >
> > Any other ideas?  
> 
> I can do a little bit of profiling next week, but even if we get this
> down from 250 ms to 10 ms I'd still like to see async probe turned on.
> There's no reason for it to be off and every little bit counts.
Agreed. However, I'd like a comment next to the place we turn it on
saying what delays we are trying to mitigate by enabling it in this
driver.

Jonathan

> 
> 
> > Jonathan
> >  
> > >
> > > This is a very safe flag to turn on since:
> > >
> > > 1. It's not like our probe order was defined by anything anyway.  When
> > > we probe is at the whim of when our i2c controller probes and that can
> > > be any time.
> > >
> > > 2. If some other driver needs us then they have to handle the fact
> > > that we might not have probed yet anyway.
> > >
> > > 3. There may be other drivers probing at the same time as us anyway
> > > because _they_ used async probe.
> > >
> > > While I won't say that it's impossible to tickle a bug by turning on
> > > async probe, I would assert that in almost all cases the bug was
> > > already there and needed to be fixed anyway.
> > >
> > > ALSO NOTE: measurement / testing was done on the downstream Chrome OS
> > > 5.4 tree.  I confirmed compiling on mainline.
> > >
> > >  drivers/iio/proximity/sx9310.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > > index dc2e11b43431..444cafc53408 100644
> > > --- a/drivers/iio/proximity/sx9310.c
> > > +++ b/drivers/iio/proximity/sx9310.c
> > > @@ -1054,6 +1054,7 @@ static struct i2c_driver sx9310_driver = {
> > >               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> > >               .of_match_table = of_match_ptr(sx9310_of_match),
> > >               .pm = &sx9310_pm_ops,
> > > +             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > >       },
> > >       .probe          = sx9310_probe,
> > >       .id_table       = sx9310_id,  
> >  

