Return-Path: <linux-iio+bounces-1131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70B81A189
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5366F282097
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71863D973;
	Wed, 20 Dec 2023 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKIqVjac"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B23D967;
	Wed, 20 Dec 2023 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so2625422a12.0;
        Wed, 20 Dec 2023 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703084034; x=1703688834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zipz1OYEhdhdykgZB1hAO+2BFJwW0gu1niltmpw0TbA=;
        b=UKIqVjaczWsMqQUIN6hP8lpheXGr0kAp43kFEP7a2gUSgrKu1lc7bDqYMwFIVdZGHI
         fkxGrYrOIOjBrOxEiN2Mjf915LS0DZjuCj4NrflsTfyZym5Z4gnHWKlLQ+hUueWDSiUH
         38PePPX0cu/UlMgfOpIHeozeoZdBmChzsuLV9mucB2u6bpBq6U7L6FIuZfxUU+toL3L4
         +8LnFXJAxpz8ve+7oafRETnyohYbaI0xd0ee3eUSqdIRa8r4svlN0zqYNM+KCrKv0GTe
         ecqr3G8/pkLexcpNrMIHrZt+4NKv45G7WsIsnlNYnYrXKpAe3d/6VZSCMqPCR+EGTc4I
         AEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084034; x=1703688834;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zipz1OYEhdhdykgZB1hAO+2BFJwW0gu1niltmpw0TbA=;
        b=aFT0nQFbgfDkNAaA8cAD8qVCCB9nzuM7Sbq/rTfQboLJ7hrqkOVmKWW6uW8y4LfPMv
         wLkUOwXGjWuTNXbWVCBv5ZfC3/ux63fMNGtMA3mua7LrFnZyCRHhUEdm6sDd8Ak5L5AH
         i6JDwIu0bevIZ/S5PzYKZJguUW0IHuW85ydqJ40/iQJhy7OzYA2S0ZsI5cXyPgu8/QMA
         d2U5Mn/n9eTPrc4GodTMWG57EsqQrTgG/C3nBncQSj7TuikeskxSTKmCGERGjbxyiCVU
         MwyNBEOpvZWiuSh0Rn3GL4paEny8WgzbMevKhYfjqE1lP1iJIYkwQwDs/3fC2Rp/fIb0
         7sNQ==
X-Gm-Message-State: AOJu0Yy4x0Tx7cJjSt1L83qye4jKQ+ZP2JC1hNORfNFUoZnXsYmlRefU
	TUt6hwt4uwbVhpw4otXuKxk=
X-Google-Smtp-Source: AGHT+IFJo1F1hAiAeKWaeXPgRI6EJgNqIqtp+nrWG17UtFrEN/Pjwdp7P76JOh6TuJkbnSF4A+SOvg==
X-Received: by 2002:a50:9512:0:b0:553:a1e0:311f with SMTP id u18-20020a509512000000b00553a1e0311fmr1633333eda.25.1703084033693;
        Wed, 20 Dec 2023 06:53:53 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id d23-20020a50fe97000000b005534057c72dsm3598926edt.18.2023.12.20.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:53:53 -0800 (PST)
Message-ID: <8e37482d51b3eafa42aeb0ae12b70187845e1244.camel@gmail.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 20 Dec 2023 15:56:59 +0100
In-Reply-To: <20231220141733.GA145578-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231214141600.GA224419-robh@kernel.org>
	 <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
	 <20231214170326.GA458046-robh@kernel.org>
	 <dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
	 <20231217140412.237511b8@jic23-huawei>
	 <20231220141733.GA145578-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 08:17 -0600, Rob Herring wrote:
