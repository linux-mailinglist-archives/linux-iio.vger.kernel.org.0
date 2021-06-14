Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12DC3A64BE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhFNL2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235477AbhFNL0Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:26:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13EF61078;
        Mon, 14 Jun 2021 10:57:38 +0000 (UTC)
Date:   Mon, 14 Jun 2021 11:59:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alex Roberts <alex.roberts@ieee.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: using dma buffers for SPI adcs
Message-ID: <20210614115938.07a922d3@jic23-huawei>
In-Reply-To: <CAPkENw-TUC85hUMTJnkm2zvsk_NR_+8f3XngWaNGAWLkD8MNJA@mail.gmail.com>
References: <CAPkENw-TUC85hUMTJnkm2zvsk_NR_+8f3XngWaNGAWLkD8MNJA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Jun 2021 19:33:32 -0500
Alex Roberts <alex.roberts@ieee.org> wrote:

> Hello,
> 
> I am learning how to use and write iio device drivers for ADCs. It seems
> most of the support is tied to FPGA based SoCs where ADCs can make use of
> Analog Devices SPI Engine and AXI IP. I'm looking at the AD7768-1 driver on
> the Analog Devices fork for example.
> 
> How does one use dma buffers for generic ARM processors for an ADC attached
> to a dma-enabled SPI port.. for example a Beaglebone Black or Raspberry PI?
> Is this even possible or something that makes sense? The goal is of course
> to use DMA to avoid interrupting the processor for every conversion.
> 
> I tried using the ADI driver, but get a ENODEV error when requesting the
> dma channel because there is not a "dmas" entry in the device tree node for
> the ADC, however it's parent SPI node does have dma entries.
> 
> Thanks,
> Alex.

Hi Alex,

I'll take a stab at answering this.

So the key thing here is that it's 'normally' not that easy to get a
DMA enabled SPI port to act like a fully fledged DMA engine suitable for
autonomous use streaming data into RAM.  They tend to be much more focused
on simple transfers needed for SPI itself.  Sometimes they are capable of
simple streaming but not in a remotely generic fashion.

Thus to use a DMA engine to do SPI based ADC transfers you need something
a bit cleverer. The Analog Device SPI Engine is effectively an offload engine
for SPI ADC management.  IIRC you set it up to sample a cyclic set of channels
and it generates all the writes needed to the device to make those happen
+ packs the data in to DMA buffers (large contiguous memory regions in RAM).

It's possible that a generic board might have a smart enough SPI implementation
to do this, but I'm not aware of it being possible on the BBB or RaspberryPi.

I vaguely remember some discussions a long time back about using the PRU on
the BBB to implement this sort of functionality, but can't remember where
or when those happened :(  Possible IRC a long time back.

Jonathan
