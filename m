Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDBC3B97DD
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGAVA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 17:00:56 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:39498 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhGAVAz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 17:00:55 -0400
Received: by mail-il1-f175.google.com with SMTP id o10so7756997ils.6;
        Thu, 01 Jul 2021 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2zgru6MXd5SLDqd7wCexHPvv0BJAK0xYITph2LIZkqk=;
        b=YakfgHUJ5lf+43H2C6hDwrY754yU8as/YhEm4SeRg00sTqGyDF71Y36vGTXyPcVhOR
         XcpS5j+q5ySTjIEyLyLyM/itj+wg05U4x0NToZlyJIgNWeFggXnLX7Sv72GXXyGlIPuo
         D99WtvR+r9zWQ+egCIG2R03nqn7t4G5uz3p0S4Ki5CaPu/sZsf2ZctYnqibSqe92i/Rh
         2jJ/NG+lPyFQOBHvEuUNgyt4zzoPxvE2D8t7Nnn7shYkEsXt+0Xr39pk2aq4agMYrf8/
         ce0TF6EFU7n5HhLMCLXuPfwCm1TSHkovvOj3Nt7qmJu8/9zurlMxcJb97lfmybWXGyW1
         iTDQ==
X-Gm-Message-State: AOAM532tA9PfhLFwr56DdnEUVbVSOUR4y0pQdUG5Qy0t4zL0wGHfvAGu
        sRtOHCt690Lcm5IYlI408K5QHkNAPw==
X-Google-Smtp-Source: ABdhPJwW8911boFOGNQfh4nPrBd7wObIw3u3HGnQK8FcHUewDKuBkE/Uszk0UQIzs+feZmwzyCth5A==
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr991312ile.274.1625173104539;
        Thu, 01 Jul 2021 13:58:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p6sm564839ilg.68.2021.07.01.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 13:58:23 -0700 (PDT)
Received: (nullmailer pid 2920053 invoked by uid 1000);
        Thu, 01 Jul 2021 20:58:19 -0000
Date:   Thu, 1 Jul 2021 14:58:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: frequency: add adrf6780 doc
Message-ID: <20210701205819.GA2912677@robh.at.kernel.org>
References: <20210701141648.131776-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701141648.131776-1-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 01, 2021 at 05:16:48PM +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ADRF6780 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> v3: remove `adi,parity-en` from example after latest changes in v2 
>  .../bindings/iio/frequency/adi,adrf6780.yaml  | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> new file mode 100644
> index 000000000000..b191d98bf778
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adrf6780.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADRF6780 Microwave Upconverter
> +
> +maintainers:
> +- Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   wideband, microwave upconverter optimized for point to point microwave

Wideband

> +   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.

blank line

> +   https://www.analog.com/en/products/adrf6780.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adrf6780
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock (see clock/clock-bindings.txt)

Drop the reference.

> +    minItems: 1
> +
> +  clock-names:
> +    description:
> +      Must be "lo_in"

Looks like a constraint...

clock-names:
  items:
    - const: lo_in

> +    maxItems: 1
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  adi,vga-buff-en:
> +    description:
> +      VGA Buffer Enable.
> +    type: boolean
> +
> +  adi,lo-buff-en:
> +    description:
> +      LO Buffer Enable.
> +    type: boolean
> +
> +  adi,if-mode-en:
> +    description:
> +      IF Mode Enable.
> +    type: boolean
> +
> +  adi,iq-mode-en:
> +    description:
> +      IQ Mode Enable.
> +    type: boolean
> +
> +  adi,lo-x2-en:
> +    description:
> +      LO x2 Enable.
> +    type: boolean
> +
> +  adi,lo-ppf-en:
> +    description:
> +      LO x1 Enable.
> +    type: boolean
> +
> +  adi,lo-en:
> +    description:
> +      LO Enable.
> +    type: boolean

Do the other adi,lo-* properties depend on this one? If so, add 
'dependencies' schema.

Any other property dependencies or mutual exclusion?

> +
> +  adi,uc-bias-en:
> +    description:
> +      UC Bias Enable.
> +    type: boolean
> +
> +  adi,lo-sideband:
> +    description:
> +      Switch to the Other LO Sideband.
> +    type: boolean
> +
> +  adi,vdet-out-en:
> +    description:
> +      VDET Output Select Enable.
> +    type: boolean
> +

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

No child nodes, what are these for?

> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +- compatible
> +- reg
> +- clocks
> +- clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +- |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      adrf6780@0{

space              ^

> +        compatible = "adi,adrf6780";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&adrf6780_lo>;
> +        clock-names = "lo_in";
> +      };
> +    };
> +...
> +
> -- 
> 2.32.0
> 
> 
