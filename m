Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CEA304832
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 20:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbhAZFs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbhAYSkc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 13:40:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32383C061573
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:39:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b17so1670729plz.6
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=HUlXmhLxfFL0uFjwqnaYUzkmMX5jHNTTDGv5mrAagns=;
        b=VDd+kTVIuDmtmmzrmR2idk0dEsQSoBV+Wvd0o1RUrWFyKmvG9iTjca49MKwbg+9W+y
         1W6UA6nUqEcRMyQpcJexChxujhcdlgsaHf+4u8wTZRRpZ0CIQHNBFrDyBkqsSDhQZMcp
         PJbjpiJjNYnNFdL6l16WgMzSaHNW6oxxjN5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=HUlXmhLxfFL0uFjwqnaYUzkmMX5jHNTTDGv5mrAagns=;
        b=gYF6VpfQsrdSpTFnkA4Yd7Uq93fFjaaD3+kdhu3h2Vfo/QkX+JjbJvTwUIzgjR1AyU
         wuiZzn0EqCqNB3Q6Cc15i+20+w8rj1/pe+HicF80GG6bDZu5AQU2KlHXazocgttzQnmP
         QBBaNFKUIbrEZtI22Ffs9dUBjUP0t8OqEh63YBDV6SI0o6/axB+QTp+GzqmjGSUEw/x4
         +Cldp8/DwrSPdYvv1sCndQhCSLX7p6szSYQWQeEx+Jd9ODClhlPA/bHDrgyt3Id1JvA5
         nGDDwreCjn8fQKSQx2B6QiNWbiWUrld4KCY3KW3jjMaDx51xkdRQIkTs0tul2jKtEW3y
         H6bw==
X-Gm-Message-State: AOAM531YFYubxuLJM8iN+qkriajU1TLQaZ0J3ujmbUqsffXLdV1fTCaF
        Ew92Coq283tONA2JaonGNmyPrA==
X-Google-Smtp-Source: ABdhPJy4wGvq0eaFs5eQTf+pY1PrJ+/m12dTr7V0NP3w2jPDL6TmSkYaRRVmDiKREMpNPDNXdYmnRA==
X-Received: by 2002:a17:90a:4504:: with SMTP id u4mr1610012pjg.218.1611599991735;
        Mon, 25 Jan 2021 10:39:51 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id ga4sm78946pjb.53.2021.01.25.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:39:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210124173820.4528b9c9@archlinux>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org> <20210124173820.4528b9c9@archlinux>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 25 Jan 2021 10:39:49 -0800
Message-ID: <161159998973.76967.1213998704222248070@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2021-01-24 09:38:20)
> On Fri, 22 Jan 2021 14:54:43 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > Add support for a ChromeOS EC proximity driver that exposes a "front"
> > proximity sensor via the IIO subsystem. The EC decides when front
> > proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> > notify the kernel of proximity. Similarly, when proximity detects
> > something far away it sets the switch bit to 0. For now this driver
> > exposes a single sensor, but it could be expanded in the future via more
> > MKBP bits if desired.
> >=20
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> Hi Stephen,
>=20
> Looks more or less fine to me.  My main concern is potential confusion
> in naming with the cros_ec_prox_light driver that we already have.
>=20
> A few other minor bits and bobs inline.
>=20

Cool thanks.

> > diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Mak=
efile
> > index 9c1aca1a8b79..b1330dd8e212 100644
> > --- a/drivers/iio/proximity/Makefile
> > +++ b/drivers/iio/proximity/Makefile
> > @@ -5,6 +5,7 @@
> > =20
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_AS3935)         +=3D as3935.o
> > +obj-$(CONFIG_CROS_EC_PROXIMITY)      +=3D cros_ec_proximity.o
> >  obj-$(CONFIG_ISL29501)               +=3D isl29501.o
> >  obj-$(CONFIG_LIDAR_LITE_V2)  +=3D pulsedlight-lidar-lite-v2.o
> >  obj-$(CONFIG_MB1232)         +=3D mb1232.o
> > diff --git a/drivers/iio/proximity/cros_ec_proximity.c b/drivers/iio/pr=
oximity/cros_ec_proximity.c
> > new file mode 100644
> > index 000000000000..a3aef911e3cc
> > --- /dev/null
> > +++ b/drivers/iio/proximity/cros_ec_proximity.c
> > @@ -0,0 +1,252 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for cros-ec proximity sensor exposed through MKBP switch
> > + *
> > + * Copyright 2021 Google LLC.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/kernel.h>
>=20
> Slight preference for alphabetical order though keeping specific
> sections separate as done here is fine.

Will fix.

