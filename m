Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F978E974
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjHaJdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Aug 2023 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHaJdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 05:33:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D6194
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 02:32:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c1f6f3884so63428966b.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693474376; x=1694079176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWK2cFkxqnI7uv7GoDk9yEQyOgJrz0gvoDCUA6NhF1A=;
        b=eVsoF6MZyYPf6Cw+SxJRhTolJ20Be716v4q4uTWorgVNzK0qLXjbXZMUlEIjZTeQ8U
         WXPX72mFTNpbXYMdOk8eV5wFmKE2klYJ7ohW6nvlTwvCP+hQhEE1izdTpiygJFPbUJsG
         rYIUOc/YRdzNHgw64vymImpX4k0lKH2KUUv1Zgqkpa8CYeDf8Emv2AZqPgntudLzkR7E
         ang/pUg+DiahW8wbxRhDnrsKe8ghFfcGsY1hmXHtx7HWYhchMNAz+ti5VBgkIGMxx9Az
         KnKh3FcDX+R4YH11y7em+i1SOsxMucNKksjWcN2EVfzMCVnykAzfHmEtymLFbGIjW2fJ
         7ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474376; x=1694079176;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWK2cFkxqnI7uv7GoDk9yEQyOgJrz0gvoDCUA6NhF1A=;
        b=QhU9jKmJW3LSaMHFwhnDHGhtBkAClqFk4k3ZO28x0Vx1pH31uzNVYBM7PAkjW3NX+V
         0Z6GOvtqo8sTWQ+8BlenDOkjURijJV7PPDkvGcOTQ2PBP1xGYQeutIfw8iBWEynUgUhn
         AStX4xTsdTu9oDgQNRsqJj24pNhTNnhMnQI9sXfU/CjEaYYG/itWpwvDugqxpbKVC+en
         K62zTlZm+O+pLCLIRR1i+CBkYJjTEz5F5YYsq+pXE0MeVEX+HtT4YxoouWJt+jIQsDQU
         DMqbW4hcys/D5j6rKjWdnv56NhHP1ED/FN/S7Houz4jKdN2kvjfbz1Wytlj91SEWc69/
         +07w==
X-Gm-Message-State: AOJu0YzNmC2r/YWm+rtN2bqp5rqFJBmIfx3NYFNTDtDQBCiENQ0eh9Qw
        mDSQi8FPHa+n1pXPBjFQMxusd7J47ojFXQ==
X-Google-Smtp-Source: AGHT+IG0IPVX0OQeT7lAe6owuyOIzGv7+FjrMJzKqjlkHS2jrqkJ6nFFhjq9EveBTldEb6eqrYlZ+g==
X-Received: by 2002:a17:906:9bc6:b0:9a5:7d24:de46 with SMTP id de6-20020a1709069bc600b009a57d24de46mr3470553ejc.15.1693474375860;
        Thu, 31 Aug 2023 02:32:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709067f8800b009a1a5a7ebacsm531248ejr.201.2023.08.31.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:32:55 -0700 (PDT)
Message-ID: <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 31 Aug 2023 11:32:54 +0200
In-Reply-To: <20230830180234.00007437@Huawei.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
         <20230804145342.1600136-2-nuno.sa@analog.com>
         <20230830180234.00007437@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
> On Fri, 4 Aug 2023 16:53:39 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Hi Nuno,
>=20

Hi Jonathan,

Thanks for the initial review...

>=20
> One general comment is that you could have stripped this back a fair bit
> for ease of understanding.=C2=A0 At this stage we don't care about things
> like debug or control of test patterns.=C2=A0 Bring those in as extra pat=
ches.
>=20

Agreed... As I mentioned (I think) in the cover, I made the RFC bigger than=
 needed to
kind of showcase how we can properly configure the hdl core to support thin=
gs
(interface calibration) that were very hard to do with the current implemen=
tation.
I'll make sure to add the minimum needed API to accommodate what we have ri=
ght now.

> I haven't fully gotten my head around the ordering constraints on removal=
.
> Are there other users of the component framework that have similar proble=
ms?
>=20

My understanding on the component API is that one should do all the tear do=
wn in the
.unbind() callback. As usual, I can see some drivers not really doing that.

> Also, I don't yet understand how a multiple front end, single backend set=
up
> would work.=C2=A0 Or indeed single front end, multiple backend...=C2=A0 M=
aybe we don't
> need those cases, but if we want this to be useful beyond adi-axi we
> probably at least want an outline of how they work.
>=20

