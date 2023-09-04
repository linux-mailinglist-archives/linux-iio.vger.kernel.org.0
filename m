Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF89791978
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjIDOLp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjIDOLo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 10:11:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECDCDE
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 07:11:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76dcf1d8957so93094285a.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Sep 2023 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693836699; x=1694441499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pKDKEY47CyDql6APi2bp+UbfKWDTwF3ffNhJnQft1L8=;
        b=nIf32VteH2o1SOlngJyCwV6yI1fZIklKTo0SSpKOGG+2sFciovQyUFqP2srLV5Xbqr
         iGstJCB897laJ0LXza/Q3g0CI/aGNtmUU8Z8c1Dg6zFLSFsFY/Tkhm8lnZogx6tcrg18
         DIasMcsFwebg4WnwnJrn/BC0HNo+HJgFZwQQozG1XQvaq5k8LpgmalutXxFs97FipWn7
         R8s0seBecfWz31y+hEl/6lfN+qVftTHinlMzWbeeOH94Os1HUzjBiOLTNaD395O2+LfZ
         gN0nDFeyGeOEKCB83RCREucmzekV35muo2yo/CVl/B3vtNC3DIaBbEi/9FeE3czhJVkb
         hDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693836699; x=1694441499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKDKEY47CyDql6APi2bp+UbfKWDTwF3ffNhJnQft1L8=;
        b=kK1kgaIjBlEc5WwaYiTOx9jtpL7zr2MeJsi8607uX9eZBeQKK4LdtWxgqF3rCBGnaH
         hLk2cK8VGTejVFLky1zBt4ApLAu9Wp/orgY4awcsaqqsdZtb7L35TO6Jnx+DBPaavfaE
         yNfQZI6EhbmYQ/YyzzdJfatST3JThj0tOVPSlLHoqZEbK3E7gjs1uuTehMmRxdGPEjOY
         MnTSlNqGfhOvzHpXYFYqoKGDa65zRhX4UXL6PCW9YDGbfQ4Zy4Dameagd2+X8YGN9luv
         X3YZkPwX94i3T5y1eB9mzsR5qLh1o1kBvYWTeGtNMQWkDokY+JRmM9jPHjRzTJodeoIj
         IdMA==
X-Gm-Message-State: AOJu0YybIbTqdJnp+ZyL5eUM8CzHuUMIaP5nxbyD25XkDRu1lJBlwqbX
        s9SqzIux0DlgNGACLrpkCFuXkK6aqob2ZLa5
X-Google-Smtp-Source: AGHT+IFxupa9bSBVNhTLTIiOAKiYAzemUUPZmfCaUSlEIFhJnF4OLtYTpJ4nQNe1NMtACW46M/9WGA==
X-Received: by 2002:a05:620a:8cb:b0:76d:aa3b:ac9c with SMTP id z11-20020a05620a08cb00b0076daa3bac9cmr9890763qkz.46.1693836699296;
        Mon, 04 Sep 2023 07:11:39 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:bd39:43a2:571c:1c76? (p200300f6ef346000bd3943a2571c1c76.dip0.t-ipconnect.de. [2003:f6:ef34:6000:bd39:43a2:571c:1c76])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a158700b0076cb3690ae7sm3350768qkk.68.2023.09.04.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 07:11:38 -0700 (PDT)
Message-ID: <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Date:   Mon, 04 Sep 2023 16:14:17 +0200
In-Reply-To: <20230903115653.5bb8c0e8@jic23-huawei>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
         <20230804145342.1600136-2-nuno.sa@analog.com>
         <20230830180234.00007437@Huawei.com>
         <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
         <20230903115653.5bb8c0e8@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2023-09-03 at 11:56 +0100, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 11:32:54 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
> > > On Fri, 4 Aug 2023 16:53:39 +0200
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>=C2=A0=20
> > >=20
> > > Hi Nuno,
> > > =C2=A0=20
> >=20
> > Hi Jonathan,
> >=20
> > Thanks for the initial review...
> >=20
> > >=20
> > > One general comment is that you could have stripped this back a fair =
bit
> > > for ease of understanding.=C2=A0 At this stage we don't care about th=
ings
> > > like debug or control of test patterns.=C2=A0 Bring those in as extra=
 patches.