>=20
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +struct cros_ec_proximity_data {
> > +     struct cros_ec_device *ec;
> > +     struct iio_dev *indio_dev;
> > +     struct mutex lock;
> > +     struct notifier_block notifier;
> > +     bool enabled;
> > +};
> > +
> > +static const struct iio_event_spec cros_ec_prox_events[] =3D {
> > +     {
> > +             .type =3D IIO_EV_TYPE_THRESH,
> > +             .dir =3D IIO_EV_DIR_EITHER,
> > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > +     },
> > +};
> > +
> > +static const struct iio_chan_spec cros_ec_prox_chan_spec[] =3D {
> > +     {
> > +             .type =3D IIO_PROXIMITY,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > +             .event_spec =3D cros_ec_prox_events,
> > +             .num_event_specs =3D ARRAY_SIZE(cros_ec_prox_events),
> > +     },
> > +};
> > +
> > +static int cros_ec_proximity_parse_state(const void *data)
> > +{
> > +     u32 switches =3D get_unaligned_le32(data);
> > +
> > +     return !!(switches & BIT(EC_MKBP_FRONT_PROXIMITY));
> > +}
> > +
> > +static int cros_ec_proximity_query(struct cros_ec_device *ec_dev, int =
*state)
> > +{
> > +     struct ec_params_mkbp_info *params;
> > +     struct cros_ec_command *msg;
> > +     int ret;
> > +
> > +     msg =3D kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
> > +                   GFP_KERNEL);
>=20
> Given this is known at build time, perhaps better to add it to the=20
> iio_priv() accessed structure and avoid having to handle allocations
> separately.

Ok.

>=20
> > +     if (!msg)
> > +             return -ENOMEM;
[...]
> > +static int cros_ec_proximity_read_raw(struct iio_dev *indio_dev,
> > +                        const struct iio_chan_spec *chan, int *val,
> > +                        int *val2, long mask)
> > +{
> > +     struct cros_ec_proximity_data *data =3D iio_priv(indio_dev);
> > +     struct cros_ec_device *ec =3D data->ec;
> > +     int ret;
> > +
> > +     if (chan->type !=3D IIO_PROXIMITY)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D iio_device_claim_direct_mode(indio_dev);
>=20
> Normally we only introduce these protections when adding the ability
> to change the state from direct to buffered (which these prevent).
> This driver doesn't yet support any other modes so I don't think
> there is any benefit in having these.
>=20
> If the aim is more local protection then should use a local lock
> as the semantics fo these functions might change in future.

Alright I'll drop it.

>=20
>=20
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D cros_ec_proximity_query(ec, val);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int cros_ec_proximity_read_event_config(struct iio_dev *indio_d=
ev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir)
> > +{
> > +     struct cros_ec_proximity_data *data =3D iio_priv(indio_dev);
> > +
> > +     return data->enabled;
> > +}
> > +
> > +static int cros_ec_proximity_write_event_config(struct iio_dev *indio_=
dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir, int st=
ate)
> > +{
> > +     struct cros_ec_proximity_data *data =3D iio_priv(indio_dev);
> > +
> > +     mutex_lock(&data->lock);
> > +     data->enabled =3D state;
> > +     mutex_unlock(&data->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct iio_info cros_ec_proximity_info =3D {
> > +     .read_raw =3D cros_ec_proximity_read_raw,
> > +     .read_event_config =3D cros_ec_proximity_read_event_config,
> > +     .write_event_config =3D cros_ec_proximity_write_event_config,
> > +};
> > +
> > +static int cros_ec_proximity_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_device *ec =3D dev_get_drvdata(dev->parent);
> > +     struct iio_dev *indio_dev;
> > +     struct cros_ec_proximity_data *data;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     data->ec =3D ec;
> > +     data->indio_dev =3D indio_dev;
> > +     mutex_init(&data->lock);
> > +     platform_set_drvdata(pdev, data);
> > +
> > +     indio_dev->name =3D "cros_ec_proximity";
> > +     indio_dev->dev.parent =3D dev;
> > +     indio_dev->info =3D &cros_ec_proximity_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D cros_ec_prox_chan_spec;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(cros_ec_prox_chan_spec);
> > +
> > +     ret =3D devm_iio_device_register(dev, indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->notifier.notifier_call =3D cros_ec_proximity_notify;
> > +     ret =3D blocking_notifier_chain_register(&ec->event_notifier,
> > +                                            &data->notifier);
> > +     if (ret)
> > +             dev_err(dev, "cannot register notifier: %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_proximity_remove(struct platform_device *pdev)
> > +{
> > +     struct cros_ec_proximity_data *data =3D platform_get_drvdata(pdev=
);
> > +     struct cros_ec_device *ec =3D data->ec;
> > +
> > +     blocking_notifier_chain_unregister(&ec->event_notifier,
> > +                                        &data->notifier);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
>=20
> As a general rule, we are trying to clear out protections on CONFIG_OF etc
> and use of of_match_ptr() on the basis they don't really gain us anything
> and prevent use of some other firmware types.  Here I guess you know what
> your firmware looks like, but I'm still keen to drop it in the interests
> of there being fewer places to copy it from.
>=20
> It may be a good idea to give this a more specific name as well given
> we already have cros-ec-prox as a platform device id from
> the cros_ec_light_prox driver.

Alright. I renamed it to cros_ec_mkbp_proximity throughout this driver.
I'm concerned about dropping CONFIG_OF because of_match_ptr() and
CONFIG_OF=3Dn makes it unused but I suppose that will be OK as long as
compilation passes.

>=20
>=20
> > +static const struct of_device_id cros_ec_proximity_of_match[] =3D {
> > +     { .compatible =3D "google,cros-ec-proximity" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > +#endif
> > +
> > +static struct platform_driver cros_ec_proximity_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "cros-ec-proximity",
> > +             .of_match_table =3D of_match_ptr(cros_ec_proximity_of_mat=
ch),
> > +     },
> > +     .probe =3D cros_ec_proximity_probe,
> > +     .remove =3D cros_ec_proximity_remove,
> > +};
> > +module_platform_driver(cros_ec_proximity_driver);
> > +
