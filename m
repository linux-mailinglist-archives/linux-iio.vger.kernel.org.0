Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE5225D38
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGTLQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgGTLQi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:16:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2062073A;
        Mon, 20 Jul 2020 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595243798;
        bh=h/+3Px8t9dUzIXFkpxr1WT1l9Hilocmlm4Pl2hk5x+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EK1m5F1T8VF8+PkE6ofWtSbn78yiYNdbyDFUcbIAhi0Jfnau4AwihFw2U0V3XF6Sm
         SJqircjgWTVfWQheYVkgI1NEtiM5ONi1ZZTLZBfEUOEu9d41VeYuADN39yBvTL0JRu
         /mj134CnFPs4ySguORQKiVs96Ha+pvk98qdbqC1A=
Date:   Mon, 20 Jul 2020 12:16:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        darius.berghe@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: gyro: Add DT binding doc for
 ADXRS290
Message-ID: <20200720121633.7a9e5cd7@archlinux>
In-Reply-To: <20200715092821.14625-1-nish.malpani25@gmail.com>
References: <20200715092821.14625-1-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 14:58:21 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> new file mode 100644
> index 000000000000..a997d945fdb0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/gyroscope/adi,adxrs290.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope
> +
> +maintainers:
> +  - Nishant Malpani <nish.malpani25@gmail.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADXRS290 dual-axis MEMS gyroscope device.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxrs290

I think we can use const here as only one item currently.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +  - spi-cpha
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gyro@0 {
> +                   compatible = "adi,adxrs290";
> +                   reg = <0>;
> +                   spi-max-frequency = <5000000>;
> +                   spi-cpol;
> +                   spi-cpha;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd02cfc410e8..0bb8ac90fba1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1103,6 +1103,7 @@ M:	Nishant Malpani <nish.malpani25@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/gyro/adxrs290.c
> +F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
>  
>  ANALOG DEVICES INC ASOC CODEC DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>

