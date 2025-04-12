Return-Path: <linux-iio+bounces-18029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782CA86EB7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9213A64FA
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D902080F4;
	Sat, 12 Apr 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4W8VFri"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282601C3C08;
	Sat, 12 Apr 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482278; cv=none; b=rq4Jf8Q8o8dMfBSO76uEJ+MUS703rODEskqk1E8dC98YYF+XeejgMbd1wfjbLYJw4OusOgdcmh0x5ypLimtVIo4F1JoCcdhMnVCr0xWJNH3FTZQvTNBG+p4zsfHIadZbt18obk6wdDySAnE/++Ex7phWZCvkUqRQLLv7fhvD1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482278; c=relaxed/simple;
	bh=ChJ9V0Jc/+b3HPY0a+HA52laHzIuwkZ7RdLSpf1yLcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+gNul5t0u5ZDds12e8ntG6S2Y578IvxIGNWTP7Uk/rBDB4Ml1KO/hdv2ZIa78gMknoD9l7gaYCC9fDYQj0LcmiIVg3h6jkxdBIO1iUqxmNRczgIX7RYo6KRHf8HdwuwlId6GAAsS/vTibR4CwqsfecvQC6uxYKya0KC0q55Nf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4W8VFri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0409CC4CEE3;
	Sat, 12 Apr 2025 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744482277;
	bh=ChJ9V0Jc/+b3HPY0a+HA52laHzIuwkZ7RdLSpf1yLcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4W8VFritsK1NPGVLVvivYuuLrGOKNRwcpW0lvUtj+SimKmUJj8ejIBGHZsYo/rc9
	 PCBpUv0bV+4xEr5+XRDWzUHv/YLJD9Qx0atgQe4eNud+e/6M4h8YgD2wFr9zp9KEgE
	 G6SBq/mgRpeJjgPZ42Fzi261s4uAC6z+D8M1jA1lOaxpUhRmYWf6xyyA6e7yas1gXu
	 e5oHzsrIw3JDNV8ODROCmRDNCaywiGhrbtvM89dv5WGILBh55zqtsgI+15AF7SbGD0
	 GqTcORsS/oQJouiK9Ny+od7BLIH+aLh0seFCy66fDkiJOct7/Yam+rFpGxWGguskh8
	 IHdew1XrSxL6Q==
Date: Sat, 12 Apr 2025 19:24:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600
 documentation
Message-ID: <20250412192428.1938b08c@jic23-huawei>
In-Reply-To: <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
	<20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 13:28:39 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Document the ICM-456xxx devices devicetree bindings.
> Describe custom sysfs API for controlling the power modes.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++
>  .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
>  2 files changed, 173 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600 b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d2d9b68ad9e35fe0d6c157e984afc327eab92ec
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
> @@ -0,0 +1,37 @@

As has been noted, wrong place. This goes in the patch with the relevant ABI
being added to the driver.

> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Accelerometer power mode. Setting this attribute will set the
> +		requested power mode to use if the ODR support it. If ODR
> +		support only 1 mode, power mode will be enforced.
If the mode id enforced, then the ODR will change?  I hope not. ODR should dominate here
though note you should match ABI terms anyway so sampling_frequency.

Also as noted, these already exist in some form in the main docs. Add entries
there.

> +		Reading this attribute will return the current accelerometer
> +		power mode if the sensor is on, or the requested value if the
> +		sensor is off. The value between real and requested value can
> +		be different for ODR supporting only 1 mode.

I'd just fail the set. If the ODR is changed in a fashion that requires this
to change, just do it and have this attribute return the new value. All ABI
is allowed when necessary to have side effects on other IIO ABI elements.
We try to keep that as intuitive as possible, but sometimes the hardware
puts very complex requirements on us.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode_available
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of available accelerometer power modes that can be set in
> +		in_accel_power_mode attribute.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_power_mode
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Gyroscope power mode. Setting this attribute will set the
> +		requested power mode to use if the ODR support it. If ODR
> +		support only 1 mode, power mode will be enforced.
> +		Reading this attribute will return the current gyroscope
> +		power mode if the sensor is on, or the requested value if the
> +		sensor is off. The value between real and requested value can
> +		be different for ODR supporting only 1 mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_power_mode_available
> +KernelVersion:	6.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of available gyroscope power modes that can be set in
> +		in_anglvel_power_mode attribute.


> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..51455f0b5cb90abdd823f154e45891ad364296e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/invensense,icm45600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: InvenSense ICM-456xx Inertial Measurement Unit
I'd go with Invensense ICM-45600 and similar Inertial Measurement Units.

We have been bitten too many times in the past by wild cards and manufacturers
who love to put something in a numbering scheme for marketing reasons (or just
because they feel like it) rather than because they are in any way related
at the hardware level.

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

Alpha numeric order for these.

> +      - invensense,icm45686
> +      - invensense,icm45688p
> +      - invensense,icm45608
> +      - invensense,icm45634
> +      - invensense,icm45689
> +      - invensense,icm45606
> +      - invensense,icm45687
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
For really 'standard' supplies like these it is also acceptable to just
do
    vdd-supply: true
    vddio-supply: true

When description adds little there is no need to give one.

> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
I think you need
    mount-matrix: true
as well.

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
> +            interrupts = <7 IRQ_TYPE_EDGE_RAISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "1", "0", "0",
> +                           "0", "1", "0",
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
> +            interrupts = <6 IRQ_TYPE_EDGE_RAISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "1", "0", "0",
> +                           "0", "1", "0",
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
> +        icm45600@68,46A00000011 {
> +            compatible = "invensense,icm45600";
> +            reg = <0x68 0x46A 0x84>;
> +            interrupt-parent = <&gpio1>;
> +            interrupt-names = "INT1";
> +            interrupts = <5 IRQ_TYPE_EDGE_RISING>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            mount-matrix = "1", "0", "0",
> +                           "0", "1", "0",
> +                           "0", "0", "1";
> +        };
> +    };
> 


