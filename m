Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D27FC887
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKNONO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 09:13:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfKNONN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Nov 2019 09:13:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3277FDC2F7B13D9705AE;
        Thu, 14 Nov 2019 22:12:35 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 22:12:29 +0800
Date:   Thu, 14 Nov 2019 14:12:25 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <tomislav.denis@avl.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] bindings: iio: pressure: Add dlh-i2c documentation
Message-ID: <20191114141225.00002f4f@huawei.com>
In-Reply-To: <20191114100908.11180-4-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191114100908.11180-4-tomislav.denis@avl.com>
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

On Thu, 14 Nov 2019 11:09:08 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> Add a device tree binding documentation for DLH series pressure
> sensors.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Hi Tomislav,

A few little comments inline

Thanks,

Jonathan


> ---
>  .../devicetree/bindings/iio/pressure/dlh-i2c.yaml  | 43 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml b/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
> new file mode 100644
> index 0000000..43539ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml

prefix the filename as per the compatible - so
asc,slh-i2c.yaml

> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0

I'm guessing you own the copyright on this binding.  Where possible
the DT maintainers are requesting that bindings are dual licensed as
(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/dlh-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: All Sensors DLH series low voltage digital pressure sensors
> +
> +maintainers:
> +  - Tomislav Denis <tomislav.denis@avl.com>
> +
> +description: |
> +  Bindings for the All Sensors DLH series pressure sensors.
> +
> +  Specifications about the sensors can be found at:
> +    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF

I took a quick look at the datasheet.  Whilst I guess you don't have
it wired up, there is an EOC line which should be here as the
doc should cover the hardware, rather than what we currently
use in the driver.  The EOC line looks like a data ready
interrupt from my quick read.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - asc,dlhl60d
> +      - asc,dlhl60g
> +
> +  reg:
> +    description: I2C device address
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pressure@29 {
> +          compatible = "asc,dlhl60d";
> +          reg = <0x29>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a08923..b45081d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -674,6 +674,7 @@ W:	http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
>  S:	Maintained
>  L:	linux-iio@vger.kernel.org
>  F:	drivers/iio/pressure/dlh-i2c.c
> +F:	Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
>  
>  ALLEGRO DVT VIDEO IP CORE DRIVER
>  M:	Michael Tretter <m.tretter@pengutronix.de>


