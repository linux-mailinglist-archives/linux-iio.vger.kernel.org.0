Return-Path: <linux-iio+bounces-25805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05EC28EFC
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47F37347EBD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EA265296;
	Sun,  2 Nov 2025 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tI9FbkxA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA54A3C;
	Sun,  2 Nov 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085636; cv=none; b=Mwl7kuwSXPAX+GffxyPwwB9jpD1xzyv/kXDKEfkSbVJmMcdnyLBnQnTAJ7GWEO1u1+zQiapUms01ZqiU8YEwSiz2KJIBlG/LW0wK+RuP23ylnCL8t3UecrtZJ6GO/ZP0B351xbfBbgXcTj2udDDY4N79cUhUj2nuWjEVoWyNPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085636; c=relaxed/simple;
	bh=gJ9Gi3u5SrdQ0lj8khp8OmOLQpUTeBQv9G5hejIauVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugoKPYhuJ8bcw0FwvYuXg8A3CtnLJ9fMUdk+9XIV1my2SRhTupQbInkHxGbzkqsfwAUetNhI5AbW/AHLE2lvH4Qj+x8GsGfHn0ufClHzGQCNI4Fs1LKCDGSUYLazf33D5fTfCTURA0z219EBPGF7sejGAHRRl7qUDIWYLM1ZLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tI9FbkxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED40FC4CEF7;
	Sun,  2 Nov 2025 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762085635;
	bh=gJ9Gi3u5SrdQ0lj8khp8OmOLQpUTeBQv9G5hejIauVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tI9FbkxAwqQFaC1/jW5rC0SOpAbquiJGGTJhZ2Y2Yi/JWY8EEhhChoCkGewUs4yRa
	 +1yv6sREzZguipqWAwh9u7oppbNqOtAnj5oDPXUTXVhVdK5Y3daLaiC4nSlWYu5YrN
	 CzFh+FY6EU2zSKoLKUrgzaxNvBbrGfH+D+qt1gsdz5jA8d0xFHpIzI0U5oAtF1V0jQ
	 r9dYXgc98AEHstGQctjXWUcO1iVzAwl/ulFOlIJGW2uoOw+85LM4BvpVLuDyArNNci
	 hbuk5Cs2PZcBhpuwqbaIq71ve9QmATtsI8I+ndMrVZCyxdcZiKJ0j6X8V7QnwWqDMX
	 TOfvhUe8/xbsA==
Date: Sun, 2 Nov 2025 12:13:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251102121348.76dfad7c@jic23-huawei>
In-Reply-To: <1a95bd186bf1b5b3e2d3b3808069dba6649bafd1.camel@gmail.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
	<20251023180831.000026ca@huawei.com>
	<ffb2512aad9bec33b0fe27035f88e79636362645.camel@gmail.com>
	<20251027150136.6cfd3774@jic23-huawei>
	<1a95bd186bf1b5b3e2d3b3808069dba6649bafd1.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 11:30:55 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-10-27 at 15:01 +0000, Jonathan Cameron wrote:
> > On Mon, 27 Oct 2025 14:48:50 +0000
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Thu, 2025-10-23 at 18:08 +0100, Jonathan Cameron wrote: =20
> > > > On Thu, 23 Oct 2025 14:01:37 +0300
> > > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > > =C2=A0  =20
> > > > > Add device tree binding documentation for the Analog Devices AD54=
46
> > > > > family of Digital-to-Analog Converters and compatible devices from
> > > > > Texas Instruments. There's both SPI and I2C interfaces and feature
> > > > > resolutions ranging from 8-bit to 16-bit.
> > > > >=20
> > > > > The binding covers 29 compatible devices including the AD5446 ser=
ies,
> > > > > AD5600 series, AD5620/5640/5660 variants with different voltage r=
anges,
> > > > > and TI DAC081s101/DAC101s101/DAC121s101 devices.
> > > > >=20
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0  =20
> > > > Hi Nuno,
> > > >=20
> > > > Thanks for filling in this missing doc.=C2=A0 I wonder what else is=
 old
