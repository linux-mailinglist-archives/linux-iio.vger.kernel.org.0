Return-Path: <linux-iio+bounces-12111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5119C3921
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C954B21823
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D430155741;
	Mon, 11 Nov 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOl3SnRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C02B67F;
	Mon, 11 Nov 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311144; cv=none; b=hyEOO5Id8yMxD8ZeRS13lJXElJb6MgCe5qi7kJfg1WW3bMuDf8e1B0pzRF5FI9RvBFgsKmmtKvCpjLPMc+5cJnD/l2JHAXkPtbWYJY3dfu82Rt4HnKy4aJjGzVoh5J9ztRbcGPb+JPkHrmGZ8lcq6xGLJhdGHYhZSs1cXwZ1Lxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311144; c=relaxed/simple;
	bh=HSHjlJQZFGGqSbgGh5jrRl7Y3YvM28pedTin90gBhtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s030gLUmLkuG9qwmjpY/T4x0wDM+oSEeeA/wrWIgs5JI3wI1OzSHXeFasgZQpLbtXzLXP0dECOsautDMHAMTawWdR39QJLBISyEer0n8JqiopzaoBNlZtHRbKbGk81snYaKT/k9LXz2zPIRY4kGSCAqsrZi3sPzBL5q2Fyolz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOl3SnRk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a4031f69fso711432066b.0;
        Sun, 10 Nov 2024 23:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731311140; x=1731915940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlYEoLWgXvf50waTFfyvkqu6l2VBpvmR0XQbzw8Cmd8=;
        b=lOl3SnRkPgPyFggWqkVMMTGmJpMbTdYlmssEE8Q4XWBb58ADS0CFMnSZWBauZlZdcG
         Slh70Y8uNRBiSXZ+W32f6s8uNLyoOZ919xWVcUyABN6HfThG2vh/Jd0ersXm/v2uH4XP
         yBXRcC6iMdV7Pr5bGrUpqKX05Ug8uRe35tyej2oIy5D6zip1DPaJ+RAgjodXhyMYk6AO
         kK7JRYiMD7eivA92f/WMzbsNcXsJsb87e5UEP7+6kT/Z660maDdWDGqO4G1JREwoj3Fj
         bnzl0CtFDweVHhdmb1VWwLGKe8/P0sMRG15uSRpTHMve362xl12lomT/ZAvpDVDpULCE
         fqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731311140; x=1731915940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlYEoLWgXvf50waTFfyvkqu6l2VBpvmR0XQbzw8Cmd8=;
        b=dN454pGZVe+bNsPDOvM9QlpNNoMs68YHShU/N9IfpmeNXQkDR4DUlP3IstZFtoddO3
         v1zcZkBJAJbe2gcTPBY8yFt9I9OA2N5JxiQaAcMdzIuJBuT/Tb8042iDafSKaud8UeZN
         1g6dyRynfShPj/4isaxrSKdNk5iqyQH5XE2nTETC3ZZR3cY3wtdiQRLjwu+fustrCwpi
         W5iwJ1VJOeSFTWyophmeHlQhkBxzpCs0Duj8qmt7O/2w75uEjxEDdcSy/AT/UPmSBxcg
         gyRsJXLZOp6eRVcOtbHh12jILBoNGVR24a6JG9aj0zSOkS8U32s44Rf8Vf8bLk6NTmlW
         KJSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSHCoYuDjTK3+RcgnObrW1DkVQJ/82NoQO6dJcBbluU5KCFD+cT2IzuIa8AaKPFHcSiVz4LdzETci9@vger.kernel.org, AJvYcCXeUaLzD0n0WxJnz8UGnCHJR7IBmcnnTFpThKebMxCDCyDIGmETLKLyU5suMvBOBkvejKyXZv+Zhu3ZopOB@vger.kernel.org, AJvYcCXtvZgvDm+8u9eL+RF+71K02MMFNli/MFG0K73ufBd9PMAhFqBi68o0tL6NzDv6J+z7njETszfHTqrD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyux+Ls2Hwrcei8W6J9J7HFyT5Ay6j5xCWz9GheiMIIKa21upn7
	8n7V0M6HR37r+KdtjvXqRUnPNY8+Wv27vdRmfnVrqvQncj5dbeacKU6Vj0O4UNFDQDVUiQN3mw7
	AOvI+neZPorC+4f/70uEUI3ZTo+M=
X-Google-Smtp-Source: AGHT+IH0KLR+0s7nW02uC0eKWTUgxxMYz1DzkxED3149OYbLx/SStp/Kw6ce/5yR+YmhbYjwOTnDum2ZPJHSCyvFgkY=
X-Received: by 2002:a17:907:25c2:b0:a99:ecaf:4543 with SMTP id
 a640c23a62f3a-a9eeff41732mr1209496866b.25.1731311140145; Sun, 10 Nov 2024
 23:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
 <CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
 <20241109134228.4359d803@jic23-huawei> <20241109142943.3d960742@jic23-huawei>