Indeed we can have multiple (and we have it out of tree) backends on one fr=
ontend.
Think on an ADC/DAC with fairly complex data path with more than one
channel/interface (CMOS, LVDS, etc). Typically, in those case, each of the =
interface
will be connected to an instance of the hdl core (the backend).

> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/addac/converter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 547 ++++++++++++++++++++++++++++
> > =C2=A0include/linux/iio/addac/converter.h | 485 +++++++++++++++++++++++=
+
> > =C2=A02 files changed, 1032 insertions(+)
> > =C2=A0create mode 100644 drivers/iio/addac/converter.c
> > =C2=A0create mode 100644 include/linux/iio/addac/converter.h
> >=20
> > diff --git a/drivers/iio/addac/converter.c b/drivers/iio/addac/converte=
r.c
> > new file mode 100644
> > index 000000000000..31ac704255ad
> > --- /dev/null
> > +++ b/drivers/iio/addac/converter.c
> > @@ -0,0 +1,547 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Framework to handle complex IIO aggregate devices
> > + *
> > + * A note on some of the design expectations with regards to lifetimes=
 and
> > + * devices bringup/removal.
> > + *
> > + * The Framework is using, under the wood, the component API which mak=
es it to
> > + * easy treat a bunch of devices as one aggregate device. This means t=
hat the
> > + * complete thing is only brought to live when all the deviced are pro=
bed. To do
>=20
> devices
>=20
> > + * this, two callbacks are used that should in fact completely replace=
 .probe()
> > + * and .remove(). The formers should only be used the minimum needed. =
Ideally,
>=20
> I don't follow the sentence in the middle of the line above.
>=20
> > + * only to call the functions to add and remove frontend annd backend =
devices.
> Spell check...
>=20
> > + *
> > + * It is advised for frontend and backend drivers to use their .remove=
()
>=20
> I'd not 'advise' things. I'd say the 'use' them.
>=20
> > + * callbacks (to use devres API during the frontend and backends
> > initialization).
> > + * See the comment in @converter_frontend_bind().
> > + *
> > + * It is also assumed that converter objects cannot be accessed once o=
ne of the
> > + * devices of the aggregate device is removed (effectively bringing th=
e all the
>=20
> bringing all the devices down
>=20
> > + * devices down). Based on that assumption, these objects are not refc=
ount which
>=20
> recounted
>=20
> > + * means accessing them will likely fail miserably.
>=20
> I hope that doesn't mean there will be no protection.=C2=A0 I don't mind =
if nothing
> works
> but breaking the kernel isn't an option.
>=20

Hmm, well, you'll have a use after free... But one will have to be creative=
 to use
one of these objects after releasing the device from the driver (on the unb=
ind path).
And here we don't have any interaction with chardevs, etc which might keep =
references
to devices even after unbind.

The only place where I can see someone doing it wrong is from a frontend dr=
iver if
for some reason (that I cannot think of now) we need to keep references/use=
 'struct
converter' after .frontend_close() is called. In that case and if the backe=
nd driver
was the one being removed/unbind, the converter object will effectively be =
freed (as
it was allocated with devres) and we are left with a possible use after fre=
e. But
that would be a very strange usecase to be missed in review (I hope :)).

We can always refcount the converters (not sure if we need to do it for fro=
ntend
devices). Sure, drivers can still screw up but at least in that case, the f=
ramework
is not to blame :).

