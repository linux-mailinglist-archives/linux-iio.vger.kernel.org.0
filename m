Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA662790B80
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjICK4e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 06:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICK4d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 06:56:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C47DE
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 03:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF2BCB8095B
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 10:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A8C433C7;
        Sun,  3 Sep 2023 10:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693738586;
        bh=F3v8Zviy0RTyqBsYdGII4jkFcafdcQfcPg3vX1A7VeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KV8B99BmIIN6bSDqe2XI1OdQXRliz470VPJrDByfGpxtyA4eqlJqpPliaLv2nkGhq
         1k91MgTDeGlJZSLMyVmG+ZCWiABYUrEx544xGcZIaAKlviaBVP3Q+Wq9v85PpeRIJG
         GnGcnx69PH+u+uncY6tU1SYIfZy3o4hZVMB8tZxAIy8g6tK3q6ZjbjyHmJS3VGrRsd
         5iWO0uea33zUabcM4hVzJxPGZmvu/ch9b8FMAOqhknq92dOnJAFIhbiQSXsqFZfOtw
         0smUD8xWTbQYBg/4p3IlscY0293opLJYf3wyzWWC+62H0Drs8j/UXpILv9u+VriGmI
         UeRTWwJHQq3ow==
Date:   Sun, 3 Sep 2023 11:56:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
Message-ID: <20230903115653.5bb8c0e8@jic23-huawei>
In-Reply-To: <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
        <20230804145342.1600136-2-nuno.sa@analog.com>
        <20230830180234.00007437@Huawei.com>
        <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Aug 2023 11:32:54 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
> > On Fri, 4 Aug 2023 16:53:39 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > Hi Nuno,
> >  =20
>=20
> Hi Jonathan,
>=20
> Thanks for the initial review...
>=20
> >=20
> > One general comment is that you could have stripped this back a fair bit
> > for ease of understanding.=C2=A0 At this stage we don't care about thin=
gs
> > like debug or control of test patterns.=C2=A0 Bring those in as extra p=
atches.
> >  =20
>=20
> Agreed... As I mentioned (I think) in the cover, I made the RFC bigger th=
an needed to
> kind of showcase how we can properly configure the hdl core to support th=
ings
> (interface calibration) that were very hard to do with the current implem=
entation.
> I'll make sure to add the minimum needed API to accommodate what we have =
right now.
>=20
> > I haven't fully gotten my head around the ordering constraints on remov=
al.
> > Are there other users of the component framework that have similar prob=
lems?
> >  =20
>=20
> My understanding on the component API is that one should do all the tear =
down in the
> .unbind() callback. As usual, I can see some drivers not really doing tha=
t.
>=20
> > Also, I don't yet understand how a multiple front end, single backend s=
etup
> > would work.=C2=A0 Or indeed single front end, multiple backend...=C2=A0=
 Maybe we don't
> > need those cases, but if we want this to be useful beyond adi-axi we
> > probably at least want an outline of how they work.
> >  =20
>=20
> Indeed we can have multiple (and we have it out of tree) backends on one =
frontend.
> Think on an ADC/DAC with fairly complex data path with more than one
> channel/interface (CMOS, LVDS, etc). Typically, in those case, each of th=
e interface
> will be connected to an instance of the hdl core (the backend).

That might work out for your case, but not the stm32 one where I think we c=
an end
up with interleaved data from two front ends in the same buffer...

>=20
> > Jonathan
> >  =20
> > > ---
> > > =C2=A0drivers/iio/addac/converter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 547 ++++++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/addac/converter.h | 485 +++++++++++++++++++++=
+++
> > > =C2=A02 files changed, 1032 insertions(+)
> > > =C2=A0create mode 100644 drivers/iio/addac/converter.c
> > > =C2=A0create mode 100644 include/linux/iio/addac/converter.h
> > >=20
> > > diff --git a/drivers/iio/addac/converter.c b/drivers/iio/addac/conver=
ter.c
> > > new file mode 100644
> > > index 000000000000..31ac704255ad
> > > --- /dev/null
> > > +++ b/drivers/iio/addac/converter.c
> > > @@ -0,0 +1,547 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Framework to handle complex IIO aggregate devices
> > > + *
> > > + * A note on some of the design expectations with regards to lifetim=
es and
> > > + * devices bringup/removal.
> > > + *
> > > + * The Framework is using, under the wood, the component API which m=
akes it to
> > > + * easy treat a bunch of devices as one aggregate device. This means=
 that the
