Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B512BC733
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgKVQnn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 11:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgKVQnm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 11:43:42 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA2B20781;
        Sun, 22 Nov 2020 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606063422;
        bh=tFZCReQWVh7manOveUs7U/EUZnuHPgVgPPgH6zUaH1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m9lx3dxzNA7QZvg+8/4oPmZN6cyEv3zSYLA95bq7Bm6WW+Jc84fF7WZXQCiU+N8mI
         LMj8/uYDD76WlAuWxEs3OAGS1qzx5V6MQM30aaYPDttIPtO5H8uv/yYZYCdhaksDA0
         aAHDj3l9crRf/qHtfhLoqUu1kulNhsTuVWxvWMec=
Date:   Sun, 22 Nov 2020 16:43:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/46] dt-bindings:iio:samsung,sensorhub-rinato: yaml
 conversion
Message-ID: <20201122164339.12f4c028@archlinux>
In-Reply-To: <20201031184854.745828-7-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-7-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Renamed to be more specific as I would be surprised if this is the only
> sensorhub Samsung have ever shipped.
> Fixed missing reg property in the example
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Karol Wrona <k.wrona@samsung.com>

Karol's email address is bouncing so I've put myself as maintainer of this
binding.  I'm more than happy to hand it over to someone else if anyone
steps forward.

Applied to the togreg branch of iio.git and pushed out as test for
the autobuilders to possible poke at it.

Thanks,

Jonathan

> ---
>  .../iio/samsung,sensorhub-rinato.yaml         | 72 +++++++++++++++++++
>  .../devicetree/bindings/iio/sensorhub.txt     | 24 -------
>  2 files changed, 72 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
> new file mode 100644
> index 000000000000..62366cbd37e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/samsung,sensorhub-rinato.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Sensorhub driver
> +
> +maintainers:
> +  - Karol Wrona <k.wrona@samsung.com>
> +
> +description: |
> +  Sensorhub is a MCU which manages several sensors and also plays the role
> +  of a virtual sensor device.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,sensorhub-rinato
> +      - samsung,sensorhub-thermostat
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ap-mcu-gpios:
> +    maxItems: 1
> +    description:
> +      Application Processor to sensorhub line - used during communication
> +
> +  mcu-ap-gpios:
> +    maxItems: 1
> +    description:
> +      Sensorhub to Application Processor - used during communication
> +
> +  mcu-reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reset the sensorhub.
> +
> +  spi-max-frequency: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ap-mcu-gpios
> +  - mcu-ap-gpios
> +  - mcu-reset-gpios
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sensorhub@0 {
> +            compatible = "samsung,sensorhub-rinato";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            interrupt-parent = <&gpx0>;
> +            interrupts = <2 0>;
> +            ap-mcu-gpios = <&gpx0 0 0>;
> +            mcu-ap-gpios = <&gpx0 4 0>;
> +            mcu-reset-gpios = <&gpx0 5 0>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/sensorhub.txt b/Documentation/devicetree/bindings/iio/sensorhub.txt
> deleted file mode 100644
> index b6ac0457d4ea..000000000000
> --- a/Documentation/devicetree/bindings/iio/sensorhub.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Samsung Sensorhub driver
> -
> -Sensorhub is a MCU which manages several sensors and also plays the role
> -of a virtual sensor device.
> -
> -Required properties:
> -- compatible: "samsung,sensorhub-rinato" or "samsung,sensorhub-thermostat"
> -- spi-max-frequency: max SPI clock frequency
> -- interrupts: communication interrupt
> -- ap-mcu-gpios: [out] ap to sensorhub line - used during communication
> -- mcu-ap-gpios: [in] sensorhub to ap - used during communication
> -- mcu-reset-gpios: [out] sensorhub reset
> -
> -Example:
> -
> -	shub_spi: shub {
> -		compatible = "samsung,sensorhub-rinato";
> -		spi-max-frequency = <5000000>;
> -		interrupt-parent = <&gpx0>;
> -		interrupts = <2 0>;
> -		ap-mcu-gpios = <&gpx0 0 0>;
> -		mcu-ap-gpios = <&gpx0 4 0>;
> -		mcu-reset-gpios = <&gpx0 5 0>;
> -	};

