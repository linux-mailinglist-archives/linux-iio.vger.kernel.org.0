Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDC7D356F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjJWLsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Oct 2023 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjJWLsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 07:48:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF81E4
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 04:48:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ba081173a3so507073666b.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698061694; x=1698666494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYUwLjsk6Wh255qZf1jT5v/1wtsoRPVf0wGYXAopwWY=;
        b=R8iHHZL2sbVyKTlpmvjH77z20JhDqi/tbyCUB92cg59VlNVvhniCg/vOOW/HyyPGOe
         4UbWcjDn+zguHLISb2N8b+0ObPtn9jduT0hSIpq3FsGqK8cENEf51uI8Rl9zsjWCab8c
         Rfd13lU/pJpg80wGVsWm6iCPYmbk8W3/mPpA/Omh7hQDdp9cSrigxNEkVvP60qYpDwmD
         1w/zEPRcBfH98dzA5eXM2LdxaqmBSgkq8UQw4WnfzmGecXNkgWSvLsAh3PCPyvqcbME8
         sWfh0Vc4LYibTtciodfaI7uqDW0wXFMfnRDAUypcRqEpUEIh4SRFRBilvoGvupvRjz5J
         lrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061694; x=1698666494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYUwLjsk6Wh255qZf1jT5v/1wtsoRPVf0wGYXAopwWY=;
        b=ix78CS9fXYV0jns0A/McNpX0rynyMuS/84IAmqNt4YZYYueB5Wn7xiUSdaJUNLG85F
         ThLZupUExcZNWP97mjZN1Q2Ol8qIx1dwrDHm+3zJRaY1l9ynUxlS7yiPt3JgeDIumXw2
         acaa3QaIC3sJMrHBlmLBE6PGrkcWEzPr73Ns0WlKIyu2CEJ2DNehKOS3AUuULXxBekYH
         OeCs41+lrVe2Q8QNZ/IpvwKYTFp3xtx2eQct6HK/fm+/ad7cNWcQ5aXx6Ky6daj1GSmd
         SypTbLBu4fU8oqbIXUGe0u3/m3vgW3nU73zBNOX0AIDYsjzyIVuTKxmu6X+XOh1R1kug
         MJPQ==
X-Gm-Message-State: AOJu0YwFh6hS6oVLe8g32D4D9fPWd6Zh2WEXgviypk/DYZanwp9+fydY
        CzVmaa049XkWwRBC11Ui+08=
X-Google-Smtp-Source: AGHT+IGUcsMK/IKOj+9gZOVnnAIbYf6dFNpqwwDosG0JqoaDCiwoWZELGj0CLG0A32UaHofEHtaEwQ==
X-Received: by 2002:a17:907:988:b0:9c5:2806:72e2 with SMTP id bf8-20020a170907098800b009c5280672e2mr6636212ejc.34.1698061693464;
        Mon, 23 Oct 2023 04:48:13 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906468500b00992b2c55c67sm6511485ejr.156.2023.10.23.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:48:13 -0700 (PDT)
Message-ID: <0147cfed5e8402722186daa49256d20a8e2c83a1.camel@gmail.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org
Date:   Mon, 23 Oct 2023 13:51:04 +0200
In-Reply-To: <20231023105323.00000370@Huawei.com>
References: <20231022154710.402590-1-jic23@kernel.org>
         <20231022154710.402590-2-jic23@kernel.org>
         <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
         <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
         <20231023105323.00000370@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2023-10-23 at 10:53 +0100, Jonathan Cameron wrote:
