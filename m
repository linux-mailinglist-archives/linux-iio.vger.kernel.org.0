Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D711E96E8
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEaKTU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaKTT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:19:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFFA20707;
        Sun, 31 May 2020 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590920358;
        bh=2YCsEk60doZYjemvV6V2oezEz2eOnaYsBKkvBvxc8TA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XaQyYQwFjFwkXHgrYhw14E+183rjpqxyUctVWdF3IXB8K9tX4QHLBYXfsIBKt2/kS
         vF9tYKu/+q+sTk/3yD4Uv3UNbKrCAhs4u76JWIXkl4JFqiFoEeBUXrHc/uH41btMIj
         Tn9pwG0UEwTF+zBPZoZto379UeT0+qKnEM7UI+Us=
Date:   Sun, 31 May 2020 11:19:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200531111914.56dbff8b@archlinux>
In-Reply-To: <20200530213630.87159-5-tomasz.duszynski@octakon.com>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
        <20200530213630.87159-5-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 May 2020 23:36:30 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Add SCD30 sensor binding file.
> 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  .../iio/chemical/sensirion,scd30.yaml         | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> new file mode 100644
> index 000000000000..34cc3925d64d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sensirion,scd30.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SCD30 carbon dioxide sensor
> +
> +maintainers:
> +  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
> +
> +description: |
> +  Air quality sensor capable of measuring co2 concentration, temperature
> +  and relative humidity.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,scd30
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  sensirion,sel-gpios:
> +    description: GPIO connected to the SEL line
> +    maxItems: 1
> +
> +  sensirion,pwm-gpios:
> +    description: GPIO connected to the PWM line
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      scd30@61 {

Nodes should have generic names.  Not sure we have an appropriate
one in the spec, but as main focus of people using this will be
c02 herpas

	c02@61?  

Rob may well have a better suggestion!

> +        compatible = "sensirion,scd30";
> +        reg = <0x61>;
> +        vdd-supply = <&vdd>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +  - |
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    serial {
> +      scd30 {
> +        compatible = "sensirion,scd30";
> +        vdd-supply = <&vdd>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5db4b446c8ba..0ab9cf39e051 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15140,6 +15140,7 @@ F:	include/uapi/linux/phantom.h
>  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
>  M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
>  F:	drivers/iio/chemical/scd30.h
>  F:	drivers/iio/chemical/scd30_core.c
>  F:	drivers/iio/chemical/scd30_i2c.c

