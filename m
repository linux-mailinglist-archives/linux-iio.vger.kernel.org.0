Return-Path: <linux-iio+bounces-9408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC497222E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB31F245E4
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FAA1898FA;
	Mon,  9 Sep 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVnAmdlq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFA14B06C;
	Mon,  9 Sep 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908366; cv=none; b=htqV8ZwO8mDRlntiNqPcjMH3+LrEV6yKpV/3xxhMkVH9YgVvVOQRCOkcQW42IQxt9xIv1nFZT9enNSIlMerZ6Fc6MzvItIBGkIfMUIFMgPaKUIpc/r69sXwe2IjLMc5Z8HX3PRgAs3mUJV11ojsK/LXeo7UtGDHE1DDITEtdJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908366; c=relaxed/simple;
	bh=rb5B92CBMzNEIC9NKpkqesSlKLgo3pGrD7EkJpolgRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiTj4mnf5AApYdDFJ8V6H+J783dk0hsNbPe8EDU7u9NDnpStbiE3mgX3sfawYdnvsm2DVKgHINcScacIxZ3utcmvKh0xeLCDoIzlE047oukQz7wAqfZyROn1xmy3N0aeG6xHeuiBwgrwA9Yz7H+pMgsBwJ4VE7FhERKLuEhJuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVnAmdlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3A2C4CEC5;
	Mon,  9 Sep 2024 18:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908365;
	bh=rb5B92CBMzNEIC9NKpkqesSlKLgo3pGrD7EkJpolgRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uVnAmdlqtGX+dm7d/YQAij+U3sGOHcUR85jkKax1Uv+J132Ocu9M6F2tStGJFmcmv
	 EYEzpL6TBDlrahliRP2cuRx5J/HXlr1aBI/sAd/CMHgAnq8oZVPXfprEjd6Y9REggc
	 rD+4ZbcUpo1aYe1S5q2e4397/fkFZb4M4vHzFBEmAXwGBb0abcgKV6C70kfOFD+XN4
	 oiUaOwA5TbSSszq+SsiQcDTBOHrZb/jcpYXfW4jXAKekOoELlRWrsPksviYDlQfw3i
	 QWUpwOrCVIbyELwgV6vzZ9ZhWaTVAV2zrbh9L8dCESF3qS8+ORxDYVlnODVTH4PkY7
	 QTfQcSseUh+Ug==
Date: Mon, 9 Sep 2024 19:59:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
Message-ID: <20240909195917.4ede2a9e@jic23-huawei>
In-Reply-To: <b9b952f6d73ee96f414d8bdb64fcf3dbfa625abd.camel@gmail.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240831123837.26a1070a@jic23-huawei>
	<74e0b200-d4c0-4aa3-9ee6-f49ac3f1467d@baylibre.com>
	<4a62ea7b-a8af-49e0-9718-30d927a69038@baylibre.com>
	<20240903203935.358a1423@jic23-huawei>
	<4bb5722003936371a661938d7238db195d2c0ad3.camel@gmail.com>
	<20240907151215.6f4c829c@jic23-huawei>
	<b9b952f6d73ee96f414d8bdb64fcf3dbfa625abd.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Sep 2024 09:37:35 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-09-07 at 15:12 +0100, Jonathan Cameron wrote:
> > On Thu, 05 Sep 2024 11:16:03 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Tue, 2024-09-03 at 20:39 +0100, Jonathan Cameron wrote: =20
> > > > On Tue, 3 Sep 2024 11:17:24 -0500
> > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > =C2=A0  =20
> > > > > On 9/3/24 3:34 AM, Angelo Dureghello wrote:=C2=A0  =20
> > > > > > Hi Jonathan and all,
> > > > > >=20
> > > > > >=20
> > > > > > On 31/08/24 1:38 PM, Jonathan Cameron wrote:=C2=A0=C2=A0=C2=A0 =
 =20
