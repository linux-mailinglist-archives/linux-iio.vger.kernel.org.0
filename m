Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57853351D45
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhDAS1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237026AbhDASSq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE366136A;
        Thu,  1 Apr 2021 15:12:55 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:13:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, devicetree@vger.kernel.org,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add DT bindings
 for TMP117
Message-ID: <20210401161304.70c61fe6@jic23-huawei>
In-Reply-To: <20210401091648.87421-2-puranjay12@gmail.com>
References: <20210401091648.87421-1-puranjay12@gmail.com>
        <20210401091648.87421-2-puranjay12@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Apr 2021 14:46:47 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Add devicetree binding document for TMP117, a digital temperature sensor.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> new file mode 100644
> index 000000000..1ead22317
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> +
> +description: |
> +    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> +    I2C interface.
> +      https://www.ti.com/lit/gpn/tmp1
> +
> +maintainers: 
> +  - "Puranjay Mohan <puranjay12@gmail.com>"
> +
> +properties: 
> +  compatible: 
> +    enum: 
> +      - "ti,tmp117"
> +  reg: 
> +    maxItems: 1
> +required: 
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - | 
> +    tmp117@48 {
> +        compatible = "ti,tmp117";
> +        reg = <0x48>;
> +      };  

For the example embed it in an appropriate i2c description e.g.

    i2c {
        #address-cells = <1>;
        #size-cells = <0>;

        tmp117@48 {
             compatible = "ti,tmp117";
             reg = <0x48>;
        };
    };
