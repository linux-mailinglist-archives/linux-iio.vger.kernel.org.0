Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BD29D9AA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbgJ1XAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Oct 2020 19:00:02 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:36241 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbgJ1W6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2020 18:58:52 -0400
X-Greylist: delayed 4197 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:58:52 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 50A65280074C8;
        Wed, 28 Oct 2020 21:31:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2536036696; Wed, 28 Oct 2020 21:31:40 +0100 (CET)
Date:   Wed, 28 Oct 2020 21:31:40 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Message-ID: <20201028203140.GA24407@wunner.de>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-17-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011170749.243680-17-jic23@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 06:07:36PM +0100, Jonathan Cameron wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC082s085 and similar DACs
> +
> +description:
> +  A familly of Texas Instruments 8/10/12-bit 2/4-channel DACs
           ^^
s/familly/family


> +  spi-cpha: true
> +  spi-cpol:
> +    description:
> +      Should be either spi-cpha, or spi-cpol but not both.
> +
> +  vref-supply: true
[...]
> +required:
> +  - compatible
> +  - reg

"vref-supply" and ("spi-cpha" xor "spi-cpol") are also requird
per the existing txt file.


> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "ti,dac082s085";
> +            reg = <0>;
> +            spi-max-frequency = <40000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vref-supply = <&vref_2v5_reg>;
> +        };
> +    };

Hm, why wasn't the "vref_2v5_reg" node carried over from the txt file?

Thanks,

Lukas
