Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0650837FD05
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhEMR7p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhEMR7n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:59:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F93611CE;
        Thu, 13 May 2021 17:58:30 +0000 (UTC)
Date:   Thu, 13 May 2021 18:59:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/11] iio: chemical: atlas: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513185939.44e6ce6b@jic23-huawei>
In-Reply-To: <CAJCx=gnHaX2rWVm5WS9C5j0pSdioK344Ji+s39V8=SxLEL-+gw@mail.gmail.com>
References: <20210501171352.512953-1-jic23@kernel.org>
        <20210501171352.512953-6-jic23@kernel.org>
        <CAJCx=gnHaX2rWVm5WS9C5j0pSdioK344Ji+s39V8=SxLEL-+gw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 May 2021 23:44:54 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Variable location for the timestamp, so just use __aligned(8)
> > to ensure it is always possible to naturally align it.
> >
> > Found during an audit of all calls of uses of
> > iio_push_to_buffers_with_timestamp()
> >
> > Fixes tag is not accurate, but it will need manual backporting beyond
> > that point if anyone cares.
> >
> > Fixes: 0d15190f53b4 ("iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to have a go at breaking things.

Thanks,

Jonathan

> 
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 56ba6c82b501..6795722c68b2 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -91,8 +91,8 @@ struct atlas_data {
> >         struct regmap *regmap;
> >         struct irq_work work;
> >         unsigned int interrupt_enabled;
> > -
> > -       __be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
> > +       /* 96-bit data + 32-bit pad + 64-bit timestamp */
> > +       __be32 buffer[6] __aligned(8);
> >  };
> >
> >  static const struct regmap_config atlas_regmap_config = {
> > --
> > 2.31.1
> >  

