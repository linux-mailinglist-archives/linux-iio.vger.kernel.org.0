Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB843FEDC4
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbhIBMau convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 08:30:50 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:38461 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIBMau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 08:30:50 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 07C59C3F9A
        for <linux-iio@vger.kernel.org>; Thu,  2 Sep 2021 12:25:54 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2ED24C0002;
        Thu,  2 Sep 2021 12:25:32 +0000 (UTC)
Date:   Thu, 2 Sep 2021 14:25:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/16] iio: adc: max1027: Support software triggers
Message-ID: <20210902142526.55fca207@xps13>
In-Reply-To: <SJ0PR03MB63594E162F7246874CD1A72599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-16-miquel.raynal@bootlin.com>
        <SJ0PR03MB63594E162F7246874CD1A72599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

"Sa, Nuno" <Nuno.Sa@analog.com> wrote on Fri, 20 Aug 2021 07:58:25
+0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Wednesday, August 18, 2021 1:12 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: [PATCH 15/16] iio: adc: max1027: Support software triggers
> > 
> > [External]
> > 
> > Now that max1027_trigger_handler() has been freed from handling
> > hardware
> > triggers EOC situations, we can use it for what it has been designed in
> > the first place: trigger software originated conversions. In other
> > words, when userspace initiates a conversion with a sysfs trigger or a
> > hrtimer trigger, we must do all configuration steps, ie:
> > 1- Configuring the trigger
> > 2- Configuring the channels to scan
> > 3- Starting the conversion (actually done automatically by step 2 in
> >    this case)
> > 4- Waiting for the conversion to end
> > 5- Retrieving the data from the ADC
> > 6- Push the data to the IIO core and notify it
> > 
> > Add the missing steps to this helper and drop the trigger verification
> > hook otherwise software triggers would simply not be accepted at all.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index 8c5995ae59f2..bb437e43adaf 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -413,17 +413,6 @@ static int max1027_debugfs_reg_access(struct
> > iio_dev *indio_dev,
> >  	return spi_write(st->spi, val, 1);
> >  }
> > 
> > -static int max1027_validate_trigger(struct iio_dev *indio_dev,
> > -				    struct iio_trigger *trig)
> > -{
> > -	struct max1027_state *st = iio_priv(indio_dev);
> > -
> > -	if (st->trig != trig)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> >  static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig,
> > bool state)
> >  {
> >  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > @@ -512,7 +501,21 @@ static irqreturn_t max1027_trigger_handler(int
> > irq, void *private)
> > 
> >  	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq,
> > private);
> > 
> > +	ret = max1027_configure_trigger(indio_dev);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = max1027_configure_chans_to_scan(indio_dev);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = max1027_wait_eoc(indio_dev);
> > +	if (ret)
> > +		goto out;
> > +
> >  	ret = max1027_read_scan(indio_dev);  
> 
> There's something that I'm not getting... How are we checking that
> we have software triggers? This API is called only if the device
> allocates it's own trigger which will happen if there's a spi IRQ.
> 
> I'm probably missing something as this series is fairly big but the way
> I would do it is (in the probe):
> 
> - always call 'devm_iio_triggered_buffer_setup()' function and properly use
> buffer ops [1] (for example, you can use 'validate_scan_mask()' to setup the
> channels to read);  
> - only allocate a trigger if an IRQ is present in which case, we assume HW 
> triggering is supported.

I think these are the exact steps that are enforced in the next patch,
I can squash them if you wish but I think it makes sense to have it in
two steps.

Thanks,
Miquèl
