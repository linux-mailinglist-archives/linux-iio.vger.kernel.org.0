Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7515FF52
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgBOQ7J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 11:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgBOQ7J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 11:59:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B142083B;
        Sat, 15 Feb 2020 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581785948;
        bh=1qUEz4ujkGGQsEuVNAf94EoAOAw0/zejz2pxtOvcllw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obe+96GUSY7bGr259zJRrQ+YuBQB5X/u8RM4qMrKOp7JLgB35zTcvipUo1YIEXybg
         hxk/V35XlQHlDS4U4eQiotLwcpN3YxGTYawl2cEXlqQS/MLlFYTCEYS2LqgT6fiIY5
         KCMVCb05FANjhgLqSGmw+CDSDjiXJ24lH3ts9rro=
Date:   Sat, 15 Feb 2020 16:59:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
Message-ID: <20200215165903.6ea4e618@archlinux>
In-Reply-To: <20200211191201.1049902-2-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-2-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:55 +0100
David Heidelberg <david@ixit.cz> wrote:

> This commit add dt-bindings support to al3320a driver and vendor-prefix
> dynaimage.
> Partly based on unmerged commit:
> "iio: Add Dyna-Image AP3223 ambient light and proximity driver"
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v5
>  - drop requirement on interrups and vdd-supply
>  - s/al3320a@1c/light-sensor@1c/
>  - dual license also under BSD
> 
>  .../bindings/iio/light/al3320a.yaml           | 43 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/al3320a.yaml b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
> new file mode 100644
> index 000000000000..cdc8d98d114c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
I missed this previously but it's preferred for the filename to include the
manufacturer bit.  I'll fix up including the reference to the filename below.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Ideally I'd like to add a DT reviewed by, but I think you've addressed
all the previous comments.

Thanks,

Jonathan


> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/al3320a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dyna-Image AL3320A sensor
> +
> +maintainers:
> +  - David Heidelberg <david@ixit.cz>
> +
> +properties:
> +  compatible:
> +    const: dynaimage,al3320a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@1c {
> +            compatible = "dynaimage,al3320a";
> +            reg = <0x1c>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupts = <0 99 4>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9cd52d9e1f7f..8d2ebf3d0aa1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -267,6 +267,8 @@ patternProperties:
>      description: Dragino Technology Co., Limited
>    "^dserve,.*":
>      description: dServe Technology B.V.
> +  "^dynaimage,.*":
> +    description: Dyna-Image
>    "^ea,.*":
>      description: Embedded Artists AB
>    "^ebs-systart,.*":

