Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012EB426F0C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhJHQhR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 12:37:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3951 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJHQhR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 12:37:17 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HQtxv0Sh4z67P67;
        Sat,  9 Oct 2021 00:32:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 18:35:19 +0200
Received: from localhost (10.52.124.14) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 17:35:18 +0100
Date:   Fri, 8 Oct 2021 17:34:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <andrei.drimbarean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <fazilyildiran@gmail.com>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>
Subject: Re: [PATCH 1/2] dt-bindings: add adpd188 schema
Message-ID: <20211008173459.00002242@Huawei.com>
In-Reply-To: <20211008112747.79969-2-andrei.drimbarean@analog.com>
References: <20211008112747.79969-1-andrei.drimbarean@analog.com>
        <20211008112747.79969-2-andrei.drimbarean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.14]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 14:27:46 +0300
<andrei.drimbarean@analog.com> wrote:

> From: Andrei Drimbarean <andrei.drimbarean@analog.com>
Hi Andrei

Welcome to IIO!

Anyhow, now for review.  Comments inline.

All patches need a patch description.  For a binding it's normal to put
a little bit about the device here.

> 
> Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>
> ---
>  .../bindings/iio/light/adi,adpd188.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml b/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
> new file mode 100644
> index 000000000000..3c08b0904803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/adi,adpd188.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADPD188 device driver
> +
> +maintainers:
> +  - Andrei Drimbarean <andrei.drimbarean@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADPD188 device. 

What sort of device is it?  Give us a little bit of detail.

> The device support both SPI and I2C

Please keep the line length under 80 characters when it doesn't hurt readability to do so.

> +  interfaces. Datasheet can be found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf

Blank line after blocks such as here.

> +properties:
> +  compatible:
> +    enum:
> +      - adi,adpd188
> +
> +  reg:
> +    description: SPI chip select number or I2C slave address
> +    maxItems: 1

No real need to describe this as it's very standard.

    reg: true;

is probably enough info for this one.

> +
> +  interrupts:
> +    description: IRQ line for the device or device chain

Device chain? That's unusual enough that we should probably have
some more detail somewhere in this binding on what that means.

> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  status:
> +    const: 'okay'

That should not be in a binding document. It's a general property so
if we did list it, we would need it everywhere. It is also perfectly
acceptable to have a status that says the device isn't present.

> +
> +  adi,no-of-devices:
> +    description: Number of daisy-chained devices on an I2C bus
> +      string

More detail needed on this I think.
Also a default (0 or 1 based?)

> +    $ref: "http://devicetree.org/schemas/types.yaml#/definitions/uint8"

Are there any power supplies that should be described somewhere here?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      status = "okay";
> +
> +      adpd188@64 {
> +        compatible = "adi,adpd188";
> +        reg = <0x64>;
> +        interrupts = <9 1>;
> +        interrupt-parent = <&gpio>;
> +        adi,no-of-devices = <8>;
> +      };
> +    };
> +
> +additionalProperties: false
additionalProperties belongs above the 'examples' block.