> > > + * complete thing is only brought to live when all the deviced are p=
robed. To do =20
> >=20
> > devices
> >  =20
> > > + * this, two callbacks are used that should in fact completely repla=
ce .probe()
> > > + * and .remove(). The formers should only be used the minimum needed=
. Ideally, =20
> >=20
> > I don't follow the sentence in the middle of the line above.
> >  =20
> > > + * only to call the functions to add and remove frontend annd backen=
d devices. =20
> > Spell check...
> >  =20
> > > + *
> > > + * It is advised for frontend and backend drivers to use their .remo=
ve() =20
> >=20
> > I'd not 'advise' things. I'd say the 'use' them.
> >  =20
> > > + * callbacks (to use devres API during the frontend and backends
> > > initialization).
> > > + * See the comment in @converter_frontend_bind().
> > > + *
> > > + * It is also assumed that converter objects cannot be accessed once=
 one of the
> > > + * devices of the aggregate device is removed (effectively bringing =
the all the =20
> >=20
> > bringing all the devices down
> >  =20
> > > + * devices down). Based on that assumption, these objects are not re=
fcount which =20
> >=20
> > recounted
> >  =20
> > > + * means accessing them will likely fail miserably. =20
> >=20
> > I hope that doesn't mean there will be no protection.=C2=A0 I don't min=
d if nothing
> > works
> > but breaking the kernel isn't an option.
> >  =20
>=20
> Hmm, well, you'll have a use after free... But one will have to be creati=
ve to use
> one of these objects after releasing the device from the driver (on the u=
nbind path).
> And here we don't have any interaction with chardevs, etc which might kee=
p references
> to devices even after unbind.
>=20
> The only place where I can see someone doing it wrong is from a frontend =
driver if
> for some reason (that I cannot think of now) we need to keep references/u=
se 'struct
> converter' after .frontend_close() is called. In that case and if the bac=
kend driver
> was the one being removed/unbind, the converter object will effectively b=
e freed (as
> it was allocated with devres) and we are left with a possible use after f=
ree. But
> that would be a very strange usecase to be missed in review (I hope :)).
>=20
> We can always refcount the converters (not sure if we need to do it for f=
rontend
> devices). Sure, drivers can still screw up but at least in that case, the=
 framework
> is not to blame :).

If the rules are clearly stated (with some reasoning) I don't think we need
to care about saying what happens if you break them.  People will always sh=
oot
themselves in the foot, but as long as it is reasonably fiddly to do that's
fine by me :)

...

