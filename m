Return-Path: <linux-iio+bounces-17407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B4A76356
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A01887140
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E81DDC1D;
	Mon, 31 Mar 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzIlymMo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890F1CEEBB;
	Mon, 31 Mar 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414086; cv=none; b=StGa+8IiZbOuZGEwZfaMBFV38OM8/+KXvKlkPzcbbto3ZTcYEjik5m+DMcF94COBnnUG++uX5xN/IqT8BEOXiF06aSwX7XM/FLwE2k81BdsRKiBqBbk84iGvDcXaj4ERSbLdEqxwOSQVAw1beTRET4XnFLIAmlb8IXkPLF71bUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414086; c=relaxed/simple;
	bh=KbEDbIcQklJUKKH/MxYalG9NKt5nl3VutILG7n2p7UY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP1dHCCIvzsdGoCvwYqllt2xQZNX4NsSMVMjOj+C+3oQe1beoPdPho52HVwhS0mS4XNQv149r/p2TRU/c1EKUISsKLDByCsSneR0xxlXuQ01ThiVQsKh6db3SJGKM+xB3G8sm9p1wUeo3AGWq5bqtE1UeCHMThRORTmtjR8iD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzIlymMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F3C4CEE3;
	Mon, 31 Mar 2025 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743414086;
	bh=KbEDbIcQklJUKKH/MxYalG9NKt5nl3VutILG7n2p7UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzIlymMoSptu07gQSwU7uQwOsalKqOFb+diY9gnfk3y6NMTQu8y+U1zqCpftJZ5D/
	 wl3AhUDj9Wv+JTvUuYjJa/NsxfA0aIXoagO36v4AtG8rwgIy+SWuvta34hfBRpMdJz
	 YAXI5ssnS7P7QYHI7Ln4tCnCVEaRQTr0rt5Cd+FU8a6R9zI1pYW5gJkJ0BMOPAR33B
	 LhNpFEU93xIHmrS6nwvKDHJlT7MrCh9MS9UV3pgaREwin5R3SNRxqVp4e+ArJauYz/
	 9friea+GxAd0GgDcOI1XvG+Pk2wsVv4TCywcbmbhKE3bJB1pAfqjHwhZIIaNV4Gyv+
	 cC9EwiD6WZmHg==
Date: Mon, 31 Mar 2025 10:41:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Message-ID: <20250331104116.7ef8a467@jic23-huawei>
In-Reply-To: <PH0PR03MB71417CFD279F01382D025848F9AD2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-3-f211d781923e@analog.com>
	<20250328090341.0d213f3d@jic23-huawei>
	<PH0PR03MB71417CFD279F01382D025848F9AD2@PH0PR03MB7141.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 01:31:10 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Friday, March 28, 2025 5:04 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; lin=
ux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kern=
el.org
> > Subject: Re: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
> >=20
> > [External]
> >=20
> > On Mon, 24 Mar 2025 19:22:57 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >  =20
> > > Document the AD3530R/AD3530, an 8-Channel, 16-bit Voltage Output DAC,
> > > while the AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC.
> > > These devices include software-programmable gain controls that provide
> > > full-scale output spans of 2.5V or 5V for reference voltages of 2.5V.
> > > They operate from a single supply voltage range of 2.7V to 5.5V and a=
re
> > > guaranteed to be monotonic by design. Additionally, these devices
> > > features a 2.5V, 5ppm/=C2=B0C internal reference, which is disabled b=
y default.
> > >
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > >  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 91 =20
> > ++++++++++++++++++++++ =20
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 92 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.ya=
ml =20
> > b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml =20
> > > new file mode 100644
> > > index =20
> > 0000000000000000000000000000000000000000..e581472b50048bedda742
> > 2748035423b9b020382 =20
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> > > @@ -0,0 +1,91 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: =20
> > https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/adi,a=
d353
> > 0r.yaml*__;Iw!!A3Ni8CS0y2Y!-bEqh-bKz-a-
> > ZzfbJZwXi9KWwKlsk_Pcaj5XQLeLaDBpO8MaryRedRHaL0GUFfNz35tDsFaJkV45P
> > fyEzA$ =20
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta- =20
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!-bEqh-bKz-a-
> > ZzfbJZwXi9KWwKlsk_Pcaj5XQLeLaDBpO8MaryRedRHaL0GUFfNz35tDsFaJkV5zI4
> > zMaQ$ =20
> > > +
> > > +title: Analog Devices AD3530R and Similar DACs
> > > +
> > > +maintainers:
> > > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > > +
> > > +description: |
> > > +  The AD3530/AD3530R are low power, 8-channel, 16-bit, buffered volt=
age =20
> > output, =20
> > > +  digital-to-analog converters (DACs) that include software-programm=
able =20
> > gain =20
> > > +  controls that result in full-scale output spans of 2.5V or 5V for =
reference
> > > +  voltages of 2.5V. The devices operate from single, 2.7V to 5.5V su=
pply =20
> > ranges =20
> > > +  and are guaranteed monotonic by design. The AD3530R also offers a =
2.5V,
> > > +  5ppm/=C2=B0C internal reference that is disabled by default.
> > > +  Datasheet can be found here:
> > > +  https://www.analog.com/media/en/technical-documentation/data- =20
> > sheets/ad3530_ad530r.pdf =20
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad3530r =20
> >=20
> > You mention this one as well as a variant without the r postfix in the
> > 'description'.
> > So why not compatible for that?  If it's software compatible with the r=
 version
> > than
> > a fallback compatible makes sense.  We probably still want to have sepa=
rate
> > compatibles though in case we get an errata that only applies to one of=
 them.
> >=20
> > If they are the same silicon, perhaps with different ratings then make =
that clear
> > in the description and perhaps it is fine to not have both compatibles =
listed. =20
>=20
> The main difference is that the r variant supports both internal and exte=
rnal references,
> while the non-r variant supports only external references. I agree with h=
aving separate
> compatibles. Well, I'm thinking of adding a parameter in chip_info into t=
he driver to
> identify internal reference support. What do you think?
Yes, combination of separate compatibles and a parameter in chip_info to ma=
ke the
code simple sounds like the right solution to me.

Jonathan

>=20
> >  =20
> > > +      - adi,ad3531r =20
> >=20
> > This isn't mentioned in the description text.
> >  =20
> > > +
> > > +  reg:
> > > +    maxItems: 1 =20
> >=20
> > Thanks,
> >=20
> > Jonathan =20


