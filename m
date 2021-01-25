Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A2302B9F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 20:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAYT31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 14:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbhAYT3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jan 2021 14:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 804EC21D79;
        Mon, 25 Jan 2021 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611602900;
        bh=6On6sfkiGo0BjdpSyslylTwlmNwbsH/AgnljyDfO1uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hK8doc1xMi+SLHQlsjEplwak91eoXAIZPbh8xVQS310QxdI2GjVdOw0WrCERovOM1
         OmS9IJFJbJEfzZWpPU/67naO0kOWsiqxfiUz9GNW5KHaM8uMyOYjL/f+RqTQubHUz+
         Mb/eg31FW1VdrfLlc+F9Jftb3O/GV/OWQF+fXpdY=
Date:   Mon, 25 Jan 2021 20:28:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
        dragos.bogdan@analog.com, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 03/12][RESEND] iio: buffer: rework buffer &
 scan_elements dir creation
Message-ID: <YA8b0az9c0Hha405@kroah.com>
References: <20210122162529.84978-1-alexandru.ardelean@analog.com>
 <20210122162529.84978-4-alexandru.ardelean@analog.com>
 <20210124181126.07c100a5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124181126.07c100a5@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 06:11:26PM +0000, Jonathan Cameron wrote:
> On Fri, 22 Jan 2021 18:25:20 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > When adding more than one IIO buffer per IIO device, we will need to create
> > a buffer & scan_elements directory for each buffer.
> > We also want to move the 'scan_elements' to be a sub-directory of the
> > 'buffer' folder.
> > 
> > The format we want to reach is, for a iio:device0 folder, for 2 buffers
> > [for example], we have a 'buffer0' and a 'buffer1' subfolder, and each with
> > it's own 'scan_elements' subfolder.
> > 
> > So, for example:
> >    iio:device0/buffer0
> >       scan_elements/
> > 
> >    iio:device0/buffer1
> >       scan_elements/
> > 
> > The other attributes under 'bufferX' would remain unchanged.
> > 
> > However, we would also need to symlink back to the old 'buffer' &
> > 'scan_elements' folders, to keep backwards compatibility.
> > 
> > Doing all these, require that we maintain the kobjects for each 'bufferX'
> > and 'scan_elements' so that we can symlink them back. We also need to
> > implement the sysfs_ops for these folders.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> +CC GregKH and Rafael W for feedback on various things inline.
> 
> It might be that this is the neatest solution that we can come up with but
> more eyes would be good!

In short, please do NOT do this.

At all.

no.

{sigh}

> 
> Whilst I think this looks fine, I'm less confident than I'd like to be.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/industrialio-buffer.c | 195 +++++++++++++++++++++++++++---
> >  drivers/iio/industrialio-core.c   |  24 ++--
> >  include/linux/iio/buffer_impl.h   |  14 ++-
> >  include/linux/iio/iio.h           |   2 +-
> >  4 files changed, 200 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 0412c4fda4c1..0f470d902790 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1175,8 +1175,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
> >  	return (ret < 0) ? ret : len;
> >  }
> >  
> > -static const char * const iio_scan_elements_group_name = "scan_elements";
> > -
> >  static ssize_t iio_buffer_show_watermark(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> > @@ -1252,6 +1250,124 @@ static struct attribute *iio_buffer_attrs[] = {
> >  	&dev_attr_data_available.attr,
> >  };
> >  
> > +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> > +
> > +static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
> > +					struct attribute *attr,
> > +					char *buf)
> > +{
> > +	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
> > +	struct device_attribute *dattr;
> > +
> > +	dattr = to_dev_attr(attr);
> > +
> > +	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
> > +}


First off, you are dealing with "raw" kobjects here, below a 'struct
device' in the device tree, which means that suddenly userspace does not
know what in the world is going on, and you lost events and lots of
other stuff.

Never do this.  It should not be needed, and you are just trying to
paper over one odd decision of an api with another one you will be stuck
with for forever.

Remember the driver core can create subdirectories for your attributes
automatically if you want them to be in a subdir, but that's it, no
further than that.  Just name the attribute group.

But yes, you can not create a symlink to there, because (surprise), you
don't want to!

So please, just rethink your naming, create a totally new naming scheme
for multiple entities, and just drop the old one (or keep a single
value if you really want to.)  Don't make it harder than it has to be
please, you can never remove the "compatible symlinks", just make a new
api and move on.

thanks,

greg k-h
