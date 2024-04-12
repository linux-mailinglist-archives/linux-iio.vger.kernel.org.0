Return-Path: <linux-iio+bounces-4210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B88A37CF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 23:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7B32862A7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2273152174;
	Fri, 12 Apr 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3S4HzVYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3F1514F8
	for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956997; cv=none; b=OUKz8EvRcDJzZHyGLXMc1hIjftcstYElUekFKyd+6sgntNb8YikGtAcZz/vsacIIMGtv28MyN1SkuXu+f6w9i9SApyW453UKYI5lt1agx1dxTjmHhsfOvSXc+v9DeZ+jcHKBZDVDP3ubBtKs7ydXuvfC8tqNm9LF2RlfEwp/svs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956997; c=relaxed/simple;
	bh=gjU4uk0GsSZKMlfJwnrDqwWR4YB0R1hQfcDlO8zqaSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbR7dCzfds6i/3t9tZKrHL35+GTDN8QPQBlA+98FJYO/zAhABuhsgN3Hc1TvLsUia5lywJzobc1UiVJHh7i/sCNaTmfucHe+HtDNHNdZeJ4MpNexheBMMDOt2Yrswj68ewURUta4jbhELXaNK9AYQmHIUc8yAQuAIzk/fjKg6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3S4HzVYE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso16310751fa.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712956992; x=1713561792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI5+qELetGjRtPvxCNwfVsLKWcvg4CEuVj7KWlNVrRE=;
        b=3S4HzVYE8j/FDn9xDRtnngHYOOAR+U30CHUGlQSYOd+j1sDg4UaiegDgAeeMUW1b3e
         40MvOun9FLDeVOs+SBmzVr9zV6WwBAJRTkIC1SFsFyfzTKjdou5m5VfQUIxinkTz3ahw
         fyrtmgs2S5BywNEtKQYu8uME8fRMYA93yfLqDeTsNLw/0eceTQ9fz6Q/1Hlgbb90RfcY
         1/gB7bjxgTbzJKAPW1I7M1drntVVCF5URl4fEf++8e6PGEFeOHR37XosdS4zYuxD1KLu
         FeqeR3ClDujoN5ttstLeqR99gkAAPWFcLPDFZ3JivgWdeWPbz9/ULhD8AqfCGyDOL3HT
         9qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956992; x=1713561792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI5+qELetGjRtPvxCNwfVsLKWcvg4CEuVj7KWlNVrRE=;
        b=DUSTfHIJ4R2jngp3hoky8xzAo1h+OeX3UprM+DsiV1y4nT00bWyHDYLLMxufFBG3Em
         stFMKpwv10x/lmuw9xhGVefFoSCCkVaDmY09IpXW8b8fSapmgJkgwDjMFR/lwS2xRmkX
         sbQqa0JsyNDyuxqGCxJ4gnBLDINju+rZJ3ek5/ylpzwyZTwO7XdhN8TEa6qxhfTWW2MN
         tf+GUr0Py8EORK2mfbGJX05DfG5Q9MLM0clnOylLE+mg8i8T5Zvp1opTNyzrjRhl3nvT
         jI/pbdevjAWS2Mj2S/aGM4hE7S2WNnJYkzeaIzqu91lWym3gFfCOYIutYUmLecWrAxv4
         4eJg==
X-Gm-Message-State: AOJu0YzF5p8KyAv3aCrOViBA02BC/3QeHxnrEMrQM6l8oD2mjR6SEGsl
	J4qqjEIcLa0FNGGbLyCDc1CCwwYN6oi66B0uFw7gpS306RsZQBspXuR0l8I0Pw9eRmMX1MqoXJ5
	CklBeicmrHzznIoZFCC7kZ9HSKUbzq55iCLQ5Pw==
X-Google-Smtp-Source: AGHT+IFQ1va6+20zWwSm0SxD+9H0KFtcry/X9YiOjzitgl1O072Ts1JaZH3ll9wyEqut1Gk3frIjLR5AAHx+D/dEdag=
X-Received: by 2002:a05:651c:205c:b0:2d9:eb66:6d39 with SMTP id
 t28-20020a05651c205c00b002d9eb666d39mr2247871ljo.19.1712956992169; Fri, 12
 Apr 2024 14:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412032102.136071-1-kimseer.paller@analog.com> <20240412032102.136071-2-kimseer.paller@analog.com>
In-Reply-To: <20240412032102.136071-2-kimseer.paller@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Apr 2024 16:23:00 -0500
Message-ID: <CAMknhBHgKK_OEcPz-5ktxj+YEkB7jHpw5owdh9HVj_qfwuVXkQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> Add documentation for ltc2664 and ltc2672.
>
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664=
.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> new file mode 100644
> index 000000000..2f581a9e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> @@ -0,0 +1,230 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2664 and LTC2672 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/lt=
c2664.pdf

This link gives a 404 error. Is there a typo?


