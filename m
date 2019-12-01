Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC510E177
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLAK6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 05:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLAK6d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 05:58:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9570E20833;
        Sun,  1 Dec 2019 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575197913;
        bh=T3BCPZb+DEtCnqd72UKbIa5lrWksL4BLMpWGzxUovyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A/Quld9/z6SGlqhLMkZEw2ILifLLgyWyaBMCCc7UN+hwrK7IpMDYO74a8y2+2E1EW
         mlDRTw7LkqE9ZD94+Evx6r5752oO+gXR2iaPJYTom7wyq6AhcgzyosFwfufl+t62BX
         xntxkO+rOSArHcKhJVhlGy7gLyyo6R2pq6hIxFu0=
Date:   Sun, 1 Dec 2019 10:58:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] bindings: iio: pressure: Add dlh-i2c
 documentation
Message-ID: <20191201105829.79a04b90@archlinux>
In-Reply-To: <20191129073420.9800-4-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191129073420.9800-1-tomislav.denis@avl.com>
        <20191129073420.9800-4-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 08:34:20 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for DLH series pressure
> sensors.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Looks good to me, but I'll leave some time for others to take a look.

> ---
>  .../bindings/iio/pressure/asc,dlh-i2c.yaml         | 51 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> new file mode 100644
> index 0000000..5de2277
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/dlh-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: All Sensors DLH series low voltage digital pressure sensors
> +
> +maintainers:
> +  - Tomislav Denis <tomislav.denis@avl.com>
> +
> +description: |
> +  Bindings for the All Sensors DLH series pressure sensors.
> +
> +  Specifications about the sensors can be found at:
> +    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asc,dlhl60d
> +      - asc,dlhl60g
> +
> +  reg:
> +    description: I2C device address
> +    maxItems: 1
> +
> +  interrupts:
> +    description: interrupt mapping for EOC(data ready) pin
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
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pressure@29 {
> +          compatible = "asc,dlhl60d";
> +          reg = <0x29>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <10 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39d6f0f..8f0eab0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -674,6 +674,7 @@ W:	http://www.allsensors.com/
>  S:	Maintained
>  L:	linux-iio@vger.kernel.org
>  F:	drivers/iio/pressure/dlh-i2c.c
> +F:	Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
>  
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>