> > + *
> > + * Copyright (C) 2023 Analog Devices Inc.
> > + */
> > +
> > +#define dev_fmt(fmt) "Converter - " fmt
> > +
> > +#include <linux/component.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/addc/converter.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +
> > +struct converter_backend {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head entry;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct converter_ops *=
ops;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *drvdata;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int cached_reg_addr=
;
> > +};
> > +
> > +struct converter_frontend {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head list;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct frontend_ops *o=
ps;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev;
> > +};
>=20
>=20
>=20
> > +static int converter_bind(struct device *dev, struct device *aggregate=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 void *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_frontend *f=
rontend =3D dev_get_drvdata(aggregate);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_backend *co=
nv =3D dev_get_drvdata(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D conv->ops->backend_i=
nit(conv, dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_add_tail(&conv->entry, =
&frontend->list);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +
> > +static void converter_unbind(struct device *dev, struct device *aggreg=
ate,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 void *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_backend *co=
nv =3D dev_get_drvdata(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (conv->ops->backend_close=
)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0conv->ops->backend_close(conv);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* after this point the conv=
erter should not be used anymore */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0converter_set_drvdata(conv, =
NULL);
> > +}
> > +
> > +static const struct component_ops converter_component_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.bind =3D converter_bind,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.unbind =3D converter_unbind=
,
> > +};
> > +
> > +static int converter_frontend_bind(struct device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_frontend *f=
rontend =3D dev_get_drvdata(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D component_bind_all(d=
ev, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We open a new group so th=
at we can control when resources are
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * released and still use de=
vice managed (devm_) calls. The expectations
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are that on probe, backen=
d resources are allocated first followed by
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frontend resources (w=
here registering the IIO device must happen)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Naturally we want the rev=
erse order on the unbind path and that would
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not be possible without o=
pening our own devres group.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that the component A=
PI also opens it's own devres group when
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * calling the .bind() callb=
acks for both the aggregate device
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (our frontend) and each o=
f the components (our backends). On the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unbind path, the aggregat=
e .unbind() function is called
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (@converter_frontend_unbi=
nd()) which should be responsible to tear
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * down all the components (=
effectively releasing all the resources
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * allocated on each compone=
nt devres group) and only then the aggregate
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devres group is released.=
 Hence, the order we want to maintain for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing resources would=
 not be satisfied because backend resources
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * would be freed first. Wit=
h our own group, we can control when
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * releasing the resources a=
nd we do it before @component_unbind_all().
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This also relies that int=
ernally the component API is releasing each
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of the component's devres=
 group. That is likely not to change, but
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * maybe we should not trust=
 it and also open our own groups for backend
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices?!
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Another very important th=
ing to keep in mind is that this is only
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * valid if frontend and bac=
kend driver's are implementing their
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .remove() callback to cal=
l @converter_frontend_del() and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @converter_backend_del().=
 Calling those functions from
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devm_add_action* and use =
devm APIs in .frontend_init() and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_init() is not go=
ing to work. Not perfect but still better
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * than having to tear every=
thing down in .frontend_close() and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .backend_close()
>=20
> That last bit is nasty and will be non obvious to driver authors.
>=20
> I wonder if we can come up with some means to make it hard to do.
>=20

Yeah, I agree. The alternative is to always bring everything down in
.frontend_close() and .backend_close(). But that can also be prone to subtl=
e bugs
because it's easy to mess up the ordering when not using devres.

So, at this point, I cannot really think on a perfect solution rather than =
keeping
some rules like (assuming we keep the logic we have now):

* Using devres on frontend|backend_init() only when .remove() is provided o=
n the
driver.
* No mixes of devres and .frontend|backend_close()

But yeah, would be nice if we could come up with something to make it more =
obvious to
driver authors.

We might be able to detect that converter_backend_del() and converter_front=
end_del()
are under devres while no .frontend|backend_close() is being given. I guess=
 that
could be a valid indicator of likely misusage.

Or even better (but I'm not sure it's doable with the current devres API), =
detecting
that converter_backend_del() or converter_frontend_del() are under devres w=
hile more
resources are also allocated in our specific opened groups. That would alwa=
ys be a
problem (I think) because the only way for the _del() functions to be under=
 devres is
if someone added them (from .probe) with devm_add_action() which means that=
 tearing
down the aggregate will happen after some resources (which were allocated i=
n the
_init() function) are already freed (as even with new groups, devres will r=
emove
things on the reverse order). And that would defenitely be problematic. And=
, in fact,
is the whole reason why I have the .del() functions on .remove() (so, teari=
ng down
the aggregate device is the first thing to happen and resources are freed i=
n the
reverse order they were allocated).

Other thought would be some generic helper macros to use in these type of d=
rivers so
a .remove() callback is always added to remove the components.=20

Anyways, even the above might be tricky enough to not include it. I'll give=
 it some
thought.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!devres_open_group(dev, =
frontend, GFP_KERNEL))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D frontend->ops->front=
end_init(frontend, dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0devres_release_group(dev, frontend);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devres_close_group(dev, NULL=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +
> > +static void converter_frontend_unbind(struct device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct converter_frontend *f=
rontend =3D dev_get_drvdata(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (frontend->ops->frontend_=
close)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0frontend->ops->frontend_close(frontend);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devres_release_group(dev, fr=
ontend);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0component_unbind_all(dev, NU=
LL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_del_init(&frontend->lis=
t);
> > +}
> > +
> > +static const struct component_master_ops frontend_component_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.bind =3D converter_frontend=
_bind,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.unbind =3D converter_fronte=
nd_unbind,
> > +};
>=20
>=20
> > diff --git a/include/linux/iio/addac/converter.h
> > b/include/linux/iio/addac/converter.h
> > new file mode 100644
> > index 000000000000..09d9d491b2b8
> > --- /dev/null
> > +++ b/include/linux/iio/addac/converter.h
> > @@ -0,0 +1,485 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef _CONVERTER_H
> > +#define _CONVERTER_H
> > +
> > +struct converter_frontend;
> > +struct converter_backend;
> > +struct iio_dev;
> > +struct device;
> > +struct regmap;
> > +
> > +enum converter_test_pattern {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_PRBS_7,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_PRBS_15,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_PRBS_23,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_PRBS_31,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_RAMP_NIBBLE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_RAMP_16,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* vendor specific from 32 *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_ADI_PRBS_9A =3D 32=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_ADI_PRBS_23A,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_ADI_PRBS_X,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_TEST_PATTERN_MAX
> > +};
> > +
> > +enum converter_data_type {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_TWOS_COMPLEMENT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_OFFSET_BINARY,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_DATA_TYPE_MAX
> > +};
> > +
> > +enum converter_edge {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_RISING_EDGE_SAMPLE=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_FALLING_EDGE_SAMPL=
E,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONVERTER_EDGE_MAX
> > +};
> > +
> > +struct converter_chan_status {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool errors;
> > +};
> > +
> > +/**
> > + * struct converter_data_fmt - Backend data format
> > + * @type:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Data type.
> > + * @sign_extend:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bool to tell=
 if the data is sign extended.
> > + * @enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Enable/Disable the data format module. If disabled,
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0not formatting =
will happen.
> > + */
> > +struct converter_data_fmt {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum converter_data_type typ=
e;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool sign_extend;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool enable;
> > +};
> > +
> > +/**
> > + * struct converter_test_pattern_xlate - Helper struct for test patter=
n handling
> > + * @pattern:=C2=A0=C2=A0=C2=A0Pattern to configure.
> > + * @reg_val:=C2=A0=C2=A0=C2=A0Register value for the pattern to config=
ure.
> > + */
> > +struct converter_test_pattern_xlate {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum converter_test_pattern =
pattern;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int reg_val;
> > +};
> > +
> > +/**
> > + * struct converter_ops - Backend supported operations
> > + * @backend_init:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mandatory functio=
n to initialize the backend device. It
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should be a rep=
lacement for .probe() where the latest
>=20
> just say .probe() again as 'the latest' is a fiddly bit of English
>=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should only hav=
e to care about doing @converter_add().
> > + * @backend_close:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Optional function to t=
ear down the device.
> > + * @enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Enable the backend device.
> > + * @disable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0Disable the backend device.
> > + * @data_format_set:=C2=A0=C2=A0=C2=A0Configure the data format for a =
specific channel.
> > + * @chan_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Enable one c=
hannel.
> > + * @chan_disable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Disable one chann=
el.
> > + * @iodelay_set:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Controls the=
 IO delay for all the lanes at the interface
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(where data is =
actually transferred between frontend and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backen=
d) level.
> > + * @test_pattern_set:=C2=A0=C2=A0Set's a test pattern to be transmitte=
d/received by the
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend. Typica=
lly useful for debug or interface
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0purposes calibr=
ation.
> > + */
> > +struct converter_ops {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*backend_init)(struct c=
onverter_backend *conv, struct device *dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*backend_close)(struct=
 converter_backend *conv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*enable)(struct convert=
er_backend *conv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*disable)(struct conve=
rter_backend *conv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*data_format_set)(struc=
t converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct converter_data_fmt *data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*chan_enable)(struct co=
nverter_backend *conv, unsigned int chan);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*chan_disable)(struct c=
onverter_backend *conv, unsigned int chan);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*iodelay_set)(struct co=
nverter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int num_lanes, unsigned int delay);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*test_pattern_set)(stru=
ct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum converter_test_pattern patte=
rn);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*chan_status)(struct co=
nverter_backend *conv, unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct converter_chan_status *status);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*sample_edge_select)(st=
ruct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum converter_edge edge);
> > +};
> > +
> > +/**
> > + * struct frontend_ops - Frontend supported operations
> > + * @frontend_init:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mandatory function to =
initialize the frontend device. It
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should be a rep=
lacement for .probe() where the latest
>=20
> As above.
>=20
>=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0should only hav=
e to care about doing @frontend_add().
> > + * @frontend_close:=C2=A0=C2=A0=C2=A0=C2=A0Optional function to tear d=
own the device.
> > + */
> > +struct frontend_ops {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*frontend_init)(struct =
converter_frontend *frontend,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct device *dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*frontend_close)(struc=
t converter_frontend *frontend);
> > +};
> > +
> > +/**
> > + * converter_test_pattern_xlate() - Helper macro for translatting test=
 patterns
> > + * @pattern:=C2=A0=C2=A0=C2=A0Pattern to translate.
> > + * @xlate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0List of @struct converter_test=
_pattern_xlate pairs.
> > + *
> > + * Simple helper to match a supported pattern and get the register val=
ue. Should
> > + * only be called by backend devices. Automatically computes the numbe=
r of
> > + * @xlate entries.
> > + */
> > +#define converter_test_pattern_xlate(pattern, xlate)=C2=A0=C2=A0=C2=A0=
\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__converter_test_pattern_xla=
te(pattern, xlate, ARRAY_SIZE(xlate));
> > +
> > +#if IS_ENABLED(CONFIG_IIO_CONVERTER)
>=20
> Why?=C2=A0 I'd expect any driver that uses this framework to be useless w=
ithout
> it, so we shouldn't need protections. Handle that with Kconfig select / d=
epends
>=20

Well, we do have cases of frontends that might be used in standalone mode (=
I mean,
with no backend device) or with the backend connected. But alright, I will =
keep
things simple for now and let's take care if such case ever get's upstream =
(hopefully
they eventual do :)).

