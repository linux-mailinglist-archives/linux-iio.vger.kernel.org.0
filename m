Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9358622F681
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgG0RY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 13:24:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2541 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730611AbgG0RY1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jul 2020 13:24:27 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A785D395796E4E15A9F2;
        Mon, 27 Jul 2020 18:24:26 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 18:24:26 +0100
Date:   Mon, 27 Jul 2020 18:24:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Darius Berghe <darius.berghe@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jic23@kernel.org>,
        <robh@kernel.org>, "Mike Looijmans" <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 3/3] ltc2471 driver yaml
Message-ID: <20200727182425.00001db9@huawei.com>
In-Reply-To: <20200727135834.84093-4-darius.berghe@analog.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
        <20200727135834.84093-4-darius.berghe@analog.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 16:58:34 +0300
Darius Berghe <darius.berghe@analog.com> wrote:

> Add dt binding documentation for ltc2471 driver. This covers all supported
> devices.
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>

+CC Mike given the doc lists him as maintainer.

> ---
>  .../bindings/iio/adc/adi,ltc2471.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> new file mode 100644
> index 000000000000..d5b35a1fa651
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ltc2471.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2471 16-bit I2C Sigma-Delta ADC
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Analog Devices LTC2461 (single-ended) and LTC2463 (differential) 16-bit
> +  I2C Sigma-Delta ADC with 60sps output rate.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/24613fa.pdf
> +
> +  Analog Devices LTC2471 (single-ended) and LTC2473 (differential) 16-bit
> +  I2C Sigma-Delta ADC with selectable 208/833sps output rate.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/24713fb.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2461
> +      - adi,ltc2463
> +      - adi,ltc2471
> +      - adi,ltc2473
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply (2.7V - 5.5V)

additionalProperties: false

should be fine here I think...
I keep forgetting this one myself.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      adc@14 {
> +        compatible = "adi,ltc2461";
> +        reg = <0x14>;
> +      };
> +    };
> +

