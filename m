Return-Path: <linux-iio+bounces-15171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239CFA2D6EE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A8D1889EA8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79B2500AB;
	Sat,  8 Feb 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlIe/8c4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2213EFE3;
	Sat,  8 Feb 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029135; cv=none; b=LPhYhh5KF/As8xgAlglyKZzQV58oCikH96pOA/4Z1sUcmr+atTlewN5OAuK2eXTYrUgwNyjOMnvKyqKBmPJMlWcVd1maUCa7OitfT8lB788cNqqtq/uP35Dkz7uGc/4L7HCDyg8uOFC0YcCtscNE5SOwMRn44EcljNixKJWcCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029135; c=relaxed/simple;
	bh=XNM/6f1VoE8anSwil56NQFr75jRiQ8aJ2WPeJxzFQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJcTGcFJR/+2KO+h3B5gTnDJ9iryMlWGvM9s2peqB33Y8o7+Ggl2v9WGcjc7AVsND3VutS5fYowSSS4k8BwlOquLKrmqbV/eSYJFKaZAF1fxaswXSEK8Dkv0aCrcOsZHw+Ze05iZIspaJ1be2ExtC+cs00pPcWAsKlV8sJmrgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlIe/8c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA2C4CED6;
	Sat,  8 Feb 2025 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739029135;
	bh=XNM/6f1VoE8anSwil56NQFr75jRiQ8aJ2WPeJxzFQdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KlIe/8c4mq6aMpjIVAOTmKedtplOY/9X9GSlmYuu8nQ++AtOVSndQsBVwOWE5d/6T
	 vKk5rvmiPkpijNhNKt+YsO6K4RWOpo0Qf2nDCSNyrGn0AA2hBW6X2KYU6D3oi7Hl42
	 v75lBOCz4zfRffB4Xg7ATMBRgs9k2D/q+Vhk8aXwO2PFrt3PYmkw7rSToPiu8Gres1
	 tVq+HUkjBGzvWq2jINFGx3BMcFkwFev7A9lnH+3HJ/2EYK9i3aifLTQwhI+UQvSxip
	 y5LKBe5q2VxcyoRuJ4dnxmgENjAd3QqH2By+DKEBfeN+5xP94okIZV+ZPEgik5vYzy
	 t1YUgUzA9VyzQ==
Date: Sat, 8 Feb 2025 15:38:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Robert Budai
 <robert.budai@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Paul Cercueil <paul@crapouillou.net>, David
 Lechner <dlechner@baylibre.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250208153843.0353baa9@jic23-huawei>
In-Reply-To: <20250205-styling-chirpy-79eae9437b3b@spud>
References: <20250204143612.85939-1-robert.budai@analog.com>
	<20250204143612.85939-5-robert.budai@analog.com>
	<20250204-helium-marbled-a0863a0a18a8@spud>
	<15065d0cd19f39d92ce860cd03802c368df74b34.camel@gmail.com>
	<20250205-styling-chirpy-79eae9437b3b@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2025 19:52:37 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Feb 05, 2025 at 04:11:51PM +0000, Nuno S=C3=A1 wrote:
> > On Tue, 2025-02-04 at 19:25 +0000, Conor Dooley wrote: =20
> > > On Tue, Feb 04, 2025 at 04:36:08PM +0200, Robert Budai wrote: =20
> > > > Document the ADIS16550 device devicetree bindings.
> > > >=20
> > > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > > ---
> > > >=20
> > > > v6:
> > > > - applied blank line suggestions
> > > > - added clock-frequency dependency change suggestions
> > > > - yamllint corrections
> > > >=20
> > > > =C2=A0.../bindings/iio/imu/adi,adis16550.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 83 +++++++++++++++++++
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 ++
> > > > =C2=A02 files changed, 92 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis1655=
0.yaml
> > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > new file mode 100644
> > > > index 000000000000..8750bb937979
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > @@ -0,0 +1,83 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices ADIS16550 and similar IMUs
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > > > +=C2=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > +=C2=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > +
> > > > +properties:
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550
> > > > +
> > > > +=C2=A0 reg:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 spi-cpha: true
> > > > +=C2=A0 spi-cpol: true
> > > > +
> > > > +=C2=A0 spi-max-frequency:
> > > > +=C2=A0=C2=A0=C2=A0 maximum: 15000000
> > > > +
> > > > +=C2=A0 vdd-supply: true
> > > > +
> > > > +=C2=A0 interrupts:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 reset-gpios:
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be the device tree identifier =
of the RESET pin. If specified,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it will be asserted during driver p=
robe. As the line is active low,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it should be marked GPIO_ACTIVE_LOW.
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0 description: If not provided, then the internal=
 clock is used.
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 clock-frequency:
> > > > +=C2=A0=C2=A0=C2=A0 description: Clock frequency in Hz when an exte=
rnal clock is used.
> > > > +=C2=A0=C2=A0=C2=A0 oneOf:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 1
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 128
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 3000
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 4500 =20
> > >=20
> > > I don't get why this is a property, to be honest. When you've got an
> > > external clock, why isn't the frequency obtained from the clock provi=
der
> > > node?
> > >  =20
> >=20
> > The main purpose of this property is actually to show/document the cons=
trains of
> > the external clock. We can very well just error out in the driver (and =
we do
> > that) and not have this property. I mentioned this property to Robert s=
ome
> > revisions ago and I also pointed out that I wasn't really sure if it sh=
ould be
> > used or not=C2=A0(I guess this is more for fixed clock providers...). I=
IRC, I did
> > asked for some advice/comments but we got none so I assume Robert just =
decided
> > to use it and see what you guys had to say about it. =20
>=20
> NGL, this is one of the kinda of things where if you're relying on
> dt-bindings to avoid cocking up your board design, things have already
> gotten pretty badly wrong! That said, "clock-frequency" is a
> property for cpus, fixed-frequency clock providers and i2c buses, you'd
> need a vendor prefix and a unit suffix here IMO. Also, I don't really
> think that it actually does anything at all, given it does not constrain =
the
> clock you're linking to with the clocks property. This may as well just be
> a comment in the description of the clocks property, for all that it does.

I'd just drop it.=20

Jonathan



