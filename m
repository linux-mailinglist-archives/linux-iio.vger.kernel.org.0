Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6336CA36
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbhD0RTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237495AbhD0RTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:19:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9386C60FF3;
        Tue, 27 Apr 2021 17:18:22 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:19:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] iio: core: move @clock_id from struct iio_dev to
 struct iio_dev_opaque
Message-ID: <20210427181907.614873e2@jic23-huawei>
In-Reply-To: <CA+U=DsrsFhH65HkdNSTFLXF3-rbpEYkZ5MvoXDmuSeniHampXA@mail.gmail.com>
References: <20210426174911.397061-1-jic23@kernel.org>
        <20210426174911.397061-10-jic23@kernel.org>
        <CA+U=DsrsFhH65HkdNSTFLXF3-rbpEYkZ5MvoXDmuSeniHampXA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 11:02:02 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There is already an acessor function used to access it, making this
> > move straight forward.  
> 
> Right now the iio_device_get_clock() helper is only being used in the
> Chrome EC core sensor driver.
> Maybe later if that can be reworked without this helper, then it could
> be made private to IIO core.
> Though, chances are some other driver may come along later and ask for
> it to be public again.

Agreed. My gut feeling is this will come up again (largely because some
idiot who will remain nameless picked a silly default clock many years
ago when he didn't know better).

Jonathan

> 
> Anyway.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c | 14 +++++++++++++-
> >  include/linux/iio/iio-opaque.h  |  2 ++
> >  include/linux/iio/iio.h         | 12 +-----------
> >  3 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 4a4c02fea152..efb4cf91c9e4 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -271,13 +271,25 @@ int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
> >                 mutex_unlock(&indio_dev->mlock);
> >                 return -EBUSY;
> >         }
> > -       indio_dev->clock_id = clock_id;
> > +       iio_dev_opaque->clock_id = clock_id;
> >         mutex_unlock(&indio_dev->mlock);
> >
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(iio_device_set_clock);
> >
> > +/**
> > + * iio_device_get_clock() - Retrieve current timestamping clock for the device
> > + * @indio_dev: IIO device structure containing the device
> > + */
> > +clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
> > +{
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +       return iio_dev_opaque->clock_id;
> > +}
> > +EXPORT_SYMBOL(iio_device_get_clock);
> > +
> >  /**
> >   * iio_get_time_ns() - utility function to get a time stamp for events etc
> >   * @indio_dev: device
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index d7c3036861ac..c9504e9da571 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -24,6 +24,7 @@
> >   * @legacy_scan_el_group:      attribute group for legacy scan elements attribute group
> >   * @legacy_buffer_group:       attribute group for legacy buffer attributes group
> >   * @scan_index_timestamp:      cache of the index to the timestamp
> > + * @clock_id:                  timestamping clock posix identifier
> >   * @chrdev:                    associated character device
> >   * @flags:                     file ops related flags including busy flag.
> >   * @debugfs_dentry:            device specific debugfs dentry
> > @@ -51,6 +52,7 @@ struct iio_dev_opaque {
> >         struct attribute_group          legacy_buffer_group;
> >
> >         unsigned int                    scan_index_timestamp;
> > +       clockid_t                       clock_id;
> >         struct cdev                     chrdev;
> >         unsigned long                   flags;
> >
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index ed0537015eee..5606a3f4c4cb 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -509,7 +509,6 @@ struct iio_buffer_setup_ops {
> >   * @name:              [DRIVER] name of the device.
> >   * @label:              [DRIVER] unique name to identify which device this is
> >   * @info:              [DRIVER] callbacks and constant info from driver
> > - * @clock_id:          [INTERN] timestamping clock posix identifier
> >   * @setup_ops:         [DRIVER] callbacks to call before and after buffer
> >   *                     enable/disable
> >   * @priv:              [DRIVER] reference to driver's private information
> > @@ -538,7 +537,6 @@ struct iio_dev {
> >         const char                      *name;
> >         const char                      *label;
> >         const struct iio_info           *info;
> > -       clockid_t                       clock_id;
> >         const struct iio_buffer_setup_ops       *setup_ops;
> >
> >         void                            *priv;
> > @@ -589,15 +587,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
> >                 put_device(&indio_dev->dev);
> >  }
> >
> > -/**
> > - * iio_device_get_clock() - Retrieve current timestamping clock for the device
> > - * @indio_dev: IIO device structure containing the device
> > - */
> > -static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
> > -{
> > -       return indio_dev->clock_id;
> > -}
> > -
> > +clockid_t iio_device_get_clock(const struct iio_dev *indio_dev);
> >  int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
> >
> >  /**
> > --
> > 2.31.1
> >  

