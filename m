Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320C62761CA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgIWUP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgIWUP5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:15:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B668C206D9;
        Wed, 23 Sep 2020 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600892157;
        bh=EyZ7FjlIHAC2uyOBzx9xK5z0GL/fC6e1KhF56KcZT1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2SvaeTSeOcNiWC7Mc+QgHTOHCkboYmeb1fcFLSnNim9IJnlj+SUko6c+OHVb/YRO
         tpF/RzHbk87okaWsXM/vtGXsSlIWrx4PXDNvax/5/rpxScdSl+Ex17JlOhE3vJSRDO
         pJAjHpSLd3qqTzYvi37XevEmkn8hAjpQiEBAhOt8=
Date:   Wed, 23 Sep 2020 21:15:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: dac: ad5686: add binding
Message-ID: <20200923211552.3532afdb@archlinux>
In-Reply-To: <20200922184012.557622-3-michael.auchter@ni.com>
References: <20200922184012.557622-1-michael.auchter@ni.com>
        <20200922184012.557622-3-michael.auchter@ni.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 13:40:12 -0500
Michael Auchter <michael.auchter@ni.com> wrote:

> Add a binding for AD5686
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
Hi Michael,

Thanks for this.
A few comments inline.

Thanks,

Jonathan

> ---
> Changes since v1:
> - Keep supported device sorted
> - fix adc -> dac type in schema path
> 
>  .../bindings/iio/dac/adi,ad5686.yaml          | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> new file mode 100644
> index 000000000000..9ce76d75f31b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5686 and similar multi-channel DACs
> +
> +maintainers:
> +  - Michael Auchter <michael.auchter@ni.com>
> +
> +description: |
> +  Binding for Analog Devices AD5686 and similar multi-channel DACs
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5311r
> +      - adi,ad5338r
> +      - adi,ad5671r
> +      - adi,ad5675r
> +      - adi,ad5691r
> +      - adi,ad5692r
> +      - adi,ad5693
> +      - adi,ad5693r
> +      - adi,ad5694
> +      - adi,ad5694r
> +      - adi,ad5695r
> +      - adi,ad5696
> +      - adi,ad5696r
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: |
> +      The regulator supply for DAC reference voltage.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

Why address-cells and size-cells?  Properties we are giving
are for the dac, not the i2c bus.

> +
> +required:
> +  - compatible
> +  - reg


additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad5686: dac@0 {
> +        compatible = "adi,ad5686";
> +        reg = <0>;
> +        vcc-supply = <&dac_vref>;
> +      };
> +    };
> +

