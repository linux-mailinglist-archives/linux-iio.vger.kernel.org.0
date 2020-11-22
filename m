Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449402BC789
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKVRm6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 12:42:58 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39636 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgKVRm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 12:42:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B59609E0049;
        Sun, 22 Nov 2020 17:42:55 +0000 (GMT)
Date:   Sun, 22 Nov 2020 17:42:52 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 16/46] dt-bindings:iio:light:sharp,gp2ap020a00f: txt to
 yaml conversion.
Message-ID: <20201122174252.6f90d7a5@archlinux>
In-Reply-To: <20201031184854.745828-17-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-17-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:24 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion.  Maintainers as per original binding file authors,
> but that was a long time back so as with others, if email addresses bounce
> I'll switch this to me.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Jacek's emails bouncing so dropped from maintainers.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../bindings/iio/light/gp2ap020a00f.txt       | 21 --------
>  .../iio/light/sharp,gp2ap020a00f.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> deleted file mode 100644
> index 9231c82317ad..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Sharp GP2AP020A00F I2C Proximity/ALS sensor
> -
> -The proximity detector sensor requires power supply
> -for its built-in led. It is also defined by this binding.
> -
> -Required properties:
> -
> -  - compatible : should be "sharp,gp2ap020a00f"
> -  - reg : the I2C slave address of the light sensor
> -  - interrupts : interrupt specifier for the sole interrupt generated
> -		 by the device
> -  - vled-supply : VLED power supply, as covered in ../regulator/regulator.txt
> -
> -Example:
> -
> -gp2ap020a00f@39 {
> -	compatible = "sharp,gp2ap020a00f";
> -	reg = <0x39>;
> -	interrupts = <2 0>;
> -	vled-supply = <...>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> new file mode 100644
> index 000000000000..d6a4b47467f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/sharp,gp2ap020a00f.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp GP2AP020A00F I2C Proximity/ALS sensor
> +
> +maintainers:
> +  - Jacek Anaszewski <j.anaszewski@samsung.com>
> +  - Kyungmin Park <kyungmin.park@samsung.com>
> +
> +description: |
> +  The proximity detector sensor requires power supply for its built-in led.
> +
> +properties:
> +  compatible:
> +    const: sharp,gp2ap020a00f
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vled-supply: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vled-supply
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@39 {
> +            compatible = "sharp,gp2ap020a00f";
> +            reg = <0x39>;
> +            interrupts = <2 0>;
> +            vled-supply = <&als_reg>;
> +        };
> +    };
> +...

