Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578BF476493
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhLOVak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 16:30:40 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33686 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLOVaj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 16:30:39 -0500
Received: by mail-oi1-f178.google.com with SMTP id q25so33639013oiw.0;
        Wed, 15 Dec 2021 13:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=71Gp03jRiryB5KlI1n8Wnc0U8QAX3fnZRt25VdiZuBo=;
        b=tHlymVHHLNByWKGI+RjhaX9vQLynJh7wfzvQpLzv8UXsxKupwI69DOHj/gn8OTqhjH
         q/WV412s6We58wKwPRmA2Db/LfdC9O5Cro4Pb8/h8GFNU0Pgyv+TxX6jzQGZzORCD0qc
         lPu3OzTBU+VsqtIuyDU3HpRqeVjuMNmDMc0PNwM7IagR/ALjaDD1BLcK05oNmdyJAY2M
         G76c8XeRtBqnSFCxore47tAmMBYLTtMyL73JEJVLtVgscDooHnNJ6R9P0Ox+NkWAvMQH
         9CVtE9bjTzw/13wCJcihkkfSiXXhMqc5zFLxNZ1aGyafXri2iw5zep+e2ro+7/aZc5rr
         shtw==
X-Gm-Message-State: AOAM530wIEC1Rm2ZgGWw9TsED7Maylkw28/cdbcFcGqCHrt1V6GwYwVe
        3gDvxlFL5StzOotuegSrkg==
X-Google-Smtp-Source: ABdhPJxdmd/8ZvJ3qYwAxySWWmPMSv7BTFEjtBH1pfRP230PqCDa/kn7gsnk93iJ8zxTIff7p7nznA==
X-Received: by 2002:a54:4809:: with SMTP id j9mr1652970oij.59.1639603839107;
        Wed, 15 Dec 2021 13:30:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb7sm780218oob.14.2021.12.15.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:30:38 -0800 (PST)
Received: (nullmailer pid 1873369 invoked by uid 1000);
        Wed, 15 Dec 2021 21:30:37 -0000
Date:   Wed, 15 Dec 2021 15:30:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: Add ltc2688 documentation
Message-ID: <YbpefZY2lqtgLpUV@robh.at.kernel.org>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211214165608.7903-4-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214165608.7903-4-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 14, 2021 at 05:56:08PM +0100, Nuno Sá wrote:
> Document the LTC2688 devicetree properties.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2688.yaml         | 146 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> new file mode 100644
> index 000000000000..7919cd8ec7c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2688 DAC
> +
> +maintainers:
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices LTC2688 16 channel, 16 bit, +-15V DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2688.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2688
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +
> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  vref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-scale
> +      range of all channels. By default, the internal reference is routed to
> +      this pin.
> +
> +  reset-gpios:
> +    description:
> +      If specified, it will be asserted during driver probe. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      enum: [TGP1, TGP2, TGP3]

pattern: '^TGP[1-3]$'

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: The channel number representing the DAC output channel.
> +        maximum: 15
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation enables
> +          fast switching of a DAC output between two different DAC codes without
> +          any SPI transaction. It will result in a different ABI for the
> +          channel.
> +        type: boolean
> +
> +      adi,output-range-millivolt:

Not one of the defined units. Use '-microvolt'
> +        description:
> +          Specify the channel output full scale range. Allowed values are
> +            <0 5000>
> +            <0 10000>
> +            <-5000 5000>
> +            <-10000 10000>
> +            <-15000 15000>

Looks like constraints.

items:
  - enum: [ -15000, -10000, -5000, 0 ]
  - enum: [ 5000, 10000, 15000 ]

though that will need to all be x1000.

> +        $ref: /schemas/types.yaml#/definitions/int32-array

And drop the type.

> +
> +      adi,overrange:
> +        description: Enable 5% overrange over the selected full scale range.
> +        type: boolean
> +
> +      adi,toggle-dither-input:
> +        description:
> +          Selects the TGPx pin to be associated with this channel. This setting
> +          only makes sense for toggle or dither enabled channels. If
> +          @adi,toggle-mode is not set and this property is given, the channel is
> +          assumed to be a dither capable channel. Note that multiple channels
> +          can be mapped to the same pin. If this setting is given, the
> +          respective @clock must also be provided. Mappings between this and
> +          clocks
> +            0 - TGP1
> +            1 - TGP2
> +            2 - TGP3
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    spi {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          ltc2688: ltc2688@0 {
> +                  compatible = "adi,ltc2688";
> +                  reg = <0>;
> +
> +                  vcc-supply = <&vcc>;
> +                  iovcc-supply = <&vcc>;
> +                  vref-supply = <&vref>;
> +
> +                  clocks = <&clock_tgp2>;
> +                  clock-names = "TGP2";
> +
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  channel@0 {
> +                          reg = <0>;
> +                          adi,toggle-mode;
> +                          adi,overrange;
> +                  };
> +
> +                  channel@1 {
> +                          reg = <1>;
> +                          adi,output-range-millivolt = <(-10000) 10000>;
> +                          adi,toggle-dither-input = <2>;
> +                  };
> +          };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61b1eaad4611..4ee2a1b6bf62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11168,6 +11168,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
>  F:	drivers/iio/dac/ltc2688.c
>  
>  LTC2947 HARDWARE MONITOR DRIVER
> -- 
> 2.17.1
> 
> 
