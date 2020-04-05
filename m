Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6081C19EA36
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDEJdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 05:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDEJdc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 05:33:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F14520672;
        Sun,  5 Apr 2020 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586079211;
        bh=KYcq8xF5oZTPhfrFDLfsjMxdAjhBNcVMU+8/TDHEN5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eyg/qTHnYba9z5prC/bef9XmoBxcVzXofYlIVu3vImeUHA0j45ccMsP6hPNEc/BKh
         k4zNdnswKj47ZTswQzFZBIYKHi+cu2bRA88Cp087IJ0gwyGXJpOwBcHW2TBhcaDZIS
         tyKw1IQ2d3ua+fScUIaT0LabNXHeHVkQ31X5QF5s=
Date:   Sun, 5 Apr 2020 10:33:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for
 chrdev
Message-ID: <20200405103327.4f4e049d@archlinux>
In-Reply-To: <366621e9-896b-0bc7-5c77-14b11d619a22@metafoo.de>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
        <20200330145705.29447-4-alexandru.ardelean@analog.com>
        <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
        <89f9cb7a7ea1b0cce1fcce77db9577b3e16b9287.camel@analog.com>
        <366621e9-896b-0bc7-5c77-14b11d619a22@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 19:43:09 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/30/20 7:27 PM, Ardelean, Alexandru wrote:
