Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901582A4B9F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKCQeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:34:10 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:45935 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgKCQeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:34:10 -0500
Received: by mail-oo1-f66.google.com with SMTP id j41so4342560oof.12;
        Tue, 03 Nov 2020 08:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKqONroTNYXML+RtHTbg+GBecYRT+0c6qZrSPFfEkFs=;
        b=jQw4AF+SmHqC5eO/NaZtAWkHqE+DNjq/G6SYolKUHFmdo2ioHSUL8fBjkPLbiKYvCo
         ffKW/QUOnyK2DxTbZQO8flcLjI+UNDWpt1pYipttESGLSsLXRRsmMNk1YyI5W2sZrdIC
         vuVG24kzkKLbtmclx1TfCuvtUmWN/o3B0dqCy5Tc82P5LYr5C+7+0WVGtkKyiIvEzkZf
         0qcAuXQF9j0opO5bp5kwpDMIMKXH49ow4fIEjiiZ8StTO7TM66DCh3rM/YzvEX+RgWoT
         1rr3sfxeE37mWCcYYt4R+rfTa1QvRmHxLJfenza8SaBg/VnWiQ53YsiaQKGmBHuPz/ib
         jUDQ==
X-Gm-Message-State: AOAM532EVTvI3g+muFA+VT66z3WUX5YVfqSHXHdOX8xmMPr9rtASQyPc
        E7/InxLtF++ov4T7ou4DvBMapIeV5w==
X-Google-Smtp-Source: ABdhPJzxtuDaLDOVaKpgjPJIz4ZpByu3MGeiU+GhwDmrKkpWNjCZNAHuCuSYgqvfJm8uqG9LoAAjZg==
X-Received: by 2002:a4a:e95d:: with SMTP id v29mr15810516ood.91.1604421248319;
        Tue, 03 Nov 2020 08:34:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm4047251oif.43.2020.11.03.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:34:07 -0800 (PST)
Received: (nullmailer pid 1788543 invoked by uid 1000);
        Tue, 03 Nov 2020 16:34:07 -0000
Date:   Tue, 3 Nov 2020 10:34:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 42/46] dt-bindings:iio:accel:fsl,mma8452: txt to yaml
 conversion.
Message-ID: <20201103163407.GG1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-43-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-43-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:50PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding so mostly straight forward to convert.
> Original binding was unclear on how many interrupts there are.
> The device has two such lines, whilst I believe the driver currently
> only uses one at a time.  The binding should allow both to be specified.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> ---
>  .../bindings/iio/accel/fsl,mma8452.yaml       | 62 +++++++++++++++++++
>  .../devicetree/bindings/iio/accel/mma8452.txt | 35 -----------
>  2 files changed, 62 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
> new file mode 100644
> index 000000000000..3b8e5ebdf90c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/fsl,mma8452.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
> +  triaxial accelerometer
> +
> +maintainers:
> +  - Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,mma8451
> +      - fsl,mma8452
> +      - fsl,mma8453
> +      - fsl,mma8652
> +      - fsl,mma8653
> +      - fsl,fxls8471
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      2 highly configurable interrupt lines exist.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: Specify which interrupt line is in use.
> +    enum:
> +      - INT1
> +      - INT2

This will default to only 1 item allowed. You need minItems/maxItems.

> +
> +  vdd-supply: true
> +  vddio-supply: true
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
> +        accel@1d {
> +            compatible = "fsl,mma8453";
> +            reg = <0x1d>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <5 0>;
> +            interrupt-names = "INT2";
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> deleted file mode 100644
> index e132394375a1..000000000000
> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
> -triaxial accelerometer
> -
> -Required properties:
> -
> -  - compatible: should contain one of
> -    * "fsl,mma8451"
> -    * "fsl,mma8452"
> -    * "fsl,mma8453"
> -    * "fsl,mma8652"
> -    * "fsl,mma8653"
> -    * "fsl,fxls8471"
> -
> -  - reg: the I2C address of the chip
> -
> -Optional properties:
> -
> -  - interrupts: interrupt mapping for GPIO IRQ
> -
> -  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
> -		     interrupt line in use.
> -
> -  - vdd-supply: phandle to the regulator that provides vdd power to the accelerometer.
> -
> -  - vddio-supply: phandle to the regulator that provides vddio power to the accelerometer.
> -
> -Example:
> -
> -	mma8453fc@1d {
> -		compatible = "fsl,mma8453";
> -		reg = <0x1d>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <5 0>;
> -		interrupt-names = "INT2";
> -	};
> -- 
> 2.28.0
> 
