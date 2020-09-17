Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53F026E281
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIQRdp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIQRd2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 13:33:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F6020725;
        Thu, 17 Sep 2020 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600364008;
        bh=wNoTCGcfcB/3veX9mEs1zGpPBnfxajFdOgvN0afMW7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQwRuDux4teckfNDKQ3XeTDN+ueiBL9tB+it3+a1Qg22UTK6i5b/CCinsmV4ZL/Bl
         TkpcMJnMm40OKktvu/LZSVx9xyxhyNdN1K4dNoS9qO7g19sG9BWch8y8DaJwxS8BFm
         QA/X58JzpxNkXVYNohgO3bAyf1vnxnH/P07dLSKI=
Date:   Thu, 17 Sep 2020 18:33:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add bindings doc for
 MT6360 ADC
Message-ID: <20200917183322.25fa2aea@archlinux>
In-Reply-To: <1600191369-28040-2-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600191369-28040-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 01:36:07 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> This change adds the binding doc for the MT6360 ADC.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
Hi Gene

A few things inline I missed before.  Ideally this wants
a device-tree ack which it isn't likely to get without
cc'ing the binding Maintainers. I've added Rob and the list.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/mediatek,mt6360.yaml          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml
> new file mode 100644
> index 0000000..2fa2fe7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6360.yaml#

I think this should probably match the compatible as should the file name.
(sorry missed this on previous review!)

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6360 and similar ADCs
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  Family of simple ADCs with i2c interface and internal references.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6360-adc
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"
As it's fresh in my mind from forgetting it myself, can we
add

additionalProperties: false

?


> +
> +examples:
> +  - |
> +    adc {
> +      compatible = "mediatek,mt6360-adc";
> +      #io-channel-cells = <1>;
> +    };
> +...

