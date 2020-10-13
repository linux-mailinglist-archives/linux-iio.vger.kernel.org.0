Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EEA28CA2B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391414AbgJMIWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391409AbgJMIWb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 04:22:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD1C0613D0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 01:22:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so16246772pfa.10
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGbrU6mHLZ6OXB9EsoVPLPTA7DB5gEcDbBfK2zWDWrw=;
        b=YdSLdZK3dEfpnmrah3yIa3nc2lGMoekMUNSdj1JeeY6YqYJCuFFtdgkpkyObxv+UhP
         eaQg45rtrKmT2zvSW2d53sdoBp5zAYcYg6ld/UBJU5de25uGQ/4HBN5g/vZ57UuSnJeN
         zj8hRwjaXgirTOtv20dMKmDRlEaw0UawduKr8kDVGDhrsJCRbT44/pIw0fYbCc9F+7LR
         WuZ8/GyTQXxrqdV2hMyBjIWiRjQCPZAGBpjevJkTCfcyHEodvKkpfUaHEPPmzPSrZLsr
         4Ceo5sycPTAWVjwsNyKW6W5L6uSebDYsY74mSLx8JcMyHUGs3gcTvktyrFiRw8gWTurb
         n+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGbrU6mHLZ6OXB9EsoVPLPTA7DB5gEcDbBfK2zWDWrw=;
        b=Yl1pqH4/Sr7VDLQrwvIueehDbQBZ1hlTJxFgWNzJPBtETSM0BjNdDLr7WXsHq2SHvh
         My/9d0qLILPL09LetyRUYjdaAdfUzkCGC+xARzIATRPn5D9+1K7H1m5etE56Ao8sr9Jn
         hRoCJxT3ftCn9QYHqgWaj8KbrD1NQPREOOfjU7iKVvzH/8k8fyQg6g3prK/9ozVrD/VQ
         sUTsVyz6w8ib1e8/F/PiVkZv0I9gUQpvN/uCgqpqKkyoKpgTpuhZOWQTzxgdyQN7XtrV
         fmTiQh9aoPkwoHqIm5hznpIZ3cgTtAw3BxnllztQrjsiJ/52/qu8IctN3kiInk0UCpiI
         MoWg==
X-Gm-Message-State: AOAM530aIkqNOz4hA+2Qj+2+n0UaHwvy3qGRoOuITOhDYjfdW9ctDGBv
        FocK9Ac7L7dIcXdk6QvUCZc2
X-Google-Smtp-Source: ABdhPJxISy31+7PvIjATMety61KYvRr1jfU45E0fZF0KdHojJsGTi5oqbjfIoS4azfNcAbKj6QaFCw==
X-Received: by 2002:a63:3f8d:: with SMTP id m135mr9893179pga.234.1602577351127;
        Tue, 13 Oct 2020 01:22:31 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id u18sm22833866pgk.18.2020.10.13.01.22.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Oct 2020 01:22:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <manivannanece23@gmail.com>
Date:   Tue, 13 Oct 2020 13:52:25 +0530
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 29/29] dt-bindings:iio:temperature:ti,tmp07 yaml
 conversion
Message-ID: <20201013082225.GD5065@linux>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-30-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011170749.243680-30-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 06:07:49PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion from txt to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Manivannan Sadhasivam <manivannanece23@gmail.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  .../bindings/iio/temperature/ti,tmp007.yaml   | 57 +++++++++++++++++++
>  .../bindings/iio/temperature/tmp007.txt       | 33 -----------
>  2 files changed, 57 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
> new file mode 100644
> index 000000000000..3c2b7189fa2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ti,tmp007.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IR thermopile sensor with integrated math engine
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannanece23@gmail.com>
> +
> +description: |
> +  http://www.ti.com/lit/ds/symlink/tmp007.pdf
> +
> +properties:
> +  compatible:
> +    const: ti,tmp007
> +
> +  reg:
> +    description: |
> +      The I2C address of the sensor (changeable via ADR pins)
> +      ------------------------------
> +      |ADR1 | ADR0 | Device Address|
> +      ------------------------------
> +         0      0        0x40
> +         0      1        0x41
> +         0     SDA       0x42
> +         0     SCL       0x43
> +         1      0        0x44
> +         1      1        0x45
> +         1     SDA       0x46
> +         1     SCL       0x47
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temp-sensor@40 {
> +            compatible = "ti,tmp007";
> +            reg = <0x40>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <5 0x08>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> deleted file mode 100644
> index da0af234a357..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -* TI TMP007 - IR thermopile sensor with integrated math engine
> -
> -Link to datasheet: http://www.ti.com/lit/ds/symlink/tmp007.pdf
> -
> -Required properties:
> -
> -  - compatible: should be "ti,tmp007"
> -  - reg: the I2C address of the sensor (changeable via ADR pins)
> -		------------------------------
> -		|ADR1 | ADR0 | Device Address|
> -		------------------------------
> -		   0      0        0x40
> -		   0	  1	   0x41
> -		   0	 SDA       0x42
> -		   0     SCL       0x43
> -		   1      0        0x44
> -		   1      1        0x45
> -		   1	 SDA	   0x46
> -		   1     SCL       0x47
> -
> -Optional properties:
> -
> -  - interrupts: interrupt mapping for GPIO IRQ (level active low)
> -
> -Example:
> -
> -tmp007@40 {
> -        compatible = "ti,tmp007";
> -        reg = <0x40>;
> -	interrupt-parent = <&gpio0>;
> -	interrupts = <5 0x08>;
> -};
> -
> -- 
> 2.28.0
> 
