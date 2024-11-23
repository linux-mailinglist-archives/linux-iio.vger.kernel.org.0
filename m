Return-Path: <linux-iio+bounces-12528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB29D697B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E14281C0F
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20A1F60A;
	Sat, 23 Nov 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVmMe+aY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F171195;
	Sat, 23 Nov 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732373281; cv=none; b=CXEyIxbEKwhVE6xcNaOBj9XKajZIijGelGdqzjzRtXLg7YrWz2vZEjl4tvS2APsE7m85IP2XoeqEofzoGDCa6lN6cxFPWjfNShzqnwHHHzkVoflyQEwIFbV7+DuNsadlug/c5lv+GSW1dpcy314QQeWP2uv4zdG2H26j44D7x3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732373281; c=relaxed/simple;
	bh=GX7YvZaT3/KO8mANa0y6U65yYYqqMMUzkhuc/FPkcKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb5i0den5RJ4XWRanhInf3TLVwbNjJdxs8ao2rzZj46we/uIME0ZVVkL/AoW6zckR4IxX6jesZwCN86qqVuUnTK3jsFRovYRm1NKK6NfUlDkTaTT8dUdBDbGqaiL8ii79qquP/kLeC2fKThMVHjmDoDR+UlXEMLBUqBVvY1qUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVmMe+aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D960C4CECD;
	Sat, 23 Nov 2024 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732373281;
	bh=GX7YvZaT3/KO8mANa0y6U65yYYqqMMUzkhuc/FPkcKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jVmMe+aYyAsPsljF2ajajb8lm7vuDc8/WySMMqeaCpAoEV2gxHm2N1VrCAeEKqaN6
	 8ZwuUwTdlte5vhLxHoChScNC4IV0ijAHGUKzlqEpigM3nPOmnJNBkLWbTdS/Ah9CXe
	 IHOFtNFtHQ70k1h0l4SXVjnUFpR/h8Or/ALQPTdKmRnE5x3IUGks/mJ3Vi3ZtA2ipo
	 flub/uuPnrblen6kvqp/qFLdms8rNvfz/t4cWudleSvcyfdTYqslLJT/856Q8B/xT7
	 FvVvAw25AQeUUa0zeHzV7jD7kmVxNgzrNkrVFY/oRDqKnO0eghKVp5KvproUacD8RP
	 Co/DVWyv+bA6g==
Date: Sat, 23 Nov 2024 14:47:50 +0000
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
Message-ID: <20241123144750.43eaa1c5@jic23-huawei>
In-Reply-To: <CA+4VgcJ=8wDWWnmgEt-UkEUfnfD8kGtHe44G5+dcRYt=KdwNfw@mail.gmail.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
	<20241106023916.440767-2-j2anfernee@gmail.com>
	<6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
	<CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
	<20241109134228.4359d803@jic23-huawei>
	<20241109142943.3d960742@jic23-huawei>
	<CA+4VgcJ=8wDWWnmgEt-UkEUfnfD8kGtHe44G5+dcRYt=KdwNfw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 15:45:03 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Jonathan Cameron,
>=20
> For property read-vin-data-size, we have a internal discussion.
>=20
> For Nuvoton NCT7201/NCT7202 chip,
> Take an example as to Vin1:
> The VIN reading supports Byte read (One Byte) and Word read (Two Byte)
>=20
> For Byte read:
> First read Index 00h to get VIN1 MSB, then read Index 0Fh Bit 3~7 to
> get VIN1 LSB.
> Index 0Fh is a shared LSB for all VINs.
>=20
> For Word read:
> Read Index 00h and get 2 Byte (VIN1 MSB and VIN1 LSB).
>=20
> We would refer your suggestion,
> we  declare a property named "nvuoton,read-vin-data-size" with default va=
lue 16
> for user to use.

Thanks for the info.  If the i2c controller allows word read
then the right thing is to always use it.

Just check for I2C_FUNC_SMBUS_READ_WORD_DATA with
i2c_check_functionality()

If it's supported use i2c_smbus_read_word_swapped()
if not, do the i2c_smbus_read_byte() approach.

We don't need to want this in DT as it is a property of the smbus
controller, not this device.

Jonathan




