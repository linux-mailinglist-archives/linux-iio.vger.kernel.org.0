Return-Path: <linux-iio+bounces-17979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548FA8680E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364797AA24A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE329614A;
	Fri, 11 Apr 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm2xcQ3t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E93284B33;
	Fri, 11 Apr 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406210; cv=none; b=iXzWfjZvLeQ/zhszLC1erULF4Xi/znPS9ESWBAHd4U4NBZrpuEOOPxUDD6kjZZk439xmHIs0mbQg2eBU+spduzqPXX4X6rKsTF5DYmnelRrafVQV5TdD7AtcKoPwQpJvt//nEiwGeeazwbZ7IwSuJXUjXLfpEPzclPhiOwWl5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406210; c=relaxed/simple;
	bh=k1nWT9Gl30GmoaxSQzyEt6FB9frMtta2Qaej68P2cxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbhP8N+cZwhFjFaekaBFkQD2FXj3B1fWshpswwPDH+CXkfGDyB9gUfc1GCdeSkxBo9v6759G//XuhYLsdHpq/GUsDXjWNk285ooRp8J4kgwgePHOTQjGMTqiJB5e1l8cNnVW81L2bvtOI5VtXA2bTve/1eNsE1q4N2rB61qrXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm2xcQ3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A45C4CEE2;
	Fri, 11 Apr 2025 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744406209;
	bh=k1nWT9Gl30GmoaxSQzyEt6FB9frMtta2Qaej68P2cxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm2xcQ3tHN2SVRQ6lazMXz307MQQs98FPsuztnmvnGd/VQnwnTNnC2w1bA2awKb/h
	 cpq6cXmU4yWyHAK4v2+rF56mUyGByboScps4vXo9RYgv4wGzHfAVaoDcSQ8seP218K
	 h90vL/JxV2Zqfaz7zmtvhTicTTwrcVKI/RXmf4LJBWtKsdW0CohEYhJhT/kVjmpSph
	 2A/FjJSzyiXAYEsPamkndGW51Wbe1Cb9peIfLMfg+EDyC1QsoFC/o4g20bycZs/6U2
	 xoKZEYKKbQtcSweMhV+K1/8dPoG/2p8YC+NIj6RPmr1rz+ZmWBua6tKz228yFnuIZh
	 TeMM2LrbnvgtQ==
Date: Fri, 11 Apr 2025 16:16:47 -0500
From: Rob Herring <robh@kernel.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600 documentation
Message-ID: <20250411211647.GA4049879-robh@kernel.org>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
 <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>

On Fri, Apr 11, 2025 at 01:28:39PM +0000, Remi Buisson wrote:
> Document the ICM-456xxx devices devicetree bindings.
> Describe custom sysfs API for controlling the power modes.

You can drop 'documentation' from the subject.

> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++

This goes in the patch adding the sysfs files.

>  .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
>  2 files changed, 173 insertions(+)


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
> +      - invensense,icm45686
> +      - invensense,icm45688p
> +      - invensense,icm45608
> +      - invensense,icm45634
> +      - invensense,icm45689
> +      - invensense,icm45606
> +      - invensense,icm45687

sort in alpanumeric order

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
> -- 
> 2.34.1
> 

