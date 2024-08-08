Return-Path: <linux-iio+bounces-8333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A385D94C41C
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FCF285CCA
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3C1465BB;
	Thu,  8 Aug 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXocCki8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800455769;
	Thu,  8 Aug 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140657; cv=none; b=Y0DddCONV4F//31d2MeifIkONL6tD/jD/noX9RaL6d/DWQn39MBs4DbAV2pysRMx/NFfaxx7752VbudOtdSTgviL0XLGRFPqtwjGHUUQXZmpb3rc78MjWzNFd38C1Rtoq4/LwQySzIUpGcWLjyS1HArOnq4H2orXivTmEdeFjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140657; c=relaxed/simple;
	bh=IzN+0IllBbe8cqENOEL8lICQYXZcmk8qn7cN8akcdRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbRCPMXhJ89qJ5qurFiTy0Ul8swx50G3jJ5KDrSjyHYSgQyKMwMNqs2P7x82LnHTPIXLzHwao8NBfyMK++ZhPeWaFKxDkPBGl7sasb++joXZObFZD/zK/vZkQsaJDmP2peLZRodDbLAsgvCZBR5Ua45E7YY7KiyjYbkzMUFdB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXocCki8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C28C4AF0E;
	Thu,  8 Aug 2024 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723140657;
	bh=IzN+0IllBbe8cqENOEL8lICQYXZcmk8qn7cN8akcdRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXocCki8oHoLLruHpGgEKljB/jBxRTPpzxTsiKp0ccvszSqsUDrHKpQKLwxm/26C8
	 VsB//QmFJPlZFIHUrdDsS/hpZ2GmQjICpMfsXn92jRcosRLQZ3ey9IVVmSKNW8c0NK
	 fCkggrY3AZVnr/c7Tm7aQ+9cbZsBWtPfw+jwHJoMr8iYxlPVNdZ/+6jjT6SgMV1iI6
	 VWT4ud/EladOQl6HLsLcoMJu+m/bJYIh1uwGAmurJN5r9aQvNWZY1vu+kMyqq+cYVE
	 NLJ4E/QvuB70pcLrLPEC9C8Ca83PPbtZmFX0vjiCKL9+DCgbr6uPVS5BZg4WmB6gUK
	 9WukUjoDUx2OQ==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1155586276.0;
        Thu, 08 Aug 2024 11:10:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/lTDC50R2IIVI4H4h/DiHkbNBKJP1xkP/mIN8+SAlbH+pj/Wbo3O2oWXF9hPNtwkmaUnYHHxENYFJWnWEQvK7zJ0G8HxKvNrECWxKhxiWdVJYDsB/zuAlOWYRhKv/Pu4BoBM1x1LvpP4/HscIyjrkH7AhpsB+q39XGXXQJdg5nXwY/ThjxgVgM3KUa+yam8r80Ez3/cDZi4gwCi8AwA==
X-Gm-Message-State: AOJu0YycuJ23YWBjHdXqguMLjCHKC2uJzszUHLQGUlhUZWXVhaxkDn63
	BxzEYoeYpkA8NPUr++4pO0QnQCnWx0BBXjd8l4XoldDdwNI05DsPINef7D6hpqv4dFcyKFxkBME
	htlZnrjw5jDR3FbiL+bvjZyGvLQ==
X-Google-Smtp-Source: AGHT+IG6f1NrEBsWGrKI3cTAq+ObiGLjaOX692b54NH03/BssS5qOzyO2HKGBpDdEZhJIc/qfVg2dAYc9OkraoG11DU=
X-Received: by 2002:a05:6902:e0b:b0:e0b:c16a:d0b1 with SMTP id
 3f1490d57ef6-e0e9dc8793emr3047061276.45.1723140656382; Thu, 08 Aug 2024
 11:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com> <20240711-iio-adc-ad4695-v4-1-c31621113b57@baylibre.com>
