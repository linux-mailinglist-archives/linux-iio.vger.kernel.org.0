Return-Path: <linux-iio+bounces-11937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC579BE255
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F471F237AC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549681D9668;
	Wed,  6 Nov 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzAVVJLq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646D1D95A9;
	Wed,  6 Nov 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884996; cv=none; b=uencmvORk3uZCW3UEyOFORHsZvrmB4EFYroNSvYJVRxGRxj6G9hFv7QpLb7iSYebSdrMrHpWVwuXEEDUvvxUeFlNeBXHPKQvJWdiqqN0eLAFVWp38ceACmrKOpH9zTPOPs+zaj2KxKhjFQFEM95x5ZLlnvKDebUB6x0mWnDmM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884996; c=relaxed/simple;
	bh=nxrCpqfCp7YF5rQvcpcOOqUALKRgtWKx9p44sRekEsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhGoqlm0E8oVVPJ8ZaYxz13Sk0IQ+l6TL2IwiCV1xpHfC/tYXITH1c4bpvLpaUELE1080lZiQNJRQ10IIhpilQPxYFCBkQTa7Z8B5mY9NWdA45vAJ37Oh5GjrwAZuyaIndsPcxkTdUXY3HQu6Zk1Ma3iyaSsoAfFrRYezzFaxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzAVVJLq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so832117066b.0;
        Wed, 06 Nov 2024 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730884992; x=1731489792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRkks3dSyRy/clHnQcnjYlOdhUaiujCRFslbnDY6mJA=;
        b=VzAVVJLqJywk7hdR0a+cnNDq9GWnAuWAGh8o2ybLGXEhNNmTwGxJZr6MK8XefFbtVQ
         dQ84EEM2BdOuKSwY1955/M2fCUdp0341P2PGbUJbu7wZYinb4by5zVgKC5cUUcObTQG2
         ByC1AYj1rRF+3rott2+qqXVg7MeusT+dhcakgFos6OTNXtSQL+JzeQvsu5uCEtC97Zut
         nsc4ggthj1CdAjEXbI4antNUfGGGstfhaKG4Cjzis2SbVYHl7AsZI9JkS8mjWOHsw/LG
         PjzS5p218Tk79hXbAqZsJCPafzaK+aTspTKMabs1anoJ5t5f0MeeYkBq6G/B/Ln5H1Ds
         egCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884993; x=1731489793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRkks3dSyRy/clHnQcnjYlOdhUaiujCRFslbnDY6mJA=;
        b=PoSN8eqsvgxeon/nEAVa6+Xe1/UuhS5/Zdt3oIRPeSUYTfUNiEzktsx4PNFmSyM2+R
         T1r3nth944PsV3LgQk9wazbDO7vl3DvYa3Hcw1kSdzfB7hah4/sFTiWy8R3tbYH/+y6T
         cHUjoUbs/Cql1s/t7ldTMYs7APlvZFSDLyJL9zzPrMeCa6Jwo2uDwdwLmK4FA1Lgmda4
         iqWuPSEUxu8svZOsQXQgGcljenaPpbFqk5Tdqf82l4Gv59RCQWEkt8NwT5kptnDo/t/l
         wSV/0esQcqU6d5zJ0LtW42Oyc49bfCeKpyi+YDbxEEmbstgd801QiaYNbhrYogi0oPWG
         263g==
X-Forwarded-Encrypted: i=1; AJvYcCX3E5DA8Ji8rVGTjLOcurJwSjV2q2XR8pdbSCXaKf/4pcZtYVrNLVLYavXXWEWeZ/ttxAeYh60TU3eE@vger.kernel.org, AJvYcCXEIWIRxMnRdDaFc/TOtFZGTBZWrUQvpikdKrs+K5g/4vuFp01f1dySSxn1BxGRV+jRYznjvYZ+1+MZBiSB@vger.kernel.org, AJvYcCXFpHLjM/lfZeUWUOQoClBpjby3cYOREfALYYv7jcP4cL6ZhaIQH8tuoQgILXGo4c3AVdQ+K3nPGEMn@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJIxoHB7kYFCVSBfGNlSMW5kWiP9MyMl3X9iK2owF9WrDVv3J
	fc4ctIJ5wqWhAyhq/UM2i8O6wEJJ8YW9dviUpRGfELMnyjgLii6BoSMcK3MGnrSQb4T0gGTsKRx
	bc8YzPG79jzgKaGBlfzpU3e0GZuo=
X-Google-Smtp-Source: AGHT+IFv6NXCj0PoJ3/9MebXG7UMEvSLe5/XYsXv7IOXWlLpbZrwz5OF5MmA5IiWVO83xU2p+sYbWhvM35oxrlZEs5c=
X-Received: by 2002:a17:906:f34a:b0:a9e:c696:8f78 with SMTP id
 a640c23a62f3a-a9ec6969260mr153549166b.51.1730884992222; Wed, 06 Nov 2024
 01:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
In-Reply-To: <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Wed, 6 Nov 2024 17:22:35 +0800
Message-ID: <CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, joao.goncalves@toradex.com, 
	marius.cristea@microchip.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chanh Nguyen,

Thank you for your response.

Chanh Nguyen <chanh@amperemail.onmicrosoft.com> =E6=96=BC 2024=E5=B9=B411=
=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:58=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
>
>
> On 06/11/2024 09:39, Eason Yang wrote:
> > This adds a binding specification for the Nuvoton NCT7201/NCT7202
> > family of ADCs.
> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > ---
> >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 ++++++++++++++++++=
+
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 48 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,=
nct720x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.=
yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > new file mode 100644
> > index 000000000000..3052039af10e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton nct7202 and similar ADCs
> > +
> > +maintainers:
> > +  - Eason Yang <yhyang2@nuvoton.com>
> > +
> > +description: |
> > +   Family of ADCs with i2c interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7201
> > +      - nuvoton,nct7202
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  read-vin-data-size:
>
> Is it generic property or vendor property? I tried to find in the
> https://github.com/torvalds/linux/tree/master/Documentation/devicetree/bi=
ndings
> , but it seems this property hasn't been used on other devices.
>
> If it is vendor property, then I think it should include a vendor
> prefix. For examples:
>
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/adi%2Cad7780.yaml#L50
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/st%2Cstmpe-adc.yaml#L22
>
>

I would add a vendor prefix for it.

> > +    description: number of data bits per read vin
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [8, 16]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - read-vin-data-size
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        nct7202@1d {
>
> I think the Node name should follow
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>
>
> For some examples that were merged before
>
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/adi%2Cad7091r5.yaml#L102
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/maxim%2Cmax1238.yaml#L73
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/ti%2Cadc081c.yaml#L49
>

I would change it for the node naming.

> > +            compatible =3D "nuvoton,nct7202";
> > +            reg =3D <0x1d>;
> > +            read-vin-data-size =3D <8>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 91d0609db61b..68570c58e7aa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2746,6 +2746,7 @@ L:      openbmc@lists.ozlabs.org (moderated for n=
on-subscribers)
> >   S:  Supported
> >   F:  Documentation/devicetree/bindings/*/*/*npcm*
> >   F:  Documentation/devicetree/bindings/*/*npcm*
> > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> >   F:  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> >   F:  arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> >   F:  arch/arm/mach-npcm/
>

