Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070A4476C0F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhLPIiv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:38:51 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47355 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhLPIiv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:38:51 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 48171E0005;
        Thu, 16 Dec 2021 08:38:49 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:38:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 08/10] iio: core: Move iio_dev->currentmode to the
 opaque structure
Message-ID: <20211216093848.7b2f10af@xps13>
In-Reply-To: <CA+U=DsoMLD1EpK7yDXaQ_HwTQgm_TeZvM_eykE6jWYgg6P3Y7w@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-9-miquel.raynal@bootlin.com>
        <CA+U=DsoMLD1EpK7yDXaQ_HwTQgm_TeZvM_eykE6jWYgg6P3Y7w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:48:36 +0200:

> On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > This entry should, under no situation, be modified by device
> > drivers. Now that we have limited its read access to device drivers
> > really needing it, and handled modifications through another dedicated
> > helper within the core, we can easily move this variable to the opaque
> > structure as well as the write helper in order to prevent device driver
> > from playing with it.
> >  
> 
> Ah, the set-helper becomes inline.
> 
> The helpers make more sense now.
> 
> [ regardless of the naming of the helpers]
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Great! Thanks for the entire review and feedback!

> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/industrialio-core.c | 15 +++------------
> >  include/linux/iio/iio-opaque.h  | 16 ++++++++++++++++
> >  include/linux/iio/iio.h         |  5 -----
> >  3 files changed, 19 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 5c7e0c9e1f59..9836a57ff151 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2064,21 +2064,12 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> >   **/
> >  int iio_get_internal_mode(struct iio_dev *indio_dev)
> >  {
> > -       return indio_dev->currentmode;
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +       return iio_dev_opaque->currentmode;
> >  }
> >  EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> >
> > -/**
> > - * iio_set_internal_mode() - helper function providing write-only access to the
> > - *                          internal @currentmode variable
> > - * @indio_dev:         IIO device structure for device
> > - **/
> > -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> > -{
> > -       indio_dev->currentmode = mode;
> > -}
> > -EXPORT_SYMBOL_GPL(iio_set_internal_mode);
> > -
> >  subsys_initcall(iio_init);
> >  module_exit(iio_exit);
> >
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 2be12b7b5dc5..72f35270a387 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -7,6 +7,9 @@
> >   * struct iio_dev_opaque - industrial I/O device opaque information
> >   * @indio_dev:                 public industrial I/O device information
> >   * @id:                        used to identify device internally
> > + * @currentmode:               operating mode currently in use, may be eventually
> > + *                             checked by device drivers but should be considered
> > + *                             read-only as this is a core internal bit
> >   * @driver_module:             used to make it harder to undercut users
> >   * @info_exist_lock:           lock to prevent use during removal
> >   * @trig_readonly:             mark the current trigger immutable
> > @@ -36,6 +39,7 @@
> >   */
> >  struct iio_dev_opaque {
> >         struct iio_dev                  indio_dev;
> > +       int                             currentmode;
> >         int                             id;
> >         struct module                   *driver_module;
> >         struct mutex                    info_exist_lock;
> > @@ -71,4 +75,16 @@ struct iio_dev_opaque {
> >  #define to_iio_dev_opaque(_indio_dev)          \
> >         container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
> >
> > +/**
> > + * iio_set_internal_mode() - helper function providing write-only access to the
> > + *                          internal @currentmode variable
> > + * @indio_dev:         IIO device structure for device
> > + **/
> > +static inline void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> > +{
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +       iio_dev_opaque->currentmode = mode;
> > +}
> > +
> >  #endif
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 27551d251904..d04ab89fa0c2 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -492,9 +492,6 @@ struct iio_buffer_setup_ops {
> >   *                     registering the IIO device and can be filed up by the
> >   *                     IIO core depending on the features advertised by the
> >   *                     driver during other steps of the registration
> > - * @currentmode:       [INTERN] operating mode currently in use, may be
> > - *                     eventually checked by device drivers but should be
> > - *                     considered read-only as this is a core internal bit
> >   * @dev:               [DRIVER] device structure, should be assigned a parent
> >   *                     and owner
> >   * @buffer:            [DRIVER] any buffer present
> > @@ -521,7 +518,6 @@ struct iio_buffer_setup_ops {
> >   */
> >  struct iio_dev {
> >         int                             modes;
> > -       int                             currentmode;
> >         struct device                   dev;
> >
> >         struct iio_buffer               *buffer;
> > @@ -679,7 +675,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
> >                                            const char *fmt, ...);
> >
> >  int iio_get_internal_mode(struct iio_dev *indio_dev);
> > -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
> >
> >  /**
> >   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> > --
> > 2.27.0
> >  

Thanks,
Miquèl