> > > > > > > On Thu, 29 Aug 2024 14:31:58 +0200
> > > > > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > Hi, asking for comments for this patchset, that is mostly
> > > > > > > > ready, at least feature-complete and functionally tested.
> > > > > > > >=20
> > > > > > > > I am introducing ad3552r-axi variant, controlled from a fpg=
a-based
> > > > > > > > AXI IP, as a platform driver, using the DAC backend. The pa=
tchset
> > > > > > > > is
> > > > > > > > actually based on linux-iio, since some needed DAC backend
> > > > > > > > features
> > > > > > > > was already there on that repo only, still to be merged in
> > > > > > > > mainline.
> > > > > > > >=20
> > > > > > > > Comments i would like to ask are:
> > > > > > > >=20
> > > > > > > > - i added some devicetree bindings inside current ad3552r y=
aml,
> > > > > > > > =C2=A0=C2=A0 device is the same, so i wouldn't create a dif=
ferent yaml
> > > > > > > > file.=C2=A0=C2=A0=C2=A0  =20
> > > > > > > Agreed. If same device, it's usually better to keep it in one=
 file.
> > > > > > > =C2=A0=C2=A0  =20
> > > > > > > > - if it's ok adding the bus-type property in the DAC backen=
d:
> > > > > > > > =C2=A0=C2=A0 actually, this platform driver uses a 4 lanes =
parallel bus,
> > > > > > > > plus
> > > > > > > > =C2=A0=C2=A0 a clock line, similar to a qspi. This to read =
an write
> > > > > > > > registers
> > > > > > > > =C2=A0=C2=A0 and as well to send samples at double data rat=
e. Other DAC may
> > > > > > > > =C2=A0=C2=A0 need "parallel" or "lvds" in the future.=C2=A0=
=C2=A0=C2=A0  =20
> > > > > > > If it is for register read + write as well, sounds to me like=
 you
