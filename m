Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6AC14ABB2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0VfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 16:35:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44971 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0VfN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jan 2020 16:35:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so9927418otj.11;
        Mon, 27 Jan 2020 13:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DS9rBnPhlHanLaFTLViZKZChByFqRQj8L2SSOh5cpGQ=;
        b=PUOgrTMleoLX9WO3bxJ+Ns/MdBhO1n+kQvAUCNJIemhqfvzQW49oduuc6dl1BWwmRr
         fbASTIxj+bVOz2FDx3jYb7elPytnhDb5FDScqFxaxATfueejb9y4QnXryofMExMCu1UU
         C6EJr5l0ldVx/6BQtefyQFWgqw0iMfHx4yqV+LHgkquTphqzUfBC0yiRfVTfQpaZSKIr
         Y268Ia6tF8PbWrwe/Fw+314D5iNBGtsy80OE1ETFBaoJc/DgWqtQaV7om70urZBiOApP
         Oakz3uOvdUUbsPKtTayq7y5W3+P4l1R+ecFDXvNDndxsqLshAp1DuAGm7LrwHEMXz84t
         HMrQ==
X-Gm-Message-State: APjAAAUPnapq0H7m47ver8hQfbpH6ZaV8g4BwL3LhASZuiRcp22xGxZ3
        46drBPBWfnAIXMOvbr+BK0tlo1M=
X-Google-Smtp-Source: APXvYqxazihpH6AOjBHM0TSoXXhx43x+o2cRWFEu2KNLM8CmEUGKyThuZmvXYfpz59hEMyDo5GWqlQ==
X-Received: by 2002:a9d:da2:: with SMTP id 31mr13507583ots.319.1580160912219;
        Mon, 27 Jan 2020 13:35:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm5192804oif.47.2020.01.27.13.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 13:35:11 -0800 (PST)
Received: (nullmailer pid 17422 invoked by uid 1000);
        Mon, 27 Jan 2020 21:35:10 -0000
Date:   Mon, 27 Jan 2020 15:35:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ekigwana@gmail.com, jic23@kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: frequency: Add docs for ADF4360
 PLL
Message-ID: <20200127213510.GA698@bogus>
References: <20200122132004.4621-1-alexandru.ardelean@analog.com>
 <20200122132004.4621-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122132004.4621-2-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 22, 2020 at 03:20:03PM +0200, Alexandru Ardelean wrote:
> From: Edward Kigwana <ekigwana@gmail.com>
> 
> This change adds the device-tree bindings documentation for the ADF4360
> family of PLLs.
> 
> Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/frequency/adf4371.yaml       |  24 +--
>  .../bindings/iio/frequency/adi,adf4360.yaml   | 158 ++++++++++++++++++
>  2 files changed, 170 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 7ec3ec94356b..6edb68e8febf 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -48,16 +48,16 @@ required:
>  
>  examples:
>    - |
> -    spi0 {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -
> -        frequency@0 {
> -                compatible = "adi,adf4371";
> -                reg = <0>;
> -                spi-max-frequency = <1000000>;
> -                clocks = <&adf4371_clkin>;
> -                clock-names = "clkin";
> -        };
> -    };
> +      spi0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          frequency@0 {
> +                  compatible = "adi,adf4371";
> +                  reg = <0>;
> +                  spi-max-frequency = <1000000>;
> +                  clocks = <&adf4371_clkin>;
> +                  clock-names = "clkin";
> +          };
> +      };

What's this change for?

>  ...
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> new file mode 100644
> index 000000000000..1a7f166d2a3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019-2020 Edward Kigwana
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF4360 PLL device driver
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Edward Kigwana <ekigwana@gmail.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADF4360 family of clock generator phase-locked
> +  loop (PLL) devices with an integrated voltage-controlled oscillator (VCO).
> +  Each of the parts in the family supports a specific frequency range.
> +  Datasheets can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-0.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-2.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-3.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-4.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-5.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-6.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-7.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-8.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-9.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4360-0
> +      - adi,adf4360-1
> +      - adi,adf4360-2
> +      - adi,adf4360-3
> +      - adi,adf4360-4
> +      - adi,adf4360-5
> +      - adi,adf4360-6
> +      - adi,adf4360-7
> +      - adi,adf4360-8
> +      - adi,adf4360-9

The enum can be just:

pattern: '^adi,adf4360-[0-9]$'


> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: phandle to external reference clock.

Not all that specific to this define, so drop.

> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  adi,loop-filter-pfd-frequency-hz:
> +    description: |
> +      The phase-frequency-detector frequency that the external loop filter was
> +      designed for.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Standard type suffixes have a type already, so you can drop this.

> +    maxItems: 1

Any constraints in the value?

> +
> +  adi,loop-filter-charger-pump-current-microamp:
> +    description: |
> +      The charge pump current that the external loop filter was designed for.
> +      The provided value is clamped to the closest enumerated value.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Can be dropped. Same goes for the rest.

> +      - enum: [310, 620, 930, 1250, 1560, 1870, 2180, 2500]
> +    maxItems: 1
> +
> +  adi,vco-minimum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Minimum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  adi,vco-maximum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Maximum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  adi,loop-filter-inverting:
> +    description: Indicates that the external loop filter is an inverting filter.
> +    type: boolean
> +
> +  adi,power-up-frequency-hz:
> +    description: |
> +      PLL tunes to the set frequency on probe or defaults to either the minimum
> +      for the part or value set using adi,vco-minimum-frequency-hz.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  adi,vdd-supply:
> +    description: |
> +      vdd supply is used to enable or disable chip when regulator power down
> +      mode is set. Other power down modes are used to mitigate the case of a
> +      shared regulator.
> +    maxItems: 1

-supply is always 1 item, so drop.

> +
> +  adi,enable-gpios:

enable-gpios is a standard name, so drop the vendor prefix.

> +    description: |
> +      Chip enable gpio is used to enable or disable chip when chip enable power
> +      down mode is set.
> +    maxItems: 1
> +
> +  adi,muxout-gpios:
> +    description: |
> +      MUX out gpio is used to detect chip and test pll lock state on read when
> +      muxout control is set to lock detect.
> +    maxItems: 1
> +
> +  adi,power-out-level-microamp:
> +    description: |
> +      Chip support setting of output power level. This property is optional.
> +      If it is not provided by default 11000 uA will be set.
> +    allOf:
> +      - enum: [3500, 5000, 7500, 11000]

Don't need the 'allOf'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - adi,loop-filter-charge-pump-current
> +  - adi,loop-filter-pfd-frequency-hz
> +
> +examples:
> +  - |
> +      spi0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pll@0 {
> +                  compatible = "adi,adf4360-7";
> +                  reg = <0>;
> +                  spi-max-frequency = <2000000>;
> +                  clocks = <&ref_clock>;
> +                  #clock-cells = <0>;
> +                  clock-names = "clkin";
> +                  clock-output-names = "adf4360-7";
> +
> +                  adi,loop-filter-charge-pump-current = <5>;
> +                  adi,loop-filter-pfd-frequency-hz = <2500000>;
> +                  adi,vco-minimum-frequency-hz = <700000000>;
> +                  adi,vco-maximum-frequency-hz = <840000000>;
> +          };
> +      };
> +...
> -- 
> 2.20.1
> 
