Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279392AB42
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfEZQjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 12:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfEZQjT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 May 2019 12:39:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A542075B;
        Sun, 26 May 2019 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558888757;
        bh=ZRGTIVYaHYRt51w0uSjhKU/386SEDJ1jWuPg7ckiXDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTydKIUT2J0nOZF9/pmjOFRvdPIeF8Zg5xRFX+NrRtEW4tVnO3Np8pk3ljl3h66AN
         U2AiOtugeZE+7vTYGJWNnVWDSOKSgdV77/VKBrYkp/H/UNPPnLuQWNAzKFs6QqcRJX
         BTb3zpSgztXgw2G1sECkK1EWvtArIhMD4zgpXdAo=
Date:   Sun, 26 May 2019 17:39:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Message-ID: <20190526173911.57ae3d11@archlinux>
In-Reply-To: <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
        <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 22:26:30 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds a YAML binding for the Analog Devices AD7780/1 and
> AD7170/1 analog-to-digital converters.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Looks good to me, but I'm still finding my feet with these so will
leave it for a few days for others to have time to comment.

Michael, looking for a quick reply from you to say if you are happy
being explicitly listed as maintainer for this one, or if you'd
rather land it on someone else.  Same applies for patch 2.

Renato, if I seem to have forgotten this in a week or so, feel
free to give me a poke. I've been known to loose patches entirely!

Thanks,

Jonathan
> ---
> Changes in v2:
>  - vref-supply to avdd-supply
>  - remove avdd-supply from required list
>  - include adc block in an spi block
> 
>  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
>  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 48 deletions(-)
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
> index 000000000000..d1109416963c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> @@ -0,0 +1,87 @@
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
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage.
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
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7780";
> +            reg = <0>;
> +
> +            avdd-supply      = <&vdd_supply>;
> +            powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +            adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
> +            adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> +        };
> +    };

