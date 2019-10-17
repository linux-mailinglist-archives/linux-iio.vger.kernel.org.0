Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEDDB70D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439255AbfJQTLy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 15:11:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35058 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfJQTLy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2019 15:11:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so3145987oig.2;
        Thu, 17 Oct 2019 12:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pNn+3a0mSOImc8lwCiiMBTaCf4ZMHWOyJsIWR4MRyo=;
        b=OQDVLCuzkwM5MvVNgeXUM2wwe23MX7r52ZpL0jVT9mxxUS9ez/vABY2I8NGYzIX6hx
         veOIo7uZc1ZVmYxC95DnvM8xT4erPAm30HMtcXub2xmiKUuDEoC2BKZCNOb8e6zD9TxT
         DjdYjwvuWOT7c4zwIpyViPA2q8bVtrMiBsxYuFRxyPIuk4jJY1PSaxXhI8OfSQl1xQ0Y
         9PKtvUISZOZ553pro5dU33I2OkcRAPaNNFYGiAPfT7Jcqq+OeN5ZD4n4SHYRF0yUE/fb
         vLy5oenpvbIjLDOuY2E0LcYwUGvqn4Ks2QtQoRmD+OxOumF7O+Ior0QkdEOH42D/BAnC
         9G9Q==
X-Gm-Message-State: APjAAAVyylqEvjuUM+csr5H0TJMWYFUMs70fbNfYmeXaLhIrajeQPzR+
        8UYBYwsvGgbuSRw3xsNZ3g==
X-Google-Smtp-Source: APXvYqyLtpa4JcFkjiCx780J6I9B1F/uD9BsRXrz/UaxOGuWozT33iIfQ63TlzPlmKHRSwDk+KhHxA==
X-Received: by 2002:aca:5148:: with SMTP id f69mr4711582oib.172.1571339513398;
        Thu, 17 Oct 2019 12:11:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm731351oia.28.2019.10.17.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:11:52 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:11:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191017191152.GA11222@bogus>
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 15, 2019 at 11:52:23PM -0300, Marcelo Schmitt wrote:
> Add a device tree binding doc for AD7292 monitor and control system.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7292.yaml          | 107 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> new file mode 100644
> index 000000000000..40028332d9e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: GPL-2.0
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
> +    maxItems: 1

Not necessary, regulator supplies are always 1 item, so drop maxItems.

> +
> +  spi-cpha:
> +    description: |
> +      See Documentation/devicetree/bindings/spi/spi-controller.yaml
> +    maxItems: 1

This is just wrong because spi-cpha is a boolean. Just 'spi-cpha: true' 
is sufficient. If this device needs this property, then it should 
probably be required.

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
> +        maxItems: 1
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
> +      ad7292: ad7292@0 {

adc@0

> +        compatible = "adi,ad7292";
> +        reg = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        spi-max-frequency = <25000000>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
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
> +    }

Missing ';'. Make sure this builds with 'make -k dt_binding_check'. The 
'-k' is due to some other breakage ATM.

Rob
