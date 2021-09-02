Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2D3FEB2C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbhIBJ10 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 05:27:26 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:62203 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbhIBJ1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 05:27:25 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E1E9740006;
        Thu,  2 Sep 2021 09:26:25 +0000 (UTC)
Date:   Thu, 2 Sep 2021 11:26:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/16] iio: adc: max1027: Introduce an end of conversion
 helper
Message-ID: <20210902112619.248bca16@xps13>
In-Reply-To: <SJ0PR03MB635976F76F5121FFF26E858B99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-13-miquel.raynal@bootlin.com>
        <SJ0PR03MB635976F76F5121FFF26E858B99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

"Sa, Nuno" <Nuno.Sa@analog.com> wrote on Fri, 20 Aug 2021 07:28:17
+0000:

> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Wednesday, August 18, 2021 1:12 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; Miquel Raynal
> > <miquel.raynal@bootlin.com>
> > Subject: [PATCH 12/16] iio: adc: max1027: Introduce an end of
> > conversion helper
> > 
> > [External]
> > 
> > For now this helper only waits for the maximum duration of a
> > conversion,
> > but it will soon be improved to properly handle the end of conversion
> > interrupt.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index afc3ce69f7ea..2d6485591761 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -60,6 +60,9 @@
> >  #define MAX1027_NAVG_32   (0x03 << 2)
> >  #define MAX1027_AVG_EN    BIT(4)
> > 
> > +/* Device can achieve 300ksps so we assume a 3.33us conversion
> > delay */
> > +#define MAX1027_CONVERSION_UDELAY 4
> > +
> >  enum max1027_id {
> >  	max1027,
> >  	max1029,
> > @@ -236,6 +239,20 @@ struct max1027_state {
> >  	u8				reg ____cacheline_aligned;
> >  };
> > 
> > +static DECLARE_WAIT_QUEUE_HEAD(max1027_queue);
> > +
> > +static int max1027_wait_eoc(struct iio_dev *indio_dev)
> > +{
> > +	unsigned int conversion_time =
> > MAX1027_CONVERSION_UDELAY;
> > +
> > +	if (indio_dev->active_scan_mask)
> > +		conversion_time *= hweight32(*indio_dev-  
> > >active_scan_mask);  
> > +
> > +	usleep_range(conversion_time, conversion_time * 2);
> > +
> > +	return 0;
> > +}
> > +
> >  /* Scan from 0 to the highest requested channel */
> >  static int max1027_configure_chans_to_scan(struct iio_dev
> > *indio_dev)
> >  {
> > @@ -310,9 +327,11 @@ static int max1027_read_single_value(struct
> > iio_dev *indio_dev,
> >  	/*
> >  	 * For an unknown reason, when we use the mode "10" (write
> >  	 * conversion register), the interrupt doesn't occur every time.
> > -	 * So we just wait 1 ms.
> > +	 * So we just wait the maximum conversion time and deliver
> > the value.
> >  	 */
> > -	mdelay(1);
> > +	ret = max1027_wait_eoc(indio_dev);
> > +	if (ret)
> > +		return ret;  
> 
> I'm a bit confused here... Why are we looking at the active_scan_mask?
> Aren't we preventing this for running concurrently with buffering?

Sorry for the confusion, at this stage the "if (active_masks)" is
useless, I moved it later in the series when we actually start to use
this EOC helper for the buffered reads as well.

Thanks,
Miquèl