> On Mon, 23 Oct 2023 10:55:56 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2023-10-22 at 16:10 -0500, David Lechner wrote:
> > > On Sun, Oct 22, 2023 at 10:47=E2=80=AFAM Jonathan Cameron <jic23@kern=
el.org>
> > > wrote:=C2=A0=20
> > > >=20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >=20
> > > > Allows use of:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, =
claimed_dev)(indio_dev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_=
dev);
> > > >=20
> > > > to automatically call iio_device_release_direct_mode() based on sco=
pe.
> > > > Typically seen in combination with local device specific locks whic=
h
> > > > are already have automated cleanup options via guard(mutex)(&st->lo=
ck)
> > > > and scoped_guard().=C2=A0 Using both together allows most error han=
dling to
> > > > be automated.
> > > >=20
> > > > Note that whilst this pattern results in a struct iio_dev *claimed_=
dev
> > > > that can be used, it is not necessary to do so as long as that poin=
ter
> > > > has been checked for errors as in the example.
> > > >=20
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > > =C2=A0drivers/iio/industrialio-core.c |=C2=A0 4 ++++
> > > > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 25 +++++++++++++++++++++++++
> > > > =C2=A02 files changed, 29 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industri=
alio-
> > > > core.c
> > > > index c77745b594bd..93bfad105eb5 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mo=
de);
> > > > =C2=A0 */
> > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev=
)
> > > > =C2=A0{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Auto cleanup can result in=
 this being called with an ERR_PTR
> > > > */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(indio_dev))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&to_iio_dev=
_opaque(indio_dev)->mlock);
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > index d0ce3b71106a..11c42170fda1 100644
> > > > --- a/include/linux/iio/iio.h
> > > > +++ b/include/linux/iio/iio.h
> > > > @@ -9,6 +9,7 @@
> > > >=20
> > > > =C2=A0#include <linux/device.h>
> > > > =C2=A0#include <linux/cdev.h>
> > > > +#include <linux/cleanup.h>
> > > > =C2=A0#include <linux/slab.h>
> > > > =C2=A0#include <linux/iio/types.h>
> > > > =C2=A0/* IIO TODO LIST */
> > > > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *=
dev,
> > > > struct iio_dev *indio_dev,
> > > > =C2=A0int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s6=
4
> > > > timestamp);
> > > > =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev=
);
> > > > +/*
> > > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > > + *
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, claimed_dev)(in=
dio_dev);
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > + *
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev);
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > > > + */
> > > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 iio_device_release_direct_mode(_T),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ({
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct i=
io_dev *dev;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int d =
=3D iio_device_claim_direct_mode(_T);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (d < =
0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D ERR_PTR(d);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D _T;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct iio_dev *_T);
> > > > +
> > > > =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > > > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev=
);
> > > >=20
> > > > --
> > > > 2.42.0
> > > > =C2=A0=20
> > >=20
> > > What is the benefit of exposing `claimed_dev` rather than just the in=
t
> > > return value? It seems like it just makes more noise in the error
> > > check.
> > > =C2=A0=20
> >=20
> > I don't really have a very strong opinion on this but what I really don=
't
> > like
> > much is the pattern:
> >=20
> > CLASS(type, ret), where the return value is an argument of the macro...=
 It
> > would
> > be nice if we could just make it like:
> >=20
> > ret =3D guard(type)(...); //or any other variation of the guard() macro
> > if (ret)=20
> > 	return ret;
> >=20
> > the above could also be an error pointer or even have one variation of =
each.
> > but
> > yeah, that likely means changing the cleanup.h file and that might be o=
ut of
> > scope for Jonathan's patch series.=20
> >=20
>=20
> I fully agree it's ugly and a little unintuitive but I don't see a way an
> "lvalue"
> can work work cleanly (due to magic types under the hood) and I suspect w=
e
> will
> have to get used to this pattern.
>=20

Yeah, given the games being played with the constructor and the _lock defin=
ition
so we return the variable we want to "release" I agree it would be hard to =
have
anything clean and likely even harder to read (more than it is already :)).

However, I think users of the cleanup.h stuff could build on top of it... F=
or
instance, in our case we could have something like:

#define IIO_CLAIM_DIRECT(dev)=20
	int __ret =3D 0;
	CLASS(iio_claim_direct, claimed_dev)(dev);
	if ((IS_ERR(claimed_dev))
		__ret =3D PTR_ERR(claimed_dev);
	__ret

Then we could use it in the same way as before... Or at the very least I wo=
uld
simply make it a bit more readable for IIO (rather than the plain CLASS() c=
all):

#define IIO_CLAIM_DIRECT(claimed_dev, dev)
	CLASS(iio_claim_direct, claimed_dev)(dev)

Just some thoughts...

- Nuno S=C3=A1

