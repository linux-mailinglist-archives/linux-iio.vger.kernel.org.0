Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A77D3A1A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWO4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Oct 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWO4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 10:56:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BBDD
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 07:55:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9adca291f99so497210966b.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698072958; x=1698677758; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1so8fI5uNuZhnpQYWidZJQd13zUPsl/AoibJOnBEOOk=;
        b=QZEXHEJdsMIqYJP2xNOXzMDq2yEm5nueuGkX+Gq8kYg30sODKYzVV0+POpBGg95puc
         pTKhHHgQAMLFMSEmfNsU9wqMtQXPWMguIZ62QdJSSm0YRWwtgZSl6zqWUY4kL7mHdgng
         HMRs/tDsz1XT2qWqGMj79iuABKJDe7+CwIBnqiWHbfkvAdtq67YkZDr4h/4M2ingLSjk
         eejASjaWVy/OLOCGk/at8tqHoz7BjpG4jkwXI+hTAts1MtAbSZLMZR50i2kwiZPfXz7T
         W6P8QN4pNJYC0Dc9kPvmcXm7kKfIztjgtbmz+QAyFquHX/yQdQ8lSuCSF/hkE3RbjnH6
         Oljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072958; x=1698677758;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1so8fI5uNuZhnpQYWidZJQd13zUPsl/AoibJOnBEOOk=;
        b=Ua8IkGtkh2JSeyNdtJguocnVqdkHlccyeAvWwZtHcx7SCbnZzo8SeQ3Bv/EHNXLlFS
         MsfzZ8n0urolSuJs8gKpYeseLkBHxTwUTSqmXmtJXJIO7001h7fV/y08AiJQx/VMPNSx
         gEPZHynS4BKc9DkY1xdVDc4TH936RcwlwZV53/xtFtqm2FH30JP62SaLf+L+wnh29uPb
         rC7uIziWsz/ofYESL9gIh7Ss1+9NDoiC+I3kc13sDyUQoGD/5Net/mkubDbQxC2mPw1c
         wnUNWt9rxfPnhL/iGCl32XKt/bOS+5APvz0ZjY3/yDfAiJbXCIs4L4P36+VS9RIqRcy8
         FCZQ==
X-Gm-Message-State: AOJu0Yyu4BVXOWs9Stc1MoR6TTmO+J1g6qUBV9DdpmyaLXJNz+/b6ADY
        e4GsO+L4mJ5olYY413ZPhSo=
X-Google-Smtp-Source: AGHT+IHTbxSTQ0djkqRMJbEJX8hvmAT2H0RqajATuz7xAtURR5vfyGSfEM/m2cSMguC2XMO/1zN4Xg==
X-Received: by 2002:a17:907:720f:b0:9bd:804a:5601 with SMTP id dr15-20020a170907720f00b009bd804a5601mr6801927ejc.54.1698072958065;
        Mon, 23 Oct 2023 07:55:58 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906225900b0098f99048053sm6926168ejr.148.2023.10.23.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:55:57 -0700 (PDT)
Message-ID: <25cb785485ae585923b7b81276e10d8c048ba850.camel@gmail.com>
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
Date:   Mon, 23 Oct 2023 16:58:48 +0200
In-Reply-To: <20231023153431.000038b9@Huawei.com>
References: <20231022154710.402590-1-jic23@kernel.org>
         <20231022154710.402590-2-jic23@kernel.org>
         <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
         <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
         <20231023105323.00000370@Huawei.com>
         <0147cfed5e8402722186daa49256d20a8e2c83a1.camel@gmail.com>
         <20231023153431.000038b9@Huawei.com>
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

On Mon, 2023-10-23 at 15:34 +0100, Jonathan Cameron wrote:
> On Mon, 23 Oct 2023 13:51:04 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2023-10-23 at 10:53 +0100, Jonathan Cameron wrote:
> > > On Mon, 23 Oct 2023 10:55:56 +0200
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > On Sun, 2023-10-22 at 16:10 -0500, David Lechner wrote:=C2=A0=20
> > > > > On Sun, Oct 22, 2023 at 10:47=E2=80=AFAM Jonathan Cameron <jic23@=
kernel.org>
> > > > > wrote:=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > >=20
> > > > > > Allows use of:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_dire=
ct, claimed_dev)(indio_dev);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_d=
ev))
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(clai=
med_dev);
> > > > > >=20
> > > > > > to automatically call iio_device_release_direct_mode() based on
> > > > > > scope.
> > > > > > Typically seen in combination with local device specific locks =
which
> > > > > > are already have automated cleanup options via guard(mutex)(&st=
-
> > > > > > >lock)
> > > > > > and scoped_guard().=C2=A0 Using both together allows most error=
 handling
