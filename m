Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5A7D6251
	for <lists+linux-iio@lfdr.de>; Wed, 25 Oct 2023 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJYHVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Oct 2023 03:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjJYHVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Oct 2023 03:21:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99490
        for <linux-iio@vger.kernel.org>; Wed, 25 Oct 2023 00:21:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9be3b66f254so747689966b.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Oct 2023 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698218486; x=1698823286; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1znAr3sKUxoqRkdig/U6P25Qg54QY6Csc3PBcGlAN4=;
        b=Ur68CetA3uuygkQGkWCPRFockI+IQOvYU9v8Yu3hXlmhtuW/SLWM3gYtU/zMIoxHge
         PF4i88SXuPonKT5lLYxHd3QSUpZHzFouZnbzl7g/6C73fcU26rZ0BcXWphw9r0byQLub
         CZpeIcYT+yRdy+Zabhij85y62l9prRHZZm6+6IgVmyLHN7JsLtUrKgsO8cZvFeD8/bSt
         KdcN6dGr4qhjgzqyWRvDA4FN4TBcLy6q1VZ+glYU8rh1pg3uYWPmkTs0GiMO42VaaKvM
         pK1NDidBzwzOiYCQaobWo20z/aitHels6nuRpxM4rieT47pg1/Kr1xO/BbrO6znVqMVb
         Z50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218486; x=1698823286;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1znAr3sKUxoqRkdig/U6P25Qg54QY6Csc3PBcGlAN4=;
        b=QytAogusQxZ1vnlM5Gh96MmYxQn/vWQJo2ihsqdglUZI4ZIjk2ULZy5Mex1zOHZ2u/
         6fNm9SjXINgortFFvDtrwvhmQWQznBb3dShS9V5ZYgHbTv7ZwmQZXZvqUFqZcMiCr8tS
         2bDOmmTDRwvpeDb9ehEVXJ7Ecqnll6lG4sLfBD8Zr1ypXHz2KxPNwwpoFf/KC9ry4ySB
         MifbXevFHNu8jbtKt/cxvlHq8c8lzkWZCMs2ZsBZp6FrwqoiRW01W9ZqRJQeRv/+5090
         BTZJd7jnCuPUoZf66x4u8Sh3JMHwJD4JHMStWSwc56aAKsy7wqc3PCTEq79RhLxb+9G8
         piCw==
X-Gm-Message-State: AOJu0YzpYp7oSFmSI/1mlFzl4t0S3Hi45Ubb8a6vIigd6kzmZWKINWil
        inU9ExKSzSPRWAfex1cde5s=
X-Google-Smtp-Source: AGHT+IFCzBJodTctHcPRs5N7sar8haeBcMdvm75P0p24/E/NrkirSCJMqMOEaLCK14ByeOlaGKXXng==
X-Received: by 2002:a17:907:7f8b:b0:9bf:2673:7371 with SMTP id qk11-20020a1709077f8b00b009bf26737371mr13242220ejc.13.1698218485874;
        Wed, 25 Oct 2023 00:21:25 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b00997d76981e0sm9301750ejq.208.2023.10.25.00.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:21:25 -0700 (PDT)
Message-ID: <6db4383af5337985a3212327787194e93e536634.camel@gmail.com>
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
Date:   Wed, 25 Oct 2023 09:24:16 +0200
In-Reply-To: <20231024132312.0000614c@Huawei.com>
References: <20231022154710.402590-1-jic23@kernel.org>
         <20231022154710.402590-2-jic23@kernel.org>
         <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
         <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
         <20231023105323.00000370@Huawei.com>
         <0147cfed5e8402722186daa49256d20a8e2c83a1.camel@gmail.com>
         <20231023153431.000038b9@Huawei.com>
         <25cb785485ae585923b7b81276e10d8c048ba850.camel@gmail.com>
         <20231024132312.0000614c@Huawei.com>
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

