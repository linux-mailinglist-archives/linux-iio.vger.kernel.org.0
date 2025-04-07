Return-Path: <linux-iio+bounces-17762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D9A7DFD5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16387175292
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D91A316D;
	Mon,  7 Apr 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuRnNh2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D189319D086;
	Mon,  7 Apr 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033341; cv=none; b=lxIix9pzGNOl+pZUSiNcQ3s90eqQDzu5Qsk3ErPMc+Nd5ggKJbj4yM3YbuNKWCzxlW8L4LZvsujMfB0LASpWavYTEHgwCK36Q4OMzWlwaao2YbXB3bXTQiA4CH72Ma6M7uuyibT/xlhcwN7V8xmZ2S2iCCNBd8whJXu8gGWmIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033341; c=relaxed/simple;
	bh=1r4Y1xGaIw6Z2bMc6PG2RocXTnsmf+k7C3olFVHVcc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY0DsVXAs7ijow9WwRXbzRTg1zElro4xmf6frsgRFGxlW28P2XmsAGACCutYZ3AbasFrVP1NWh+gOH+H3QclDOsnf8oqn/qVu2/C2pihbVp/ZK/hJT7qzPX/IMGL/ZAHJAb7N4HBqBRhtFchq+3j3lkPmwsCdyOZAaX5AkKcosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuRnNh2u; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso8363902a12.2;
        Mon, 07 Apr 2025 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744033338; x=1744638138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa6KU2wdxERyxbNkzxJOW0BR3XtH5OL92vINFtJKy6o=;
        b=MuRnNh2u9+QBx055fC9222qHYI6qmsrlbRzRBYvN/XHgpjZXRoslV/G2t1+SZ0DldY
         IPbKlCc/yPNWThOWSCDJ+r2tIYPLHzPjoC2JKg4xGdEU5VZQUwIaPFvSQSa7PLpxFV0v
         /xaSCBkmcyUbeOKbFGIVhFoX2c8dGVWbvhviVtXuGN0xh2WxLtahTD8QZyP8HprY8LU5
         Z37RGbnuO0AXTwyQRdl9YTUo4vKE8IRCaE/GCvdfd5UGQb7DRJiyMafzpw74pja3xAfv
         NWyxw93G7YGHgV3Y0ZHb7WufNs9Fixk+mVcplpkkpXaOE1xvJ6ku2PBwiERU1K4w3g7L
         9FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033338; x=1744638138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa6KU2wdxERyxbNkzxJOW0BR3XtH5OL92vINFtJKy6o=;
        b=Xq2RMhCh+SIVvrk9qfNDixufOmMNcKgdml0Qx2ar4klXfCK7v1OeO5MiU++rml2++s
         xNlnYbQ+OuqyWWv7++lgzQs6TZmHW7rJWpixHL+yu0VXvvLC6kJ47fu48/WVdGt9Hitb
         jgfl4IlCHQZ0g3dh/LOC1MdOhB1m9UsEsMTLCNvDYoyVdTLpCa3ZSCzYeL7jgtJ78cx2
         mHDP+KXUC9v/Zvh9VKArY35xB4PGa67gjULwYry/zchlAyNKNMU6aqDWO5iqKnNU2MVY
         1aeA5lleIeAcvGjWa+O2dv1t96qeOzB0GOUGhcMPwPUhO7lBCJpFTGKOp+fy6fSf73Ry
         /Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCUQHjwF6381twxu1+ZVSjmeEW2A8SS28Ga/uUidC8eqjRqlYT2Ar+Jo4qtrFszicrAKEX0XCspd7sBQ@vger.kernel.org, AJvYcCUy/enEj9hdeN+AN1eb5Lm2Ml8KD7UvDcgpBXrp90PMrxUe84TmRgRbhGx2upp96LxhGpZu0fsLbfpc30TH@vger.kernel.org, AJvYcCVOMPFpF8iBSfCXdpX91pgBob7JndjA3C8ooAayUYXNsBRtdBnnAHDXVVZ2O9Xt2AU4QBpiNw8PpTVk@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv6EkEOU1uMCOKJscMQplWKZ5YfNpblrOigA4Cce4HfmU/3zx
	aJMn4Q9eS4jO3oh6ckSiR6DAllsmn0oKJTtC8Wc9gBLJSrFQVtsNzslQRABI529PyD3e2epcVpa
	4h3OiKHBKfeFQHf6pGNugepL88tE=
