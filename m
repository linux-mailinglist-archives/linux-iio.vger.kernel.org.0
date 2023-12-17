Return-Path: <linux-iio+bounces-1000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F72815F8F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3722835E3
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868544394;
	Sun, 17 Dec 2023 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loPK4eOO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E544369;
	Sun, 17 Dec 2023 14:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12001C433C8;
	Sun, 17 Dec 2023 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702821868;
	bh=pauay14mit3mM4hIsUc1NwwGo2lr2REiIQ4+35RHyho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=loPK4eOOEu9ABSTMZzt4d5yzBvVzzc9bFlFqiiDrxKInPyJ4/JhMfHvOTuLRUqf8U
	 ZlRhmftxaEtGlwg/d+lsXmWZs3rCKuoUVGGrakqBXVu9Rahjr9Wd+Tz9ZmUCir/tvH
	 9CQ89EwGVY2q/7BKcf14brl6+Hq4TxzQAvT7AECes7hqA0/7D8JG+ZAMYWEXuG2FKP
	 GJSuSYC2WW1NYDgv330CKzBdnGit4pBLhnilxN5yQFZxkc7kfh5FXuUVic1HwhV3l4
	 +ersIYV7BNOagOE4N9HLC1Moxjk2y3Clq1YpzWa0MTMQhQAFSlvQVXMWSwtj8Y/Hib
	 PuERElka7dvQQ==
Date: Sun, 17 Dec 2023 14:04:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
Message-ID: <20231217140412.237511b8@jic23-huawei>
In-Reply-To: <dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	<20231214141600.GA224419-robh@kernel.org>
	<fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
	<20231214170326.GA458046-robh@kernel.org>
	<dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 16:18:39 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-12-14 at 11:03 -0600, Rob Herring wrote:
