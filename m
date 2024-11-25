Return-Path: <linux-iio+bounces-12641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE49D86DA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B9C163925
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB31AC8B9;
	Mon, 25 Nov 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbCcKPkA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104D18872F;
	Mon, 25 Nov 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542375; cv=none; b=Ua2bo6CzCbTRrCUhvpvax6HD/ERIiQOgEQ3jdE06aLAUhLKlrX+6fvqMCUglbogyckKJCzo2sX8fGIEG/cfg16HvWsJ0me+/ojb14HTLo5MRZR2OefwnVKTrTUNI3b9VasiUCBtc5VHZRpLMDdSHk7N3kVzPX6iV/gniCCH5mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542375; c=relaxed/simple;
	bh=K6+biCOj1EJW76S/bxKgAp/0jtJ6hpnfLFl8aCpX1kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S9coZtUjC381a8KqG2myFJn0V8yWJocLgSO/R/boNpKxnMGb1itH5llKJTvwTs/nvT5qt8GIgSBHT+GlvyV+QNSvf+M2mS7S40uvgXalZYRJTT3vCX5+YU7J+92I3iSm//hCDufoEN06L7RdkSsD4hlqi+GcOw2ruDtHhwxsfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbCcKPkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E346C4CECE;
	Mon, 25 Nov 2024 13:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732542374;
	bh=K6+biCOj1EJW76S/bxKgAp/0jtJ6hpnfLFl8aCpX1kk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YbCcKPkAmTxo6obVn92cj7syWiLgZkzCsB61EG4qJy8slBEBjPfbPFkqNcR4LA5Ui
	 AdArG9hsgq4Nf95pGETmezFJD6tFGOeRX1DIb45gW2SfLjdp/Hh1tfpZi1Et/WY1/f
	 8I+PCaVJZmdoOiRhxmAf9oqdJAPCYlX57PWIWvQg+O9hxgwkWQ6wHHMhTBM9hpGNjv
	 o7rb8k/UKuzNvH8oNqb47kbVqQ7R0z9migtlMfEO3+QO7QyH/Zlr4xoMdK0c7NsCM/
	 brHRWNmBUBumA1jpJMYXerB8adhqiB8vtc2xSCFoYa0elfkVwT5Q4ltnKt/7vtX7pN
	 unI+8bHcx3+ew==
Message-ID: <9eeae001-92b2-40da-ba75-b03c95eb7139@kernel.org>
Date: Mon, 25 Nov 2024 14:46:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: iio: Add adis16550 bindings
To: Robert Budai <robert.budai@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241125133520.24328-1-robert.budai@analog.com>
 <20241125133520.24328-6-robert.budai@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241125133520.24328-6-robert.budai@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 14:35, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v2:
> - signed of by submitter
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 97 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..767b500afbaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16550 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +      - adi,adis16550w


What is the difference between them? You have description and commit msg
for this.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,

Do not describe DT syntax.
s/Must be the device tree identifier of the//
Instead something like "RESET active low pin".


> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.

This is false. It should not. Instead, it should be marked according to
the board design. You can have there inverter.

> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: If not provided, then the internal clock is used.
> +
> +  adi,sync-mode:
> +    $ref: /schemas/types.yaml#/definitions/string

Do not redefine properties. You are stuck with what is there already :/

> +    description: |
> +      Configures the device SYNC pin.
> +      scaled_sync:  Device handles internally custom scaled
> +                    sync mode. It is stored in a designated register.
> +    enum:
> +      - direct_sync
> +      - scaled_sync
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        adi,sync-mode:
> +          enum: [direct_sync, scaled_sync]

This does not make sense. There is no other option in this enum. Not
sure what you wanted to achieve here. If dependency on property then
required, see example-schema.

> +
> +    then:
> +      dependencies:
> +        adi,sync-mode: [ clocks ]
> +
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false

unevaluatedProperties false



Best regards,
Krzysztof

