Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4625EEED
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIFPxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgIFPxf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:53:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DCF20708;
        Sun,  6 Sep 2020 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599407613;
        bh=yOBRKzMg0VJttwyLuKHk+6BAt+E/89oYR/Q08GXaNSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KScde9m8omA0bQe1jtjz9G5Nubv80MZrXM3LO8PRi8Id30GBn3nQpnZQ+n4nMKDyD
         dMuvbjz301iJW4ItiK/44a92ZBfGfsgg6xaAe5/o80Yh7MlhgX7tlpZQST9P2/R+dE
         olgqkG3XxxnOKVuHk9LDGtKw1wYPdBLo0ZIbivJg=
Date:   Sun, 6 Sep 2020 16:53:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pop, Cristian" <Cristian.Pop@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to a
 device channel
Message-ID: <20200906165329.150cc055@archlinux>
In-Reply-To: <BN6PR03MB251405FC8654C3539D7BD9C1E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
References: <20200824083646.84886-1-cristian.pop@analog.com>
        <20200830122425.3e00332b@archlinux>
        <BN6PR03MB2514AE2330F47235028B4455E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
        <BN6PR03MB251405FC8654C3539D7BD9C1E72D0@BN6PR03MB2514.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Sep 2020 13:35:12 +0000
"Pop, Cristian" <Cristian.Pop@analog.com> wrote:

> > -----Original Message-----
> > From: Pop, Cristian
> > Sent: Friday, September 4, 2020 2:14 PM
> > To: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [RFC PATCH v2] iio: core: Add optional symbolic label to a device
> > channel

Hi Cristian,

If possible fix your word wrapping for future replies.
I've tried to unwind it below but it makes it very hard
to read and reply to.