> > On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno S=C3=A1 wrote: =20
> > > On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote: =20
> > > > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote: =20
> > > > > v1:
> > > > > =C2=A0
> > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-h=
uawei/T/#m222f517
> > > > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > >=20
> > > > > v2:
> > > > > =C2=A0
> > > > > https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-545095189=
5e1@analog.co
> > > > > m
> > > > >=20
> > > > > Changes in v3:
> > > > > - Patch 1:
> > > > > =C2=A0* Use proposed generic schema [1]. Also make it a required =
property;
> > > > > =C2=A0* Improved the commit message.
> > > > > - Patch 2:
> > > > > =C2=A0* Improved commit message.
> > > > > - Patch 4:
> > > > > =C2=A0* Namespace all IIO DMAENGINE buffer exports;
> > > > > =C2=A0* Removed unrelated new line removal change.
> > > > > - Patch 5:
> > > > > =C2=A0* Namespace all IIO backend exports.
> > > > > - Patch 6:
> > > > > =C2=A0* Set backend.h in alphabetical order;
> > > > > =C2=A0* Import IIO backend namespace.
> > > > > - Patch 7:
> > > > > =C2=A0* Don't depend on OF in kbuild anymore;
> > > > > =C2=A0* Import IIO backend namespace.
> > > > >=20
> > > > > For the bindings patches, I tried not to enter into much details =
about
> > > > > the IIO framework as I think specifics of the implementation don'=
t care
> > > > > from the bindings perspective. Hopefully the commit messages are =
good
> > > > > enough.
> > > > >=20
> > > > > I'm also aware that patch 1 is not backward compatible but we are
> > > > > anyways doing it on the driver side (and on the driver the proper=
ty is
> > > > > indeed required). Anyways, just let me know if making the property
> > > > > required is not acceptable (I'm fairly confident no one was using=
 the
> > > > > upstream version of the driver and so validating devicetrees for =
it).=20
> > > > >=20
> > > > > Keeping the block diagram in v3's cover so we don't have to follo=
w links
> > > > > to check the one of the typicals setups.=20
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----------------------------------
> > > > > ----
> > > > > -----------------
> > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | -----------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ------------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0 FPGA |
> > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |------------------------| | AXI ADC |---------| DMA CORE
> > > > > |----
> > > > > --| RAM |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > =C2=A0| (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|----=
-----|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > |----
> > > > > --|=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
> > > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |------------------------| -----------=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------------
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
> > > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ----------------------------------
> > > > > ----
> > > > > ----------------- =20
> > > >=20
> > > > Why doesn't axi-adc just have an io-channels property to adc? It's =
the=20
> > > > opposite direction for the link, but it seems more logical to me th=
at=20
> > > > axi-adc depends on adc rather than the other way around.
> > > >  =20
> > >=20
> > > We are not interested on a single channel but on the complete device.=
=C2=A0>From the
> > > axi-
> > > adc point of view, there's not much we could do with the adc channel.=
 I mean,
> > > maybe
> > > we could still do something but it would be far from ideal (see below=
). =20
> >=20
> > Will this hold up for everyone? Could there be a backend device that=20
> > handles multiple ADCs? IOW, do you need #io-backend-cells? It's somewha=
t=20
> > better if we add that up front rather than later and have to treat=20
> > missing as 0 cells. It is also the only way to generically identify the=
=20
> > providers (well, there's also 'foo-controller' properties, but we've=20
> > gone away from those).
> >  =20
>=20
> For the axi-adc backend, it's very unlikely. The way the core connects to=
 the
> converters is through a serial data interface (LVDS, CMOS or JESD in ADI =
usecases).
> This interface is not really a bus so it's kind of a 1:1 connection. Now,=
 in more
> complicated devices (like highly integrated RF transceivers) what we have=
 is that we
> have multiple of these cores (one per RX/TX port) connected to the fronte=
nd. So,
> effectively 1 frontend could have multiple backends. So, yes, your first =
"doubts" are
> not that "crazy" as this is also not the "typical" provider - consumer re=
lationship.
> However, for all of what I've said in the previous email, even in these c=
ases,
> thinking in these cores as the provider, makes things much more easier to=
 handle.
>=20
> However, the above is just ADI usecases. In theory, yes, it can be very p=
ossible for
> another backend other than axi-adc to have multiple frontends connected s=
o I guess we
> can make #io-backend-cells already available in the schema.

I'd like ultimately to consider making this work for new instances of
dfsdm devices (separately front end ADC that spits out a modulated signal t=
hat a host
controller then turns into something useful). In those cases we might well =
see a mix
of front ends connected to one backend (at least in theory - not sure anyon=
e would
build such thing outside of an eval board).

Adding the flexibility from the start would be sensible. So I agree with Ro=
b here.

>=20
> For the axi-adc bindings this would be 'const: 0', right?
>=20
> >  =20
> > > The opposite direction is exactly what we had (look at patch 2) just =
with another
> > > custom property. The problem with that is that we would then need a b=
idirectional
> > > link (we would need to callback into the provider and the provider wo=
uld need to
> > > access the consumer) between consumers and providers and that would b=
e far from
> > > optimal. The bidirectional link would exist because if we want to sup=
port
> > > fundamental
> > > things like LVDS/CMOS interface tuning we need to set/get settings fr=
om the axi-
> > > adc
> > > core. And as Jonathan suggested, the real data is captured or sent on=
 the
> > > converters
> > > (ADC or DACs) and that is why we have the IIO device/interface in the=
re and why
> > > we
> > > call them "frontends". In ADI usecases, backends are these FPGA cores=
 providing
> > > "services" to the "real" high speed converters. To put it in another =
way, the
> > > real
> > > converter is the one who knows how to use the axi-adc core and not th=
e other way
> > > around. That's also one of the reasons why it would be way more diffi=
cult to
> > > handle
> > > things with the opposite link. That's how we have done it so far and =
the mess we
> > > have
> > > out of tree is massive :sweat_smile: We ended up doing raw writes and=
 reads on
> > > the
> > > axi-adc MMIO registers from the converter driver just because we had =
to configure
> > > or
> > > get something from the axi-adc device but the link was backwards. =20
> >=20
> > The direction (for the binding) doesn't really matter. It doesn't=20
> > dictate the direction in the OS. In the ad9467 driver, you can search=20
> > the DT for 'adi,adc-dev' and find the node which matches your node's=20
> > phandle. It's not exactly efficient, but you are doing it once. It woul=
d=20
> > also prevent the DT ABI break you are introducing.
> >  =20
>=20
> Hmm, I think I see your idea. So you mean something like
> devm_iio_backend_get_optional() and if not present, then we would look fo=
r nodes
> having the 'adi,adc-dev' property and look for the one pointing at us... =
Then, we
> would need another API in the backend to look for registered backends mat=
ching that
> fwnode. Right?
>=20
> I mean, I guess this could work but we would already have to start a fres=
h framework
> with API's that are not really meant to be used anymore other than the ad=
9467 driver
> (not devm_iio_backend_get_optional() because sooner or later I think we'l=
l need that
> one). We are already breaking ABI in the driver and I'm still fairly conf=
ident no one
> is really using the upstream driver because it's lacking support for devi=
ces and
> important features (not even in ADI fork we're using it).
>=20
> Anyways, if you still insist on having something like this (and feel more=
 comfortable
> in not breaking DT ABI), I can see how this would look like in the next v=
ersion...

See how it looks. If it means removing the need to convince Rob then it's p=
robably easier
to write the code than try and talk him around ;)  Can happily stick a bit =
deprecated
note next to the binding and the code.

>=20
> >  =20
> > > > And if there's another consumer in the chain, then a node could=20
> > > > certainly be both an io-channels consumer and producer.
> > > >  =20
> > >=20
> > > This should also be possible with this architecture. A node can be bo=
th a backend
> > > (provider) and a consumer and we have an out of tree design that fits=
 this (that
> > > I
> > > surely want to upstream after the foundations are done).
> > >  =20
> > > > The architecture of the drivers seems odd to me. It looks similar t=
o=20
> > > > making a phy driver handle all the state and protocol with the host=
=20
> > > > controller being a backend. =20
> > >=20
> > > In this case, it's not really a controller. It's more like an extensi=
on of the
> > > device
> > > because we need a way to handle the high sample rates this ADCs can d=
o. Then we
> > > can
> > > also do test tones with the backend which is useful for interface tun=
ing (as
> > > mentioned above).
> > >=20
> > > To give you a bit more context,=C2=A0I'm adding the generic property =
because we will
> > > have
> > > more users for it (from ADI - the next should be the axi-dac core) bu=
t STM is
> > > also
> > > interested in this (likely the next user).
> > >=20
> > > Hope this makes it a bit more clear... =20
> >=20
> > Yes, thanks.
> >=20
> > I generally ask for 2 users on new common bindings. I've accepted too=20
> > many only to have the 2nd user come in a month later and need additions=
.=20
> > An ack on the binding from the STM folks would be nice here. And=20
> > Jonathan too.
> >  =20
>=20
> Olivier, could we get an ack on the bindings patch? Do you also have any =
idea about
> how long it would take for you to send patches so we have another user of=
 the schema?
>=20
> On my side, it might very well take a month or so (given we have holidays=
 nearby) as
> the axi-dac core is more complex than the axi-adc. Bah it might take less=
 than a
> month to have the first version of it posted in the lists but I can't mak=
e any
> promises.

For the driver side of things I'd like at least 2, preferably 3 users befor=
e merging.
We have more flexibility to rework things as any issues will probably be in=
ternal
interfaces, but I'd rather wait if we are going to have 3 users within anot=
her month
or 2.

Jonathan
=20
>=20
> - Nuno S=C3=A1
>=20


