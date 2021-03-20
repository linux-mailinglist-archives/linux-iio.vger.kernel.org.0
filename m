Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8CB342EAB
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTRv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 13:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTRva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 13:51:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4F96192D;
        Sat, 20 Mar 2021 17:51:28 +0000 (UTC)
Date:   Sat, 20 Mar 2021 17:51:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, devicetree@vger.kernel.org,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: Add DT bindings
 for TMP117
Message-ID: <20210320175125.3d6e5b01@jic23-huawei>
In-Reply-To: <20210320064509.119878-2-puranjay12@gmail.com>
References: <20210320064509.119878-1-puranjay12@gmail.com>
        <20210320064509.119878-2-puranjay12@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 12:15:08 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Add devicetree binding document for TMP117, a digital temperature sensor.

Contents looks fine, but the ordering is unusual.

Vast majority of bindings I've seen have document in an order that makes
sense for human readers (not alphabetical!)  Use whitespace
to help readability as well.

Something like:


> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

> +title: "TI TMP117 - Digital temperature sensor with integrated NV memory"

> +description: |
> +    TI TMP117 - Digital temperature sensor with integrated NV memory that supports

Avoid repeating info in the title.

> +    I2C interface.
> +      https://www.ti.com/lit/gpn/tmp1

> +maintainers: 
> +  - "Puranjay Mohan <puranjay12@gmail.com>"

> +properties: 
> +  compatible: 
> +    enum: 
> +      - "ti,tmp117"
> +  reg: 
> +    maxItems: 1

> +required: 
> +  - compatible
> +  - reg

> +examples: |
> +    tmp117@48 {
> +        compatible = "ti,tmp117";
> +        reg = <0x48>;
> +    };

> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> new file mode 100644
> index 000000000..927660461
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +description: |
> +    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> +    I2C interface.
> +      https://www.ti.com/lit/gpn/tmp1
> +examples: |
> +    tmp117@48 {
> +        compatible = "ti,tmp117";
> +        reg = <0x48>;
> +    };
> +maintainers: 
> +  - "Puranjay Mohan <puranjay12@gmail.com>"
> +properties: 
> +  compatible: 
> +    enum: 
> +      - "ti,tmp117"
> +  reg: 
> +    maxItems: 1
> +required: 
> +  - compatible
> +  - reg
> +title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> +