On Tue, 2023-10-24 at 13:23 +0100, Jonathan Cameron wrote:
> On Mon, 23 Oct 2023 16:58:48 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2023-10-23 at 15:34 +0100, Jonathan Cameron wrote:
> > > On Mon, 23 Oct 2023 13:51:04 +0200
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > On Mon, 2023-10-23 at 10:53 +0100, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > On Mon, 23 Oct 2023 10:55:56 +0200
> > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > On Sun, 2023-10-22 at 16:10 -0500, David Lechner wrote:=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > On Sun, Oct 22, 2023 at 10:47=E2=80=AFAM Jonathan Cameron
> > > > > > > <jic23@kernel.org>
> > > > > > > wrote:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > >=20
> > > > > > > > Allows use of:
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_=
direct, claimed_dev)(indio_dev);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claim=
ed_dev))
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(=
claimed_dev);
> > > > > > > >=20
> > > > > > > > to automatically call iio_device_release_direct_mode() base=
d on
> > > > > > > > scope.
> > > > > > > > Typically seen in combination with local device specific lo=
cks
> > > > > > > > which
> > > > > > > > are already have automated cleanup options via guard(mutex)=
(&st-
> > > > > > > > =C2=A0=20
> > > > > > > > > lock)=C2=A0=20
> > > > > > > > and scoped_guard().=C2=A0 Using both together allows most e=
rror
> > > > > > > > handling
> > > > > > > > to
> > > > > > > > be automated.
> > > > > > > >=20
> > > > > > > > Note that whilst this pattern results in a struct iio_dev
> > > > > > > > *claimed_dev
> > > > > > > > that can be used, it is not necessary to do so as long as t=
hat
> > > > > > > > pointer
> > > > > > > > has been checked for errors as in the example.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.co=
m>
> > > > > > > > ---
> > > > > > > > =C2=A0drivers/iio/industrialio-core.c |=C2=A0 4 ++++
> > > > > > > > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 25 +++++++++++++++++++++++++
> > > > > > > > =C2=A02 files changed, 29 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/iio/industrialio-core.c
> > > > > > > > b/drivers/iio/industrialio-
> > > > > > > > core.c
> > > > > > > > index c77745b594bd..93bfad105eb5 100644
> > > > > > > > --- a/drivers/iio/industrialio-core.c
> > > > > > > > +++ b/drivers/iio/industrialio-core.c
> > > > > > > > @@ -2065,6 +2065,10 @@
> > > > > > > > EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > > > > > > > =C2=A0 */
> > > > > > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *i=
ndio_dev)
> > > > > > > > =C2=A0{
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Auto cleanup can r=
esult in this being called with an
> > > > > > > > ERR_PTR
> > > > > > > > */
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(indio_dev)=
)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > > > > +
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&to=
_iio_dev_opaque(indio_dev)->mlock);
> > > > > > > > =C2=A0}
> > > > > > > > =C2=A0EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > > > > > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/ii=
o.h
> > > > > > > > index d0ce3b71106a..11c42170fda1 100644
> > > > > > > > --- a/include/linux/iio/iio.h
> > > > > > > > +++ b/include/linux/iio/iio.h
> > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > >=20
> > > > > > > > =C2=A0#include <linux/device.h>
> > > > > > > > =C2=A0#include <linux/cdev.h>
> > > > > > > > +#include <linux/cleanup.h>
> > > > > > > > =C2=A0#include <linux/slab.h>
> > > > > > > > =C2=A0#include <linux/iio/types.h>
> > > > > > > > =C2=A0/* IIO TODO LIST */
> > > > > > > > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct
> > > > > > > > device
> > > > > > > > *dev,
> > > > > > > > struct iio_dev *indio_dev,
> > > > > > > > =C2=A0int iio_push_event(struct iio_dev *indio_dev, u64 ev_=
code, s64
> > > > > > > > timestamp);
> > > > > > > > =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indi=
o_dev);
> > > > > > > > =C2=A0void iio_device_release_direct_mode(struct iio_dev *i=
ndio_dev);
> > > > > > > > +/*
> > > > > > > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > > > > > > + *
> > > > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, claimed=
_dev)(indio_dev);
> > > > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > > > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > > > > > + *
> > > > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev);
> > > > > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > > > > > > > + */
> > > > > > > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 iio_device_release_direct_mode(_T),
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ({
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct iio_dev *dev;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int d =3D
> > > > > > > > iio_device_claim_direct_mode(_T);
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (d < 0)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D ERR_PTR(d);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 else
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D _T;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dev;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }),
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct iio_dev *_T);
> > > > > > > > +
> > > > > > > > =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indi=
o_dev);
> > > > > > > > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *i=
ndio_dev);
> > > > > > > >=20
> > > > > > > > --
> > > > > > > > 2.42.0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > What is the benefit of exposing `claimed_dev` rather than jus=
t the
> > > > > > > int
> > > > > > > return value? It seems like it just makes more noise in the e=
rror
> > > > > > > check.
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > I don't really have a very strong opinion on this but what I re=
ally
> > > > > > don't
> > > > > > like
> > > > > > much is the pattern:
> > > > > >=20
> > > > > > CLASS(type, ret), where the return value is an argument of the
> > > > > > macro...
> > > > > > It
> > > > > > would
> > > > > > be nice if we could just make it like:
> > > > > >=20
> > > > > > ret =3D guard(type)(...); //or any other variation of the guard=
()
> > > > > > macro
> > > > > > if (ret)=20
> > > > > > 	return ret;
> > > > > >=20
> > > > > > the above could also be an error pointer or even have one varia=
tion
> > > > > > of
> > > > > > each.
> > > > > > but
> > > > > > yeah, that likely means changing the cleanup.h file and that mi=
ght
> > > > > > be
> > > > > > out of
> > > > > > scope for Jonathan's patch series.=20
> > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > I fully agree it's ugly and a little unintuitive but I don't see =
a way
> > > > > an
> > > > > "lvalue"
> > > > > can work work cleanly (due to magic types under the hood) and I
> > > > > suspect we
> > > > > will
> > > > > have to get used to this pattern.
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Yeah, given the games being played with the constructor and the _lo=
ck
> > > > definition
> > > > so we return the variable we want to "release" I agree it would be =
hard
> > > > to
> > > > have
> > > > anything clean and likely even harder to read (more than it is alre=
ady
> > > > :)).
> > > >=20
> > > > However, I think users of the cleanup.h stuff could build on top of
> > > > it...
> > > > For
> > > > instance, in our case we could have something like:
> > > >=20
> > > > #define IIO_CLAIM_DIRECT(dev)=20
> > > > 	int __ret =3D 0;
> > > > 	CLASS(iio_claim_direct, claimed_dev)(dev);
> > > > 	if ((IS_ERR(claimed_dev))
> > > > 		__ret =3D PTR_ERR(claimed_dev);
> > > > 	__ret=C2=A0=20
> > >=20
> > > Maybe, but we'll have to deal with people perpetually trying to brack=
ets
> > > around
> > > the complex macro...=20
> > >=20
> > > =C2=A0=20
> >=20
> > Not sure what you mean here... you mean dealing with people coming up w=
ith
> > funny
> > new macros around CLASS(). In IIO, this is very specific and If I'm not
> > missing
> > anything the obvious, the above macro with give the same usage as=20
> > iio_device_claim_direct_mode() but without caring about release() - so =
not
> > sure
> > people could be that creative :)
> Checkpatch will warn something along the lines of complex macros should b=
e
> contained
> in brackets / or do while()
>=20
> So the class would go out of scope and be freed at the end of the macro :=
)
>=20

Dohh! Tbh, I was not  being "smart" by not putting the brackets in my examp=
le
macro. I was just making it simple. For the real thing I had the brackets i=
n my
mind and completely forgot about the scope nature of the cleanup attr.

Anyways, I very much like all of this stuff and I'm starting to use it in a=
ll
the places I can...

- Nuno S=C3=A1


