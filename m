Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0A260346
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgIGRq5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgIGRqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Sep 2020 13:46:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF419C061573;
        Mon,  7 Sep 2020 10:46:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so7018007pjr.2;
        Mon, 07 Sep 2020 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUwwJmW415jdniBRnhCr71QvDhindSCif4v2x7+xATw=;
        b=rAchZ6oxFaZRTKYKHVAu1BJZNZ8CqgEdPpcTyyM+gTIhqZWyRTywYlYvhvwWkriCla
         vK/PrJ3tt+OGuxhpXdu+oZ8fSwIbAfbBHkSKmqL4PPRwkqXOu+KSyz6kGRVRwXXmz5d2
         XW7eL1V2CGLn4AEDouT0dZX3KP4UF+2hJiOQjqamGlvXYfmzUdNyeX+niKkya0i8eGvC
         Zw/NkqlE/xG6CYy/naDuKHO5ScSMtJbuIFGqZjUdZh8OkG0jiN4uf3zbaKtnTI75FWvf
         5fVYEza7xlcgEfAjdaHFC/IEtBMeXOnpDALDheR+BXgWl2Zprwo6d7Mm4uj7Udhwa3Qj
         bOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUwwJmW415jdniBRnhCr71QvDhindSCif4v2x7+xATw=;
        b=Kfn3vjEJeNSYGAMGMQHTQG5BWXuVJVIvgI1BxCkgWYNYISN3usoSQcms5ZG3CwobJi
         u71JS1J39nBDHLOeU7YJPnXpWo/kwRViISwOOxzRVVTXSU/Tcbkpzb1er4IA6tUdi6H2
         RpkA2NZxVZIOviXU5SE77CmmpBrFdXvVnAmHX35+vb/p2ryQxCSFBVfK8uMKEGxGeJE4
         FmeWGZQ9U9s9JWDjmM2OgJMpmlPfrFvNGpPx+YjejM0Xf6E7ntfjl1ySYyIQ+nWqHHyO
         xooH9Ica5dXp8QoCnHULlSOdOHSCr+Dcx/NR2yQyigiCmhMKsQ4ShL/8nmjnCK22++bC
         MCYA==
X-Gm-Message-State: AOAM530DKsOGSlkV/tOP4K22AxUXBY9VrFAsAo4Hca6Lpxj34onpgBi7
        fVhmz0rY090XJAGy8HT3xkFju/72Iz7mlX15ZnY=
X-Google-Smtp-Source: ABdhPJzVnZk2IuUK4LHweduLHf6VK/djDPaGh2EANPzLRqhLVy1fm8I6Oyl2Axhqvudkojmk9o9mLgkwfY4Cf0r36zg=
X-Received: by 2002:a17:902:7d8e:: with SMTP id a14mr6381974plm.224.1599500812402;
 Mon, 07 Sep 2020 10:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200905173004.216081-1-jic23@kernel.org> <20200905173004.216081-7-jic23@kernel.org>
In-Reply-To: <20200905173004.216081-7-jic23@kernel.org>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Tue, 8 Sep 2020 01:46:40 +0800
Message-ID: <CA+H2tpE2-f7Sugi04hFwx4QrczufnE2gNHPzAoHWMwARgyOyLw@mail.gmail.com>
Subject: Re: [PATCH 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Sep 6, 2020 at 1:32 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I changed the name to reflect a specific part in line with normal
> naming conventions. If there is a particularly strong reason to
> keep the wild cards let me know.

Why do we have to change the file name of 27xx ?

>
> Otherwise this was a fairly simple conversion as part of converting
> all the IIO bindings to yaml.

Thanks for doing this for us.

-Orson

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
>  .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
>  2 files changed, 72 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> new file mode 100644
> index 000000000000..57df6439dd9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sprd,sc2720-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SC27XX series PMICs ADC binding
> +
> +maintainers:
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +
> +description:
> +  Supports the ADC found on these PMICs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc2720-adc
> +      - sprd,sc2721-adc
> +      - sprd,sc2723-adc
> +      - sprd,sc2730-adc
> +      - sprd,sc2731-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  hwlocks:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 2
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: big_scale_calib
> +      - const: small_scale_calib
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#io-channel-cells"
> +  - hwlocks
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@480 {
> +            compatible = "sprd,sc2731-adc";
> +            reg = <0x480>;
> +            interrupt-parent = <&sc2731_pmic>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            #io-channel-cells = <1>;
> +            hwlocks = <&hwlock 4>;
> +            nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> +            nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> deleted file mode 100644
> index b4daa15dcf15..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Spreadtrum SC27XX series PMICs ADC binding
> -
> -Required properties:
> -- compatible: Should be one of the following.
> -       "sprd,sc2720-adc"
> -       "sprd,sc2721-adc"
> -       "sprd,sc2723-adc"
> -       "sprd,sc2730-adc"
> -       "sprd,sc2731-adc"
> -- reg: The address offset of ADC controller.
> -- interrupt-parent: The interrupt controller.
> -- interrupts: The interrupt number for the ADC device.
> -- #io-channel-cells: Number of cells in an IIO specifier.
> -- hwlocks: Reference to a phandle of a hwlock provider node.
> -- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
> -- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
> -
> -Example:
> -
> -       sc2731_pmic: pmic@0 {
> -               compatible = "sprd,sc2731";
> -               reg = <0>;
> -               spi-max-frequency = <26000000>;
> -               interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -               interrupt-controller;
> -               #interrupt-cells = <2>;
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               pmic_adc: adc@480 {
> -                       compatible = "sprd,sc2731-adc";
> -                       reg = <0x480>;
> -                       interrupt-parent = <&sc2731_pmic>;
> -                       interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> -                       #io-channel-cells = <1>;
> -                       hwlocks = <&hwlock 4>;
> -                       nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
> -                       nvmem-cell-names = "big_scale_calib", "small_scale_calib";
> -               };
> -       };
> --
> 2.28.0
>
