Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400AA1AB108
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441552AbgDOTId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411734AbgDOTH1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 15:07:27 -0400
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7532C061A10;
        Wed, 15 Apr 2020 12:07:26 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 0D51AE0851; Wed, 15 Apr 2020 21:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1586977644; bh=6kKOP9MD30yOGMfU+pNu0Hgt58IVDIYTyfhvXAfdje0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mvLltGiKZ+SX2dhw5gFV0PSGDlLVI3B7O6o+hVS9+bm6kTo0egsMam0IEMDoqmmkM
         JiMZ7smuPvSLFzgBjG07AW72uF4kJ51b5hV3V105DT2NFfWRCIrQGamAuoCipS1i1k
         79CO93pFUwKpy5vbDTz3WBplGLZgTODVoB5wY8LU=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 028A8E0451;
        Wed, 15 Apr 2020 21:07:24 +0200 (CEST)
Date:   Wed, 15 Apr 2020 21:07:23 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Saravanan Sekar <sravanhome@gmail.com>
cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 1/6] dt-bindings: mfd: add document bindings for
 mp2629
In-Reply-To: <20200415162030.16414-2-sravanhome@gmail.com>
Message-ID: <alpine.DEB.2.21.2004152106160.18914@vps.pmeerw.net>
References: <20200415162030.16414-1-sravanhome@gmail.com> <20200415162030.16414-2-sravanhome@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020, Saravanan Sekar wrote:

comment below

> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> new file mode 100644
> index 000000000000..e71c554802a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +description: |
> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
> +  wireless camera and portable devices. Chip is contrlled over I2C.

controlled

> +
> +  The battery charge management device handles battery charger controller and
> +  ADC IIO device for battery, system voltage
> +
> +properties:
> +  compatible:
> +    const: mps,mp2629
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      The first cell is the IRQ number, the second cell is the trigger type.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c@7e205000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@4b {
> +            compatible = "mps,mp2629";
> +            reg = <0x4b>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gpio2>;
> +            #interrupt-cells = <2>;
> +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
