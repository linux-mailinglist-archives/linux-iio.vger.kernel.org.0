Return-Path: <linux-iio+bounces-15945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87EA408F5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13DD7AC998
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6498915854A;
	Sat, 22 Feb 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/CXpAID"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAA14F9D6;
	Sat, 22 Feb 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234422; cv=none; b=Aa8MKzqzQ1Yk2HXhGJzi8JnTDhGxxLy+BUxwR3Z+9Mu/XtB1etEK//17XKen1RjACDWk6L9v5WwvVvT3vfRnno/JUVAWGnn+xbY3bL31+qm1O55hZayBPhWKlqOKuKl/ibC2zGyWWVwlcRCmMNOYyp5nBQ/t7xQu7Qx5NWxAb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234422; c=relaxed/simple;
	bh=EL+0y5KjTAzDfvmIH+Ri1DqZPpipQZAhhIpAMVIjN/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grsyKWJlfkNdGccMvWIHcQDJmWYpqA/KP8nmk2RfyH+TbT/ai/iaCsXA6FLiz6AOH6sa02HjduBgg6QkqU6pFRGEd5utCSSDQiy8ci/beSoKyzI5d2yWjBPXg4q7JqbgeVOc7oA5dwP86Hx6mn6pwrG8nOuzpY7XTWnHNSQ23xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/CXpAID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D36C4CED1;
	Sat, 22 Feb 2025 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740234421;
	bh=EL+0y5KjTAzDfvmIH+Ri1DqZPpipQZAhhIpAMVIjN/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/CXpAIDe2Z0vS74RVsT9F2geFff724n0SCs2rtxahtDlAbZOht4cEJdh2wu3cU8/
	 qJcXAL2eAdwhq/BymL2DCYOSPmfsXJI6zXHPFa8Rg9YLNigB/+lljwDxMe0f8Cp759
	 2LX4BBH9Wn4hsfolt33QTHlp8aojFGnhLooQiwX+sbGvio09m2gtYff8moOmMcqpkV
	 YTYVKJhaeaX/gEp6EeWrSArkx0h/r8ZzyAPd610voLJv19nFHV1ccJjwCkdjgU4t2e
	 fA2KLWCv1m+LdNtDTFH04XXVPsIrC/CsK0A5z5/z2O5g4BoS/PQSNhT0NPFv39UCxM
	 woHuREoKB3HRQ==
Date: Sat, 22 Feb 2025 14:26:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Message-ID: <20250222142650.63857ea8@jic23-huawei>
In-Reply-To: <CAPVz0n2wRu3X82nrnEac+XP+Q8uQMVwBLhGUaoqOLLf-V5dZfg@mail.gmail.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
	<20250218132702.114669-2-clamor95@gmail.com>
	<20250221203803.GA24813-robh@kernel.org>
	<CAPVz0n2wRu3X82nrnEac+XP+Q8uQMVwBLhGUaoqOLLf-V5dZfg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Feb 2025 09:01:18 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D1=82, 21 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:38 Ro=
b Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Feb 18, 2025 at 03:26:59PM +0200, Svyatoslav Ryhel wrote: =20
> > > Add bindings for the LM3533 - a complete power source for
> > > backlight, keypad, and indicator LEDs in smartphone handsets.
> > > The high-voltage inductive boost converter provides the
> > > power for two series LED strings display backlight and keypad
> > > functions.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++=
++
> > >  1 file changed, 231 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.y=
aml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/D=
ocumentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > > new file mode 100644
> > > index 000000000000..83542f0c7bf7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > > @@ -0,0 +1,231 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI LM3533 Complete Lighting Power Solution
> > > +
> > > +description: | =20
> >
> > Use '>' rather than '|' if only formatting is paragraphs.
> > =20
>=20
> yaml check did not complain, fine.

It can't tell whether you want it formatted exactly or if paragraphs
is enough.=20

>=20
> > > +  The LM3533 is a complete power source for backlight,
> > > +  keypad, and indicator LEDs in smartphone handsets. The
> > > +  high-voltage inductive boost converter provides the
> > > +  power for two series LED strings display backlight and
> > > +  keypad functions. =20
> >
> > Wrap lines at 80
> > =20
>=20
> Checkpatch and yaml check do not complain, why? 80 char limit was removed=
, no?

Check was to prevent over 80 chars, here you are far too short.




