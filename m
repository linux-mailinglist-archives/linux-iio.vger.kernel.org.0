Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21550F0D4B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 04:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfKFDtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 22:49:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40527 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFDtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 22:49:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id 22so1607703oip.7;
        Tue, 05 Nov 2019 19:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYRy2kU11mjJOqDThkKH567jR3x8F3FqGXpmcAaLlOo=;
        b=F+Z7/hJZiqLIEezcoGg3lTIp28cO4/7kNLRNTu6FKs9XKWd6ogMDNRamLohBrXXgpt
         ZNKKNS/GegUKG0huchmm7w3YfvGCWF/wKtsVgOE8LIXSTuKhJ+ZfxphcKtyb6Z+O3PQ+
         GkJzIilUf+P8Gp8TRRhbWFdQROYxZPPAWe9Jv7pDc0/TZszOwT/eW6ljwYnjeUIiWOSN
         JSgBy3Zl7Os07mnJIziRRlVfz53BtoDmRSjK/Akl4cJsVqDJEceOO44vKYzYQnAw3jbv
         YNZ2GVZdB8t+Cqxuguitzn55CwShG8zCTY/7+J49Yy6N+MiWK5TNeQC7ua5Eai59SG59
         T/Ew==
X-Gm-Message-State: APjAAAW90eEId3KJmGBW4KzJ9djA6o5jZQWLYg8Ab0lPXYpqiPRX0LXQ
        xKbaL7KLtvsGpRPcVejxEg==
X-Google-Smtp-Source: APXvYqyArk7cjiKQPNiUtt/ZJP0XyerEm6RMmGQgcHosA8r7K975fgj1X6RbwQlU05L0p4gxByX+MA==
X-Received: by 2002:aca:39d7:: with SMTP id g206mr325373oia.101.1573012161814;
        Tue, 05 Nov 2019 19:49:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm6486980oia.51.2019.11.05.19.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:49:21 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:49:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Migrate MCP3911 documentation to
 yaml
Message-ID: <20191106034920.GA15882@bogus>
References: <20191029211142.14650-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029211142.14650-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 29, 2019 at 10:11:42PM +0100, Marcus Folkesson wrote:
> Rewrite bindings to use json-schema vocabulary.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/mcp3911.txt   | 30 --------
>  .../bindings/iio/adc/microchip,mcp3911.yaml   | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 73 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> deleted file mode 100644
> index 3071f48fb30b..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* Microchip MCP3911 Dual channel analog front end (ADC)
> -
> -Required properties:
> - - compatible: Should be "microchip,mcp3911"
> - - reg: SPI chip select number for the device
> -
> -Recommended properties:
> - - spi-max-frequency: Definition as per
> -	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> -	 Max frequency for this chip is 20MHz.
> -
> -Optional properties:
> - - clocks: Phandle and clock identifier for sampling clock
> - - interrupt-parent: Phandle to the parent interrupt controller
> - - interrupts: IRQ line for the ADC
> - - microchip,device-addr: Device address when multiple MCP3911 chips are present on the
> -	same SPI bus. Valid values are 0-3. Defaults to 0.
> - - vref-supply: Phandle to the external reference voltage supply.
> -
> -Example:
> -adc@0 {
> -	compatible = "microchip,mcp3911";
> -	reg = <0>;
> -	interrupt-parent = <&gpio5>;
> -	interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> -	spi-max-frequency = <20000000>;
> -	microchip,device-addr = <0>;
> -	vref-supply = <&vref_reg>;
> -	clocks = <&xtal>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> new file mode 100644
> index 000000000000..bfcf6a5fb44e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/iio/adc/microchip,mcp3911.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip MCP3911 Dual channel analog front end (ADC)
> +
> +maintainers:
> +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> +  - Kent Gustavsson <nedo80@gmail.com>
> +
> +description: |
> +  Bindings for the Microchip MCP3911 Dual channel ADC device. Datasheet can be
> +  found here: https://ww1.microchip.com/downloads/en/DeviceDoc/20002286C.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp3911
> +
> +  reg:
> +    description: SPI chip select number for the device

No need to describe common properties if you have nothing special for 
this device to say.

> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: |
> +      Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt.

Same here.

> +    maximum: 20000000
> +    maxItems: 1

Not an array, so drop.

> +
> +  clocks:
> +    description: Phandle and clock identifier for sampling clock

Same comment on descriptions.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ line of the ADC
> +    maxItems: 1
> +
> +  microchip,device-addr:
> +    description: Device address when multiple MCP3911 chips are present on the same SPI bus.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3]
> +      - default: 0
> +
> +  vref-supply:
> +    description: Phandle to the external reference voltage supply.
> +    maxItems: 1

Drop this *-supply is always 1 item.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "microchip,mcp3911";
> +        reg = <0>;
> +        interrupt-parent = <&gpio5>;
> +        interrupts = <15 2>;
> +        spi-max-frequency = <20000000>;
> +        microchip,device-addr = <0>;
> +        vref-supply = <&vref_reg>;
> +        clocks = <&xtal>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e51a68bf8ca8..fbccc9d450ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10723,7 +10723,7 @@ M:	Kent Gustavsson <kent@minoris.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/adc/mcp3911.c
> -F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>  
>  MICROCHIP NAND DRIVER
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> -- 
> 2.23.0
> 
