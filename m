Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F152A1F24
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgKAPeu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgKAPet (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:34:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C12E206D8;
        Sun,  1 Nov 2020 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604244889;
        bh=UQsIf8GFwl4kaVslPomFKf2DtFdFx3IH16pt4zhUhac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zMRKSbKUpkqBBgZVawdbTDRoeSpvmRXcBEj6F3vpER+NV2SIFjdhmcrm7tFjW54SJ
         hiX6v0zQ7UFfkN4ScSsfHz2h+ExlqB3F5QRAtqFBIIeObISAhiG4X4eoiUV//svDqn
         TM3blzDTiU1QFr1mq/oJp1U+LVvNpiRuE+hno1Oc=
Date:   Sun, 1 Nov 2020 15:34:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v7 1/3] dt-bindings: iio: adc: add bindings doc for
 MT6360 ADC
Message-ID: <20201101153443.3826103e@archlinux>
In-Reply-To: <1603181267-15610-2-git-send-email-gene.chen.richtek@gmail.com>
References: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com>
        <1603181267-15610-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Oct 2020 16:07:45 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> This change adds the binding doc for the MT6360 ADC.

One thing I'd previously missed below.

Jonathan

> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/iio/adc/mediatek,mt6360-adc.yaml      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
> new file mode 100644
> index 0000000..a7350ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6360-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6360 and similar ADCs
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  Family of simple ADCs with i2c interface and internal references.

That seems unlikely...

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
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +      compatible = "mediatek,mt6360-adc";
> +      #io-channel-cells = <1>;
> +    };
> +...

