Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137942A318E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgKBRbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 12:31:01 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3017 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgKBRbB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Nov 2020 12:31:01 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CBF9F90C3AAD4860B20D;
        Mon,  2 Nov 2020 17:30:59 +0000 (GMT)
Received: from localhost (10.52.120.98) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 17:30:59 +0000
Date:   Mon, 2 Nov 2020 17:28:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <jic23@kernel.org>, <ardeleanalex@gmail.com>,
        <linux-iio@vger.kernel.org>, <alexandru.ardelean@analog.com>
Subject: Re: Requirement for at91-sama5d2_adc timestamp buffer
Message-ID: <20201102172856.00007ee5@Huawei.com>
In-Reply-To: <767f3b0f-7874-a359-63db-db01fe87fdf1@microchip.com>
References: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
        <CA+U=DsoMWH281+1vv8h8aZKumkM+oocrWP6XVKVQ5AoFoXpk3w@mail.gmail.com>
        <20201101202152.72c0f384@archlinux>
        <767f3b0f-7874-a359-63db-db01fe87fdf1@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.98]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 13:29:27 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 01.11.2020 22:21, Jonathan Cameron wrote:
> > On Sun, 1 Nov 2020 11:28:53 +0200
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >   
> >> On Fri, Oct 30, 2020 at 2:29 PM <Eugen.Hristev@microchip.com> wrote:  
> >>>
> >>> Hello Jonathan,
> >>>
> >>> I found an issue with at91-sama5d2_adc driver, namely, when using DMA
> >>> and timestamp in the same time, the hardware provides the sample in the
> >>> fashion (2 bytes per channel) * (number of channels) - as copied by the
> >>> DMA master to memory.
> >>> I compute a software timestamp , and then push to buffers with timestamp.
> >>> However your push code will try to write this timestamp inside my buffer
> >>> ! and overwrite my samples... I have multiple samples in the buffer
> >>> (watermark number) and there is no space between them because the
> >>> hardware copies the conversion data directly in this buffer.
> >>>
> >>> Do you have any suggestion on how to solve this, except 1) giving up the
> >>> timestamp in this mode or 2) copy to another buffer with more space for
> >>> timestamp storage ?  
> >>
> >> I'm assuming the issue is here:
> >>                  iio_push_to_buffers_with_timestamp(indio_dev,
> >>                                  (st->dma_st.rx_buf + st->dma_st.buf_idx),
> >>                                  (st->dma_st.dma_ts + interval * sample_index));
> >>
> >> Can the DMA be configured to add some padding in-between the samples?
> >> It looks like the way this is currently working, timestamps cannot
> >> work with the DMA buffers and multiple consecutive samples.
> >> But, it may be that this case is a bit unrealistic; or shouldn't be supported.
> >> DMA is used to provide really-fast transfers; computing timestamps in
> >> SW for each sample would slow things down to the point where the
> >> transfers aren't fast anymore.
> >>
> >> What would [possibly] be an alternative, is to do a
> >> "iio_push_multiple_samples_to_buffers_with_timestamp(indio_dev, buffer
> >> for 1 sample-set, n_samples, )".
> >> That would basically mean, the DMA gets 10, 100, 1000 samples, and
> >> adds a timestamp at the end.
> >> Now, the only thing that I don't know here: is how userspace would be
> >> able to determine the number of samples until the next timestamp.
> >> I guess some mechanism could be extended inside IIO to accommodate for
> >> this; N_samples_till_timestamp counter, with a default value of 1.
> >> Not sure if it makes sense though.  
> > 
> > There is a very obscure and little used facility to repeats of a single
> > channel, but that's as close as we get.  Describing arbitrary patterns
> > of data is hard to do without adding the overhead of a header and not
> > doing tagged data has been one of the fundamental design decisions in
> > IIO.
> > 
> > We've discussed adding a separate meta data buffer, but that would
> > need extra storage anyway to flag when there was meta data so wouldn't
> > help you here.
> > 
> > As Alexandru asked, can you persuade the dma engine to leave a gap?  
> 
> This might work for a single channel. But if we use arbitrary number of 
> channels, only the iio driver knows how many channels are enabled and 
> how to separate the data into samples, by dividing total dma received 
> data by the size of one sample
> So the DMA channel is just copying data from the ADC as soon as it's 
> ready, and then in the iio driver I am just passing the buffer to the 
> subsystem. Thus it's pretty unaware to leave a gap when the channels are 
> done for one sample.

You would have to have a DMA engine that was clever to do this.
Not hard to implement, but only if the hardware designer appreciated it
might be useful.

> 
> > If not, you are going to have to keep copying the data.
> > I theory you might be able to persuade the kfifo to take that
> > data in different form and then introduce a different path for
> > buffer management (not iio_push_to_buffers_*), but you'd need to
> > figure out how to do that.  
> 
> Currently, I hold two timestamps (one at DMA start and one at DMA 
> finish), and then spread the time between them by the number of samples 
> (Jonathan's idea when I initially added the DMA support). I could make 
> another primitive that would receive a timestamp for DMA start , and one 
> for DMA end, but this would mean that the memcopy would be done inside 
> the iio subsystem (which is again a performance blocker)
> Is there a way to have a channel enabled, but this channel would provide 
> data not every time so to say, for example, once every X samples ?

Not currently.   We can specify patterns like
XXXXYYYYT but not XYXYXYXYXYT (using the repeat element in the
scan element description).

The description format for a scan doesn't allow for the concept of not
every time.

> I could alter the scan_mask to remove the timestamp channel and then 
> reenable the timestamp and provide timestamp information at the end of 
> one DMA chunk ?

Given that would require reinitializing the kfifo etc it won't work.
Via a bit of black magic that I can't really remember we use a fixed
record size kfifo to avoid having to store the record size in each entry.
As such, to change that record size requires recreating the kfifo. 

It might be possible to define a kfifo_in that takes 2 parameters and
fills the kfifo element with both of them via 2 copies.

I think I looked at this a long time back but can't really recall why
I decided against it other than general feeling that there isn't anything
special about timestamps in IIO so we shouldn't treat them differently
if we can avoid it.

> Does this sound as a good solution ?

No unfortunately.  The description to userspace has to be clean
and unambiguous.  I'm not yet seeing how we do that.

Jonathan

> 
> Thanks,
> Eugen
> >>  
> >>>
> >>> Thanks,
> >>> Eugen  
> >   
> 