> > > > > > > need
> > > > > > > to treat this as a new bus type, possibly then combined with a
> > > > > > > backend, or something similar to spi offload?
> > > > > > >=20
> > > > > > > What bus does this currently sit on in your DT bindings?
> > > > > > > (add an example)=C2=A0=C2=A0=C2=A0  =20
> > > > > >=20
> > > > > >=20
> > > > > > &amba {
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0ref_clk: clk@44B00000 {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-c=
lkgen-2.00.a";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44B00000 0x100=
00>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #clock-cells =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>, <&=
clkc 15>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "s_axi_ac=
lk", "clkin1";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clock-output-names =3D "r=
ef_clk";
> > > > > > =C2=A0=C2=A0 =C2=A0};
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0dac_tx_dma: dma-controller@0x44a30000 {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-d=
mac-1.00.a";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a30000 0x100=
00>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #dma-cells =3D <1>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupt-parent =3D <&in=
tc>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <0 57 IRQ_=
TYPE_LEVEL_HIGH>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&clkc 15>;
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 adi,channels {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #size-=
cells =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 #addre=
ss-cells =3D <1>;
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-ch=
annel@0 {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 reg =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,source-bus-width =3D <32>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,source-bus-type =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,destination-bus-width =3D <32>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 adi,destination-bus-type =3D <1>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0 =C2=A0};
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0backend: controller@44a70000 {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi-d=
ac-9.1.b";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x100=
0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 bus-type =3D <1>;=C2=A0 /=
* IIO QSPI */
> > > > > > =C2=A0=C2=A0 =C2=A0};
> > > > > >=20
> > > > > > =C2=A0=C2=A0 =C2=A0axi-ad3552r {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad355=
2r";
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 9=
2 GPIO_ACTIVE_LOW>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 io-backends =3D <&backend=
>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 channel@0 {
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 reg =
=3D <0>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 adi,ou=
tput-range-microvolt =3D <(-10000000) (10000000)>;
> > > > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > =C2=A0=C2=A0 =C2=A0};=C2=A0=C2=A0=C2=A0  =20
> > > > >=20
> > > > > Shouldn't the axi-ad3552r node be one level higher since it isn't
> > > > > a memory-mapped device, but rather an external chip?=C2=A0  =20
> > > > Definitely not where it currently is..=C2=A0  =20
> > > > >=20
> > > > > But based on the other feedback we got in this series and some
> > > > > #devicetree IRC chat here is an alternate binding suggestion we
> > > > > could consider.
> > > > >=20
> > > > > First, even though the FPGA IP block for use with AD3225R uses
> > > > > the same register map as the AXI DAC IP block, some of the
> > > > > registers behave differently, so it makes sense to have a
> > > > > different compatible string rather than using the bus-type
> > > > > property to tell the difference between the two IP blocks.
> > > > > There are likely more differences than just the bus type.=C2=A0  =
=20
> > > >=20
> > > > I'd be amazed if they managed to keep things that similar
> > > > given totally different buses.
> > > > =C2=A0  =20
> > >=20
> > > Yeah, I was trying to avoid new compatibles as much as I can because =
things
> > > can
> > > get pretty confusing (with lots of new compatibles and quirks) pretty
> > > quickly.
> > > Typically yes, most designs have slight differences between them (wit=
h new
> > > features and so on) but so far I was trying (thinking) to have those =
as a
> > > generic new backend op (plus a matching binding property if needed). =
For
> > > this
> > > particular case, I'm fairly sure we could get away with the bus contr=
oller
> > > property and having different implementations depending on the bus be=
ing
> > > implemented. For the other bits that might differ between designs (eg=
: DDR
> > > support) is up to frontends to call it or not (depending on they havi=
ng that
> > > feature or not).  =20
> >=20
> > That breaks down if the backend you happen to be using (maybe a new
> > one hasn't been written yet) is missing the DDR feature but the front e=
nd
> > device can run with or without it.
> > Unless the hardware makes this discoverable you'll have the backend dri=
ver
> > writing some enable bit that does nothing.
> >=20
> > Maybe it's a case of using fallback compatibles - so define more specif=
ic
> > ones but with a fallback to one that doesn't provide the fancy features
> > and only covers thins all IPs support.
> >  =20
> > > Naturally we need that the IPs having DDR support to not have
> > > the same thing supported in different registers but we do control tha=
t since
> > > these are FPGA cores.
> > >=20
> > > All the above said, I'm fine with new compatibles but we need to draw=
 a line
> > > when we add new ones. If the reasoning is the IP has some new bits or=
 new
> > > registers, then things can get very confusing (even more if we think =
about
> > > fallback compatibles) as most of the new designs have some quirks (ev=
en if
> > > minimal). So I would say to add new compatibles when things get diffe=
rent
> > > enough
> > > that a sane/generic API is not doable. =20
> >=20
> > If you can influence the IP designers, the usual solution to this is
> > discoverability of features. So standard register that all IP carries t=
hat
> > has flags for each feature that has ever been implemented.
> >  =20
>=20
> That get's messy. We do have some flags for some of the more generic feat=
ures
> (I'm using them in the backends when available). But we have (and will ha=
ve) so
> many variations of these designs that it get's hard to get it right all t=
he
> time. And for thing like this bus quirk a flag itself may be not enough to
> distinguish between different implementations...
>=20
> Last time I spoke with the designers, they are thinking about just adding=
 a set
> of custom registers that (always the same range I think) for these IPs an=
d then
> leave it up to the driver implementation to deal with the different
> implementations of the registers. Not sure if it's the best approach but =
it
> feels like they're getting tired of dealing with all the subtle changes b=
etween
> the different devices these IPs connect too :)
>=20
> On the IIO backend "world", frontends are the ones with the knowledge of =
what
> these custom registers could implement and so, it's very doable for backe=
nds to
> export a range of valid registers for frontends to "directly" (of course =
not
> reading/writing directly :)) access. Feels a bit hacky but also a bit
> reasonable... Anyways, all of the above is still just speculation so not =
sure if
> it will happen at all. Just some ramblings from me :)
>=20
>=20
> > If not, best option is each IP gets a compatible but we assume fallbacks
> > are fine until they aren't.
> >  =20
>=20
> Yeah, Conor made some compelling arguments about using new compatibles. At
> least, for the more complicated cases like this.
Agreed. With explanation above, we would still want the backends
to be able to protect against a front end asking for things they don't
support.  Might not need to do that all the time, but if we don't
have a compatible to deal with incompatibilities we won't be able to
fix it when problems occur.

Old IP, newer driver would be the likely nasty case though other
way around is possible too (new IP, old driver)

Jonathan

>=20
> - Nuno S=C3=A1


