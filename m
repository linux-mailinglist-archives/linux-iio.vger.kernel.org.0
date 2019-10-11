Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F93D41F0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfJKN6N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 09:58:13 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39180 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfJKN6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 09:58:13 -0400
Received: by mail-oi1-f180.google.com with SMTP id w144so8049219oia.6;
        Fri, 11 Oct 2019 06:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AytY9RaOFMiuMeVFAdexpGbO16/DhiD2ofdUEPgBF1Q=;
        b=ak2YGPjEYnLMwwk9zxuwNsKeKkxITIISTJdqdgfyKPKMLn00u4WUp/JWhvZJ+5Cw3o
         UVW8hRQornFDMnQSnJgkNmzAmfd3XYOnGNdFVmUMkogKQUxu/zI35uQj7cycifwl0O6y
         tKstrO9H4XLpdRvFaXKPohrm0c6ubxN9gq+aMfpz8WZgr9S/naEQDSyQidzz5DujGEvA
         E7bvlLxRAeeHPO9IMoZCgKe4WQm1Qxjh/3Q0ycr5+jqmNkRA83Xfb/f8oCUXhRcQXgQV
         qVuVTUpeKT0PqZrSVOi8MUkMr7e2ds+lFk0h7BBAh4eX5/Fp3597W93w5QiedfbZX8Re
         FArw==
X-Gm-Message-State: APjAAAWX1RUjQaHWc4UZgnbzyDp8hhqQQwaXrHLENFQrF5SNIK/MWEr3
        qvoCFEOCvD7lKy4adjb2eQ==
X-Google-Smtp-Source: APXvYqxtffR8czl1U1RQTq/Ohz0EN84FPMWZcjMCNUDER4Ji+4PpCT0VJCpJkyTf8rMV7jHoi6aPLw==
X-Received: by 2002:a54:438f:: with SMTP id u15mr5181880oiv.40.1570802292421;
        Fri, 11 Oct 2019 06:58:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm2581820otn.44.2019.10.11.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:58:11 -0700 (PDT)
Date:   Fri, 11 Oct 2019 08:58:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Message-ID: <20191011135811.GA23962@bogus>
References: <20191010012523.14426-1-rjones@gateworks.com>
 <20191010175648.10830-1-rjones@gateworks.com>
 <20191010175648.10830-2-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010175648.10830-2-rjones@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 10, 2019 at 10:56:47AM -0700, Robert Jones wrote:
> This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> device-tree bindings.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> new file mode 100644
> index 0000000..d33a1cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/fxos8700.yaml#

Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml: $id: 
path/filename 'iio/imu/fxos8700.yaml' doesn't match actual filename

Test your binding with 'make dt_binding_check'.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale FXOS8700 Inertial Measurement Unit
> +
> +maintainers:
> +  - Robert Jones <rjones@gateworks.com>
> +
> +description: |
> +  Accelerometer and magnetometer combo device with an i2c and SPI interface.
> +  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,fxos8700
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    maxItems: 2
> +    items:
> +      - const: INT1
> +      - const: INT2

This doesn't match the example now. You need 'minItems: 1' if you need
to support 1 or 2 interrupts. If it can be either one, then you need:

items:
  enum: [ INT1, INT2 ]

> +
> +  drive-open-drain:
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fxos8700@1e {
> +          compatible = "nxp,fxos8700";
> +          reg = <0x1e>;
> +
> +          interrupt-parent = <&gpio2>;
> +          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> +          interrupt-names = "INT1";
> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fxos8700@1e {
> +          compatible = "nxp,fxos8700";
> +          reg = <0x1e>;

I guess you could have SPI chip select # 30...

> +
> +          interrupt-parent = <&gpio2>;
> +          spi-max-frequency = <1000000>
> +          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> +          interrupt-names = "INT1";
> +        };
> +    };
> -- 
> 2.9.2
> 