> On Sun, Dec 17, 2023 at 02:04:12PM +0000, Jonathan Cameron wrote:
> > On Fri, 15 Dec 2023 16:18:39 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >=20
> > > On Thu, 2023-12-14 at 11:03 -0600, Rob Herring wrote:
> > > > On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno S=C3=A1 wrote:=C2=A0=
=20
> > > > > On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:=C2=A0=20
> > > > > > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:=C2=A0=
=20
> > > > > > > v1:
> > > > > > > =C2=A0
> > > > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic=
23-huawei/T/#m222f517
> > > > > > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > > > >=20
> > > > > > > v2:
> > > > > > > =C2=A0
> > > > > > > https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-54509=
51895e1@analog.co
> > > > > > > m
> > > > > > >=20
> > > > > > > Changes in v3:
> > > > > > > - Patch 1:
> > > > > > > =C2=A0* Use proposed generic schema [1]. Also make it a requi=
red
> > > > > > > property;
> > > > > > > =C2=A0* Improved the commit message.
> > > > > > > - Patch 2:
> > > > > > > =C2=A0* Improved commit message.
> > > > > > > - Patch 4:
> > > > > > > =C2=A0* Namespace all IIO DMAENGINE buffer exports;
> > > > > > > =C2=A0* Removed unrelated new line removal change.
> > > > > > > - Patch 5:
> > > > > > > =C2=A0* Namespace all IIO backend exports.
> > > > > > > - Patch 6:
> > > > > > > =C2=A0* Set backend.h in alphabetical order;
> > > > > > > =C2=A0* Import IIO backend namespace.
> > > > > > > - Patch 7:
> > > > > > > =C2=A0* Don't depend on OF in kbuild anymore;
> > > > > > > =C2=A0* Import IIO backend namespace.
> > > > > > >=20
> > > > > > > For the bindings patches, I tried not to enter into much deta=
ils
> > > > > > > about
> > > > > > > the IIO framework as I think specifics of the implementation =
don't
> > > > > > > care
> > > > > > > from the bindings perspective. Hopefully the commit messages =
are
> > > > > > > good
> > > > > > > enough.
> > > > > > >=20
> > > > > > > I'm also aware that patch 1 is not backward compatible but we=
 are
