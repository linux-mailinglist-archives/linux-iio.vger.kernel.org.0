Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72839775C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFAQBj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:01:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3121 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFAQBj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:01:39 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fvc462Nblz6M4Pb;
        Tue,  1 Jun 2021 23:47:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:59:56 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:59:55 +0100
Date:   Tue, 1 Jun 2021 16:59:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v1 9/9] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
Message-ID: <20210601165951.000002c7@Huawei.com>
In-Reply-To: <20210530005917.20953-10-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-10-liambeguin@gmail.com>
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

On Sat, 29 May 2021 20:59:17 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one cases, the measurement of a temperature through a
> voltage sense amplifier such as the LTC2997.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-amplifier.yaml  | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> new file mode 100644
> index 000000000000..015413cbffbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-amplifier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Temperature Sense Amplifier
> +
> +maintainers:
> +  - Liam Beguin <lvb@xiphos.com>
> +
> +description: |
> +  When an io-channel measures the output voltage of a temperature IC such as
> +  the LTC2997, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.
> +
> +properties:
> +  compatible:
> +    const: temperature-sense-amplifier
> +
> +  io-channels:
> +    maxItems: 1
> +    description: |
> +      Channel node of a voltage io-channel.
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  alpha-micro-volts-per-degree:

Include units in the naming.

micro-volts-per-degree-celsius: perhaps?
That will then get the type from dt-schema/schema/property-units.
Though amusing it will identify it based on celsius, when the units are arguably
volts.


> +    description: |
> +      Output voltage gain of the temperature IC.
> +
> +  use-kelvin-scale:
> +    type: boolean
> +    description: |
> +      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.

I'm not clear why that change would make any difference to alpha?  It would make
a difference to an offset though (and you should allow for one of those if
you want this to be generic).

Pick one and stick to it for all cases.  It might make the dts author do
some simple maths but that is preferable to having this flexibility
when we don't need it.

> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +  - alpha-micro-volts-per-degree
> +
> +examples:
> +  - |
> +    znq_temp: iio-rescale0 {

The end result is a temperature sensor, so this should
have a name reflecting that.  Here that would be
temperature-sensor as per the dt schema specification:
https://www.devicetree.org/specifications/

> +        compatible = "temperature-sense-amplifier";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 3>;
> +
> +        use-kelvin-scale;
> +        alpha-micro-volts-per-degree = <4000>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0eb7fcd94b66..f224bd8e6125 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-current.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml

