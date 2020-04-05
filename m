Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B319EA38
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgDEJto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 05:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgDEJtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 05:49:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5C520675;
        Sun,  5 Apr 2020 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586080183;
        bh=WeVDkWhZ6t/eVvXarXcNbFo+gbsB1fyrnxptuJEKHVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKQUUCy+IiMLpeZV5w8MFnUC0ujrzpC2KgGueu8kKrY2DK8thWcECEmaAwPpKSUiH
         NqIQYD0fmTlxj+nP/heUrTZA8k+YdLiAKGsWF9Ty6wc/S80reuEx92MfbXse4LAZqK
         PYof/bA1mzZ3F2Jh00u7WFdcuTMYSFTvveJUpjC8=
Date:   Sun, 5 Apr 2020 10:49:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for
 chrdev
Message-ID: <20200405104939.0e220daa@archlinux>
In-Reply-To: <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
        <20200330145705.29447-4-alexandru.ardelean@analog.com>
        <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 17:58:16 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/30/20 4:57 PM, Alexandru Ardelean wrote:
> > This is WIP.
> > It hasn't been tested yet. Mostly serves as base for some discussion.
> >
> > There have been some offline discussions about how to go about this.
> > Since I wasn't involved in any of those discussions, this kind of tries to
> > re-build things from various bits.
> >
> > 1. First approach is: we keep 1 buffer per device, and we make it either
> > in/out, which means that for devices that for devices that have both in/out
> > 2 iio_dev instances are required, or an ADC needs to be connected on the in
> > path and a DAC on out-path. This is predominantly done in the ADI tree.
> >
> > 2. One discussion/proposal was to have multiple buffers per-device. But the
> > details are vague since they were relayed to me.
> > One detail was, to have indexes for devices that have more than 1
> > buffer:
> >
> > Iio_deviceX:
> >          buffer
> >          scan_elements
> >
> > Iio_deviceX:
> >          BufferY
> >          scan_elementsY
> >          BufferZ
> >          scan_elementsZ
> >
> > I am not sure how feasible this is for a single chrdev, as when you look at
> > the fileops that get assigned to a chrdev, it looks like it can have at
> > most two buffers (one for input, out for output).
> >
> > Multiplexing input buffers can work (from ADCs), but demultiplexing output
> > buffers into a DAC, not so well. Especially on a single chrdev.
> >
> > Question 1: do we want to support more than 2 buffers per chrdev?
> >
> > This is what ADI currently has in it's tree (and works).
> >
> > Example, ADC:
> >   # ls iio\:device3/buffer/
> >   data_available  enable  length  length_align_bytes  watermark
> >   #  ls iio\:device3/scan_elements/
> >   in_voltage0_en  in_voltage0_index  in_voltage0_type  in_voltage1_en  in_voltage1_index  in_voltage1_type
> >
> > Example, DAC:
> >   #  ls iio\:device4/buffer/
> >   data_available  enable  length  length_align_bytes  watermark
> >   # ls iio\:device4/scan_elements/
> >   out_voltage0_en     out_voltage0_type  out_voltage1_index  out_voltage2_en     out_voltage2_type  out_voltage3_index
> >   out_voltage0_index  out_voltage1_en    out_voltage1_type   out_voltage2_index  out_voltage3_en    out_voltage3_type
> >
> > The direction of each element is encoded into the filename of each channel.
> >
> > Another question is:
> >   Does it make sense to have more than 1 'scan_elements' folder?
> >   That is, for devices that would have both in & out channels.
> >
> > For 'buffer' folders I was thinking that it may make sense to have,
> > 'buffer_in' && 'buffer_out'.
> >
> > So, one idea is:
> >
> > Iio_deviceX:
> >          buffer_in
> >          buffer_out
> >          scan_elements
> >
> > Currently, this patch kind of implements 2 buffers per iio_dev/chrdev.
> > But the format is:
> >
> > Iio_deviceX:
> >          buffer_in
> >          buffer_out
> >          scan_elements_in
> >          scan_elements_out  
> 
> I'd make scan_elements as a sub-folder of the buffer folder. And have 
> symlink for the legacy case

Now this is a bit of legacy.  The original concept was that you could have
different types of buffer registered for a device (though only one at a time)
and hence scan_elements reflected what was being pushed 'into' the buffer
vs the buffer folder that reflected characteristics of the buffers (how long
it was for instance).

Reality was we never really supported multiple buffers like this, having figured
out that hardware fifos are almost always better fronted by a software fifo
rather than directly exposed.

So I want to think about it a bit more, but right now I can't see a reason not
to move the scan_elements directories under the buffer. (with symlink!)

> 
> >
> > Obviously it shouldn't work as-is [as it wasn't tested], but at least gives
> > some glimpse of where this could go.  
> 
> I believe the basic idea behind the multiple buffers per device was, 
> that if we do it, we should do it in a way that you can have an 
> arbitrary number of buffers. E.g. not just one input and output but also 
> multiple input buffers.

We have other devices that might be better supported this way, but get fiddly
because you can move the channels between different buffers.

N channels, M triggers, P hardware fifos (or tagged fifos).
Some combinations go into different places.

A classic is an accelerometer / gyro device where the sampling rates can be
entirely different and you get accel/accel/gyro/accel/accel/gyro in the 
fifo.  Currently we split that into two devices.

However, the issue in transistioning to this model is there isn't an
obvious way of making it backwards compatible for existing userspace.
I guess we could do some magic by hooking in an optional consumer driver
that just wraps a particular buffer. 

For output buffers at least this isn't a problem.

There are other corners to deal with such as breaking the current assumption
that triggers are global for the device (probably move trigger under the buffer
much like scan_elements and symlink for legacy) and sampling_frequency
- though we already have devices where that is either a buffer or trigger
characteristic.

> 
> >
> > 3. A side question is about the 'iio_buffer -> pollq' field. I was
> > wondering if it would make sense to move that on to 'iio_dev  pollq' if
> > adding multiple buffers are added per-device. It almost makes sense to
> > unify the 'pollq' on indio_dev.
> > But, it looks a bit difficult, and would require some more change [which is
> > doable] if it makes sense for whatever reason.
> > The only reason to do it, is because the iio_buffer_fileops has a .poll =
> > iio_buffer_poll() function attached to it. Adding multiple buffers for an
> > IIO device may require some consideration on the iio_buffer_poll() function
> > as well.  
> 
> I think we need one chardev per buffer. Conceptually that is the right 
> approach in my option since the two buffers are independent streams. But 
> also from a practical point of view we want to have the ability to have 
> the buffers opened by different applications. E.g. iio_readdev on the 
> input buffer and iio_writedev on the output buffer. And there might be 
> some other operations that wont multiplex as nicely as read/write. The 
> high speed interface for example would not work as it is right now.
> 

Yup. Separate chardev is pretty much the only option given the poll infrastructure.
In theory could do the anon file trick again but I'm not sure it's worth it
- the vast majority of drivers are still going to be single buffer (I think!)

Jonathan
