Return-Path: <linux-iio+bounces-22046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284BB12FB3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736993BB833
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337DD205E25;
	Sun, 27 Jul 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9S3sa6x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13B282EE;
	Sun, 27 Jul 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622658; cv=none; b=PsWeL+aXneRrarD6Tv+3Jqzlgq7vHpGq7JD87jdXLwj3zC/+fGpzKCA7b9os4BrFs14iXqxgJQs7dxSkx6e2lerqYLyPaIJNm3nVwXp9RGF2kdmABuzQmILKkXRNNOUPmh1RW7pC8QUYJhWxeMnYOWwSfkClx8AnZhSO3iFrm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622658; c=relaxed/simple;
	bh=hpo2wsDDz+BvrtX0pOauee6m7aQv1fSOFxC5YfrPnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIB6MlWUlFSrv/GIFW4Srq+YEmk2TOGvs3D0TjAZrmbdEHFwAMtfG+aN8Djpxt+zi4VLYCpurqyC00tX2TKWP6dYGDxMWiEeFFg3P6Or6gezMuqzKOPw9p8YByJYmRPhX60ozo5myQCNHr0w0Rp7HhtEIFXNfcKYTdwZfQ5wFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9S3sa6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03547C4CEEB;
	Sun, 27 Jul 2025 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753622657;
	bh=hpo2wsDDz+BvrtX0pOauee6m7aQv1fSOFxC5YfrPnWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9S3sa6xJ/hhGQ4Ta9GCEt8tyDLu0UiXaosUkkETka6ogB81CetQK5rydZGJ9gSJG
	 8wF7u92eHo56UTElbmakUJ/r3AhqPJYXvEAG5uuzo5xwlhYoi525X9jkOZ4/eVvRVB
	 T3yW3XE10411Tyjn+thY/snphjaXS+wLiCihUu/4pp1sajg7COvg1LirRON/xhBCNO
	 0GAgxyg/YV9k8AP0zfxpLpLKd4ASE2zxMUX8vcSafmkNBj2NJQLwfKJ9pnq9+pmPW+
	 8BOleCPEzXh41MH+s9OnVzOlhWrIymgDTbow6YqEo7n1IlKbNfsh1mAOQxnbG1gAtN
	 yuY9sdTulyQEg==
Date: Sun, 27 Jul 2025 14:24:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: adc: add ade9000
Message-ID: <20250727142410.63dc20fb@jic23-huawei>
In-Reply-To: <20250721112455.23948-2-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
	<20250721112455.23948-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jul 2025 14:24:42 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings support for ade9000.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - move interrup-names near interrupts
>  - remove properties related to the waveform buffer and make them runtime=
 attributes
>  - remove egy-time property and make it a runtime attribute.
>  - remove wf-src and use filter_type in the driver.
>  - add vref, vdd support.
>  - use adc standard channels instead of phase channels.
>  .../bindings/iio/adc/adi,ade9000.yaml         | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000=
.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..0176252aae35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Meterin=
g driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy a=
nd power
> +  quality monitoring device. Superior analog performance and a digital s=
ignal
> +  processing (DSP) core enable accurate energy monitoring over a wide dy=
namic

Getting a bit marketing heavy for my liking!  Make just drop this sentence.

> +  range. An integrated high end reference ensures low drift over tempera=
ture
> +  with a combined drift of less than =C2=B125 ppm/=C2=B0C maximum for th=
e entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
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
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: irq0
> +      - const: irq1
> +
> +  reset-gpios:
> +    description: |
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +
> +patternProperties:
> +  "^channel@[0-2]$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: The channel number (0-2 for phases A, B, C)
> +        minimum: 0
> +        maximum: 2
> +

What useful info is this providing?  Seems relatively unlikely anyone
will use a 3 phase power monitor for less than 3 phases.  It's not
required to have per channel nodes and many drivers don't because there
isn't anything channels specific in DT and we just leave them all on.

> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +          reset-gpios =3D <&gpio 4 GPIO_ACTIVE_LOW>;
> +          interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FAL=
LING>;
> +          interrupt-names =3D "irq0", "irq1";
> +          interrupt-parent =3D <&gpio>;
> +          vdd-supply =3D <&vdd_reg>;
> +
> +          channel@0 {
> +            reg =3D <0>;
> +          };
> +          channel@1 {
> +            reg =3D <1>;
> +          };
> +          channel@2 {
> +            reg =3D <2>;
> +          };
> +      };
> +    };


