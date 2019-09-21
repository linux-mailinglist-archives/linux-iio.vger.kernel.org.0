Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E742B9F1F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfIURM7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 13:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfIURM6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 13:12:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900A520820;
        Sat, 21 Sep 2019 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085978;
        bh=imNIPRuqDRv+W+vL/c2C0ilGJvaFe6U2kD92EDWxUAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+TkyX5Go267+LYpS6aQ3f+TTSLgfIe32Q6Ba/WueGjpFWnY1tMSc4zk713gSJq2J
         aQaAlzSf/Fjzx1mY/KxUjiwxd67F31a714Mn+bgifvm+qw4D18lxEiWshAUAvpYt0e
         bzXznc5+PjhueKtkp0+nCfHSEi7Da++y0jlg/4dU=
Date:   Sat, 21 Sep 2019 18:12:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
Message-ID: <20190921181253.43fa0071@archlinux>
In-Reply-To: <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
        <20190912144310.7458-5-andrea.merello@gmail.com>
        <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
        <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
        <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
        <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 09:45:21 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno ven 13 set 2019 alle ore 13:30 Couret Charles-Antoine
> <charles-antoine.couret@essensium.com> ha scritto:
> 
> > >> One thing that maybe could be optimized (for the driver), is in `ad7949_spi_read_channel()` to use the current-channel &
> > >> not do a SPI write to change the channel if it doesn't change.
> > >>
> > >> Datasheets (in general) are not always obvious about describing chip behavior for SW (or for writing a driver), but I
> > >> would suspect that if you are reading garbage data, it could be that the channel has changed.
> > >> This is true for some other ADCs.
> > >> And requires testing for this one.  
> > > Yes, it's exactly what I've seen here. If the channel does not change
> > > then the AD is already in acquisition phase on the right channel (I
> > > assume it's OK to keep it in such phase indefinitely), then we can
> > > just trigger a new conversion (CNV low->high, that is a dummy xfer)
> > > and then read the result in following xfer, as the driver already did.
> > >
> > > I craft a V2 that performs the extra (3rd) spi xfer only if the
> > > channel has to change.  
> >
> > This design should be ok. I didn't implement in that way because not
> > enough time to optimize the driver before release (I don't have access
> > to the chip anymore) and for our workflow it was not relevant (we
> > scanned all channels).  
> 
> I was in the process of doing this, but, thinking again about it, I'm
> not completely sure it is really OK:
> Should we guarantee that the value we return as outcome of a IIO read
> request (i.e. we access in_voltage_raw) is sampled _after_ the user
> read request?
> 
> For example, the user might setup some other HW for the measure, or
> somehow wait for the right moment for doing the measure, and then
> perform the read from IIO, thus it's probably not OK if we convert a
> value sampled just before the IIO read request.

Absolutely.  MUX in front of the sensor is a fairly common thing to see.

> 
> If we skip the configuration rewrite when the channel doesn't change -
> as discussed above - then we actually _terminate_ the acquisition when
> the IIO read is triggered, that is we are converting the value sampled
> right before the IIO read.
> 
> If this is OK then I'll go on, otherwise I think that we should always
> do the three cycles (so that triggering IIO read always waits also for
> a new acquisition phase)
An excellent point.  I agree and suspect we may have this wrong in other
sensors.  The question gets more interesting if running in buffered mode
as we have had systems using a trigger generated by an external process.
I suppose in that case we just have to deal with the offset in the fifo
etc in userspace.

Maybe we should think about adding a note to be careful of that.  Not
really sure where we would note it though...

Thanks,

Jonathan