> > > > > > to
> > > > > > be automated.
> > > > > >=20
> > > > > > Note that whilst this pattern results in a struct iio_dev
> > > > > > *claimed_dev
> > > > > > that can be used, it is not necessary to do so as long as that
> > > > > > pointer
> > > > > > has been checked for errors as in the example.
> > > > > >=20
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > > =C2=A0drivers/iio/industrialio-core.c |=C2=A0 4 ++++
> > > > > > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 25 +++++++++++++++++++++++++
> > > > > > =C2=A02 files changed, 29 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/industrialio-core.c
> > > > > > b/drivers/iio/industrialio-
> > > > > > core.c
> > > > > > index c77745b594bd..93bfad105eb5 100644
> > > > > > --- a/drivers/iio/industrialio-core.c
> > > > > > +++ b/drivers/iio/industrialio-core.c
> > > > > > @@ -2065,6 +2065,10 @@
> > > > > > EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > > > > > =C2=A0 */
> > > > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio=
_dev)
> > > > > > =C2=A0{
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Auto cleanup can resul=
t in this being called with an
> > > > > > ERR_PTR
> > > > > > */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(indio_dev))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&to_iio=
_dev_opaque(indio_dev)->mlock);
> > > > > > =C2=A0}
> > > > > > =C2=A0EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > > > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > > > index d0ce3b71106a..11c42170fda1 100644
> > > > > > --- a/include/linux/iio/iio.h
> > > > > > +++ b/include/linux/iio/iio.h
> > > > > > @@ -9,6 +9,7 @@
> > > > > >=20
> > > > > > =C2=A0#include <linux/device.h>
> > > > > > =C2=A0#include <linux/cdev.h>
> > > > > > +#include <linux/cleanup.h>
> > > > > > =C2=A0#include <linux/slab.h>
> > > > > > =C2=A0#include <linux/iio/types.h>
> > > > > > =C2=A0/* IIO TODO LIST */
> > > > > > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct devi=
ce
> > > > > > *dev,
> > > > > > struct iio_dev *indio_dev,
> > > > > > =C2=A0int iio_push_event(struct iio_dev *indio_dev, u64 ev_code=
, s64
> > > > > > timestamp);
> > > > > > =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indio_de=
v);
> > > > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio=
_dev);
> > > > > > +/*
> > > > > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > > > > + *
> > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, claimed_dev=
)(indio_dev);
> > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > > > + *
> > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev);
> > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > > > > > + */
> > > > > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 iio_device_release_direct_mode(_T),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ({
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct iio_dev *dev;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t d =3D iio_device_claim_direct_mode(_T);
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (d < 0)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D ERR_PTR(d);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D _T;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct iio_dev *_T);
> > > > > > +
> > > > > > =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_de=
v);
> > > > > > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio=
_dev);
> > > > > >=20
> > > > > > --
> > > > > > 2.42.0
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > What is the benefit of exposing `claimed_dev` rather than just th=
e int
> > > > > return value? It seems like it just makes more noise in the error
> > > > > check.
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > I don't really have a very strong opinion on this but what I really
> > > > don't
> > > > like
> > > > much is the pattern:
> > > >=20
> > > > CLASS(type, ret), where the return value is an argument of the macr=
o...
> > > > It
> > > > would
> > > > be nice if we could just make it like:
> > > >=20
> > > > ret =3D guard(type)(...); //or any other variation of the guard() m=
acro
> > > > if (ret)=20
> > > > 	return ret;
> > > >=20
> > > > the above could also be an error pointer or even have one variation=
 of
> > > > each.
> > > > but
> > > > yeah, that likely means changing the cleanup.h file and that might =
be
> > > > out of
> > > > scope for Jonathan's patch series.=20
> > > > =C2=A0=20
> > >=20
> > > I fully agree it's ugly and a little unintuitive but I don't see a wa=
y an
> > > "lvalue"
> > > can work work cleanly (due to magic types under the hood) and I suspe=
ct we
> > > will
> > > have to get used to this pattern.
> > > =C2=A0=20
> >=20
> > Yeah, given the games being played with the constructor and the _lock
> > definition
> > so we return the variable we want to "release" I agree it would be hard=
 to
> > have
> > anything clean and likely even harder to read (more than it is already =
:)).
> >=20
> > However, I think users of the cleanup.h stuff could build on top of it.=
..
> > For
> > instance, in our case we could have something like:
> >=20
> > #define IIO_CLAIM_DIRECT(dev)=20
> > 	int __ret =3D 0;
> > 	CLASS(iio_claim_direct, claimed_dev)(dev);
> > 	if ((IS_ERR(claimed_dev))
> > 		__ret =3D PTR_ERR(claimed_dev);
> > 	__ret
>=20
> Maybe, but we'll have to deal with people perpetually trying to brackets
> around
> the complex macro...=20
>=20
>=20

Not sure what you mean here... you mean dealing with people coming up with =
funny
new macros around CLASS(). In IIO, this is very specific and If I'm not mis=
sing
anything the obvious, the above macro with give the same usage as=20
iio_device_claim_direct_mode() but without caring about release() - so not =
sure
people could be that creative :).

Anyways, as I started to say in my first reply, I don't feel strong about t=
his
at all, so feel free to add:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


