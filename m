Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FEF39785E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhFAQtE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:49:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3128 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhFAQtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:49:04 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvdFb06tjz6Q3dY;
        Wed,  2 Jun 2021 00:40:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:47:20 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:47:19 +0100
Date:   Tue, 1 Jun 2021 17:47:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for
 temperature-sense-current
Message-ID: <20210601174713.00002279@Huawei.com>
In-Reply-To: <20210530005917.20953-9-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-9-liambeguin@gmail.com>
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

On Sat, 29 May 2021 20:59:16 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through
> a current sense amplifier (such as an AD590) and a sense resistor.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-current.yaml    | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> new file mode 100644
> index 000000000000..1bac74486102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-current.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense Current
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage for a temperature current
> +  sense amplifier such as the AD950, the interesting measurement is almost
> +  always the corresponding temperature, not the voltage output.
> +  This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-current

What about such a sensor connected to a current ADC? That was what I was
immediately expecting when I saw the naming.

You could daisy chain this with the current-sense-resistor AFE though
that does seem overly messy.

Anyhow this should be called something that reflects the presence of
that sense resitor.

> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  sense-resistor-ohms:
> +    description: The sense resistance.
> +
> +  alpha-micro-amps-per-degree:
> +    description: |
> +      Linear output current gain of the temperature IC.
> +
> +  use-kelvin-scale:
> +    type: boolean
> +    description: |
> +      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +  - sense-resistor-ohms
> +  - alpha-micro-amps-per-degree
> +
> +examples:
> +  - |
> +    ad590: iio-rescale0 {
> +        compatible = "temperature-sense-current";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 2>;
> +
> +        sense-resistor-ohms = <8060>;
> +        use-kelvin-scale;
> +        alpha-micro-amps-per-degree = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7279af85adb..0eb7fcd94b66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c

