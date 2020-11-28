Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5692C74A1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbgK1Vtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbgK1THD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:07:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D56246CA;
        Sat, 28 Nov 2020 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606581516;
        bh=tToNEDXKqrHxmvWK0E7n9JzzmVszJUc/God8Yny7iaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J2M3rWimEqY/Jd13Su1ZEF7BULAh2XLq0ThcXImkwNy0zjkTf8y0VeBDOB9hYGJur
         DNpCMXdmZNk0AxdmTZXalGVSC6Jg38iH26B4CoTpiTnKAvGo1inQM3s7lf671pMXQ8
         Gj0+TmbsR7hqT20FI+UbakbLhwbuAf1uf6HiCs9c=
Date:   Sat, 28 Nov 2020 16:38:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/3] dt-bindings:iio:adc: convert adc.txt to yaml
Message-ID: <20201128163832.638a7801@archlinux>
In-Reply-To: <20201031182423.742798-2-jic23@kernel.org>
References: <20201031182423.742798-1-jic23@kernel.org>
        <20201031182423.742798-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:24:21 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Each driver that uses this will need to use a $ref
> We can't always enable it like most of the generic bindings due to
> channel@X matching far more widely than IIO.

This patch crossed with the introduction of a label attribute
to the txt file.  As that was trivial I've just moved that
over to the yaml file and applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/adc.txt       | 23 -----------
>  .../devicetree/bindings/iio/adc/adc.yaml      | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
> deleted file mode 100644
> index 5bbaa330a250..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/adc.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Common ADCs properties
> -
> -Optional properties for child nodes:
> -- bipolar : Boolean, if set the channel is used in bipolar mode.
> -- diff-channels : Differential channels muxed for this ADC. The first value
> -		specifies the positive input pin, the second value the negative
> -		input pin.
> -
> -Example:
> -	adc@0 {
> -		compatible = "some,adc";
> -		...
> -		channel@0 {
> -			bipolar;
> -			diff-channels = <0 1>;
> -			...
> -		};
> -
> -		channel@1 {
> -			diff-channels = <2 3>;
> -			...
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> new file mode 100644
> index 000000000000..328a4318feee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic IIO bindings for ADC channels
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description:
> +  A few properties are defined in a common way ADC channels.
> +
> +properties:
> +  $nodename:
> +    pattern: "^channel(@[0-9a-f]+)?$"
> +    description:
> +      A channel index should match reg.
> +
> +  reg:
> +    maxItems: 1
> +
> +  bipolar:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If provided, the channel is to be used in bipolar mode.
> +
> +  diff-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 2
> +    minItems: 2
> +    description:
> +      Many ADCs have dual Muxes to allow different input pins to be routed
> +      to both the positive and negative inputs of a differential ADC.
> +      The first value specifies the positive input pin, the second
> +      specifies the negative input pin.
> +
> +additionalProperties: true

