Return-Path: <linux-iio+bounces-23223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F929B34065
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BB03AECE9
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EF820A5EA;
	Mon, 25 Aug 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2yD6oq/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588621E6DC5;
	Mon, 25 Aug 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127414; cv=none; b=VdPCg05N4AcWdupXn3vGTuuCKQGL0kLxHbmDAtQLPFKPxtvnNvQGCxx5I76Duqba13r6G5wZuwCqisAX+Q9blyWSqt2VdmwR8oEtRd8kk3dTp+cPTBS13+7iHyLE03voS1WksHPV8XGyFN18haP1x8cbl/B9/Z5DUpcxXvRq8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127414; c=relaxed/simple;
	bh=O7Z6kH1RQbEMeE3eiSyEx19EZcZ/ZKVgcYDzfKEp3mI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap1eQk2UNyHI/8/WEuCVsOzMvwfCuTp4l6/L8QaukB7tviBNrTd+0rfJRspOhOCf77a/TWftlsjAIonCV2RV9w9Bt4WiVVtVNdc8ZAMPn1kn51LvLJghn/M7u0fBQqraAqWLuRPJxCp/DbGGDhyrRVmZtWxGKzSKUD4M01FJIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2yD6oq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546FAC4CEED;
	Mon, 25 Aug 2025 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127414;
	bh=O7Z6kH1RQbEMeE3eiSyEx19EZcZ/ZKVgcYDzfKEp3mI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2yD6oq/fymrgyNovJcnhvOZsA1fty8NFngqr8Ou2b0H5qOWYA/QslY4Gq1gWXFIs
	 rCYIwO17t0Zw7iXgFdnKlDvTozH8AlrgxWpFTbVVTvimz/5OPwiihE591bjy7SaB5/
	 4kilDO0WFxN9rUp/rv6uTZit55WWgsE211htDe9s6N+9u/iPXr3u9PPMxx8zXTCFdL
	 X9pbfuKiyoOt8AU9CBtmYIUUaKr0d2IcvbA3RoqD02bnK+Q9pHQvG9qhl1+IF0Zuds
	 z/Ex+LSCghdBGhpFOzly1szoP2EouhkPfBtdMe080cHGp4zsqJYYRAQXnLxZ5eSi/a
	 BEaRuyT+lL8Lw==
Date: Mon, 25 Aug 2025 14:10:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] dt-bindings: iio: adc: add ade9000
Message-ID: <20250825141006.4ae0f866@jic23-huawei>
In-Reply-To: <20250822160157.5092-4-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
	<20250822160157.5092-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 16:01:52 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings support for ade9000.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
one minor thing inline.

> ---
> changes in v5:
>  - remove clock-output-names property (simplified clock output)
>  - make interrupts, reset-gpios, and interrupt-names optional (removed fr=
om required list) =20
>  - improve interrupt-names description to allow any subset of irq0, irq1,=
 dready
>  - fix typo in description ("ADE9000 s a" -> "ADE9000 is a")
>  - fix spacing in description ("analog-to- digital" -> "analog-to-digital=
")
>  - uncomment clock example in device tree example
>  .../bindings/iio/adc/adi,ade9000.yaml         | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000=
.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..a1513ad41651
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Meterin=
g driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 is a highly accurate, fully integrated, multiphase energy =
and power
> +  quality monitoring device. Superior analog performance and a digital s=
ignal
> +  processing (DSP) core enable accurate energy monitoring over a wide dy=
namic
> +  range. An integrated high end reference ensures low drift over tempera=
ture
> +  with a combined drift of less than =C2=B125 ppm/=C2=B0C maximum for th=
e entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to-digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
E9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9000
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    description: Optional interrupt names. Any subset of irq0, irq1, dre=
ady.

The binding should enforce that list of possible values. Lots of examples i=
n tree.
Basically an enum combined with maxItems / minItems to say 1 to 3 of them.
I'm not sure if that is latest preferred way of doing this though.

> +    maxItems: 3
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +
> +  clocks:
> +    description: External clock source when not using crystal
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  "#clock-cells":
> +    description:
> +      ADE9000 can provide clock output via CLKOUT pin with external buff=
er.
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +          compatible =3D "adi,ade9000";
> +          reg =3D <0>;
> +          spi-max-frequency =3D <7000000>;
> +
> +          #clock-cells =3D <0>;
> +          reset-gpios =3D <&gpio 4 GPIO_ACTIVE_LOW>;
> +          interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FAL=
LING>, <4 IRQ_TYPE_EDGE_FALLING>;
> +          interrupt-names =3D "irq0", "irq1", "dready";
> +          interrupt-parent =3D <&gpio>;
> +          clocks =3D <&ext_clock_24576khz>;
> +          clock-names =3D "clkin";
> +          vdd-supply =3D <&vdd_reg>;
> +      };
> +    };


