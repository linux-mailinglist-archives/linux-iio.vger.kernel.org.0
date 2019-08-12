Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15A8A6D7
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 21:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHLTHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 15:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfHLTHf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 15:07:35 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB1C20842;
        Mon, 12 Aug 2019 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565636854;
        bh=FcFeaQDXYSIJuf9XH3+tvFUIqjy5UNjSL13NncdI4lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qtg+nC2RZBlfIwv+HDTtkwAXEQ9hANBf8IDXAU+gEteVYnjzSBm2oYmoYCahq9N+5
         ua8Ae4B4QzeOgCeqp98o6yreb/razFufSBpe2pnd+JIGfMMlZKtm0M3gxjl9Zy8cSN
         ocZnFAd9UcZZ/p6/YbSdoXaDqxDtoFzQyQEsOxlc=
Received: by mail-qt1-f171.google.com with SMTP id b11so4158172qtp.10;
        Mon, 12 Aug 2019 12:07:34 -0700 (PDT)
X-Gm-Message-State: APjAAAVR/NwXWToimLphQOfs15PvVQ/b4RKoBxdeiDDA5MQaNDiMR+kd
        9E00TeoUoRCP+Q9A0LX2N0nsOZxjQeC2STjBdA==
X-Google-Smtp-Source: APXvYqxk/joWgBLYIYok1T9+jsQdNHJop0U8NuSELICDjk3xl7SPL7nbv63ymnQdTJGha5x0HyH+ihoMLBAs53zaNlM=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr31241634qtc.143.1565636853900;
 Mon, 12 Aug 2019 12:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190812090341.27183-1-mircea.caprioru@analog.com> <20190812090341.27183-4-mircea.caprioru@analog.com>
In-Reply-To: <20190812090341.27183-4-mircea.caprioru@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:07:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTVEMfxuCx3ueuT2uoLbxNiMUOGJzNUerJrQz95sHb=A@mail.gmail.com>
Message-ID: <CAL_JsqLTVEMfxuCx3ueuT2uoLbxNiMUOGJzNUerJrQz95sHb=A@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: iio: adc: ad7192: Add binding
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

On Mon, Aug 12, 2019 at 3:03 AM Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
>
> This patch add device tree binding documentation for AD7192 adc in YAML
> format.
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> new file mode 100644
> index 000000000000..a56ee391f6a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -0,0 +1,123 @@
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
> +    description: SPI chip select number for the device

Don't need a description as this is a standard property and there's
only 1 entry.

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
> +    description: IRQ line for the ADC

Same here.

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
> +      ad7192@0 {

adc@0

With those fixes,

Reviewed-by: Rob Herring <robh@kernel.org>
