Return-Path: <linux-iio+bounces-23547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBBB3D472
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8010189AEDF
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD4270552;
	Sun, 31 Aug 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfV9JxXp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94926CE39;
	Sun, 31 Aug 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658874; cv=none; b=Q+MM4jkea3kbWm9GIme4wrjSDVsiS8G5BzT2bXCycGBidLVNvHg9obJMSeNpPkmfB5SAClx/1YuYUTqZyP/Pj7LbrVSoGrM/e79wCPuc7OAmwZjcYQYqwjgGTZpCWkjW7OtazZIgPkjlT3V05U/MWwIDClH4PfHj22smaqPbRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658874; c=relaxed/simple;
	bh=JTnmKJKL3G1MU26AydhExn3eBf+nz8rBFKiO/bxK4zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrEDYxOC6eweKOiB/t7WvYB8FRVoI4kH7FrD6Ta5X+HNt4EMgsk1MdsUwd5jdm1TnzQb3UqKnEJOYM3phKZxTviwkCFqhIes1Hz2kIMvVYquWZ5vUvrS0KqRLYcnHXyTA2sCeHY3crg9/w+A5joK2mdpdqGPbYQe0Oe8esCf2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfV9JxXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B25C4CEED;
	Sun, 31 Aug 2025 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756658873;
	bh=JTnmKJKL3G1MU26AydhExn3eBf+nz8rBFKiO/bxK4zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZfV9JxXp65IEldUdmfTWZ+hpAg+XmjuQ7TKmZUoLBjqR9O2oj29Uk5q68TS9LsN8s
	 jUo5U9bJh2aWc6Frd8r5bQYPo4Bf1A8DNNGk8TgzxWTZ0gG9ATDRpjRXFnx+IdXCWQ
	 20r1+nQI/r5NOP5hXOGanXk9RjJMfZ7pn5ZWY38NL9CKsjBHDSvxdc/jY5pCGKyRKh
	 ZtgN9wXbUk5sM8iXcVZbcuAVtS2ewXIAphfUZLOcIAmHsfU5KK4H1C5SipFQhVJ64+
	 fqj9cEoRrFCjNp8wbXQnm8aGXqlod6bmsTTRWHsNC69BgHwkBzVMVJHsDSWqmUDq12
	 +aVcrYiYpfrYg==
Message-ID: <6a7a2721-063d-490a-8fd9-bec101531027@kernel.org>
Date: Sun, 31 Aug 2025 18:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, peterz@infradead.org,
 jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, jonathan.cameron@huawei.com,
 akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/2025 12:31, Lakshay Piplani wrote:
> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> Changes in v2 (addressed review comments from Krzysztof Kozlowski):
>  - Dropped nxp,alert-active-high: unnecessary as polarity handling is implicit in driver.
>  - Retained nxp,interrupt-mode: required to program TM(thermostat mode) bit; enables interrupt
>    (latched) mode. If not present in DT entry comparator mode is set as default.
>  - Retained nxp,fault-queue: This needs to be configured during device initialization.
>    This property configures the hardware fault queue length. Defines how many consecutive faults
>    are required before ALERT/IBI is asserted, preventing false triggers in noisy environments.
>  - The `reg` property remains required to satisfy `dt_binding_check`.

Where was v1? Why aren't you using b4 for all this?

>  - Fixed YAML formatting, line wrapping, and examples.
>  - Changed compatibles from nxp,p3t1755 to nxp,p3t1755-iio and nxp,p3t1750 to nxp,p3t1750-iio
>    as reported by kernel test robot.

Huh? Why?

> 
>  .../bindings/iio/temperature/nxp,p3t1755.yaml | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> new file mode 100644
> index 000000000000..4eb6fc5cb247
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP P3T175x Temperature Sensor
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
> +
> +  P3T175x (P3T1750/P3T1755) is a digital temperature sensor with a range of -40°C to
> +  +125°C and a 12-bit resolution. It supports communication over
> +  both I2C and I3C interfaces.
> +
> +  The I2C interface supports up to 32 static addresses and provides
> +  an ALERT output to signal when temperature thresholds are crossed.
> +
> +  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
> +  allowing the device to notify the controller of threshold events without
> +  dedicated alert pin.
> +
> +  The device supports configurable thermostat modes (interrupt or comparator),
> +  fault queue length etc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1750-iio
> +      - nxp,p3t1755-iio

Drop iio

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      In I2C mode, the device supports up to 32 static addresses.
> +      In I3C mode, the 'reg' property encodes a triplet of
> +      <static-address BCR PID> used for device matching.
> +      Static address is optional if matching is done via PID.
> +
> +  nxp,interrupt-mode:
> +    type: boolean
> +    description: |
> +      Enables interrupt mode (TM = 1), where alerts are latched until
> +      cleared by a register read.
> +      Required for IBI support over I3C. On I2C, both interrupt and
> +      comparator mode support events.
> +
> +  nxp,fault-queue:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    description: |
> +      Number of consecutive temperature limit
> +      violations required before an alert is triggered.
> +      valid values:- 1, 2, 4 or 6.
> +      If unspecified, hardware default (2) is used.
> +
> +  assigned-address:
> +    true

Drop and instead we need to define i3c-peripheral-properties, just like
spi has. Then you reference here that file.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temp-sensor@48 {
> +            compatible = "nxp,p3t1755-iio";
> +            reg = <0x48>;
> +            nxp,interrupt-mode;
> +            nxp,fault-queue = <6>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +
> +  - |
> +    i3c {
> +      #address-cells = <3>;
> +      #size-cells = <0>;
> +      temp-sensor@48,236152a00 {
> +        reg = <0x48 0x236 0x152a00>;
> +        assigned-address = <0x50>;

This example is pretty incomplete.

> +      };
> +    };


Best regards,
Krzysztof

