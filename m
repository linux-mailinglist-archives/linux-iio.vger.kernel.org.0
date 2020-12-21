Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2072E0040
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 19:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgLUSpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 13:45:18 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46942 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgLUSpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 13:45:17 -0500
Received: by mail-oi1-f177.google.com with SMTP id q205so12193357oig.13;
        Mon, 21 Dec 2020 10:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWBYjY6yUTnOC9KU1g2rDC6EQI4nGKdxUE9a6H16YTA=;
        b=bdjl6YwQWS1gxehInNbUKe2ro/JVraYpd0TipJsVhbnm6PxrtKjv6dS7LSTfekuOx+
         aAYE9+79SVRR4WK6urVOFFQ045wkki/HDx7vTATJGyuEtvubZrpK91djBjFqteTAlB1K
         BYABYY+Jlr3lvxqv1F45oD5DubHMQTotD+JRRxDxJQ5F2l0rjvZCFWaCAF/YzdiVYRuq
         TECo56lpX05jR4pYLv3UoyylHmGu1lDFG291/OQIfOm3KrngpgL7XCkKDmOGWdzRQ2Wg
         GWvOE2BsF01i5sZ9aieHZka1NbecUjVu8237d7aV3cZa8OmimWCuKVquPO7ESgMG+Dse
         +PVg==
X-Gm-Message-State: AOAM530A2/Bm0tKywtglIQK/Tx2pPJh3iaoD0sGarbVQhdYDP5zSwYuG
        2j5yFVacCwwbyVi/7ONxbBPiklCssg==
X-Google-Smtp-Source: ABdhPJxSTwka874noWHFkT1NgVKEOOgBGUJtsWNuYPFuZ8cOJ0ovZKYke7z3cf9FGFFrXRvd+BGrnw==
X-Received: by 2002:a05:6808:3c3:: with SMTP id o3mr12307111oie.24.1608576276873;
        Mon, 21 Dec 2020 10:44:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h30sm3407306ooi.12.2020.12.21.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:44:36 -0800 (PST)
Received: (nullmailer pid 339755 invoked by uid 1000);
        Mon, 21 Dec 2020 18:44:34 -0000
Date:   Mon, 21 Dec 2020 11:44:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201221184434.GA331914@robh.at.kernel.org>
References: <20201218171231.58794-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218171231.58794-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 18, 2020 at 07:12:29PM +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  Changelog v4:
> 	- Add range selection
> 	- Reset is GPIO_ACTIVE_LOW
> 	
>  .../bindings/iio/dac/adi,ad5766.yaml          | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> new file mode 100644
> index 000000000000..846b5ee50761
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5766 DAC device driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5766
> +      - adi,ad5767
> +
> +  output-range:
> +    description: Select converter output range.

Something standard for DACs? If not needs a vendor prefix and type. 

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be asserted
> +      during driver probe. As the line is active low, it should be marked
> +      GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - output-range
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          
> +          ad5766@0 {
> +              compatible = "adi,ad5766";
> +              output-range = <(-5) 5>;
> +              reg = <0>;
> +              spi-cpol;
> +              spi-max-frequency = <1000000>;
> +              reset-gpios = <&gpio 22 0>;
> +            };
> +      };
> -- 
> 2.17.1
> 