> > > +static int converter_frontend_bind(struct device *dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_frontend =
*frontend =3D dev_get_drvdata(dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D component_bind_all=
(dev, NULL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We open a new group so =
that we can control when resources are
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * released and still use =
device managed (devm_) calls. The expectations
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are that on probe, back=
end resources are allocated first followed by
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frontend resources =
(where registering the IIO device must happen)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Naturally we want the r=
everse order on the unbind path and that would
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not be possible without=
 opening our own devres group.
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that the component=
 API also opens it's own devres group when
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * calling the .bind() cal=
lbacks for both the aggregate device
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (our frontend) and each=
 of the components (our backends). On the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unbind path, the aggreg=
ate .unbind() function is called
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (@converter_frontend_un=
bind()) which should be responsible to tear
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * down all the components=
 (effectively releasing all the resources
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated on each compo=
nent devres group) and only then the aggregate
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devres group is release=
d. Hence, the order we want to maintain for
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing resources wou=
ld not be satisfied because backend resources
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * would be freed first. W=
ith our own group, we can control when
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing the resources=
 and we do it before @component_unbind_all().
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This also relies that i=
nternally the component API is releasing each
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of the component's devr=
es group. That is likely not to change, but
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * maybe we should not tru=
st it and also open our own groups for backend
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices?!
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Another very important =
thing to keep in mind is that this is only
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * valid if frontend and b=
ackend driver's are implementing their
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .remove() callback to c=
all @converter_frontend_del() and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @converter_backend_del(=
). Calling those functions from
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devm_add_action* and us=
e devm APIs in .frontend_init() and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_init() is not =
going to work. Not perfect but still better
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * than having to tear eve=
rything down in .frontend_close() and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_close() =20
> >=20
> > That last bit is nasty and will be non obvious to driver authors.
> >=20
> > I wonder if we can come up with some means to make it hard to do.
> >  =20
>=20
> Yeah, I agree. The alternative is to always bring everything down in
> .frontend_close() and .backend_close(). But that can also be prone to sub=
tle bugs
> because it's easy to mess up the ordering when not using devres.
>=20
> So, at this point, I cannot really think on a perfect solution rather tha=
n keeping
> some rules like (assuming we keep the logic we have now):
>=20
> * Using devres on frontend|backend_init() only when .remove() is provided=
 on the
> driver.
> * No mixes of devres and .frontend|backend_close()
>=20
> But yeah, would be nice if we could come up with something to make it mor=
e obvious to
> driver authors.

>=20
> We might be able to detect that converter_backend_del() and converter_fro=
ntend_del()
> are under devres while no .frontend|backend_close() is being given. I gue=
ss that
> could be a valid indicator of likely misusage.
>=20
> Or even better (but I'm not sure it's doable with the current devres API)=
, detecting
> that converter_backend_del() or converter_frontend_del() are under devres=
 while more
> resources are also allocated in our specific opened groups. That would al=
ways be a
> problem (I think) because the only way for the _del() functions to be und=
er devres is
> if someone added them (from .probe) with devm_add_action() which means th=
at tearing
> down the aggregate will happen after some resources (which were allocated=
 in the
> _init() function) are already freed (as even with new groups, devres will=
 remove
> things on the reverse order). And that would defenitely be problematic. A=
nd, in fact,
> is the whole reason why I have the .del() functions on .remove() (so, tea=
ring down
> the aggregate device is the first thing to happen and resources are freed=
 in the
> reverse order they were allocated).
>=20

I couldn't work out how to do anything easily and would need some experimen=
ts.
Maybe some 'hidden' devres callbacks and a state flag somewhere.  If we reg=
ister
that very late we can perhaps detect that we entered devres cleanup before =
calling
expected manual cleanup.  I'm thinking have the setup path register a flag =
checking
callback and the cleanup path set a flag (devres now safe).  Then we can at=
 least
make it scream if we end up doing things in wrong way.

> Other thought would be some generic helper macros to use in these type of=
 drivers so
> a .remove() callback is always added to remove the components.=20
I wondered if that could work but it's an ugly macro because needs to deal =
with
different bus types.

>=20
> Anyways, even the above might be tricky enough to not include it. I'll gi=
ve it some
> thought.

Agreed - seems fiddly but maybe there is a neat trick to it.
Or indeed another subsystem already doing something.

> > > +#define converter_test_pattern_xlate(pattern, xlate)=C2=A0=C2=A0=C2=
=A0\
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__converter_test_pattern_x=
late(pattern, xlate, ARRAY_SIZE(xlate));
> > > +
> > > +#if IS_ENABLED(CONFIG_IIO_CONVERTER) =20
> >=20
> > Why?=C2=A0 I'd expect any driver that uses this framework to be useless=
 without
> > it, so we shouldn't need protections. Handle that with Kconfig select /=
 depends
> >  =20
>=20
> Well, we do have cases of frontends that might be used in standalone mode=
 (I mean,
> with no backend device) or with the backend connected. But alright, I wil=
l keep
> things simple for now and let's take care if such case ever get's upstrea=
m (hopefully
> they eventual do :)).

Yeah. Introduce the stubs when you need them ;)

...

> > > +
> > > +/**
> > > + * converter_frontend_del - Remove the frontend device
> > > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device to remove f=
rom the aggregate
> > > + *
> > > + * Removes the frontend from the aggregate device. This tears down t=
he frontend
> > > + * and all the converters.
> > > + *
> > > + * Ideally, this should be called from the frontend driver .remove()=
 callback.
> > > + * This means that all the converters (and the frontend) will be tea=
r down =20
> > torn down  =20
> > > + * before running any specific devres cleanup (at the driver core le=
vel). What
> > > + * this all means is that we can use devm_ apis in .frontend_init() =
and being
> > > + * sure those resources will be released after the backend resources=
 and before
> > > + * any devm_* used in .probe(). If that is not the case, one should =
likely not
> > > + * use any devm_ API in .frontend_init(). That means .frontend_close=
() should be
> > > + * provided to do all the necessary cleanups. =20
> >=20
> > You can force a driver remove to tear down another driver binding first=
 though it
> > all
> > gets fiddly.=C2=A0 Take a look at how device_release_driver() is used.=
=C2=A0 May well not
> > help you here though - I've not thought it through properly.
> >  =20
>=20
> Yeah, I know but I don't think it would help us here or even be correct a=
nd I think
> the problem would be the same. I mean, we would still need to call
> converter_frontend_del() or converter_backend_del() from the respective .=
remove()
> callbacks.
>=20
Agreed. I'm also not sure it helps and low on time at the moment to experim=
ent around this.

Jonathan
