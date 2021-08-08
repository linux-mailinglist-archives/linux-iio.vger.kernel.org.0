Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4323E3B43
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhHHQF6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 12:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQF6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 12:05:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D085D60EE9;
        Sun,  8 Aug 2021 16:05:37 +0000 (UTC)
Date:   Sun, 8 Aug 2021 17:08:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        ardeleanalex@gmail.com
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: temperature: add MAXIM
 max31865 support
Message-ID: <20210808170827.54b4d3b1@jic23-huawei>
In-Reply-To: <20210804154254.241118-2-navin@linumiz.com>
References: <20210804154254.241118-1-navin@linumiz.com>
        <20210804154254.241118-2-navin@linumiz.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  4 Aug 2021 21:12:54 +0530
Navin Sankar Velliangiri <navin@linumiz.com> wrote:

> Add DT bindings for MAXIM max31865 RTD sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>

dt-bindings need to be cc'd to the devicetree list and maintainers 
so they can review them.

There has also been some recent discussion on having spi modes in
bindings when the device only supports one option.  The preference
is to instead have the driver enforce those by an spi_mode()
call. (e.g. spi-cpha)

There are corner cases (usually involving some cheap level conversion)
where this doesn't work, but in those cases the 'required' below wouldn't
work either, so we leave them to be dealt with if they ever happen for
a particular piece of hardware.

Jonathan

> 
> ---
> 
> Note:
> Changes in v2:
> 	-> Changed the name RTD to Resistance Temperature Detector
> 	-> renamed maxim,no-of-wires to 3-wire
> 	-> fixed code alignment for the example  
> 
> Changes in v3:
> 	-> Added more information about 3 wire RTD connection  
> ---
>  .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> new file mode 100644
> index 000000000000..aafb33b16549
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/maxim,max31865.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX31865 Resistance Temperature Detector.
> +
> +maintainers:
> +  - Navin Sankar Velliangiri <navin@linumiz.com>
> +
> +description: |
> +  https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max31865
> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,3-wire:
> +    description:
> +      Identifies the number of wires used by the RTD. Setting this property
> +      enables 3-wire RTD connection. Else 2-wire or 4-wire RTD connection.
> +    type: boolean
> +
> +  spi-max-frequency: true
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       temp_sensor@0 {
> +         compatible = "maxim,max31865";
> +         reg = <0>;
> +         spi-max-frequency = <400000>;
> +         spi-cpha;
> +         maxim,3-wire;
> +       };
> +    };
> +...

