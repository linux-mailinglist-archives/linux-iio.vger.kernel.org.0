Return-Path: <linux-iio+bounces-1526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E508297B0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7880728D721
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D63FE36;
	Wed, 10 Jan 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDMST5d7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DD41205;
	Wed, 10 Jan 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29058bb2ceso427866266b.0;
        Wed, 10 Jan 2024 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704882853; x=1705487653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbrpO+Uk7Iw8WCp3ZB9C1pV0XeCBbgefW9dI7e67LUo=;
        b=QDMST5d7FmsQ46okG/wIdIGuMMRlLIyR0so0C6U5R4qvWnFEBc6kMTg8kmQyTpYtCP
         Fg16WqjCe2cKz710G+1Hs1iEjzST9nio1d1A5yJO1uGEHmhiZgiuvu2kgX0JbnB5NGPC
         +E2Yq2i72U5ogM6NveT4A7WjaKADXtnMWfbhx0oLe8AEUxnmjimfyU3K7umTqHIGh6YR
         3TmWnuJYqn7DhtDCzGlzmtsHViCqly1xeYA0sUXzyDzy8C4NZf0MiW4PanshaJJc4i+Q
         gqd+IE4LG4NeGvyizS6SPTZavMqVGfyNDQRChqhySHSLr/C380cwtq8dl//jR5hwbc2e
         xchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882853; x=1705487653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbrpO+Uk7Iw8WCp3ZB9C1pV0XeCBbgefW9dI7e67LUo=;
        b=D9aHwvzLBHfaPZK8CQpv+rs+m8h6M+ChAFlS6NEA9Th4Qp19s65xNhU6m8vs7NKl3G
         g3bKCcr2cViyZZX3hWeo2JwyKNmEJ3FXfKpEwsUBggqsW30kk4piFE5ti9bkhRbcbfl2
         t77K8uzv94fnswD/dNAZvkuQbgN2Hkewu8lqmphM9s4Fw7aMEmdlClEUFwVEYmYMU9jC
         QV3YIX5zR0CdRjIgg9kThKfy6WPKQ37AZvKcZJGSCv4NyirDprnxdZ+EIeGs+8QS30It
         tsctrPZjXvULCzCJ6PEyBm6TyvFPohfrZ8vw/EdsXsFwXFw7trMTLSeKjExSXfW5+96z
         ojlg==
X-Gm-Message-State: AOJu0Yzj3vuaSbWfwgB+GqCMwJKkyIlg4m27loPcVwNbjd3o+e9ne2i5
	KlqcaSpTv+bdBU6+nAU/2KAcH3So2yBmpN27Nog=
X-Google-Smtp-Source: AGHT+IEr8VQmfkTYE7ST2zYWV4LeGK2QYdWY+ys2Gl7x6m0VZhZ+++Cnz87Z1jNlLR5EAhKG8otzbA==
X-Received: by 2002:a17:906:da8a:b0:a23:7576:3552 with SMTP id xh10-20020a170906da8a00b00a2375763552mr408536ejb.45.1704882852496;
        Wed, 10 Jan 2024 02:34:12 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b00a2699a54888sm1939147ejc.64.2024.01.10.02.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:34:12 -0800 (PST)
Message-ID: <a16a2241d93696002e718b9e353bc9f798063ce8.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Wed, 10 Jan 2024 11:37:23 +0100
In-Reply-To: <20240110091608.00003bfc@Huawei.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-6-998e9148b692@analog.com>
	 <20231221174437.5935a5c3@jic23-huawei>
	 <f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
	 <20231226155904.043fee13@jic23-huawei>
	 <8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
	 <20240110091608.00003bfc@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 09:16 +0000, Jonathan Cameron wrote:
