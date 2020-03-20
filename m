Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B878318C462
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 01:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTAt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 20:49:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33644 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCTAt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 20:49:27 -0400
Received: by mail-io1-f65.google.com with SMTP id o127so4382370iof.0;
        Thu, 19 Mar 2020 17:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBAKZaovO7P+c8C9AJ1JuMUFLGjL6HUae79ikakVMCo=;
        b=b6gzJQyzVcfFurS/wpynrpqOyIVFAVrrQPVtve4FNJcFC2OWWggBvTfrVA2hXV/UEq
         PZq6j9HCpt7x6kpcp3ffg9aBytcSoySGkpLlI9EB09TWWGQT83N3Mp9QicJYVy3GEdMg
         7w79ulGxzEZZHqZR3mbuGzzZtx/KxeBaVV+Q6FsUAyhC4b1DuMUsNeJtQDQ0tqyb2pr6
         dVk9SiY3ES5NtuDBUmvYMKLmuR/hC72MDeOMjuO0HuWyoUxfuOdlaCIrPvDguJzOqxZb
         98F3k7UzYKeb54kWyzSPSsNBh49u70m40ccw8FLNi7J8XtEPJd5MbA9tOUNjSA+4Np53
         L8Mg==
X-Gm-Message-State: ANhLgQ1k0TOQ6nhIKVhgTLTpmtCuqfQvVITvEYTYPUV3QN23ekI3sJX5
        yU9oWLApAIUSa/VsIwJ8Wg==
X-Google-Smtp-Source: ADFU+vsSI+UFexKpMVwrhk8QlkYIWGzNIJPImKdeK96fvi4Nf4enbsS90HcpcXS72GkBsc+KD90TOg==
X-Received: by 2002:a6b:d90c:: with SMTP id r12mr5247454ioc.72.1584665365904;
        Thu, 19 Mar 2020 17:49:25 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t83sm1473377ild.42.2020.03.19.17.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:49:25 -0700 (PDT)
Received: (nullmailer pid 29909 invoked by uid 1000);
        Fri, 20 Mar 2020 00:49:22 -0000
Date:   Thu, 19 Mar 2020 18:49:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: dac: Add docs for AD5770R DAC
Message-ID: <20200320004922.GA3641@bogus>
References: <20200218121031.27233-1-alexandru.tachici@analog.com>
 <20200218121031.27233-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218121031.27233-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 18, 2020 at 02:10:31PM +0200, Alexandru Tachici wrote:
> Adding dt-bindings documentation for AD5770R DAC.

DT list needs to be Cc'ed if you want bindings reviewed.

> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 185 ++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> new file mode 100644
> index 000000000000..13d6b5ff479d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -0,0 +1,185 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5770r.yaml#

Jonathan mentioned 'adc' part, but 'bindings' is also wrong. Should be:

.../schemas/iio/dac/...

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5770R DAC device driver
> +
> +maintainers:
> +  - Mircea Caprioru <mircea.caprioru@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5770R.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5770r
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      AVdd voltage supply. Represents two different supplies in the datasheet
> +      that are in fact the same.
> +
> +  iovdd-supply:
> +    description:
> +      Voltage supply for the chip interface.
> +
> +  vref-supply:
> +    description: Specify the voltage of the external reference used.
> +      Available reference options are 1.25 V or 2.5 V. If no
> +      external reference declared then the device will use the
> +      internal reference of 1.25 V.
> +
> +  adi,external-resistor:
> +    description: Specify if an external 2.5k ohm resistor is used. If not
> +      specified the device will use an internal 2.5k ohm resistor.
> +      The precision resistor is used for reference current generation.
> +    type: boolean
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be
> +      asserted during driver probe.
> +    maxItems: 1
> +
> +  channel0:

channel@0 ???

Once you fix that, your example will start failing.

> +    description: Represents an external channel which are
> +      connected to the DAC. Channel 0 can act both as a current
> +      source and sink.
> +    type: object
> +
> +    properties:
> +      num:

Use 'reg' instead.

> +        description: This represents the channel number.
> +        items:

You can drop items.

> +          const: 0
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/int32-array

*-microamp already has a type, so this should be dropped. However, I 
believe it's unsigned currently, but we can fix it to be signed.

> +            - items:
> +                - enum: [0 300000]
> +                - enum: [-60000 0]
> +                - enum: [-60000 300000]

Negative values don't yet work until we fix dtc to be able to output 
negative values. For now, can you just avoid negative numbers in the 
example.

What's defined here doesn't match the example. You are saying there are 
3 cells with 2 possible values each. I think you want:

oneOf:
  - items:
      - const: 0
      - const: 300000
  - items:
      - const: -60000
      - const: 0
  - items:
      - const: -60000
      - const: 300000
      

> +
> +  channel1:
> +    description: Represents an external channel which are
> +      connected to the DAC.
> +    type: object
> +
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          const: 1
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 140000]
> +                - enum: [0 250000]
> +
> +  channel2:
> +    description: Represents an external channel which are
> +      connected to the DAC.
> +    type: object
> +
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          const: 2
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 140000]
> +                - enum: [0 250000]
> +
> +patternProperties:
> +  "^channel@([3-5])$":
> +    type: object
> +    description: Represents the external channels which are connected to the DAC.
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          minimum: 3
> +          maximum: 5
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 45000]
> +                - enum: [0 100000]
> +
> +required:
> +- reg
> +- diff-channels
> +- channel0
> +- channel1
> +- channel2
> +- channel3
> +- channel4
> +- channel5
> +
> +examples:
> +  - |
> +        spi {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                ad5770r@0 {
> +                        compatible = "ad5770r";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        vref-supply = <&vref>;
> +                        adi,external-resistor;
> +                        reset-gpios = <&gpio 22 0>;
> +
> +                        channel@0 {
> +                                num = <0>;
> +                                adi,range-microamp = <(-60000) 300000>;
> +                        };
> +
> +                        channel@1 {
> +                                num = <1>;
> +                                adi,range-microamp = <0 140000>;
> +                        };
> +
> +                        channel@2 {
> +                                num = <2>;
> +                                adi,range-microamp = <0 55000>;
> +                        };
> +
> +                        channel@3 {
> +                                num = <3>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +
> +                        channel@4 {
> +                                num = <4>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +
> +                        channel@5 {
> +                                num = <5>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +                };
> +        };
> +...
> -- 
> 2.20.1
> 
