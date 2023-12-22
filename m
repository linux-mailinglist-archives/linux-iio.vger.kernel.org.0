Return-Path: <linux-iio+bounces-1220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CC81C764
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED37B21226
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36DF9D6;
	Fri, 22 Dec 2023 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz0ZATp5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C01171B;
	Fri, 22 Dec 2023 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d2376db79so13127605e9.0;
        Fri, 22 Dec 2023 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703237956; x=1703842756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jVrrNiEWnQMTSmSzK5+KsRbkx0B73QRT1bSxOYJV62s=;
        b=Cz0ZATp5S17Q6v53c8pVodQb7MAl8D6IiJGs3WkGhHLevTBfVD9vdlrsHXztr5EMyI
         Wz5Y/zW3BUQ9YALCwWvyT0BmiqGDrcpJ2jg4YOaq8OvuzGPyE+q5w4E9/7eZoXY6fUBx
         nuL8EcjZmmUMlhk3D1H8kYttbesc+XPl+0Z/hZ7WuU+/4l0DCbOTQW0LhwgqmcCUBXcL
         HngtHaJ49/ZUpUNfxgvU27zQR4Z/pkTa8xnKdvUjfWynVdr2ENd5Uhi2Ze/Vjsf4ClSZ
         dIhCmfLLAzFPGwOzFZJM4gtxiD9v8TQ/AwpBV/LRecn4WCtgo/gCNJe1SLppp/MvGgBV
         qBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703237956; x=1703842756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVrrNiEWnQMTSmSzK5+KsRbkx0B73QRT1bSxOYJV62s=;
        b=jm1rUHv+Wjd7WbTCegvHOXTRLtJcggLAYVkEs5Ja9P+lh6CfYLCRuMkDI3G0CFWzUS
         ibJPtrUTarpI9xppeePa5IYuPm18LREs1Q1gZzpZgYMXw/aL9rw2/y/MZG/CsUeDqeFK
         SQmiClSNz8nb1Olf5mIgggM2Qx84rDh58+uuTtjSHIyRI1yhMUmG2rduhX+5aw8WwYTL
         MhdtC9R6KQf1Hoivk5YVdXu3bCH+YeKD8F8uV5hPRa+3AJUs2YgcLQtQ3eKdxQ8x8Yoo
         k6FeSaHdQcNvV+HEN/WaU0xfYgS14HFeVO9NnYG1Vy85LnD4GHjvqhnyY+Vw8RqCr+4j
         23pg==
X-Gm-Message-State: AOJu0Yzy9hW3nzjM75rPEChfDGCkJ26R4NqeCvp3ooKmH33WfmidhVxa
	Yu56T8yrhpbWZXfWUyhZN27/YQiuPVXTmspjyF8=
X-Google-Smtp-Source: AGHT+IFuiBwjVVx7cCxgI2HocddyVXUeJKlWOqfertUHy8H5k70tVZRf0ueFWX8TLg6AGDjIGTC1JA==
X-Received: by 2002:a05:600c:6003:b0:40d:4956:9b66 with SMTP id az3-20020a05600c600300b0040d49569b66mr177938wmb.66.1703237955532;
        Fri, 22 Dec 2023 01:39:15 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:5877:261e:1d6d:8696? ([2001:818:ea8e:7f00:5877:261e:1d6d:8696])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b0040d3276ba19sm6274724wms.25.2023.12.22.01.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:39:14 -0800 (PST)
Message-ID: <f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Fri, 22 Dec 2023 10:39:15 +0100
In-Reply-To: <20231221174437.5935a5c3@jic23-huawei>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-6-998e9148b692@analog.com>
	 <20231221174437.5935a5c3@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 17:44 +0000, Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 16:34:09 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > This is a Framework to handle complex IIO aggregate devices.
> >=20
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0- Backends should register themselves with @devm_iio_backend_regi=
ster()
> > =C2=A0- Frontend devices should get backends with @devm_iio_backend_get=
()
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> A few minor comments, but seems good to me otherwise.
>=20
> Jonathan
>=20
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0drivers/iio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/industrialio-backend.c | 456 ++++++++++++++++++++++++=
+++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 75 ++++++
> > =C2=A05 files changed, 545 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3029841e92a8..df5f5b988926 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10334,6 +10334,14 @@ L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-media@vg=
er.kernel.org
> > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/media/rc/iguanair.c
> > =C2=A0
> > +IIO BACKEND FRAMEWORK
> > +M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Nuno Sa <nuno.sa@analog.com>
> > +R:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Olivier Moysan <olivier.moysan@foss.st=
.com>
> > +L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-iio@vger.kernel.org
> > +S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/industrialio-backend.c
> > +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/linux/iio/backend.h
> > +
> > =C2=A0IIO DIGITAL POTENTIOMETER DAC
> > =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Peter Rosin <peda@axentia.se>
> > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-iio@vger.kernel.org
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 52eb46ef84c1..451671112f73 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -71,6 +71,11 @@ config IIO_TRIGGERED_EVENT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Provides helper =
functions for setting up triggered events.
> > =C2=A0
> > +config IIO_BACKEND
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Framework to handle c=
omplex IIO aggregate devices.
>=20
> Add some more description here. Not sure the current text will help
> anyone understand it :)
>=20