> On Tue, 09 Jan 2024 13:15:54 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2023-12-26 at 15:59 +0000, Jonathan Cameron wrote:
> > > =C2=A0=20
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_act=
ion_or_reset(dev, iio_backend_release,
> > > > > > back);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link =3D device_link=
_add(dev, back->dev,
> > > > > > DL_FLAG_AUTOREMOVE_CONSUMER);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!link)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_warn("%s: Could not link to supplier(%s)\n=
",
> > > > > > dev_name(dev),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0dev_name(back->dev));=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Why is that not an error and we try to carry on?=C2=A0=C2=A0=C2=
=A0=20
> > > >=20
> > > > I guess having the links are not really mandatory for the whole thi=
ng to
> > > > work (more
> > > > like a nice to have). That's also how this is handled in another
> > > > subsystems
> > > > so I
> > > > figured it would be fine.
> > > >=20
> > > > But since you are speaking about this... After you pointing me to
> > > > Bartosz's
> > > > talk and
> > > > sawing it (as stuff like this is mentioned), I started to question =
this.
> > > > The
> > > > goal
> > > > with the above comment is that if you remove the backend, all the
> > > > consumers
> > > > are
> > > > automatically removed (unbound). Just not sure if that's what we al=
ways
> > > > want
> > > > (and we
> > > > are already handling the situation where a backend goes away with -
> > > > ENODEV)
> > > > as some
> > > > frontends could still be useful without the backend (I guess that c=
ould
> > > > be
> > > > plausible). I think for now we don't really have such usecases so t=
he
> > > > links
> > > > can make
> > > > sense (and we can figure something like optionally creating these l=
inks
> > > > if
> > > > we ever
> > > > need too) but having your inputs on this will definitely be valuabl=
e.=C2=A0=20
> > >=20
> > > I'm not keen on both trying to make everything tear down cleanly AND
> > > making
> > > sure
> > > it all works even if we don't. That just adds two code paths to test =
when
> > > either
> > > should be sufficient on its own.=C2=A0 I don't really mind which.=C2=
=A0 Bartosz's
> > > stuff=C2=A0=20
> >=20
> > Agreed...
> >=20
> > > is nice, but it may not be the right solution here.=C2=A0=C2=A0=20
> >=20
> > There's pros and cons on both options...=C2=A0
> >=20
> > For the device links the cons I see is that it depends on patch 3 for i=
t to
> > work
> > (or some other approach if the one in that patch is not good) - not rea=
lly a
> > real con though :). The biggest concern is (possible) future uses where=
 we
> > end
> > up with cases where removing a backend is not really a "deal breaker". =
I
> > could
> > think of frontends that have multiple backends (one per data path) and
> > removing
> > one backend would not tear the whole thing down (we would just have one=
 non
> > functional data paths/port where the others are still ok).
>=20
> I wouldn't waste time catering to such set ups.=C2=A0 If the whole thing =
gets
> torn down because one element went away that should be fine.
> To do anything else I'd want to see a real world use case.

Fair enough...

>=20
> >=20
> > Olivier, for STM usecases, do we always need the backend? I mean, does =
it
> > make
> > sense to always remove/unbind the frontend in case the backend is unbou=
nd?
> >=20
> > Maybe some of your usecases already "forces" us with a decision.=20
> >=20
> > The biggest pro I see is code simplicity. If we can assume the frontend=
 can
> > never exist in case one of the backends is gone, we can:
> >=20
> > =C2=A0* get rid of the sync mutex;
> > =C2=A0* get rid of the kref and bind the backend object lifetime to the=
 backend
> > device (using devm_kzalloc() instead of kzalloc + refcount.
> >=20
> > Basically, we would not need to care about syncing the backend existenc=
e
> > with
> > accessing it...
> > To sum up, the device_links approach tends to be similar (not identical=
) to
> > the
> > previous approach using the component API.
> >=20
> > The biggest pro I see in Bartosz's stuff is flexibility. So it should j=
ust
> > work
> > in whatever future usecases we might have. I fear that going the
> > device_links
> > road we might end up needing this stuff anyways.
>=20
> I'm keen on it if it simplifies code or becomes the dominant paradigm for=
 such
> things in the kernel (so becomes what people expect).=C2=A0 That isn't tr=
ue yet
> and I doubt it will be particularly soon.=C2=A0 If things head that way w=
e can
> revisit as it would enable things that currently we don't support - nothi=
ng
> should break.
>=20

Well, If I'm not missing anything, simpler code would be with device_links =
so I
guess that's your preferred approach for now :). Also fine by me as this is=
 an
in kernel interface so we easily revisit it.

I'll just wait a bit more (before sending v5) to see if Olivier has any
foreseeable usecase where device_links would be an issue.

- Nuno S=C3=A1



