Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64EE460070
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhK0RS7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:18:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58476 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbhK0RQ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:16:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C88AD60EC3;
        Sat, 27 Nov 2021 17:13:43 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D0C33C53FAD;
        Sat, 27 Nov 2021 17:13:40 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:18:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: frequency: add admv1013 doc
Message-ID: <20211127171840.347010c9@jic23-huawei>
In-Reply-To: <20211123115336.65827-2-antoniu.miclaus@analog.com>
References: <20211123115336.65827-1-antoniu.miclaus@analog.com>
        <20211123115336.65827-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 13:53:35 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADMV1013 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

One comment inline + as noted in the ABI, I think the freq_mode
belongs in here as something like adi,input-mode or something like that.

Thanks,

Jonathan

> ---
>  - remove powerdown properties from the dt bindings
>  - update quad-se-mode property using strings enum
>  .../bindings/iio/frequency/adi,admv1013.yaml  | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> new file mode 100644
> index 000000000000..adbff58cbbf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv1013.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV1013 Microwave Upconverter
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +   Wideband, microwave upconverter optimized for point to point microwave
> +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> +
> +   https://www.analog.com/en/products/admv1013.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv1013
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  clocks:
> +    description:
> +      Definition of the external clock.
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lo_in
> +
> +  clock-output-names:
> +    maxItems: 1

Does it provide a clock?  Whilst there is a high frequency output I'm not
sure anyone would term it a clock or that it would be helfpul to manage
it like that... 

> +
> +  vcm-supply:
> +    description:
> +      Analog voltage regulator.
> +
> +  adi,detector-enable:
> +    description:
> +      Enable the Envelope Detector available at output pins VENV_P and
> +      VENV_N. Disable to reduce power consumption.
> +    type: boolean
> +
> +  adi,quad-se-mode:
> +    description:
> +      Switch the LO path from differential to single-ended operation.
> +      se-neg - Single-Ended Mode, Negative Side Disabled.
> +      se-pos - Single-Ended Mode, Positive Side Disabled.
> +      diff - Differential Mode.
> +    enum: [se-neg, se-pos, diff]
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - vcm-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv1013@0{
> +        compatible = "adi,admv1013";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        clocks = <&admv1013_lo>;
> +        clock-names = "lo_in";
> +        vcm-supply = <&vcm>;
> +        adi,quad-se-mode = "diff";
> +        adi,detector-enable;
> +      };
> +    };
> +...

