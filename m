Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7363D1A983A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895206AbgDOJQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 05:16:40 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:40398 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895193AbgDOJQ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Apr 2020 05:16:28 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id BF03DE01FA; Wed, 15 Apr 2020 11:16:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1586942181; bh=ncylDpaKZtZ3lQN73jxuqouhPNIAVzjx8bLjlP9nz5k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mhtg0s+g0ilGFTzcsBfizbiURCnXTRRY1jX0Qb/JFJFYM5LSyE8sWSn8+3NVJlVCO
         5AS6xpO0shx+tUAqCmjgRX32ZBqzEpbLUHcmnrZXCGo7VrGoKGCsitOxujArgSoBuR
         HMc+e0mDtENmCVSP23nb8IED4MeTFgThhkbL/h5c=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id B46E9E019D;
        Wed, 15 Apr 2020 11:16:21 +0200 (CEST)
Date:   Wed, 15 Apr 2020 11:16:21 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
cc:     robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: add document bindings for wsen-itds
 accel sensor
In-Reply-To: <20200415065535.7753-3-saravanan@linumiz.com>
Message-ID: <alpine.DEB.2.21.2004151114590.22614@vps.pmeerw.net>
References: <20200415065535.7753-1-saravanan@linumiz.com> <20200415065535.7753-3-saravanan@linumiz.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="324302256-1364362776-1586942181=:22614"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324302256-1364362776-1586942181=:22614
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 15 Apr 2020, Saravanan Sekar wrote:

comments below, some typos

> Add device tree binding information for wsen-itds accel sensor driver.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/iio/accel/we,wsen-itds.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> new file mode 100644
> index 000000000000..165cdf71966d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/we,wsen-itds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Würth Elektronik WSEN-ITDS triaxial acceleration sensor
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +description: |
> +  Acceleration and temperature iio sensors with an i2c interface.

sensor

> +  The sensor provies additional application specific features like

provides

> +  tap detection, 6D Orinetation, Free-fall, Motion and Activity.

orientation

> +
> +properties:
> +  compatible:
> +    enum:
> +      - we,wsen-itds
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: phandle to the regulator that provides power to the accelerometer
> +
> +  vddio-supply:
> +    description: phandle to the regulator that provides power to the sensor's IO
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      accelerometer@18 {
> +        compatible = "we,wsen-itds";
> +        reg = <0x18>;
> +        vdd-supply = <&vdd>;
> +        vddio-supply = <&vddio>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
--324302256-1364362776-1586942181=:22614--
