Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7BFF439
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 18:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfKPRMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 12:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKPRMA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 12:12:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD3E21843;
        Sat, 16 Nov 2019 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573924320;
        bh=GgGQ3QgakPWrEDObNy8Vsqjjd7lFiJ/TOaydn0UUiSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2I+m6Y7PGXAKKvzPEPkXwxdpkOdOE7HKib5FaLgHN2sdHmWis84r3x/n0RMK3WxRo
         y2Ph7G38XbjeVRiTETX64S9JgjIgC0GAteZCVISIjLYCSpOz0UnC4MskeAA59JWvjE
         01rRFYkHzyGfd3nJTH40lt12udtf14x+r0bJCiBo=
Date:   Sat, 16 Nov 2019 17:10:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-binding: iio: Add documentation for AD7091R5
Message-ID: <20191116171028.1a0f8876@archlinux>
In-Reply-To: <20191115135723.12219-3-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
        <20191115135723.12219-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 15:57:22 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Documentation for AD7091R5 ADC was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,

Jonathan

> ---
> Changes in v5:
> -nothing changed
> 
>  .../bindings/iio/adc/adi,ad7091r5.yaml        | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> new file mode 100644
> index 000000000000..31ffa275f5fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +
> +maintainers:
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091r5
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Phandle to the vref power supply
> +
> +  interrupts:
> +    maxItems: 1
> +
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@2f {
> +                compatible = "adi,ad7091r5";
> +                reg = <0x2f>;
> +
> +                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +                interrupt-parent = <&gpio>;
> +        };
> +    };
> +...