> > > > enough that we still don't have docs? Guess I should check when
> > > > I'm next bored enough (so that's not happening any time soon ;)=C2=
=A0  =20
> > >=20
> > > Yeah, wouldn't be surprised if there's some more ADI old stuff hangin=
g around.
> > > This caught my attention since I saw that out of tree patch adding su=
pport for a
> > > new device (with no real reason for not being in tree).
> > >  =20
> > > > =C2=A0  =20
> > > > > ---
> > > > > =C2=A0.../devicetree/bindings/iio/dac/adi,ad5446.yaml=C2=A0=C2=A0=
=C2=A0 | 138
> > > > > +++++++++++++++++++++
> > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > > > > =C2=A02 files changed, 146 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446=
.yaml
> > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..90fc8ca053fe
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > > @@ -0,0 +1,138 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Analog Devices AD5446 and similar DACs
> > > > > +
> > > > > +maintainers:
> > > > > +=C2=A0 - Michael Hennerich <michael.hennerich@analog.com>
> > > > > +=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > +
> > > > > +description: |=C2=A0  =20
> > > >=20
> > > > Trivial but don't need the | as hardly matters if these get formatt=
ed
> > > > differently.=C2=A0  =20
> > >=20
> > > Sure.
> > >  =20
> > > > =C2=A0  =20
> > > > > +=C2=A0 Digital to Analog Converter devices supporting both SPI a=
nd I2C
> > > > > interfaces.
> > > > > +=C2=A0 These devices feature a range of resolutions from 8-bit t=
o 16-bit.=C2=A0  =20
> > > >=20
> > > > ...
> > > > =C2=A0  =20
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 940889b158eb..dae04c308975 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
> > > > > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > > > > =C2=A0F:	drivers/regulator/ad5398.c
> > > > > =C2=A0
> > > > > +AD5456	DAC DRIVER=C2=A0  =20
> > > > Tab seems odd here.=20
> > > >=20
> > > > Hmm. For a lot of ADI drivers we have entries that would look like
> > > > ANALOG DEVICES INC AD5456 DAC DRIVER
> > > >=20
> > > > Any reason for formatting it like this?=C2=A0  =20
> > >=20
> > > Ok, time to come clean :)
> > >=20
> > > Bindings were AI generated and then I just cleaned the obvious proble=
ms (clearly
> > > I did not payed too much attention to the boilerplate stuff - lesson =
learned). =20
> >=20
> > I'd hold off on doing anything much with AI on kernel code for now.
> > A clear policy might come out of the maintainers summit in December.
> > If you are curious, various threads on: https://lore.kernel.org/ksummit=
/ =20
>=20
> Right, I did saw some threads regarding some patches being automatically =
sent
> (I think the AUTOSEL stuff for stable) by AI. Not completely the same her=
e as I still
> reviewed it and changed things (more like co-developed thing :)).
> =20
> >=20
> > DT bindings get picked up by various projects so they may have their own
> > policy long run.
> >  =20
>=20
> I see, it's kind of handy (for bindings not so complicated) as it can com=
e up with maybe
> 50/60% of the whole thing. But sure, I will refrain from using it until w=
e have a clear
> policy in place.
>=20
> BTW, writing covers and commit messages would be fine, right?

Yes - I've not seen anyone object to that and it is very helpful
in improving the readability of those.  As long as people closely check
the result!

>=20
> - Nuno S=C3=A1
>=20
> > J
> >  =20
> > >=20
> > > - Nuno S=C3=A1
> > >  =20
> > > > =C2=A0  =20
> > > > > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > > > > +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > +L:	linux-iio@vger.kernel.org
> > > > > +S:	Supported
> > > > > +W:	https://ez.analog.com/linux-software-drivers
> > > > > +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > > +
> > > > > =C2=A0AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
> > > > > =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> > > > > =C2=A0S:	Supported
> > > > > =C2=A0  =20


