Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8A26AD9A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgIOT24 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgIOT2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:28:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1AC06174A;
        Tue, 15 Sep 2020 12:18:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y9so4126611ilq.2;
        Tue, 15 Sep 2020 12:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qADCpDDZYXGLDB9qiRzX/sPuBqnYsAaT2PC/ym5ZjTk=;
        b=jg4w5u3kox34Nt89YauuPwLk8dzvD97VgMHBaKil7M+t4hPR08x8x6BMVElalTUfrw
         RT5czOo9J4KhDU0QONs95sJ6YAQQwQLU0iesvHl3M9Mi/c1ekuy2W31Y3AV3HnpaV+ww
         t6HL8Ib4z76LVGSbAkXl7d8rIafhGT8qEB10Ok1Ol7VU8o1wYjo3uXBn07vNpgnS97ia
         3r4hkUgKJ9iW0i79uPRHnriaWeADa/XBMGDwyP4Sse6MDMyT8Q7O7U/8i/pC6cOnIbnM
         XkCFjC7z1vBnjEVCwdpu3OvWnoFQUNK3s6n20OlKTUSLEWmtdOwa2f+dFWm5GtWNNgw+
         iDOA==
X-Gm-Message-State: AOAM532FOaOTyN/5TxTc4Cl7TdB7gi6trRR9LLsRmq/Drqlnnf+lCJwn
        EaCKw1GTn+gyD60nh1U+1TpsXRCAg8eypU0=
X-Google-Smtp-Source: ABdhPJyqNELLjuu7kp0t1pCCjZR/86ZoOLot1HeTBNTtMnGxW34QKKBhjo6ylC6d1mc4F0NqslvOSw==
X-Received: by 2002:a05:6e02:807:: with SMTP id u7mr16829423ilm.67.1600197482412;
        Tue, 15 Sep 2020 12:18:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e12sm9072165ils.70.2020.09.15.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:18:01 -0700 (PDT)
Received: (nullmailer pid 2341460 invoked by uid 1000);
        Tue, 15 Sep 2020 19:17:59 -0000
Date:   Tue, 15 Sep 2020 13:17:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v2 17/20] dt-bindings:iio:adc:holt,hi8435 yaml conversion
Message-ID: <20200915191759.GA2339990@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-18-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-18-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:43PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very simple binding.  I've changed the example to use the node
> name threshold-detector@0 as sensor@0 seemed too generic.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> ---
>  .../devicetree/bindings/iio/adc/hi8435.txt    | 21 --------
>  .../bindings/iio/adc/holt,hi8435.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> deleted file mode 100644
> index 3b0348c5e516..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Holt Integrated Circuits HI-8435 threshold detector bindings
> -
> -Required properties:
> - - compatible: should be "holt,hi8435"
> - - reg: spi chip select number for the device
> -
> -Recommended properties:
> - - spi-max-frequency: definition as per
> -		Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Optional properties:
> - - gpios: GPIO used for controlling the reset pin
> -
> -Example:
> -sensor@0 {
> -	compatible = "holt,hi8435";
> -	reg = <0>;
> -	gpios = <&gpio6 1 0>;
> -
> -	spi-max-frequency = <1000000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
> new file mode 100644
> index 000000000000..a35cf3876b86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/holt,hi8435.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Holt Integrated Circuits HI-8435 SPI threshold detector
> +
> +maintainers:
> +  - Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> +
> +description: |
> +  Datasheet: http://www.holtic.com/documents/427-hi-8435_v-rev-lpdf.do
> +
> +properties:
> +  compatible:
> +    const: holt,hi8435
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpios:
> +    description:
> +       GPIO used for controlling the reset pin

maxItems: 1

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  spi-max-frequency: true
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
> +        threshold-detector@0 {
> +            compatible = "holt,hi8435";
> +            reg = <0>;
> +            gpios = <&gpio6 1 0>;
> +            spi-max-frequency = <1000000>;
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
