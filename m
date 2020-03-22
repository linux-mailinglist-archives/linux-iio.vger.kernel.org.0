Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0B18E98E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCVPP7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCVPP7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:15:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1079220724;
        Sun, 22 Mar 2020 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584890159;
        bh=0kLQ8SZT6fi5PlbGvkx9sA9jLe7XK5mmnp7GNjGyLZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EQlaeglv9LS5i23NWi0MRzxqoWrZJbUQqmwHrtxthsPIHO5WDVcgslrkyvBl5EABk
         +jMFp2hZye7ReedMO5/68WhJ206wGiJYH4iVERas4u4yIgaelAL+v4vXHOmYX1bvU/
         MKAqelyRo2cPYySBiQZgGr9PautDfPMg2N5W6m3w=
Date:   Sun, 22 Mar 2020 15:15:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7793: use read_avail iio hook for
 scale available
Message-ID: <20200322151554.2c204c49@archlinux>
In-Reply-To: <5ae09f8526a8847cb45435aa5280f905956ff588.camel@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
        <20200321090802.11537-5-alexandru.ardelean@analog.com>
        <20200321193726.GA2813151@smile.fi.intel.com>
        <5ae09f8526a8847cb45435aa5280f905956ff588.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 09:18:13 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2020-03-21 at 21:37 +0200, Andy Shevchenko wrote:
> > [External]
> > 
> > On Sat, Mar 21, 2020 at 11:08:02AM +0200, Alexandru Ardelean wrote:  
> > > This change uses the read_avail and '.info_mask_shared_by_type_available'
> > > modifier to set the available scale.
> > > Essentially, nothing changes to the driver's ABI.
> > > 
> > > The main idea for this patch is to remove the AD7793 driver from
> > > checkpatch's radar. There have been about ~3 attempts to fix/break the
> > > 'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
> > > it to be an arithmetic operation and people were trying to change that.
> > > +static int ad7793_read_avail(struct iio_dev *indio_dev,
> > > +			     struct iio_chan_spec const *chan,
> > > +			     const int **vals, int *type, int *length,
> > > +			     long mask)
> > >  {
> > >  	struct ad7793_state *st = iio_priv(indio_dev);
> > >  
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*vals = (int *)st->scale_avail;
> > > +		*type = IIO_VAL_INT_PLUS_NANO;
> > > +		/* Values are stored in a 2D matrix  */
> > > +		*length = ARRAY_SIZE(st->scale_avail) * 2;
> > >  
> > > +		return IIO_AVAIL_LIST;
> > > +	}
> > >  
> > > +	return -EINVAL;  
> > 
> > Wouldn't be better move this under default case?
> >   
> 
> Ummm, sure.
> I'm a bit vague how we do from here since Jonathan accepted this and the
> patchset.
> I'll send a V3 of the whole set [in a few days max].

I'll drop this last patch.  Just resend this one with the change.

Jonathan

