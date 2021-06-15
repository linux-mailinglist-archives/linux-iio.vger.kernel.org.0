Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267573A7AC3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFOJiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 05:38:21 -0400
Received: from www381.your-server.de ([78.46.137.84]:56692 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFOJiU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jun 2021 05:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9f0hlLKRiRu7JDnIcZ2U8trxQzEuRLNEN1gEv+M4mJs=; b=XKCt2LxMeQCzLy5QnkDh8VYEh0
        k93gQZ4/GwEYryL+eWGxXK6th5gutVZUF+SE3Fpp4vyM9rw1YCqG0jC7sS8F0WVvhrMF43024S4jn
        MRt1h4smY/zI6YIG+tvN2lLR2RcMhS3ac3mo5zP0h3Q8Fq/7nc92otS5JO3z9VNhhz0UH6PrdUdKL
        bxwgb/pNRBaarMoo2M4yE7pPp9WhuKP0A60sRLSUpdO/qsJ7ajws2ROqJcEK/Nh8lzsPwwOXJtJJB
        1sI1RHmRHuIKRiC9xJjngooQM9+iq1mEvP3/XLCWYz+exGgNMqgJYTnFVIXfIpcJTd7mRPm8uuzXN
        AJ+VHFTg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lt5UT-0003GQ-S6; Tue, 15 Jun 2021 11:36:13 +0200
Received: from [2001:a61:2bdf:6601:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lt5UT-000Hkq-O0; Tue, 15 Jun 2021 11:36:13 +0200
Subject: Re: using dma buffers for SPI adcs
To:     Jonathan Cameron <jic23@kernel.org>,
        Alex Roberts <alex.roberts@ieee.org>
Cc:     linux-iio@vger.kernel.org
References: <CAPkENw-TUC85hUMTJnkm2zvsk_NR_+8f3XngWaNGAWLkD8MNJA@mail.gmail.com>
 <20210614115938.07a922d3@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <67472b6c-6dc1-23ef-4b47-aeb31e586c55@metafoo.de>
Date:   Tue, 15 Jun 2021 11:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210614115938.07a922d3@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26201/Mon Jun 14 13:07:08 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/14/21 12:59 PM, Jonathan Cameron wrote:
> On Sat, 12 Jun 2021 19:33:32 -0500
> Alex Roberts <alex.roberts@ieee.org> wrote:
>
>> Hello,
>>
>> I am learning how to use and write iio device drivers for ADCs. It seems
>> most of the support is tied to FPGA based SoCs where ADCs can make use of
>> Analog Devices SPI Engine and AXI IP. I'm looking at the AD7768-1 driver on
>> the Analog Devices fork for example.
>>
>> How does one use dma buffers for generic ARM processors for an ADC attached
>> to a dma-enabled SPI port.. for example a Beaglebone Black or Raspberry PI?
>> Is this even possible or something that makes sense? The goal is of course
>> to use DMA to avoid interrupting the processor for every conversion.
>>
>> I tried using the ADI driver, but get a ENODEV error when requesting the
>> dma channel because there is not a "dmas" entry in the device tree node for
>> the ADC, however it's parent SPI node does have dma entries.
>>
>> Thanks,
>> Alex.
> Hi Alex,
>
> I'll take a stab at answering this.
>
> So the key thing here is that it's 'normally' not that easy to get a
> DMA enabled SPI port to act like a fully fledged DMA engine suitable for
> autonomous use streaming data into RAM.  They tend to be much more focused
> on simple transfers needed for SPI itself.  Sometimes they are capable of
> simple streaming but not in a remotely generic fashion.
>
> Thus to use a DMA engine to do SPI based ADC transfers you need something
> a bit cleverer. The Analog Device SPI Engine is effectively an offload engine
> for SPI ADC management.  IIRC you set it up to sample a cyclic set of channels
> and it generates all the writes needed to the device to make those happen
> + packs the data in to DMA buffers (large contiguous memory regions in RAM).
>
> It's possible that a generic board might have a smart enough SPI implementation
> to do this, but I'm not aware of it being possible on the BBB or RaspberryPi.
>
> I vaguely remember some discussions a long time back about using the PRU on
> the BBB to implement this sort of functionality, but can't remember where
> or when those happened :(  Possible IRC a long time back.

That sums it up pretty nicely.

The problem is you need support for executing the SPI transaction 
automatically in response to the trigger or data ready signal. Otherwise 
the interrupt overhead will overload the system once you go above a few 
kHz. I've seen some SoCs and Microcontrollers which support this, but no 
Linux support. Sometimes it is possible to use a controller that was 
more meant for audio use cases, but even then it needs to support more 
thatn what is required for just audio, so the list will be very short.

The only alternative is to dedicate a full CPU to doing the SPI 
transfers and instead of using interrupts poll the data ready signal, 
this will reduce the overhead and latency itself. But the CPU will spend 
a lot of time busy waiting and not be able to do any other work. Some 
SoCs these days have smaller co-processors like a cortex-r5, these would 
be ideal candidates to implement this if they are not already busy doing 
something else.

- Lars

