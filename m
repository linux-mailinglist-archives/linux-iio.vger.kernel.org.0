Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01C352924
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 11:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBJxa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 05:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJxa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 05:53:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7C460FE6;
        Fri,  2 Apr 2021 09:53:25 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:53:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: drop __func__ while using
 Dynamic debug
Message-ID: <20210402105335.1bfbaf2e@jic23-huawei>
In-Reply-To: <CAHp75VfkCQpfUrVcWHUnD4DLMp9iZJBL8mYfsYOCsESm_y068A@mail.gmail.com>
References: <20210401154343.41527-1-dmugil2000@gmail.com>
        <CAHp75VfkCQpfUrVcWHUnD4DLMp9iZJBL8mYfsYOCsESm_y068A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Apr 2021 21:05:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Apr 1, 2021 at 8:48 PM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
> >
> > dropped __func__ while using dev_dbg() and pr_debug()  
> 
> The commit message may be amended, from code perspective LGTM!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I added a note to the commit message to observe that the function
name printing can be configured using dynamic debug.

Applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilder bots like 0-day check if they can find any
problems that we've missed.

Thanks,

Jonathan

> 
> > Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > ---
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index 76a60d93fe23..95ec5f3c3126 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -198,7 +198,7 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
> >         unsigned int p = fl->ford;      /* filter order (ford) */
> >         struct stm32_dfsdm_filter_osr *flo = &fl->flo[fast];
> >
> > -       pr_debug("%s: Requested oversampling: %d\n",  __func__, oversamp);
> > +       pr_debug("Requested oversampling: %d\n", oversamp);
> >         /*
> >          * This function tries to compute filter oversampling and integrator
> >          * oversampling, base on oversampling ratio requested by user.
> > @@ -294,8 +294,8 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
> >                                 }
> >                                 flo->max = (s32)max;
> >
> > -                               pr_debug("%s: fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
> > -                                        __func__, fast, flo->fosr, flo->iosr,
> > +                               pr_debug("fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
> > +                                        fast, flo->fosr, flo->iosr,
> >                                          flo->res, bits, flo->rshift,
> >                                          flo->lshift);
> >                         }
> > @@ -858,7 +858,7 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
> >          * support in IIO.
> >          */
> >
> > -       dev_dbg(&indio_dev->dev, "%s: pos = %d, available = %d\n", __func__,
> > +       dev_dbg(&indio_dev->dev, "pos = %d, available = %d\n",
> >                 adc->bufi, available);
> >         old_pos = adc->bufi;
> >
> > @@ -912,7 +912,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
> >         if (!adc->dma_chan)
> >                 return -EINVAL;
> >
> > -       dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
> > +       dev_dbg(&indio_dev->dev, "size=%d watermark=%d\n",
> >                 adc->buf_sz, adc->buf_sz / 2);
> >
> >         if (adc->nconv == 1 && !indio_dev->trig)
> > --
> > 2.25.1
> >  
> 
> 

