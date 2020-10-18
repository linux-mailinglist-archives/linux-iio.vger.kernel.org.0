Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCB2918B1
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgJRRru (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRrt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 13:47:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A331207BB;
        Sun, 18 Oct 2020 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603043269;
        bh=408HoBPOaafIJF53bdqtdqvD7XMAA29NhowBqYpKaew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rw1sSUjK16aC5eo1mWWC8Wb8KhGIdEnEBb75XkFrP3DhZclf1aV9HutPNz0lOUxul
         wiTfNRw3Z8ZA/rlK49pymX9N3k43Sy9mYqtfUyboEApTB1zU6p32ZAcDGDmg/T0Y7z
         3HGDBAUo+JH0p25D+4OWSA3C/1cxe2+t1101Xzic=
Date:   Sun, 18 Oct 2020 18:47:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Ismail H . Kose" <Ismail.Kose@maximintegrated.com>,
        "Ismail H . Kose" <ihkose@gmail.com>
Subject: Re: [PATCH 18/29] dt-bindings:iio:dac:maxim,ds4424 yaml conversion
Message-ID: <20201018184744.16a20230@archlinux>
In-Reply-To: <20201011170749.243680-19-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
        <20201011170749.243680-19-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 18:07:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion of this straight forward binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ismail H. Kose <Ismail.Kose@maximintegrated.com>
> Cc: Ismail H. Kose <ihkose@gmail.com>
Ismail's Maxim address bounces, so I've switched to the gmail one
for v2.  @Ismail: If you'd rather not be listed as maintaining this
binding then let me know.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/dac/ds4424.txt    | 20 ---------
>  .../bindings/iio/dac/maxim,ds4424.yaml        | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> deleted file mode 100644
> index eaebbf8dab40..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device Driver
> -
> -Datasheet publicly available at:
> -https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
> -
> -Required properties:
> -	- compatible: Should be one of
> -		maxim,ds4422
> -		maxim,ds4424
> -	- reg: Should contain the DAC I2C address
> -
> -Optional properties:
> -	- vcc-supply: Power supply is optional. If not defined, driver will ignore it.
> -
> -Example:
> -	ds4224@10 {
> -		compatible = "maxim,ds4424";
> -		reg = <0x10>; /* When A0, A1 pins are ground */
> -		vcc-supply = <&vcc_3v3>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> new file mode 100644
> index 000000000000..91661079d7ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/maxim,ds4424.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC
> +
> +maintainers:
> +  - Ismail H. Kose <Ismail.Kose@maximintegrated.com>
> +
> +description: |
> +  Datasheet publicly available at:
> +  https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,ds4422
> +      - maxim,ds4424
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply: true
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
> +        dac@10 {
> +            compatible = "maxim,ds4424";
> +            reg = <0x10>; /* When A0, A1 pins are ground */
> +            vcc-supply = <&vcc_3v3>;
> +        };
> +    };
> +...

