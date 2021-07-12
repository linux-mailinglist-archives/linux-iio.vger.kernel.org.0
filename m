Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A913C602D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhGLQOt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 12:14:49 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:36580 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhGLQOt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 12:14:49 -0400
Received: by mail-il1-f181.google.com with SMTP id j5so2511346ilk.3;
        Mon, 12 Jul 2021 09:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9HMN5LJZVuVA0FOK0FGkM8nqyj4ld2XA2G0Cc8q6SD0=;
        b=rXnWrTUHQLMDfQ3t+E8/EpEZTn4bcgscmBoQbBNe92o0p0lt+jihzfQwLDOwocRQS+
         mFHrH+AVAefRQmv5M9EbTqIeN9GaSguVGAWP46c+alxH1E2iSs4noC9VnITi6YXDkUog
         ZuzyLLO4I9Rcw7v71zD5zIeePmZyRmhodMjYOYWDG8ydZcc7bKaCJBeCkepMULDWTWbv
         BhZC0E+oINNiVu5EsFN9kOlCTK+3NmWP1UwgASP6XcigBeO4C2ocQb5wt0CdEJZnqQHt
         f3ko5oYwvjFReetOq1kYBMXEJUm1NPlgQqCVt4FskTJTe9BeM2tnuu4HNGzo8RTf6fSq
         hDhw==
X-Gm-Message-State: AOAM5320v8QZc6DkTsQM27h2Siwh3K3C9GdB49imZUUMFs245my7fS1K
        U0cMGAVspCcUl4eYCKmfaQ==
X-Google-Smtp-Source: ABdhPJzexgPf2jnfJFGtPKXhUglMRagL0lC++MIZgyNXUnpXfQx4WcWjb5+OQAj2GmyFY1KFtUj8cw==
X-Received: by 2002:a05:6e02:602:: with SMTP id t2mr13857344ils.118.1626106318750;
        Mon, 12 Jul 2021 09:11:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l8sm8740446iok.26.2021.07.12.09.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:11:58 -0700 (PDT)
Received: (nullmailer pid 2034482 invoked by uid 1000);
        Mon, 12 Jul 2021 16:11:56 -0000
Date:   Mon, 12 Jul 2021 10:11:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 10/10] dt-bindings: iio: afe: add bindings for
 temperature transducers
Message-ID: <20210712161156.GA2029104@robh.at.kernel.org>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-11-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706160942.3181474-11-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 06, 2021 at 12:09:42PM -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly.
> This binding describe one case, the measurement of a temperature
> through a temperature transducer (either voltage or current).
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-transducer.yaml       | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
> new file mode 100644
> index 000000000000..b5a4fbfe75e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-transducer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Transducer
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  A temperature transducer is a device that converts a thermal quantity
> +  into any other physical quantity. This binding applies to temperature to
> +  voltage (like the LTC2997), and temperature to current (like the AD590)
> +  linear transducers.
> +  In both cases these are assumed to be connected to a voltage ADC.
> +
> +  When an io-channel measures the output voltage of a temperature analog front
> +  end such as a temperature transducer, the interesting measurement is almost
> +  always the corresponding temperature, not the voltage output. This binding
> +  describes such a circuit.
> +
> +  The general transfer function here is (using SI units)
> +    V(T) = Rsense * Isense(T)
> +    T = (Isense(T) / alpha) + offset
> +    T = 1 / (Rsense * alpha) * (V + offset * Rsense * alpha)
> +
> +  When using a temperature to voltage transducer, Rsense is set to 1.
> +
> +  The following circuits show a temperature to current and a temperature to
> +  voltage transducer that can be used with this binding.
> +
> +           VCC
> +          -----
> +            |
> +        +---+---+
> +        | AD590 |                               VCC
> +        +---+---+                              -----
> +            |                                    |
> +            V proportional to T             +----+----+
> +            |                          D+ --+         |
> +            +---- Vout                      | LTC2997 +--- Vout
> +            |                          D- --+         |
> +        +---+----+                          +---------+
> +        | Rsense |                               |
> +        +---+----+                             -----
> +            |                                   GND
> +          -----
> +           GND
> +
> +properties:
> +  compatible:
> +    const: temperature-transducer
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 0

This is a io-channel consumer and producer?

> +
> +  sense-offset-millicelsius:
> +    description: |
> +      Temperature offset. The default is <0>.
> +      This offset is commonly used to convert from Kelvins to degrees Celsius.
> +      In that case, sense-offset-millicelsius would be set to <(-273150)>.

default: 0

> +
> +  sense-resistor-ohms:
> +    description: |
> +      The sense resistor. Defaults to <1>.
> +      Set sense-resistor-ohms to <1> when using a temperature to voltage
> +      transducer.

default: 1

Though why would we set the value to 1 if the default is 1?

> +
> +  alpha-ppm-per-celsius:
> +    description: |
> +      Sometimes referred to as output gain, slope, or temperature coefficient.
> +
> +      alpha is expressed in parts per million which can be micro-amps per
> +      degrees Celsius or micro-volts per degrees Celsius. The is the main
> +      characteristic of a temperature transducer and should be stated in the
> +      datasheet.
> +
> +additionalProperties: false

Blank line here.

> +required:
> +  - compatible
> +  - io-channels
> +  - alpha-ppm-per-celsius
> +
> +examples:
> +  - |
> +    ad950: temperature-sensor-0 {
> +        compatible = "temperature-transducer";
> +        #io-channel-cells = <0>;
> +        io-channels = <&temp_adc 3>;
> +
> +        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
> +        sense-resistor-ohms = <8060>;
> +        alpha-ppm-per-celsius = <1>; /* 1 uA/K */
> +    };
> +  - |
> +    znq_tmp: temperature-sensor-1 {
> +        compatible = "temperature-transducer";
> +        #io-channel-cells = <0>;
> +        io-channels = <&temp_adc 2>;
> +
> +        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
> +        alpha-ppm-per-celsius = <4000>; /* 4 mV/K */
> +    };
> +...
> -- 
> 2.30.1.489.g328c10930387
> 
> 
