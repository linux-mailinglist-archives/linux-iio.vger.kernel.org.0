Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134182A23D7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 05:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKBEzV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 23:55:21 -0500
Received: from anchovy1.45ru.net.au ([203.30.46.145]:45270 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbgKBEzV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 23:55:21 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2020 23:55:20 EST
Received: (qmail 28875 invoked by uid 5089); 2 Nov 2020 04:48:38 -0000
Received: by simscan 1.2.0 ppid: 28818, pid: 28819, t: 0.0741s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 2 Nov 2020 04:48:38 -0000
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml
 conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-3-jic23@kernel.org>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <a10e6e98-4f20-e1eb-c3c7-b00052109ab9@electromag.com.au>
Date:   Mon, 2 Nov 2020 12:48:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201031184854.745828-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/11/2020 02:48, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple direct conversion from txt to yaml as part of a general aim of
> converting all IIO bindings to this machine readable format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>
Reviewed-by: Phil Reid <preid@electromag.com.au>

> ---
>   .../bindings/iio/potentiometer/ad5272.txt     | 27 ----------
>   .../iio/potentiometer/adi,ad5272.yaml         | 50 +++++++++++++++++++
>   2 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> deleted file mode 100644
> index f9b2eef946aa..000000000000
> --- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Analog Devices AD5272 digital potentiometer
> -
> -The node for this device must be a child node of a I2C controller, hence
> -all mandatory properties for your controller must be specified. See directory:
> -
> -        Documentation/devicetree/bindings/i2c
> -
> -for more details.
> -
> -Required properties:
> -	- compatible:  	Must be one of the following, depending on the model:
> -			adi,ad5272-020
> -			adi,ad5272-050
> -			adi,ad5272-100
> -			adi,ad5274-020
> -			adi,ad5274-100
> -
> -Optional properties:
> - - reset-gpios: GPIO specification for the RESET input. This is an
> -		active low signal to the AD5272.
> -
> -Example:
> -ad5272: potentiometer@2f {
> -	reg = <0x2F>;
> -	compatible = "adi,ad5272-020";
> -	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> new file mode 100644
> index 000000000000..b9b7d383bff1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5272 digital potentiometer
> +
> +maintainers:
> +  - Phil Reid <preid@electromag.com.au>
> +
> +description: |
> +  Datasheet: https://www.analog.com/en/products/ad5272.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5272-020
> +      - adi,ad5272-050
> +      - adi,ad5272-100
> +      - adi,ad5274-020
> +      - adi,ad5274-100
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Active low signal to the AD5272 RESET input.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        potentiometer@2f {
> +            compatible = "adi,ad5272-020";
> +            reg = <0x2F>;
> +            reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

23 Junction Parade, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
