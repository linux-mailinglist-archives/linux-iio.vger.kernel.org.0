Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E512024CC
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFTPb3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 11:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgFTPb2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 11:31:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981B82251D;
        Sat, 20 Jun 2020 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592667088;
        bh=ENCFOs4/J5WDi/FGJjBnSwANquqM3TjFEwmmsKt8OCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oWDS72rXYMByjiV65inDSRf5cIWk/ii4BJewKNx8nj6LCseRogBhiWf99mxpy9NL1
         EMLal0pDQv2G0RkqVGly1g8B5lafAmWE+Rs6YXdD1Bi5XCjHX6PDMD87E23FD+C3jR
         Y6TsCVdDGDYcMtKkSuQ8L3YqCEpzaUPd2qH9Ytt4=
Date:   Sat, 20 Jun 2020 16:31:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darius Berghe <darius.berghe@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] iio:adc:ltc2471: add dt binding yaml
Message-ID: <20200620163124.29d9cd38@archlinux>
In-Reply-To: <20200617133523.58158-3-darius.berghe@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
        <20200617133523.58158-3-darius.berghe@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Jun 2020 16:35:23 +0300
Darius Berghe <darius.berghe@analog.com> wrote:

> Add dt binding documentation for ltc2471 driver. This covers all supported
> devices.
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>
A few things inline but basically fine.

We should however also think about documenting power supplies.
Even though the driver doesn't currently control the binding should
be as complete as possible.

Jonathan

> ---
>  .../bindings/iio/adc/adi,ltc2471.yaml         | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> new file mode 100644
> index 000000000000..0b84e14ec984
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ltc2471.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2471 16-bit I2C Sigma-Delta ADC
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Analog Devices LTC2471 (single-ended) and LTC2473 (differential) 16-bit
> +  I2C Sigma-Delta ADC with selectable 208/833sps output rate.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/24713fb.pdf
> +
> +  Analog Devices LTC2461 (single-ended) and LTC2463 (differential) 16-bit
> +  I2C Sigma-Delta ADC with 60sps output rate.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/24613fa.pdf

Put these two blocks in numeric order.  If we end up adding a bunch more
devices it will be much more consistent if they are order.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2471
> +      - adi,ltc2473
> +      - adi,ltc2461
> +      - adi,ltc2463

Put them in numeric order.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      ltc2461@14 {

Should use a generic name
adc@14

> +        compatible = "ltc2461";
> +        reg = <0x14>;
> +      };
> +    };
> +  - |
> +    i2c0 {

Not a lot of point in two examples given how similar they are.
I'd just keep the one. 

> +      ltc2473@54 {
> +        compatible = "ltc2473";
> +        reg = <0x54>;
> +      };
> +    };
> +

