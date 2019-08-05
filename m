Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA2820F2
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfHEP6C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfHEP6C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:58:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145012064A;
        Mon,  5 Aug 2019 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020681;
        bh=44qgJUZzegg1qFcAcmz2R5AwMHNsv5gye238cohSRcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SYXV73IuJ/sD/y/Y5vesdDWtWtxspS6jUR9Rop7Bl6Auf0NG3gkf3XHKk2AXitxg8
         61QRWEoG15KVBZ2q/ciDygr5duQTmv1JRx0c/9OMxxSpiVf5wWd6i/PxAYN9LmncK1
         kiP9qBNNROJ6IhQesh5sHJCRkZAiHJBzdgvaRmVs=
Date:   Mon, 5 Aug 2019 16:57:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add binding document for NOA1305
Message-ID: <20190805165755.10c0bde3@archlinux>
In-Reply-To: <20190802114228.1278-1-martyn.welch@collabora.com>
References: <20190802114228.1278-1-martyn.welch@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  2 Aug 2019 12:42:27 +0100
Martyn Welch <martyn.welch@collabora.com> wrote:

> Document the ON Semiconductor NOA1305 ambient light sensor devicetree
> bindings.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> 
> Changes:
> v2: Same as v1.
> v3: Same as v2.
> v4: Same as v3.
> 
>  .../bindings/iio/light/noa1305.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/noa1305.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/noa1305.yaml b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
> new file mode 100644
> index 000000000000..17e7f140b69b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/noa1305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ON Semiconductor NOA1305 Ambient Light Sensor
> +
> +maintainers:
> +  - Martyn Welch <martyn.welch@collabora.com>
> +
> +description: |
> +  Ambient sensing with an i2c interface.
> +
> +  https://www.onsemi.com/pub/Collateral/NOA1305-D.PDF
> +
> +properties:
> +  compatible:
> +    enum:
> +      - onnn,noa1305
> +
> +  reg:
> +    maxItems: 1
> +
> +  vin-supply:
> +    description: Regulator that provides power to the sensor
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
> +        light@39 {
> +                compatible = "onnn,noa1305";
> +                reg = <0x39>;
> +        };
> +    };
> +...

