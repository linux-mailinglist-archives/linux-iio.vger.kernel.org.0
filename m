Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED692D1CAE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 23:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgLGWEO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 17:04:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33277 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgLGWEN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Dec 2020 17:04:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so14062791ots.0;
        Mon, 07 Dec 2020 14:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0mqqJ3OVz05oRFoQsrS34BgAVCpwooVqqVYDSSkUB4=;
        b=YB3Ev4+dlK5q4Yqvp4xc9yCvdfsShFIS5nm+WUQWFSGGhYhfjKRBMXIqrzzUmb71M4
         vcQp602RNh1SKZZOTBvfeC/uD1CbYO6V0w4tMbtIyde7AT6GOlbqTRwsP1LOjGgZuRKA
         TI4K1m/ROS3sH5lrJzYRoU6KBHx4GikBSmyEKmQ0xV0Xl0eoXXFgtIs0w0FoAykRBS0U
         OtAxXcqPKWV3xOBHLzN95avNv4JbHX7y2+PnYBFf7bkuTdGOYom2bF/arpC0GL5ZiNFy
         D0MVkUQMowyFrvjG/Hj0GSV8cxEfFFa4PCQehW3zFBbvoKn7khayrIIW7+xRwLEQ1I5S
         nv1A==
X-Gm-Message-State: AOAM532IyupB0A3vsstVSA7uwrI7WjJUvwIlr+0wAu1KqX5Ro/InktFp
        yBudLtrNqf+Njy6Je5y8lA==
X-Google-Smtp-Source: ABdhPJxvs7gWBxPfFYmdpp+KLCZOJ56/weNtINy+k/GhWmKg9zXiQytUIvcrMCgK+B7oirCquuCAeg==
X-Received: by 2002:a9d:3e85:: with SMTP id b5mr14410618otc.354.1607378612639;
        Mon, 07 Dec 2020 14:03:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm3131592oti.45.2020.12.07.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:03:31 -0800 (PST)
Received: (nullmailer pid 914711 invoked by uid 1000);
        Mon, 07 Dec 2020 22:03:30 -0000
Date:   Mon, 7 Dec 2020 16:03:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 4/4] dt-bindings: adc: ad7887: add binding doc for
 AD7887
Message-ID: <20201207220330.GB912645@robh.at.kernel.org>
References: <20201119100748.57689-1-alexandru.ardelean@analog.com>
 <20201119100748.57689-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119100748.57689-4-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 19, 2020 at 12:07:48PM +0200, Alexandru Ardelean wrote:
> This change adds a simple device-tree binding for thhe Analog Devices
> AD7887 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7887.yaml          | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> new file mode 100644
> index 000000000000..9b30f4569b4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings. checkpatch.pl will tell you this.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7887.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7887 low power, 12-bit ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices AD7887 low power, 12-bit analog-to-digital converter (ADC)
> +  that operates from a single 2.7 V to 5.25 V power supply.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7887
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  avcc-supply: true
> +
> +  spi-max-frequency: true
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply
> +
> +  adi,dual-channel-mode:
> +    description:
> +      Configures dual-channel mode for the ADC. In dual-channel operation,
> +      the AIN1/VREF pin assumes its AIN1 function, providing a second analog
> +      input channel. In this case, he reference voltage for the part is provided
> +      via the VDD pin. As a result, the input voltage range on both the AIN0 and
> +      AIN1 inputs is 0 to VDD.
> +    type: boolean
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - spi-cpol
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +                compatible = "adi,ad7887";
> +                reg = <0>;
> +                spi-max-frequency = <1000000>;
> +                spi-cpol;
> +                spi-cpha;
> +
> +                avcc-supply = <&adc_supply>;
> +                vref-supply = <&adc_vref>;
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 