> > > =C2=A0=20
> >=20
> > Agreed... As I mentioned (I think) in the cover, I made the RFC bigger =
than
> > needed to
> > kind of showcase how we can properly configure the hdl core to support
> > things
> > (interface calibration) that were very hard to do with the current
> > implementation.
> > I'll make sure to add the minimum needed API to accommodate what we hav=
e
> > right now.
> >=20
> > > I haven't fully gotten my head around the ordering constraints on rem=
oval.
> > > Are there other users of the component framework that have similar
> > > problems?
> > > =C2=A0=20
> >=20
> > My understanding on the component API is that one should do all the tea=
r
> > down in the
> > .unbind() callback. As usual, I can see some drivers not really doing t=
hat.
> >=20
> > > Also, I don't yet understand how a multiple front end, single backend
> > > setup
> > > would work.=C2=A0 Or indeed single front end, multiple backend...=C2=
=A0 Maybe we
> > > don't
> > > need those cases, but if we want this to be useful beyond adi-axi we
> > > probably at least want an outline of how they work.
> > > =C2=A0=20
> >=20
> > Indeed we can have multiple (and we have it out of tree) backends on on=
e
> > frontend.
> > Think on an ADC/DAC with fairly complex data path with more than one
> > channel/interface (CMOS, LVDS, etc). Typically, in those case, each of =
the
> > interface
> > will be connected to an instance of the hdl core (the backend).
>=20
> That might work out for your case, but not the stm32 one where I think we=
 can
> end
> up with interleaved data from two front ends in the same buffer...
>=20

Not sure I'm following this one. But wouldn't that be something specific fo=
r
each system (through devicetree)? I haven't tried but I think the same back=
end
could be used in different frontend devices (using the component API). That=
 is
not really a usecase for me but definitely something that could be supporte=
d (if
we need to start doing things like keep enable/disable counters and so on) =
if it
is a usecase for stm32.


> >=20
> > > Jonathan
> > > =C2=A0=20
> > > > ---
> > > > =C2=A0drivers/iio/addac/converter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 547 ++++++++++++++++++++++++++++
> > > > =C2=A0include/linux/iio/addac/converter.h | 485 +++++++++++++++++++=
+++++
> > > > =C2=A02 files changed, 1032 insertions(+)
> > > > =C2=A0create mode 100644 drivers/iio/addac/converter.c
> > > > =C2=A0create mode 100644 include/linux/iio/addac/converter.h
> > > >=20
> > > > diff --git a/drivers/iio/addac/converter.c
> > > > b/drivers/iio/addac/converter.c
> > > > new file mode 100644
> > > > index 000000000000..31ac704255ad
> > > > --- /dev/null
> > > > +++ b/drivers/iio/addac/converter.c
> > > > @@ -0,0 +1,547 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Framework to handle complex IIO aggregate devices
> > > > + *
> > > > + * A note on some of the design expectations with regards to lifet=
imes
> > > > and
> > > > + * devices bringup/removal.
> > > > + *
> > > > + * The Framework is using, under the wood, the component API which
> > > > makes it to
> > > > + * easy treat a bunch of devices as one aggregate device. This mea=
ns
> > > > that the
> > > > + * complete thing is only brought to live when all the deviced are
> > > > probed. To do=C2=A0=20
> > >=20
> > > devices
> > > =C2=A0=20
> > > > + * this, two callbacks are used that should in fact completely rep=
lace
> > > > .probe()
> > > > + * and .remove(). The formers should only be used the minimum need=
ed.
> > > > Ideally,=C2=A0=20
> > >=20
> > > I don't follow the sentence in the middle of the line above.
> > > =C2=A0=20
> > > > + * only to call the functions to add and remove frontend annd back=
end
> > > > devices.=C2=A0=20
> > > Spell check...
> > > =C2=A0=20
> > > > + *
> > > > + * It is advised for frontend and backend drivers to use their
> > > > .remove()=C2=A0=20
> > >=20
> > > I'd not 'advise' things. I'd say the 'use' them.
> > > =C2=A0=20
> > > > + * callbacks (to use devres API during the frontend and backends
> > > > initialization).
> > > > + * See the comment in @converter_frontend_bind().
> > > > + *
> > > > + * It is also assumed that converter objects cannot be accessed on=
ce
> > > > one of the
> > > > + * devices of the aggregate device is removed (effectively bringin=
g the
> > > > all the=C2=A0=20
> > >=20
> > > bringing all the devices down
> > > =C2=A0=20
> > > > + * devices down). Based on that assumption, these objects are not
> > > > refcount which=C2=A0=20
> > >=20
> > > recounted
> > > =C2=A0=20
> > > > + * means accessing them will likely fail miserably.=C2=A0=20
> > >=20
> > > I hope that doesn't mean there will be no protection.=C2=A0 I don't m=
ind if
> > > nothing
> > > works
> > > but breaking the kernel isn't an option.
> > > =C2=A0=20
> >=20
> > Hmm, well, you'll have a use after free... But one will have to be crea=
tive
> > to use
> > one of these objects after releasing the device from the driver (on the
> > unbind path).
> > And here we don't have any interaction with chardevs, etc which might k=
eep
> > references
> > to devices even after unbind.
> >=20
> > The only place where I can see someone doing it wrong is from a fronten=
d
> > driver if
> > for some reason (that I cannot think of now) we need to keep references=
/use
> > 'struct
> > converter' after .frontend_close() is called. In that case and if the
> > backend driver
> > was the one being removed/unbind, the converter object will effectively=
 be
