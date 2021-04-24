Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEF36A0D2
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhDXLSG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 24 Apr 2021 07:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDXLSF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:18:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6447A61476;
        Sat, 24 Apr 2021 11:17:26 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:18:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 6/9] iio: adis_buffer: update device page after
 changing it
Message-ID: <20210424121806.5ff0a3a3@jic23-huawei>
In-Reply-To: <CA+U=Dsp08Hv7KtV_K=mG9RfDWpTezhPa0Xjp_R7jZrAuOqKz_w@mail.gmail.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-7-nuno.sa@analog.com>
        <CA+U=Dsphpu97Et6sgjd+9TUEHTw7xq44M5yL=CFtuCEU9QLxQQ@mail.gmail.com>
        <CY4PR03MB311220A749133B44C778F9F799459@CY4PR03MB3112.namprd03.prod.outlook.com>
        <CA+U=Dsp08Hv7KtV_K=mG9RfDWpTezhPa0Xjp_R7jZrAuOqKz_w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 16:56:26 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Apr 23, 2021 at 3:20 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> >  
> > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Sent: Friday, April 23, 2021 9:33 AM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > <jic23@kernel.org>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>
> > > Subject: Re: [PATCH v2 6/9] iio: adis_buffer: update device page after
> > > changing it
> > >
> > > [External]
> > >
> > > On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com>
> > > wrote:  
> > > >
> > > > With commit 58ca347b9b24 ("iio: adis_buffer: don't push data to  
> > > buffers on  
> > > > failure"), we return if 'spi_sync()' fails which would leave
> > > > 'adis->current_page' in an incoherent state. Hence, set this variable
> > > > right after we change the device page.
> > > >
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/iio/imu/adis_buffer.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/imu/adis_buffer.c  
> > > b/drivers/iio/imu/adis_buffer.c  
> > > > index a29d22f657ce..dda367071980 100644
> > > > --- a/drivers/iio/imu/adis_buffer.c
> > > > +++ b/drivers/iio/imu/adis_buffer.c
> > > > @@ -140,6 +140,8 @@ static irqreturn_t adis_trigger_handler(int irq,  
> > > void *p)  
> > > >                                 mutex_unlock(&adis->state_lock);
> > > >                                 goto irq_done;
> > > >                         }
> > > > +
> > > > +                       adis->current_page = 0;
> > > >                 }
> > > >         }
> > > >
> > > > @@ -151,10 +153,8 @@ static irqreturn_t adis_trigger_handler(int  
> > > irq, void *p)  
> > > >                 goto irq_done;
> > > >         }
> > > >
> > > > -       if (adis->data->has_paging) {
> > > > -               adis->current_page = 0;
> > > > +       if (adis->data->has_paging)
> > > >                 mutex_unlock(&adis->state_lock);
> > > > -       }  
> > >
> > > So, continuing from my comment here [1]:
> > >
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/li
> > > nux-iio/patch/20210422101911.135630-6-
> > > nuno.sa@analog.com/__;!!A3Ni8CS0y2Y!u1RyPNeh8e5m7lPfDa5H5ZjT
> > > hA9TdsLGvk2m1kFQBbAKe40PmvQS8O8N-f-GEg$
> > >
> > > This can become more elegant, because this block:
> > >        if (adis->data->has_paging)
> > >                 mutex_unlock(&adis->state_lock);
> > >
> > > can be moved right after "ret = spi_sync(adis->spi, &adis->msg);"
> > >
> > > And then the duplication added in patch [1] can be cleaned up.
> > > So maybe a re-ordering of patches could simplify/remove the added
> > > duplication.
> > >  
> >
> > Hmmm I'm not following you :). What's your idea? You mean the block
> > inside the 'if (ret)' in case spi_sync fails? If so, we can move it but then
> > we cannot do the goto jump... you mean something like?
> >
> > ret = spi_sync();
> > if (adis->data->has_paging)
> >         mutex_unlock(&adis->state_lock);
> > if (ret) {
> >         dev_err();
> >         goto irq_done;
> > }
> >
> > I don't particularly like the paging stuff after the spi_sync but this avoids
> > some duplication for sure... and reduces some lines of code :)  
> 
> Yeah, this was the suggestion.
> No strong opinion about it.
Ah. I should probably read ahead a bit before commenting on earlier patches ;)

I was thinking this was the way to go.  It would be an entirely standard pattern 
if not for the if (adis->data->has_paging) being there.

Hmm maybe some helpers would make this more readable?  

adis_mutex_lock_if_paging(adis);
adis_mutex_unlock_if_paging(adis);

Probably not worth it given single usecase.  I'd go with what you have above.
I'd also reorder this before the previous patch as that will make that one simpler.

Jonathan

> 
> >
> > - Nuno Sá  