>=20
> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=889=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:29=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On Sat, 9 Nov 2024 13:42:28 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Wed, 6 Nov 2024 17:22:35 +0800
> > > Yu-Hsian Yang <j2anfernee@gmail.com> wrote:
> > > =20
> > > > Dear Chanh Nguyen,
> > > >
> > > > Thank you for your response.
> > > >
> > > > Chanh Nguyen <chanh@amperemail.onmicrosoft.com> =E6=96=BC 2024=E5=
=B9=B411=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:58=E5=
=AF=AB=E9=81=93=EF=BC=9A =20
> > > > >
> > > > >
> > > > >
> > > > > On 06/11/2024 09:39, Eason Yang wrote: =20
> > > > > > This adds a binding specification for the Nuvoton NCT7201/NCT72=
02
> > > > > > family of ADCs.
> > > > > >
> > > > > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > > > > > ---
> > > > > >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++++=
+++++++++
> > > > > >   MAINTAINERS                                   |  1 +
> > > > > >   2 files changed, 48 insertions(+)
> > > > > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/=
nuvoton,nct720x.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,=
nct720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.ya=
ml
> > > > > > new file mode 100644
> > > > > > index 000000000000..3052039af10e
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x=
.yaml
> > > > > > @@ -0,0 +1,47 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yam=
l#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Nuvoton nct7202 and similar ADCs
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Eason Yang <yhyang2@nuvoton.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +   Family of ADCs with i2c interface.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - nuvoton,nct7201
> > > > > > +      - nuvoton,nct7202
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  read-vin-data-size: =20
> > > > >
> > > > > Is it generic property or vendor property? I tried to find in the
> > > > > https://github.com/torvalds/linux/tree/master/Documentation/devic=
etree/bindings
> > > > > , but it seems this property hasn't been used on other devices.
> > > > >
> > > > > If it is vendor property, then I think it should include a vendor
> > > > > prefix. For examples:
> > > > >
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/adi%2Cad7780.yaml#L50
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/st%2Cstmpe-adc.yaml#L22
> > > > >
> > > > > =20
> > > >
> > > > I would add a vendor prefix for it. =20
> > >
> > > Why do we want this at all?  Is this device sufficiently high
> > > performance that Linux will ever want to trade of resolution against
> > > sampling speed?
> > >
> > > If so that seems like a policy control that belongs in userspace. Note
> > > that to support that in IIO I would want a strong justification for w=
hy we dno't
> > > just set it to 16 always. We just go for maximum resolution in the va=
st majority
> > > of drivers that support control of this. =20
> > I'd misunderstood what this is. It's a control no what the i2c word siz=
e is.
> > Do we actually care about supporting rubbish i2c controllers?  How many
> > can't do a word access?
> >
> > If you do it should be detected from the controller rather than in DT.
> > =20
> > >
> > > =20
> > > > =20
> > > > > > +    description: number of data bits per read vin
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +    enum: [8, 16]
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - reg
> > > > > > +  - read-vin-data-size
> > > > > > +
> > > > > > +additionalProperties: false
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    i2c {
> > > > > > +        #address-cells =3D <1>;
> > > > > > +        #size-cells =3D <0>;
> > > > > > +
> > > > > > +        nct7202@1d { =20
> > > > >
> > > > > I think the Node name should follow
> > > > > https://devicetree-specification.readthedocs.io/en/latest/chapter=
2-devicetree-basics.html#generic-names-recommendation
> > > > >
> > > > >
> > > > > For some examples that were merged before
> > > > >
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/adi%2Cad7091r5.yaml#L102
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/maxim%2Cmax1238.yaml#L73
> > > > > https://github.com/torvalds/linux/blob/master/Documentation/devic=
etree/bindings/iio/adc/ti%2Cadc081c.yaml#L49
> > > > > =20
> > > >
> > > > I would change it for the node naming.
> > > > =20
> > > > > > +            compatible =3D "nuvoton,nct7202";
> > > > > > +            reg =3D <0x1d>;
> > > > > > +            read-vin-data-size =3D <8>;
> > > > > > +        };
> > > > > > +    };
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 91d0609db61b..68570c58e7aa 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -2746,6 +2746,7 @@ L:      openbmc@lists.ozlabs.org (moderat=
ed for non-subscribers)
> > > > > >   S:  Supported
> > > > > >   F:  Documentation/devicetree/bindings/*/*/*npcm*
> > > > > >   F:  Documentation/devicetree/bindings/*/*npcm*
> > > > > > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x=
.yaml
> > > > > >   F:  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.ya=
ml
> > > > > >   F:  arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> > > > > >   F:  arch/arm/mach-npcm/ =20
> > > > > =20
> > >
> > > =20
> > =20