X-Gm-Gg: ASbGncsh/P0s3IeChclbC5kJa181efjPa6lZE2H9pEKiKLbYytlIz52WXn5Azkf6wd/
	Q1XYJJKW82FitZKXs3OUcsXyyueBUDSKPxKJpJ7yvZh2TIc4WtyvMKhbptfPhj+z7BO1LvahTrn
	CfDvu7gXmVWAbG+841qozebftO
X-Google-Smtp-Source: AGHT+IHhtn/MY8uQvzJzvMpoMO8/8pCPRUNklZgOaGuOQVfqvhUggICmePL4U7XBoQsuoXMMgsVnU6yzTxAsZQISebE=
X-Received: by 2002:a17:907:7216:b0:ac3:8899:d2a6 with SMTP id
 a640c23a62f3a-ac7d185ce57mr1279671566b.12.1744033337483; Mon, 07 Apr 2025
 06:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
 <20250221090918.1487689-2-j2anfernee@gmail.com> <8975b119-fe24-463a-b163-dce702df3cdd@baylibre.com>
In-Reply-To: <8975b119-fe24-463a-b163-dce702df3cdd@baylibre.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 7 Apr 2025 21:41:19 +0800
X-Gm-Features: ATxdqUE_5Q4GslleR9QLgSAVfxgRYmQtklJyPCOrpUHS44T56v3qQ5wCflyg1WM
Message-ID: <CA+4VgcK=R=BF-qk4w-pLkwbTypgMmpJ=7joYN8nioT2Dx3_Z7w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
To: David Lechner <dlechner@baylibre.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, 
	andriy.shevchenko@linux.intel.com, gstols@baylibre.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com, 
	matteomartelli3@gmail.com, marcelo.schmitt@analog.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, thomas.bonnefille@bootlin.com, 
	ramona.nechita@analog.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear David Lechner,

Thanks again for the review, I'll do the changes here and send next patch.

David Lechner <dlechner@baylibre.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 2/21/25 3:09 AM, Eason Yang wrote:
> > Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bi=
t
> > ADCs with I2C interface.
> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,nct7201.yaml     | 57 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,n=
ct7201.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.=
yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> > new file mode 100644
> > index 000000000000..830c37fd9f22
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton nct7201 and similar ADCs
> > +
> > +maintainers:
> > +  - Eason Yang <j2anfernee@gmail.com>
> > +
> > +description: |
> > +  The NCT7201/NCT7202 is a Nuvoton Hardware Monitor IC, contains up to=
 12 voltage
> > +  monitoring channels, with SMBus interface, and up to 4 sets SMBus ad=
dress
> > +  selection by ADDR connection. It also provides ALERT# signal for eve=
nt
> > +  notification and reset input RSTIN# to recover it from a fault condi=
tion.
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
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
>
> Maybe this was brought up before, but no power supply?
>

  vdd-supply:
    description:
      A 3.3V to supply that powers the chip.

  vref-supply:
    description:
      The regulator supply for the ADC reference voltage.

> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@1d {
> > +            compatible =3D "nuvoton,nct7202";
> > +            reg =3D <0x1d>;

            vdd-supply =3D <&vdd>;
            vref-supply =3D <&vref>;

> > +            interrupt-parent =3D <&gpio3>;
> > +            interrupts =3D <30 IRQ_TYPE_LEVEL_LOW>;
> > +            reset-gpios =3D <&gpio3 28 GPIO_ACTIVE_LOW>;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3864d473f52f..fdc4aa5c7eff 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2831,6 +2831,7 @@ L:      openbmc@lists.ozlabs.org (moderated for n=
on-subscribers)
> >  S:   Supported
> >  F:   Documentation/devicetree/bindings/*/*/*npcm*
> >  F:   Documentation/devicetree/bindings/*/*npcm*
> > +F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml

Remove F:   Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>
> This (ARM/NUVOTON NPCM ARCHITECTURE) doesn't look like the right place fo=
r
> adding a stand-alone chip. You will need to start a new section like:
>
> NUVOTON NCT7201 IIO DRIVER
>

NUVOTON NCT7201 IIO DRIVER
M: Eason Yang <j2anfernee@gmail.com>
L: linux-iio@vger.kernel.org
S: Maintained
F: Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
F: drivers/iio/adc/nct7201.c

> >  F:   Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> >  F:   arch/arm/boot/dts/nuvoton/nuvoton-npcm*
> >  F:   arch/arm/mach-npcm/
>

