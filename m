Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA540C318
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhIOJ42 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 15 Sep 2021 05:56:28 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40245 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhIOJ42 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 05:56:28 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C47BB20014;
        Wed, 15 Sep 2021 09:55:06 +0000 (UTC)
Date:   Wed, 15 Sep 2021 11:55:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 14/16] iio: adc: max1027: Don't just sleep when the
 EOC interrupt is available
Message-ID: <20210915115505.1df4ef4d@xps13>
In-Reply-To: <SA1PR03MB6355578764364F98D3FF163A99D29@SA1PR03MB6355.namprd03.prod.outlook.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-15-miquel.raynal@bootlin.com>
        <SA1PR03MB6355578764364F98D3FF163A99D29@SA1PR03MB6355.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

Nuno.Sa@analog.com wrote on Mon, 6 Sep 2021 09:38:02 +0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Thursday, September 2, 2021 11:15 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Miquel Raynal <miquel.raynal@bootlin.com>
> > Subject: [PATCH v2 14/16] iio: adc: max1027: Don't just sleep when the
> > EOC interrupt is available
> > 
> > [External]
> > 
> > The interrupt will fire upon end of conversion. This currently can
> > happen in two situations: either the cnvst trigger was enabled and
> > toggled, or a single read was requested and the data is ready. The first
> > situation is already covered while the second is not. Instead, a waiting
> > delay is applied. Let's handle these interrupts more properly by adding
> > second path in our EOC helper.
> > 
> > Rename the interrupt handler to a more generic name as it won't only
> > handle triggered situations.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index b85fe0a48ff9..e734d32a5507 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -256,15 +256,27 @@ struct max1027_state {
> >  	struct iio_trigger		*trig;
> >  	__be16				*buffer;
> >  	struct mutex			lock;
> > +	struct completion		complete;
> > 
> >  	u8				reg ____cacheline_aligned;
> >  };
> > 
> >  static int max1027_wait_eoc(struct iio_dev *indio_dev)
> >  {
> > +	struct max1027_state *st = iio_priv(indio_dev);
> >  	unsigned int conversion_time =
> > MAX1027_CONVERSION_UDELAY;
> > +	int ret;
> > 
> > -	usleep_range(conversion_time, conversion_time * 2);
> > +	if (st->spi->irq) {
> > +		ret = wait_for_completion_timeout(&st->complete,
> > +
> > msecs_to_jiffies(1000));
> > +		if (!ret)
> > +			return ret;
> > +
> > +		reinit_completion(&st->complete);  
> 
> I would call this before the waiting...

Sure, this is probably better.

Thanks,
Miquèl
