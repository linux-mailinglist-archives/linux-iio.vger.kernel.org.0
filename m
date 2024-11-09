Return-Path: <linux-iio+bounces-12074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD99C2D97
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1557283050
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2741946A0;
	Sat,  9 Nov 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgfdn+OL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D6170A26;
	Sat,  9 Nov 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159761; cv=none; b=uUOj9tySshyeHv1Skd8zTE9XWn9flltG7dgt9IBdC7H/iSeKtPolI9YmeP0cIfIFjrU91LpWkYIgO5vj2PRWlR5GXaKTX2JA8RAYkIalXpuTiz/LCmC17dojyv9dXFFAjkScGF6t7nQ0UkdLk/sMjvcaDCBtO2roDGMSSWS7Gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159761; c=relaxed/simple;
	bh=t3t+ysfKKtXS17fLmXkD4LYR/AhPzUkC7huhFUxrLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWOFNkJPId+Yl+KuSDPLiuVwdv5JjyNKyIUE0lQRwohpwdL88CyBBEQ8P8vHbGDj6m1+ZOsVuvLQXFrsvcb9dsIXnizNihyCQToIbczSZZHa1S7hNMte7z9dIdEi88g/tv4svVE4tzYOgVN/QtS/+jokLbi1wChcIb5WnPcJPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgfdn+OL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26118C4CECE;
	Sat,  9 Nov 2024 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731159761;
	bh=t3t+ysfKKtXS17fLmXkD4LYR/AhPzUkC7huhFUxrLeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sgfdn+OLEx56qBN0CAsq6HQH0f+cpAppZT7lpAXOQ77nFEvYjVOMXXM4mLx0oAjG7
	 TNsIT/VFr5+hCUAuSunaNFD7cllDJS+a0uSWnQWd5I99A+FmruUaZfnql834zNpLGR
	 +awEbbDHSqWlLFHp/N6O3JQvV+4RcZ7wtKt7XATwSXC74jbWAFV8d3ksfStgGmId55
	 xLNxLw5luJurTUpk3u145dqgqF02K5UYM/D2J3ifHeD3Y2uY+mJtOOab/4R7ZHKbfi
	 f1FOCie9XDCypmAkzm7Z8xiCTsmCRgt+tEX4F121qp2rg47S9dsfhCKRZXWU6hneK7
	 AP2LJM0o9DGbw==
Date: Sat, 9 Nov 2024 13:42:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, avifishman70@gmail.com,
 tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andy@kernel.org, marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com,
 joao.goncalves@toradex.com, marius.cristea@microchip.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
Message-ID: <20241109134228.4359d803@jic23-huawei>
In-Reply-To: <CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
	<20241106023916.440767-2-j2anfernee@gmail.com>
	<6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
	<CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 17:22:35 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Chanh Nguyen,
>=20
> Thank you for your response.
>=20
> Chanh Nguyen <chanh@amperemail.onmicrosoft.com> =E6=96=BC 2024=E5=B9=B411=
=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:58=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> >
> >
> > On 06/11/2024 09:39, Eason Yang wrote: =20
> > > This adds a binding specification for the Nuvoton NCT7201/NCT7202
> > > family of ADCs.
> > >
> > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > > ---
> > >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++++++++++=
+++
> > >   MAINTAINERS                                   |  1 +
> > >   2 files changed, 48 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoto=
n,nct720x.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720=
x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > > new file mode 100644
> > > index 000000000000..3052039af10e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > > @@ -0,0 +1,47 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nuvoton nct7202 and similar ADCs
> > > +
> > > +maintainers:
> > > +  - Eason Yang <yhyang2@nuvoton.com>
> > > +
> > > +description: |
> > > +   Family of ADCs with i2c interface.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nuvoton,nct7201
> > > +      - nuvoton,nct7202
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  read-vin-data-size: =20
> >
> > Is it generic property or vendor property? I tried to find in the
> > https://github.com/torvalds/linux/tree/master/Documentation/devicetree/=
bindings
> > , but it seems this property hasn't been used on other devices.
> >
> > If it is vendor property, then I think it should include a vendor
> > prefix. For examples:
> >
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/adi%2Cad7780.yaml#L50
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/st%2Cstmpe-adc.yaml#L22
> >
> > =20
>=20
> I would add a vendor prefix for it.

Why do we want this at all?  Is this device sufficiently high
performance that Linux will ever want to trade of resolution against
sampling speed?

If so that seems like a policy control that belongs in userspace. Note
that to support that in IIO I would want a strong justification for why we =
dno't
just set it to 16 always. We just go for maximum resolution in the vast maj=
ority
of drivers that support control of this.


>=20
> > > +    description: number of data bits per read vin
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [8, 16]
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - read-vin-data-size
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        nct7202@1d { =20
> >
> > I think the Node name should follow
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devi=
cetree-basics.html#generic-names-recommendation
> >
> >
> > For some examples that were merged before
> >
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/adi%2Cad7091r5.yaml#L102
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/maxim%2Cmax1238.yaml#L73
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/iio/adc/ti%2Cadc081c.yaml#L49
> > =20
>=20
> I would change it for the node naming.
>=20
> > > +            compatible =3D "nuvoton,nct7202";
> > > +            reg =3D <0x1d>;
> > > +            read-vin-data-size =3D <8>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 91d0609db61b..68570c58e7aa 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2746,6 +2746,7 @@ L:      openbmc@lists.ozlabs.org (moderated for=
 non-subscribers)
> > >   S:  Supported
> > >   F:  Documentation/devicetree/bindings/*/*/*npcm*
> > >   F:  Documentation/devicetree/bindings/*/*npcm*
> > > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > >   F:  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> > >   F:  arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> > >   F:  arch/arm/mach-npcm/ =20
> > =20


