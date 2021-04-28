Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6E36D8FF
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhD1N7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 09:59:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2940 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbhD1N7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 09:59:11 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVg4t2tWnz686k6;
        Wed, 28 Apr 2021 21:50:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 15:58:25 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 14:58:24 +0100
Date:   Wed, 28 Apr 2021 14:56:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add
 interrupt options
Message-ID: <20210428145650.000054cf@Huawei.com>
In-Reply-To: <20210428082203.3587022-1-sean@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 10:22:00 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This in done for supporting hw buffered sampling
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Please squash into the original binding patch.
Bindings should reflect the hardware features rather than what the driver
happens to be currently taking advantage of.

Occasionally we'll do it in multiple parts because we aren't sure what
the binding will look like, but in this case you've posted this before
the other has been applied so just merge them together.

Thanks,

Jonathan

> ---
> This series depends on "iio: accel: add support for
> FXLS8962AF/FXLS8964AF accelerometers"
> 
>  .../bindings/iio/accel/nxp,fxls8962af.yaml           | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index c7be7a1679ab..e0e5542377df 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -32,6 +32,16 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    maxItems: 1
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> @@ -51,6 +61,7 @@ examples:
>              reg = <0x62>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };
>    - |
> @@ -66,5 +77,6 @@ examples:
>              spi-max-frequency = <4000000>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };

