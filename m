Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93FC476BBD
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhLPIST convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:18:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49125 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLPIST (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:18:19 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7B0B4E000D;
        Thu, 16 Dec 2021 08:18:17 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:18:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/10] iio: magnetometer: rm3100: Stop abusing the
 ->currentmode
Message-ID: <20211216091816.456acb9e@xps13>
In-Reply-To: <CA+U=DsrSBP4pd24jSjHg-F5ifQLjkmBPt6VJHDrr1c1f93s5_A@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-4-miquel.raynal@bootlin.com>
        <CA+U=DsrSBP4pd24jSjHg-F5ifQLjkmBPt6VJHDrr1c1f93s5_A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:40:12 +0200:

> On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > This is an internal variable for the core, here it is set to a "default"
> > value by the driver in order to later be able to perform checks against
> > it. None of this is needed because this check actually cares about the
> > buffers being enabled or not. So it is an unproper side-channel access
> > to the information "are the buffers enabled?", returned officially by
> > the iio_buffer_enabled() helper. Use this helper instead.  
> 
> A few comments inline.
> 
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/magnetometer/rm3100-core.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> > index 13914273c999..be0057f82218 100644
> > --- a/drivers/iio/magnetometer/rm3100-core.c
> > +++ b/drivers/iio/magnetometer/rm3100-core.c
> > @@ -141,18 +141,10 @@ static irqreturn_t rm3100_irq_handler(int irq, void *d)
> >         struct iio_dev *indio_dev = d;
> >         struct rm3100_data *data = iio_priv(indio_dev);
> >
> > -       switch (indio_dev->currentmode) {
> > -       case INDIO_DIRECT_MODE:
> > +       if (!iio_buffer_enabled(indio_dev))
> >                 complete(&data->measuring_done);
> > -               break;
> > -       case INDIO_BUFFER_TRIGGERED:  
> 
> This is one of those semantic changes that looks correct, but may end
> up getting comments that it should be validated by someone with
> hardware [and for good reason].
> Especially in places like Ref1 (below).

I think here we are pretty safe assuming that the change will not break
the driver because this is a construction that is very common in IIO
drivers.

Below, as stated in the cover letter, this is just my own
understanding and I'll happily drop the change if someone
thinks/observes this is unsafe.

> But I guess the iio_get_internal_mode() helper could still be used.
> I guess I'd wait for more opinions on this.
> 
> > +       else
> >                 iio_trigger_poll(data->drdy_trig);
> > -               break;
> > -       default:
> > -               dev_err(indio_dev->dev.parent,
> > -                       "device mode out of control, current mode: %d",
> > -                       indio_dev->currentmode);
> > -       }
> >
> >         return IRQ_WAKE_THREAD;
> >  }
> > @@ -377,7 +369,7 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
> >                         goto unlock_return;
> >         }
> >
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {  
> 
> Ref1
> 
> > +       if (iio_buffer_enabled(indio_dev)) {
> >                 /* Writing TMRC registers requires CMM reset. */
> >                 ret = regmap_write(regmap, RM3100_REG_CMM, 0);
> >                 if (ret < 0)
> > @@ -553,7 +545,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> >         indio_dev->channels = rm3100_channels;
> >         indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> >         indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> > -       indio_dev->currentmode = INDIO_DIRECT_MODE;  
> 
> This is fine :)
> 
> >
> >         if (!irq)
> >                 data->use_interrupt = false;
> > --
> > 2.27.0
> >  


Thanks,
Miquèl