Alright...

> > +
> > =C2=A0source "drivers/iio/accel/Kconfig"
> > =C2=A0source "drivers/iio/adc/Kconfig"
> > =C2=A0source "drivers/iio/addac/Kconfig"
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index 9622347a1c1b..0ba0e1521ba4 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_IIO_GTS_HELPER) +=3D industrialio-gts-he=
lper.o
> > =C2=A0obj-$(CONFIG_IIO_SW_DEVICE) +=3D industrialio-sw-device.o
> > =C2=A0obj-$(CONFIG_IIO_SW_TRIGGER) +=3D industrialio-sw-trigger.o
> > =C2=A0obj-$(CONFIG_IIO_TRIGGERED_EVENT) +=3D industrialio-triggered-eve=
nt.o
> > +obj-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend.o
> > =C2=A0
> > =C2=A0obj-y +=3D accel/
> > =C2=A0obj-y +=3D adc/
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > new file mode 100644
> > index 000000000000..75a0a66003e1
> > --- /dev/null
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -0,0 +1,456 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Framework to handle complex IIO aggregate devices.
> > + *
> > + * The typical architecture is to have one device as the frontend devi=
ce which
> > + * can be "linked" against one or multiple backend devices. All the II=
O and
> > + * userspace interface is expected to be registers/managed by the fron=
tend
> > + * device which will callback into the backends when needed (to get/se=
t some
> > + * configuration that it does not directly control).
> > + *
> > + * The framework interface is pretty simple:
> > + *=C2=A0=C2=A0 - Backends should register themselves with @devm_iio_ba=
ckend_register()
> > + *=C2=A0=C2=A0 - Frontend devices should get backends with @devm_iio_b=
ackend_get()
> > + *
> > + * Also to note that the primary target for this framework are convert=
ers like
> > + * ADC/DACs so @iio_backend_ops will have some operations typical of c=
onverter
> > + * devices. On top of that, this is "generic" for all IIO which means =
any kind
> > + * of device can make use of the framework. That said, If the @iio_bac=
kend_ops
> > + * struct begins to grow out of control, we can always refactor things=
 so that
> > + * the industrialio-backend.c is only left with the really generic stu=
ff. Then,
> > + * we can build on top of it depending on the needs.
> > + *
> > + * Copyright (C) 2023 Analog Devices Inc.
> > + */
> > +#define pr_fmt(fmt) "iio-backend: " fmt
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/list.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/kref.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/backend.h>
> > +
> > +struct iio_backend {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head entry;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iio_backend_ops=
 *ops;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct module *owner;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *priv;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mutex used to synchronize=
 backend callback access with concurrent
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * calls to @iio_backend_unr=
egister. The lock makes sure a device is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not unregistered while a =
callback is being run.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mutex lock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kref ref;
> > +};
> > +
>=20
> ...
>=20
> > +
> > +static void iio_backend_release(void *arg)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *back =3D=
 arg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0module_put(back->owner);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kref_put(&back->ref, iio_bac=
kend_free);
> > +}
> > +
> > +static int __devm_iio_backend_get(struct device *dev, struct iio_backe=
nd *back)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_link *link;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kref_get(&back->ref);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!try_module_get(back->ow=
ner)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_err("%s: Cannot get module reference\n", dev_name(d=
ev));
>=20
> Why do you need the reference?=C2=A0 Good to add a comment on that here.

Yeah, typical stuff when it's a module and we don't want for it to go away.=
 Even
though we handle that case with pointer stuff. I'll comment it.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_action_or_r=
eset(dev, iio_backend_release, back);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link =3D device_link_add(dev=
, back->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!link)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_warn("%s: Could not link to supplier(%s)\n", dev_na=
me(dev),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_na=
me(back->dev));
>=20
> Why is that not an error and we try to carry on?

