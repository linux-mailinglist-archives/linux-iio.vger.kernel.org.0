Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E760460040
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhK0Qm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:42:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40288 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhK0Qk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:40:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B05ACB82169;
        Sat, 27 Nov 2021 16:37:12 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 88A9FC53FBF;
        Sat, 27 Nov 2021 16:37:09 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:42:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings:iio:filter: add admv8818 doc
Message-ID: <20211127164210.1e8679e5@jic23-huawei>
In-Reply-To: <20211123133900.133027-3-antoniu.miclaus@analog.com>
References: <20211123133900.133027-1-antoniu.miclaus@analog.com>
        <20211123133900.133027-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 15:38:59 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV8818 Filter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

This looks good to me.  The clocks things does leave me a little
nervous though, so let's see what Rob thinks.

Key thing here is that these aren't typically clocks being used or
generated in an SoC, but rather high microwave signals that
we are filtering...  It's useful to treat them as clocks to get
the filters to automatically adjust if the input frequency changes.

Jonathan

> ---
> changes in v2:
>  - remove `bw-hz` dt property
>  .../bindings/iio/filter/adi,admv8818.yaml     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> new file mode 100644
> index 000000000000..93e08bcd8cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> @@ -0,0 +1,69 @@
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
> +      - const: rf_in
> +
> +  clock-output-names:
> +    maxItems: 1
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
> +      };
> +    };
> +...
> +

