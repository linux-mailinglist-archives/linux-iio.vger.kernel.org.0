Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D98360EFA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhDOP3D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:29:03 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36809 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDOP27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:28:59 -0400
Received: by mail-ot1-f54.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso12293449oto.3;
        Thu, 15 Apr 2021 08:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LY2vHNrmJ4VUycAazocxqw3arHIPlisaAEbMlRrHfuA=;
        b=JpKS5WQDRJ8egbWOLdLe0JFUO2Kn4wu4lrhWtuKFGD9RliM5aQLZeKEiesVQqpcPcw
         YgoXkELh2Lpo0+6J5rI0vAJOvkz3vwEmAJe+Y2KmuIvR5qCSsLuWEe5Q54vkfyTKUMKu
         Xar+sGfm/F1vWEqsGttAVv3OkmeyxN3VlMm7+NeSm3b/wJAy2JfmNZYlaiIabwdeWw4O
         6T6rHaqb439biHIZRVIQTHzMnDVUcYxuLMJA0aY0Dg26YS4LlVBA4UjwYRJ1mz6IOe7e
         NgP0148RbiZZM1C+8L5Qs1qklqCmDLnlnAAF53MMzGkwPD4ajs3rY8Tjonl6gQDCy0E5
         v1uw==
X-Gm-Message-State: AOAM5326gpi55XWoE5u5f2n9kQHfIv0+ZTSP8GI8IvXL83rej6fAD7Tw
        FQ8dAUoIB4nzY48+WGa2fw==
X-Google-Smtp-Source: ABdhPJyuitY4IZ7OhIqikWDYKogmNDpN89u+6/jcyczELxvIXG5/NLczw7e5Fdi4UcboAcNqULLZpA==
X-Received: by 2002:a05:6830:14d2:: with SMTP id t18mr3200750otq.50.1618500514833;
        Thu, 15 Apr 2021 08:28:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j20sm598274ooc.29.2021.04.15.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:28:33 -0700 (PDT)
Received: (nullmailer pid 1436466 invoked by uid 1000);
        Thu, 15 Apr 2021 15:28:32 -0000
Date:   Thu, 15 Apr 2021 10:28:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add bindings
Message-ID: <20210415152832.GA1433608@robh.at.kernel.org>
References: <20210415114614.1071928-1-sean@geanix.com>
 <20210415114614.1071928-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415114614.1071928-2-sean@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 15, 2021 at 01:46:14PM +0200, Sean Nyekjaer wrote:
> Add devicetree binding for the NXP FXLS8962AF/FXLS8962AF
> accelerometer sensor.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  .../bindings/iio/accel/nxp,fxls8962af.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> new file mode 100644
> index 000000000000..8cf099c75d1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/nxp,fxls8962af.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP FXLS8962AF/FXLS8964AF Accelerometer driver
> +
> +maintainers:
> +  - Sean Nyekjaer <sean@geanix.com>
> +
> +description: |
> +  NXP FXLS8962AF/FXLS8964AF Accelerometer driver that supports
> +  SPI and I2C interface.
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
> +    https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: nxp,fxls8962af
> +          - const: nxp,fxls8964af
> +      - enum:
> +          - nxp,fxls8962af
> +          - nxp,fxls8964af

That's needlessly complicated. Either nxp,fxls8962af has a fallback or 
it doesn't.

blank line needed here too.

> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: phandle to the regulator that provides power to the accelerometer
> +
> +  spi-max-frequency: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +        /* Example for a I2C device node */
> +        accelerometer@2a {
> +            compatible = "nxp,fxls8962af";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +  - |
> +    spi0 {
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "nxp,fxls8962af";
> +            reg = <0>;
> +            spi-max-frequency = <4000000>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> -- 
> 2.31.0
> 
