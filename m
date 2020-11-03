Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116C72A4B01
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCQSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:18:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35243 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgKCQSw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:18:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id n11so16485295ota.2;
        Tue, 03 Nov 2020 08:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kzc7NTNk+jn1PwxEbOe5B1xQVAt7z6VoLw/UBo2I7K0=;
        b=l+/tPksusZgd9xC9dJq5P/HtrRLbWglhHG+ifSWuAo+JnBFfJNTmQgaa8kowQ69XcE
         Wq7XNVGoHn9t8kYRKTTU++sW1NiVbdBTtDOn+21pRrv3YGTPq2oiHo7KtMqXQaiwyljN
         GCv440VM19/ujHMc5OZUcadMq4MEJooVvSOQzn3UjfQk6G48yd3psu9VQMBPiwCPQTZ6
         bL6ey3ktlgC87N74vz8EV071dc5BwUMODjiiqWaECresDs8qKzfaL0ftY+GFMHpkkt+m
         9u7uxXUrJEmKgnUDrBYm5GPhMkY121xolzjEjlbLSY9b6HsXY/DeV2phUf3pWqhtWFBn
         VMNw==
X-Gm-Message-State: AOAM530w4gyxmZ6y9wsN3a3zd8+S4wyTjobnul75FQ81ozi8XBLCVQih
        7MPh1g5A3KIy5B0F0Qv72BiasgdG9g==
X-Google-Smtp-Source: ABdhPJye1bAA5Qspa9WPtdKYXd/3TdvEzUz6MP/YSKPWbRK9cLmsq4HzXutOKPE2CXMG1kBoJBs3CQ==
X-Received: by 2002:a9d:6647:: with SMTP id q7mr12845019otm.196.1604420331030;
        Tue, 03 Nov 2020 08:18:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n23sm4317513oon.14.2020.11.03.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:18:50 -0800 (PST)
Received: (nullmailer pid 1768641 invoked by uid 1000);
        Tue, 03 Nov 2020 16:18:49 -0000
Date:   Tue, 3 Nov 2020 10:18:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 19/46] dt-bindings:iio:light:upisemi,us51882: txt to yaml
 conversion.
Message-ID: <20201103161849.GC1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-20-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-20-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:27PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I don't have an up to date address for Adriana Reus so I've put myself
> as the binding maintainer for this one.  I'm happy to hand over to Adriana
> or anyone else who wants take it on!
> 
> This has a lot of optional tuning parameters. The docs are modified to try
> and put the default values in the description of each one rather than a
> forwards reference to the example.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/light/upisemi,us5182.yaml    | 75 +++++++++++++++++++
>  .../devicetree/bindings/iio/light/us5182d.txt | 45 -----------
>  2 files changed, 75 insertions(+), 45 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> new file mode 100644
> index 000000000000..b9dc8ae25bf0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/upisemi,us5182.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UPISEMI us5182d I2C ALS and Proximity sensor
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: upisemi,asd5182
> +
> +  reg:
> +    maxItems: 1
> +
> +  upsemi,glass-coef:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      glass attenuation factor - compensation factor of resolution 1000
> +      for material transmittance.  Default: 1000

       default: 1000

> +
> +  upisemi,dark-ths:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    minItems: 8
> +    maxItems: 8
> +    description:
> +      16-bit thresholds (adc counts) corresponding to every scale.
> +
> +  upisemi,upper-dark-gain:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      8-bit dark gain compensation factor(4 int and 4 fractional bits - Q4.4)
> +      applied when light > threshold. Default: 0.

       default: 0

> +
> +  upisemi,lower-dark-gain:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      8-bit dark gain compensation factor(4 int and 4 fractional bits - Q4.4)
> +      applied when light < threshold. Default: 0x16

     default: 0x16

> +
> +  upisemi,continuous:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description: |
> +      This chip has two power modes: one-shot (chip takes one measurement and
> +      then shuts itself down) and continuous (chip takes continuous
> +      measurements). The one-shot mode is more power-friendly but the
> +      continuous mode may be more reliable. If this property is specified
> +      the continuous mode will be used instead of the default one-shot one for
> +      raw reads.
> +
> +additionalProperties: false
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
> +        light-sensor@39 {
> +            compatible = "upisemi,usd5182";
> +            reg = <0x39>;
> +            upisemi,glass-coef = < 1000 >;
> +            upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
> +            upisemi,upper-dark-gain = /bits/ 8 <0x00>;
> +            upisemi,lower-dark-gain = /bits/ 8 <0x16>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> deleted file mode 100644
> index a61979997f37..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/us5182d.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -* UPISEMI us5182d I2C ALS and Proximity sensor
> -
> -Required properties:
> -- compatible: must be "upisemi,usd5182"
> -- reg: the I2C address of the device
> -
> -Optional properties:
> -- upisemi,glass-coef: glass attenuation factor - compensation factor of
> -                      resolution 1000 for material transmittance.
> -
> -- upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
> -                    counts) corresponding to every scale.
> -
> -- upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
> -                           fractional bits - Q4.4) applied when light > threshold
> -
> -- upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
> -                           fractional bits - Q4.4) applied when light < threshold
> -
> -- upisemi,continuous: This chip has two power modes: one-shot (chip takes one
> -                      measurement and then shuts itself down) and continuous (
> -                      chip takes continuous measurements). The one-shot mode is
> -                      more power-friendly but the continuous mode may be more
> -                      reliable. If this property is specified the continuous
> -                      mode will be used instead of the default one-shot one for
> -                      raw reads.
> -
> -If the optional properties are not specified these factors will default to the
> -values in the below example.
> -The glass-coef defaults to no compensation for the covering material.
> -The threshold array defaults to experimental values that work with US5182D
> -sensor on evaluation board - roughly between 12-32 lux.
> -There will be no dark-gain compensation by default when ALS > thresh
> -(0 * dark-gain), and a 1.35 compensation factor when ALS < thresh.
> -
> -Example:
> -
> -    usd5182@39 {
> -                compatible = "upisemi,usd5182";
> -                reg = <0x39>;
> -                upisemi,glass-coef = < 1000 >;
> -                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
> -                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
> -                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
> -    };
> -- 
> 2.28.0
> 
