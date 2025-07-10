Return-Path: <linux-iio+bounces-21556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D1B00EE1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F1D645240
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C482C1594;
	Thu, 10 Jul 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHT96495"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2042C08CE;
	Thu, 10 Jul 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187266; cv=none; b=AxmWRHBoxiXxTjpkM4YJHidEuxrP7s4QW4dS/fJAht62GRJ71ngMZVFZPmQ38wWxZDcdFRLRzH35HdKvyzoWVuWhlcfvYdS/ZOkobMTrtiI+G4ZMN8ii9049/lQiSdOQfJnQ0yHVP0q2YreagQINlUWYOosxL0N4G1fHOSeVce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187266; c=relaxed/simple;
	bh=DCoM3/ORILyE6XK0aOTBtanbbPJHqvQxanSreV7rd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFRIhr34HXog9JHvBqkSRzE55Cq/FdaRaGLBQ7u0ATMd5+8INW2D33iIUPdYTQAbtftpYkafodabm4FXVx+py5htEJz3xL91s/Sc71IFSDwOe3wZ95KkKfhm3NKeBX0gDbymK7FuecoCUheGcJf9XkEoKbJZiPftG48uRmzdSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHT96495; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937DDC4CEE3;
	Thu, 10 Jul 2025 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752187265;
	bh=DCoM3/ORILyE6XK0aOTBtanbbPJHqvQxanSreV7rd3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHT96495VGzP8HM4htHaF/Lu/1ra+4PqJD5Zk2RKFfngh14I517xd612iWBacLain
	 5tfFz25k1UGvY7n5rSZPaKoqb6pCSa4PXWds8U8mFk+f+Q43Ku/R3VF0FnVapfHh+W
	 fCe75kXPX0OxZYVpNuAyDH2iU+0lqv/pWggmFcEnRTOV/S4gN1curADqsAaaMXt6LO
	 VGW7MFfZ0RHJQiyI0OD7ps+VrZL8PBd2o+OeeiSSfQ8UIZk4HkxU0Kw51d+lBwBYXP
	 hnUR9YmvMplHiKJyjy7cyk1kdh6A8/1MgynalMm4Eu3LUAbJrxQ5fCWQ064J3ZsAWT
	 AFMVhel2C2oYA==
Date: Thu, 10 Jul 2025 17:41:04 -0500
From: Rob Herring <robh@kernel.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250710224104.GA4495-robh@kernel.org>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>

On Thu, Jul 10, 2025 at 08:57:56AM +0000, Remi Buisson wrote:
> Document the ICM-45600 devices devicetree bindings.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  .../bindings/iio/imu/invensense,icm45600.yaml      | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a651878791ffae8d1c8d6c8ff1e4becfc56af79f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> @@ -0,0 +1,138 @@
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
> +
> +  drive-open-drain:
> +    type: boolean
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
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
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm45605@68 {
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
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        icm45605@0 {
> +            compatible = "invensense,icm45605";
> +            reg = <0>;
> +            spi-max-frequency = <24000000>;
> +            interrupt-parent = <&gpio1>;
> +            interrupt-names = "INT1";
> +            interrupts = <6 IRQ_TYPE_EDGE_RISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "0", "-1", "0",
> +                           "1", "0", "0",
> +                           "0", "0", "1";
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i3c {
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +
> +        icm45606@68,46A00000084 {
> +            reg = <0x68 0x46A 0x84>;
> +            interrupt-parent = <&gpio1>;
> +            interrupt-names = "INT1";
> +            interrupts = <5 IRQ_TYPE_EDGE_RISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "0", "-1", "0",
> +                           "1", "0", "0",
> +                           "0", "0", "1";
> +        };
> +    };

I don't think we need 3 examples just for different buses being the only 
diff.

Rob

