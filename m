Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CC1DD5D8
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgEUST1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgEUST1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:19:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A4E20738;
        Thu, 21 May 2020 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590085166;
        bh=N5CsmBgzgRJ1qoSjQJyCqgE9IOj3hAVxpxWnjwMHcOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sid+RAofpJhvVSePV8bzGp+OZMlEJfxE7e+9xOWfDmVLegyKQnOgPc3nSTCPsC5hP
         cA1F18rZmRreoph12CkIhK+B3aUHnjMRyG2RXLt2QMgmjtjzVIok24QNlTbalhEa/0
         Yn+IsceiGCdvPfkRTpU8D7Sf3FEzdiKaCkv9zVdc=
Date:   Thu, 21 May 2020 19:19:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] iio: at91_adc: pass ref to IIO device via param
 for int function
Message-ID: <20200521191921.11473cba@archlinux>
In-Reply-To: <99993df0dce7f7561e9659985265d6c1f5839208.camel@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-4-alexandru.ardelean@analog.com>
        <20200516181749.243c9515@archlinux>
        <99993df0dce7f7561e9659985265d6c1f5839208.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 08:32:11 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2020-05-16 at 18:17 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Thu, 14 May 2020 16:17:05 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > Since there will be some changes to how iio_priv_to_dev() is implemented,
> > > it could be that the helper becomes a bit slower, as it will be hidden away
> > > in the IIO core.
> > > 
> > > For this driver, the IIO device can be passed directly as a parameter to
> > > the at91_ts_sample() function, thus making it immune to the change of
> > > iio_priv_to_dev().
> > > The function gets called in an interrupt context.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > I wonder. Should we just pass the struct device?  It's only used for
> > error printing I think, so we could make that explicit.  
> 
> I was also thinking that for this series, [for some drivers] it would make sense
> to put a reference to indio_dev on the state-struct; and just return it.
> I'll see about it.
> I am feeling that sometimes these IIO core cleanups end up being more than I
> want to do. But I'll try to see about it. Maybe I can make time or delegate some
> of this.

Absolutely understood.  No problem if you don't have time / energy to
do this stuff.  I very much appreciate it when you do, but I know how
unrewarding it can be!

> 
> My personal interest with them, is to reduce my complaints during reviews.
> People starting to write IIO drivers: well, I can see their frustration [on
> their faces] when I complain that they shouldn't use something, and they copied
> it from somewhere.
> 

That's more or less the only reason I write IIO patches currently!
Though I get to mostly avoid seeing the faces of those who fall
into the traps of old code we should have tidied up years ago :(
Not gotten near any of new hardware pile of IIO hardware in a long time.
Plenty of other new hardware, but not IIO stuff!

Jonathan

> 
> > 
> > I'm not that bothered either way though.
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/adc/at91_adc.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > > index 0368b6dc6d60..5999defe47cd 100644
> > > --- a/drivers/iio/adc/at91_adc.c
> > > +++ b/drivers/iio/adc/at91_adc.c
> > > @@ -287,13 +287,12 @@ static void handle_adc_eoc_trigger(int irq, struct
> > > iio_dev *idev)
> > >  	}
> > >  }
> > >  
> > > -static int at91_ts_sample(struct at91_adc_state *st)
> > > +static int at91_ts_sample(struct iio_dev *idev, struct at91_adc_state *st)
> > >  {
> > >  	unsigned int xscale, yscale, reg, z1, z2;
> > >  	unsigned int x, y, pres, xpos, ypos;
> > >  	unsigned int rxp = 1;
> > >  	unsigned int factor = 1000;
> > > -	struct iio_dev *idev = iio_priv_to_dev(st);
> > >  
> > >  	unsigned int xyz_mask_bits = st->res;
> > >  	unsigned int xyz_mask = (1 << xyz_mask_bits) - 1;
> > > @@ -449,7 +448,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void
> > > *private)
> > >  
> > >  		if (status & AT91_ADC_ISR_PENS) {
> > >  			/* validate data by pen contact */
> > > -			at91_ts_sample(st);
> > > +			at91_ts_sample(idev, st);
> > >  		} else {
> > >  			/* triggered by event that is no pen contact, just read
> > >  			 * them to clean the interrupt and discard all.  