> > 
> > Best ragards,
> > Cristian Pop
> >   
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, August 30, 2020 2:24 PM
> > > To: Pop, Cristian <Cristian.Pop@analog.com>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH v2] iio: core: Add optional symbolic label to
> > > a device channel
> > >
> > > [External]
> > >
> > > On Mon, 24 Aug 2020 11:36:46 +0300
> > > Cristian Pop <cristian.pop@analog.com> wrote:
> > >  
> > > > If a label is defined in the device tree for this channel add that
> > > > to the channel specific attributes. This is useful for userspace to
> > > > be able to identify an individual channel.
> > > >
> > > > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > > > ---
> > > >  Changes in v2:
> > > > 	- Move label check before "read_raw" callback.
> > > > 	- Move the responsability to of parsing channel labels, to the
> > > > 	  driver.
> > > >
> > > >  drivers/iio/industrialio-core.c | 10 ++++++++--
> > > >  include/linux/iio/iio.h         |  2 ++
> > > >  include/linux/iio/types.h       |  1 +
> > > >  3 files changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-core.c
> > > > b/drivers/iio/industrialio-core.c index 1527f01a44f1..32277e94f02d
> > > > 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -135,6 +135,7 @@ static const char * const iio_modifier_names[] =
> > > > {
> > > >  /* relies on pairs of these shared then separate */  static const
> > > > char * const iio_chan_info_postfix[] = {
> > > >  	[IIO_CHAN_INFO_RAW] = "raw",
> > > > +	[IIO_CHAN_INFO_LABEL] = "label",
> > > >  	[IIO_CHAN_INFO_PROCESSED] = "input",
> > > >  	[IIO_CHAN_INFO_SCALE] = "scale",
> > > >  	[IIO_CHAN_INFO_OFFSET] = "offset", @@ -653,14 +654,18 @@ static
> > > > ssize_t iio_read_channel_info(struct device  
> > > *dev,  
> > > >  	int ret;
> > > >  	int val_len = 2;
> > > >
> > > > -	if (indio_dev->info->read_raw_multi)
> > > > +	if (indio_dev->info->read_raw_multi) {
> > > >  		ret = indio_dev->info->read_raw_multi(indio_dev, this_attr- c,
> > > >  
> > > 	INDIO_MAX_RAW_ELEMENTS,  
> > > >  							vals, &val_len,
> > > >  							this_attr->address);
> > > > -	else
> > > > +	} else {
> > > >  		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> > > >  				    &vals[0], &vals[1], this_attr->address);
> > > > +		if (ret < 0 && this_attr->address == IIO_CHAN_INFO_LABEL  
> > > &&  
> > > > +			this_attr->c->label_name)  
> > >
> > > I'm not keen on this. We shouldn't be calling read_raw at all in this path.
> > > There is no way it can return a valid label.
> > >  
> > > > +			return sprintf(buf, "%s\n", this_attr->c->label_name);
> > > > +	}
> > > >
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > > @@ -1399,6 +1404,7 @@ static int iio_device_register_sysfs(struct
> > > > iio_dev  
> > > *indio_dev)  
> > > >  			attrcount_orig++;
> > > >  	}
> > > >  	attrcount = attrcount_orig;
> > > > +  
> > >
> > > Please avoid unrelated white space changes.
> > >  
> > > >  	/*
> > > >  	 * New channel registration method - relies on the fact a group does
> > > >  	 * not need to be initialized if its name is NULL.
> > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h index
> > > > a1be82e74c93..39209f3b62be 100644
> > > > --- a/include/linux/iio/iio.h
> > > > +++ b/include/linux/iio/iio.h
> > > > @@ -223,6 +223,7 @@ struct iio_event_spec {
> > > >   *			correspond to the first name that the channel is  
> > > referred  
> > > >   *			to by in the datasheet (e.g. IND), or the nearest
> > > >   *			possible compound name (e.g. IND-INC).
> > > > + * @label_name:		Unique name to identify which channel this is.
> > > >   * @modified:		Does a modifier apply to this channel. What  
> > > these are  
> > > >   *			depends on the channel type.  Modifier is set in
> > > >   *			channel2. Examples are IIO_MOD_X for axial sensors  
> > > about  
> > > > @@ -260,6 +261,7 @@ struct iio_chan_spec {
> > > >  	const struct iio_chan_spec_ext_info *ext_info;
> > > >  	const char		*extend_name;
> > > >  	const char		*datasheet_name;
> > > > +	const char		*label_name;  
> > >
> > > This can't be part of chan_spec as that is constant in many drivers.
> > > We need a separate way of doing this.    
> What do you mean by "chan_spec is constant in many drivers"?
> Instances of the "struct iio_chan_spec" are created in the driver. 

No they aren't.  Grep for struct iio_chan_spec 
Something like... 
git grep iio_chan_spec -- drivers/iio/ | grep const | grep channels

A very very large number of drivers keep this data constant.
If the driver doesn't provide flexibility on enabled channels
(for example such flexibility makes no sense on an accelerometer)
then the instances of this structure are constant.

There are lots of good reasons to do this if at all possible and
I'm not happy changing it just to put in an optional string.

> Also it makes sense for me to add "const char              *label_name;"
> in this structure since it is an attribute of the channel, and it doesn't
> change at runtime, only when parsing the device tree and assigning the value to it

That is at runtime.  The structure is constant at build time in many/most drivers.
There are 459 instances using the above grep for starters that would all
need to change.

>, when an instance of "iio_chan_spec" is created.
> >> Don't use info_mask, but
> > > register it separately for each channel in a similar way to we do the
> > > name and label attributes for the whole device.  
> Don't understand this part. "name" and "label" of the device are elements of
> "struct iio_dev", as "const char  *label_name;" is part of "struct iio_chan_spec", the equivalent structure for holding channel attributes.
It is not the equivalent structure.  There is no equivalent per channel structure.
iio_chan_spec is a specification for a channel, not a dynamic structure holding
information about it, whereas iio_dev is such a dynamic structure holding
dynamic information about the device (plus a few small bits of constant info).

If we need a dynamic structure per channel then we need to create a new one,
not take a massive amount of constant data and make it dynamic in order
to add a single dynamic field.

> Who will hold the label values otherwise, if not the " iio_chan_spec " structure?

A new element.  For now we should keep this in the drivers because
it is a driver decision to provide this information.  For a lot of
drivers it makes no sense to have a label so we don't want to put the
burden on the IIO core.

For now, a driver should just copy the labels into driver local storage
and return them from the new callback.

Later, we can look at adding utility functions etc if it turns out to make
sense.  However, I'm not interested in doing that until we have a
reasonable number of drivers using the facility and hence
a good understanding of the common elements of such functions.

> > > I would add a new callback to iio_info that is passed the
> > > iio_chan_spec and returns a const char * for the label name.  
> I do agree with the callback, it can be a more generic callback,
> to return strings, for other purposes also.
> Something like this:
>     int (*read_string)(struct iio_dev *indio_dev,  struct iio_chan_spec const *chan,  char *string,  long mask);
> or
>     int (*read_string)(struct iio_dev *indio_dev,  struct iio_chan_spec const *chan, const char **string, long mask);
> The callback will be called in "iio_read_channel_info", so I think that a system file will be created for it.

What else is it used for?  If you are refactoring some other code
to use this new callback then it is worth considering.  Until then
it's an unused generalization so a bad idea.

Thanks,

Jonathan

> > >
> > > The driver would be responsible for doing a lookup based on what it
> > > has cached from the dt parse, probably indexed off address or
> > > scan_index (that can be driver specific)
> > >
> > > To create the attribute you need to add this to
> > > iio_device_register_sysfs and use the various core functions to build
> > > the attribute name in a similar fashion to that done for info mask elements.
> > >
> > > It will be more complex than your approach, but make it more
> > > 'separable' as a feature in drivers.
> > >
> > > Jonathan
> > >
> > >  
> > > >  	unsigned		modified:1;
> > > >  	unsigned		indexed:1;
> > > >  	unsigned		output:1;
> > > > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > > > index e6fd3645963c..c8f65f476eb2 100644
> > > > --- a/include/linux/iio/types.h
> > > > +++ b/include/linux/iio/types.h
> > > > @@ -34,6 +34,7 @@ enum iio_available_type {
> > > >
> > > >  enum iio_chan_info_enum {
> > > >  	IIO_CHAN_INFO_RAW = 0,
> > > > +	IIO_CHAN_INFO_LABEL,
> > > >  	IIO_CHAN_INFO_PROCESSED,
> > > >  	IIO_CHAN_INFO_SCALE,
> > > >  	IIO_CHAN_INFO_OFFSET,  
> 

