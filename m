Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F78444495B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 21:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKCULe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 3 Nov 2021 16:11:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4062 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCULe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Nov 2021 16:11:34 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HkyQw5NlHz67DfB;
        Thu,  4 Nov 2021 04:04:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:08:55 +0100
Received: from localhost (10.52.121.67) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 20:08:54 +0000
Date:   Wed, 3 Nov 2021 20:08:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Message-ID: <20211103200851.00007c67@Huawei.com>
In-Reply-To: <20211102135947.131223-3-antoniu.miclaus@analog.com>
References: <20211102135947.131223-1-antoniu.miclaus@analog.com>
        <20211102135947.131223-3-antoniu.miclaus@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.67]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 15:59:47 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the AD7293 Power Amplifier.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Whilst the driver may not support all the features, we should
try to describe as many of the hardware connections / power supplies
etc as possible.

From a quick glance, I'm seeing a reset gpio, some alert pins (which I'm
assuming can be used as interrupts, and several power supplies that should
be provided by regulators.

So for v2, please added as much of that as possible.

There may be odd corner cases (e.g. the sleep pins) where we aren't
completely sure how they would be used, which you can leave for when/if
we figure out what makes sense.

Jonathan

> ---
>  .../bindings/iio/amplifiers/adi,ad7293.yaml   | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> new file mode 100644
> index 000000000000..b9cfd4621fb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad7293.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7293 12-Bit Power Amplifier Current Controller with ADC,
> +       DACs, Temperature and Current Sensors
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Power Amplifier drain current controller containing functionality
> +   for general-purpose monitoring and control of current, voltage,
> +   and temperature, integrated into a single chip solution with an
> +   SPI-compatible interface.
> +
> +   https://www.analog.com/en/products/ad7293.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7293
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
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
> +      ad7293@0 {
> +        compatible = "adi,ad7293";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +      };
> +    };
> +...

