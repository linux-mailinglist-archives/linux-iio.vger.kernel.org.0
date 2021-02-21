Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CD320B9B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUQAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBUQAP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:00:15 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B9764E04;
        Sun, 21 Feb 2021 15:59:33 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:59:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Message-ID: <20210221155930.31df57f1@archlinux>
In-Reply-To: <20210207154623.433442-22-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-22-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Feb 2021 15:46:20 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Binding covering the ad7150, ad7151 and ad7156 capacitance to digital
> convertors.  The only difference between these is how many channels they
> have (1 or 2)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Robh+dt@kernel.org
> Cc: devicetree@vger.kernel.org
@Rob,

Any comments on this?  Lars requested that I use symbolic values
for the irq flags which I can do whilst applying - but otherwise
I don't plan to change anything else in here.

It's the only patch that needs tweaking and I don't really
want to repost all 24 just for that.

Thanks,

Jonathan

> ---
>  .../bindings/iio/cdc/adi,ad7150.yaml          | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
> new file mode 100644
> index 000000000000..2155d3f5666c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/cdc/adi,ad7150.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog device AD7150 and similar capacitance to digital convertors.
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7150
> +      - adi,ad7151
> +      - adi,ad7156
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts: true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7150
> +              - adi,ad7156
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7151
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cdc@48 {
> +            compatible = "adi,ad7150";
> +            reg = <0x48>;
> +            interrupts = <25 2>, <26 2>;
> +            interrupt-parent = <&gpio>;
> +        };
> +    };
> +...

