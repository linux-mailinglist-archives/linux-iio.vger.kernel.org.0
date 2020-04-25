Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2601B8906
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDYTgC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgDYTgB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:36:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD8B206D4;
        Sat, 25 Apr 2020 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843361;
        bh=rQMJgnkXyudQwiNR2GAX2shGSPxAYkUdRwxlosL0c7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rPtLPchWEcowcKjilJOx89EHLKg5+bhOnDxGuIMYPkEPCuNfpYXNCnfsLmXreQuRf
         3QISo/Oef6AIhMUUkZj1g1DqNE70bXiE/6+MP5iHjG027j/D8bTcIUgqxmFmpyIC1E
         C0hTpOcXZrAUtSYcA/yMd2XSCg7QgsiEv0+roEdg=
Date:   Sat, 25 Apr 2020 20:35:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio/dac: convert ltc2632.txt to
 lltc,ltc2632.yaml
Message-ID: <20200425203556.4c051fad@archlinux>
In-Reply-To: <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
        <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 12:26:08 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
There is something odd going on with indentation but otherwise looks fine to me.
However we need to leave time for a final DT review.

Thanks,

Jonathan

> ---
> v5:
> correct require section
> set maintainer of analog.com
> v4..v2: no change
> 
>  .../bindings/iio/dac/lltc,ltc2632.yaml        | 76 +++++++++++++++++++
>  .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
>  2 files changed, 76 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> new file mode 100644
> index 000000000000..b0043144fbc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Bindings for the Linear Technology LTC2632/2634/2636 DAC
> +  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc2632-l12
> +      - lltc,ltc2632-l10
> +      - lltc,ltc2632-l8
> +      - lltc,ltc2632-h12
> +      - lltc,ltc2632-h10
> +      - lltc,ltc2632-h8
> +      - lltc,ltc2634-l12
> +      - lltc,ltc2634-l10
> +      - lltc,ltc2634-l8
> +      - lltc,ltc2634-h12
> +      - lltc,ltc2634-h10
> +      - lltc,ltc2634-h8
> +      - lltc,ltc2636-l12
> +      - lltc,ltc2636-l10
> +      - lltc,ltc2636-l8
> +      - lltc,ltc2636-h12
> +      - lltc,ltc2636-h10
> +      - lltc,ltc2636-h8
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  vref-supply:
> +    description:
> +	  Phandle to the external reference voltage supply. This should
> +      only be set if there is an external reference voltage connected to the VREF
> +      pin. If the property is not set the internal reference is used.

Odd intent going on there.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vref: regulator-vref {
> +        compatible = "regulator-fixed";
> +        regulator-name = "vref-ltc2632";
> +        regulator-min-microvolt = <1250000>;
> +        regulator-max-microvolt = <1250000>;
> +        regulator-always-on;
> +    };
> +
> +    spi_master {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dac: ltc2632@0 {
> +        compatible = "lltc,ltc2632";
> +        reg = <0>;    /* CS0 */
> +        spi-max-frequency = <1000000>;
> +        vref-supply = <&vref>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> deleted file mode 100644
> index 1ab9570cf219..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Linear Technology LTC2632/2634/2636 DAC
> -
> -Required properties:
> - - compatible: Has to contain one of the following:
> -	lltc,ltc2632-l12
> -	lltc,ltc2632-l10
> -	lltc,ltc2632-l8
> -	lltc,ltc2632-h12
> -	lltc,ltc2632-h10
> -	lltc,ltc2632-h8
> -	lltc,ltc2634-l12
> -	lltc,ltc2634-l10
> -	lltc,ltc2634-l8
> -	lltc,ltc2634-h12
> -	lltc,ltc2634-h10
> -	lltc,ltc2634-h8
> -	lltc,ltc2636-l12
> -	lltc,ltc2636-l10
> -	lltc,ltc2636-l8
> -	lltc,ltc2636-h12
> -	lltc,ltc2636-h10
> -	lltc,ltc2636-h8
> -
> -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
> -apply. In particular, "reg" and "spi-max-frequency" properties must be given.
> -
> -Optional properties:
> -	- vref-supply: Phandle to the external reference voltage supply. This should
> -	  only be set if there is an external reference voltage connected to the VREF
> -	  pin. If the property is not set the internal reference is used.
> -
> -Example:
> -
> -	vref: regulator-vref {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vref-ltc2632";
> -		regulator-min-microvolt = <1250000>;
> -		regulator-max-microvolt = <1250000>;
> -		regulator-always-on;
> -	};
> -
> -	spi_master {
> -		dac: ltc2632@0 {
> -			compatible = "lltc,ltc2632-l12";
> -			reg = <0>; /* CS0 */
> -			spi-max-frequency = <1000000>;
> -			vref-supply = <&vref>; /* optional */
> -		};
> -	};

