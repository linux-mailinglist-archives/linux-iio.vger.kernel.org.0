Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965E305EA6
	for <lists+linux-iio@lfdr.de>; Wed, 27 Jan 2021 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhA0Our (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Jan 2021 09:50:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2440 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhA0Oto (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2021 09:49:44 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DQmcQ1pS3z67bqV;
        Wed, 27 Jan 2021 22:45:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 15:49:02 +0100
Received: from localhost (10.47.72.68) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 27 Jan
 2021 14:49:01 +0000
Date:   Wed, 27 Jan 2021 14:48:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 03/12][RESEND] iio: buffer: rework buffer &
 scan_elements dir creation
Message-ID: <20210127144818.00002d85@Huawei.com>
In-Reply-To: <CA+U=DsoogP2Bj5zsE-1BwOhZy20jjvEhgh780FSiQU4M9AwoxA@mail.gmail.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
        <20210122162529.84978-4-alexandru.ardelean@analog.com>
        <20210124181126.07c100a5@archlinux>
        <YA8b0az9c0Hha405@kroah.com>
        <CA+U=DsoogP2Bj5zsE-1BwOhZy20jjvEhgh780FSiQU4M9AwoxA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.72.68]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Jan 2021 11:45:04 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Jan 25, 2021 at 9:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jan 24, 2021 at 06:11:26PM +0000, Jonathan Cameron wrote:  
> > > On Fri, 22 Jan 2021 18:25:20 +0200
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >  
> > > > When adding more than one IIO buffer per IIO device, we will need to create
> > > > a buffer & scan_elements directory for each buffer.
> > > > We also want to move the 'scan_elements' to be a sub-directory of the
> > > > 'buffer' folder.
> > > >
> > > > The format we want to reach is, for a iio:device0 folder, for 2 buffers
> > > > [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> > > > it's own 'scan_elements' subfolder.
> > > >
> > > > So, for example:
> > > >    iio:device0/buffer0
> > > >       scan_elements/
> > > >
> > > >    iio:device0/buffer1
> > > >       scan_elements/
> > > >
> > > > The other attributes under 'bufferX' would remain unchanged.
> > > >
> > > > However, we would also need to symlink back to the old 'buffer' &
> > > > 'scan_elements' folders, to keep backwards compatibility.
> > > >
> > > > Doing all these, require that we maintain the kobjects for each 'bufferX'
> > > > and 'scan_elements' so that we can symlink them back. We also need to
> > > > implement the sysfs_ops for these folders.
> > > >
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > >
> > > +CC GregKH and Rafael W for feedback on various things inline.
> > >
> > > It might be that this is the neatest solution that we can come up with but
> > > more eyes would be good!  
> >
> > In short, please do NOT do this.
> >
> > At all.
> >
> > no.
> >
> > {sigh}
> >  
> > >
> > > Whilst I think this looks fine, I'm less confident than I'd like to be.
> > >
> > > Jonathan
> > >  
> > > > ---
> > > >  drivers/iio/industrialio-buffer.c | 195 +++++++++++++++++++++++++++---
> > > >  drivers/iio/industrialio-core.c   |  24 ++--
> > > >  include/linux/iio/buffer_impl.h   |  14 ++-
> > > >  include/linux/iio/iio.h           |   2 +-
> > > >  4 files changed, 200 insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > > index 0412c4fda4c1..0f470d902790 100644
> > > > --- a/drivers/iio/industrialio-buffer.c
> > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> > > >     return (ret < 0) ? ret : len;
> > > >  }
> > > >
> > > > -static const char * const iio_scan_elements_group_name = "scan_elements";
> > > > -
> > > >  static ssize_t iio_buffer_show_watermark(struct device *dev,
> > > >                                      struct device_attribute *attr,
> > > >                                      char *buf)
> > > > @@ -1252,6 +1250,124 @@ static struct attribute *iio_buffer_attrs[] = {
> > > >     &dev_attr_data_available.attr,
> > > >  };
> > > >
> > > > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > > > +
> > > > +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> > > > +                                   struct attribute *attr,
> > > > +                                   char *buf)
> > > > +{
> > > > +   struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > > > +   struct device_attribute *dattr;
> > > > +
> > > > +   dattr = to_dev_attr(attr);
> > > > +
> > > > +   return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > > > +}  
> >
> >
> > First off, you are dealing with "raw" kobjects here, below a 'struct
> > device' in the device tree, which means that suddenly userspace does not
> > know what in the world is going on, and you lost events and lots of
> > other stuff.
> >
> > Never do this.  It should not be needed, and you are just trying to
> > paper over one odd decision of an api with another one you will be stuck
> > with for forever.
> >
> > Remember the driver core can create subdirectories for your attributes
> > automatically if you want them to be in a subdir, but that's it, no
> > further than that.  Just name the attribute group.
> >
> > But yes, you can not create a symlink to there, because (surprise), you
> > don't want to!
> >
> > So please, just rethink your naming, create a totally new naming scheme
> > for multiple entities, and just drop the old one (or keep a single
> > value if you really want to.)  Don't make it harder than it has to be
> > please, you can never remove the "compatible symlinks", just make a new
> > api and move on.  

Thanks Greg. I had a feeling we were pushing things too far in an
ugly direction :(

> 
> 
> So, coming back to Jonathan.
> Any thoughts on how to proceed?
> 
> We could merge the files 'buffer & scan_elements' [from in the
> /sys/bus/iio/devices/iio:deviceX/{buffer,scan_elements}
> 
> So, essentially:
> # ls /sys/bus/iio/devices/iio:deviceX/bufferY
> data_available       length              watermark
> enable                   length_align_bytes
> in_voltage0_en      in_voltage0_type   in_voltage1_index
> in_voltage0_index  in_voltage1_en     in_voltage1_type
> 
> Where:
> # ls  /sys/bus/iio/devices/iio:deviceX/scan_elements
> in_voltage0_en     in_voltage0_type   in_voltage1_index
> in_voltage0_index  in_voltage1_en     in_voltage1_typ
> 
> # ls  /sys/bus/iio/devices/iio:deviceX/buffer
> data_available      length              watermark
> enable              length_align_bytes
> 
> I don't think we need to add any prefixes for the scan_elements/buffer
> files, or?

Hmm. I guess this works. The only alternative I can think of would
be bufferY and bufferY_scan_elements directories, but that is probably
worse than what you suggest.

I'm not keen on the lost of grouping between of scan elements but it
may just be a price we have to pay.  Probably not too bad as only
in_ elements (_out shortly I guess) exist in scan_elements.

To maintain backwards compatibility we'll need to also register the
old attributes, but that shouldn't be too painful beyond a bunch
of near duplicated code.

> 
> Do we still do this new ioctl() for buffer0, 1, 2, N being accessed
> via anon inodes?
> Or do we go [back] via the route of each buffer with it's own chardev?
> i.e.  introduce a "/dev/iio/deviceX/bufferY" structure
> 

Reality is most of our devices are going to remain single buffered, so
whilst I'm not overly keen on proliferation of chardevs the cost should
be fairly small.

For separate chardevs what would the naming in /dev/ look like?
Gut feeling is stay with the anon approach, at least partly for
consistency with the event interface.

Jonathan


> I'm fine either way.
> 
> Thanks
> Alex
> 
> >
> > thanks,
> >
> > greg k-h  

