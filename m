Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B9655C1EF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiF0WZ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbiF0WZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:25:26 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07818357;
        Mon, 27 Jun 2022 15:25:25 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id f15so6527099ilj.11;
        Mon, 27 Jun 2022 15:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPl5d+aNcqE9cDBG3G/otoyoA/ZIfmiAIqcA/be9AUQ=;
        b=G9eDVexFhOdGKvYDeZ0w4FAaC79O9dy/uG1SjJahGqAbyN4jKZc2i9PDOWj4Xqw1vU
         4alLpdfPM3RUqhUEgZbnGjoTU3bpM+a8R3D0c7DviQREQlhxUmr1qNdulPL79i6cE8Ee
         /7r8lMjJs7vF+pKdh8Zq3jLsjXsF9QiIp0vwInmft/QQJp9toP0aofi5Nx9a+k2ZDqvQ
         GEaU/cC/uQ7K+Zo47QT5Ikz4NQOhVkVG40NwuhX6uJI2vXfRpkApUIYCX96Te7MPbZSO
         m3H7v06ZJfVfRY8pisvFeLKDwnn9eCWXl31MkBcdmfICsO68nohvRNT+5/f0VQVF+EA7
         pUEg==
X-Gm-Message-State: AJIora8n1bj/kQoX3bpgRtfdmlixb8ZWSqJVw9iwXSxsmIAUsIOw5sYA
        RCYmVpkzxD31LkN3JeRU+A==
X-Google-Smtp-Source: AGRyM1s2YGaEBy6p5QS578o6Kmq3oHW6dPUUNTJsordKAInVNfZbRNjeBeQ//9YN/X5RgBK3WMJqzA==
X-Received: by 2002:a05:6e02:1bc4:b0:2da:7a81:1c9a with SMTP id x4-20020a056e021bc400b002da7a811c9amr7050769ilv.213.1656368724623;
        Mon, 27 Jun 2022 15:25:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k3-20020a6bef03000000b0067511446707sm4858733ioh.21.2022.06.27.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:25:24 -0700 (PDT)
Received: (nullmailer pid 3076525 invoked by uid 1000);
        Mon, 27 Jun 2022 22:25:22 -0000
Date:   Mon, 27 Jun 2022 16:25:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, Jacopo Mondi <jacopo@jmondi.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: staging: iio: imu: Document CEVA BNO08x
Message-ID: <20220627222522.GA3067718-robh@kernel.org>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-2-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616100006.22045-2-jacopo+renesas@jmondi.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 16, 2022 at 12:00:05PM +0200, Jacopo Mondi wrote:
> From: Jacopo Mondi <jacopo@jmondi.org>
> 
> Document CEVA BNO08x (080, 085 and 086) Sensor Hub.
> 
> The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> firmware.
> 
> Datasheet:
> https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  .../bindings/staging/iio/imu/ceva,bno08x.yaml | 63 +++++++++++++++++++

You expect this binding to change? If so, then why define the ABI. If 
not, then why is it in staging? IOW, I don't really want additions to 
bindings/staging/.

If this isn't in a .dts file and the driver isn't stable yet, then just 
don't document it until it is.

>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml b/Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml
> new file mode 100644
> index 000000000000..f7d6ea6d9147
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/staging/iio/imu/ceva,bno08x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CEVA BNO080/85/86
> +
> +maintainers:
> +  - Jacopo Mondi <jacopo@jmondi.org>
> +
> +description: |
> +  CEVA BNO08x is a System in Package (SiP) that integrates a triaxial
> +  accelerometer, triaxial gyroscope, magnetometer and a 32-bit ARM Cortex-M0+
> +  microcontroller running CEVA's SH-2 firmware.
> +
> +  The BNO08x family is documented at
> +  https://www.ceva-dsp.com/product/bno080-085/
> +  https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> +
> +  The SH-2 firmware reference is available at
> +  https://cdn.sparkfun.com/assets/4/d/9/3/8/SH-2-Reference-Manual-v1.2.pdf
> +  https://cdn.sparkfun.com/assets/7/6/9/3/c/Sensor-Hub-Transport-Protocol-v1.7.pdf
> +
> +properties:
> +  compatible:
> +    const: ceva,bno08x

Don't use wildcards in compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Phandle to the GPIO connected to the chip H_INTN (Host Interrupt) pin.
> +      The interrupt type shall be IRQ_TYPE_EDGE_FALLING.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bno080: imu@4b {
> +            compatible = "ceva,bno08x";
> +            interrupt-parent = <&gpio5>;
> +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +            reg = <0x4b>;
> +        };
> +    };
> +
> --
> 2.35.1
> 
> 
