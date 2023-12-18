Return-Path: <linux-iio+bounces-1049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA5816807
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A4A282BEA
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C40101DB;
	Mon, 18 Dec 2023 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH8VF+fM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD6101C2;
	Mon, 18 Dec 2023 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso4474666a12.0;
        Mon, 18 Dec 2023 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702888117; x=1703492917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zr9jVBtQpLCWW9l8nCjtKvOQA782/6dnac7OO1JnkwI=;
        b=RH8VF+fMT7/2vNsjh0t6vZSrDIJKXNwO0r+skCXiJ6AEuw5JN4TV+oSl8VEV82+8rr
         viCsTon2hdXgy1qqCQ2IqJGILjsmXwAAIyNfj31tHLpDGRvEUIJhRgbmSFxoSXXpL/5E
         miDJWOqBSadB7YNGnMFVkTEPIpmhJXeAUKmDTKjwWmzO3aks7eOX0QFf43tJq3E9w7O6
         eNXKcFq8q94RrBEW6I5dP4YliabgK+x+v5EFcwb04lSEQ65LZALSQcgZaD2PukCxVVzG
         VIpl32rt+gLR9HNaegaQKrZQECbImlmGpVe2Hb9O9FnqV6NoEc4k6tt8UKIHUmxQN89r
         v4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888117; x=1703492917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zr9jVBtQpLCWW9l8nCjtKvOQA782/6dnac7OO1JnkwI=;
        b=UtgVtHhjT6gfp/lzLkwfni1aRVCMJGFsg5wPqq3ODaxYtj7s6RLANanjBvCG9dSZt8
         aciI8n4p7YvaSKIcBz/XIkogHYxskpNCStEohJj7RTILproqQxNZR0EFkJeqyfABBrwM
         HLnIY9t2fTaFWP9qTXWyOWfb1Y9hWyA88uX/Y2DgH3u5x6q7qH1idbTldUMW0oNprX4c
         OCCUMN2BLeDtyX9uaBscWH+GIvEVcAh/PpcybSgNw1XtbWvmaUCZI4pJzFzUoPwz1t6U
         VG6RH6eRFtK49YW8Mu3U7n1Nco3htc9BCrVlTsQ0LpKKSpYGamSYj7yKE1CU6W3wrqPO
         TceQ==
X-Gm-Message-State: AOJu0YxCHId5moz8j6BvuIgSgDvWzrZccaJLJI0o763ILtJEYb+uo7T+
	bjJ0a1CBOj+zl2YzuZnoEwk=
X-Google-Smtp-Source: AGHT+IF/27kutM23P0/i14dhFEsJ2UmFW8D4YFDBn4oBTvUzkcvukZp5kfnr+8FhTysztDH5HmPgDg==
X-Received: by 2002:a17:906:ecb5:b0:a1d:afd8:ae89 with SMTP id qh21-20020a170906ecb500b00a1dafd8ae89mr13911507ejb.75.1702888116110;
        Mon, 18 Dec 2023 00:28:36 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id tx6-20020a1709078e8600b00a1fabca52f5sm10083700ejc.154.2023.12.18.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:28:35 -0800 (PST)
Message-ID: <4531a5b626361a18bba8df640f530fcaeab00e7e.camel@gmail.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 18 Dec 2023 09:31:40 +0100
In-Reply-To: <20231217140412.237511b8@jic23-huawei>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231214141600.GA224419-robh@kernel.org>
	 <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
	 <20231214170326.GA458046-robh@kernel.org>
	 <dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
	 <20231217140412.237511b8@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-12-17 at 14:04 +0000, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 16:18:39 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2023-12-14 at 11:03 -0600, Rob Herring wrote:
