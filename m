Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9933A1E4B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFIUwS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFIUwR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 16:52:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DF86054E;
        Wed,  9 Jun 2021 20:50:20 +0000 (UTC)
Date:   Wed, 9 Jun 2021 21:52:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 8/8] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
Message-ID: <20210609215214.7e3be504@jic23-huawei>
In-Reply-To: <20210607144718.1724413-9-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
        <20210607144718.1724413-9-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Jun 2021 10:47:18 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> An ADC is often used to measure other quantities indirectly. This
> binding describe such a use case, the measurement of a temperature
> through an analog front end connected to a voltage channel.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../iio/afe/temperature-sense-amplifier.yaml  | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> new file mode 100644
> index 000000000000..08f97f052a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
> @@ -0,0 +1,57 @@
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
> +  When an io-channel measures the output voltage of a temperature analog front
> +  end such as an RTD (resistance thermometer) or a temperature to current
> +  sensor, the interesting measurement is almost always the corresponding
> +  temperature, not the voltage output. This binding describes such a circuit.

Perhaps add something about this only covering the linear cases...

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
> +  sense-gain-mult:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain multiplier. The default is <1>.
> +
> +  sense-gain-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Amplifier gain divider. The default is <1>.
> +
> +  sense-offset-millicelsius:
> +    description: Amplifier offset. The default is <0>.

Whilst it may seem obvious I'd like to see a statement of
how these are used somewhere in here.

   temp_celcius = voltage * gain-mult / gain-div + offset

Mainly because those familiar with the IIO usage of offset
would expect
(voltage + offset) * gain-mult/gain-div 

which doesn't make sense for this device but might leave
people confused!

> +
> +additionalProperties: false
> +required:
> +  - compatible
> +  - io-channels
> +
> +examples:
> +  - |
> +    pt1000_1: temperature-sensor {
> +        compatible = "temperature-sense-amplifier";
> +        #io-channel-cells = <1>;
> +        io-channels = <&temp_adc 3>;
> +
> +        sense-gain-mult = <1000000>;
> +        sense-gain-div = <3908>;
> +        sense-offset-millicelsius = <(-255885)>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e679d422b472..4f7b4ee9f19b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8887,6 +8887,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-amplifier.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
>  F:	drivers/iio/afe/iio-rescale.c
>  