In-Reply-To: <20240711-iio-adc-ad4695-v4-1-c31621113b57@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Aug 2024 12:10:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKaddw8FnPfdnhKhHUb8AcTxFadc_eZmxjX0QxFR80=mw@mail.gmail.com>
Message-ID: <CAL_JsqKaddw8FnPfdnhKhHUb8AcTxFadc_eZmxjX0QxFR80=mw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:16=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Add device tree bindings for AD4695 and similar ADCs.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>
> Note, this may trigger a DT build warning "common-mode-channel: missing
> type definition" if the builder doesn't include the recently added
> common-mode-channel property [1]. This should be safe to ignore (passes
> make dt_binding_check locally).
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/=
?h=3Dtesting&id=3Dd86deaec1c5b0fb60c3619e8d2ae7a1d722fd2ad
>
> v4 changes:
> * Picked up Conor's reviewed-by tag.
>
> v3 changes:
> * Change interrupts to be per pin instead of per signal.
> * Drop diff-channels and single-channel properties.
> * Odd numbered pins added to common-mode-channel property enum.
> * REFGND and COM values changes to avoid confusion with pin numbers.
> * Add inX-supply properties for odd numbed input pins.
>
> v2 changes:
> * Drop *-wlcsp compatible strings
> * Don't use fallback compatible strings
> * Reword supply descriptions
> * Use standard channel properties instead of adi,pin-pairing
> * Fix unnecessary | character
> * Fix missing blank line
> * Add header file with common mode channel macros
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 256 +++++++++++++++=
++++++
>  MAINTAINERS                                        |  10 +
>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
>  3 files changed, 275 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> new file mode 100644
> index 000000000000..a2e824e26691
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> @@ -0,0 +1,256 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4695.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Easy Drive Multiplexed SAR Analog to Digital Conve=
rters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> +
> +description: |
> +  A family of similar multi-channel analog to digital converters with SP=
I bus.
> +
> +  * https://www.analog.com/en/products/ad4695.html
> +  * https://www.analog.com/en/products/ad4696.html
> +  * https://www.analog.com/en/products/ad4697.html
> +  * https://www.analog.com/en/products/ad4698.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4695
> +      - adi,ad4696
> +      - adi,ad4697
> +      - adi,ad4698
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 80000000
> +
> +  spi-cpol: true
> +  spi-cpha: true
> +
> +  spi-rx-bus-width:
> +    minimum: 1
> +    maximum: 4
> +
> +  avdd-supply:
> +    description: Analog power supply.
> +
> +  vio-supply:
> +    description: I/O pin power supply.
> +
> +  ldo-in-supply:
> +    description: Internal LDO Input. Mutually exclusive with vdd-supply.
> +
> +  vdd-supply:
> +    description: Core power supply. Mutually exclusive with ldo-in-suppl=
y.
> +
> +  ref-supply:
> +    description:
> +      External reference voltage. Mutually exclusive with refin-supply.
> +
> +  refin-supply:
> +    description:
> +      Internal reference buffer input. Mutually exclusive with ref-suppl=
y.
> +
> +  com-supply:
> +    description: Common voltage supply for pseudo-differential analog in=
puts.
> +
> +  adi,no-ref-current-limit:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When this flag is present, the REF Overvoltage Reduced Current pro=
tection
> +      is disabled.
> +
> +  adi,no-ref-high-z:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable this flag if the ref-supply requires Reference Input High-Z=
 Mode
> +      to be disabled for proper operation.
> +
> +  cnv-gpios:
> +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI=
 CS.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: The Reset Input (RESET). Should be configured GPIO_ACTI=
VE_LOW.
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: Signal coming from the BSY_ALT_GP0 pin (ALERT or BU=
SY).
> +      - description: Signal coming from the GP2 pin (ALERT).
> +      - description: Signal coming from the GP3 pin (BUSY).
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: gp0
> +      - const: gp2
> +      - const: gp3
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      The first cell is the GPn number: 0 to 3.
> +      The second cell takes standard GPIO flags.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^in(?:[13579]|1[135])-supply$":
> +    description:
> +      Optional voltage supply for odd numbered channels when they are us=
ed as
> +      the negative input for a pseudo-differential channel.
> +
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    description:
> +      Describes each individual channel. In addition the properties defi=
ned
> +      below, bipolar from adc.yaml is also supported.
> +
> +    properties:
> +      reg:
> +        maximum: 15
> +
> +      common-mode-channel:
> +        description:
> +          Describes the common mode channel for single channels. 0xFF is=
 REFGND
> +          and OxFE is COM. Macros are available for these values in
> +          dt-bindings/iio/adi,ad4695.h. Values 1 to 15 correspond to INx=
 inputs.
> +          Only odd numbered INx inputs can be used as common mode channe=
ls.
> +        items:

"items" is for arrays, but common-mode-channel is a uint32. Drop
"items". Either Jonathan can fixup or you'll need to send a fix.

It's now warning in linux-next (you need dtschema main branch):
/builds/robherring/linux-dt/Documentation/devicetree/bindings/iio/adc/adi,a=
d4695.example.dtb:
adc@0: channel@1:common-mode-channel: 254 is not of type 'array'
        from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4695.y=
aml#
/builds/robherring/linux-dt/Documentation/devicetree/bindings/iio/adc/adi,a=
d4695.example.dtb:
adc@0: channel@2:common-mode-channel: 3 is not of type 'array'
        from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4695.y=
aml#

> +          enum: [1, 3, 5, 7, 9, 11, 13, 15, 0xFE, 0xFF]
> +        default: 0xFF

Rob

