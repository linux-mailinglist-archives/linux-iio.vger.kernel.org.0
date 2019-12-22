Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA0128F39
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2019 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLVSH4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Dec 2019 13:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfLVSH4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Dec 2019 13:07:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE0F206D3;
        Sun, 22 Dec 2019 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577038074;
        bh=AXO3IG0scX/owDhFJ2EPWEb/thMP3sqao2HJei/CAzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8qsTO6uyPeA0tG362Hu/HzXq37yTAu6ytXeCbFzGZt6Zgs6CScuaOoqydSfTJt25
         KCyhR3cgoe9WOiahsqK16E2Iu8SqTgmI382nqu7/8u7RivHx/xisjRY3W3lcG5ELq9
         WGnYvm84bN5VEtuIs1fMaDpohhGZOWM7dR3bpFJM=
Date:   Sun, 22 Dec 2019 18:07:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: frequency: Add docs for LTC6952
Message-ID: <20191222180749.4ad0a939@archlinux>
In-Reply-To: <20191219134810.6677-1-mircea.caprioru@analog.com>
References: <20191219134810.6677-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Dec 2019 15:48:08 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> Document support for Analog Devices LTC6952 ultralow jitter, 4.5GHz PLL
> with 11 outputs and JESD204B/C support.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
I''m far from sure if we have the right balance of clock and IIO specific
+ device specific bindings in here.

For example should the divider only be controlled by whatever the clock
consumer requests?

Definitely want some review of this from the clock side of things.

Thanks,

Jonathan


> ---
>  .../bindings/iio/frequency/adi,ltc6952.yaml   | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
> new file mode 100644
> index 000000000000..a28c773c3948
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/frequency/adi,ltc6952.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC6952 ultralow jitter, JESD204B/C clock generation IC.
> +
> +maintainers:
> +  - Mircea Caprioru <mircea.caprioru@analog.com>
> +
> +description: |
> +  Analog Devices LTC6952 ultralow jitter, JESD204B/C clock generation IC.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6952.pdf 
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc6952
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    description: |
> +      Clock output signal names indexed by the first cell in the clock
> +      specifier (see clock/clock-bindings.txt)
> +    maxItems: 1
> +
> +  adi,vco-frequency-hz:
> +    description: |
> +      VCO input frequency. This is fed to the internal distribution path and
> +      feedback dividers.

Superficially this feels like it should be a established via the requested
output frequencies and some idea of a 'best' value to satisfy them?

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  adi,ref-frequency-hz:
> +    description: |
> +      Reference input frequency. This is fed in the reference divider.

Is this not just an upstream clock? 

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-output-names
> +
> +patternProperties:
> +  "^channel@[0-9]$":
> +    type: object
> +    description: Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 11 channels numbered from 0 to 10.
> +        maxItems: 1
> +
> +      adi,extended-name:
> +        description: Descriptive channel name.
I mention in review of patch 2 this is a definite no.   A separate
out_chanX_label type attribute could provide this an use standard "label" dt
binding.  I think we currently have that for the IIO device but not yet its channels.

> +        maxItems: 1
> +
> +      adi,divider:
> +        description: |
> +          Channel divider. This divides the incoming VCO frequency.
Fundamental thing here is the output frequency required by any consumer.
Feels like this should be done through the clock framework bindings rather than
explicit controls here..


> +        maxItems: 1
> +
> +      adi,digital-delay:

So I'm assuming there is no binding for this level of fine control in normal
clock bindings?  I would like some input from people more knowledgeable on
that framework though.

> +        description: |
> +          Each output divider can have the start time of the output delayed by
> +          integer multiples of half of the VCO period after a synchronization
> +          event.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +          - maximum: 4095
> +        maxItems: 1
> +
> +      adi,analog-delay:
> +        description: |
> +          Each output has a fine analog delay feature to further adjust its
> +          output delay time (tADELx) in small steps.

Umm. Can we do better than 'small steps' for the units of this?

> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - minimum: 0
> +          - maximum: 63
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +examples:
> +   - |
> +     ltc6952@0 {
> +       compatible = "adi,ltc6952";
> +       reg = <0>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       spi-max-frequency = <10000000>;
> +
> +       clock-output-names = "ltc6952_out0", "ltc6952_out1", "ltc6952_out2",
> +         "ltc6952_out3", "ltc6952_out4", "ltc6952_out5", "ltc6952_out6",
> +         "ltc6952_out7", "ltc6952_out8", "ltc6952_out9", "ltc6952_out10";
> +       #clock-cells = <1>;
> +
> +       adi,vco-frequency-hz = <4000000000>;
> +       adi,ref-frequency-hz = <100000000>;
> +
> +       ltc6952_c0: channel@0 {
> +         reg = <0>;
> +         adi,extended-name = "REF_CLK";
> +         adi,divider = <10>;
> +         adi,digital-delay = <100>;
> +         adi,analog-delay = <0>;
> +       };
> +
> +       ltc6952_c1: channel@1 {
> +         reg = <1>;
> +         adi,extended-name = "TEST_CLK";
> +         adi,divider = <10>;
> +       };
> +     };