> > +
> > +/**
> > + * converter_get_drvdata - Get driver private data
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
>=20
> Comments should be next to implementation (I got this wrong in original I=
IO
> code and still haven't pushed them all down).=C2=A0 One reason is that pe=
ople often
> change the internals without realizing there is a comment on them in a he=
ader
> that also needs updating. Much harder to do that if it's right in front o=
f
> you in the c file.
>=20

Ohh I didn't realised that but makes sense...

> > + */
> > +void *converter_get_drvdata(const struct converter_backend *conv);
> > +
> > +/**
> > + * converter_set_drvdata - Set driver private data
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @drvdata:=C2=A0=C2=A0=C2=A0Driver private data.
> > + */
> > +void converter_set_drvdata(struct converter_backend *conv, void *drvda=
ta);
> > +
> > +/**
> > + * converter_set_regmap - Add a regmap object to a converter
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @regmap:=C2=A0=C2=A0=C2=A0=C2=A0Regmap object.
> > + */
> > +void converter_set_regmap(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct regmap *regmap);
> > +
> > +/**
> > + * __converter_test_pattern_xlate - Helper macro for translatting test=
 patterns
> > + * @pattern:=C2=A0=C2=A0=C2=A0Pattern to translate.
> > + * @xlate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0List of @struct converter_test=
_pattern_xlate pairs.
> > + * @n_matches:=C2=A0Number of entries in @xlate.
> > + *
> > + * Simple helper to match a supported pattern and get the register val=
ue. Should
> > + * only be called by backend devices.
> > + */
> > +int __converter_test_pattern_xlate(unsigned int pattern,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct convert=
er_test_pattern_xlate
> > *xlate,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int n_matches);
> > +
> > +/**
> > + *
> > + */
> > +int converter_add(struct device *dev, const struct converter_ops *ops)=
;
> > +
> > +/**
> > + * converter_del - Remove the converter device
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device to remove fro=
m the aggregate
> > + *
> > + * Removes the converter from the aggregate device. This tears down th=
e frontend
> > + * and all the converters.
> > + *
> > + * Ideally, this should be called from the backend driver .remove() ca=
llback.
> > + * This means that all the converters (and the frontend) will be tear =
down
> > before
> > + * running any specific devres cleanup (at the driver core level). Wha=
t this all
> > + * means is that we can use devm_ apis in @backend_init() and being su=
re those
> > + * resources will be released after the backend resources and before a=
ny devm_*
> > + * used in @probe(). If that is not the case, one should likely not us=
e any
> > + * devm_ API in @backend_init(). That means .backend_close() should be
> > + * provided to do all the necessary cleanups.
> > + */
> > +void converter_del(struct device *dev);
> > +
> > +/**
> > + * converter_enable - Enable the device
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + *
> > + * Enables the backend device.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_enable(struct converter_backend *conv);
> > +
> > +/**
> > + * converter_disable - Disable the device
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + *
> > + * Disables the backend device.
> > + */
> > +void converter_disable(struct converter_backend *conv);
> > +
> > +/**
> > + * converter_test_pattern_set - Set a test pattern
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @chan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Channel number.
> > + * @pattern:=C2=A0=C2=A0=C2=A0Pattern to set.
> > + *
> > + * Set's a test pattern to be transmitted/received by the backend. Typ=
ically
> > + * useful for debug or interface calibration purposes. A backend drive=
r can
> > + * call the @converter_test_pattern_xlate() helper to validate the pat=
tern
> > + * (given an array of @struct converter_test_pattern_xlate).
> > + *
> > + * Note that some patterns might be frontend specific. I.e, as far as =
the
> > + * backend is concerned the pattern is valid (from a register point of=
 view) but
> > + * the actual support for the pattern is not implemented in the device=
 for this
> > + * specific frontend. It's up to the frontend to ask for a proper patt=
ern
> > + * (as it should know better).
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_test_pattern_set(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum converter_test_pattern pattern);
> > +
> > +int converter_chan_status_get(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct converter_chan_status *status);
> > +
> > +/**
> > + * converter_data_format_set - Configure the data format
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @chan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Channel number.
> > + * @data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Data format.
> > + *
> > + * Properly configure a channel with respect to the expected data form=
at. A
> Configure a channel ...
>=20
> We won't do it improperly ;)
>=20
> > + * @struct converter_data_fmt must be passed with the settings.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_data_format_set(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 const struct converter_data_fmt *data);
> > +
> > +int converter_sample_edge_select(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum converter_edge edge);
> > +
> > +static inline int
> > +converter_sample_on_falling_edge(struct converter_backend *conv)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return converter_sample_edge=
_select(conv, CONVERTER_RISING_EDGE_SAMPLE);
> > +}
> > +
> > +static inline int
> > +converter_sample_on_rising_edge(struct converter_backend *conv)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return converter_sample_edge=
_select(conv, CONVERTER_FALLING_EDGE_SAMPLE);
> > +}
> > +
> > +/**
> > + * converter_chan_enable - Enable a backend channel
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @chan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Channel number.
> > + *
> > + * Enables a channel on the backend device.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_chan_enable(struct converter_backend *conv, unsigned int=
 chan);
> > +
> > +/**
> > + * converter_chan_disable - Disable a backend channel
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @chan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Channel number.
> > + *
> > + * Disables a channel on the backend device.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_chan_disable(struct converter_backend *conv, unsigned in=
t chan);
> > +
> > +/**
> > + * converter_iodelay_set - Set's the backend data interface IO delay
> > + * @conv:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Converter device.
> > + * @num_lanes:=C2=A0Number of lanes in the data interface.
> > + * @delay:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Delay to set.
> > + *
> > + * Controls the IO delay for all the lanes at the data interface (wher=
e data is
> > + * actually transferred between frontend and backend) level.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int converter_iodelay_set(struct converter_backend *conv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 unsigned int num_lanes, unsigned int delay);
> > +
> > +/**
> > + * converter_frontend_del - Remove the frontend device
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device to remove fro=
m the aggregate
> > + *
> > + * Removes the frontend from the aggregate device. This tears down the=
 frontend
> > + * and all the converters.
> > + *
> > + * Ideally, this should be called from the frontend driver .remove() c=
allback.
> > + * This means that all the converters (and the frontend) will be tear =
down
> torn down=20
> > + * before running any specific devres cleanup (at the driver core leve=
l). What
> > + * this all means is that we can use devm_ apis in .frontend_init() an=
d being
> > + * sure those resources will be released after the backend resources a=
nd before
> > + * any devm_* used in .probe(). If that is not the case, one should li=
kely not
> > + * use any devm_ API in .frontend_init(). That means .frontend_close()=
 should be
> > + * provided to do all the necessary cleanups.
>=20
> You can force a driver remove to tear down another driver binding first t=
hough it
> all
> gets fiddly.=C2=A0 Take a look at how device_release_driver() is used.=C2=
=A0 May well not
> help you here though - I've not thought it through properly.
>=20

Yeah, I know but I don't think it would help us here or even be correct and=
 I think
the problem would be the same. I mean, we would still need to call
converter_frontend_del() or converter_backend_del() from the respective .re=
move()
callbacks.

BTW, thanks for all the English fixes and help :)

- Nuno S=C3=A1
>=20
