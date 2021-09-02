Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3353FF003
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbhIBPWC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 11:22:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52117 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhIBPWC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 11:22:02 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4259C10000A;
        Thu,  2 Sep 2021 15:21:01 +0000 (UTC)
Date:   Thu, 2 Sep 2021 17:21:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/16] iio: adc: max1027: Support software triggers
Message-ID: <20210902172100.3200b3b6@xps13>
In-Reply-To: <20210830115046.3727ccc4@jic23-huawei>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-16-miquel.raynal@bootlin.com>
        <20210830115046.3727ccc4@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Mon, 30 Aug 2021 11:50:46
+0100:

> On Wed, 18 Aug 2021 13:11:38 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Now that max1027_trigger_handler() has been freed from handling hardware
> > triggers EOC situations, we can use it for what it has been designed in
> > the first place: trigger software originated conversions.  
> 
> As mentioned earlier, this is not how I'd normally expect this sort of
> case to be handled. I'd be expecting the cnvst trigger to still be calling
> this function and the function to do the relevant check to ensure it
> knows the data is already available in that case.

I tried to follow your advice and Nuno's regarding this, I hope the new
version will match your expectations (new version coming soon).
However if my changes do not match, I will probably need more guidance
to understand in deep what you suggest.

> > In other
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
> > @@ -413,17 +413,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
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
> >  static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
> >  {
> >  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > @@ -512,7 +501,21 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
> >  
> >  	pr_debug("%s(irq=%d, private=0x%p)\n", __func__, irq, private);
> >  
> > +	ret = max1027_configure_trigger(indio_dev);  
> 
> I'd not expect to see this ever time.  The configuration shouldn't change
> from one call of this function to the next.

True, this is not needed.

> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = max1027_configure_chans_to_scan(indio_dev);  
> 
> This should also not change unless it is also responsible for the 'go' signal.
> If that's true then it is badly named.

It's responsible for the go signal, I renamed it "configure_and_start".

However, just for my own understanding, when would I be supposed to
configure the channels requested by the user otherwise?

Thanks,
Miquèl