> +  https://www.analog.com/media/en/technical-documentation/data-sheets/lt=
c2672.pdf
> +
> +$defs:
> +  toggle-operation:
> +    type: object
> +    description: Toggle mode channel setting.
> +
> +    properties:
> +      reg:
> +        description: Channel number.
> +        minimum: 0
> +        maximum: 4
> +

> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation =
enables
> +          fast switching of a DAC output between two different DAC codes=
 without
> +          any SPI transaction.
> +        type: boolean

I'm not convinced that this belongs in the devicetree. It seems like
everything related to toggling can and should be left to runtime
configuration.

> +
> +patternProperties:
> +  "^channel@[0-4]$":
> +    type: object
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2664
> +      - adi,ltc2672
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +

There is also an input supply for each output channel on ltc2672, so I
think we also need vdd0-supply, vdd1-supply, etc.

On ltc2664, there is V+ instead so it needs v-pos-supply.

And there is V~ on both which can be between -5.5V/-15.75V and GND, so
optional v-neg-supply seems appropriate.

> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  vref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-s=
cale
> +      range of all channels. If not provided the internal reference is u=
sed and
> +      also provided on the VREF pin.

There is no VREF pin, so it looks like there is a typo. And it would
make more sense to call this ref-supply as well.

> +
> +  clr-gpios:
> +    description:
> +      If specified, it will be asserted during driver probe. As the line=
 is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1

Some other potentially properties for complete bindings that would be
trivial to add now:

* (ltc2672) There is a FAULT output pin, so it would make sense to
have an interrupts property for that signal.
* (both) I haven't done any DACs myself yet, but I see ldac-gpios on a
few other bindings. I assume this is the typical way for handling the
LDAC signal on most DACs?
* (both) I see these have daisy chain capabilities, so an optional
#daisy-chained-devices could be appropriate.

Maybe not so trivial:

* (both) The MUX/MUXOUT pins look like we have an embedded pin mux, so
it could mean we need #pinctrl-cells. ltc2664 would also need
muxin-gpios for this.


> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ltc2664
> +    then:
> +      properties:
> +        adi,manual-span-operation-config:
> +          description:
> +            This property must mimic the MSPAN pin configurations.
> +            By tying the MSPAN pins (MSP2, MSP1 and MSP0) to GND
> +            and/or VCC, any output range can be hardware-configured
> +            with different mid-scale or zero-scale reset options.
> +            The hardware configuration is latched during power on reset
> +            for proper operation.
> +              0 - MPS2=3DGND, MPS1=3DGND, MSP0=3DGND
> +              1 - MPS2=3DGND, MPS1=3DGND, MSP0=3DVCC
> +              2 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DGND
> +              3 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DVCC
> +              4 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DGND
> +              5 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DVCC
> +              6 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DGND
> +              7 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DVCC (enables SoftSpan f=
eature)
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +          default: 7

Are these always hard-wired or could they be connected to gpios and
made configurable at runtime?

> +
> +      patternProperties:
> +        "^channel@([0-3])$":
> +          $ref: '#/$defs/toggle-operation'
> +          unevaluatedProperties: false
> +
> +          description: Channel in toggle functionality.
> +
> +          properties:
> +            adi,output-range-microvolt:
> +              description: Specify the channel output full scale range.

How would someone writing a .dts know what values to select for this
property? Or is this something that should be configured at runtime
instead of in the devicetree? Or should this info come from the
missing voltage supplies I mentioned?

> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [5000000, 10000000]
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +                - items:
> +                    - const: -10000000
> +                    - const: 10000000
> +                - items:
> +                    - const: -2500000
> +                    - const: 2500000
> +
> +          required:
> +            - adi,output-range-microvolt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ltc2672
> +    then:
> +      properties:
> +        adi,rfsadj-ohms:
> +          description: If FSADJ is tied to VCC, an internal RFSADJ (20 k=
=CE=A9) is
> +            selected, which results in nominal output ranges. When an ex=
ternal
> +            resistor of 19 k=CE=A9 to 41 k=CE=A9 can be used instead by =
connecting the
> +            resistor between FSADJ and GND it controls the scaling of th=
e
> +            ranges, and the internal resistor is automatically disconnec=
ted.
> +          minimum: 19000
> +          maximum: 41000
> +          default: 20000

This is the kind of description that would be helpful on some of the
other properties. It does a good job of explaining what value to
select based on what is connected to the chip.

> +
> +      patternProperties:
> +        "^channel@([0-4])$":
> +          $ref: '#/$defs/toggle-operation'
> +          unevaluatedProperties: false
> +
> +          description: Configuration properties for a channel in toggle =
mode
> +
> +          properties:
> +            adi,output-range-microamp:
> +              description: Specify the channel output full scale range.
> +              $ref: /schemas/types.yaml#/definitions/uint32
> +              enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100=
000000,
> +                     200000000, 300000000]
> +

Same comments as adi,output-range-microvolt apply here.

> +          required:
> +            - adi,output-range-microamp
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - vcc-supply
> +  - iovcc-supply
> +
> +additionalProperties: false
> +

