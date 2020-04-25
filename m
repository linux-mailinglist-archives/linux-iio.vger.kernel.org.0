Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D1A1B88DF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDYTXq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgDYTXq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:23:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C36C20714;
        Sat, 25 Apr 2020 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587842625;
        bh=7xT0CJYyctX/za7aIrPT0FcmDTrVX7/KZzusycnTbGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HlFvJ60PnH+YbWSiAq1+P2/m+MDmT6K00GWCV+Tybx27lZ+AmLnOGjBguupwtuZGA
         LwhXG/kM9+lK9PqhusGz3PXPLKBbCJ/TdADnsMbeyeNxVso1eRebrPJ3GtKEhmTzph
         phMiQdBDzDbrA2j/h9gdDZXLV6/s+ybloqg2Q6o0=
Date:   Sat, 25 Apr 2020 20:23:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200425202341.53e614d8@archlinux>
In-Reply-To: <20200422141135.86419-6-tomasz.duszynski@octakon.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
        <20200422141135.86419-6-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 16:11:34 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Add SCD30 sensor binding file.
> 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  .../iio/chemical/sensirion,scd30.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> new file mode 100644
> index 000000000000..b092b2530c76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license preferred with BSD for bindings.

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
> +  - vdd-supply

Only enable it I think in the driver.  Should be fine with a stub regulator
as provided if we don't specify one in the dt binding because it's not
controllable and we are lazy.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    # include <dt-bindings/gpio/gpio.h>
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      scd30@61 {
> +        compatible = "sensirion,scd30";
> +        reg = <0x61>;
> +        vdd-supply = <&vdd>;
> +        interrupt-parrent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +  - |
> +    # include <dt-bindings/gpio/gpio.h>

Why gpio?

> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    serial {
> +      scd30 {
> +        compatible = "sensirion,scd30";
> +        vdd-supply = <&vdd>;
> +        interrupt-parrent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +
> +...

