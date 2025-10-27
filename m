Return-Path: <linux-iio+bounces-25495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A96C0ED51
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82704632BE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5E309DDB;
	Mon, 27 Oct 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC34aBx+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB32C08B2;
	Mon, 27 Oct 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577303; cv=none; b=d9mNLgrPnR4N7e3Jdv+ETT/QVa7q1Rwel2h0oNoMWC8g83tEnBMkO0iYRdCoejGA1p8EDy4cFesRTiN3WCFLP1jXdPRPJurVP4P+cCTiDlToxVED5Lf9+63/3lKyi1jTALNJvlcWf+hgB8cjaZE9jRIN/nQcahL9TVZmDnfyRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577303; c=relaxed/simple;
	bh=XFlNwp1fOvUuFjxA+eajEGJRyfmsUFhUCbXE0Kg2oNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZhQmEWx3Nmce0RK8MnAROHbCDGCpa843AAOKH1TzWVV2ncTIllv8RChDwDP719fzSoI2eTOxx7TAUm6zjvZLx956bVHbswzOrkSaWbUxMgCiE8AO0+mvyTfYztq1gANj/9dFKy2l9R9iHIbF0b4jftcKlCssuAGCK26y+JzKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC34aBx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B92C4CEF1;
	Mon, 27 Oct 2025 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577302;
	bh=XFlNwp1fOvUuFjxA+eajEGJRyfmsUFhUCbXE0Kg2oNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tC34aBx+LTDJv+caoIEAgf0yMH6Qv0uPVjri6HMbVCixro3laiZG4m3tdY7rniBj1
	 deSJbR2DOTFQ2UVi6H4Ptq2MGXsisXRbWI6ck8EmQngw5VNTRT9Lf+F66VNsiOg0x5
	 HAiKR5YLsw8wPnryewetE+eXfiWYUImnHsz71WNww1VfU5AhdgFAGwc4o8+qtJi6bX
	 YpIqc7BSo6eXi5sAzF4E8PzZHzwrdv/oh15yc+v31jfqYG3CJ0/6cQSyFqtxXt3xPC
	 EPrNOixVcCPms2vUPzJkelnXV0YcJYnH+QibzStvq0xN6E6x4EusJGeNkKq/gSNo9B
	 fJIV99fl6P2Qg==
Date: Mon, 27 Oct 2025 15:01:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko  <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski  <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251027150136.6cfd3774@jic23-huawei>
In-Reply-To: <ffb2512aad9bec33b0fe27035f88e79636362645.camel@gmail.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
	<20251023180831.000026ca@huawei.com>
	<ffb2512aad9bec33b0fe27035f88e79636362645.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 14:48:50 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-10-23 at 18:08 +0100, Jonathan Cameron wrote:
> > On Thu, 23 Oct 2025 14:01:37 +0300
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > Add device tree binding documentation for the Analog Devices AD5446
> > > family of Digital-to-Analog Converters and compatible devices from
> > > Texas Instruments. There's both SPI and I2C interfaces and feature
> > > resolutions ranging from 8-bit to 16-bit.
> > >=20
> > > The binding covers 29 compatible devices including the AD5446 series,
> > > AD5600 series, AD5620/5640/5660 variants with different voltage range=
s,
> > > and TI DAC081s101/DAC101s101/DAC121s101 devices.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > Hi Nuno,
> >=20
> > Thanks for filling in this missing doc.=C2=A0 I wonder what else is old
> > enough that we still don't have docs? Guess I should check when
> > I'm next bored enough (so that's not happening any time soon ;) =20
>=20
> Yeah, wouldn't be surprised if there's some more ADI old stuff hanging ar=
ound.
> This caught my attention since I saw that out of tree patch adding suppor=
t for a
> new device (with no real reason for not being in tree).
>=20
> >  =20
> > > ---
> > > =C2=A0.../devicetree/bindings/iio/dac/adi,ad5446.yaml=C2=A0=C2=A0=C2=
=A0 | 138
> > > +++++++++++++++++++++
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > > =C2=A02 files changed, 146 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > new file mode 100644
> > > index 000000000000..90fc8ca053fe
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > @@ -0,0 +1,138 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD5446 and similar DACs
> > > +
> > > +maintainers:
> > > +=C2=A0 - Michael Hennerich <michael.hennerich@analog.com>
> > > +=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > +
> > > +description: | =20
> >=20
> > Trivial but don't need the | as hardly matters if these get formatted
> > differently. =20
>=20
> Sure.
>=20
> >  =20
> > > +=C2=A0 Digital to Analog Converter devices supporting both SPI and I=
2C
> > > interfaces.
> > > +=C2=A0 These devices feature a range of resolutions from 8-bit to 16=
-bit. =20
> >=20
> > ...
> >  =20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 940889b158eb..dae04c308975 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
> > > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > > =C2=A0F:	drivers/regulator/ad5398.c
> > > =C2=A0
> > > +AD5456	DAC DRIVER =20
> > Tab seems odd here.=20
> >=20
> > Hmm. For a lot of ADI drivers we have entries that would look like
> > ANALOG DEVICES INC AD5456 DAC DRIVER
> >=20
> > Any reason for formatting it like this? =20
>=20
> Ok, time to come clean :)
>=20
> Bindings were AI generated and then I just cleaned the obvious problems (=
clearly
> I did not payed too much attention to the boilerplate stuff - lesson lear=
ned).

I'd hold off on doing anything much with AI on kernel code for now.
A clear policy might come out of the maintainers summit in December.
If you are curious, various threads on: https://lore.kernel.org/ksummit/

DT bindings get picked up by various projects so they may have their own
policy long run.

J

>=20
> - Nuno S=C3=A1
>=20
> >  =20
> > > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > > +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Supported
> > > +W:	https://ez.analog.com/linux-software-drivers
> > > +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > +
> > > =C2=A0AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
> > > =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> > > =C2=A0S:	Supported
> > >  =20


