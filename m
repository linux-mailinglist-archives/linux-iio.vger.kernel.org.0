Return-Path: <linux-iio+bounces-2281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF184C6FD
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3260D1C241E7
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD420B28;
	Wed,  7 Feb 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhbUG8R9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702320B09;
	Wed,  7 Feb 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297211; cv=none; b=BEs78TF9sjtsU+pHBB9CNgG6WN0BTFWKhehMYXKgF7up4zSWU57xQqJsCSAFDQgW2lGfZQBie7qnJY+NeVwAnhahageN1Na7GF0HdUF8s6o9mAnFG7J8gQh0PfroXEVqqnHSFqTCV8A1uporQXlxS2P0TRLN+FDSeYIO86vrTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297211; c=relaxed/simple;
	bh=ABVtrywqzlREKTEdLbO3z97CMZIq3B6lGa9XOD4Pjn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwCO0pvXi7VRN53Z+dYb2uF5r0rLfnxamlNCI9OpItpzCcTjXyV67IxGxlOf/8ImU+7MJPjNuT6Zy7Yw39M5hoNpyCPzb5v7ZKQcJw2lJ9X3Wp0Kb1yxAsm5qYUDk8OtC0MuDjo7mk44jT2J853zqoepsXJJbWnL0Sy9tQyBdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhbUG8R9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a370e63835cso45014266b.1;
        Wed, 07 Feb 2024 01:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707297208; x=1707902008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ABVtrywqzlREKTEdLbO3z97CMZIq3B6lGa9XOD4Pjn0=;
        b=PhbUG8R97yFL2lpmtI//Q+CCGgDd5dtI6h3TcmypUhKu51CYmicYeSyyVEK0WzdTsH
         ONu2jDlKFF/AP/JMyYPFRz7zEtLATAjBmwgjZnyL+4Rdw16gn0XPDBGDBRvo9w6xXTOd
         i+oZCaqER1rGAyqnS5qQqPspj/Ksviw2NE7uGM1nsfJzn79PbfdGPEqYUpdjVp3S0bce
         4PIaWicuk91sM5sBoEux40Hp8B0gUxsWEDdjtpnkZJuvCtqRALFcQuBkZZc83hFanp6X
         ZFZVgGdmT7oiMhgo3hkt08IgPukQrE1X035nirkpKz0dQneEuHb5uaHaEpp22inyLUPj
         DV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297208; x=1707902008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABVtrywqzlREKTEdLbO3z97CMZIq3B6lGa9XOD4Pjn0=;
        b=iyEBNpVUhszyUNsNcdBadMIk+V2HrE5UczlaWu1C9bHTrEfePbRjAveM1iloq3Br94
         z5mqxoxga/WJrB3TCJ+TFlLNgJWTt4Ouz6cBR+Zx8kK37fQgzoQ3I3eHyvBNq1x7uBVi
         gKRymuZm1+acUr7ljDUBenTI5Ev5MLVpvHx0NtN4W9Lzt/9IUjBL7zKTYdwuB+TmHtZJ
         MkjkRjWjw4YHs/DeyIMeygjc5XytkHT6tBDNCU0TnKGWr2K9y9eO5+cdkpYlUNjzcM/T
         WrQpbXzAYyd9PvqvQ5mVDph3ZtsrXjzZa46SH529UqgAqoj2llX9kuAtgNFcbyNFjxFu
         Y8fg==
X-Gm-Message-State: AOJu0YwafqszL+FqPvdq5eUFLvqNZikPkkXsbKsnfakibBS4ZwYRszCl
	PY65zbzOcAjF8/w4yJGLypT64yux7vOYgB5IeXhtwiFtESQV20ap
