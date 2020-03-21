Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5728418E340
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgCURXG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 13:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbgCURXG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:23:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A795E20724;
        Sat, 21 Mar 2020 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811385;
        bh=Nb/kpBInkiWsppn05a1CTpV6ZeTEE2HI+Zx4P9ME4Zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y4EPE0VFRAijxwRfMUW2/ql3SGyzaDIPI0gBlJljKZQbXTr1j9tONL0g9NFSSUP0M
         913PJmyRcAPYEYFfA1zZCeb/XflIN1PnehcPeoq8IVIt2THeTzlCQ1khyBh64GvE6d
         zs3J8LJnV+oLeJKtDarJ+qSwIKjPVMSM7ETPk1BI=
Date:   Sat, 21 Mar 2020 17:23:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v11 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Message-ID: <20200321172300.7bb44fb9@archlinux>
In-Reply-To: <20200321085315.11030-7-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:53:13 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds the bindings documentation for the AXI ADC driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied.

Thanks,

> ---
>  .../bindings/iio/adc/adi,axi-adc.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> new file mode 100644
> index 000000000000..0924b2b4972b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,axi-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI ADC IP core
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  Analog Devices Generic AXI ADC IP core for interfacing an ADC device
> +  with a high speed serial (JESD204B/C) or source synchronous parallel
> +  interface (LVDS/CMOS).
> +  Usually, some other interface type (i.e SPI) is used as a control
> +  interface for the actual ADC, while this IP core will interface
> +  to the data-lines of the ADC and handle the streaming of data into
> +  memory via DMA.
> +
> +  https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-adc-10.0.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +
> +  adi,adc-dev:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A reference to a the actual ADC to which this FPGA ADC interfaces to.
> +
> +required:
> +  - compatible
> +  - dmas
> +  - reg
> +  - adi,adc-dev
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    axi-adc@44a00000 {
> +          compatible = "adi,axi-adc-10.0.a";
> +          reg = <0x44a00000 0x10000>;
> +          dmas = <&rx_dma 0>;
> +          dma-names = "rx";
> +
> +          adi,adc-dev = <&spi_adc>;
> +    };
> +...

