Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B435C401
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhDLKbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 06:31:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2835 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbhDLKbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 06:31:06 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJlBJ3Bj6z688s4;
        Mon, 12 Apr 2021 18:20:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 12:30:41 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 11:30:41 +0100
Date:   Mon, 12 Apr 2021 11:29:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tomas Melin <tomas.melin@vaisala.com>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Message-ID: <20210412112915.00006130@Huawei.com>
In-Reply-To: <20210412075056.56301-2-tomas.melin@vaisala.com>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
        <20210412075056.56301-2-tomas.melin@vaisala.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 10:50:55 +0300
Tomas Melin <tomas.melin@vaisala.com> wrote:

> initial DT bindings for Murata SCA3300 Accelerometer.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Hi Tomas.
> ---
>  .../bindings/iio/accel/sca3300.yaml           | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/sca3300.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml
> new file mode 100644
> index 000000000000..32fe4b647cd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/sca3300.yaml

Vendor prefix on the filename please.

> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/sca3300.yaml#

Vendor prefix will end up here as well.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Murata SCA3300 Accelerometer
> +
> +description: |
> +  3-axis industrial accelerometer with digital SPI interface
> +  https://www.murata.com/en-global/products/sensor/accel/sca3300
> +
> +maintainers:
> +  - Tomas Melin <tomas.melin@vaisala.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - murata,sca3300
> +
> +  reg:
> +    maxItems: 1
> +    description: SPI chip select number according to the general SPI bindings

No need to give a description as this is the same for all SPI devices.

> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +  murata,opmode:
> +    description: Accelerometer operation mode as described in datasheet (MODE)
> +    $ref: /schemas/types.yaml#/definitions/uint32

This needs a proper description here.  Also perhaps worth noting that we
very rarely let mode related things like this into DT. They are always almost
something that is policy rather than hardware description and so belong somewhere
userspace can control them.

In this particular case, looks like a simple range control.   That belongs in 
userspace via _scale attributes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - murata,opmode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        sca3300@0 {
> +            compatible = "murata,sca3300";
> +            reg = <0x0>;
> +            spi-max-frequency = <4000000>;
> +            murata,opmode = <4>;
> +        };
> +    };
> +...