X-Google-Smtp-Source: AGHT+IFY9anbsMRTh2t20M/avQldRrhKwkVtResfFbCaos2hR/1W9m73dCYs56NB1qoZ3mm2JGCKFw==
X-Received: by 2002:a17:906:5fc2:b0:a37:ad9c:c146 with SMTP id k2-20020a1709065fc200b00a37ad9cc146mr3568370ejv.62.1707297207895;
        Wed, 07 Feb 2024 01:13:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3rn3jvG73jJjooMuvQK6QXWQD9qsdskEihG+vm6AqQaJrhd7dd3/8jWF32qctRGgdXVJ0/0Lg3X1e+jwj1mku3tXlbZsBGg3szayx6HMHU0vLw/qw2srFxKUJZGIl3pLhAxmnFI8bEd2yKLVz4SdoJgI2X1yKrPIXvEE0R4EF3gU5GnpQQdgCvwvkFr+dX/28a2O3w+YDr5sRT7K4a9OGg0wLR1pO7b6noOCnQuzjPty1DDFMeXPxPr8VeWPiK0WaA5gE5WX2oUd88b0AD3/DRNgJx/JUF3MZuF2Ly7bR4V8iWc0KdeIbjV70zfnWVTKam5PuDXyTrJ2AWlGnXkFCebfrACan0B9bROFx3iJs/36mGmfKhBFr6XKjJf1wIg==
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906264800b00a3860356f42sm541012ejc.19.2024.02.07.01.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:13:27 -0800 (PST)
Message-ID: <5c0985247622215c3eea548879afe68d0dce00ec.camel@gmail.com>
Subject: Re: [PATCH v9 5/7] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Wed, 07 Feb 2024 10:16:46 +0100
In-Reply-To: <CAHp75VdUjNeYsgJHcMC+z9m9j=z7Qzh0BFXR=Zi7jPs6rRVUKg@mail.gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	 <20240206-iio-backend-v9-5-df66d159c000@analog.com>
	 <CAHp75VdUjNeYsgJHcMC+z9m9j=z7Qzh0BFXR=Zi7jPs6rRVUKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 16:27 +0200, Andy Shevchenko wrote:
> On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
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
>=20
> Not sure what the meaning of @ in the above lines.
>=20

No special meaning...

> ...
>=20
> > +/*
> > + * Framework to handle complex IIO aggregate devices.
> > + *
> > + * The typical architecture is to have one device as the frontend devi=
ce
> > which
> > + * can be "linked" against one or multiple backend devices.
>=20
> Can we have an ASCII art with an example?

I do have one in the cover and spoke on the possibility of having it here b=
ut no
one really expressed any interest on it. Personally, for now, I'm also not
seeing it as *that* important.

>=20
> > =C2=A0All the IIO and
> > + * userspace interface is expected to be registers/managed by the fron=
tend
> > + * device which will callback into the backends when needed (to get/se=
t
> > some
> > + * configuration that it does not directly control).
> > + *
> > + * The framework interface is pretty simple:
> > + *=C2=A0=C2=A0 - Backends should register themselves with
> > @devm_iio_backend_register()
> > + *=C2=A0=C2=A0 - Frontend devices should get backends with @devm_iio_b=
ackend_get()
> > + *
> > + * Also to note that the primary target for this framework are convert=
ers
> > like
> > + * ADC/DACs so @iio_backend_ops will have some operations typical of
> > converter
> > + * devices. On top of that, this is "generic" for all IIO which means =
any
> > kind
> > + * of device can make use of the framework. That said, If the
> > @iio_backend_ops
> > + * struct begins to grow out of control, we can always refactor things=
 so
> > that
> > + * the industrialio-backend.c is only left with the really generic stu=
ff.
> > Then,
> > + * we can build on top of it depending on the needs.
> > + *
> > + * Copyright (C) 2023-2024 Analog Devices Inc.
> > + */
>=20
> ...
>=20
> > +/*
> > + * Helper macros to call backend ops. Makes sure the option is support=
ed
>=20
> Missing period.
>=20
> > + */
>=20
> ...
>=20
> > +/**
> > + * iio_backend_chan_enable - Enable a backend channel
> > + * @back:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Backend device
> > + * @chan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Channel number
> > + *
> > + * RETURNS:
>=20
> Not sure if this is the style used in other IIO core files...
>=20
> > + * 0 on success, negative error number on failure.
> > + */
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!try_module_get(back->owner))=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(dev, "Cannot get module reference\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENODEV;
>=20
> devm_*() are supposed to be used only at ->probe() stage, hence
> dev_err_probe() is fine (and eventually would be nice to have for the
> sake of making messaging uniform).
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D device_link_add(dev, bac=
k->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(dev, "Could not link to supplier(%s)\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(ba=
ck->dev));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
>=20
> Ditto.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D device_property_match_string(dev, "io-backend-names=
",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 name);
>=20
> One line?

Would pass the 80 limit column. I would not mind at all to have the one lin=
er
but I'm playing by Jonathan's rules. Stick with that limit unless it hurts
readability.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_=
PTR(ret);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 index =3D ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 index =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode =3D fwnode_find_reference(=
dev_fwnode(dev), "io-backends",
> > index);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(fwnode)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(dev, "Cannot get Firmware reference\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_CAST(fwnode);
>=20
> dev_err_probe() ?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ops) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(dev, "No backend ops given\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
>=20
> dev_err_probe() ?

Yeah, I can switch to that as on top of being devm APIs, these APIs are rea=
lly
intended to be called during probe().

- Nuno S=C3=A1

