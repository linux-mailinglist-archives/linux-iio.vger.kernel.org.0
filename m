Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1257E303958
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbhAZJqw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbhAZJp4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 04:45:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70359C061573;
        Tue, 26 Jan 2021 01:45:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q129so32352057iod.0;
        Tue, 26 Jan 2021 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIW7mnwPUf6YWlYV9Dc8rQUYYrNuTxch5ZKKzYw0AFE=;
        b=ByfMfrJVJCKfp9k9KLuY9+zPDSK/oFPLxitqpAXbJiff4391iSWe8bKaYpGBbCmmvE
         FIyrmxZBTVaD2k5CbmUL7zZ898btlbJNEgMoRgegkdChxpRG0wHsfu+P1j+Xvk9nnHyD
         x/5TkGYudvDAChZjGnJXtjw1q2R5CB8MhAJtJUoaU2DvDlmWgqbJ3Hdn//kyJbj3JTrU
         eoaAyB08XmQ+F9wGYcs+tDXIbHAV95o7rM+y7DAztaGQ0U83UmbjTSn+AWLbCEI2CUOn
         fL21yhJXU7mRf8+Npa6Fd/e0B0JcBAWP1EetClFEvo5H0/nbc91eHMYHCXE0g3OjS1WV
         y3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIW7mnwPUf6YWlYV9Dc8rQUYYrNuTxch5ZKKzYw0AFE=;
        b=fi4Gsd1X1UnHzLEH4LduDZbTwYZwXnHrZh8luRFKorFaUFgP0kMHeeChC4OFZdFDyk
         6lUIwXfggD+3QfKSLpFJ56KLlULSc4RCDi/eNGwjTxJ1OrWA+L/RwP2Nl8Y9X4pahwTk
         HnvJcuZyoLHDipQJYo9Jw7CtUivPcNO2y1mZNL0c0w4jR/pAJHSZdPKGgMEuZb3VgdKG
         8X9mpgP4JfSCsdN6lCWoXrRsp4TkZstHeWpgKeiXgb3PDeAQKRloDIJ1vQkSHBNYrzlB
         ABMKwV6T1hQIpNL5sADfqN3fh8ukHAChy6+X9pjzfdLJLmZYDFb5liZxGeWIAdBCSBWO
         rZhA==
X-Gm-Message-State: AOAM5314U4v/PnUdnfueKPkmCtx0kXlKWXRLZ7PbVlnRLs9ZjEFDDHW5
        NnxRLQwaDX13zmcYhze2RHlDUZApD756AhkdPkw=
X-Google-Smtp-Source: ABdhPJyuTTVkkTksmE/DzwuiRARXE9iUtKPzZJoMvirmHVYMYFMkCjf7EuwR1M8S0b8H68CNmqnHUn+oa+2RK/ndoqk=
X-Received: by 2002:a02:7fc5:: with SMTP id r188mr4063015jac.69.1611654315745;
 Tue, 26 Jan 2021 01:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
 <20210122162529.84978-4-alexandru.ardelean@analog.com> <20210124181126.07c100a5@archlinux>
 <YA8b0az9c0Hha405@kroah.com>
In-Reply-To: <YA8b0az9c0Hha405@kroah.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 26 Jan 2021 11:45:04 +0200
Message-ID: <CA+U=DsoogP2Bj5zsE-1BwOhZy20jjvEhgh780FSiQU4M9AwoxA@mail.gmail.com>
Subject: Re: [PATCH v2 03/12][RESEND] iio: buffer: rework buffer &
 scan_elements dir creation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 25, 2021 at 9:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 24, 2021 at 06:11:26PM +0000, Jonathan Cameron wrote:
