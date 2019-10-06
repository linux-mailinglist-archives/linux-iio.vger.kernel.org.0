Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174D0CD010
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJFJ1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJ1c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:27:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551D720700;
        Sun,  6 Oct 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570354051;
        bh=HqEXAYIgyXLmOdsdRNKQRbfLSC1uipoNQvtZW0Er9V0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BAO1KptAz7LThMOv5lrDT6f3ujq1VxfuvbJxSKFpu1nkt2Lx/lpF/iBkDHqIbJe5Q
         WOK1GRxkPMoUOOliHtaIsMjoCd7HHyhj9c1ePEoiHrmhgxLhrscnpy3BA2+H7KlI4l
         u96ypleyNdG05jlqmG0oNaVEfL+fS9+z2x/dB3mI=
Date:   Sun, 6 Oct 2019 10:27:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Message-ID: <20191006102727.6945a271@archlinux>
In-Reply-To: <CAJCx=g=y9xDHHZ06wjGNRVG0hLVSsWQZJJcPVTtAxmYVW8dwxw@mail.gmail.com>
References: <20190920073122.21713-1-alexandru.ardelean@analog.com>
        <CAJCx=g=y9xDHHZ06wjGNRVG0hLVSsWQZJJcPVTtAxmYVW8dwxw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Oct 2019 18:56:48 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Sep 20, 2019 at 12:31 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> >
> > The iio_triggered_buffer_predisable() should be called last, to detach the
> > poll func after the devices has been suspended.
> >
> > The position of iio_triggered_buffer_postenable() is correct.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> 
> Sorry didn't notice this till now. Looks good to me.
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> > index 3a20cb5d9bff..6c175eb1c7a7 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
> >         struct atlas_data *data = iio_priv(indio_dev);
> >         int ret;
> >
> > -       ret = iio_triggered_buffer_predisable(indio_dev);
> > +       ret = atlas_set_interrupt(data, false);
> >         if (ret)
> >                 return ret;
> >
> > -       ret = atlas_set_interrupt(data, false);
> > +       pm_runtime_mark_last_busy(&data->client->dev);
> > +       ret = pm_runtime_put_autosuspend(&data->client->dev);
> >         if (ret)
> >                 return ret;
> >
> > -       pm_runtime_mark_last_busy(&data->client->dev);
> > -       return pm_runtime_put_autosuspend(&data->client->dev);
> > +       return iio_triggered_buffer_predisable(indio_dev);
> >  }
> >
> >  static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
> > --
> > 2.20.1
> >  

