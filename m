Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4F22B88B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGWVVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 17:21:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39132 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVVl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 17:21:41 -0400
Received: by mail-io1-f65.google.com with SMTP id z6so7816619iow.6;
        Thu, 23 Jul 2020 14:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DF4SoJ3bkqgFOwJrwi4NaCZKlRqd4/RS0vrb93p8qnk=;
        b=RfmeCifK8bD8B0M1C8dczCH7k+xnR8PQlUbvIdhsK46CH33a4xbf5fmQUhFrbVTNYP
         3kFsqWDmghnrTy7XNKPBof06rj8r7RK75PPm2MCJ5OlmnxYVXvsEyidwdmJLnCGJOKdp
         NRNzX5qZg+AyktLygzLMxOjf1waFOaQ+XkHTRG1i6EeRBpuzNflsnU70BmyJ2bpKGroX
         r4nebSitWtgbDrhO7722FyDiKO/L0OCaCMEHs3nempaAGW2PDjqGOAnTYO/k0iVN1wom
         UZbRtHAOz9LwmejNYPJesFGJ6PcfSUK1GMWtrGmXciAKm7V2KkcbV8VM6VoopH+xVpsV
         w31Q==
X-Gm-Message-State: AOAM531rHgEXdm1Ivg2tbQGENXhX5WJC86Y1Z0GQTBAWGexyIkiqDWD1
        H61qke+JskhVECazDI0SjA==
X-Google-Smtp-Source: ABdhPJwNHXXRj2P9BDzjbKhSiYJWzsI4bSYAAQ/7SgyJi1PiF/OckBbEZ/VG/YgjGAEgbQCLDA0srA==
X-Received: by 2002:a05:6602:2e13:: with SMTP id o19mr7184099iow.24.1595539300530;
        Thu, 23 Jul 2020 14:21:40 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f18sm2066894ion.47.2020.07.23.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:21:40 -0700 (PDT)
Received: (nullmailer pid 880075 invoked by uid 1000);
        Thu, 23 Jul 2020 21:21:39 -0000
Date:   Thu, 23 Jul 2020 15:21:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: maxim,max1118 yaml conversion
Message-ID: <20200723212139.GA875510@bogus>
References: <20200722171224.989138-1-jic23@kernel.org>
 <20200722171224.989138-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722171224.989138-3-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 06:12:23PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple device with a simple conversion.  Special handling needed
> for the max1118 which is the only supported part that has an external
> reference voltage.
> 
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
>  .../bindings/iio/adc/maxim,max1118.yaml       | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max1118.txt b/Documentation/devicetree/bindings/iio/adc/max1118.txt
> deleted file mode 100644
> index cf33d0b15a6d..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/max1118.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs
> -
> -Required properties:
> - - compatible: Should be one of
> -	* "maxim,max1117"
> -	* "maxim,max1118"
> -	* "maxim,max1119"
> - - reg: spi chip select number for the device
> - - (max1118 only) vref-supply: The regulator supply for ADC reference voltage
> -
> -Recommended properties:
> - - spi-max-frequency: Definition as per
> -		Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -adc@0 {
> -	compatible = "maxim,max1118";
> -	reg = <0>;
> -	vref-supply = <&vdd_supply>;
> -	spi-max-frequency = <1000000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
> new file mode 100644
> index 000000000000..ca24b8b23cde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max1118.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1118 and similar ADCs
> +
> +maintainers:
> +  - Akinobu Mita <akinobu.mita@gmail.com>
> +
> +description: |
> +    Dual channel 8bit ADCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max1117
> +      - maxim,max1118
> +      - maxim,max1119
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +           const: maxim,max1118
> +    then:
> +      properties:
> +        vref-supply:
> +          description: External reference, needed to establish input scaling

This needs to be moved to the main section when you add 
'additionalProperties'.

Then add an 'else' clause here with:

not:
  required:
    - vref-supply

Or this works too:

properties:
  vref-supply: false

> +
> +      required:
> +        - vref-supply
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "maxim,max1118";
> +            reg = <0>;
> +            vref-supply = <&adc_vref>;
> +            spi-max-frequency = <1000000>;
> +        };
> +    };
> +...
> -- 
> 2.27.0
> 
