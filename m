Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C971E14FDA4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 15:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBOr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 09:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgBBOr5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 09:47:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B72C20658;
        Sun,  2 Feb 2020 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580654876;
        bh=vOal+xwqdFl3PSiT6YduVztrZILw3cPLzRMWcvax7rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AuElYCvWXxX55Kg5+8dt6g12nYpGG6BWq0Q40srxfsqKBp2iu/pak1HxpaQBwt5s7
         RxFRuOgJP+5OHTpuLNiOu/6b3vq6RqlXqN9W0JZFHmTN+0CNsAZ/0kgPAhNa/3reaX
         KFCIdL3yC9WbtVA+YmFFxxBTdMgmHETqhbvCSBTw=
Date:   Sun, 2 Feb 2020 14:47:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ekigwana@gmail.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: frequency: Add docs for
 ADF4360 PLL
Message-ID: <20200202144752.1fb925e4@archlinux>
In-Reply-To: <20200128111302.24359-2-alexandru.ardelean@analog.com>
References: <20200128111302.24359-1-alexandru.ardelean@analog.com>
        <20200128111302.24359-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jan 2020 13:13:01 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Edward Kigwana <ekigwana@gmail.com>
> 
> This change adds the device-tree bindings documentation for the ADF4360
> family of PLLs.
> 
> Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4360.yaml   | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> new file mode 100644
> index 000000000000..895e2cb2b300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019-2020 Edward Kigwana
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF4360 PLL device driver

This isn't a driver, so don't mention "device driver" It's a binding
for the hardware.

> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Edward Kigwana <ekigwana@gmail.com>
> +
> +description: |
> +  Bindings for the Analog Devices ADF4360 family of clock generator phase-locked
> +  loop (PLL) devices with an integrated voltage-controlled oscillator (VCO).
> +  Each of the parts in the family supports a specific frequency range.
> +  Datasheets can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-0.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-2.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-3.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-4.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-5.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-6.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-7.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-8.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-9.pdf
> +
> +properties:
> +  compatible:
> +    pattern: '^adi,adf4360-[0-9]$'
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  adi,loop-filter-pfd-frequency-hz:
> +    description: |
> +      The phase-frequency-detector frequency that the external loop filter was
> +      designed for.
> +    allOf:
> +      - minimum: 25000
> +      - maximum: 8000000
> +    maxItems: 1
> +
> +  adi,loop-filter-charger-pump-current-microamp:
> +    description: |
> +      The charge pump current that the external loop filter was designed for.
> +      The provided value is clamped to the closest enumerated value.
> +    enum: [ 310, 620, 930, 1250, 1560, 1870, 2180, 2500 ]
> +
> +  adi,vco-minimum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Minimum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    maxItems: 1
> +
> +  adi,vco-maximum-frequency-hz:
> +    description: |
> +      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Maximum VCO frequency
> +      that can be supported by the tuning range set by the external inductor.
> +    maxItems: 1
> +
> +  adi,loop-filter-inverting:
> +    description: Indicates that the external loop filter is an inverting filter.
> +    type: boolean
> +
> +  adi,power-up-frequency-hz:
> +    description: |
> +      PLL tunes to the set frequency on probe or defaults to either the minimum
> +      for the part or value set using adi,vco-minimum-frequency-hz.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: |
> +      vdd supply is used to enable or disable chip when regulator power down
> +      mode is set. Other power down modes are used to mitigate the case of a
> +      shared regulator.
> +
> +  enable-gpios:
> +    description: |
> +      Chip enable gpio is used to enable or disable chip when chip enable power
> +      down mode is set.
> +    maxItems: 1
> +
> +  adi,muxout-gpios:
> +    description: |
> +      MUX out gpio is used to detect chip and test pll lock state on read when
> +      muxout control is set to lock detect.
> +    maxItems: 1

This is a debug feature I think? If so probably shouldn't be in dt, but
perhaps I am missing something?

> +
> +  adi,power-out-level-microamp:
> +    description: |
> +      Chip support setting of output power level. This property is optional.
> +      If it is not provided by default 11000 uA will be set.
> +    enum: [ 3500, 5000, 7500, 11000 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - adi,loop-filter-charge-pump-current
> +  - adi,loop-filter-pfd-frequency-hz
> +
> +examples:
> +  - |
> +      spi0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pll@0 {
> +                  compatible = "adi,adf4360-7";
> +                  reg = <0>;
> +                  spi-max-frequency = <2000000>;
> +                  clocks = <&ref_clock>;
> +                  #clock-cells = <0>;
> +                  clock-names = "clkin";
> +                  clock-output-names = "adf4360-7";
> +
> +                  adi,loop-filter-charge-pump-current = <5>;
> +                  adi,loop-filter-pfd-frequency-hz = <2500000>;
> +                  adi,vco-minimum-frequency-hz = <700000000>;
> +                  adi,vco-maximum-frequency-hz = <840000000>;
> +          };
> +      };
> +...

