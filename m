Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3B476C0E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhLPIiB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:38:01 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60171 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhLPIiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:38:00 -0500
X-Greylist: delayed 1326 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 03:38:00 EST
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DF97EFF807;
        Thu, 16 Dec 2021 08:37:58 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:37:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/10] iio: core: Hide read accesses to
 iio_dev->currentmode
Message-ID: <20211216093757.114f46cf@xps13>
In-Reply-To: <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-7-miquel.raynal@bootlin.com>
        <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:38:17 +0200:

> On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > In order to later move this variable within the opaque structure, let's
> > create a helper for accessing it in read-only mode. This helper will be
> > exposed and kept accessible for the few drivers that could need it. The
> > write access to this variable however should be fully reserved to the
> > core so in a second step we will add another helper, not exported to the
> > device drivers.  
> 
> The naming needs a bit of discussion.
> I would have gone for iio_dev_get_current_mode() or something like that.

I honestly tried both, but it appeared important to me to name it
"internal" so that people are not too tempted to use it in the first
place. Other advises are welcome, I an definitely switch to
iio_dev_get/set_current_mode() if it is preferred.

> And I would probably not use this helper inside the IIO core stuff
> (i.e. drivers/iio/industrialio-*.c files)
> Mostly because [if now used only in IIO core] it makes the
> "indio_dev->currentmode" assignment and access easier to trace.

I think you meant in a later review that this was fine given the fact
that a setter helper was also introduced. The goal behind using a
helper literally everywhere was to avoid introducing an indirect access
to the opaque structure everywhere, and do this final change almost
transparently for the users.

> There's also the change that accessing "indio_dev->currentmode"
> becomes a function-symbol which has rules at link-time and may add
> some new jmp/ret instructions.
> But It doesn't look like this is used in any fast-paths, so it's not
> an issue as much.

I was also tempted to do that in the first place but this does not work
anymore as soon as the variable is moved to the opaque structure (only
the setter, which is internal to the core, may end up in the
iio-opaque.h header). Otherwise we would end up exporting the opaque
header from iio.h which is truly not what we want.

> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c |  4 ++--
> >  drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
> >  drivers/iio/industrialio-buffer.c     |  6 +++---
> >  drivers/iio/industrialio-core.c       | 11 +++++++++++
> >  drivers/iio/industrialio-trigger.c    |  2 +-
> >  include/linux/iio/iio.h               |  9 ++++++---
> >  6 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index b0678c351e82..0a191463d462 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
> >         struct bmc150_accel_data *data = iio_priv(indio_dev);
> >         int ret = 0;
> >
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
> >                 return 0;
> >
> >         mutex_lock(&data->mutex);
> > @@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> >         struct bmc150_accel_data *data = iio_priv(indio_dev);
> >
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
> >                 return 0;
> >
> >         mutex_lock(&data->mutex);
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index 4c922ef634f8..2b7f6371950e 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -1117,7 +1117,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
> >                 return at91_adc_configure_touch(st, true);
> >
> >         /* if we are not in triggered mode, we cannot enable the buffer. */
> > -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
> >                 return -EINVAL;
> >
> >         /* we continue with the triggered buffer */
> > @@ -1159,7 +1159,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
> >                 return at91_adc_configure_touch(st, false);
> >
> >         /* if we are not in triggered mode, nothing to do here */
> > -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
> >                 return -EINVAL;
> >
> >         /*
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index e180728914c0..f4dbab7c44fa 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >                         goto err_disable_buffers;
> >         }
> >
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
> >                 ret = iio_trigger_attach_poll_func(indio_dev->trig,
> >                                                    indio_dev->pollfunc);
> >                 if (ret)
> > @@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >         return 0;
> >
> >  err_detach_pollfunc:
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
> >                 iio_trigger_detach_poll_func(indio_dev->trig,
> >                                              indio_dev->pollfunc);
> >         }
> > @@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
> >                         ret = ret2;
> >         }
> >
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
> >                 iio_trigger_detach_poll_func(indio_dev->trig,
> >                                              indio_dev->pollfunc);
> >         }
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 463a63d5bf56..a1d6e30d034a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2057,6 +2057,17 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> >
> > +/**
> > + * iio_get_internal_mode() - helper function providing read-only access to the
> > + *                          opaque @currentmode variable
> > + * @indio_dev:         IIO device structure for device
> > + **/
> > +int iio_get_internal_mode(struct iio_dev *indio_dev)
> > +{
> > +       return indio_dev->currentmode;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> > +
> >  subsys_initcall(iio_init);
> >  module_exit(iio_exit);
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index b23caa2f2aa1..71b07d6111d6 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -411,7 +411,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
> >         int ret;
> >
> >         mutex_lock(&indio_dev->mlock);
> > -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) == INDIO_BUFFER_TRIGGERED) {
> >                 mutex_unlock(&indio_dev->mlock);
> >                 return -EBUSY;
> >         }
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 0312da2e83f8..dcab17f44552 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -677,15 +677,18 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
> >  __printf(2, 3)
> >  struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
> >                                            const char *fmt, ...);
> > +
> > +int iio_get_internal_mode(struct iio_dev *indio_dev);
> > +
> >  /**
> >   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> >   * @indio_dev:         IIO device structure for device
> >   **/
> >  static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
> >  {
> > -       return indio_dev->currentmode
> > -               & (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > -                  INDIO_BUFFER_SOFTWARE);
> > +       return iio_get_internal_mode(indio_dev) &
> > +               (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > +                INDIO_BUFFER_SOFTWARE);
> >  }
> >
> >  /**
> > --
> > 2.27.0
> >  


Thanks,
Miquèl
