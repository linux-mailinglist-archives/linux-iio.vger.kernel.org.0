Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBD399EE4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCK1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 06:27:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3137 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCK1W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jun 2021 06:27:22 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fwhd66DSHz6L6JM;
        Thu,  3 Jun 2021 18:16:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 12:25:33 +0200
Received: from localhost (10.52.126.9) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 11:25:32 +0100
Date:   Thu, 3 Jun 2021 11:25:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christoph Fritz <chf.fritz@googlemail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: add isl76683 light
 bindings
Message-ID: <20210603112531.00007622@Huawei.com>
In-Reply-To: <20210602134512.193186-3-chf.fritz@googlemail.com>
References: <20210602134512.193186-1-chf.fritz@googlemail.com>
        <20210602134512.193186-3-chf.fritz@googlemail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.9]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Jun 2021 15:45:12 +0200
Christoph Fritz <chf.fritz@googlemail.com> wrote:

> This patch adds documentation of device tree bindings for Intersil
> isl76683 light sensor.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Hi Christoph,

One trivial comment inline. As mentioned in the driver review it might
be nice to relax the requirement for the irq if we can sensibly
do so.  Far too common for people to not wire it up for simple sensors.

Jonathan

> ---
>  .../bindings/iio/light/isil,isl76683.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml b/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
> new file mode 100644
> index 000000000000..3e802a29892b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/isil,isil76683.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intersil isl76683 ambient light sensor
> +
> +maintainers:
> +  - Christoph Fritz <chf.fritz@googlemail.com>
> +
> +description: |
> +  https://www.intersil.com/content/dam/Intersil/documents/isl7/isl76683.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - isil,isl76683

Unless you are expecting to add new devices sharing this binding, perhaps
       const: isil,isl77683
is more appropriate.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        isl76683@74 {
> +            compatible = "isil,isl76683";
> +            reg = <0x74>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <20 IRQ_TYPE_FALLING>;
> +        };
> +    };
> +...

