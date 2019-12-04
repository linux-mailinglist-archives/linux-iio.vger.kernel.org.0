Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5CC1125BB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 09:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfLDIqH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 03:46:07 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4571 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfLDIqH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 03:46:07 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4xLNsUQDEfxULouLYzoSIaIlckWltHCZaGQd+HaljCUjhF89OsA1yvocbqvxHPGf7Od2Uizpp2
 QroyqLkablnIIbw2sQYBGjL+HkIopqSH+zRbFj5OXQGMSZ2uKWmvdCkpgB7T36LYbVZMkYfQ6g
 cB+Q4MJitU/sk+wV5fkRPjAC6ya1ULcv7sclnZFH8eXGAkhfxD+JgybN0EaeGREKPub90zdtZl
 HJaimALMXvWkOgXSvIQoBNFwNlVfmIYoVgmXdgizzT3z5BZmHN3MFjVZz0sMO0ogVFpWOEdctI
 FSk=
X-IronPort-AV: E=Sophos;i="5.69,276,1571727600"; 
   d="scan'208";a="56561727"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Dec 2019 01:46:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Dec 2019 01:46:07 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 4 Dec 2019 01:46:06 -0700
Date:   Wed, 4 Dec 2019 09:45:55 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20191204084555.7gjyh23oywhruy7g@M43218.corp.atmel.com>
Mail-Followup-To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>
References: <20191023082508.17583-1-alexandru.ardelean@analog.com>
 <17cf55869cc418795d0013c0594ed8fc04381d46.camel@analog.com>
 <9df3d999-0ec6-a282-d24b-8f7df5f14f6d@microchip.com>
 <e43bf58f-223c-0b12-2912-6f353d866ec3@microchip.com>
 <74aabb41107ab162660f21e726c88a9dd40ecc5e.camel@analog.com>
 <60ce6ff9-ba06-2522-e9a0-55e6fd2731ec@microchip.com>
 <0075d7fc890b0986f2113664c664ff46931de432.camel@analog.com>
 <3a8ea46b-14d4-30d8-5766-02538cab8394@microchip.com>
 <b01afcee62e82e6965115a8a0ec7246f71488df1.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b01afcee62e82e6965115a8a0ec7246f71488df1.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 03, 2019 at 01:40:34PM +0000, Ardelean, Alexandru wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, 2019-12-03 at 12:17 +0000, Eugen.Hristev@microchip.com wrote:
