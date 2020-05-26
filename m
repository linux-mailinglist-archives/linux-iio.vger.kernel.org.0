Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C41E3277
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgEZW2w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 18:28:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44242 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389889AbgEZW2v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 18:28:51 -0400
Received: by mail-io1-f68.google.com with SMTP id p20so10430410iop.11;
        Tue, 26 May 2020 15:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDwEz/JE5jOg2OHCVqT4W2DPG4k9l5gtnCyJUBU0V04=;
        b=Hui7KgU1XKcZ59FIp9ApMgVW/NX3greaFUqoYrIKCBbfMiHD4Nsx5nwSeX0ERXdT8O
         KB7Fdkz0/lhva8NGCVvXrRFKdyKkyKcg5gMYJne3ffw4WOv/TXIE0MHZkDCgSOJSfYE9
         p+K2GwBiGBlh/WrOvx3Ae+w+fE09CFHvOSnL5GxkA7ZaGzQjbRww7E5GwbmvREkngVNa
         ZhhFSubEFSLiVKjV1DTe0S1O5l3mDAcMzTk+4w1MlSIgPBBNlKiF05HHyMdfWrPtYoFv
         c7KXeYRZ/LK9Ne9Mz/2qDB3YORuDnAG/bitCOwXA7LM0L+73scmvcJkB8pd14Z39+FC3
         T4rw==
X-Gm-Message-State: AOAM531mYL8vcUDgWi2EZr5Jrx/l5O8BtYZ+LdFOFrUzGGODMJye7FHH
        r2eCM1He78XSA/UeIV9WhA==
X-Google-Smtp-Source: ABdhPJxULrVSb/aigwwxG47NzpgQxbYZ2MsEuXA8CEC1usL4zhqKDI7qwdmpLsY9vZBggij6f0FtCg==
X-Received: by 2002:a6b:6818:: with SMTP id d24mr7139339ioc.57.1590532128934;
        Tue, 26 May 2020 15:28:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r68sm570471ilb.37.2020.05.26.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:28:48 -0700 (PDT)
Received: (nullmailer pid 499297 invoked by uid 1000);
        Tue, 26 May 2020 22:28:47 -0000
Date:   Tue, 26 May 2020 16:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: magnetometer: ak8975: convert
 format to yaml, add maintainer
Message-ID: <20200526222847.GA492828@bogus>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
 <20200525151117.32540-3-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525151117.32540-3-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 05:10:36PM +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml.

I would have converted to yaml and do any re-formatting/wording, then 
added 'interrupts', but this is fine.


> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt      | 37 ---------
>  .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> deleted file mode 100644
> index 0576b9df0bf2..000000000000
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -* AsahiKASEI AK8975 magnetometer sensor
> -
> -Required properties:
> -
> -  - compatible : should be "asahi-kasei,ak8975".
> -  - reg : the I2C address of the magnetometer.
> -
> -Optional properties:
> -
> -  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
> -      is ready to be read and is possible to listen on it. If used,
> -      this should be active high. Prefer interrupt over this.
> -
> -  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
> -
> -  - vdd-supply: an optional regulator that needs to be on to provide VDD.
> -
> -  - mount-matrix: an optional 3x3 mounting rotation matrix.
> -
> -Example:
> -
> -ak8975@c {
> -        compatible = "asahi-kasei,ak8975";
> -        reg = <0x0c>;
> -        interrupt-parent = <&gpio6>;
> -        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> -        vdd-supply = <&ldo_3v3_gnss>;
> -        mount-matrix = "-0.984807753012208",  /* x0 */
> -                       "0",                   /* y0 */
> -                       "-0.173648177666930",  /* z0 */
> -                       "0",                   /* x1 */
> -                       "-1",                  /* y1 */
> -                       "0",                   /* z1 */
> -                       "-0.173648177666930",  /* x2 */
> -                       "0",                   /* y2 */
> -                       "0.984807753012208";   /* z2 */
> -};
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> new file mode 100644
> index 000000000000..a603659d5fa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8975.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AsahiKASEI AK8975 magnetometer sensor
> +
> +maintainers:
> +  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: asahi-kasei,ak8975
> +      - const: asahi-kasei,ak8963
> +      - const: asahi-kasei,ak09911
> +      - const: asahi-kasei,ak09912

These 4 can be an enum.

> +      - const: ak8975
> +        deprecated: true
> +      - const: ak8963
> +        deprecated: true
> +      - const: ak09911
> +        deprecated: true
> +      - const: ak09912
> +        deprecated: true

And these 4 can be an enum+deprecated.

> +
> +  reg:
> +    maxItems: 1
> +    description: the I2C address of the magnetometer.

Don't need a description.

> +
> +  gpios:
> +    description: |
> +      AK8975 has a "Data ready" pin (DRDY) which informs that data
> +      is ready to be read and is possible to listen on it. If used,
> +      this should be active high. Prefer interrupt over this.

Need to define how many GPIOs (maxItems: 1).

> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt for DRDY pin. Triggered on rising edge.
> +
> +  vdd-supply:
> +    maxItems: 1
> +    description: |
> +      an optional regulator that needs to be on to provide VDD power to
> +      the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@c {
> +            compatible = "asahi-kasei,ak8975";
> +            reg = <0x0c>;
> +            interrupt-parent = <&gpio6>;
> +            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +            vdd-supply = <&ldo_3v3_gnss>;
> +            mount-matrix = "-0.984807753012208",  /* x0 */
> +                           "0",                   /* y0 */
> +                           "-0.173648177666930",  /* z0 */
> +                           "0",                   /* x1 */
> +                           "-1",                  /* y1 */
> +                           "0",                   /* z1 */
> +                           "-0.173648177666930",  /* x2 */
> +                           "0",                   /* y2 */
> +                           "0.984807753012208";   /* z2 */
> +        };
> +    };
> -- 
> 2.17.1
> 
