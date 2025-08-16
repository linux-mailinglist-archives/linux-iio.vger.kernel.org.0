Return-Path: <linux-iio+bounces-22797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B55B28D66
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A662B3BAAC3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4982D0610;
	Sat, 16 Aug 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh8pD0Nd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB831DF742;
	Sat, 16 Aug 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755343529; cv=none; b=PK8JJPCkU3nT0KvaMwoTq3TcmuSK1NXBIlkstLyscoT9WGTWhz6hjQ9H90OV2I5bkU/DdpZCLpQDciZKMlqKAViNQtIw2kyn3xeZA82fDSSvAxWiKHeu71PdhDxoJ2aDH6NNW4lwaoEKMCTStUrRAWkXlahNXRzwW3k12CPGw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755343529; c=relaxed/simple;
	bh=5C84l4xZ1NV/v27biPkkCIjMZop57ZB3qzqqFyLS+jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAqjFhIjSArluVcPdkg77ww0ZAepa7ZqxmQQ6DAPXy5FYvswNEOoygOW4fpulzz8CWMvW59ukNFFMhoDH9CWi2DrIy3idAImILoMOhN7gGTMJvl8rpwwu4invRGZDh3cH7BprmQTfLAvNW19NcU6vVLFhyNWrZ98XIaRS91u8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh8pD0Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783CFC4CEEF;
	Sat, 16 Aug 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755343528;
	bh=5C84l4xZ1NV/v27biPkkCIjMZop57ZB3qzqqFyLS+jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kh8pD0Nda/J7JqycDC8vYqFJOKj/hlQH8ZKorpiXMMH6QJYWQn4+eQ7yIR7LmlSIK
	 CyQTBf6TYbpfC/8hnjmWCPI8InZzP+6G4pOqIcLbYvDjbBAxQII2ZC839QHzS68R/l
	 rn7FW9NsMM24vjPsyqGiAtTUWaCJkZW4zQAXLAYvwqXfHXFNiTQ/Red5W4+r3YOn2E
	 eIwFqpTdKu1sBmpMn0kYHfRDHp6YbG6/Gq8m96vnY9i03RNC1njN0EecIYjDC0qQW0
	 zP7NdYrFWI0cSRpenZSYNCRoCkvBIhglWUC+QRypcLRwPXRaZFnFWP5eOGIDN7nNV3
	 Ccy6BwIIxOU8Q==
Date: Sat, 16 Aug 2025 12:25:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250816122519.2c7a5d9e@jic23-huawei>
In-Reply-To: <20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:57:15 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Document the ICM-45600 devices devicetree bindings.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  .../bindings/iio/imu/invensense,icm45600.yaml      | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f43258124c32ebf850fc29b2e97643885e6f8480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/invensense,icm45600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-45600 Inertial Measurement Unit
> +
> +maintainers:
> +  - Remi Buisson <remi.buisson@tdk.com>
> +
> +description: |
> +  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
> +  accelerometer.
> +
> +  It has a configurable host interface that supports I3C, I2C and SPI serial
> +  communication, features up to 8kB FIFO and 2 programmable interrupts with
> +  ultra-low-power wake-on-motion support to minimize system power consumption.
> +
> +  Other industry-leading features include InvenSense on-chip APEX Motion
> +  Processing engine for gesture recognition, activity classification, and
> +  pedometer, along with programmable digital filters, and an embedded
> +  temperature sensor.
> +
> +  https://invensense.tdk.com/wp-content/uploads/documentation/DS-000576_ICM-45605.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - invensense,icm45605
> +      - invensense,icm45606
> +      - invensense,icm45608
> +      - invensense,icm45634
> +      - invensense,icm45686
> +      - invensense,icm45687
> +      - invensense,icm45688p
> +      - invensense,icm45689
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    description: Choose chip interrupt pin to be used as interrupt input.

See v1 review on this from Krzysztof that you seem to have missed.

> +
> +  drive-open-drain:
> +    type: boolean
> +
> +  vdd-supply:

Description doesn't add much so simply
  vdd-supply: true

Might be enough.

> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
Also very standard description so probably doesn't add anything.

> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix

Could do
  mount-matrix: true

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
Needed for any functionality to be available?
Note that this isn't a question of what driver currently requires, but
more what someone could implement if they happen not to have wired interrupts.

That happens annoyingly often!

Jonathan
> +  - interrupt-names
> +  - vdd-supply
> +  - vddio-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@68 {
> +            compatible = "invensense,icm45605";
> +            reg = <0x68>;
> +            interrupt-parent = <&gpio2>;
> +            interrupt-names = "INT1";
> +            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "0", "-1", "0",
> +                           "1", "0", "0",
> +                           "0", "0", "1";
> +        };
> +    };
> 


