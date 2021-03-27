Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB25D34B860
	for <lists+linux-iio@lfdr.de>; Sat, 27 Mar 2021 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0RCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 13:02:22 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41475 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhC0RCB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 13:02:01 -0400
Received: by mail-oi1-f170.google.com with SMTP id z15so8993950oic.8;
        Sat, 27 Mar 2021 10:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ldGNUOc4SBVAB+z9wRCXO6PlOlMpMotMJHqEqZkxP0Q=;
        b=KTidhLynN64ioxemkxCaA2vGwmBb1MyDohHczP/uqpBuA5FIIJ+VCYg4zCSbwi0VSP
         Xa+PfUSFTr2KdNL99sYxr3wxt7P0EiL8wzV6+my9RHQqgvXxJRo255MxQ0HQxLAZgboN
         Bd4dd6aP9Tasvt5O5CMTgVUj65mPWkPceSZ0R9ItTCNK+MzEvJ1dMWL+SVKxxgU0brlz
         S7e9rAn/hPmakKBdhqeHSfEDovJNXQaJ4/G2+CE2C4r+9A/NzoaG5lgd8SbJMwxfj1Pz
         Fa3s4aodMk1JOxb0RkTlQ+ZP4NOnGMJj2JKfjoB/QcoSOxmcHyPZzLbW9QvHwnCAC5cB
         kjDw==
X-Gm-Message-State: AOAM531O4rGD2tgIHe2CZC9tq8MXijR24X6cH6Na3t7IUhkP4f8FLFtN
        0voWZgSae5WW0KInKizoe9BdbqYfug==
X-Google-Smtp-Source: ABdhPJxxiEl5w7Dd7XM49OqfgN5wHD0q2gRI43tMxxKgnPf42SyfZhIxlLA6NROR/Hy1Na3KPZa6gA==
X-Received: by 2002:a54:408a:: with SMTP id i10mr14047231oii.141.1616864520517;
        Sat, 27 Mar 2021 10:02:00 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id z14sm2511644oid.12.2021.03.27.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:01:59 -0700 (PDT)
Received: (nullmailer pid 245995 invoked by uid 1000);
        Sat, 27 Mar 2021 17:01:53 -0000
Date:   Sat, 27 Mar 2021 11:01:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     jic23@kernel.org, michal.simek@xilinx.com, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add ti,ina260.yaml
Message-ID: <20210327170153.GA243988@robh.at.kernel.org>
References: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
 <20210322105056.30571-2-raviteja.narayanam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322105056.30571-2-raviteja.narayanam@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 04:20:55PM +0530, Raviteja Narayanam wrote:
> Add a binding for Texas Instruments INA260 power monitor device.
> 
> Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> ---
>  .../bindings/iio/adc/ti,ina260.yaml           | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
> new file mode 100644
> index 000000000000..97c68188e53d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ina260.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments INA260 power monitor
> +
> +maintainers:
> +  - Raviteja Narayanam <raviteja.narayanam@xilinx.com>
> +
> +description: |
> +  The INA260 is a digital-output, current, power and voltage monitor
> +  with an I2C and SMBUS compatible interface with an integrated shunt
> +  resistor. It features up to 16 programmable addresses on I2C compatible
> +  interface. Datasheet - https://www.ti.com/lit/ds/symlink/ina260.pdf?ts=1608607288391
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ina260
> +
> +  reg:
> +    description: |
> +      The 7-bits long I2c address of the device

Just 'maxItems: 1'

> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  interrupts:
> +    description: |
> +      IRQ line for the device

That's every 'interrupts' property. Drop.

You need to say how many: maxItems: 1

> +
> +  label:
> +    description: |
> +      A symbolic name for the device
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ina260@40 {
> +        compatible = "ti,ina260";
> +        reg = <0x40>;
> +        #io-channel-cells = <1>;
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