I guess having the links are not really mandatory for the whole thing to wo=
rk (more
like a nice to have). That's also how this is handled in another subsystems=
 so I
figured it would be fine.

But since you are speaking about this... After you pointing me to Bartosz's=
 talk and
sawing it (as stuff like this is mentioned), I started to question this. Th=
e goal
with the above comment is that if you remove the backend, all the consumers=
 are
automatically removed (unbound). Just not sure if that's what we always wan=
t (and we
are already handling the situation where a backend goes away with -ENODEV) =
as some
frontends could still be useful without the backend (I guess that could be
plausible). I think for now we don't really have such usecases so the links=
 can make
sense (and we can figure something like optionally creating these links if =
we ever
need too) but having your inputs on this will definitely be valuable.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("%s: Found backend(=
%s) device\n", dev_name(dev),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_name(back->dev));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +
> > +/**
> > + * devm_iio_backend_get - Get a backend device
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device where to look=
 for the backend.
> > + * @name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Backend name.
> > + *
> > + * Get's the backend associated with @dev.
> > + *
> > + * RETURNS:
> > + * A backend pointer, negative error pointer otherwise.
> > + */
> > +struct iio_backend *devm_iio_backend_get(struct device *dev, const cha=
r *name)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *back;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int index =3D 0, ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (name) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0index =3D device_property_match_string(dev, "io-backen=
ds-names",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (index < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(index);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fwnode =3D fwnode_find_refer=
ence(dev_fwnode(dev), "io-backends", index);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(fwnode)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* not an error if optional */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_debug("%s: Cannot get Firmware reference\n", dev_na=
me(dev));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_CAST(fwnode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guard(mutex)(&iio_back_lock)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(back, &i=
io_back_list, entry) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!device_match_fwnode(back->dev, fwnode))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contin=
ue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fwnode_handle_put(fwnode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D __devm_iio_backend_get(dev, back);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(ret);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return back;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fwnode_handle_put(fwnode);
>=20
> FYI. I have a series doing auto cleanup of fwnode_handles in progress.
> Should get some time over the weekend to snd that out.=C2=A0 Aim is to av=
oid need
> to dance around manually freeing them (similar to the DT __free(device_no=
de)
> series I posted the other day).

Cool! This will surely be an user of that.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EPROBE_DEFER=
);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
> > +
> > +/**
> > + * devm_iio_backend_get_optional - Get optional backend device
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device where to look=
 for the backend.
> > + * @name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Backend name.
> > + *
> > + * Same as @devm_iio_backend_get() but return NULL if backend not foun=
d.
> > + *
> > + * RETURNS:
> > + * A backend pointer, negative error pointer otherwise or NULL if not =
found.
> > + */
> > +struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const=
 char *name)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *back;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0back =3D devm_iio_backend_ge=
t(dev, name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(back) && PTR_ERR(=
back) =3D=3D -ENOENT)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return back;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_optional, IIO_BACKEND);
>=20
> I'm not convinced the optional variant is worth while.=C2=A0 Could just c=
hoose
> a particular return value to mean that e.g. ERR_PTR(-ENOENT) and document
> it for the normal get.=C2=A0 Then have special handling in the drivers wh=
ere
> you need backwards compatibility with a previous approach.
>=20
> I'd rather pay the complexity price in a couple of drivers than have
> to explain backends aren't typically optional for years to come.

Alright. For now I'm not seeing any usecase where backends are optional. Fo=
r the case
we need the backward compatibility I'll do as you suggest. If we ever have =
a real
'optional' usecase we can easily add this one again.

>=20
>=20
> > +
> > +/**
> > + * devm_iio_backend_get_from_fwnode_lookup
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Device where to bind=
 the backend lifetime.
> > + * @fwnode:=C2=A0=C2=A0=C2=A0=C2=A0Firmware node of the backend device=
.
> > + *
> > + * It directly looks the backend device list for a device matching @fw=
node.
>=20
> I would word this:
> Search the backend list for a device matchign &fwnode.

ack

>=20
> > + * This API should not be used and it's only present for preventing th=
e first
> > + * user of this framework to break it's DT ABI.
>=20
> You could stick a __ in front of the name to hopefully scare people away =
:)
> + highlight something odd is going on to reviewers seeing this called in
> some future driver.
> Also I can we might convert other drivers that are doing similar things
> (dfsdm for example) and maybe this will be useful
> so __devm_iio_backend_get_from_fwnode_lookup() and
> "preventing breakage of old DT bindings".

Will do!

Thanks for the inputs!
- Nuno S=C3=A1


