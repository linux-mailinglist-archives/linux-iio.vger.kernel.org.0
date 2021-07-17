Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A083CC436
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhGQPjj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 11:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236355AbhGQPjh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 11:39:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165BB6109E;
        Sat, 17 Jul 2021 15:36:37 +0000 (UTC)
Date:   Sat, 17 Jul 2021 16:39:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 3/4] dt-bindings: iio: imu: add bosch BNO055 serdev
 driver bindings
Message-ID: <20210717163900.657ec48b@jic23-huawei>
In-Reply-To: <20210715141742.15072-4-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20210715141742.15072-4-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Jul 2021 16:17:41 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Introduce new documentation file for the BNO055 serdev driver that will
dt bindings are for the device not the driver (so don't mention driver
in the binding or the patch description).

> be included in next patches of this same series
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Cc: Andrea Merello <andrea.merello@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  .../bindings/iio/imu/bosch,bno055-serial.yaml | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml
> new file mode 100644
> index 000000000000..743c784ebc94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055-serial.yaml

Better to have just one doc covering this interface and i2c if that gets added.

> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bno055-serial.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Serial-attached Bosch BNO055
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>

That's just mean!  I have plenty of these to look after already! Joking
aside, you'd be a better maintainer for this than me as more likely
to pay attention.

> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
> +  internal MCU for sensor fusion
> +  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
> +
> +properties:
> +  compatible:
> +    enum:
> +     - bosch,bno055-serial
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   bno055 {

name needs to be the one for the device type found in the device tree spec or
if it's not there, something in same 'spirit'.  Probably imu here

> +      compatible = "bosch,bno055-serial";
Don't need the -serial. It will bind based on the bus this is under.
Speaking of which, it's normal to provide that bus info as part of the example.
See for example chemical/sensiron,scd30.yaml

> +      reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
> +      clocks = <&imu_clk>;
> +   };

