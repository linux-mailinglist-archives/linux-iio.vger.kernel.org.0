Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5045E39C22C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 23:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFDVSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 17:18:52 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42912 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDVSw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 17:18:52 -0400
Received: by mail-ot1-f48.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6000956oth.9;
        Fri, 04 Jun 2021 14:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MG5KxgxX2V167Mxk01FiCjyeRCj/anSLT1f7uYJ6gGc=;
        b=eVhxq1nW+nMTogWSjAGeKX9j2oFOXBNvjChav6ynKJRF8fbCIWH15inah+qiPBEve+
         uaLyC+shF3aOpqn65X/jXxK05VEHXNAUbsI9FFxVcx2jRfZbSytkuTarKrT6pdiLsyE6
         A7hW6CJ+dyPAExkdkBE9FVrXhnxZTlJMcC/AAwXqB/JpGrJigVHSlyDo4bVeczSAEAwA
         TJYX8QzC2BPqGxwKZ2ek1V6i/8B3b17ePU7fsDbTSI/nCgVs3eR+hwbXhox8bsvHF5vP
         n8zKCZk/BxTjEwQVTwAXy8JnCaA3totosBOoQXbd3344Mkfq7gqompR8xHIq4Sv3cc3q
         vyBQ==
X-Gm-Message-State: AOAM53162vGHNgvU/ToVi/XiajK6gkPqpv8inGOzj6i3Uh3fsr8ML31u
        +RYonwszNPZvJ8osims+zg==
X-Google-Smtp-Source: ABdhPJzgiyxpTp9buLL/uBcm5ExFupjA7/fgJketo2exschqxCHyZdbZ5cx6LZ8V3NJLSEEC4CSNAQ==
X-Received: by 2002:a05:6830:1518:: with SMTP id k24mr5131330otp.40.1622841424250;
        Fri, 04 Jun 2021 14:17:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x24sm712328otq.34.2021.06.04.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:17:03 -0700 (PDT)
Received: (nullmailer pid 3933507 invoked by uid 1000);
        Fri, 04 Jun 2021 21:17:02 -0000
Date:   Fri, 4 Jun 2021 16:17:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 7/9] dt-bindings: iio: afe: add binding for
 temperature-sense-rtd
Message-ID: <20210604211702.GA3925041@robh.at.kernel.org>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-8-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530005917.20953-8-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 29, 2021 at 08:59:15PM -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through
> the voltage across an RTD resistor such as a PT1000.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-rtd.yaml        | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> new file mode 100644
> index 000000000000..4798eda6e533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense RTD
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage across an RTD such as a

What's an RTD? Not defined anywhere here.

> +  PT1000, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-rtd
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1

Doesn't this belong in the provider?

> +
> +  excitation-current-microamp:
> +    description: The current fed through the RTD sensor.
> +
> +  alpha-micro-ohms-per-ohm-celsius:
> +    description: |
> +      Linear approximation of the resistance versus temperature relationship
> +      between 0 and 100 degrees Celsius.
> +
> +      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
> +      and ASTM E-1137 specify an alpha of 3850.

Is there a max and min value?

> +
> +  r-naught-ohms:
> +    description: |
> +      Resistance of the sensor at 0 degrees Celsius.
> +      Common values are 100 for PT100 and 1000 for PT1000.

max or min?

> +
> +additionalProperties: false

blank line here.

> +required:
> +  - compatible
> +  - io-channels
> +  - excitation-current-microamp
> +  - alpha-micro-ohms-per-ohm-celsius
> +  - r-naught-ohms
> +
> +examples:
> +  - |
> +    pt1000_1: iio-rescale0 {
> +        compatible = "temperature-sense-rtd";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc1 0>;
> +
> +        excitation-current-microamp = <1000>;
> +        alpha-micro-ohms-per-ohm-celsius = <3908>;
> +        r-naught-ohms = <1000>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3ab0ccc34ab..a7279af85adb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  
> -- 
> 2.30.1.489.g328c10930387
