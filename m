Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108C127E490
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgI3JOG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 05:14:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59895 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3JOF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 05:14:05 -0400
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7C84C24000E;
        Wed, 30 Sep 2020 09:14:02 +0000 (UTC)
Date:   Wed, 30 Sep 2020 11:14:01 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 4/4] iio: adc: at91_adc: remove of_match_ptr() usage
Message-ID: <20200930091401.GE2804081@piout.net>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-5-alexandru.ardelean@analog.com>
 <20200930074728.GD2804081@piout.net>
 <CA+U=DsofSvQKwSQEye9ONYMJkKiL9er6sH2FTLH-5SgmmnPqOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsofSvQKwSQEye9ONYMJkKiL9er6sH2FTLH-5SgmmnPqOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/09/2020 11:46:06+0300, Alexandru Ardelean wrote:
> On Wed, Sep 30, 2020 at 10:48 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi,
> >
> > On 30/09/2020 09:00:08+0300, Alexandru Ardelean wrote:
> > > Since the driver should be allowed to build without OF support, the
> > > of_match_ptr() is redundant.
> > >
> >
> > This can probably be squashed with the previous commit.
> >
> > Also, I think that you should really make the driver DT only else, the
> > driver will carry dead code and there will be no reminder that a cleanup
> > is needed.
> >
> > I can take care of that if you feel that this is more work than what you
> > wanted to spend on this driver.
> 
> Ah, you're saying remove the old pdata?

Yes, since you are making the driver DT only, the pdata has to be
removed, don't forget to also remove the header file.

> I can do that while waiting for other of my patches to go in.
> 
> >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  drivers/iio/adc/at91_adc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > > index 7d846a2852a5..473bffe84fbd 100644
> > > --- a/drivers/iio/adc/at91_adc.c
> > > +++ b/drivers/iio/adc/at91_adc.c
> > > @@ -1466,7 +1466,7 @@ static struct platform_driver at91_adc_driver = {
> > >       .id_table = at91_adc_ids,
> > >       .driver = {
> > >                  .name = DRIVER_NAME,
> > > -                .of_match_table = of_match_ptr(at91_adc_dt_ids),
> > > +                .of_match_table = at91_adc_dt_ids,
> > >                  .pm = &at91_adc_pm_ops,
> > >       },
> > >  };
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Alexandre Belloni, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
