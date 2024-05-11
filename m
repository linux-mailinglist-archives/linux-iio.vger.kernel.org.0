Return-Path: <linux-iio+bounces-4967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F58C3274
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE6128231E
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5B56771;
	Sat, 11 May 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVaDlUDq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BB56772;
	Sat, 11 May 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444713; cv=none; b=EY/ku2VW+yzu0TbWoAUG5YqNBHlwGsAMVU3A+ZnEtBpIkscPwc5K8GMbNXK59zu1AaXTN8TMNcnI5Ygwv3FC4cXAQVnAEzdAVElCXjVPMdidYoApoj2PFAgBnkTaWzL1dvA7WBaDZP1y2fb8pgeZKXWMFfdIFq2mjyDBZRCnllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444713; c=relaxed/simple;
	bh=PoZ0hnBSYNcpGCRh+GVodXfFczNN0WpcaG9zsi291mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoD+k0vvd4cte01Pi3RqdUCv/G6lD924UMQV+KWo+fnCrVC9jC9tfTscmOH9fmkpPGVtFQnUO2qnM/VyO40ptuIuu/Xc263Dw7e717FW9qlHk6HoQK4SGCSqvuJABk5xe0mOksGpb+mdADqt1F7DFIFU4Q6RFc/GLNxPmJqkmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVaDlUDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54983C2BBFC;
	Sat, 11 May 2024 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715444713;
	bh=PoZ0hnBSYNcpGCRh+GVodXfFczNN0WpcaG9zsi291mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hVaDlUDqc2PLNffxiiFiED2qvAcfwrRnzjaogkiTzB0ouPyGNV7WKfjn8LF4I9ztg
	 tm/bGfuG0b8Za4M4lPvd8jBxONYQSw8fRR6uYx+Svm8CmnC6XheYri/vrYTspo36bO
	 tpJZ9cVGAJ6yqN5sGd/2teB5uzej58WkRg7wmawphCKbO6jvO5Q/LRKOQslYFs+zWo
	 1jX3wAkUFYWoaQ0avusDCF6PoJC6QnLFXux2PIzEwhZGnnzFCKPxDnhmQfv5GlKnRj
	 QglqYE85+RcxcPu3s3DSg1FKt7lBiRFLpF21Zv+feN8abAjZ8AAPS0Czt34/KhCQCs
	 20l0MsOyrr5zQ==
Date: Sat, 11 May 2024 17:25:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460
Message-ID: <20240511172500.718fe12d@jic23-huawei>
In-Reply-To: <CAMknhBFXk07HbP_pPg5wkW-9Ah2-66kGzZFvcvBNrbjfguHb4g@mail.gmail.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<20240510064053.278257-2-Mariel.Tinaco@analog.com>
	<CAMknhBFXk07HbP_pPg5wkW-9Ah2-66kGzZFvcvBNrbjfguHb4g@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 12:28:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@anal=
og.com> wrote:
> >
> > This adds the bindings documentation for the 14-bit
> > High Voltage, High Current, Waveform Generator
> > Digital-to-Analog converter.
> >
> > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> > ---
> >  .../bindings/iio/dac/adi,ad8460.yaml          | 67 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  2 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad846=
0.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml =
b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > new file mode 100644
> > index 000000000..924f76209
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2024 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad8460.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD8460 DAC
> > +
> > +maintainers:
> > +  - Mariel Tinaco <mariel.tinaco@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD8460 110 V High Voltage, 1 A High Current,
> > +  Arbitrary Waveform Generator with Integrated 14-Bit High Speed DAC
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad8460.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad8460
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 20000000
> > +
> > +  vref-supply: =20
>=20
> It would be nice to make the property name match the pin name since
> there is more than one reference voltage input.
>=20
> refio-1p2v-supply:
>=20
> > +    description: Drive voltage in the range of 1.2V maximum to as low =
as
> > +      low as 0.12V through the REF_IO pin to adjust full scale output =
span =20
>=20
> I don't seen anything in the datasheet named REF_IO. Is this a typo
> and it should be REFIO_1P2V?
>=20
> > +
> > +  clocks:
> > +    description: The clock for the DAC. This is the sync clock
> > +
> > +  adi,rset-ohms:
> > +    description: Specify value of external resistor connected to FS_AD=
J pin
> > +      to establish internal HVDAC's reference current I_REF
> > +    minimum: 2000
> > +    maximum: 20000
> > + =20
>=20
> I see lots more pins on the datasheet, many of which should be trivial
> to add bindings for (we prefer to have the bindings as complete as
> possible even if the driver doesn't implement everything). Potential
> candidates:
>=20
> sdn-reset-gpios: (active high)
> reset-gpios: (active low)
> sdn-io-gpios: (active high)
>=20
> hvcc-supply:
> hvee-supply:
> vcc-5v-supply:
> vref-5v-supply:
> dvdd-3p3v-supply:
> avdd-3p3v-supply:
>=20
> It also looks like there is a parallel interface for data, so I would
> expect to see an io-backends property that links to the PHY used for
> handling that.
>=20
Ultimately yes, but the parallel interface might require some decisions on=
=20
binding that are non obvious until it's actually implemented. So maybe
don't need that bit from the start.  The rest I agree should be here.


>=20
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    spi {
> > +        dac@0 {
> > +            compatible =3D "adi,ad8460";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <8000000>;
> > +            adi,rset-ohms =3D <2000>;
> > +
> > +            vref-supply =3D <&vrefio>;
> > +            clocks =3D <&sync_ext_clk>;
> > +        };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 758c202ec..dae93df2a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1234,6 +1234,13 @@ W:       https://ez.analog.com/linux-software-dr=
ivers
> >  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >  F:     drivers/iio/adc/ad7780.c
> >
> > +ANALOG DEVICES INC AD8460 DRIVER
> > +M:     Mariel Tinaco <Mariel.Tinaco@analog.com>
> > +L:     linux-iio@vger.kernel.org
> > +S:     Supported
> > +W:     https://ez.analog.com/linux-software-drivers
> > +F:     Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > +
> >  ANALOG DEVICES INC AD9739a DRIVER
> >  M:     Nuno Sa <nuno.sa@analog.com>
> >  M:     Dragos Bogdan <dragos.bogdan@analog.com>
> > --
> > 2.34.1
> >
> > =20


