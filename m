Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD71CB24C
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEHOva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 10:51:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbgEHOva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 10:51:30 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id ED18474328E5A4274316;
        Fri,  8 May 2020 15:51:28 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 15:51:28 +0100
Date:   Fri, 8 May 2020 15:51:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: proximity: provide vcnl3020 device
 tree binding document
Message-ID: <20200508155050.0000008e@Huawei.com>
In-Reply-To: <20200507132600.8801-2-i.mikhaylov@yadro.com>
References: <20200507132600.8801-1-i.mikhaylov@yadro.com>
        <20200507132600.8801-2-i.mikhaylov@yadro.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 May 2020 16:25:59 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../iio/proximity/vishay,vcnl3020.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> new file mode 100644
> index 000000000000..408dee17cdf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl3020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Integrated Proximity Sensor With Infrared Emitter
> +
> +maintainers:
> +  - Ivan Mikhaylov <i.mikhaylov@yadro.com>
> +
> +description: |
> +  The VCNL3020 is a fully integrated proximity sensor. Fully integrated means
> +  that the infrared emitter is included in the package. It has 16-bit
> +  resolution. It includes a signal processing IC and features standard I2C
> +  communication interface. It features an interrupt function.
> +
> +  Specifications about the devices can be found at:
> +  https://www.vishay.com/docs/84150/vcnl3020.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,vcnl3020
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  vishay,led-current-microamp:
> +    description:
> +      IR LED current value with valid Range = 0 to 20d. e.g. 0 = 0 mA,
> +      1 = 10 mA, 20 = 200 mA. LED Current is limited to 200 mA for values
> +      higher than decimal 20. The drive current for the LED used in proximity
> +      sensing.

This text is really confusing. Just let the enum speak for itself and leave text as
something short like

"The driver current for the LED used in proximity sensing. "

Units and values are clear already.

> +    enum: [0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000,
> +          100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000,
> +          180000, 190000, 200000]
> +    default: 20000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        proximity@13 {
> +              compatible = "vishay,vcnl3020";
> +              reg = <0x13>;
> +              vishay,led-current-microamp = <200000>;
> +        };
> +    };


