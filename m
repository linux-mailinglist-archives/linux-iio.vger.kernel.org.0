Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B08241558
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 05:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHKDf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 23:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgHKDf4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 23:35:56 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CFC06174A
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2020 20:35:55 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so9433547iln.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2020 20:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoAFxkYHimwlRMa0O33F9oj8ETqTc94/er1Fur1K2VY=;
        b=OepbOosG6cVp2QSTFhL6XRyoHNakaPaNFOjozWqbYfosEqMX+WEzxxScojKtGMvvBh
         NL92h45L4Q8UT4Mln8VCF+hKD8lbhUEfDsyr5TUgjdw6dzVkbuj4LUEMmjbVpWUmRasS
         UB2ZC9MqSedOctbI9clxo5voblVc20ql18fOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoAFxkYHimwlRMa0O33F9oj8ETqTc94/er1Fur1K2VY=;
        b=tnJz0lFQ4gQMD/Oorfw7eBkozjrCG2ZQduqAMtfu4aKnqXzezE88598YUs9FXnu5i6
         INM17oAQWHsJ61Y8UN3NlVPWagyvG4elr7lKTekkTFKD4rZ2DYnPOWMMbEjOZv0uO7ih
         Cy7DbU4Z2eeR6+dNrI3NQtHfvBFiI1NPG+byRGOnmmnSaykvG51hYNo1gJwxFQ+jKogl
         RmgafYqC1RjL1PMFjgpChhnDSUpKlURWARnnokQa3k6HCeWCbUBO3XgI8fdTQU8S85Hq
         HWyZ2UnPzzEDdCHRAwM30Us93adjcNwpenXYICtZhbeysqyyTovfExuIhBi31GNcqqze
         kT4w==
X-Gm-Message-State: AOAM530IvAP2caiCzqtnUgwTj1kYe+yBtum19AX9nHLJbSsFwFhAmtG0
        wuBxGSagN5c9V8DbysELLmURoOXvqo7DHrcn9Lo41w==
X-Google-Smtp-Source: ABdhPJzsL8VPLkqDmEWhkcpZ6013wkdMp5Ww0FbcTTMftOWeLIyT7Jiyb+9JEV9ChpDiiWLsCsPueJ9z/FwRsMjgWoA=
X-Received: by 2002:a05:6e02:c71:: with SMTP id f17mr8440565ilj.98.1597116955080;
 Mon, 10 Aug 2020 20:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200809111753.156236-1-jic23@kernel.org> <20200809111753.156236-6-jic23@kernel.org>
In-Reply-To: <20200809111753.156236-6-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 10 Aug 2020 20:35:43 -0700
Message-ID: <CAJCx=gkytma0DvFxiJn_phipQQHCwr6NF5EMzk++XPNSzSRP5g@mail.gmail.com>
Subject: Re: [PATCH 05/13] dt-bindings: iio: adc: ti,adc161s626 yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 4:20 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion for this ADC driver.  Note that I haven't put
> limits on the spi-max-sampling-frequency because the adc161s626
> doesn't state one clearly defined value.
>
> Added the #io-channel-cells property to allow for consumers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>


> ---
>  .../bindings/iio/adc/ti,adc161s626.yaml       | 51 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc161s626.txt        | 18 -------
>  2 files changed, 51 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
> new file mode 100644
> index 000000000000..3f4f334d6f73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,adc161s626.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADC141S626 and ADC161S626 ADCs
> +
> +maintainers:
> +  - Matt Ranostay <matt.ranostay@konsulko.com>
> +
> +description: |
> +  Single channel 14/16bit differential ADCs
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,adc141s626
> +      - ti,adc161s626
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  vdda-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,adc161s626";
> +            vdda-supply = <&vdda_fixed>;
> +            reg = <0>;
> +            spi-max-frequency = <4300000>;
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> deleted file mode 100644
> index 3d25011f0c99..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Texas Instruments ADC141S626 and ADC161S626 chips
> -
> -Required properties:
> - - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
> - - reg: spi chip select number for the device
> - - vdda-supply: supply voltage to VDDA pin
> -
> -Recommended properties:
> - - spi-max-frequency: Definition as per
> -               Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -adc@0 {
> -       compatible = "ti,adc161s626";
> -       vdda-supply = <&vdda_fixed>;
> -       reg = <0>;
> -       spi-max-frequency = <4300000>;
> -};
> --
> 2.28.0
>
