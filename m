Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56C4A71D7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbiBBNqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 08:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiBBNqj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 08:46:39 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CADC061714
        for <linux-iio@vger.kernel.org>; Wed,  2 Feb 2022 05:46:39 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 512DC60018;
        Wed,  2 Feb 2022 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643809597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bs4gVsMm+qpQW6rqNZjPNJWTeZHDnwV1gKpS8WHTws0=;
        b=ROe390HA5fo7TR8YYNkWClq1YocIiwjtE4QQHe/T6R2I6JXf1xyANKPTd53d0mSu762Yjo
        b7vT/7lFmmkB6vciSqGbgYJ6xoekkp0JzQquWhi8bTTxQ3OSsq9/LPwXfBrHERq7PFSpmy
        DSTyLaziqG1O4DBGCzURiOlJmt2V3X7/XKG+NiWMdO/cMINuA76TsRP8L3Yka8aLKW3QF0
        wMImwIQuZAA+o1DlqTKh2Og8CWFEq9yITPtyWFQx+eRcECjulRgTHOu6n5VkhMMOKuVO9A
        jraf3eW5BWWhI5ePu/e0qeRgNupkDcZSgJhsjXR3nvIofH0aLF9BQiJVf58NIA==
Date:   Wed, 2 Feb 2022 14:46:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] iio: core: Clarify the modes
Message-ID: <20220202144635.35748521@xps13>
In-Reply-To: <20220115173050.3501e20c@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-11-miquel.raynal@bootlin.com>
        <20220115173050.3501e20c@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 17:30:50 +0000:

> On Wed, 15 Dec 2021 16:13:44 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > As part of a previous discussion with Jonathan Cameron [1], it appeared
> > necessary to clarify the meaning of each mode so that new developers
> > could understand better what they should use or not use and when.
> >=20
> > The idea of renaming these modes as been let aside because naming is a
> > big deal and requires a lot of thinking. So for now let's focus on
> > correctly explaining what each mode implies.
> >=20
> > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-hua=
wei/
> >=20
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/linux/iio/iio.h | 40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d04ab89fa0c2..75b561fd63d0 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -314,7 +314,45 @@ static inline bool iio_channel_has_available(const=
 struct iio_chan_spec *chan,
> >  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> >  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
> > =20
> > -/* Device operating modes */
> > +/**
> > + * Device operating modes
> > + * @INDIO_DIRECT_MODE: There is an access to the last single value ava=
ilable. =20
>=20
> I'd avoid 'last' as not obvious wrt to what time point.  Perhaps use some=
thing
> horrible like "timely"?

I don't feel a big difference between the two, besides timely being far
from easy to understand IMHO, but I'll use it if you think it's best.

> > + * On most devices, this is a single-shot read. On some devices with d=
ata
> > + * streams without an 'on-demand' function, this might also be the 'la=
st value'
> > + * feature. Above all, this mode internally means that we are not in a=
ny of the
> > + * other modes, and sysfs reads will definitely work. =20
>=20
> Should work ;)  They might fail for a wide variety of other reasons.

Right.

> > + * Device drivers are pleased to inquire the core about this mode. =20
> Not totally sure what you mean here.  Perhaps
> Device drivers should inform the core if they support this mode.

Ok.

> > + * @INDIO_BUFFER_TRIGGERED: Most common mode when dealing with kfifo b=
uffers. =20
>=20
> Avoid "common". That may well change in future as fifos are become increa=
singly
> common on devices over time.  Perhaps just drop this first sentence.

I don't think dropping this sentence is a good idea. My first goal here
is to make it easier for newcomers to understand these modes. Here it
clearly states "if you're dealing with a kfifo, keep reading, otherwise
just check out the next mode". Of course this might evolve over time
and if it is the case we can later update the documentation.

I've dropped the "Most" instead, to still indicate this is fairly
common but should not be read like something almost automatic.

> > + * It indicates that there is an explicit trigger that must be used. T=
his =20
>=20
> Indicates that an explicit trigger is required. (subtle difference from w=
hat you
> wrote in that you kind of imply there is only one possible choice)

Fair enough.

> > + * requests the core to attach a poll function when enabling the buffe=
r, which
> > + * is indicated by the _TRIGGERED suffix.
> > + * The core will ensure this mode is set when registering a triggered =
buffer. =20
>=20
> I'd call out the function name (mostly to be inline with below where you =
need
> to because there isn't a particularly good way to describe what it is doi=
ng).

Done.

>=20
> > + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event tr=
iggered.
> > + * No poll function can be attached because there is no triggered infr=
astructure
> > + * we can use to cause capture. There is a kfifo that the hardware wil=
l fill,
> > + * but not "one scan at a time", just like in a continuous stream. =20
>=20
> No real relationship to a continuous stream that I can see.  Perhaps some=
thing like
> "Typically hardware will have a buffer that can hold multiple scans. Soft=
ware may
>  read one or more scans at a single time and push the available data to a=
 Kfifo."

Added.

>=20
> > This means
> > + * the core will not attach any poll function when enabling the buffer.
> > + * The core will ensure this mode is set when registering a simple kfi=
fo buffer. =20
>=20
> I'd call out the function name here.  The above registers a kfifo as well=
 which is
> pretty simple...

Sure.

>=20
> > + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use=
 this mode.
> > + * Same as above but this time the buffer is not a kfifo where we have=
 direct
> > + * access to the data. Instead, the consumer driver must access the da=
ta through
> > + * side-channels  =20
> What do you mean by side-channels here?  That term gets over used - perha=
ps
> "non software visible channels"

Clear.

>=20
>  + (or DMA when there is no demux possible in software).
> > + * The core will ensure this mode is set when registering a dmaengine =
buffer. =20
>=20
> > + * @INDIO_EVENT_TRIGGERED: Very specific, do not use this mode. =20
>=20
> :) That's harsh..

Looks like you changed your mind, that's almost what you proposed back
in September ;)

> If you happen to be supporting hardware that works this way
> it's a valid setting.  Perhaps we'd be safe to say:
> "Very unusual."
>=20
> > + * Triggers usually refer to an external event which will start data c=
apture.
> > + * Here it is kind of the opposite as, a particular state of the data =
might
> > + * produce an event which can be considered as an event. We don't nece=
ssarily
> > + * have access to the data itself, but to the event produced. For exam=
ple, this
> > + * can be a threshold detector. The internal path of this mode is very=
 close to
> > + * the INDIO_BUFFER_TRIGGERED mode.
> > + * The core will ensure this mode is set when registering a triggered =
event.
> > + * @INDIO_HARDWARE_TRIGGERED: STM32 specific mode, do not use it. =20
>=20
> I'd avoid that comment because it'll rot when some other hardware needs s=
omething
> like this.  Again, perhaps "Very rare / unusual." will be enough to put p=
eople
> off using it.

As you prefer.

> > + * Here, triggers can result in data capture and can be routed to mult=
iple
> > + * hardware components, which make them close to regular triggers in t=
he way
> > + * they must be managed by the core, but without the entire interrupts=
/poll
> > + * functions burden. All of this is irrelevant as it is all hardware m=
ediated
> > + * and distributed. =20
>=20
> "All this" is not totally clear.  Interrupts are irrelevant as the data f=
low
> is hardware mediated and distributed.

Thanks for the alternative.

>=20
> Nice descriptions in general.  Nature of these things is without a straw =
man
> to poke holes in I'd never get around to documenting this very much
> appreciated that you took the time to figure all the weird corners out and
> write this up.
>=20

I'm happy if this can be useful!

V2 finally coming soon.

Thanks,
Miqu=C3=A8l
