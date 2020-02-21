Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B36167DE2
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBUNCe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 08:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgBUNCd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:02:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3944A206EF;
        Fri, 21 Feb 2020 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582290153;
        bh=+xThR+azD9P2PWAejGynVSIEcWpxJ01pdUUIs8XZVyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DbjAK8q5Dm9NlzmJd7h9GddT6Axyzs8xTlD19xIrpPu/fEwWKHCBW08DCqDLl6CFp
         q1kdk8vujsgwhzRK6p4wVVa1GVNTRO+Jwnaeeabb8PoUYQYkDqtV04nNVSk6iEMCkS
         o1JPk42oqmPoXOvBakWKryxfeQXZgIx9BBzF9vQ4=
Date:   Fri, 21 Feb 2020 13:02:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Junho <djunho@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        michael.hennerich@analog.com, patrick.vasseur@c-s.fr,
        alexandru.Ardelean@analog.com
Subject: Re: [PATCH v2] dt-bindings: iio: adc: ad7923: Add binding
 documentation for AD7928
Message-ID: <20200221130228.3428c44a@archlinux>
In-Reply-To: <20200218110647.24758-1-djunho@padtec.com.br>
References: <20200218110647.24758-1-djunho@padtec.com.br>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Feb 2020 08:06:47 -0300
Daniel Junho <djunho@gmail.com> wrote:

> From: Daniel Junho <djunho@gmail.com>
> 
> This patch add device tree binding documentation for AD7923 adc in YAML
> format.
> 
> Signed-off-by: Daniel Junho <djunho@gmail.com>

One thing inline. I'll fix up when applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Fix the license header to "GPL-2.0-only OR BSD-2-Clause";
> - Change the Michael Hennerich email.
> 
>  .../bindings/iio/adc/adi,ad7923.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> new file mode 100644
> index 000000000000..e293df9442cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7923.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7923 and similars with 4 and 8 Channel ADCs.
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>"

Some left over quotes at the end of each line..

> +  - Patrick Vasseur <patrick.vasseur@c-s.fr>"
> +
> +description: |
> +  Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
> +   AD7918, AD7928 8 Channels ADCs.
> +
> +  Specifications about the part can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7904_7914_7924.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7908_7918_7928.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7904
> +      - adi,ad7914
> +      - adi,ad7923
> +      - adi,ad7924
> +      - adi,ad7908
> +      - adi,ad7918
> +      - adi,ad7928
> +
> +  reg:
> +    maxItems: 1
> +
> +  refin-supply:
> +    description: |
> +      The regulator supply for ADC reference voltage.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad7928: adc@0 {
> +        compatible = "adi,ad7928";
> +        reg = <0>;
> +        spi-max-frequency = <25000000>;
> +        refin-supply = <&adc_vref>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +      };
> +    };

