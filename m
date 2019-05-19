Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E022758
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfESQ5W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 12:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfESQ5W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 12:57:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90A22184C;
        Sun, 19 May 2019 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558265534;
        bh=xIfjBwAnlTWBS0xxGQD5dBqlbiDtOuwak7rtI6d9ews=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GPMTJt0OBU4YMg/nWSbx2+7UgvG3DnR4qCJII+CBIyI66geFnRx9GAkLjEYWAJ98v
         dtRFiITp+iIsLVEhnO+T9MfoSz9mipx67cuXIQHAeV05mlu0Ky+HyNwFaYnCl/3xEA
         kl6f+j19GOty2U876rxE1FXCZwbtDAwUSBDbOZCc=
Date:   Sun, 19 May 2019 12:32:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <20190519123208.26c864ce@archlinux>
In-Reply-To: <9992a318aec777b9b7788bb40d976aa89e5963fe.1558219042.git.renatogeh@gmail.com>
References: <9992a318aec777b9b7788bb40d976aa89e5963fe.1558219042.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:41:12 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds a YAML binding for the Analog Devices AD7780/1 and
> AD7170/1 analog-to-digital converters.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
One comment inline.  I'll also be needing an ack from Analog on this,
preferably Michael's.

Thanks,

Jonathan
> ---
>  .../bindings/iio/adc/adi,ad7780.txt           | 48 -----------
>  .../bindings/iio/adc/adi,ad7780.yaml          | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> deleted file mode 100644
> index 440e52555349..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -* Analog Devices AD7170/AD7171/AD7780/AD7781
> -
> -Data sheets:
> -
> -- AD7170:
> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> -- AD7171:
> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> -- AD7780:
> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> -- AD7781:
> -	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> -
> -Required properties:
> -
> -- compatible: should be one of
> -	* "adi,ad7170"
> -	* "adi,ad7171"
> -	* "adi,ad7780"
> -	* "adi,ad7781"
> -- reg: spi chip select number for the device
> -- vref-supply: the regulator supply for the ADC reference voltage
> -
> -Optional properties:
> -
> -- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
> -		    specified, it will be asserted during driver probe. As the
> -		    line is active high, it should be marked GPIO_ACTIVE_HIGH.
> -- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
> -		    the ad778x chips. If specified, it will be asserted during
> -		    driver probe. As the line is active low, it should be marked
> -		    GPIO_ACTIVE_LOW.
> -- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
> -		    for the ad778x chips. If specified, it will be asserted
> -		    during driver probe. As the line is active low, it should be
> -		    marked GPIO_ACTIVE_LOW.
> -
> -Example:
> -
> -adc@0 {
> -	compatible =  "adi,ad7780";
> -	reg =	      <0>;
> -	vref-supply = <&vdd_supply>
> -
> -	powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
> -	adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
> -	adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> new file mode 100644
> index 000000000000..931bc4f8ec04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital converters
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  The ad7780 is a sigma-delta analog to digital converter. This driver provides
> +  reading voltage values and status bits from both the ad778x and ad717x series.
> +  Its interface also allows writing on the FILTER and GAIN GPIO pins on the
> +  ad778x.
> +
> +  Specifications on the converters can be found at:
> +    AD7170:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> +    AD7171:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> +    AD7780:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> +    AD7781:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7170
> +      - adi,ad7171
> +      - adi,ad7780
> +      - adi,ad7781
> +
> +  reg:
> +    description:
> +      Chip select number for the device
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description:
> +      Must be the device tree identifier of the PDRST pin. If
> +      specified, it will be asserted during driver probe. As the
> +      line is active high, it should be marked GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  adi,gain-gpios:
> +    description:
> +      Must be the device tree identifier of the GAIN pin. Only for
> +      the ad778x chips. If specified, it will be asserted during
> +      driver probe. As the line is active low, it should be marked
> +      GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,filter-gpios:
> +    description:
> +      Must be the device tree identifier of the FILTER pin. Only
> +      for the ad778x chips. If specified, it will be asserted
> +      during driver probe. As the line is active low, it should be
> +      marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
Is that actually true?  I'd imagine it'll use a stub regulator if
it isn't supplied.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    adc@0 {
> +      compatible =  "adi,ad7780";
> +      reg = <0>;
> +      vref-supply = <&vdd_supply>;
> +
> +      powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +      adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
> +      adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> +    };

