Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B791EF07C2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 22:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKEVJb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 16:09:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43786 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEVJb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 16:09:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so6840494oie.10;
        Tue, 05 Nov 2019 13:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iegq+cSSA1NXL7WTaToEDVrgyy/Hl0omiIultHGpSIY=;
        b=dxphDh4tpngEgDeGuq7IldvTljIdcVqLYu5rFeLq/BctlaY+LUgpAlfs0zn+OyI6Hi
         DKJsVWolsyrZhD5ch0KGsfMurlCQtykg26DYKSzpXQPInBFvINTKDUqlbH9+eaN8yIvY
         o1zp6FBJ0AfFMpKKP4WY7pIkrkv9rhNdzx9g2EDM8JIKYMl8UNm+7hS2Ua8yEKcBNOz/
         0Qnmd91ZWy7SbFmwdHTBkFmTVXb9lQH2SvtZ57TQtWx8oh938jRDQhri6XSV0MXFUdNb
         +lCFIHQRjSty0Vkk+1+DHjVF9qTZiqt0x81AlCaMu+XsTWI/94VQaOsCOnZVAbom9VZc
         0E2Q==
X-Gm-Message-State: APjAAAUHOiR7ZHT+7n4RDQ87q5V74xo06Gq8mpCRRGDNoET/VwQEuNss
        4cRD1cHRXS6gTy4eXQXYog==
X-Google-Smtp-Source: APXvYqxtYE49f1zoWNTd2Yhf+wAYX6PkNmDPt0gvIEpSWoegxDimUMDmpzwvLkptmvVPSVyWYhCidQ==
X-Received: by 2002:aca:b909:: with SMTP id j9mr833672oif.99.1572988169926;
        Tue, 05 Nov 2019 13:09:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x16sm6029777oic.40.2019.11.05.13.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:09:29 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:09:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <20191105210928.GA22239@bogus>
References: <cover.1572614297.git.marcelo.schmitt1@gmail.com>
 <9a748c5150561dcf3e1f59b2900ae281b662c5b9.1572614297.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a748c5150561dcf3e1f59b2900ae281b662c5b9.1572614297.git.marcelo.schmitt1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 01, 2019 at 01:23:59PM -0300, Marcelo Schmitt wrote:
> Add a devicetree schema for AD7292 monitor and control system.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Changelog V2 -> V3:
> - changed spi-cpha property
> - added spi-cpha to the list of required properties
> - renamed example device node
> - added ';' to the final curly braces correctly closing dt-schema
> 
>  .../bindings/iio/adc/adi,ad7292.yaml          | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> new file mode 100644
> index 000000000000..1014eb50a263
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7292 10-Bit Monitor and Control System
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> +
> +description: |
> +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> +  Temperature Sensor, and GPIOs
> +
> +  Specifications about the part can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7292
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC and DAC reference voltage.
> +
> +  spi-cpha: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 8 channels numbered from 0 to 7.

Can be a constraint:

items:
  - maximum: 7

> +        maxItems: 1

And then drop this because it's implied by the above.

> +
> +      diff-channels:
> +        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad7292: adc@0 {
> +        compatible = "adi,ad7292";
> +        reg = <0>;
> +        spi-max-frequency = <25000000>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +          reg = <0>;
> +          diff-channels = <0 1>;
> +        };
> +        channel@2 {
> +          reg = <2>;
> +        };
> +        channel@3 {
> +          reg = <3>;
> +        };
> +        channel@4 {
> +          reg = <4>;
> +        };
> +        channel@5 {
> +          reg = <5>;
> +        };
> +        channel@6 {
> +          reg = <6>;
> +        };
> +        channel@7 {
> +          reg = <7>;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32bf5f8116d0..5d00e871c4c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -813,6 +813,13 @@ S:	Supported
>  F:	drivers/iio/adc/ad7124.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
>  
> +ANALOG DEVICES INC AD7292 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +
>  ANALOG DEVICES INC AD7606 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-iio@vger.kernel.org
> -- 
> 2.23.0
> 
