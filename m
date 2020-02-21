Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516FA167D2E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgBUMNG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgBUMNG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 07:13:06 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371D2222C4;
        Fri, 21 Feb 2020 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582287185;
        bh=3z3upCnCkec4qC9f3BFjqKBnwF4POnJl6gERklBM3j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h5xjdH3qzrnkR5kEvswxuSoShiBBBE98ko97lVzU/1jyt0c7I663PMhUK/mvLdIrP
         YS4hGG/iUEiu8qWtT05mSReHgCcv/h7wRF74b0IltcLPNFCx4YCuVd/Au5+RLOy8Ic
         FytXG8OmBhK877u4LODfRsoa8yaIRYkx4Tw0vn/Q=
Date:   Fri, 21 Feb 2020 12:13:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 3/3] dt-bindings: iio: chemical: consolidate
 atlas-sensor docs
Message-ID: <20200221121302.4ba8bcc4@archlinux>
In-Reply-To: <20200218034239.135619-4-matt.ranostay@konsulko.com>
References: <20200218034239.135619-1-matt.ranostay@konsulko.com>
        <20200218034239.135619-4-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Feb 2020 19:42:39 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Since Atlas Scientific device support only varies from the compatible
> string is ideal all the respective docs are merged into a single doc
> named atlas,sensor.yaml
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Great.  Appiled to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 --------
>  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 --------
>  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++++++++++
>  4 files changed, 53 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> deleted file mode 100644
> index f4320595b851..000000000000
> --- a/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Atlas Scientific EC-SM OEM sensor
> -
> -http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
> -
> -Required properties:
> -
> -  - compatible: must be "atlas,ec-sm"
> -  - reg: the I2C address of the sensor
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -Example:
> -
> -atlas@64 {
> -	compatible = "atlas,ec-sm";
> -	reg = <0x64>;
> -	interrupt-parent = <&gpio1>;
> -	interrupts = <16 2>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> deleted file mode 100644
> index af1f5a9aa4da..000000000000
> --- a/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Atlas Scientific ORP-SM OEM sensor
> -
> -https://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
> -
> -Required properties:
> -
> -  - compatible: must be "atlas,orp-sm"
> -  - reg: the I2C address of the sensor
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -Example:
> -
> -atlas@66 {
> -	compatible = "atlas,orp-sm";
> -	reg = <0x66>;
> -	interrupt-parent = <&gpio1>;
> -	interrupts = <16 2>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> deleted file mode 100644
> index 79d90f060327..000000000000
> --- a/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -* Atlas Scientific pH-SM OEM sensor
> -
> -http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
> -
> -Required properties:
> -
> -  - compatible: must be "atlas,ph-sm"
> -  - reg: the I2C address of the sensor
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -Example:
> -
> -atlas@65 {
> -	compatible = "atlas,ph-sm";
> -	reg = <0x65>;
> -	interrupt-parent = <&gpio1>;
> -	interrupts = <16 2>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> new file mode 100644
> index 000000000000..edcd2904d50e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/atlas,sensor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atlas Scientific OEM sensors
> +
> +maintainers:
> +  - Matt Ranostay <matt.ranostay@konsulko.com>
> +
> +description: |
> +  Atlas Scientific OEM sensors connected via I2C
> +
> +  Datasheets:
> +    http://www.atlas-scientific.com/_files/_datasheets/_oem/DO_oem_datasheet.pdf
> +    http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
> +    http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
> +    http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atlas,do-sm
> +      - atlas,ec-sm
> +      - atlas,orp-sm
> +      - atlas,ph-sm
> +
> +  reg:
> +     maxItems: 1
> +
> +  interrupts:
> +     maxItems: 1
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      atlas@66 {
> +        compatible = "atlas,orp-sm";
> +        reg = <0x66>;
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <16 2>;
> +      };
> +    };

