Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37AC3FD4FD
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhIAINM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 1 Sep 2021 04:13:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56891 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbhIAINL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 04:13:11 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 339C760005;
        Wed,  1 Sep 2021 08:12:10 +0000 (UTC)
Date:   Wed, 1 Sep 2021 10:12:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/16] iio: adc: max1027: Push only the requested
 samples
Message-ID: <20210901101209.31703187@xps13>
In-Reply-To: <MW4PR03MB6363BC976F039550906B6ED399CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-4-miquel.raynal@bootlin.com>
        <SJ0PR03MB6359415E120CFD3EFAF417F599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
        <20210830110756.733d5201@jic23-huawei>
        <MW4PR03MB6363FE3BAF40A383D244ADC399CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
        <20210830152956.58331a8d@jic23-huawei>
        <MW4PR03MB6363BC976F039550906B6ED399CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

"Sa, Nuno" <Nuno.Sa@analog.com> wrote on Mon, 30 Aug 2021 15:02:26
+0000:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday, August 30, 2021 4:30 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Thomas Petazzoni
> > <thomas.petazzoni@bootlin.com>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 03/16] iio: adc: max1027: Push only the requested
> > samples
> > 
> > [External]
> > 
> > On Mon, 30 Aug 2021 10:49:50 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Monday, August 30, 2021 12:08 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>; Lars-Peter  
> > Clausen  
> > > > <lars@metafoo.de>; Thomas Petazzoni
> > > > <thomas.petazzoni@bootlin.com>; linux-iio@vger.kernel.org;  
> > linux-  
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 03/16] iio: adc: max1027: Push only the  
> > requested  
> > > > samples
> > > >
> > > > [External]
> > > >
> > > > On Fri, 20 Aug 2021 07:10:48 +0000
> > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > >  
> > > > > > -----Original Message-----
> > > > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > Sent: Wednesday, August 18, 2021 1:11 PM
> > > > > > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > > > > > <lars@metafoo.de>
> > > > > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > > > > > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Miquel  
> > Raynal  
> > > > > > <miquel.raynal@bootlin.com>
> > > > > > Subject: [PATCH 03/16] iio: adc: max1027: Push only the  
> > requested  
> > > > > > samples
> > > > > >
> > > > > > [External]
> > > > > >
> > > > > > When a triggered scan occurs, the identity of the desired  
> > channels  
> > > > is  
> > > > > > known in indio_dev->active_scan_mask. Instead of reading and
> > > > > > pushing to
> > > > > > the IIO buffers all channels each time, scan the minimum  
> > amount  
> > > > of  
> > > > > > channels (0 to maximum requested chan, to be exact) and only
> > > > > > provide the
> > > > > > samples requested by the user.
> > > > > >
> > > > > > For example, if the user wants channels 1, 4 and 5, all channels  
> > > > from  
> > > > > > 0 to 5 will be scanned but only the desired channels will be  
> > pushed  
> > > > to  
> > > > > > the IIO buffers.
> > > > > >
> > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > ---
> > > > > >  drivers/iio/adc/max1027.c | 25 +++++++++++++++++++++----
> > > > > >  1 file changed, 21 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/adc/max1027.c  
> > b/drivers/iio/adc/max1027.c  
> > > > > > index b753658bb41e..8ab660f596b5 100644
> > > > > > --- a/drivers/iio/adc/max1027.c
> > > > > > +++ b/drivers/iio/adc/max1027.c
> > > > > > @@ -360,6 +360,9 @@ static int  
> > max1027_set_trigger_state(struct  
> > > > > > iio_trigger *trig, bool state)
> > > > > >  	struct max1027_state *st = iio_priv(indio_dev);
> > > > > >  	int ret;
> > > > > >
> > > > > > +	if (bitmap_empty(indio_dev->active_scan_mask,  
> > indio_dev-  
> > > > > > >masklength))  
> > > > > > +		return -EINVAL;
> > > > > > +  
> > > > >
> > > > > I'm not sure this can actually happen. If you try to enable the  
> > buffer  
> > > > > with no scan element, it should give you an error before you  
> > reach  
> > > > > this point...
> > > > >  
> > > > > >  	if (state) {
> > > > > >  		/* Start acquisition on cnvst */
> > > > > >  		st->reg = MAX1027_SETUP_REG |
> > > > > > MAX1027_CKS_MODE0 |
> > > > > > @@ -368,9 +371,12 @@ static int  
> > max1027_set_trigger_state(struct  
> > > > > > iio_trigger *trig, bool state)
> > > > > >  		if (ret < 0)
> > > > > >  			return ret;
> > > > > >
> > > > > > -		/* Scan from 0 to max */
> > > > > > -		st->reg = MAX1027_CONV_REG |  
> > MAX1027_CHAN(0) |  
> > > > > > -			  MAX1027_SCAN_N_M |  
> > MAX1027_TEMP;  
> > > > > > +		/*
> > > > > > +		 * Scan from 0 to the highest requested  
> > channel. The  
> > > > > > temperature
> > > > > > +		 * could be avoided but it simplifies a bit the  
> > logic.  
> > > > > > +		 */
> > > > > > +		st->reg = MAX1027_CONV_REG |
> > > > > > MAX1027_SCAN_0_N | MAX1027_TEMP;
> > > > > > +		st->reg |= MAX1027_CHAN(fls(*indio_dev-  
> > > > > > >active_scan_mask) - 2);  
> > > > > >  		ret = spi_write(st->spi, &st->reg, 1);
> > > > > >  		if (ret < 0)
> > > > > >  			return ret;
> > > > > > @@ -391,11 +397,22 @@ static irqreturn_t
> > > > > > max1027_trigger_handler(int irq, void *private)
> > > > > >  	struct iio_poll_func *pf = private;
> > > > > >  	struct iio_dev *indio_dev = pf->indio_dev;
> > > > > >  	struct max1027_state *st = iio_priv(indio_dev);
> > > > > > +	unsigned int scanned_chans = fls(*indio_dev-  
> > > > > > >active_scan_mask);  
> > > > > > +	u16 *buf = st->buffer;  
> > > > >
> > > > > I think sparse will complain here. buffer is a __be16 restricted
> > > > > type so you should not mix those...  
> > > > > > +	unsigned int bit;
> > > > > >
> > > > > >  	pr_debug("%s(irq=%d, private=0x%p)\n", __func__,  
> > irq,  
> > > > > >  
> > > >  
> > private);in/20210818_miquel_raynal_bring_software_triggers_support  
> > > > _to_max1027_like_adcs.mbx  
> > > > > >
> > > > > >  	/* fill buffer with all channel */
> > > > > > -	spi_read(st->spi, st->buffer, indio_dev->masklength *  
> > 2);  
> > > > > > +	spi_read(st->spi, st->buffer, scanned_chans * 2);
> > > > > > +
> > > > > > +	/* Only keep the channels selected by the user */
> > > > > > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > > > > +			 indio_dev->masklength) {
> > > > > > +		if (buf[0] != st->buffer[bit])
> > > > > > +			buf[0] = st->buffer[bit];  
> > > > >
> > > > > Since we are here, when looking into the driver, I realized
> > > > > that st->buffer is not DMA safe. In IIO, we kind of want to  
> > enforce  
> > > > > that all buffers that are passed to spi/i2c buses are safe... Maybe
> > > > > this is something you can include in your series.  
> > > >
> > > > Why is it not?  st->buffer is result of a devm_kmalloc_array() call  
> > and  
> > > > that should provide a DMA safe buffer as I understand it.
> > > >  
> > >
> > > That's a good question. I'm not sure how I came to that conclusion  
> > which  
> > > is clearly wrong. Though I think the buffer might share the line with  
> > the  
> > > mutex...  
> > Pointer shares a line.  The buffer it points to doesn't as allocated
> > by separate heap allocation.
> >   
> 
> Ups, sure :facepalm:

My understanding [1] was that devm_ allocations were generally not
suitable for DMA and should not be used for this particular purpose
because of the extra 16 bytes allocated for storing the devm magic
somewhere, which shifts the entire buffer and prevents it to always be
aligned on a cache line. I will propose a patch to switch to
kmalloc_array() instead.

[1] https://linux-arm-kernel.infradead.narkive.com/vyJqy0RQ/question-devm-kmalloc-for-dma

Thanks,
Miquèl