> > On Fri, 22 Jan 2021 18:25:20 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >
> > > When adding more than one IIO buffer per IIO device, we will need to create
> > > a buffer & scan_elements directory for each buffer.
> > > We also want to move the 'scan_elements' to be a sub-directory of the
> > > 'buffer' folder.
> > >
> > > The format we want to reach is, for a iio:device0 folder, for 2 buffers
> > > [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> > > it's own 'scan_elements' subfolder.
> > >
> > > So, for example:
> > >    iio:device0/buffer0
> > >       scan_elements/
> > >
> > >    iio:device0/buffer1
> > >       scan_elements/
> > >
> > > The other attributes under 'bufferX' would remain unchanged.
> > >
> > > However, we would also need to symlink back to the old 'buffer' &
> > > 'scan_elements' folders, to keep backwards compatibility.
> > >
> > > Doing all these, require that we maintain the kobjects for each 'bufferX'
> > > and 'scan_elements' so that we can symlink them back. We also need to
> > > implement the sysfs_ops for these folders.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > +CC GregKH and Rafael W for feedback on various things inline.
> >
> > It might be that this is the neatest solution that we can come up with but
> > more eyes would be good!
>
> In short, please do NOT do this.
>
> At all.
>
> no.
>
> {sigh}
>
> >
> > Whilst I think this looks fine, I'm less confident than I'd like to be.
> >
> > Jonathan
> >
> > > ---
> > >  drivers/iio/industrialio-buffer.c | 195 +++++++++++++++++++++++++++---
> > >  drivers/iio/industrialio-core.c   |  24 ++--
> > >  include/linux/iio/buffer_impl.h   |  14 ++-
> > >  include/linux/iio/iio.h           |   2 +-
> > >  4 files changed, 200 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > index 0412c4fda4c1..0f470d902790 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> > >     return (ret < 0) ? ret : len;
> > >  }
> > >
> > > -static const char * const iio_scan_elements_group_name = "scan_elements";
> > > -
> > >  static ssize_t iio_buffer_show_watermark(struct device *dev,
> > >                                      struct device_attribute *attr,
> > >                                      char *buf)
> > > @@ -1252,6 +1250,124 @@ static struct attribute *iio_buffer_attrs[] = {
> > >     &dev_attr_data_available.attr,
> > >  };
> > >
> > > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > > +
> > > +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> > > +                                   struct attribute *attr,
> > > +                                   char *buf)
> > > +{
> > > +   struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > > +   struct device_attribute *dattr;
> > > +
> > > +   dattr = to_dev_attr(attr);
> > > +
> > > +   return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > > +}
>
>
> First off, you are dealing with "raw" kobjects here, below a 'struct
> device' in the device tree, which means that suddenly userspace does not
> know what in the world is going on, and you lost events and lots of
> other stuff.
>
> Never do this.  It should not be needed, and you are just trying to
> paper over one odd decision of an api with another one you will be stuck
> with for forever.
>
> Remember the driver core can create subdirectories for your attributes
> automatically if you want them to be in a subdir, but that's it, no
> further than that.  Just name the attribute group.
>
> But yes, you can not create a symlink to there, because (surprise), you
> don't want to!
>
> So please, just rethink your naming, create a totally new naming scheme
> for multiple entities, and just drop the old one (or keep a single
> value if you really want to.)  Don't make it harder than it has to be
> please, you can never remove the "compatible symlinks", just make a new
> api and move on.


So, coming back to Jonathan.
Any thoughts on how to proceed?

We could merge the files 'buffer & scan_elements' [from in the
/sys/bus/iio/devices/iio:deviceX/{buffer,scan_elements}

So, essentially:
# ls /sys/bus/iio/devices/iio:deviceX/bufferY
data_available       length              watermark
enable                   length_align_bytes
in_voltage0_en      in_voltage0_type   in_voltage1_index
in_voltage0_index  in_voltage1_en     in_voltage1_type

Where:
# ls  /sys/bus/iio/devices/iio:deviceX/scan_elements
in_voltage0_en     in_voltage0_type   in_voltage1_index
in_voltage0_index  in_voltage1_en     in_voltage1_typ

# ls  /sys/bus/iio/devices/iio:deviceX/buffer
data_available      length              watermark
enable              length_align_bytes

I don't think we need to add any prefixes for the scan_elements/buffer
files, or?

Do we still do this new ioctl() for buffer0, 1, 2, N being accessed
via anon inodes?
Or do we go [back] via the route of each buffer with it's own chardev?
i.e.  introduce a "/dev/iio/deviceX/bufferY" structure

I'm fine either way.

Thanks
Alex

>
> thanks,
>
> greg k-h
