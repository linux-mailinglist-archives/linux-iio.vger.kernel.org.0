Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7523FF74
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHIRSj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRSj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:18:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2AB3206C3;
        Sun,  9 Aug 2020 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993518;
        bh=DmmOjsza01cCSfRJpqdjVqoAkwqm/jP/fpcm2ODQJ4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bUJ4TlOSIs12mW7RN4Qf2WBJtki5VBZLuhW3sQZhNqQ0QaUgnaTsuvzBf3lhj923B
         gchvUvi5LBTAEP2k8yRNe5+f9lkXiSd9+xSLMYLHun0WoWnOyGTtHl3s0JYm7+ZEHY
         uMPjQXMNsbvUcmTzOJo0o/fYznsKJrYfodmN2Pos=
Date:   Sun, 9 Aug 2020 18:18:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 03/27] iio:accel:bmc150-accel: Fix timestamp
 alignment and prevent data leak.
Message-ID: <20200809181835.678e7a64@archlinux>
In-Reply-To: <a870c6cc8a498e46d06106be9d83e4f7cbebf717.camel@linux.intel.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-4-jic23@kernel.org>
        <a870c6cc8a498e46d06106be9d83e4f7cbebf717.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Jul 2020 10:12:36 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2020-07-22 at 16:50 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses a 16 byte array of smaller elements on the
> > stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving
> > to a suitable structure in the iio_priv() data with alignment
> > ensured by use of an explicit c structure.  This data is allocated
> > with kzalloc so no data can leak appart from previous readings.
> > 
> > Fixes tag is beyond some major refactoring so likely manual
> > backporting
> > would be needed to get that far back.
> > 
> > Whilst the force alignment of the ts is not strictly necessary, it
> > does make the code less fragile.
> > 
> > Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware
> > fifo")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c
> > b/drivers/iio/accel/bmc150-accel-core.c
> > index 24864d9dfab5..48435865fdaf 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -189,6 +189,14 @@ struct bmc150_accel_data {
> >  	struct mutex mutex;
> >  	u8 fifo_mode, watermark;
> >  	s16 buffer[8];
> > +	/*
> > +	 * Ensure there is sufficient space and correct alignment for
> > +	 * the timestamp if enabled
> > +	 */
> > +	struct {
> > +		__le16 channels[3];
> > +		s64 ts __aligned(8);
> > +	} scan;
> >  	u8 bw_bits;
> >  	u32 slope_dur;
> >  	u32 slope_thres;
> > @@ -922,15 +930,16 @@ static int __bmc150_accel_fifo_flush(struct
> > iio_dev *indio_dev,
> >  	 * now.
> >  	 */
> >  	for (i = 0; i < count; i++) {
> > -		u16 sample[8];
> >  		int j, bit;
> >  
> >  		j = 0;
> >  		for_each_set_bit(bit, indio_dev->active_scan_mask,
> >  				 indio_dev->masklength)
> > -			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
> > +			memcpy(&data->scan.channels[j++], &buffer[i * 3
> > + bit],
> > +			       sizeof(data->scan.channels[0]));
> >  
> > -		iio_push_to_buffers_with_timestamp(indio_dev, sample,
> > tstamp);
> > +		iio_push_to_buffers_with_timestamp(indio_dev, &data-  
> > >scan,  
> > +						   tstamp);
> >  
> >  		tstamp += sample_period;
> >  	}  
> 

