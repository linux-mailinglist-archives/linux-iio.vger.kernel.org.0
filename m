Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26223A9B65
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFPNE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhFPNE2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 09:04:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DACC061574
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 06:02:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q15so1883054pgg.12
        for <linux-iio@vger.kernel.org>; Wed, 16 Jun 2021 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aw+Ac6FdaxpyMK0kER2tZEM/cFPyiGMZoNPJltnEUk=;
        b=NtrnGCeIdNttEwJZ7Y85CWm+pmiNkr6x2f6atX4pIaql3E4Wp0rVafSbd+t48OHfRq
         MWKgUGQoq7F35WOZCbdmVJSWNGs98ZkyN9gBrdYEVSEMSGiE02chRcA1+mNUjvn+CQz4
         h3D9Lr3A5yDGVR5WLDjcxjb/QnE3TZExQ+GOc8U7xUyKiE7cd7bGJY9KaixbPIFRLL3u
         wjyV62DKu/qxslfbl13qyYJYB2a3QHtkejzjC4HmctkAMj33wBE/TcrWcYqNkFHaZURI
         aPf3B2O+Qtde6L469pLBivYuxcM3TH33/X5gn+X9/hz8gcL43/a/LtusJF3lrqdaI12u
         u0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aw+Ac6FdaxpyMK0kER2tZEM/cFPyiGMZoNPJltnEUk=;
        b=N05l2HydSdzqdDTjrCE1MY7y/EY5+EgpWB80PwREc4M/KwQjeCyFMQjCtTFj9h6Vc1
         Eexm1hPDvmZm8Eeu87bag7M6I08qeZ7daGRiN0qY+1ajq/mjy10746Xv1FiSvsDbEczm
         qgNO/yw72kSetGTjxybTyMSG/kO1v31qwWxTLHTAUlLarFana3g3HypwfwLW8sjfqP7v
         U0kPqyT19555uzQJBinfjrSOkQGGxHDaxZJgyXU4tDqNxrHksF3EstiO2mbVSJQDuzXs
         C/WhsKShbvHNmv0+aMmxnDrLnyRT7eAzkBpzBnK2hgMHv7b6gb6KFjd9Q4piTO0jAjxk
         EvEQ==
X-Gm-Message-State: AOAM531ZYg4TIxt9IkFLx7kCMAPwUWLMQiTdyQIPJaz7CLfKjJUwNkjv
        UfupmOSCLQmkukixF7JEZrdS36p1sv8CEvgzj+E=
X-Google-Smtp-Source: ABdhPJzhgQ80dq40lymKCZ8Z+HJsqjREQbOBgVF8a+ZayzL71Dbka8vh5QAgszbtM78VWuDnnQuS2o4ZzQt4vir4F/4=
X-Received: by 2002:a63:f10b:: with SMTP id f11mr4779290pgi.203.1623848541472;
 Wed, 16 Jun 2021 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkENw-TUC85hUMTJnkm2zvsk_NR_+8f3XngWaNGAWLkD8MNJA@mail.gmail.com>
 <20210614115938.07a922d3@jic23-huawei> <67472b6c-6dc1-23ef-4b47-aeb31e586c55@metafoo.de>
In-Reply-To: <67472b6c-6dc1-23ef-4b47-aeb31e586c55@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Jun 2021 16:02:05 +0300
Message-ID: <CAHp75VcGLB6hNKd0Pn-u9HzNO-+BLL+OU+uzjgY6+924jYT6BQ@mail.gmail.com>
Subject: Re: using dma buffers for SPI adcs
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alex Roberts <alex.roberts@ieee.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 15, 2021 at 12:37 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 6/14/21 12:59 PM, Jonathan Cameron wrote:
> > On Sat, 12 Jun 2021 19:33:32 -0500
> > Alex Roberts <alex.roberts@ieee.org> wrote:
> >
> >> Hello,
> >>
> >> I am learning how to use and write iio device drivers for ADCs. It seems
> >> most of the support is tied to FPGA based SoCs where ADCs can make use of
> >> Analog Devices SPI Engine and AXI IP. I'm looking at the AD7768-1 driver on
> >> the Analog Devices fork for example.
> >>
> >> How does one use dma buffers for generic ARM processors for an ADC attached
> >> to a dma-enabled SPI port.. for example a Beaglebone Black or Raspberry PI?
> >> Is this even possible or something that makes sense? The goal is of course
> >> to use DMA to avoid interrupting the processor for every conversion.
> >>
> >> I tried using the ADI driver, but get a ENODEV error when requesting the
> >> dma channel because there is not a "dmas" entry in the device tree node for
> >> the ADC, however it's parent SPI node does have dma entries.
> >>
> >> Thanks,
> >> Alex.
> > Hi Alex,
> >
> > I'll take a stab at answering this.
> >
> > So the key thing here is that it's 'normally' not that easy to get a
> > DMA enabled SPI port to act like a fully fledged DMA engine suitable for
> > autonomous use streaming data into RAM.  They tend to be much more focused
> > on simple transfers needed for SPI itself.  Sometimes they are capable of
> > simple streaming but not in a remotely generic fashion.
> >
> > Thus to use a DMA engine to do SPI based ADC transfers you need something
> > a bit cleverer. The Analog Device SPI Engine is effectively an offload engine
> > for SPI ADC management.  IIRC you set it up to sample a cyclic set of channels
> > and it generates all the writes needed to the device to make those happen
> > + packs the data in to DMA buffers (large contiguous memory regions in RAM).
> >
> > It's possible that a generic board might have a smart enough SPI implementation
> > to do this, but I'm not aware of it being possible on the BBB or RaspberryPi.
> >
> > I vaguely remember some discussions a long time back about using the PRU on
> > the BBB to implement this sort of functionality, but can't remember where
> > or when those happened :(  Possible IRC a long time back.
>
> That sums it up pretty nicely.
>
> The problem is you need support for executing the SPI transaction
> automatically in response to the trigger or data ready signal. Otherwise
> the interrupt overhead will overload the system once you go above a few
> kHz. I've seen some SoCs and Microcontrollers which support this, but no
> Linux support. Sometimes it is possible to use a controller that was
> more meant for audio use cases, but even then it needs to support more
> thatn what is required for just audio, so the list will be very short.
>
> The only alternative is to dedicate a full CPU to doing the SPI
> transfers and instead of using interrupts poll the data ready signal,
> this will reduce the overhead and latency itself. But the CPU will spend
> a lot of time busy waiting and not be able to do any other work. Some
> SoCs these days have smaller co-processors like a cortex-r5, these would
> be ideal candidates to implement this if they are not already busy doing
> something else.

On top of what guys already said, you need hardware assistance for that.
The simplest way is to use a SoC / platform that allows users to mux
Dreq Dack (DMA main signals) to be connected to the data provider in
question. In general we have SPI host controller to follow this schema
(that's why it can do transfers from and to SPI FIFO, but there are no
signals that anyhow can affect the Dreq / Dack from the outside. I
believe that such kind of hardware might exist, but it will be
specialized one for dedicated tasks (like Audio streaming).


-- 
With Best Regards,
Andy Shevchenko
