Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47D4C5B54
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiB0N3Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiB0N3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 08:29:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2BB3ED3E
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 05:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19B6160F08
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 13:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A800C340F0;
        Sun, 27 Feb 2022 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645968526;
        bh=pBykm/INdgKwuZJv9ZjUWTlOoLphTvr59m5U3xvGzpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hq6d4+i6/9sN9BEdw5aXoqwcg5SZVbgF3gdhB9MBPYP15LAgWofFIQsHH6Ub0LDgk
         eq6AdCRW1gnnsUqUKF2EvUcOw0hKjKuMgv3xZDXw7oERCi03GYErDAsJ+Ube28H82H
         Jae+JSThTyCdhJAA4hT3jFqjxjSDcVXmZcH5zt3BZaH2O/s+bngI0aUfZhvVN5vhg5
         72qV3cqvYqPUP7l+JXLKvk63RsFY+VxgZk773i0whbSRGY6MvD0WuqVFekvuDB88cv
         lLVOhboVYq3DlmKykQNxeWjKrKyyL7x1xRcgxV2lioC9lZZ1UGgH9PJ+kBHTYQCaLv
         9Z4+OJqKUt2jw==
Date:   Sun, 27 Feb 2022 13:35:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v3 13/13] iio: core: Clarify the modes
Message-ID: <20220227133549.016935a1@jic23-huawei>
In-Reply-To: <20220214095308.42e52f34@xps13>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
        <20220213184224.1644ddbc@jic23-huawei>
        <20220214095308.42e52f34@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Feb 2022 09:53:08 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> jic23@kernel.org wrote on Sun, 13 Feb 2022 18:42:24 +0000:
>=20
> > On Mon,  7 Feb 2022 15:38:40 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  =20
> > > As part of a previous discussion with Jonathan Cameron [1], it appear=
ed
> > > necessary to clarify the meaning of each mode so that new developers
> > > could understand better what they should use or not use and when.
> > >=20
> > > The idea of renaming these modes as been let aside because naming is a
> > > big deal and requires a lot of thinking. So for now let's focus on
> > > correctly explaining what each mode implies.
> > >=20
> > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23-h=
uawei/
> > >=20
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>   =20
> > One trivial thing inline as a result of edits in v3.
> >=20
> > Otherwise, I want to let this series sit a little longer and ideally get
> > some eyes on the st_sensors patches. =20
>=20
> Sure.

Denis, Linus, Lorenzo,

If any of you have time to take a look at patches 4-8 in this series or ide=
ally
to run basic sanity tests with series in place that would be great.
https://patchwork.kernel.org/project/linux-iio/list/?series=3D611853

I don't have a convenient platform to test that driver on any more and the
changes are invasive enough to make me a little nervous about taking the
series without someone more familiar with that driver taking a look.

Thanks,

Jonathan

>=20
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  include/linux/iio/iio.h | 49 +++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index 85cb924debd9..e383b0d96035 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -315,7 +315,54 @@ static inline bool iio_channel_has_available(con=
st struct iio_chan_spec *chan,
> > >  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> > >  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
> > > =20
> > > -/* Device operating modes */
> > > +/**
> > > + * Device operating modes
> > > + * @INDIO_DIRECT_MODE: There is an access to either:
> > > + * a) The last single value available for devices that do not provide
> > > + *    on-demand reads.
> > > + * b) A new value after performing an on-demand read otherwise.   =20
> >=20
> >  =20
> > > + * On most devices, this is a single-shot read. On some devices with=
 data
> > > + * streams without an 'on-demand' function, this might also be the '=
last value'
> > > + * feature.   =20
> >=20
> > This block duplicates what you now have as a/b above. I can drop it whi=
lst
> > applying if nothing else comes up. =20
>=20
> We can get rid of it indeed. Let's see what ST people have in mind
> regarding the st_sensors patches.
>=20
> > >  Above all, this mode internally means that we are not in any of the
> > > + * other modes, and sysfs reads should work.
> > > + * Device drivers should inform the core if they support this mode.
> > > + * @INDIO_BUFFER_TRIGGERED: Common mode when dealing with kfifo buff=
ers.
> > > + * It indicates that an explicit trigger is required. This requests =
the core to
> > > + * attach a poll function when enabling the buffer, which is indicat=
ed by the
> > > + * _TRIGGERED suffix.
> > > + * The core will ensure this mode is set when registering a triggere=
d buffer
> > > + * with iio_triggered_buffer_setup().
> > > + * @INDIO_BUFFER_SOFTWARE: Another kfifo buffer mode, but not event =
triggered.
> > > + * No poll function can be attached because there is no triggered in=
frastructure
> > > + * we can use to cause capture. There is a kfifo that the driver wil=
l fill, but
> > > + * not "only one scan at a time". Typically, hardware will have a bu=
ffer that
> > > + * can hold multiple scans. Software may read one or more scans at a=
 single time
> > > + * and push the available data to a Kfifo. This means the core will =
not attach
> > > + * any poll function when enabling the buffer.
> > > + * The core will ensure this mode is set when registering a simple k=
fifo buffer
> > > + * with devm_iio_kfifo_buffer_setup().
> > > + * @INDIO_BUFFER_HARDWARE: For specific hardware, if unsure do not u=
se this mode.
> > > + * Same as above but this time the buffer is not a kfifo where we ha=
ve direct
> > > + * access to the data. Instead, the consumer driver must access the =
data through
> > > + * non software visible channels (or DMA when there is no demux poss=
ible in
> > > + * software)
> > > + * The core will ensure this mode is set when registering a dmaengin=
e buffer
> > > + * with devm_iio_dmaengine_buffer_setup().
> > > + * @INDIO_EVENT_TRIGGERED: Very unusual mode.
> > > + * Triggers usually refer to an external event which will start data=
 capture.
> > > + * Here it is kind of the opposite as, a particular state of the dat=
a might
> > > + * produce an event which can be considered as an event. We don't ne=
cessarily
> > > + * have access to the data itself, but to the event produced. For ex=
ample, this
> > > + * can be a threshold detector. The internal path of this mode is ve=
ry close to
> > > + * the INDIO_BUFFER_TRIGGERED mode.
> > > + * The core will ensure this mode is set when registering a triggere=
d event.
> > > + * @INDIO_HARDWARE_TRIGGERED: Very unusual mode.
> > > + * Here, triggers can result in data capture and can be routed to mu=
ltiple
> > > + * hardware components, which make them close to regular triggers in=
 the way
> > > + * they must be managed by the core, but without the entire interrup=
ts/poll
> > > + * functions burden. Interrupts are irrelevant as the data flow is h=
ardware
> > > + * mediated and distributed.
> > > + */
> > >  #define INDIO_DIRECT_MODE		0x01
> > >  #define INDIO_BUFFER_TRIGGERED		0x02
> > >  #define INDIO_BUFFER_SOFTWARE		0x04   =20
> >  =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

