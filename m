Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32832B5DE2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgKQLDl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 06:03:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2113 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgKQLDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 06:03:40 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb3195n6cz67Dvd;
        Tue, 17 Nov 2020 19:02:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 12:03:38 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 11:03:38 +0000
Date:   Tue, 17 Nov 2020 11:03:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: adc: ad7887: add binding doc for
 AD7887
Message-ID: <20201117110330.00004adb@Huawei.com>
In-Reply-To: <20201117075254.4861-3-alexandru.ardelean@analog.com>
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
        <20201117075254.4861-3-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 09:52:54 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a simple device-tree binding for thhe Analog Devices
> AD7887 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Binding looks good to me.

Jonathan

> ---
>  .../bindings/iio/adc/adi,ad7887.yaml          | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> new file mode 100644
> index 000000000000..9b30f4569b4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7887.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7887 low power, 12-bit ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices AD7887 low power, 12-bit analog-to-digital converter (ADC)
> +  that operates from a single 2.7 V to 5.25 V power supply.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7887
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  avcc-supply: true
> +
> +  spi-max-frequency: true
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply
> +
> +  adi,dual-channel-mode:
> +    description:
> +      Configures dual-channel mode for the ADC. In dual-channel operation,
> +      the AIN1/VREF pin assumes its AIN1 function, providing a second analog
> +      input channel. In this case, he reference voltage for the part is provided
> +      via the VDD pin. As a result, the input voltage range on both the AIN0 and
> +      AIN1 inputs is 0 to VDD.
> +    type: boolean
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - spi-cpol
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +                compatible = "adi,ad7887";
> +                reg = <0>;
> +                spi-max-frequency = <1000000>;
> +                spi-cpol;
> +                spi-cpha;
> +
> +                avcc-supply = <&adc_supply>;
> +                vref-supply = <&adc_vref>;
> +        };
> +    };
> +...

