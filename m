Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38B9397843
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFAQpP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:45:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3127 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFAQpP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:45:15 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fvd6F3rKXz6V03Q;
        Wed,  2 Jun 2021 00:34:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:43:32 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:43:31 +0100
Date:   Tue, 1 Jun 2021 17:43:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v1 7/9] dt-bindings: iio: afe: add binding for
 temperature-sense-rtd
Message-ID: <20210601174325.00000ca2@Huawei.com>
In-Reply-To: <20210530005917.20953-8-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-8-liambeguin@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.71]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 May 2021 20:59:15 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through
> the voltage across an RTD resistor such as a PT1000.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

Just one nit pick inline.

Hmm. these devices use some 'special' units for their coefficients.
Ah well, guess we copy the industry standard.

> ---
>  .../iio/afe/temperature-sense-rtd.yaml        | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> new file mode 100644
> index 000000000000..4798eda6e533
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense RTD
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage across an RTD such as a
> +  PT1000, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-rtd
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  excitation-current-microamp:
> +    description: The current fed through the RTD sensor.
> +
> +  alpha-micro-ohms-per-ohm-celsius:
> +    description: |
> +      Linear approximation of the resistance versus temperature relationship
> +      between 0 and 100 degrees Celsius.
> +
> +      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
> +      and ASTM E-1137 specify an alpha of 3850.
> +
> +  r-naught-ohms:
> +    description: |
> +      Resistance of the sensor at 0 degrees Celsius.
> +      Common values are 100 for PT100 and 1000 for PT1000.
> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +  - excitation-current-microamp
> +  - alpha-micro-ohms-per-ohm-celsius
> +  - r-naught-ohms
> +
> +examples:
> +  - |
> +    pt1000_1: iio-rescale0 {
> +        compatible = "temperature-sense-rtd";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc1 0>;
> +
> +        excitation-current-microamp = <1000>;
> +        alpha-micro-ohms-per-ohm-celsius = <3908>;
> +        r-naught-ohms = <1000>;
> +    };
> +

Drop this blank line.  Doesn't add anything ;)

> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3ab0ccc34ab..a7279af85adb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  

