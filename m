Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D637DB5E78
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfIRH77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:59:59 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:48328 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfIRH76 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Sep 2019 03:59:58 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 03:59:58 EDT
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 5567BE0387; Wed, 18 Sep 2019 09:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1568793095; bh=qUhIXx3DaSHravNW0tGD9tyRrUWWCRu2AVYFYwSsJO8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cUDXgOqAM2y8N93lvRiEsAz/PzkKGdRl8f4HutLlcNGIZKDUq7P1S5XvwWGCnshe/
         NnagnmymM3jQojKEE4RMNFXBlhI+GvglQehZNmyUXRY/4O7y3iFqAC3qlHr5+AelxX
         s92OJH5rN+5kf7S+/vY1rm2LFIUvymAXsirZgyXI=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2C466E0353;
        Wed, 18 Sep 2019 09:51:35 +0200 (CEST)
Date:   Wed, 18 Sep 2019 09:51:35 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Rishi Gupta <gupt21@gmail.com>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: add veml6030 ALS bindings
In-Reply-To: <1568776157-5373-3-git-send-email-gupt21@gmail.com>
Message-ID: <alpine.DEB.2.21.1909180950030.31639@vps.pmeerw.net>
References: <1568776157-5373-1-git-send-email-gupt21@gmail.com> <1568776157-5373-3-git-send-email-gupt21@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Sep 2019, Rishi Gupta wrote:

> This commit adds device tree bindings for veml6030 ambient
> light sensor.

comment below
 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> new file mode 100644
> index 0000000..d92684a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VEML6030 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Rishi Gupta <gupt21@gmail.com>
> +
> +description: |
> +  Bindings for the ambient light sensor veml6030 from Vishay
> +  Semiconductors over an i2c interface.
> +
> +  Irrespective of whether interrupt is used or not, application
> +  can get the ALS and White channel reading from IIO raw interface.
> +
> +  If the interrupts is used, application will receive an IIO event

interrupts are used

> +  whenever configured threshold is crossed.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.vishay.com/docs/84366/veml6030.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,veml6030
> +
> +  reg:
> +    description:
> +      I2C address of the device. If the ADDR pin on veml6030
> +      is pulled up, this address is 0x48. If the ADDR pin is
> +      pulled down, this address is 0x10.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
> +      Refer to interrupt-controller/interrupts.txt for generic
> +      interrupt client node bindings.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +                compatible = "vishay,veml6030";
> +                reg = <0x10>;
> +                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
