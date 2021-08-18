Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8853F0998
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHRQuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 12:50:13 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39716 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHRQuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 12:50:12 -0400
Received: by mail-ot1-f49.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so4854842otf.6;
        Wed, 18 Aug 2021 09:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hgUeilmmvPU0xEekHvKIx2V/TUPmcvoEThDx7GYZZ4w=;
        b=GR5bzoMSLB2ScPE+2CcoOrP3E3NDx7ZbsHpLZsAuSzcDxFIeuVKH/GvXp2Uowa3a3J
         MWSEMGKQBQBEThEQf4B+uFwS5fx49i5ol43p0KF/P0VSwvNSrvyfCcPujHNw9l7Lbd7m
         IblPytQ3yb25m3x+kWoanCRcnh7bEi39pBsS50IObUpU//fAk78olAU+sLqfEX1/qaP7
         9D92OQ9YNDjnnk6ArqcfjsJESTlNHi1j11c4UuwPSlZs89guB/+3COa0ZOhU2qJfGxHc
         0Nj3GQqg/8BuQhGK5sPNKFTt0v2krSBT+T3aqIr73zTGGdmwyzirmEr75oDIFBEtXzgp
         r0ag==
X-Gm-Message-State: AOAM533mPlkrl4f7+ked2nltCrtIRCi5uW1eby7qzQFTpSpQ6xKnGolx
        LgTSNaK9ycsbtNImUphRJA==
X-Google-Smtp-Source: ABdhPJxLoAkjNu1srPTTOJXfdPHKoAjR0hh3Z9t9WUVKsa/8K7C6Upp4n18c3yJtxpMImROBnwVbbw==
X-Received: by 2002:a05:6830:2006:: with SMTP id e6mr8047817otp.257.1629305377788;
        Wed, 18 Aug 2021 09:49:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s184sm124056oif.20.2021.08.18.09.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:49:37 -0700 (PDT)
Received: (nullmailer pid 2744304 invoked by uid 1000);
        Wed, 18 Aug 2021 16:49:36 -0000
Date:   Wed, 18 Aug 2021 11:49:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <YR06IK8UzrsfPec+@robh.at.kernel.org>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-2-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817154951.50208-2-jacopo@jmondi.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 05:49:50PM +0200, Jacopo Mondi wrote:
> Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  .../iio/chemical/senseair,sunrise.yaml        | 51 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml b/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> new file mode 100644
> index 000000000000..b77196666187
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/senseair,sunrise.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Senseair Sunrise 006-0-0007 CO2 Sensor
> +
> +maintainers:
> +  - Jacopo Mondi <jacopo@jmondi.org>
> +
> +description: |
> +  Senseair Sunrise 006-0-0007 is a NDIR CO2 sensor. It supports I2C or UART buses
> +  for communications and control.
> +
> +  Datasheets:
> +    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/PSP11704.pdf
> +    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/PSH11649.pdf
> +    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> +    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Market/publicerat/TDE7318.pdf
> +
> +properties:
> +  compatible:
> +    const: senseair,sunrise-006-0-0007
> +
> +  reg:
> +    maxItems: 1
> +
> +  ndry-gpios:
> +    description: Phandle to the GPIO line connected to the nDRY pin. Active low.
> +
> +  en-gpios:
> +    description: Phandle to the GPIO line connected to the EN pin. Active high.

You need to define how many (maxItems: 1).

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      sunrise@68 {

'co2-sensor' perhaps.

> +        compatible = "senseair,sunrise-006-0-0007";
> +        reg = <0x68>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 944a14926e02..c60502eb3d36 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1000,6 +1000,8 @@ patternProperties:
>      description: Shenzhen SEI Robotics Co., Ltd
>    "^semtech,.*":
>      description: Semtech Corporation
> +  "^senseair,.*":
> +    description: Senseair AB
>    "^sensirion,.*":
>      description: Sensirion AG
>    "^sensortek,.*":
> --
> 2.32.0
> 
> 
