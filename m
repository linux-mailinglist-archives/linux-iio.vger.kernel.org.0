Return-Path: <linux-iio+bounces-6229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9C9064A3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 09:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92C71F23E0E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394751386BB;
	Thu, 13 Jun 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j42W6Jhv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DB1384AB;
	Thu, 13 Jun 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262705; cv=none; b=vAckQ0lxy9CkictrV9sdevbzk3IGnp1NQ5ZA3mryRcvF5z8Xtxt4e+LAU1KYaiXziyY501vrLqZw75SpH/IUZdaoY8TCCLrjUBm8J23q4nwsHwiSp07ev1lCy5QmS106oXuF/Yt3reBh0ZFD/0EXQjNKOYEdzQtFZpRB+boUCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262705; c=relaxed/simple;
	bh=OslM3kkku1MDWJpYN4HLaJZ3olMNC5OUngm/2NELu/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqTErAwt4jYaFO3lubZJqqocWBmhyw+/COhbtL1uLWLg7tcCbL+9P7rAb5ofitjkQOg1IgUWIw5m399v9KnoEjuELh+DpulSf1z4L6rJU6mJC/gU7uiU2wNPuGGsU6NnFXt/uyy2e6RrFtdjHpKo1n3wjBV255sd1el1Y+YYbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j42W6Jhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657AFC2BBFC;
	Thu, 13 Jun 2024 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718262704;
	bh=OslM3kkku1MDWJpYN4HLaJZ3olMNC5OUngm/2NELu/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j42W6JhvQzwh3evAHkcis301+xm4+w2IsrLOmt83a1O2r5maTl1y1wXlYmji3/Yi+
	 gYefiRTwdGKNdXW+U6kc7e3iP9DGR2Shhk1pjRS5k6cp5k9qM2wpvnvYOhLnuCm7YA
	 a/EXe6Q141fxibH/3znijXCqR4YviSISJ5OIy/7Zr/qIXRwpqBOwaEu6dxUv4cNEDf
	 64aqM4bPsjeI9VcC9e5mwfQQKoqV6Nd8+ADOliDikmz8FserW76ExvSTLnrULIBEQv
	 2+cbHVE93IULJ6GDvHHcQOAA+1xgfl1ofJxW8SBC22ycDmIxsz0/gNdtJLZrgYGfqK
	 Wk6FG3TxHSXww==
Message-ID: <94448c2c-e7b2-4191-858c-529b254994f1@kernel.org>
Date: Thu, 13 Jun 2024 09:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
 <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2024 21:20, David Lechner wrote:
> Add device tree bindings for AD4695 and similar ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 297 +++++++++++++++++++++
>  MAINTAINERS                                        |   9 +
>  2 files changed, 306 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> new file mode 100644
> index 000000000000..8ff5bbbbef9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> @@ -0,0 +1,297 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4695.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices Easy Drive Multiplexed SAR Analog to Digital Converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  A family of similar multi-channel analog to digital converters with SPI bus.
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
> +    oneOf:
> +      - enum:
> +          - adi,ad4695
> +          - adi,ad4697
> +      # same chips in WLCSP package with more pins
> +      - items:
> +          - const: adi,ad4695-wlcsp

Usually we do not add compatibles for such differences. Programming
model is the same. Same for all other wlcsp. Unless something differs?

> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4697-wlcsp
> +          - const: adi,ad4697
> +      # same chips with higher max sample rate
> +      - items:
> +          - const: adi,ad4696

Anyway, keep all fallbacked variants in one entry, so enum with const
fallback.

> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4698
> +          - const: adi,ad4697
> +      # same chips with higher max sample rate in WLCSP package
> +      - items:
> +          - const: adi,ad4696-wlcsp
> +          - const: adi,ad4696

That's wrong. ad4696 is compatible with 4695 as stated before. It is not
compatible with ad4695-wlcsp.

> +          - const: adi,ad4695-wlcsp
> +          - const: adi,ad4695
> +      - items:
> +          - const: adi,ad4698-wlcsp
> +          - const: adi,ad4698
> +          - const: adi,ad4697-wlcsp
> +          - const: adi,ad4697
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
> +    description: A 2.7 V to 5.5 V supply that powers the analog circuitry.
> +
> +  ldo-in-supply:
> +    description: A 2.4 V to 5.5 V supply connected to the internal LDO input.
> +
> +  vdd-supply:
> +    description: A 1.8V supply that powers the core circuitry.
> +
> +  vio-supply:
> +    description: A 1.2V to 1.8V supply for the digital inputs and outputs.
> +
> +  ref-supply:
> +    description: A 2.4 V to 5.1 V supply for the external reference voltage.
> +
> +  refin-supply:
> +    description: A 2.4 V to 5.1 V supply for the internal reference buffer input.
> +
> +  com-supply:
> +    description: Common voltage supply for pseudo-differential analog inputs.
> +
> +  adi,no-ref-current-limit:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When this flag is present, the REF Overvoltage Reduced Current protection
> +      is disabled.
> +
> +  adi,no-ref-high-z:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable this flag if the ref-supply requires Reference Input High-Z Mode
> +      to be disabled for proper operation.
> +
> +  cnv-gpios:
> +    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description:
> +          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
> +          condition.
> +      - description:
> +          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
> +          condition.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: busy
> +      - const: alert
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

Blank line

> +  "#size-cells":
> +    const: 0
> +


Best regards,
Krzysztof


