Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB81C0009
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgD3PYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:24:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33199 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgD3PYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:24:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so5234128ots.0;
        Thu, 30 Apr 2020 08:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4g24e3GzwdiYIpTDMkHlnY+SwtLlwI/g7Kc4NqV3FM=;
        b=TdHtPfPiDpFSjQ7rAknghIRiOPwnYwMDbSJxTqoatwenKBTZehrcoYJLi7fEMPKydJ
         74h3rE+EVVIcCXwhYVtxJ/nGMlBSHbziBG1pVbzsLv+hZM7dGVN24mdDhA3IOdB06p8x
         Th27exzb+fTIiwdNyavEMWXwY/WcOyydF1ovQuzmJ2i/L1U4kgXOpx9Qu4uhle8TCNW5
         yXBPvXGzuBsJ4PmYIwPBYgIuMdcNMNwTKU+93CyfrR3DXmZjD9a+cHj57xACQ0zzda7j
         mRy9nCbTCujJPOi6PnIbtQpPqi6Z9cEf/6Bjz+VonPHDu+5XTMGbcWHa+2QBMB7Lb06p
         bnGg==
X-Gm-Message-State: AGi0PuY4CVKlXrc2vz1e5myFhhRTlpesK3PzbvSVD1NW7saCwbf3WKvg
        vpoKWIOJGN2IgIY6Zr0nGw==
X-Google-Smtp-Source: APiQypIEEBcRD0MSn0hGLzIxLkXC5lYI2OeNfPr7SM8+BRERqIlo3llUkEhqFKBx/zMNHevWxNEssQ==
X-Received: by 2002:a9d:7b55:: with SMTP id f21mr2114497oto.31.1588260256120;
        Thu, 30 Apr 2020 08:24:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm49738ott.51.2020.04.30.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:24:15 -0700 (PDT)
Received: (nullmailer pid 30190 invoked by uid 1000);
        Thu, 30 Apr 2020 15:24:14 -0000
Date:   Thu, 30 Apr 2020 10:24:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
Message-ID: <20200430152414.GA19887@bogus>
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
 <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 12:26:08PM +0800, Chris Ruehl wrote:
> Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
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

There's a tab here which the yaml parser isn't going to like. Not sure 
why my checker didn't run on this, but make sure 'make dt_binding_check' 
passes.

> +      only be set if there is an external reference voltage connected to the VREF
> +      pin. If the property is not set the internal reference is used.
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

spi {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dac: ltc2632@0 {

dac@0

And drop the unused label.

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
> -- 
> 2.20.1
> 