> > > > > > > anyways doing it on the driver side (and on the driver the
> > > > > > > property is
> > > > > > > indeed required). Anyways, just let me know if making the pro=
perty
> > > > > > > required is not acceptable (I'm fairly confident no one was u=
sing
> > > > > > > the
> > > > > > > upstream version of the driver and so validating devicetrees =
for
> > > > > > > it).=20
> > > > > > >=20
> > > > > > > Keeping the block diagram in v3's cover so we don't have to f=
ollow
> > > > > > > links
> > > > > > > to check the one of the typicals setups.=20
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------------
> > > > > > > -----------
> > > > > > > ----
> > > > > > > -----------------
> > > > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | -----------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -
> > > > > > > -----------
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0 FPGA |
> > > > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |------------------------| | AXI ADC |---------|
> > > > > > > DMA CORE
> > > > > > > > ----
> > > > > > > --| RAM |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > > =C2=A0| (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|=
---------
> > > > > > > |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > ----
> > > > > > > --|=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
> > > > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |------------------------| -----------=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > > > > > > -----------
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
> > > > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------------
> > > > > > > -----------
> > > > > > > ----
> > > > > > > -----------------=C2=A0=20
> > > > > >=20
> > > > > > Why doesn't axi-adc just have an io-channels property to adc? I=
t's
> > > > > > the=20
> > > > > > opposite direction for the link, but it seems more logical to m=
e
> > > > > > that=20
> > > > > > axi-adc depends on adc rather than the other way around.
> > > > > > =C2=A0=20
> > > > >=20
> > > > > We are not interested on a single channel but on the complete
> > > > > device.=C2=A0>From the
> > > > > axi-
> > > > > adc point of view, there's not much we could do with the adc chan=
nel.
> > > > > I mean,
> > > > > maybe
> > > > > we could still do something but it would be far from ideal (see
> > > > > below).=C2=A0=20
> > > >=20
> > > > Will this hold up for everyone? Could there be a backend device tha=
t=20
> > > > handles multiple ADCs? IOW, do you need #io-backend-cells? It's som=
ewhat
> > > > better if we add that up front rather than later and have to treat=
=20
> > > > missing as 0 cells. It is also the only way to generically identify=
 the=20
> > > > providers (well, there's also 'foo-controller' properties, but we'v=
e=20
> > > > gone away from those).
> > > > =C2=A0=20
> > >=20
> > > For the axi-adc backend, it's very unlikely. The way the core connect=
s to
> > > the
> > > converters is through a serial data interface (LVDS, CMOS or JESD in =
ADI
> > > usecases).
> > > This interface is not really a bus so it's kind of a 1:1 connection. =
Now,
> > > in more
> > > complicated devices (like highly integrated RF transceivers) what we =
have
> > > is that we
> > > have multiple of these cores (one per RX/TX port) connected to the
> > > frontend. So,
> > > effectively 1 frontend could have multiple backends. So, yes, your fi=
rst
> > > "doubts" are
> > > not that "crazy" as this is also not the "typical" provider - consume=
r
> > > relationship.
> > > However, for all of what I've said in the previous email, even in the=
se
> > > cases,
> > > thinking in these cores as the provider, makes things much more easie=
r to
> > > handle.
> > >=20
> > > However, the above is just ADI usecases. In theory, yes, it can be ve=
ry
> > > possible for
> > > another backend other than axi-adc to have multiple frontends connect=
ed so
> > > I guess we
> > > can make #io-backend-cells already available in the schema.
> >=20
> > I'd like ultimately to consider making this work for new instances of
> > dfsdm devices (separately front end ADC that spits out a modulated sign=
al
> > that a host
> > controller then turns into something useful). In those cases we might w=
ell
> > see a mix
> > of front ends connected to one backend (at least in theory - not sure a=
nyone
> > would
> > build such thing outside of an eval board).
> >=20
> > Adding the flexibility from the start would be sensible. So I agree wit=
h Rob
> > here.
> >=20
> > >=20
> > > For the axi-adc bindings this would be 'const: 0', right?
> > >=20
> > > > =C2=A0=20
> > > > > The opposite direction is exactly what we had (look at patch 2) j=
ust
> > > > > with another
> > > > > custom property. The problem with that is that we would then need=
 a
> > > > > bidirectional
> > > > > link (we would need to callback into the provider and the provide=
r
> > > > > would need to
> > > > > access the consumer) between consumers and providers and that wou=
ld be
> > > > > far from
> > > > > optimal. The bidirectional link would exist because if we want to
> > > > > support
> > > > > fundamental
> > > > > things like LVDS/CMOS interface tuning we need to set/get setting=
s
> > > > > from the axi-
> > > > > adc
> > > > > core. And as Jonathan suggested, the real data is captured or sen=
t on
> > > > > the
> > > > > converters
> > > > > (ADC or DACs) and that is why we have the IIO device/interface in
> > > > > there and why
> > > > > we
> > > > > call them "frontends". In ADI usecases, backends are these FPGA c=
ores
> > > > > providing
> > > > > "services" to the "real" high speed converters. To put it in anot=
her
> > > > > way, the
> > > > > real
> > > > > converter is the one who knows how to use the axi-adc core and no=
t the
> > > > > other way
> > > > > around. That's also one of the reasons why it would be way more
> > > > > difficult to
> > > > > handle
> > > > > things with the opposite link. That's how we have done it so far =
and
> > > > > the mess we
> > > > > have
> > > > > out of tree is massive :sweat_smile: We ended up doing raw writes=
 and
> > > > > reads on
> > > > > the
> > > > > axi-adc MMIO registers from the converter driver just because we =
had
> > > > > to configure
> > > > > or
> > > > > get something from the axi-adc device but the link was backwards.=
=C2=A0=20
> > > >=20
> > > > The direction (for the binding) doesn't really matter. It doesn't=
=20
> > > > dictate the direction in the OS. In the ad9467 driver, you can sear=
ch=20
> > > > the DT for 'adi,adc-dev' and find the node which matches your node'=
s=20
> > > > phandle. It's not exactly efficient, but you are doing it once. It =
would
> > > > also prevent the DT ABI break you are introducing.
> > > > =C2=A0=20
> > >=20
> > > Hmm, I think I see your idea. So you mean something like
> > > devm_iio_backend_get_optional() and if not present, then we would loo=
k for
> > > nodes
> > > having the 'adi,adc-dev' property and look for the one pointing at us=
...
> > > Then, we
> > > would need another API in the backend to look for registered backends
> > > matching that
> > > fwnode. Right?
> > >=20
> > > I mean, I guess this could work but we would already have to start a =
fresh
> > > framework
> > > with API's that are not really meant to be used anymore other than th=
e
> > > ad9467 driver
> > > (not devm_iio_backend_get_optional() because sooner or later I think =
we'll
> > > need that
> > > one). We are already breaking ABI in the driver and I'm still fairly
> > > confident no one
> > > is really using the upstream driver because it's lacking support for
> > > devices and
> > > important features (not even in ADI fork we're using it).
> > >=20
> > > Anyways, if you still insist on having something like this (and feel =
more
> > > comfortable
> > > in not breaking DT ABI), I can see how this would look like in the ne=
xt
> > > version...
> >=20
> > See how it looks. If it means removing the need to convince Rob then it=
's
> > probably easier
> > to write the code than try and talk him around ;)=C2=A0 Can happily sti=
ck a bit
> > deprecated
> > note next to the binding and the code.
>=20
> I only point out ABI breaks and require they are justified in the commit=
=20
> message (basically stating what you state above). Otherwise, I don't=20
> care if I don't use the platform.
>=20

Good to know. I already worked on a new series only with your suggestion so=
 now
I'll send it anyways :). In the end it will be up to me and Jonathan to dec=
ide
if we want to add an API only meant to be used for this.

Thanks!
- Nuno S=C3=A1
> > > > >=20


