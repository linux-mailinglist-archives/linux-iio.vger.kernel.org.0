Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20479476BCC
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 09:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhLPIWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 16 Dec 2021 03:22:39 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56747 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLPIWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 03:22:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A09F1240008;
        Thu, 16 Dec 2021 08:22:36 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:22:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
Message-ID: <20211216092235.56e69441@xps13>
In-Reply-To: <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-5-miquel.raynal@bootlin.com>
        <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:47:02 +0200:

> On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > This is an internal variable of the core, let's use the
> > iio_buffer_enabled() helper which is exported for the following purpose:
> > telling if the current mode is a buffered mode, which is precisely what
> > this driver looks for.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index 1cfefb3b5e56..a3b8827d3bbf 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
> >          * In continuous mode, use fast mode configuration,
> >          * if it provides a better resolution.
> >          */
> > -       if (adc->nconv == 1 && !trig &&
> > -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> > +       if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {  
> 
> This may become tricky if other modes get added later.
> STM does a relatively good job in updating and re-using their drivers
> (even if some of them do look quirky sometimes).
> 
> So, the question here would be: is "iio_buffer_enabled(indio_dev)"
> going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
> INDIO_BUFFER_HARDWARE get added?

I would argue, is this a real problem? Today iio_buffer_enabled() seem
to handle well what this driver is expecting. If tomorrow someone adds
another mode, that is his/her responsibility to state "okay, this
section is not common to all buffer styles *anymore*, so we need to do
a more fine grained check against ->currentmodes than
iio_buffer_enabled() does". In that case using the ->currentmodes
getter would be the right way to go, but only at that particular
moment, not today.

> 
> I'd also ping some STM people for some feedback, acks or testing.
> 
> >                 if (fl->flo[1].res >= fl->flo[0].res) {
> >                         fl->fast = 1;
> >                         flo = &fl->flo[1];
> > @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
> >                 cr1 = DFSDM_CR1_RCH(chan->channel);
> >
> >                 /* Continuous conversions triggered by SPI clk in buffer mode */
> > -               if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> > +               if (iio_buffer_enabled(indio_dev))
> >                         cr1 |= DFSDM_CR1_RCONT(1);
> >
> >                 cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
> > --
> > 2.27.0
> >  


Thanks,
Miquèl
