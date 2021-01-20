Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575BE2FC6D7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbhATBcP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 20:32:15 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34919 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbhATBcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 20:32:02 -0500
Received: by mail-oi1-f181.google.com with SMTP id w8so1615655oie.2;
        Tue, 19 Jan 2021 17:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70aGOwWqvSNnuRZRBgvIddOExT7M4WJHCpkHOLv549U=;
        b=JIceF53FUorEn13lbB0lCxvM63P0X5eZMCq9vYodn4V6WHeo1hjJaQQ97YDgMjIlQE
         d/bw3HaoEI2AFIo3yj3xi4g4722+aHhDzmfNlpXrlQjB3bm/3yVkVcByMGGeuXn0jQI+
         hb2zhVcTEE6jpqizR5wNOtOO4iIHmPvwU91c5GfVjfvuoRQWQlVdMICa8nLxGhQe2tLh
         zW7ZIJ3ZcpJSF7G54grmD/ea07bU9UV3Nw3yTQ/5lfMO7T4+E9o1d3RbrfgTgLqy8qnt
         bOEOoPjxLEmMm+dCNS/wRaaoWkZC+n9wHFZhGPO7cU1XDLuz5vqDFoww3SsQt1fVNLpu
         ad6w==
X-Gm-Message-State: AOAM530DJIQb4AXzZtCC2taSQzFZYUHS0GQQt4K42ypegE6Klyac3v8Q
        0Q4pJivfHhuYzc6tG+0kIG4j6XQ0TQ==
X-Google-Smtp-Source: ABdhPJydF0BAx1ZnbHLhfNn1zr8cKXRT8sZgYcv8vLFh//tc2P2ggSEcgqco5mLp+bpeuijFP9ph4Q==
X-Received: by 2002:aca:4d4:: with SMTP id 203mr1626279oie.18.1611106281114;
        Tue, 19 Jan 2021 17:31:21 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t16sm100212otq.17.2021.01.19.17.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:31:19 -0800 (PST)
Received: (nullmailer pid 2992413 invoked by uid 1000);
        Wed, 20 Jan 2021 01:31:18 -0000
Date:   Tue, 19 Jan 2021 19:31:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20210120013118.GA2990828@robh.at.kernel.org>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119124622.9490-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 19, 2021 at 01:46:21PM +0100, Mike Looijmans wrote:
> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v6:
> I't been almost a year since the last commit, sorry...
> Fixed the yaml errors
> Add interrupt, vdd and vddio properties
> 
> Changes in v5:
> submit together with driver code as patch series
> 
> Changes in v2:
> convert to yaml format
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> new file mode 100644
> index 000000000000..459b9969fd12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bmi088.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI088 IMU accelerometer part
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Acceleration part of the IMU sensor with an SPI interface
> +  Specifications about the sensor can be found at:
> +    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bmi088_accel

bosch,bmi088-accel

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vddio-supply: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_LEVEL_LOW.
> +      The first interrupt listed must be the one connected to the INT1 pin, the
> +      second must be the one connected to the INT2 pin.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      bmi088_accel@1 {
> +        compatible = "bosch,bmi088_accel";
> +        reg = <1>;
> +        spi-max-frequency = <10000000>;
> +        interrupt-parent = <&gpio6>;
> +        interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
