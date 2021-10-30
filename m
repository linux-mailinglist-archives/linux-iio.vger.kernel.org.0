Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2A4409C7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhJ3PCA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 11:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhJ3PCA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 11:02:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A890560F56;
        Sat, 30 Oct 2021 14:59:28 +0000 (UTC)
Date:   Sat, 30 Oct 2021 16:03:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: mma8452: Fix trigger reference couting
Message-ID: <20211030160357.6191e2a8@jic23-huawei>
In-Reply-To: <3bf78fdf-c6df-dd77-a1f1-61800c0ebe37@metafoo.de>
References: <20211024092700.6844-1-lars@metafoo.de>
        <20211028150731.753d4e40@jic23-huawei>
        <3bf78fdf-c6df-dd77-a1f1-61800c0ebe37@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 21:52:46 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/28/21 4:07 PM, Jonathan Cameron wrote:
> > On Sun, 24 Oct 2021 11:26:59 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> >> The mma8452 driver directly assigns a trigger to the struct iio_dev. The
> >> IIO core when done using this trigger will call `iio_trigger_put()` to drop
> >> the reference count by 1.
> >>
> >> Without the matching `iio_trigger_get()` in the driver the reference count
> >> can reach 0 too early, the trigger gets freed while still in use and a
> >> use-after-free occurs.
> >>
> >> Fix this by getting a reference to the trigger before assigning it to the
> >> IIO device.
> >>
> >> Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> > Gah. I thought we'd gotten all these years ago. I guess this one slipped through
> > the net.  
> Btw. we already have iio_trigger_set_immutable(), which handles the 
> reference counting. I was think of adding a iio(_device)_trigger_set() 
> that does the same except not setting the trig_readonly flag. And then 
> eventually move the trigger to iio_dev_opaque. Any concerns with this?

No concerns, seems like as sensible change given how things are evolving.
Obviously some other stuff that would need changing before we can
actually move trig.

One early step would be to modify iio_trigger_notify_done() to take
a struct iio_dev rather than a struct iio_trigger.  A job for a coccinelle
script I think!  That function name might need a rethink along with the
parameter change.

Hmm. Looks like we have a few drivers passing indio_dev->trig to iio_trigger_poll
as well which is a little odd.  mma8452 is one of them and it's not using
an immutable trigger or validate_trigger() so unexpected results if anyone
changes the trigger...  Possibly not fatal as the interrupt will probably
not occur but not correct either...

Jonathan
