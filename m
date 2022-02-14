Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BEA4B44E9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 09:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiBNIxU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 03:53:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiBNIxT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 03:53:19 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF095F8F9
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 00:53:11 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 41C8224000B;
        Mon, 14 Feb 2022 08:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644828789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmMKuegqj8C5AxdwdBJAjd25tIgLBBLsw4Hr7MEGK+Q=;
        b=ZrcEA/39QXLwzPiA0wGJtGym7dCOhJmc4dWq6Wi5G6SgWQBUN/iQRWf4YbAs+vuSzys+CK
        267GSuTr/k3DF3hVQFFjGEdjxUx8nMF7oVTwbkQl6CgB1+4bW+zeZFO05KKTHiYmCm5NMs
        ubHFDXaKaHgu6pz7E5F6djpotNebYx4A8dSRGIfo5B5layQLIsckAo3HqOuEXy/P5q2Fao
        30kWNSZZ6jGr6FozG3EsY3m0A1aDjk23iCbspGYfCqzuS4hOrIVXiUrsPdNTCViCHQlplm
        p5v2L4XMDUx1CMv/zDKej/FvNi7zxV08pAamJltVrTddL0XmoZAH5AKl5BH43Q==
Date:   Mon, 14 Feb 2022 09:53:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v3 13/13] iio: core: Clarify the modes
Message-ID: <20220214095308.42e52f34@xps13>
In-Reply-To: <20220213184224.1644ddbc@jic23-huawei>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
        <20220213184224.1644ddbc@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 13 Feb 2022 18:42:24 +0000:

> On Mon,  7 Feb 2022 15:38:40 +0100
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
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
> One trivial thing inline as a result of edits in v3.
>=20
> Otherwise, I want to let this series sit a little longer and ideally get
> some eyes on the st_sensors patches.

Sure.

>=20
> Jonathan
>=20
> > ---
> >  include/linux/iio/iio.h | 49 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 85cb924debd9..e383b0d96035 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -315,7 +315,54 @@ static inline bool iio_channel_has_available(const=
 struct iio_chan_spec *chan,
> >  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> >  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
> > =20
> > -/* Device operating modes */
> > +/**
> > + * Device operating modes
> > + * @INDIO_DIRECT_MODE: There is an access to either:
> > + * a) The last single value available for devices that do not provide
> > + *    on-demand reads.
> > + * b) A new value after performing an on-demand read otherwise. =20
>=20
>=20
> > + * On most devices, this is a single-shot read. On some devices with d=
ata
> > + * streams without an 'on-demand' function, this might also be the 'la=
st value'
> > + * feature. =20
>=20
> This block duplicates what you now have as a/b above. I can drop it whilst
> applying if nothing else comes up.

We can get rid of it indeed. Let's see what ST people have in mind
regarding the st_sensors patches.

> >  Above all, this mode internally means that we are not in any of the
> > + * other modes, and sysfs reads should work.
> > + * Device drivers should inform the core if they support this mode.
> > + * @INDIO_BUFFER_TRIGGERED: Common mode when dealing with kfifo buffer=
s.
> > + * It indicates that an explicit trigger is required. This requests th=
e core to
> > + * attach a poll function when enabling the buffer, which is indicated=
 by the
> > + * _TRIGGERED suffix.
> > + * The core will ensure this mode is set when registering a triggered =
buffer
> > + * with iio_triggered_buffer_setup().
> > + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event tr=
iggered.
> > + * No poll function can be attached because there is no triggered infr=
astructure
> > + * we can use to cause capture. There is a kfifo that the driver will =
fill, but
> > + * not "only one scan at a time". Typically, hardware will have a buff=
er that
> > + * can hold multiple scans. Software may read one or more scans at a s=
ingle time
> > + * and push the available data to a Kfifo. This means the core will no=
t attach
> > + * any poll function when enabling the buffer.
> > + * The core will ensure this mode is set when registering a simple kfi=
fo buffer
> > + * with devm_iio_kfifo_buffer_setup().
> > + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not use=
 this mode.
> > + * Same as above but this time the buffer is not a kfifo where we have=
 direct
> > + * access to the data. Instead, the consumer driver must access the da=
ta through
> > + * non software visible channels (or DMA when there is no demux possib=
le in
> > + * software)
> > + * The core will ensure this mode is set when registering a dmaengine =
buffer
> > + * with devm_iio_dmaengine_buffer_setup().
> > + * @INDIO_EVENT_TRIGGERED: Very unusual mode.
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
> > + * @INDIO_HARDWARE_TRIGGERED: Very unusual mode.
> > + * Here, triggers can result in data capture and can be routed to mult=
iple
> > + * hardware components, which make them close to regular triggers in t=
he way
> > + * they must be managed by the core, but without the entire interrupts=
/poll
> > + * functions burden. Interrupts are irrelevant as the data flow is har=
dware
> > + * mediated and distributed.
> > + */
> >  #define INDIO_DIRECT_MODE		0x01
> >  #define INDIO_BUFFER_TRIGGERED		0x02
> >  #define INDIO_BUFFER_SOFTWARE		0x04 =20
>=20


Thanks,
Miqu=C3=A8l
