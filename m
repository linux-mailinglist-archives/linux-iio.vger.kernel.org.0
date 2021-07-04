Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC63BADE5
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGDRDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDRDO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:03:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E914613CE;
        Sun,  4 Jul 2021 17:00:36 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:02:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 09/10] dt-bindings: iio: afe: add bindings for
 temperature-sense-rtd
Message-ID: <20210704180259.7cba5831@jic23-huawei>
In-Reply-To: <20210701010034.303088-10-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-10-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 21:00:33 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe one case, the measurement of a temperature through the
> voltage across an RTD resistor such as a PT1000.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> new file mode 100644
> index 000000000000..e23e74e63ec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> @@ -0,0 +1,101 @@
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
> +  RTDs (Resistance Temperature Detectors) are a kind of temperature sensors
> +  used to get a linear voltage to temperature reading within a give range
> +  (usually 0 to 100 degrees Celsius).
> +
> +  When an io-channel measures the output voltage across an RTD such as a
> +  PT1000, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.
> +
> +  The general transfer function here is (using SI units)
> +
> +    V = R(T) * iexc
> +    R(T) = r0 * (1 + alpha * T)
> +    T = 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
> +
> +  The following circuit matches what's in the examples section.
> +
> +           5V0
> +          -----
> +            |
> +        +---+----+
> +        |  R 5k  |
> +        +---+----+
> +            |
> +            V 1mA
> +            |
> +            +---- Vout
> +            |
> +        +---+----+
> +        | PT1000 |
> +        +---+----+
> +            |
> +          -----
> +           GND
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

Only 1 channel, so this should be 0.  For consumers of this driver
they only need to identify the device, not the device + channel.

https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio.yaml

> +
> +  excitation-current-microamp:
> +    description: The current fed through the RTD sensor.
> +
> +  alpha-ppm-per-celsius:
> +    description: |
> +      alpha can also be expressed in micro-ohms per ohm Celsius. It's a linear
> +      approximation of the resistance versus temperature relationship
> +      between 0 and 100 degrees Celsius.
> +
> +      alpha = (R_100 - R_0) / (100 * R_0)
> +
> +      Where, R_100 is the resistance of the sensor at 100 degrees Celsius, and
> +      R_0 (or r-naught-ohms) is the resistance of the sensor at 0 degrees
> +      Celsius.
> +
> +      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
> +      and ASTM E-1137 specify an alpha of 3850.
> +
> +  r-naught-ohms:
> +    description: |
> +      Resistance of the sensor at 0 degrees Celsius.
> +      Common values are 100 for PT100, 500 for PT500, and 1000 for PT1000
> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +  - excitation-current-microamp
> +  - alpha-ppm-per-celsius
> +  - r-naught-ohms
> +
> +examples:
> +  - |
> +    pt1000_1: temperature-sensor0 {
> +        compatible = "temperature-sense-rtd";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc1 0>;
> +
> +        excitation-current-microamp = <1000>; /* i = U/R = 5 / 5000 */
> +        alpha-ppm-per-celsius = <3908>;
> +        r-naught-ohms = <1000>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bf553e53f0f..ed80e671a16a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8897,6 +8897,13 @@ F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  
> +IIO UNIT CONVERTER (TEMPERATURE)
> +M:	Liam Beguin <liambeguin@gmail.com>
> +R:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

I'm not sure we'd normally bother with a MAINTAINERS entry when it is just the binding doc
(as rest is in the driver).  The binding doc itself has it's own local maintainers entry
which is the more useful one.

> +
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
>  M:	Stanislaw Gruszka <stf_xl@wp.pl>

