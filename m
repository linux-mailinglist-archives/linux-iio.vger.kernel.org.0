Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652A63A025
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfFHN6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfFHN6P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:58:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B1921530;
        Sat,  8 Jun 2019 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560002295;
        bh=jorZ+LEe0qVqkWc1q8FjW59bXFnWIkPygngkNYmxICY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ldsVLNZK7Mi2rupoxhQ729yfTzC/sgxlfAWNJXnKB23d7Fy+YCEoRcRdQMKlkuton
         /Am8SLbFPEQj8y41PuXge3jBskY2LwqnzWg618vmgNKn2C9JJ7hdNsRkmdeq3/HDcu
         vZmF6yhgQ+GVoeLk9KZrG1U3HvJf3JruSS4IG6FA=
Date:   Sat, 8 Jun 2019 14:58:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: frequency: Add docs for
 ADF4371 PLL
Message-ID: <20190608145809.4350ea02@archlinux>
In-Reply-To: <1559660301-12298-1-git-send-email-stefan.popa@analog.com>
References: <1559660301-12298-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Jun 2019 17:58:21 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied,

Thanks

Jonathan

> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Nothing changed.
> Changes in v4:
> 	- Nothing changed.
> Changes in v5:
> 	- Nothing changed.
> Changes in v6:
> 	- Nothing changed.
> 
>  .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> new file mode 100644
> index 0000000..d7adf074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF4371 Wideband Synthesizer
> +
> +maintainers:
> +  - Popa Stefan <stefan.popa@analog.com>
> +
> +description: |
> +  Analog Devices ADF4371 SPI Wideband Synthesizer
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4371
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Definition of the external clock (see clock/clock-bindings.txt)
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      Must be "clkin"
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        frequency@0 {
> +                compatible = "adi,adf4371";
> +                reg = <0>;
> +                spi-max-frequency = <1000000>;
> +                clocks = <&adf4371_clkin>;
> +                clock-names = "clkin";
> +        };
> +    };
> +...

