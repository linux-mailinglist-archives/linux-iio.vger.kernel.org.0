Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B54A2A2183
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAUV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAUV5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:21:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2915B20723;
        Sun,  1 Nov 2020 20:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604262116;
        bh=bwksYXSW6+bhZqa4Te2qMa4lJareuMGqGfpibo9BYLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jUCknUB0Ic2AQy/dTMJxbnWE7D+F+pxI7olux0KcSd8EJcVTEh748abHgd72G322x
         3x1PViD+mZeQT5sLlF7eknex4AyT+0I2bVPL3efykyKgJ0C2SJv44ePUcUgKRiZcdn
         CrXrUU/2epUPQ9oBFCkHz2lY32IlW1NZVaxndqhI=
Date:   Sun, 1 Nov 2020 20:21:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Eugen Hristev <Eugen.Hristev@microchip.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: Requirement for at91-sama5d2_adc timestamp buffer
Message-ID: <20201101202152.72c0f384@archlinux>
In-Reply-To: <CA+U=DsoMWH281+1vv8h8aZKumkM+oocrWP6XVKVQ5AoFoXpk3w@mail.gmail.com>
References: <8825686e-1fc4-65fd-e482-f25d46288ff7@microchip.com>
        <CA+U=DsoMWH281+1vv8h8aZKumkM+oocrWP6XVKVQ5AoFoXpk3w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Nov 2020 11:28:53 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Oct 30, 2020 at 2:29 PM <Eugen.Hristev@microchip.com> wrote:
> >
> > Hello Jonathan,
> >
> > I found an issue with at91-sama5d2_adc driver, namely, when using DMA
> > and timestamp in the same time, the hardware provides the sample in the
> > fashion (2 bytes per channel) * (number of channels) - as copied by the
> > DMA master to memory.
> > I compute a software timestamp , and then push to buffers with timestamp.
> > However your push code will try to write this timestamp inside my buffer
> > ! and overwrite my samples... I have multiple samples in the buffer
> > (watermark number) and there is no space between them because the
> > hardware copies the conversion data directly in this buffer.
> >
> > Do you have any suggestion on how to solve this, except 1) giving up the
> > timestamp in this mode or 2) copy to another buffer with more space for
> > timestamp storage ?  
> 
> I'm assuming the issue is here:
>                 iio_push_to_buffers_with_timestamp(indio_dev,
>                                 (st->dma_st.rx_buf + st->dma_st.buf_idx),
>                                 (st->dma_st.dma_ts + interval * sample_index));
> 
> Can the DMA be configured to add some padding in-between the samples?
> It looks like the way this is currently working, timestamps cannot
> work with the DMA buffers and multiple consecutive samples.
> But, it may be that this case is a bit unrealistic; or shouldn't be supported.
> DMA is used to provide really-fast transfers; computing timestamps in
> SW for each sample would slow things down to the point where the
> transfers aren't fast anymore.
> 
> What would [possibly] be an alternative, is to do a
> "iio_push_multiple_samples_to_buffers_with_timestamp(indio_dev, buffer
> for 1 sample-set, n_samples, )".
> That would basically mean, the DMA gets 10, 100, 1000 samples, and
> adds a timestamp at the end.
> Now, the only thing that I don't know here: is how userspace would be
> able to determine the number of samples until the next timestamp.
> I guess some mechanism could be extended inside IIO to accommodate for
> this; N_samples_till_timestamp counter, with a default value of 1.
> Not sure if it makes sense though.

There is a very obscure and little used facility to repeats of a single
channel, but that's as close as we get.  Describing arbitrary patterns
of data is hard to do without adding the overhead of a header and not
doing tagged data has been one of the fundamental design decisions in 
IIO.

We've discussed adding a separate meta data buffer, but that would
need extra storage anyway to flag when there was meta data so wouldn't
help you here.

As Alexandru asked, can you persuade the dma engine to leave a gap?
If not, you are going to have to keep copying the data.
I theory you might be able to persuade the kfifo to take that
data in different form and then introduce a different path for
buffer management (not iio_push_to_buffers_*), but you'd need to
figure out how to do that.
> 
> >
> > Thanks,
> > Eugen  

