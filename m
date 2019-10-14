Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6ADD61A8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfJNLsz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 07:48:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730300AbfJNLsz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Oct 2019 07:48:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFCF8377902FCE19D856;
        Mon, 14 Oct 2019 19:48:50 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 19:48:47 +0800
Date:   Mon, 14 Oct 2019 12:48:35 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>, <stefan.popa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191014124835.00005645@huawei.com>
In-Reply-To: <20191013141345.uctcutryo7pmdkem@smtp.gmail.com>
References: <20191013141345.uctcutryo7pmdkem@smtp.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 11:13:47 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a device tree binding doc for AD7292 monitor and control system.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7292.yaml          | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> new file mode 100644
> index 000000000000..16be9ea4194d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7292 10-Bit Monitor and Control System
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> +
> +description: |
> +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> +  Temperature Sensor, and GPIOs
> +
> +  Specifications about the part can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7292
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC and DAC reference voltage.
> +    maxItems: 1
> +
> +  spi-cpha:
> +    description: |
> +      See Documentation/devicetree/bindings/spi/spi-controller.yaml
> +    maxItems: 1
> +
> +  diff-channels:
> +    description: |
> +      Empty property to tell whether VIN0 and VIN1 shall work as differential
> +      inputs.
> +    maxItems: 1

This looks like a nice general interface, but really isn't as it only applies
to the first two channels.

Can you use the standard channel defintions
Documentation/devicetree/bindings/iio/adc.txt
to specify this?

It may seem overly complex, but it has the benefit of being generic.

Would be something like:

channel@0 {
	diff-channels = < 0 1 >
};
channel@2 {
};
vs all the channels being present, none set as diff.

Thanks,

Jonathan

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad7292: ad7292@0 {
> +        compatible = "adi,ad7292";
> +        reg = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        spi-max-frequency = <25000000>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
> +        diff-channels;
> +      };
> +    }
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e78317a5f4f1..5941cfc0d6f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -819,6 +819,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7292.c
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
>  
>  ANALOG DEVICES INC AD7606 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>


