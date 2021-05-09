Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D43377608
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhEIJgA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 05:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 05:36:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6F1613E8;
        Sun,  9 May 2021 09:34:55 +0000 (UTC)
Date:   Sun, 9 May 2021 10:35:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alexandru.tachici@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] iio: adc: ad7124: Fixes and devm_ for all of probe
Message-ID: <20210509103556.424fb45b@jic23-huawei>
In-Reply-To: <CA+U=DspFU3gF+_EKDMnfNn7D+MX+0GcubOjf6uBcM2ekkQtWaA@mail.gmail.com>
References: <20210508182319.488551-1-jic23@kernel.org>
        <CA+U=DspFU3gF+_EKDMnfNn7D+MX+0GcubOjf6uBcM2ekkQtWaA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 May 2021 10:31:59 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 8, 2021 at 9:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I noticed an issue around regulator error handling and managed to
> > hit another with my hacked together test setup.  Hence let's fix
> > those two issues first then we might as well follow up by converting
> > the last few bits of this driver to use device managed functions so
> > we can simplify the error handling and cleanup.
> >
> > Testing conducted with QEMU hacking and insertion of errors at relevant
> > locations in the code.  
> 
> I guess the devm_ cleanup didn't catch-on much with others.
> It means I'll probably resume it :)

It's a fun one for when you have 20 mins left at the end of a day.

Though less fun when you then hit a random memory corruption bug and
loose an hour :(

Jonathan

> 
> >
> > Jonathan Cameron (3):
> >   iio: adc: ad7124: Fix missbalanced regulator enable / disable on
> >     error.
> >   iio: adc: ad7124: Fix potential overflow due to non sequential channel
> >     numbers
> >   iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
> >     remove()
> >
> >  drivers/iio/adc/ad7124.c | 89 ++++++++++++++++++++--------------------
> >  1 file changed, 44 insertions(+), 45 deletions(-)
> >
> > --
> > 2.31.1
> >  

