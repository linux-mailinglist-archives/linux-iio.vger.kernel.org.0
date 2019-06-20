Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CA34D03C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfFTOVC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 10:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfFTOVC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 10:21:02 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903BD2085A;
        Thu, 20 Jun 2019 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561040460;
        bh=6F5deMei+k5+YeIpCzNrBLuu2IPKgo+Fob+rK4Iy+NQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D6CfA/ADEPYvgec3kZ65C4dvIwt5vIiHBo3o+qeieu87Ce+NsXE/YURm9z0yLCYL8
         NIDFqt192RyFpvQCqFRvRyciuLjrCaMqJqiqsmTFrXWYGsHsgFjmQLtFdMhfW69TGw
         4LGwM+HYGo7hkAula2TvcTZgMwtCfX98wHuIXkKU=
Received: by mail-qt1-f175.google.com with SMTP id h21so3292734qtn.13;
        Thu, 20 Jun 2019 07:21:00 -0700 (PDT)
X-Gm-Message-State: APjAAAULEUUGa07iejw0d9orJeTFaNVzx2DtvgUqz8d72KEqL3Olfjy+
        ZpWd/GI3+Cnw4w8lGzHUzubo9aeVDhP1qszVvA==
X-Google-Smtp-Source: APXvYqw03gZBMsZRPNi1BjzZT8MEMjOmAfMJmJ2g9chv7u9G+/iC5PFAdptyPt9iPpUBZAF4tOoKVlaJ6n9XxPv+neY=
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr40415318qvu.138.1561040459773;
 Thu, 20 Jun 2019 07:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190620094203.13654-1-mircea.caprioru@analog.com> <20190620094203.13654-4-mircea.caprioru@analog.com>
In-Reply-To: <20190620094203.13654-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Jun 2019 08:20:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+P3oG1MPcMMrEfp58Ltw92kk66os34wVwNuUC9a=F2vg@mail.gmail.com>
Message-ID: <CAL_Jsq+P3oG1MPcMMrEfp58Ltw92kk66os34wVwNuUC9a=F2vg@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 20, 2019 at 3:42 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> Convert AD7124 bindings documentation to YAML format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7124.yaml          | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> new file mode 100644
> index 000000000000..2dba3759b8e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: GPL-2.0

The preference for new bindings is dual (GPL-2.0 OR BSD-2-Clause) if
that is okay with you.

> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7124.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7124 ADC device driver
> +
> +maintainers:
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7124-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7124-4
> +      - adi,ad7124-8
> +
> +  reg:
> +    description: SPI chip select number for the device
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the master clock (mclk)
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  interrupts:
> +    description: IRQ line for the ADC
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  refin1-supply:
> +    description: refin1 supply can be used as reference for conversion.
> +    maxItems: 1
> +
> +  refin2-supply:
> +    description: refin2 supply can be used as reference for conversion.
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: avdd supply can be used as reference for conversion.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +patternProperties:
> +  "^channel@[01]$":

Need to allow 2-15?

> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 8 channels on ad7124-4
> +          and 16 channels on ad7124-8, numbered from 0 to 15.

Sounds like constraints.

items:
  - minimum: 0
    maximum: 15

> +        maxItems: 1

And then you can drop this as it is implied with the number of 'items' entries.

> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel.
> +          If this field is left empty, internal reference is selected.
> +        maxItems: 1

Type? Range of values?

> +
> +      diff-channels:
> +        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +        maxItems: 1

Not correct as this is an array. Assuming this is covered by a common
adc schema, you just need to define constraints on the values:

items:
  minimum: 0
  maximum: 15

> +
> +      bipolar:
> +        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +        maxItems: 1

You can assume this is covered by common adc schema. So just 'bipolar:
true' is enough.

> +
> +      adi,buffered-positive:
> +        description: Enable buffered mode for positive input.
> +        maxItems: 1

Not right as this is bool. Needs 'type: boolean'

> +      adi,buffered-negative:
> +        description: Enable buffered mode for negative input.
> +        maxItems: 1

ditto

> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +examples:
> +  - |
> +    adc@0 {
> +      compatible = "adi,ad7124-4";
> +      reg = <0>;
> +      spi-max-frequency = <5000000>;
> +      interrupts = <25 2>;
> +      interrupt-parent = <&gpio>;
> +      refin1-supply = <&adc_vref>;
> +      clocks = <&ad7124_mclk>;
> +      clock-names = "mclk";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      channel@0 {
> +        reg = <0>;
> +        diff-channels = <0 1>;
> +        adi,reference-select = <0>;
> +        adi,buffered-positive;
> +      };
> +
> +      channel@1 {
> +        reg = <1>;
> +        bipolar;
> +        diff-channels = <2 3>;
> +        adi,reference-select = <0>;
> +        adi,buffered-positive;
> +        adi,buffered-negative;
> +      };
> +
> +      channel@2 {
> +        reg = <2>;
> +        diff-channels = <4 5>;
> +      };
> +
> +      channel@3 {
> +        reg = <3>;
> +        diff-channels = <6 7>;
> +      };
> +    };
> --
> 2.17.1
>