> > > On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno S=C3=A1 wrote:=C2=A0=
=20
> > > > On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:=C2=A0=20
> > > > > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:=C2=A0=
=20
> > > > > > v1:
> > > > > > =C2=A0
> > > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23=
-huawei/T/#m222f517
> > > > > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > > >=20
> > > > > > v2:
> > > > > > =C2=A0
> > > > > > https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951=
895e1@analog.co
> > > > > > m
> > > > > >=20
> > > > > > Changes in v3:
> > > > > > - Patch 1:
> > > > > > =C2=A0* Use proposed generic schema [1]. Also make it a require=
d
> > > > > > property;
> > > > > > =C2=A0* Improved the commit message.
> > > > > > - Patch 2:
> > > > > > =C2=A0* Improved commit message.
> > > > > > - Patch 4:
> > > > > > =C2=A0* Namespace all IIO DMAENGINE buffer exports;
> > > > > > =C2=A0* Removed unrelated new line removal change.
> > > > > > - Patch 5:
> > > > > > =C2=A0* Namespace all IIO backend exports.
> > > > > > - Patch 6:
> > > > > > =C2=A0* Set backend.h in alphabetical order;
> > > > > > =C2=A0* Import IIO backend namespace.
> > > > > > - Patch 7:
> > > > > > =C2=A0* Don't depend on OF in kbuild anymore;
> > > > > > =C2=A0* Import IIO backend namespace.
> > > > > >=20
> > > > > > For the bindings patches, I tried not to enter into much detail=
s
> > > > > > about
> > > > > > the IIO framework as I think specifics of the implementation do=
n't
> > > > > > care
> > > > > > from the bindings perspective. Hopefully the commit messages ar=
e
> > > > > > good
> > > > > > enough.
> > > > > >=20
> > > > > > I'm also aware that patch 1 is not backward compatible but we a=
re
> > > > > > anyways doing it on the driver side (and on the driver the prop=
erty
> > > > > > is
> > > > > > indeed required). Anyways, just let me know if making the prope=
rty
> > > > > > required is not acceptable (I'm fairly confident no one was usi=
ng
> > > > > > the
> > > > > > upstream version of the driver and so validating devicetrees fo=
r
> > > > > > it).=20
> > > > > >=20
> > > > > > Keeping the block diagram in v3's cover so we don't have to fol=
low
> > > > > > links
> > > > > > to check the one of the typicals setups.=20
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------------------------
> > > > > > ---------
> > > > > > ----
> > > > > > -----------------
> > > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | -----------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ---
> > > > > > ---------
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0 FPGA |
> > > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |------------------------| | AXI ADC |---------|
> > > > > > DMA CORE
> > > > > > > ----
> > > > > > --| RAM |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > =C2=A0| (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|--=
-------
> > > > > > |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > ----
> > > > > > --|=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> > > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |------------------------| -----------=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---
> > > > > > ---------
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> > > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -------------------------
> > > > > > ---------
> > > > > > ----
> > > > > > -----------------=C2=A0=20
> > > > >=20
> > > > > Why doesn't axi-adc just have an io-channels property to adc? It'=
s the
> > > > > opposite direction for the link, but it seems more logical to me =
that=20
> > > > > axi-adc depends on adc rather than the other way around.
> > > > > =C2=A0=20
> > > >=20
> > > > We are not interested on a single channel but on the complete
> > > > device.=C2=A0>From the
> > > > axi-
> > > > adc point of view, there's not much we could do with the adc channe=
l. I
> > > > mean,
> > > > maybe
> > > > we could still do something but it would be far from ideal (see bel=
ow).=C2=A0
> > >=20
> > > Will this hold up for everyone? Could there be a backend device that=
=20
> > > handles multiple ADCs? IOW, do you need #io-backend-cells? It's somew=
hat=20
> > > better if we add that up front rather than later and have to treat=
=20
> > > missing as 0 cells. It is also the only way to generically identify t=
he=20
> > > providers (well, there's also 'foo-controller' properties, but we've=
=20
> > > gone away from those).
> > > =C2=A0=20
> >=20
> > For the axi-adc backend, it's very unlikely. The way the core connects =
to
> > the
> > converters is through a serial data interface (LVDS, CMOS or JESD in AD=
I
> > usecases).
> > This interface is not really a bus so it's kind of a 1:1 connection. No=
w, in
> > more
> > complicated devices (like highly integrated RF transceivers) what we ha=
ve is
> > that we
> > have multiple of these cores (one per RX/TX port) connected to the fron=
tend.
> > So,
> > effectively 1 frontend could have multiple backends. So, yes, your firs=
t
> > "doubts" are
> > not that "crazy" as this is also not the "typical" provider - consumer
> > relationship.
> > However, for all of what I've said in the previous email, even in these
> > cases,
> > thinking in these cores as the provider, makes things much more easier =
to
> > handle.
> >=20
> > However, the above is just ADI usecases. In theory, yes, it can be very
> > possible for
> > another backend other than axi-adc to have multiple frontends connected=
 so I
> > guess we
> > can make #io-backend-cells already available in the schema.
>=20
> I'd like ultimately to consider making this work for new instances of
> dfsdm devices (separately front end ADC that spits out a modulated signal=
 that
> a host
> controller then turns into something useful). In those cases we might wel=
l see
> a mix
> of front ends connected to one backend (at least in theory - not sure any=
one
> would
> build such thing outside of an eval board).
>=20
> Adding the flexibility from the start would be sensible. So I agree with =
Rob
> here.
>=20

Agreed...

> >=20
> > For the axi-adc bindings this would be 'const: 0', right?
> >=20
> > > =C2=A0=20
> > > > The opposite direction is exactly what we had (look at patch 2) jus=
t
> > > > with another
> > > > custom property. The problem with that is that we would then need a
> > > > bidirectional
> > > > link (we would need to callback into the provider and the provider =
would
> > > > need to
> > > > access the consumer) between consumers and providers and that would=
 be
> > > > far from
> > > > optimal. The bidirectional link would exist because if we want to
> > > > support
> > > > fundamental
> > > > things like LVDS/CMOS interface tuning we need to set/get settings =
from
> > > > the axi-
> > > > adc
> > > > core. And as Jonathan suggested, the real data is captured or sent =
on
> > > > the
> > > > converters
> > > > (ADC or DACs) and that is why we have the IIO device/interface in t=
here
> > > > and why
> > > > we
> > > > call them "frontends". In ADI usecases, backends are these FPGA cor=
es
> > > > providing
> > > > "services" to the "real" high speed converters. To put it in anothe=
r
> > > > way, the
> > > > real
> > > > converter is the one who knows how to use the axi-adc core and not =
the
> > > > other way
> > > > around. That's also one of the reasons why it would be way more
> > > > difficult to
> > > > handle
> > > > things with the opposite link. That's how we have done it so far an=
d the
> > > > mess we
> > > > have
> > > > out of tree is massive :sweat_smile: We ended up doing raw writes a=
nd
> > > > reads on
> > > > the
> > > > axi-adc MMIO registers from the converter driver just because we ha=
d to
> > > > configure
> > > > or
> > > > get something from the axi-adc device but the link was backwards.=
=C2=A0=20
> > >=20
> > > The direction (for the binding) doesn't really matter. It doesn't=20
> > > dictate the direction in the OS. In the ad9467 driver, you can search=
=20
> > > the DT for 'adi,adc-dev' and find the node which matches your node's=
=20
> > > phandle. It's not exactly efficient, but you are doing it once. It wo=
uld=20
> > > also prevent the DT ABI break you are introducing.
> > > =C2=A0=20
> >=20
> > Hmm, I think I see your idea. So you mean something like
> > devm_iio_backend_get_optional() and if not present, then we would look =
for
> > nodes
> > having the 'adi,adc-dev' property and look for the one pointing at us..=
.
> > Then, we
> > would need another API in the backend to look for registered backends
> > matching that
> > fwnode. Right?
> >=20
> > I mean, I guess this could work but we would already have to start a fr=
esh
> > framework
> > with API's that are not really meant to be used anymore other than the
> > ad9467 driver
> > (not devm_iio_backend_get_optional() because sooner or later I think we=
'll
> > need that
> > one). We are already breaking ABI in the driver and I'm still fairly
> > confident no one
> > is really using the upstream driver because it's lacking support for de=
vices
> > and
> > important features (not even in ADI fork we're using it).
> >=20
> > Anyways, if you still insist on having something like this (and feel mo=
re
> > comfortable
> > in not breaking DT ABI), I can see how this would look like in the next
> > version...
>=20
> See how it looks. If it means removing the need to convince Rob then it's
> probably easier
> to write the code than try and talk him around ;)=C2=A0 Can happily stick=
 a bit
> deprecated
> note next to the binding and the code.
>=20

Will do...

> >=20
> > > =C2=A0=20
> > > > > And if there's another consumer in the chain, then a node could=
=20
> > > > > certainly be both an io-channels consumer and producer.
> > > > > =C2=A0=20
> > > >=20
> > > > This should also be possible with this architecture. A node can be =
both
> > > > a backend
> > > > (provider) and a consumer and we have an out of tree design that fi=
ts
> > > > this (that
> > > > I
> > > > surely want to upstream after the foundations are done).
> > > > =C2=A0=20
> > > > > The architecture of the drivers seems odd to me. It looks similar=
 to=20
> > > > > making a phy driver handle all the state and protocol with the ho=
st=20
> > > > > controller being a backend.=C2=A0=20
> > > >=20
> > > > In this case, it's not really a controller. It's more like an exten=
sion
> > > > of the
> > > > device
> > > > because we need a way to handle the high sample rates this ADCs can=
 do.
> > > > Then we
> > > > can
> > > > also do test tones with the backend which is useful for interface t=
uning
> > > > (as
> > > > mentioned above).
> > > >=20
> > > > To give you a bit more context,=C2=A0I'm adding the generic propert=
y because
> > > > we will
> > > > have
> > > > more users for it (from ADI - the next should be the axi-dac core) =
but
> > > > STM is
> > > > also
> > > > interested in this (likely the next user).
> > > >=20
> > > > Hope this makes it a bit more clear...=C2=A0=20
> > >=20
> > > Yes, thanks.
> > >=20
> > > I generally ask for 2 users on new common bindings. I've accepted too=
=20
> > > many only to have the 2nd user come in a month later and need additio=
ns.=20
> > > An ack on the binding from the STM folks would be nice here. And=20
> > > Jonathan too.
> > > =C2=A0=20
> >=20
> > Olivier, could we get an ack on the bindings patch? Do you also have an=
y
> > idea about
> > how long it would take for you to send patches so we have another user =
of
> > the schema?
> >=20
> > On my side, it might very well take a month or so (given we have holida=
ys
> > nearby) as
> > the axi-dac core is more complex than the axi-adc. Bah it might take le=
ss
> > than a
> > month to have the first version of it posted in the lists but I can't m=
ake
> > any
> > promises.
>=20
> For the driver side of things I'd like at least 2, preferably 3 users bef=
ore
> merging.
> We have more flexibility to rework things as any issues will probably be
> internal
> interfaces, but I'd rather wait if we are going to have 3 users within an=
other
> month
> or 2.
>=20

Totally fine by me. But how would this look like? Could we have an immutabl=
e
branch where we can send patches about this? Or maybe staging? I'm asking
because adding more stuff into these series might make it harder to review =
(the
axi-dac might have some fun ABI discussion :)). Ideally, we would have this
merged somewhere and then add users on top of it.

- Nuno S=C3=A1

