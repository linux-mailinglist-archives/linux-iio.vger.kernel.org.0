Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF937FD10
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhEMSEi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 14:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhEMSEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 14:04:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19036023E;
        Thu, 13 May 2021 18:03:26 +0000 (UTC)
Date:   Thu, 13 May 2021 19:04:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/11] iio: potentiostat: lmp91000: Fix alignment of
 buffer in iio_push_to_buffers_with_timestamp()
Message-ID: <20210513190435.5bf8a083@jic23-huawei>
In-Reply-To: <CAJCx=gkhT6Hw07n5nY6RGP5dk7kQeUanSib2gR9FQBEJaJD-yA@mail.gmail.com>
References: <20210501171352.512953-1-jic23@kernel.org>
        <20210501171352.512953-8-jic23@kernel.org>
        <CAJCx=gkhT6Hw07n5nY6RGP5dk7kQeUanSib2gR9FQBEJaJD-yA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 May 2021 23:44:23 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Add __aligned(8) to ensure the buffer passed to
> > iio_push_to_buffers_with_timestamp() is suitable for the naturally
> > aligned timestamp that will be inserted.
> >
> > Here structure is not used, because this buffer is also used
> > elsewhere in the driver.
> >
> > Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Thanks Matt.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can break it.

Jonathan
> 
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/potentiostat/lmp91000.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index 8a9c576616ee..ff39ba975da7 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -71,8 +71,8 @@ struct lmp91000_data {
> >
> >         struct completion completion;
> >         u8 chan_select;
> > -
> > -       u32 buffer[4]; /* 64-bit data + 64-bit timestamp */
> > +       /* 64-bit data + 64-bit naturally aligned timestamp */
> > +       u32 buffer[4] __aligned(8);
> >  };
> >
> >  static const struct iio_chan_spec lmp91000_channels[] = {
> > --
> > 2.31.1
> >  