In-Reply-To: <20241109142943.3d960742@jic23-huawei>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 11 Nov 2024 15:45:03 +0800
Message-ID: <CA+4VgcJ=8wDWWnmgEt-UkEUfnfD8kGtHe44G5+dcRYt=KdwNfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, avifishman70@gmail.com, 
	tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, benjaminfair@google.com, lars@metafoo.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, andy@kernel.org, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, marius.cristea@microchip.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan Cameron,

For property read-vin-data-size, we have a internal discussion.

For Nuvoton NCT7201/NCT7202 chip,
Take an example as to Vin1:
The VIN reading supports Byte read (One Byte) and Word read (Two Byte)

For Byte read:
First read Index 00h to get VIN1 MSB, then read Index 0Fh Bit 3~7 to
get VIN1 LSB.
Index 0Fh is a shared LSB for all VINs.

For Word read:
Read Index 00h and get 2 Byte (VIN1 MSB and VIN1 LSB).

We would refer your suggestion,
we  declare a property named "nvuoton,read-vin-data-size" with default valu=
e 16
for user to use.

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Sat, 9 Nov 2024 13:42:28 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Wed, 6 Nov 2024 17:22:35 +0800
> > Yu-Hsian Yang <j2anfernee@gmail.com> wrote:
> >
> > > Dear Chanh Nguyen,
> > >
> > > Thank you for your response.
> > >
> > > Chanh Nguyen <chanh@amperemail.onmicrosoft.com> =E6=96=BC 2024=E5=B9=
=B411=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:58=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > >
> > > >
> > > >
> > > > On 06/11/2024 09:39, Eason Yang wrote:
> > > > > This adds a binding specification for the Nuvoton NCT7201/NCT7202
> > > > > family of ADCs.
> > > > >
> > > > > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > > > > ---
> > > > >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++++++=
+++++++
> > > > >   MAINTAINERS                                   |  1 +
> > > > >   2 files changed, 48 insertions(+)
> > > > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nu=
voton,nct720x.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nc=
t720x.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..3052039af10e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.y=
aml
> > > > > @@ -0,0 +1,47 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Nuvoton nct7202 and similar ADCs
> > > > > +
> > > > > +maintainers:
> > > > > +  - Eason Yang <yhyang2@nuvoton.com>
> > > > > +
> > > > > +description: |
> > > > > +   Family of ADCs with i2c interface.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - nuvoton,nct7201
> > > > > +      - nuvoton,nct7202
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  read-vin-data-size:
> > > >
> > > > Is it generic property or vendor property? I tried to find in the
> > > > https://github.com/torvalds/linux/tree/master/Documentation/devicet=
ree/bindings
> > > > , but it seems this property hasn't been used on other devices.
> > > >
> > > > If it is vendor property, then I think it should include a vendor
> > > > prefix. For examples:
> > > >
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/adi%2Cad7780.yaml#L50
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/st%2Cstmpe-adc.yaml#L22
> > > >
> > > >
> > >
> > > I would add a vendor prefix for it.
> >
> > Why do we want this at all?  Is this device sufficiently high
> > performance that Linux will ever want to trade of resolution against
> > sampling speed?
> >
> > If so that seems like a policy control that belongs in userspace. Note
> > that to support that in IIO I would want a strong justification for why=
 we dno't
> > just set it to 16 always. We just go for maximum resolution in the vast=
 majority
> > of drivers that support control of this.
> I'd misunderstood what this is. It's a control no what the i2c word size =
is.
> Do we actually care about supporting rubbish i2c controllers?  How many
> can't do a word access?
>
> If you do it should be detected from the controller rather than in DT.
>
> >
> >
> > >
> > > > > +    description: number of data bits per read vin
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [8, 16]
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - read-vin-data-size
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    i2c {
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <0>;
> > > > > +
> > > > > +        nct7202@1d {
> > > >
> > > > I think the Node name should follow
> > > > https://devicetree-specification.readthedocs.io/en/latest/chapter2-=
devicetree-basics.html#generic-names-recommendation
> > > >
> > > >
> > > > For some examples that were merged before
> > > >
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/adi%2Cad7091r5.yaml#L102
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/maxim%2Cmax1238.yaml#L73
> > > > https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/iio/adc/ti%2Cadc081c.yaml#L49
> > > >
> > >
> > > I would change it for the node naming.
> > >
> > > > > +            compatible =3D "nuvoton,nct7202";
> > > > > +            reg =3D <0x1d>;
> > > > > +            read-vin-data-size =3D <8>;
> > > > > +        };
> > > > > +    };
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 91d0609db61b..68570c58e7aa 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -2746,6 +2746,7 @@ L:      openbmc@lists.ozlabs.org (moderated=
 for non-subscribers)
> > > > >   S:  Supported
> > > > >   F:  Documentation/devicetree/bindings/*/*/*npcm*
> > > > >   F:  Documentation/devicetree/bindings/*/*npcm*
> > > > > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.y=
aml
> > > > >   F:  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> > > > >   F:  arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> > > > >   F:  arch/arm/mach-npcm/
> > > >
> >
> >
>

