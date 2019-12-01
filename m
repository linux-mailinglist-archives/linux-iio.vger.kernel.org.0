Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0450129902
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWRBB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 23 Dec 2019 12:01:01 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34802 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLWRBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 12:01:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 648B79E759C;
        Mon, 23 Dec 2019 17:00:59 +0000 (GMT)
Date:   Sun, 1 Dec 2019 12:03:45 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lars =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>,
        linux-iio@vger.kernel.org
Subject: Re: iio_compute_scan_bytes does not seem to account for alignment
 if first channel uses more storagebits than its successors
Message-ID: <20191201120345.69160e18@archlinux>
In-Reply-To: <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
References: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
        <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 18:23:37 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 11/29/19 3:30 PM, Lars Möllendorf wrote:
> > Hi,
> > 
> > I have written a custom kernel module implementing the IIO device API
> > backed by an IIO triggered buffer.
> > 
> > My IIO device provides 3 channels + timestamp. The sizes of the channels are
> > 
> > index  | iio_chan_spec.scan_type.storagebits
> > -------|------------------------------------------------
> >    0   |  32
> >    1   |  16
> >    2   |  16
> > 
> > If I select channel 0 (32bit) and one of channel 1 or 2 (16bit)
> > indio_dev.scan_bytes and iio_buffer.bytes_per_datum have a value of 6
> > Byte which does not account for any alignment.
> > 
> > 
> > After having a closer look at  `iio_compute_scan_bytes` which is
> > responsible for calculating both, `indio_dev.scan_bytes` and
> > `iio_buffer.bytes_per_datum` it seems to me that the order of channels
> > matter:
> > 
> > ```c
> > 	/* How much space will the demuxed element take? */
> > 	for_each_set_bit(i, mask,
> > 			 indio_dev->masklength) {
> > 		length = iio_storage_bytes_for_si(indio_dev, i);
> > 		bytes = ALIGN(bytes, length);
> > 		bytes += length;
> > 	}
> > ```
> > 
> > I understand that in case the length of each scan element is smaller
> > then the length of the successive scan elements, this algorithm works
> > because it aligns the current element to its own length. But if, as in
> > my case, the length of channel 0's scan elements  is greater then the
> > size of the samples of the consecutive channels no alignment seems to be
> > taken into account. Do I miss something here?  
> [...]
> > But in my case the latter would bloat the buffer from 16 Byte to 4*16 =
> > 64 Byte per scan if all channels are selected and timestamp is active.
> > 
> > For now, I will work around this by using 32 storagebits for all my
> > channels. This gives my 4 Bytes of overhead per scan if all elements are
> > selected and additional 2 Byte if timestamp is active.
> > 
> > In "Why do you align the buffer pointer to a multiple of the size of the
> > current scan element in iio_buffer_foreach_sample()?" on
> > https://github.com/analogdevicesinc/libiio/issues/324 I have been
> > pointed to this mailing list.  
> 
> Hi Lars,
> 
> The way this is supposed to work is that each element is aligned to its
> own natural alignment. What seems to be missing at the moment is that
> the total length is also aligned to the size of the first element, so
> that alignment is preserved for multiple consecutive samples. I feel
> like we had that at some point, but maybe I'm misremembering.
> 
> E.g. putting something like
> 
>  unsigned int first_index = find_first_bit(mask, indio_dev->masklength);
>  length = iio_storage_bytes_for_si(indio_dev, first_index);
>  bytes = ALIGN(bytes, length);
> 
> below the loop should do the trick I believe.

Good find by the way.  Not sure how we never hit this before as there
are definitely sensors out there with similar mixes to you have.
Maybe they are always used with the timestamp enabled?  Anyhow, no
matter it's clearly wrong.

Lars trick doesn't work either (I think) as we can have

u16
u16 (might be padding or real channel)
u32
u16

which should be 4 byte aligned.

I think we need to keep track of the largest element present during
the loop and use that length afterwards to pad out the end, but only
the end rather than every element.  In theory we can also have
larger elements than the timestamp, so should not do special handling
for that, it's just another element.

I think that ends up effectively a combination of the two suggestions?

Jonathan

> 
> - Lars
> 