> >
> > On 03.12.2019 14:04, Ardelean, Alexandru wrote:
> >
> > > On Tue, 2019-12-03 at 09:49 +0000, Eugen.Hristev@microchip.com wrote:
> > > > [External]
> > > >
> > > >
> > > >
> > > > On 29.11.2019 09:02, Ardelean, Alexandru wrote:
> > > >
> > > > > On Thu, 2019-11-28 at 15:19 +0000, Eugen.Hristev@microchip.com
> > > > > wrote:
> > > > >
> > > > > Hey,
> > > > >
> > > > > Sorry for the late reply.
> > > > > I'm also juggling a few things.
> > > > >
> > > > > > On 28.11.2019 10:36, Eugen.Hristev@microchip.com wrote:
> > > > > >
> > > > > > > On 25.11.2019 17:03, Ardelean, Alexandru wrote:
> > > > > > > > On Wed, 2019-10-23 at 11:25 +0300, Alexandru Ardelean wrote:
> > > > > > > > > The iio_triggered_buffer_{predisable,postenable} functions
> > > > > > > > > attach/detach
> > > > > > > > > poll functions.
> > > > > > > > >
> > > > > > > > > The iio_triggered_buffer_postenable() should be called
> > > > > > > > > first to
> > > > > > > > > attach
> > > > > > > > > the
> > > > > > > > > poll function, and then the driver can init the data to be
> > > > > > > > > triggered.
> > > > > > > > >
> > > > > > > > > Similarly, iio_triggered_buffer_predisable() should be
> > > > > > > > > called
> > > > > > > > > last
> > > > > > > > > to
> > > > > > > > > first
> > > > > > > > > disable the data (to be triggered) and then the poll
> > > > > > > > > function
> > > > > > > > > should be
> > > > > > > > > detached.
> > > > > > >
> > > > > > > Hi Alexandru,
> > > > > > >
> > > > > > > Sorry for this late reply,
> > > > > > >
> > > > > > > I remember that by adding specific at91_adc code for
> > > > > > > predisable/postenable , I was replacing the existing standard
> > > > > > > callback
> > > > > > > with my own, and have my specific at91 code before postenable
> > > > > > > and
> > > > > > > then
> > > > > > > calling the subsystem postenable,
> > > > > > > and in similar way, for predisable, first call the subsystem
> > > > > > > predisable
> > > > > > > then doing my predisable code (in reverse order as in
> > > > > > > postenable)
> > > > > > >
> > > > > > > If you say the order should be reversed (basically have the
> > > > > > > pollfunction
> > > > > > > first), how is current code working ?
> > > > > > > Should current code fail if the poll function is not attached
> > > > > > > in
> > > > > > > time ?
> > > > > > > Or there is a race between triggered data and the attachment of
> > > > > > > the
> > > > > > > pollfunc ?
> > > > > > >
> > > > > > > I am thinking that attaching the pollfunc later makes it work
> > > > > > > because
> > > > > > > the DMA is not started yet. What happens if we have the
> > > > > > > pollfunc
> > > > > > > attached but DMA is not started (basically the trigger is not
> > > > > > > started)
> > > > > > > ,
> > > > > > > can this lead to unexpected behavior ? Like the pollfunc
> > > > > > > polling
> > > > > > > but no
> > > > > > > trigger started/no DMA started.
> > > > > >
> > > > > > I looked a bit more into the code and in DMA case, using
> > > > > > postenable
> > > > > > first will lead to calling attach pollfunc, which will also
> > > > > > enable
> > > > > > the
> > > > > > trigger, but the DMA is not yet started.
> > > > > > Is this the desired effect ?
> > > > >
> > > > > Yes.
> > > >
> > > > How is this correct ? We start the trigger but have no buffer to
> > > > carry
> > > > to... what happens with the data ? -> I think we both have an answer
> > > > to
> > > > that, as you state below
> > > >
> > > > > > Normally when using DMA I would say we
> > > > > > would need to enable DMA first to be ready to carry data (and
> > > > > > coherent
> > > > > > area etc.) and then enable the trigger.
> > > > >
> > > > > So, there is a change in our tree [from some time ago].
> > > > > See here:
> > > > > https://github.com/analogdevicesinc/linux/commit/eee97d12665fef8cf429a1e5035b23ae969705b8
> > > > >
> > > > > Particularly, what's interesting is around line:
> > > > > https://github.com/analogdevicesinc/linux/commit/eee97d12665fef8cf429a1e5035b23ae969705b8#diff-0a87744ce945d2c1c89ea19f21fb35bbR722
> > > > > And you may need to expand some stuff to see more of the function-
> > > > > body.
> > > > > And some things may have changed in upstream IIO since that change.
> > > > >
> > > > > The change is to make the pollfunc attach/detach become part of the
> > > > > IIO
> > > > > framework, because plenty of drivers just call
> > > > > iio_triggered_buffer_postenable() &
> > > > > iio_triggered_buffer_predisable()
> > > > > to
> > > > > manually attach/detach the pollfunc for triggered buffers.
> > > >
> > > > Okay, I understand this. at91-sama5d2_adc does not manually
> > > > attach/detach the pollfunc. So why do we need to change anything here
> > > > ?
> > > >
> > > >
> > > > > That change is from 2015, and since then, some drivers were added
> > > > > that
> > > > > just
> > > > > manually attach/detach the pollfunc [and do nothing more with the
> > > > > postenable/predisable hooks].
> > > > >
> > > > > I tried to upstream a more complete version of that patch a while
> > > > > ago
> > > > > [u1].
> > > > > https://patchwork.kernel.org/patch/10482167/
> > > > > https://patchwork.kernel.org/patch/10737291/
> > > > >
> > > > > The conclusion was to first fix the attach/detach pollfunc order in
> > > > > all
> > > > > IIO
> > > > > drivers, so that when patch [u1] is applied, there is no more
> > > > > discussion
> > > > > about the correct order for attach/detach pollfunc.
> > > >
> > > > Allright, what is required to be fixed regarding the order, in this
> > > > specific case? We enable the DMA, and then we do the normal
> > > > 'postenable'
> > > > that was called anyway if we did not override the 'postenable' in the
> > > > ops. Do you want to move this code to 'preenable' and keep
> > > > 'postenable'
> > > > to the standard subsystem one ?
> > > >
> > > > The same applies to the predisable, we first call the subsystem
> > > > 'predisable' then do the specific at91 stuff. You want to move this
> > > > to
> > > > the 'postdisable' ?
> > > >
> > > > I think reverting the order inside the functions themselves is not
> > > > good
> > > > as we replace the order of starting trigger/DMA setup.
> > > > So, coming to your question below...
> > > >
> > > > > Coming back here [and to your question], my answer is: I don't know
> > > > > if
> > > > > the
> > > > > at91 DMA needs to be enabled/disabled before/after the pollfunc
> > > > > attach/detach.
> > > > > This sounds like specific stuff for at91 [which is fine].
> > > > >
> > > > > It could be that some other hooks may need to used to enable DMA
> > > > > before/after the attach/detach pollfunc. Maybe
> > > > > preenable()/postdisable() ?
> > > > >
> > > > > In any case, what I would like [with this discussion], is to
> > > > > resolve a
> > > > > situation where we can get closer to moving the attach/pollfunc
> > > > > code to
> > > > > IIO
> > > > > core. So, if AT91 requires a different ordering, I think you would
> > > > > be
> > > > > more
> > > > > appropriate to tell me, and propose an alternative to this patch.
> > > >
> > > > ... yes, this looks more appropriate, to move things to
> > > > 'preenable/postdisable', if you feel like 'postenable/predisable' is
> > > > not
> > > > the proper place to put them.
> > > > But the order itself, first enable DMA then trigger, and disable in
> > > > reverse order, I do not think there is anything wrong with that? Am I
> > > > misunderstanding ?
> > >
> > > Should be good.
> > >
> > > > If Jonathan or Ludovic have a different idea, please let me know.
> > >
> > > There is an alternative here [to this].
> > > Maybe using the IIO Buffer DMA[Engine] integration that Lars wrote [1].
> > > This would avoid calling dmaengine_terminate_sync() and similar hooks
> > > in
> > > the AT91 driver. That also preserves the correct order (start DMA
> > > first,
> > > then attach pollfunc ; and reverse on disable).
> > > But that is more work; not on the patch itself, but more on the
> > > testing.
> >
> > Initially, when I implemented the DMA part for this driver, this was the
> > idea. However the DMA engine was not used at that time by anyone , and I
> > could not make it work properly. Jonathan advised at that moment to use
> > this current framework.
> >
> > > [1] Upstreaming more parts for the IIO Buffer DMA[Engine] integration
> > > is on
> > > my to-do-list as well. I think there are still some patches that we
> > > use,
> > > but are not upstreamed yet.
> > >
> > > I'll come-up a with a V2 for this with preenable()/postdisable()
> > > alternative here.
> >
> > Ok, I will test it .
> >
> > What I do not understand completely is why it bothers you to have at91
> > specific code in postenable / predisable.
> > The same thing will happen will happen with preenable/postdisable:
> > specific at91 code will be called after subsystem preenable and before
> > subsystem postdisable.
> 
> Because I am preparing a framework change to IIO core and all IIO drivers
> in mainline need to be resolved when that change happens.
> I am not sure if the change will break any driver, but at least we can
> minimalize breakage.
> 

