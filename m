Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94AC1C35AC
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgEDJ2y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 May 2020 05:28:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbgEDJ2x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 May 2020 05:28:53 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C39C977FE7328CAC9F84;
        Mon,  4 May 2020 10:28:51 +0100 (IST)
Received: from localhost (10.47.88.153) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:28:51 +0100
Date:   Mon, 4 May 2020 10:28:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
 basis
Message-ID: <20200504102831.00003c7e@Huawei.com>
In-Reply-To: <BN6PR03MB3347E50B683800B249C04AFE99A60@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-5-alexandru.ardelean@analog.com>
        <CY4PR03MB33506FD8C2BF3921FE9BA2DD99D00@CY4PR03MB3350.namprd03.prod.outlook.com>
        <20200426115031.2eb0bb3c@archlinux>
        <CY4PR03MB3350C865423E5FF97834BD3F99AF0@CY4PR03MB3350.namprd03.prod.outlook.com>
        <20200502181929.2409dcde@archlinux>
        <BN6PR03MB3347E50B683800B249C04AFE99A60@BN6PR03MB3347.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.153]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 May 2020 08:24:35 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Samstag, 2. Mai 2020 19:19
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Ardelean, Alexandru <alexandru.Ardelean@analog.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; lars@metafoo.de
> > Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
> > basis
> > 
> > [External]
> > 
> > On Mon, 27 Apr 2020 12:09:18 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > > From: linux-iio-owner@vger.kernel.org <linux-iio-  
> > owner@vger.kernel.org>  
> > > > On Behalf Of Jonathan Cameron
> > > > Sent: Sonntag, 26. April 2020 12:51
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: Ardelean, Alexandru <alexandru.Ardelean@analog.com>; linux-
> > > > iio@vger.kernel.org; linux-kernel@vger.kernel.org; lars@metafoo.de
> > > > Subject: Re: [RFC PATCH 4/4] iio: Track enabled channels on a per channel
> > > > basis
> > > >
> > > > On Fri, 24 Apr 2020 07:51:05 +0000
> > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > >  
> > > > > > From: linux-iio-owner@vger.kernel.org <linux-iio-  
> > > > owner@vger.kernel.org>  
> > > > > > On Behalf Of Alexandru Ardelean
> > > > > > Sent: Freitag, 24. April 2020 07:18
> > > > > > To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > > Cc: jic23@kernel.org; lars@metafoo.de; Ardelean, Alexandru
> > > > > > <alexandru.Ardelean@analog.com>
> > > > > > Subject: [RFC PATCH 4/4] iio: Track enabled channels on a per channel  
> > > > basis  
> > > > > >
> > > > > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > > > >
> > > > > > Now that we support multiple channels with the same scan index we  
> > can  
> > > > no  
> > > > > > longer use the scan mask to track which channels have been enabled.
> > > > > > Otherwise it is not possible to enable channels with the same scan  
> > index  
> > > > > > independently.
> > > > > >
> > > > > > Introduce a new channel mask which is used instead of the scan mask  
> > to  
> > > > > > track which channels are enabled. Whenever the channel mask is  
> > > > changed a  
> > > > > > new scan mask is computed based on it.
> > > > > >
> > > > > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > > > > Signed-off-by: Alexandru Ardelean  
> > <alexandru.ardelean@analog.com>  
> > > > > > ---
> > > > > >  drivers/iio/industrialio-buffer.c | 62 +++++++++++++++++++++-------  
> > ---  
> > > > > >  drivers/iio/inkern.c              | 19 +++++++++-
> > > > > >  include/linux/iio/buffer_impl.h   |  3 ++
> > > > > >  include/linux/iio/consumer.h      |  2 +
> > > > > >  4 files changed, 64 insertions(+), 22 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-  
> > > > buffer.c  
> > > > > > index c06691281287..1821a3e32fb3 100644
> > > > > > --- a/drivers/iio/industrialio-buffer.c
> > > > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > > > @@ -216,12 +216,20 @@ int iio_buffer_alloc_scanmask(struct  
> > iio_buffer  
> > > > > > *buffer,
> > > > > >  	if (buffer->scan_mask == NULL)
> > > > > >  		return -ENOMEM;
> > > > > >
> > > > > > +	buffer->channel_mask = bitmap_zalloc(indio_dev-  
> > >num_channels,  
> > > > > > +					     GFP_KERNEL);
> > > > > > +	if (buffer->channel_mask == NULL) {
> > > > > > +		bitmap_free(buffer->scan_mask);
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
> > > > > >
> > > > > >  void iio_buffer_free_scanmask(struct iio_buffer *buffer)
> > > > > >  {
> > > > > > +	bitmap_free(buffer->channel_mask);
> > > > > >  	bitmap_free(buffer->scan_mask);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> > > > > > @@ -285,7 +293,7 @@ static ssize_t iio_scan_el_show(struct device  
> > > > *dev,  
> > > > > >
> > > > > >  	/* Ensure ret is 0 or 1. */
> > > > > >  	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> > > > > > -		       indio_dev->buffer->scan_mask);
> > > > > > +		       indio_dev->buffer->channel_mask);
> > > > > >
> > > > > >  	return sprintf(buf, "%d\n", ret);
> > > > > >  }
> > > > > > @@ -330,11 +338,12 @@ static bool iio_validate_scan_mask(struct  
> > > > iio_dev  
> > > > > > *indio_dev,
> > > > > >   * buffers might request, hence this code only verifies that the
> > > > > >   * individual buffers request is plausible.
> > > > > >   */
> > > > > > -static int iio_scan_mask_set(struct iio_dev *indio_dev,
> > > > > > -		      struct iio_buffer *buffer, int bit)
> > > > > > +static int iio_channel_mask_set(struct iio_dev *indio_dev,
> > > > > > +				struct iio_buffer *buffer, int bit)
> > > > > >  {
> > > > > >  	const unsigned long *mask;
> > > > > >  	unsigned long *trialmask;
> > > > > > +	unsigned int ch;
> > > > > >
> > > > > >  	trialmask = bitmap_zalloc(indio_dev->masklength,  
> > GFP_KERNEL);  
> > > > > >  	if (trialmask == NULL)
> > > > > > @@ -343,8 +352,11 @@ static int iio_scan_mask_set(struct iio_dev
> > > > > > *indio_dev,
> > > > > >  		WARN(1, "Trying to set scanmask prior to registering
> > > > > > buffer\n");
> > > > > >  		goto err_invalid_mask;
> > > > > >  	}
> > > > > > -	bitmap_copy(trialmask, buffer->scan_mask, indio_dev-  
> > > > > > >masklength);  
> > > > > > -	set_bit(bit, trialmask);
> > > > > > +
> > > > > > +	set_bit(bit, buffer->channel_mask);
> > > > > > +
> > > > > > +	for_each_set_bit(ch, buffer->channel_mask, indio_dev-  
> > > > > > >num_channels)  
> > > > > > +		set_bit(indio_dev->channels[ch].scan_index,  
> > trialmask);  
> > > > >
> > > > > So, here if the channels all have the same scan_index, we will end up  
> > with a  
> > > > scan_mask which is  
> > > > > different that channel_mask, right? I saw that in our internal driver's we  
> > > > then just access the  
> > > > > channel_mask field directly to know what pieces/channels do we need  
> > to  
> > > > enable prior to  
> > > > > buffering, which implies including buffer_impl.h.  
> > > > Given that we handle the demux only at the level of scan elements that
> > > > won't work in general
> > > > (even if it wasn't a horrible layering issue).  
> > >
> > > Yes, and the driver just adds 16 channels and points all of them to  
> > scan_index 0. It then  
> > > sets real_bits and the shift so that userspace can get the right channel bit.  
> > So, in the end  
> > > we have just one buffer/scan element with 16bits. My problem here is  
> > more architectural...  
> > > We should not directly include "buffer_impl.h" in drivers...
> > >  
> > > > >
> > > > > So, for me it would make sense to compute scan_mask so that it will be  
> > the  
> > > > same as channel_mask  
> > > > > (hmm but that would be a problem when computing the buffer size...)  
> > and  
> > > > drivers can correctly use  
> > > > > ` validate_scan_mask ()` cb. Alternatively, we need to expose  
> > > > channel_mask either on a new cb or  
> > > > > change the ` validate_scan_mask ()` footprint.  
> > > >
> > > > Excellent points. We need to address support for:
> > > >
> > > > 1) available_scan_mask - if we have complicated rules on mixtures of
> > > > channels inside
> > > >    a given buffer element.  
> > >
> > > Maybe one solution to expose channel mask is to check if channel_mask !=  
> > scan_mask  
> > > before calling the ` validate_scan_mask()`. If it is, we pass channel_mask to  
> > the callback.  
> > > Driver's should then know what to do with it...  
> > 
> > That's liable to be flakey as there is no requirement for the scan_mask to
> > be ordered or indeed not have holes.
> >   
> 
> Yes, but the patch is adding this code:
> 
> `
> for_each_set_bit(ch, buffer->channel_mask, indio_dev-  
> 		num_channels)  
> 	set_bit(indio_dev->channels[ch].scan_index, trialmask);  
> `
> 
> So, As I'm understanding we always enable the scan element on which a channel is inserted.
> In the end, for a traditional driver with all different scan indexes, the resulting scan mask will
> be the same as the channel mask if I'm not missing any subtlety here...

The bits for scan mask are provided by the driver, channel mask elements are simply done
in order of the channel array as we parse it.  Hence scan_mask can have gaps, whereas
channel_mask can't.  I think it's actually more complex than that because not all channels
are in the scan_mask at all.  Now we don't add channels that aren't to either scan_mask or
channel mask (as they have no buffer attributes) but they will change the bit locations
for the channel_mask.

Look at how iio_buffer_add_channel_sysfs is called.

> 
> > >  
> > > > 2) channel enabling though I'm sort of inclined to say that if you are using  
> > this  
> > > > approach
> > > >    you only get information on channels that make up a scan mask  
> > element.  
> > > > Tough luck you
> > > >    may end up enabling more than you'd like.  
> > >
> > > Not sure if I'm fully understanding this point. I believe with this approach  
> > channel  
> > > enablement works as before since the core is kind of mapping  
> > channel_mask to  
> > > scan_mask. So if we have 16 channels using only 1 scan_element we can  
> > still  
> > > enable/disable all 16 channels.  
> > 
> > Its more subtle than that.  Because of the mux, a number of different
> > channels can
> > be enabled by different consumers, but all that is exposed to the driver is
> > the resulting fused scan_mask across all consumers.  It has no idea what
> > channels
> > have been enabled if they lie within a scan_mask element.
> > 
> > Hence, whilst there can be individual channel enable and disable attributes
> > they driver only seems enable and disable of scan mask elements. That
> > means
> > it needs to turn on ALL of the channels within one scan mask element.
> > To do anything more complex requires us to carry all the following to the
> > demux
> > calculator
> > 
> > 1) scan_mask
> > 2) channel_mask
> > 3) mapping from channel mask to scan mask
> > 
> > It could be done, but it's potentially nasty.  Even then we don't want to
> > get into breaking out particular elements within a scan mask element so we'd
> > end up providing all enabled channels (within each scan mask element)
> > to the all consumers who are after any of them.
> > 
> > We'd also have to expose the fused channel mask as well as scan mask
> > to the driver which is not exactly elegant.
> > 
> > That's why I'd suggest initial work uses scan mask as the fundamental
> > unit of enable / disable, not the channel mask.
> > 
> > Nothing stops then improving that later to deal with the channel mask
> > fusion needed to work out the enables, but it's not something I'd do
> > for step 1.
> >   
> > >
> > > In the end, if we have a traditional driver with one channel per scan_index,  
> > channel_mask  
> > > should be equal to scan_mask. As we start to have more than one channel  
> > pointing to the  
> > > same scan_index, these masks will be different.
> > >  
> > > > It might be possible to make switch to using a channel mask but given the
> > > > channel index is
> > > > implicit that is going to be at least a little bit nasty.
> > > >
> > > > How much does it hurt to not have the ability to separately control  
> > channels  
> > > > within
> > > > a given buffer element?   Userspace can enable / disable them but reality  
> > is  
> > > > you'll  
> > >
> > > As long as we are "ok" with the extra amount of allocated memory, I think  
> > it would work.  
> > > Though drivers will have to replicate the same data trough all the enabled  
> > scan elements...
> > 
> > Hmm. I think we are talking about different things.  Let me give an example.
> > 
> > 8 channels in scan mask element 0 size 8 bits, 8 channels in scan mask
> > element 1
> > 
> > Enable a channel in scan mask element 0 on consumer 0, and a
> > different one on consumer 1.  If they were in different scan mask elements
> > we'd deliver the first element only to consumer 0 and the second element
> > only to consumer 1 (that's what the demux does for us)
> > 
> > Here, in what I would suggest for the initial implementation, channel mask
> > is not exposed at all to buffer setup op (update_scan_mask) - so we
> > don't know which channels in that scan mask element are needed.
> > Only answer, turn all 8 on.
> > 
> > In this case we would deliver one 8 bit buffer element to each of the
> > consumers
> > but it would include the values for all 8 channels (but none from the 8
> > channels
> > in our second scan mask element).
> > 
> > This keeps the channel mask logic (for now) separate from the demux
> > and the buffered capture setup logic, but at the cost of sampling channels
> > no one cares about.  Note we often do that anyway as a lot of hardware does
> > not have per channel enables, or is more efficient if we grab all the channels
> > in a single transaction.
> >   
> 
> Hmm, I see your point now. Looking at the patchset, it also looks like that there's
> no intention of doing the demux at the channel/bit level. I also agree on keeping the
> granularity at the scan_element level otherwise it can be really unpleasant to implement
> and "read" the demux code.
> 
> I was more looking for the possibility of passing the channel_mask to the drivers instead
> of the scan_mask (when it makes sense to do so) so we can only sample the channels we
> are interested in. In the end, we would push the complete scan_element to the iio_buffer
> only with the bits we are interested in...
To do that you'd have to deal with fusing the channel masks from multiple consumers and
checking that's possible each time we enable a channel (so channel_mask_available etc)
> 
> That being sad, I'm also not seeing a big problem in just enabling all the channels for a given
> scan element but I might be missing something.

Definitely easier for a 'first pass'.  We can be more clever later - the result of
adding fine grained control should have no impact on the perceived output - it's just
an efficiency improvement.
> 
> - Nuno Sá

Thanks,

Jonathan



