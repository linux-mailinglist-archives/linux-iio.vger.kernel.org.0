Return-Path: <linux-iio+bounces-1065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8281796B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2862832E9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DB7146C;
	Mon, 18 Dec 2023 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh/VKYmf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978537896;
	Mon, 18 Dec 2023 18:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37AAC433C7;
	Mon, 18 Dec 2023 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702923179;
	bh=bRBGCSzMyL/fl+vEUWhNFqGNbp2BbGbBJpmsYUp6o6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rh/VKYmf0x7RCztzlqfajKNe/3evXxNc/3ftQu8emST7fZDpUiQTn7o71sr/ZEPCg
	 OBCgKOl0jZ73eU8LDrNyIxSc7PBxXwQ4zEFCPXgk7U0LulQoLhn1jgWfwi5/iTx1GM
	 CEG1r4T1Gm2USta+AaUB51Ux0odiDhlv4Xt/q1Aku5t15CGjDuLLlC5vaFwnPt0W76
	 N0GyfXENUjZNy+AZ2b+9wJAC1PW6hDDhSsNHMmDQwARePHj4nZvTup29UJ1oORoCgc
	 sWoaJIV06BRRe01uqLhSsHNJFE8Td8bpdqLNk09M4Co9XUeFi/GAXDE/tq9cWXidC0
	 GCVYuqDYOVF/Q==
Date: Mon, 18 Dec 2023 18:12:43 +0000
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
Message-ID: <20231218181243.2b1e17ba@jic23-huawei>
In-Reply-To: <4531a5b626361a18bba8df640f530fcaeab00e7e.camel@gmail.com>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	<20231214141600.GA224419-robh@kernel.org>
	<fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
	<20231214170326.GA458046-robh@kernel.org>
	<dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
	<20231217140412.237511b8@jic23-huawei>
	<4531a5b626361a18bba8df640f530fcaeab00e7e.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > >  =20
> > > > =C2=A0  =20
> > > > > > And if there's another consumer in the chain, then a node could=
=20
> > > > > > certainly be both an io-channels consumer and producer.
> > > > > > =C2=A0  =20
> > > > >=20
> > > > > This should also be possible with this architecture. A node can b=
e both
> > > > > a backend
> > > > > (provider) and a consumer and we have an out of tree design that =
fits
> > > > > this (that
> > > > > I
> > > > > surely want to upstream after the foundations are done).
> > > > > =C2=A0  =20
> > > > > > The architecture of the drivers seems odd to me. It looks simil=
ar to=20
> > > > > > making a phy driver handle all the state and protocol with the =
host=20
> > > > > > controller being a backend.=C2=A0  =20
> > > > >=20
> > > > > In this case, it's not really a controller. It's more like an ext=
ension
> > > > > of the
> > > > > device
> > > > > because we need a way to handle the high sample rates this ADCs c=
an do.
> > > > > Then we
> > > > > can
> > > > > also do test tones with the backend which is useful for interface=
 tuning
> > > > > (as
> > > > > mentioned above).
> > > > >=20
> > > > > To give you a bit more context,=C2=A0I'm adding the generic prope=
rty because
> > > > > we will
> > > > > have
> > > > > more users for it (from ADI - the next should be the axi-dac core=
) but
> > > > > STM is
> > > > > also
> > > > > interested in this (likely the next user).
> > > > >=20
> > > > > Hope this makes it a bit more clear...=C2=A0  =20
> > > >=20
> > > > Yes, thanks.
> > > >=20
> > > > I generally ask for 2 users on new common bindings. I've accepted t=
oo=20
> > > > many only to have the 2nd user come in a month later and need addit=
ions.=20
> > > > An ack on the binding from the STM folks would be nice here. And=20
> > > > Jonathan too.
> > > > =C2=A0  =20
> > >=20
> > > Olivier, could we get an ack on the bindings patch? Do you also have =
any
> > > idea about
> > > how long it would take for you to send patches so we have another use=
r of
> > > the schema?
> > >=20
> > > On my side, it might very well take a month or so (given we have holi=
days
> > > nearby) as
> > > the axi-dac core is more complex than the axi-adc. Bah it might take =
less
> > > than a
> > > month to have the first version of it posted in the lists but I can't=
 make
> > > any
> > > promises. =20
> >=20
> > For the driver side of things I'd like at least 2, preferably 3 users b=
efore
> > merging.
> > We have more flexibility to rework things as any issues will probably be
> > internal
> > interfaces, but I'd rather wait if we are going to have 3 users within =
another
> > month
> > or 2.
> >  =20
>=20
> Totally fine by me. But how would this look like? Could we have an immuta=
ble
> branch where we can send patches about this? Or maybe staging? I'm asking
> because adding more stuff into these series might make it harder to revie=
w (the
> axi-dac might have some fun ABI discussion :)). Ideally, we would have th=
is
> merged somewhere and then add users on top of it.

It's fine to post a bunch of series with stated dependencies
(I've gotten 5 series + deep in the past :)

Obviously useful to have a git tree with them all on somewhere though
but if you host that it would be ideal given you are driving this
work in general.

Jonathan

>=20
> - Nuno S=C3=A1


