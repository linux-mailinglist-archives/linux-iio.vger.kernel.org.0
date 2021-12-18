Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E605479CD1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 22:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhLRVSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhLRVSS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 16:18:18 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD636C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:18:17 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id o10so5743740qvc.5
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6YB8E+u4WgAqVd8/4Wud31DBoL6UaKxWGDt9NmRpaYY=;
        b=XYsw+1WNn6T/E7aWMFIhEcraQblEWIv3TAbseSFNbqUGZjAOk/nU4U39op+D5xlmMV
         jYy1Kom59MbpZFmNn4ne7o4yWpW7nJw8i6GUCed5L5AnTEkTIrIaOuJVODIMewX5/JJF
         uNb1yjxDJ1Yhbdd2xwat3CLCjU3Kdv8+bbaYqnVgHBziaouTanQt0pcpwntRLtfus/6W
         dcP7XXvZ0OlFjW4NIWo3N+C1aEWjYBWARykqSi4UloitJpHqVlAF4KxW/Mcm+bOL45IP
         wTcWji3DGtOsIkVD6D9190hiJowMPPyjhg6gIEe+IdjElmSKY3kcCjqQND0qk+6lWg20
         1F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6YB8E+u4WgAqVd8/4Wud31DBoL6UaKxWGDt9NmRpaYY=;
        b=huANGlVl7r48DRGPGXhpQiI51D54KaeKkqAQccHqIgj77S7xh2LkAcRch+JHtYVhj6
         dmgxMRTQXaYo4dOk689hpRBEaAOPRkUV++GqHLp/kaBcJqBQERZypLbxiqdMQBfpO6oU
         oVXuYCQOahFIFheQb+5WG0ja885oaOFl00UeXnF/u2dWU0IL95SIIj9zUPnyd4f6t4OV
         NLq9CsQmkX5C4VCgT94rcbSZmsoHxwNtEVLky2y0FQZuMOUbjc52m2ihK50scLF1DJ3J
         yHZ0SCQJPv5gw9+/I/j3dSKkDRqHsL0ZOkb7vI4VKF3g/oK7GKrmxbkKXHJCl4hOOaqd
         69AQ==
X-Gm-Message-State: AOAM532mxePtELcZf0MB2Ga0QsBXpRhcYkm4Vgay+AAQS50VsKu+BK/s
        SYNoq2wkeDzbZS9MCVwykV4=
X-Google-Smtp-Source: ABdhPJxf9sMreTueQ7Zqoc7+fmQCUuDlZM6MMPvKiDwXWfdxpZ6fUXo6+lwU/p9l5Ba9ENQJv/kgfA==
X-Received: by 2002:ad4:574c:: with SMTP id q12mr3852356qvx.14.1639862297095;
        Sat, 18 Dec 2021 13:18:17 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id k19sm7786394qko.73.2021.12.18.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 13:18:16 -0800 (PST)
Date:   Sat, 18 Dec 2021 18:18:12 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Message-ID: <Yb5QFJmFoc8EM5Zd@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-16-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-16-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Think it would be more intuitive to use the number of active channels as enum
elements for adi,temp-alert-last-chan and adi,voltage-alert-last-chan.
This, though, is just my personal opinion so 
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
> as it is now clean and ready to move out of staging.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> new file mode 100644
> index 000000000000..77b8f67fe446
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7280a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7280a Lithium Ion Battery Monitoring System
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Bindings for the Analog Devices AD7280a Battery Monitoring System.
> +  Used in devices such as hybrid electric cars, battery backup and power tools.
> +  Multiple chips can be daisy chained and accessed via a single SPI interface.
> +  Data sheet found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7280A.pdf
> +
> +properties:
> +  compatible:
> +    const: adi,ad7280a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ line for the ADC
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  adi,temp-alert-last-chan:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Allows limiting of scope of which channels are considered for temperature
> +      alerts, typically because not all are wired to anything. Only applies to
> +      last device in the daisy chain.
> +    default: 5
> +    enum: [3, 4, 5]
> +
> +  adi,voltage-alert-last-chan:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Allows limiting of scope of which channels are considered for voltage
> +      alerts, typically because not all are wired to anything. Only applies to
> +      last device in the daisy chain.
> +    default: 5
> +    enum: [3, 4, 5]
> +
> +  adi,acquisition-time-ns:
> +    description:
> +      Additional time may be needed to charge the sampling capacitors depending
> +      on external writing.
> +    default: 400
> +    enum: [400, 800, 1200, 1600]
> +
> +  adi,thermistor-termination:
> +    type: boolean
> +    description:
> +      Enable the thermistor termination function.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "adi,ad7280a";
> +        reg = <0>;
> +        spi-max-frequency = <700000>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 2>;
> +        adi,thermistor-termination;
> +        adi,acquisition-time-ns = <800>;
> +        adi,voltage-alert-last-chan = <5>;
> +        adi,temp-alert-last-chan = <5>;
> +      };
> +    };
> +...
> -- 
> 2.34.1
> 
