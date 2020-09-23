Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7727621C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 22:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIWUaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 16:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUaL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 16:30:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8BA20725;
        Wed, 23 Sep 2020 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600893010;
        bh=VFt0QGlLC4JdNe56HCe3yLNw1WFqyjSGboXsrkjTu2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2E326OL36gqvuk70ilnK5/sia8uzoNgXBR3rxA8oU2nUw9Xa3ZlBAZpc1nrxyuA0
         ciXE0dRugCVi6GTUFPuvzWrPRB7dpJZGgcn74GB2V7MI6R6L9sQe3H8lkb7OG/Bc9T
         J9nFLKpuKorqSC8SyiV05ZhSZceA8N6OMt89FgCo=
Date:   Wed, 23 Sep 2020 21:30:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     j.lamorie@rocketlab.co.nz, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: ad7291: add binding
Message-ID: <20200923213005.1e52efc9@archlinux>
In-Reply-To: <20200922144422.542669-2-michael.auchter@ni.com>
References: <20200922144422.542669-1-michael.auchter@ni.com>
        <20200922144422.542669-2-michael.auchter@ni.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 09:44:21 -0500
Michael Auchter <michael.auchter@ni.com> wrote:

> Add device-tree binding for ADI AD7291 ADC.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Michael,

I tweaked this a bit whilst applying as below.

Hope that's fine with you. Let me know if not.

Applied series to the togreg branch of iio.git and pushed out as testing.
I'm not sure if this will make 5.10 or not as we are rather tight
for a final IIO pull request.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/adi,ad7291.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
> new file mode 100644
> index 000000000000..93aa29413049
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7291.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7291.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
> +
> +maintainers:
> +  - Michael Auchter <michael.auchter@ni.com>
> +
> +description: |
> +  Analog Devices AD7291 8-Channel I2C 12-Bit SAR ADC with Temperature Sensor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7291
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC reference voltage.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

These two don't need to be here.

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
> +      ad7291: adc@0 {
> +        compatible = "adi,ad7291";
> +        reg = <0>;
> +        vref-supply = <&adc_vref>;
> +      };
> +    };
> +
... added and empty blank line removed.

