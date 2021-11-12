Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799BA44EC17
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhKLRoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 12:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhKLRoJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 12:44:09 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA8361054;
        Fri, 12 Nov 2021 17:41:16 +0000 (UTC)
Date:   Fri, 12 Nov 2021 17:46:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <20211112174601.3c1f6b4b@jic23-huawei>
In-Reply-To: <20211109123127.96399-4-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 14:31:26 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV8818 Filter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> new file mode 100644
> index 000000000000..d581e236dbdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/filter/adi,admv8818.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV8818 Digitally Tunable, High-Pass and Low-Pass Filter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +    Fully monolithic microwave integrated circuit (MMIC) that
> +    features a digitally selectable frequency of operation.
> +    The device features four independently controlled high-pass
> +    filters (HPFs) and four independently controlled low-pass filters
> +    (LPFs) that span the 2 GHz to 18 GHz frequency range.
> +
> +    https://www.analog.com/en/products/admv8818.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv8818
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock.
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: "rf_in"

Is this what we'd normally think of as a clock signal?  I'd not expect
a nice squarewave on that pin for example so this seems an odd way to
define it.

> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  adi,bw-hz:
> +    description:
> +      Allows the user to increase the Bandpass Filter (BPF) bandwidth
> +      in Hz. Normally when invoked by the clk notifier, the driver
> +      sets the HPF cutoff close below the frequency and the LPF cutoff
> +      close above the frequency, and thus creating a BPF.

I don't understand this item at all.  Why do we need a control to
basically change how the other filter parameters are expressed?

> +    $ref: /schemas/types.yaml#/definitions/uint64
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv8818@0 {
> +        compatible = "adi,admv8818";
> +        reg = <0>;
> +        spi-max-frequency = <10000000>;
> +        clocks = <&admv8818_rfin>;
> +        clock-names = "rf_in";
> +        adi,bw-hz = /bits/ 64 <600000000>;
> +      };
> +    };
> +...
> +