Ok re-reading the thread I see what you want to achieve. It should be better to
have your framework change (code factorization if I have well understood) in the
patch serie or as an RFC:
- it helps people to understand why you do these changes
- if it's rejected or has to be rework, you have uselessly change the
  drivers and introduce a potential breakage.

If it has already been discussed on the mailing list, forget what I am
saying.

Regards

Ludovic

> >
> > > Thanks
> > > Alex
> > >
> > > > Also, I can test your patch to see if everything is fine.
> > > >
> > > > Thanks,
> > > > Eugen
> > > >
> > > > > Thanks :)
> > > > > Alex
> > > > >
> > > > > > > > > For this driver, the predisable & postenable hooks are also
> > > > > > > > > need to
> > > > > > > > > take
> > > > > > > > > into consideration the touchscreen, so the hooks need to be
> > > > > > > > > put
> > > > > > > > > in
> > > > > > > > > places
> > > > > > > > > that avoid the code for that cares about it.
> > > > > > > > >
> > > > > > > >
> > > > > > > > ping here
> > > > > > > >
> > > > > > > > > Signed-off-by: Alexandru Ardelean <
> > > > > > > > > alexandru.ardelean@analog.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/iio/adc/at91-sama5d2_adc.c | 19 ++++++++++--
> > > > > > > > > -------
> > > > > > > > >      1 file changed, 10 insertions(+), 9 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > b/drivers/iio/adc/at91-
> > > > > > > > > sama5d2_adc.c
> > > > > > > > > index e1850f3d5cf3..ac3e5c4c9840 100644
> > > > > > > > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > > > > @@ -889,20 +889,24 @@ static int
> > > > > > > > > at91_adc_buffer_postenable(struct
> > > > > > > > > iio_dev *indio_dev)
> > > > > > > > >           if (!(indio_dev->currentmode &
> > > > > > > > > INDIO_ALL_TRIGGERED_MODES))
> > > > > > > > >                   return -EINVAL;
> > > > > > > > >
> > > > > > > > > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > > > > > > > > +     if (ret)
> > > > > > > > > +             return ret;
> > > > > > > > > +
> > > > > > > > >           /* we continue with the triggered buffer */
> > > > > > > > >           ret = at91_adc_dma_start(indio_dev);
> > > > > > > > >           if (ret) {
> > > > > > > > >                   dev_err(&indio_dev->dev, "buffer
> > > > > > > > > postenable
> > > > > > > > > failed\n");
> > > > > > > > > +             iio_triggered_buffer_predisable(indio_dev);
> > > > > > > > >                   return ret;
> > > > > > > > >           }
> > > > > > > > >
> > > > > > > > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > > > > > > > +     return 0;
> > > > > > > > >      }
> > > > > > > > >
> > > > > > > > >      static int at91_adc_buffer_predisable(struct iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >      {
> > > > > > > > >           struct at91_adc_state *st = iio_priv(indio_dev);
> > > > > > > > > -     int ret;
> > > > > > > > >           u8 bit;
> > > > > > > > >
> > > > > > > > >           /* check if we are disabling triggered buffer or
> > > > > > > > > the
> > > > > > > > > touchscreen */
> > > > > > > > > @@ -916,13 +920,8 @@ static int
> > > > > > > > > at91_adc_buffer_predisable(struct
> > > > > > > > > iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >           if (!(indio_dev->currentmode &
> > > > > > > > > INDIO_ALL_TRIGGERED_MODES))
> > > > > > > > >                   return -EINVAL;
> > > > > > > > >
> > > > > > > > > -     /* continue with the triggered buffer */
> > > > > > > > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > > > > > > > -     if (ret < 0)
> > > > > > > > > -             dev_err(&indio_dev->dev, "buffer predisable
> > > > > > > > > failed\n");
> > > > > > > > > -
> > > > > > > > >           if (!st->dma_st.dma_chan)
> > > > > > > > > -             return ret;
> > > > > > > > > +             goto out;
> > > > > > > > >
> > > > > > > > >           /* if we are using DMA we must clear registers
> > > > > > > > > and end
> > > > > > > > > DMA
> > > > > > > > > */
> > > > > > > > >           dmaengine_terminate_sync(st->dma_st.dma_chan);
> > > > > > > > > @@ -949,7 +948,9 @@ static int
> > > > > > > > > at91_adc_buffer_predisable(struct
> > > > > > > > > iio_dev
> > > > > > > > > *indio_dev)
> > > > > > > > >
> > > > > > > > >           /* read overflow register to clear possible
> > > > > > > > > overflow
> > > > > > > > > status
> > > > > > > > > */
> > > > > > > > >           at91_adc_readl(st, AT91_SAMA5D2_OVER);
> > > > > > > > > -     return ret;
> > > > > > > > > +
> > > > > > > > > +out:
> > > > > > >
> > > > > > > I would prefer if this label is named with a function name
> > > > > > > prefix,
> > > > > > > otherwise 'out' is pretty generic and can collide with other
> > > > > > > things
> > > > > > > in
> > > > > > > the file... I want to avoid having an out2 , out3 later if code
> > > > > > > changes.
> > > > > > >
> > > > >
> > > > > Sure.
> > > > > Will do that.
> > > > >
> > > > > I did not bother much with these labels, because after applying
> > > > > [u1],
> > > > > some
> > > > > of them [maybe all] should go away.
> > > > >
> > > > >
> > > > > > > Thanks for the patch,
> > > > > > > Eugen
> > > > > > >
> > > > > > > > > +     return iio_triggered_buffer_predisable(indio_dev);
> > > > > > > > >      }
> > > > > > > > >
> > > > > > > > >      static const struct iio_buffer_setup_ops
> > > > > > > > > at91_buffer_setup_ops =
> > > > > > > > > {
> > > > > > > > _______________________________________________
> > > > > > > > linux-arm-kernel mailing list
> > > > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
