Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD779D4F04
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJLKhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 06:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLKfT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 06:35:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA45C206A1;
        Sat, 12 Oct 2019 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570876518;
        bh=wpWRu1bdjQLfcp31bGY7drOhyE2WfN3z6FU+kTIW+7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0lgw1EFnkMlG5Dmz2OYxGfjX9UZKbF3TdU//nrZrXh1qJvTml/ToDMKzk5jPzvf8
         AKQlGdDEgtZf6EFh9zRwltaxKCeykKxCx1jZ0FGFl6byXKcCqsVrqO46YPtHZ7Qerc
         CAJ9lMQFlZvG5imnQ4UqpUGtm9wZw2MywP0vXWzg=
Date:   Sat, 12 Oct 2019 11:35:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org,
        alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: Add binding for
 ADUX1020
Message-ID: <20191012113513.7ceda4e0@archlinux>
In-Reply-To: <20191011184852.12202-2-manivannan.sadhasivam@linaro.org>
References: <20191011184852.12202-1-manivannan.sadhasivam@linaro.org>
        <20191011184852.12202-2-manivannan.sadhasivam@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 00:18:51 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> Add devicetree binding for Analog Devices ADUX1020 Photometric
> sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it some more.

Thanks,

Jonathan

> ---
>  .../bindings/iio/light/adux1020.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.yaml b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
> new file mode 100644
> index 000000000000..69bd5c06319d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/adux1020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADUX1020 Photometric sensor
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description: |
> +  Photometric sensor over an i2c interface.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adux1020
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
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adux1020@64 {
> +                compatible = "adi,adux1020";
> +                reg = <0x64>;
> +                interrupt-parent = <&msmgpio>;
> +                interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +...