> > freed (as
> > it was allocated with devres) and we are left with a possible use after
> > free. But
> > that would be a very strange usecase to be missed in review (I hope :))=
.
> >=20
> > We can always refcount the converters (not sure if we need to do it for
> > frontend
> > devices). Sure, drivers can still screw up but at least in that case, t=
he
> > framework
> > is not to blame :).
>=20
> If the rules are clearly stated (with some reasoning) I don't think we ne=
ed
> to care about saying what happens if you break them.=C2=A0 People will al=
ways shoot
> themselves in the foot, but as long as it is reasonably fiddly to do that=
's
> fine by me :)
>=20
> ...
>=20
> > > > +static int converter_frontend_bind(struct device *dev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_fronten=
d *frontend =3D dev_get_drvdata(dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D component_bind_a=
ll(dev, NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We open a new group s=
o that we can control when resources are
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * released and still us=
e device managed (devm_) calls. The
> > > > expectations
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are that on probe, ba=
ckend resources are allocated first
> > > > followed by
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frontend resource=
s (where registering the IIO device must
> > > > happen)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Naturally we want the=
 reverse order on the unbind path and
> > > > that would
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not be possible witho=
ut opening our own devres group.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that the compone=
nt API also opens it's own devres group
> > > > when
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * calling the .bind() c=
allbacks for both the aggregate device
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (our frontend) and ea=
ch of the components (our backends). On
> > > > the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unbind path, the aggr=
egate .unbind() function is called
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (@converter_frontend_=
unbind()) which should be responsible to
> > > > tear
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * down all the componen=
ts (effectively releasing all the
> > > > resources
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated on each com=
ponent devres group) and only then the
> > > > aggregate
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devres group is relea=
sed. Hence, the order we want to
> > > > maintain for
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing resources w=
ould not be satisfied because backend
> > > > resources
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * would be freed first.=
 With our own group, we can control when
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing the resourc=
es and we do it before
> > > > @component_unbind_all().
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This also relies that=
 internally the component API is
> > > > releasing each
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of the component's de=
vres group. That is likely not to
> > > > change, but
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * maybe we should not t=
rust it and also open our own groups for
> > > > backend
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices?!
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Another very importan=
t thing to keep in mind is that this is
> > > > only
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * valid if frontend and=
 backend driver's are implementing their
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .remove() callback to=
 call @converter_frontend_del() and
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @converter_backend_de=
l(). Calling those functions from
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devm_add_action* and =
use devm APIs in .frontend_init() and
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_init() is no=
t going to work. Not perfect but still
> > > > better
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * than having to tear e=
verything down in .frontend_close() and
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_close()=C2=
=A0=20
> > >=20
> > > That last bit is nasty and will be non obvious to driver authors.
> > >=20
> > > I wonder if we can come up with some means to make it hard to do.
> > > =C2=A0=20
> >=20
> > Yeah, I agree. The alternative is to always bring everything down in
> > .frontend_close() and .backend_close(). But that can also be prone to s=
ubtle
> > bugs
> > because it's easy to mess up the ordering when not using devres.
> >=20
> > So, at this point, I cannot really think on a perfect solution rather t=
han
> > keeping
> > some rules like (assuming we keep the logic we have now):
> >=20
> > * Using devres on frontend|backend_init() only when .remove() is provid=
ed on
> > the
> > driver.
> > * No mixes of devres and .frontend|backend_close()
> >=20
> > But yeah, would be nice if we could come up with something to make it m=
ore
> > obvious to
> > driver authors.
>=20
> >=20
> > We might be able to detect that converter_backend_del() and
> > converter_frontend_del()
> > are under devres while no .frontend|backend_close() is being given. I g=
uess
> > that
> > could be a valid indicator of likely misusage.
> >=20
> > Or even better (but I'm not sure it's doable with the current devres AP=
I),
> > detecting
> > that converter_backend_del() or converter_frontend_del() are under devr=
es
> > while more
> > resources are also allocated in our specific opened groups. That would
> > always be a
> > problem (I think) because the only way for the _del() functions to be u=
nder
> > devres is
> > if someone added them (from .probe) with devm_add_action() which means =
that
> > tearing
> > down the aggregate will happen after some resources (which were allocat=
ed in
> > the
> > _init() function) are already freed (as even with new groups, devres wi=
ll
> > remove
> > things on the reverse order). And that would defenitely be problematic.=
 And,
> > in fact,
> > is the whole reason why I have the .del() functions on .remove() (so,
> > tearing down
> > the aggregate device is the first thing to happen and resources are fre=
ed in
> > the
> > reverse order they were allocated).
> >=20
>=20

This would actually be very messy and hard to do properly. Concurrency betw=
een
the aggregate probing (at the component level) and unbinding (at driver cor=
e
level) would be very tricky if doable at all. On top that, we do have
devres_find() but no way to tell if a devres group has resources or not. It
would be easy to add one new API but likely not worth it just for this usec=
ase.

I also thought about an helper macro to wrap every devm_ call but your belo=
w
suggestion is way better and transparent to users.

> I couldn't work out how to do anything easily and would need some experim=
ents.
> Maybe some 'hidden' devres callbacks and a state flag somewhere.=C2=A0 If=
 we
> register
> that very late we can perhaps detect that we entered devres cleanup befor=
e
> calling
> expected manual cleanup.=C2=A0 I'm thinking have the setup path register =
a flag
> checking
> callback and the cleanup path set a flag (devres now safe).=C2=A0 Then we=
 can at
> least
> make it scream if we end up doing things in wrong way.
>=20

Hmm, that might actually be a good idea and something to try. It likely mea=
ns
having a mutex (I was happy not to have one for now :) but likely inevitabl=
e
somewhere down the road) for the flag but it might work. At least we'll be =
able
to dump a WARN or something if we suspect something is wrong.

> > Other thought would be some generic helper macros to use in these type =
of
> > drivers so
> > a .remove() callback is always added to remove the components.=20
> I wondered if that could work but it's an ugly macro because needs to dea=
l
> with
> different bus types.
>=20
>=20

We could have a macro per bus type. I'm not really seeing anything differen=
t
than platform, spi and i2c. But even like this, it could easily start to ge=
t
ugly because of accepted parameters (and any deviation would again mean a
different version per bus type). Another thing that crossed my mind was wra=
ppers
to module_spi_driver() and friends. Maybe that could work. Anyways, as you =
said
in one of your replies, this is in kernel interface that we can easily
add/change. So, I will defer this to a later point in time.

- Nuno S=C3=A1
