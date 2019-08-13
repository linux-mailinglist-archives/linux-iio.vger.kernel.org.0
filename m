Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C48C3C9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 23:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfHMVe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 17:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfHMVe4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 17:34:56 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6270206C2;
        Tue, 13 Aug 2019 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565732095;
        bh=ETCEIpRGI6P10SGVHinQawDIo4K3aSvFy3EaxbBa79Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wtJg0cG1Y8abTmRWgcfIilEapvhooqjPBeeLGid78MdafirWwx8rTH6urkXFG2xla
         P3LTUsYynRjWxDZGdfSIoH4rG7jTyCFnIa6EOPFHxS9M9UNLnCi8zH1Fy6FSDT/tqk
         F0gqmZj7gkw1dlYG1Bq7bobbzhqr8wgWsjXBVGg8=
Received: by mail-qk1-f169.google.com with SMTP id s14so10513011qkm.4;
        Tue, 13 Aug 2019 14:34:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXYGdCgy8cOf2iLatkJD56m5gHjyQfXn24G9W/ZNrb1CcQYrhlx
        aBfAWJ1vl1UakGW9w3Pu7SIEe8s0K60HRXObyA==
X-Google-Smtp-Source: APXvYqwr4UNE0DxaGwu57GtRMhxVs558iBsniGHsDgLMo/2d20nyowPM8ppDh3lfbCmmy4tjWLcykviSYSe7fHgz1XY=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr36004217qke.223.1565732094984;
 Tue, 13 Aug 2019 14:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190813075544.9122-1-mircea.caprioru@analog.com> <20190813075544.9122-4-mircea.caprioru@analog.com>
In-Reply-To: <20190813075544.9122-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:34:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJo-LMmG8B6mitr38TdSj7ejrbGvcsy6TQAtvi6MoemOg@mail.gmail.com>
Message-ID: <CAL_JsqJo-LMmG8B6mitr38TdSj7ejrbGvcsy6TQAtvi6MoemOg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 13, 2019 at 1:56 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> This patch add device tree binding documentation for AD7192 adc in YAML
> format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V2:
> - remove description from spi and interrupt properties
> - changed the name of the device from ad7192 to adc in the example
>
>  .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> new file mode 100644
> index 000000000000..2d83724cb4d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7192.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7192 ADC device driver
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD7192 ADC device. Datasheet can be
> +  found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7192.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7190
> +      - adi,ad7192
> +      - adi,ad7193
> +      - adi,ad7195
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
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
> +    maxItems: 1
> +
> +  dvdd-supply:
> +    description: DVdd voltage supply
> +    items:
> +      - const: dvdd
> +
> +  avdd-supply:
> +    description: AVdd voltage supply
> +    items:
> +      - const: avdd
> +
> +  adi,rejection-60-Hz-enable:
> +    description: |
> +      This bit enables a notch at 60 Hz when the first notch of the sinc
> +      filter is at 50 Hz. When REJ60 is set, a filter notch is placed at
> +      60 Hz when the sinc filter first notch is at 50 Hz. This allows
> +      simultaneous 50 Hz/ 60 Hz rejection.
> +    type: boolean
> +
> +  adi,refin2-pins-enable:
> +    description: |
> +      External reference applied between the P1/REFIN2(+) and P0/REFIN2(=
=E2=88=92) pins.
> +    type: boolean
> +
> +  adi,buffer-enable:
> +    description: |
> +      Enables the buffer on the analog inputs. If cleared, the analog in=
puts
> +      are unbuffered, lowering the power consumption of the device. If t=
his
> +      bit is set, the analog inputs are buffered, allowing the user to p=
lace
> +      source impedances on the front end without contributing gain error=
s to
> +      the system.
> +    type: boolean
> +
> +  adi,burnout-currents-enable:
> +    description: |
> +      When this bit is set to 1, the 500 nA current sources in the signa=
l
> +      path are enabled. When BURN =3D 0, the burnout currents are disabl=
ed.
> +      The burnout currents can be enabled only when the buffer is active
> +      and when chop is disabled.
> +    type: boolean
> +
> +  bipolar:
> +    description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - dvdd-supply
> +  - avdd-supply
> +  - spi-cpol
> +  - spi-cpha
> +
> +examples:
> +  - |
> +    spi0 {
> +      adc@0 {
> +        compatible =3D "adi,ad7192";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <1000000>;
> +        spi-cpol;
> +        spi-cpha;
> +        clocks =3D <&ad7192_mclk>;
> +        clock-names =3D "mclk";
> +        #interrupt-cells =3D <2>;
> +        interrupts =3D <25 0x2>;
> +        interrupt-parent =3D <&gpio>;
> +        dvdd-supply =3D <&dvdd>;
> +        avdd-supply =3D <&avdd>;
> +
> +        adi,refin2-pins-enable;
> +        adi,rejection-60-Hz-enable;
> +        adi,buffer-enable;
> +        adi,burnout-currents-enable;
> +        };
> +    }

You didn't build this with 'make dt_binding_check'. Please do so and
fix the error here.

Rob
