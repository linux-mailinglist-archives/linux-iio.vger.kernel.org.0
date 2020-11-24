Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCB2C24DB
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgKXLmd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 06:42:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2144 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbgKXLmd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2020 06:42:33 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CgMWY5kWMz67GxF;
        Tue, 24 Nov 2020 19:39:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 24 Nov 2020 12:42:26 +0100
Received: from localhost (10.47.66.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 24 Nov
 2020 11:42:26 +0000
Date:   Tue, 24 Nov 2020 11:42:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Pop <cristian.pop@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20201124114210.000068ef@Huawei.com>
In-Reply-To: <20201123145042.18930-1-cristian.pop@analog.com>
References: <20201123145042.18930-1-cristian.pop@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.66.130]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 16:50:41 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

One trivial point inline.  If that's all we have in the series I can tidy up
whilst applying.

Jonathan

> ---
>  .../bindings/iio/dac/adi,ad5766.yaml          | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> new file mode 100644
> index 000000000000..aed4a0472bc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/dac/adi,ad5766.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5766 DAC device driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
> +

Just one blank line.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5766
> +      - adi,ad5767
> +
> +  reg:
> +    maxItems: 1
> +  
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be
> +      asserted during driver probe.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +examples:
> +  - |
> +    ad5766@0{
> +        compatible = "adi,ad5766";
> +        reg = <0>;
> +        spi-cpol;
> +        spi-max-frequency = <1000000>;
> +        reset-gpios = <&gpio 22 0>;
> +      };

