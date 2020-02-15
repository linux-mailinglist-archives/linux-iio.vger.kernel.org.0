Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11B15FF64
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgBORBB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBORBA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:01:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831F82083B;
        Sat, 15 Feb 2020 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581786060;
        bh=rpN9KSwCeWF3MfgKjBVx8LSSwJenIzc6kg5Nd3scvZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/Cp2TAUQTiPZiCyD5WErFRVo97f3lJ02dZEZdCxL4pgeGmHPFO6nwhj8R5SlJO8d
         GIw739tzH+MxEAWBt6m5L/qJOCHa5TkB1gIw+CZt0HEjPOhWZJa0KhgFP8JNNnOo+n
         sxMGPxfKpBm5vs5FgfRgP6/dMsyfYpUDnKZ0/S2I=
Date:   Sat, 15 Feb 2020 17:00:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
Message-ID: <20200215170055.32e63892@archlinux>
In-Reply-To: <20200211191201.1049902-3-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-3-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:56 +0100
David Heidelberg <david@ixit.cz> wrote:

> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
Applied with name tweaked as per patch 1.

Thanks,

Jonathan

> ---
> v5
>  - drop requirement on interrups and vdd-supply
>  - s/al3010@1c/light-sensor@1c/
>  - dual license also under BSD
> 
>  .../devicetree/bindings/iio/light/al3010.yaml | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/al3010.yaml b/Documentation/devicetree/bindings/iio/light/al3010.yaml
> new file mode 100644
> index 000000000000..fdd1e5fa9c74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/al3010.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/al3010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dyna-Image AL3010 sensor
> +
> +maintainers:
> +  - David Heidelberg <david@ixit.cz>
> +
> +properties:
> +  compatible:
> +    const: dynaimage,al3010
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
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
> +        light-sensor@1c {
> +            compatible = "dynaimage,al3010";
> +            reg = <0x1c>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupts = <0 99 4>;
> +        };
> +    };