> > On Mon, 2020-03-30 at 17:58 +0200, Lars-Peter Clausen wrote:  
> >> [External]
> >>
> >> On 3/30/20 4:57 PM, Alexandru Ardelean wrote:  
> >>> This is WIP.
> >>> It hasn't been tested yet. Mostly serves as base for some discussion.
> >>>
> >>> There have been some offline discussions about how to go about this.
> >>> Since I wasn't involved in any of those discussions, this kind of tries to
> >>> re-build things from various bits.
> >>>
> >>> 1. First approach is: we keep 1 buffer per device, and we make it either
> >>> in/out, which means that for devices that for devices that have both in/out
> >>> 2 iio_dev instances are required, or an ADC needs to be connected on the in
> >>> path and a DAC on out-path. This is predominantly done in the ADI tree.
> >>>
> >>> 2. One discussion/proposal was to have multiple buffers per-device. But the
> >>> details are vague since they were relayed to me.
> >>> One detail was, to have indexes for devices that have more than 1
> >>> buffer:
> >>>
> >>> Iio_deviceX:
> >>>           buffer
> >>>           scan_elements
> >>>
> >>> Iio_deviceX:
> >>>           BufferY
> >>>           scan_elementsY
> >>>           BufferZ
> >>>           scan_elementsZ
> >>>
> >>> I am not sure how feasible this is for a single chrdev, as when you look at
> >>> the fileops that get assigned to a chrdev, it looks like it can have at
> >>> most two buffers (one for input, out for output).
> >>>
> >>> Multiplexing input buffers can work (from ADCs), but demultiplexing output
> >>> buffers into a DAC, not so well. Especially on a single chrdev.
> >>>
> >>> Question 1: do we want to support more than 2 buffers per chrdev?
> >>>
> >>> This is what ADI currently has in it's tree (and works).
> >>>
> >>> Example, ADC:
> >>>    # ls iio\:device3/buffer/
> >>>    data_available  enable  length  length_align_bytes  watermark
> >>>    #  ls iio\:device3/scan_elements/
> >>>   
> >>> in_voltage0_en  in_voltage0_index  in_voltage0_type  in_voltage1_en  in_volt
> >>> age1_index  in_voltage1_type
> >>>
> >>> Example, DAC:
> >>>    #  ls iio\:device4/buffer/
> >>>    data_available  enable  length  length_align_bytes  watermark
> >>>    # ls iio\:device4/scan_elements/
> >>>   
> >>> out_voltage0_en     out_voltage0_type  out_voltage1_index  out_voltage2_en
> >>>     out_voltage2_type  out_voltage3_index
> >>>   
> >>> out_voltage0_index  out_voltage1_en    out_voltage1_type   out_voltage2_inde
> >>> x  out_voltage3_en    out_voltage3_type
> >>>
> >>> The direction of each element is encoded into the filename of each channel.
> >>>
> >>> Another question is:
> >>>    Does it make sense to have more than 1 'scan_elements' folder?
> >>>    That is, for devices that would have both in & out channels.
> >>>
> >>> For 'buffer' folders I was thinking that it may make sense to have,
> >>> 'buffer_in' && 'buffer_out'.
> >>>
> >>> So, one idea is:
> >>>
> >>> Iio_deviceX:
> >>>           buffer_in
> >>>           buffer_out
> >>>           scan_elements
> >>>
> >>> Currently, this patch kind of implements 2 buffers per iio_dev/chrdev.
> >>> But the format is:
> >>>
> >>> Iio_deviceX:
> >>>           buffer_in
> >>>           buffer_out
> >>>           scan_elements_in
> >>>           scan_elements_out  
> >> I'd make scan_elements as a sub-folder of the buffer folder. And have
> >> symlink for the legacy case
> >>  
> >>> Obviously it shouldn't work as-is [as it wasn't tested], but at least gives
> >>> some glimpse of where this could go.  
> >> I believe the basic idea behind the multiple buffers per device was,
> >> that if we do it, we should do it in a way that you can have an
> >> arbitrary number of buffers. E.g. not just one input and output but also
> >> multiple input buffers.
> >>  
> >>> 3. A side question is about the 'iio_buffer -> pollq' field. I was
> >>> wondering if it would make sense to move that on to 'iio_dev  pollq' if
> >>> adding multiple buffers are added per-device. It almost makes sense to
> >>> unify the 'pollq' on indio_dev.
> >>> But, it looks a bit difficult, and would require some more change [which is
> >>> doable] if it makes sense for whatever reason.
> >>> The only reason to do it, is because the iio_buffer_fileops has a .poll =
> >>> iio_buffer_poll() function attached to it. Adding multiple buffers for an
> >>> IIO device may require some consideration on the iio_buffer_poll() function
> >>> as well.  
> >> I think we need one chardev per buffer. Conceptually that is the right
> >> approach in my option since the two buffers are independent streams. But
> >> also from a practical point of view we want to have the ability to have
> >> the buffers opened by different applications. E.g. iio_readdev on the
> >> input buffer and iio_writedev on the output buffer. And there might be
> >> some other operations that wont multiplex as nicely as read/write. The
> >> high speed interface for example would not work as it is right now.  
> > For some reason, the idea of more than 1 chrdev per IIO device escaped me.
> > It makes things easier.
> > I'll take a look.
> > I probably need to think about the naming, or how to identify chrdevs per IIO
> > device.
> >
> > Maybe something like:
> > /dev/iio:device0:0
> > /dev/iio:device0:1
> >
> > where the 2nd index is
> > /sys/bus/iio/devices/iio:device0/buffer0
> > /sys/bus/iio/devices/iio:device0/buffer1
> >
> > or something like that
> >
> > not sure yet how possible it is yet; need to check  
> 
> Yep. With symlink of buffer to buffer0 to keep backwards compatibility.
> 
> There is maybe one tricky part. We use an ioctl on the buffer file 
> descriptor to get access to the event file descriptor. I don't remember 
> quite exactly why it was done like this I remember that I believe Arned 
> Bergman suggested it. But it feels like it was more of a novelty thing, 
> like look what cool stuff we can doe with anonymous inodes.

Specifically it was the concern about huge numbers of character devices
that weren't obviously associated with each other.  I'm not sure we want
to change that.

Events are still going to be associated with the channels on a particular
buffer so I'd leave this alone.

I think the number of multiple buffer devices is going to be fairly small
so I'm not so worried about using additional character devices.

Jonathan

> 
> Maybe going forward it makes sense it introduce a event chardev, which 
> would bring us full circle: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e7d967244a8eebcdadb048efc5e66849ec0a6b6
> 
> - Lars
> 

