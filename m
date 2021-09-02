Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07E3FEADE
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbhIBI5W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 04:57:22 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:40853 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbhIBI5V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 04:57:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DD6D2240017;
        Thu,  2 Sep 2021 08:56:20 +0000 (UTC)
Date:   Thu, 2 Sep 2021 10:56:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/16] iio: adc: max1027: Prevent single channel
 accesses during buffer reads
Message-ID: <20210902105619.311e62d9@xps13>
In-Reply-To: <20210830112024.4583f3cb@jic23-huawei>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-11-miquel.raynal@bootlin.com>
        <SJ0PR03MB635942A6E93291B5134350B799C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
        <SJ0PR03MB6359DB255A253092BFDC04F499C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
        <20210830112024.4583f3cb@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Mon, 30 Aug 2021 11:20:24
+0100:

> On Fri, 20 Aug 2021 07:30:07 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> 
> > > -----Original Message-----
> > > From: Sa, Nuno <Nuno.Sa@analog.com>
> > > Sent: Friday, August 20, 2021 9:21 AM
> > > To: Miquel Raynal <miquel.raynal@bootlin.com>; Jonathan Cameron
> > > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH 10/16] iio: adc: max1027: Prevent single channel
> > > accesses during buffer reads
> > > 
> > > [External]
> > > 
> > > 
> > >     
> > > > -----Original Message-----
> > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Sent: Wednesday, August 18, 2021 1:12 PM
> > > > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > > > <lars@metafoo.de>
> > > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > > > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Miquel Raynal
> > > > <miquel.raynal@bootlin.com>
> > > > Subject: [PATCH 10/16] iio: adc: max1027: Prevent single channel
> > > > accesses during buffer reads
> > > >
> > > > [External]
> > > >
> > > > When hardware buffers are enabled (the cnvst pin being the    
> > > trigger),    
> > > > one
> > > > should not mess with the device state by requesting a single channel
> > > > read. Prevent it with a iio_buffer_enabled() check.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/iio/adc/max1027.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > > > index 223c9e4abd86..83526f3d7d3a 100644
> > > > --- a/drivers/iio/adc/max1027.c
> > > > +++ b/drivers/iio/adc/max1027.c
> > > > @@ -335,6 +335,8 @@ static int max1027_read_raw(struct iio_dev
> > > > *indio_dev,
> > > >
> > > >  	switch (mask) {
> > > >  	case IIO_CHAN_INFO_RAW:
> > > > +		if (iio_buffer_enabled(indio_dev))
> > > > +			return -EBUSY;    
> > > 
> > > I guess 'iio_device_claim_direct_mode()' would be a better option
> > > here? There's nothing preventing this check to pass and then,
> > > concurrently
> > > someone enables the buffer...
> > >     
> > 
> > Taking a second look, it seems that this check is already done [1]? Am I missing
> > I missing something?

You're right, I missed that too.

> > Also, I think we are returning with the 'st->lock' held...
> > 
> > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/max1027.c#L247  
> Absolutely agree this should be done with iio_device_claim_direct_mode() to close the
> possible races.

Didn't know this helper, nice.

> I wonder why this one has been missed in all the cleanups of that stuff? Looks like
> a simple case, but I guess it wasn't immediately visible in the read_raw() function
> so no one noticed.
> 
> Jonathan
> 

Thanks,
Miquèl
