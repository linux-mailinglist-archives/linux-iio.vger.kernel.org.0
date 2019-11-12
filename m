Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1402CF99EB
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLTjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 14:39:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43352 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfKLTjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 14:39:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so15917093oie.10;
        Tue, 12 Nov 2019 11:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OeV1TEjg5DUl+fuWBn8Jfdeie+nCeDPsRLgvJFEBFg=;
        b=GGhtCMHG4Nnq0mcudZ2vskjnPB/INf9fYZG7qn+y5YjOF39UD5h3LVHwf9oVmq7t0t
         q+c8ZbVGw1vdyA/mxsbwD3gnN0xe6jryI6sCZmgmvQ3BoNByls09WG1J1ZIhWMO+GgZ0
         4NCiUJBpF4NlGty+GY0KniDlbDVEJ5N99M7BvNIeNZDOxaHfwR1XIv0M81Hy+rB9I6+d
         DuKMeRy7gQDn6JVxZuEg2b0lF3dsZsfCtVE3S3iQfe4AggY/i0Zn4YLSxQAwxYT1hdoe
         UF32KEX0MQ0rCoymdJmAtIvmVswpLSPgYWNgR5h7A/BwyqBsNMd7x2TzvU/OF8VpRGw5
         s96g==
X-Gm-Message-State: APjAAAXEBHP5JI79uZRIFdoaTKkarxmp3/cad7VR3pbyCYIW8QbJctoS
        mT9WlsvRSMX1P/6GIQQHyA==
X-Google-Smtp-Source: APXvYqxnOqQm37cKu+NMagKIQidyM/CvP2y92s3RL4Lfv0Gxm8Qyd0vtW8Jg61doTgsADBWXFsSO3Q==
X-Received: by 2002:aca:7285:: with SMTP id p127mr589107oic.120.1573587583113;
        Tue, 12 Nov 2019 11:39:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l32sm6543738otl.74.2019.11.12.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:39:42 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:39:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <20191112193942.GA27334@bogus>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
 <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 08, 2019 at 10:56:09AM -0300, Marcelo Schmitt wrote:
> Add a devicetree schema for AD7292 monitor and control system.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Changelog V3 -> V4:
> - updated SPDX identifier to GPL-2.0-only
> - changed maxitems constraint on channel property
> 
>  .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> new file mode 100644
> index 000000000000..b68be3aaf587
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Sigh, I gave you the exact line to use:

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

I've said to dual license with (GPL-2.0-only OR BSD-2-Clause) and people 
think I mean to pick one. So now I just give the whole line. I don't 
know how to be clearer.

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
> +        items:
> +          maximum: 7

Not what I said either. A slight but important difference in that you 
are missing a '-' to make 'items' a list rather than a schema/dict.

Update dt-schema. This should give a warning now.

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
