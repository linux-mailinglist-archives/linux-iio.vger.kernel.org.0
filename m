Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC877D2D3F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 10:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjJWIxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Oct 2023 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjJWIxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 04:53:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5042197
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 01:53:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso644331a12.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051186; x=1698655986; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S+YZkjUY9ZOzdsGQSi7C4wf4Orjyz/zPcIbJjr38RRM=;
        b=LExx1chYuiYin0HirFpBwuS49L8wHd9LXO7+vVWQslmcNLJ3E85nZfNubH59SUNcfW
         12vOZDkbdKWUabeRcdoqN9AJQdyfeo0L3EE4QsP7Q4RY2ibN/Iohk693aidZ2sXYieew
         tXerLkSbaXC+kPaDhcF3l5tDswjo2RGwtw1FjdMG9CDTQXu7C+x6BZL34Yib45zyWDpg
         JTAcNjtkRHpVZJKNJP0kp4Zxag3JMA0UCfNigOR1XCHybH1gxEn6fglAT2IBNYt43YIr
         YSzmflmpa6cuyG2A1o5O7FPD7XvP/gomajyySb9fSblExhmN6xAEQ1FQWhPPIAetGZmw
         3HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051186; x=1698655986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+YZkjUY9ZOzdsGQSi7C4wf4Orjyz/zPcIbJjr38RRM=;
        b=LOWGUIPNx8Dg7p5I3OZJq2hzqlzmVyqZjdt2EDzkB0wSREnuxS7HRbqPaVYjj0QSIl
         wKPZF8QLXezBAMBfhPwuBpIonzYyf+iXgoJ46FVWVndddZ/gSsYoBsb9rPt0kcZmtHXf
         tA5DdE70+Ba7LQ9JNkBEZv0eZXqg8YQrUuk2FT/txDEBBGBcJR0Y+tmBMrfqo+NdhuJX
         1N1wPb96I7T5uWRzQ0Qaq0Tp3tnlJNHdNZd8mqFJbWPljN6RwESQSCtUVq/f/3vSYHv/
         FMC/vxuwnMOt8xaE9qqW1Y1O6V8mUZqN9PyHCf1nH45SFP8as5LPcU1sihfQrSSmNGII
         Tekw==
X-Gm-Message-State: AOJu0YxMMU9jVd5UoaJ1hV4yjqXTL1GFtJjNlqesR+eTRlw8k2OPeN5l
        xNJqAVM5ndEKdUT0nN0XE1M=
X-Google-Smtp-Source: AGHT+IHExPxqOeuyTNoZ7LbZHymyAuCKNH1TkwZcyBcGuFbKtdYPdxGyzoyMQ2bHFqOciFfMiOm4qg==
X-Received: by 2002:a50:a699:0:b0:523:100b:462b with SMTP id e25-20020a50a699000000b00523100b462bmr7134753edc.5.1698051185429;
        Mon, 23 Oct 2023 01:53:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id i29-20020a0564020f1d00b0053fa3ff3aebsm5961329eda.61.2023.10.23.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:53:04 -0700 (PDT)
Message-ID: <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Mon, 23 Oct 2023 10:55:56 +0200
In-Reply-To: <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
References: <20231022154710.402590-1-jic23@kernel.org>
         <20231022154710.402590-2-jic23@kernel.org>
         <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
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

On Sun, 2023-10-22 at 16:10 -0500, David Lechner wrote:
> On Sun, Oct 22, 2023 at 10:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Allows use of:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, clai=
med_dev)(indio_dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev)=
;
> >=20
> > to automatically call iio_device_release_direct_mode() based on scope.
> > Typically seen in combination with local device specific locks which
> > are already have automated cleanup options via guard(mutex)(&st->lock)
> > and scoped_guard().=C2=A0 Using both together allows most error handlin=
g to
> > be automated.
> >=20
> > Note that whilst this pattern results in a struct iio_dev *claimed_dev
> > that can be used, it is not necessary to do so as long as that pointer
> > has been checked for errors as in the example.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > =C2=A0drivers/iio/industrialio-core.c |=C2=A0 4 ++++
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 25 +++++++++++++++++++++++++
> > =C2=A02 files changed, 29 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-
> > core.c
> > index c77745b594bd..93bfad105eb5 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > =C2=A0 */
> > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Auto cleanup can result in thi=
s being called with an ERR_PTR */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(indio_dev))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&to_iio_dev_opa=
que(indio_dev)->mlock);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d0ce3b71106a..11c42170fda1 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -9,6 +9,7 @@
> >=20
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/cdev.h>
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0#include <linux/iio/types.h>
> > =C2=A0/* IIO TODO LIST */
> > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *dev,
> > struct iio_dev *indio_dev,
> > =C2=A0int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 ti=
mestamp);
> > =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > +/*
> > + * Auto cleanup version of iio_device_claim_direct_mode,
> > + *
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, claimed_dev)(indio_=
dev);
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return PTR_ERR(claimed_dev);
> > + *
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev);
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > + */
> > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio=
_device_release_direct_mode(_T),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ({
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_=
dev *dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int d =3D i=
io_device_claim_direct_mode(_T);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (d < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D ERR_PTR(d);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D _T;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct iio_dev *_T);
> > +
> > =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> >=20
> > --
> > 2.42.0
> >=20
>=20
> What is the benefit of exposing `claimed_dev` rather than just the int
> return value? It seems like it just makes more noise in the error
> check.
>=20

I don't really have a very strong opinion on this but what I really don't l=
ike
much is the pattern:

CLASS(type, ret), where the return value is an argument of the macro... It =
would
be nice if we could just make it like:

ret =3D guard(type)(...); //or any other variation of the guard() macro
if (ret)=20
	return ret;

the above could also be an error pointer or even have one variation of each=
. but
yeah, that likely means changing the cleanup.h file and that might be out o=
f
scope for Jonathan's patch series.=20

- Nuno S=C3=A1

