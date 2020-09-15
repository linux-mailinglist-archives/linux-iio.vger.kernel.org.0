Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6326AD36
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIOTMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:12:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40917 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgIOTLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:11:04 -0400
Received: by mail-io1-f66.google.com with SMTP id j2so5347700ioj.7;
        Tue, 15 Sep 2020 12:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tG4zkFtCOYywSVQ2L0xObA/8Rcurg09++51ndj1PBNg=;
        b=emC/97Isrxkt5v3JSq4TljfehE9v7LLHz5pchUrZwC0nZY4lzh2skr5Y1jO0O9cM8O
         TtTrp4Ci7e6iZoHfPaiXjpoJ7P6gWPysvYACAJ7MOJLa7IS0AsJ7Jlm+UrUAMhcji3TB
         ayBi2JIzrsXy74RFM7tHInbX9GdeeWTyBH8v16nAj0kB8JFAI6u/YNmzPFUmeW47B4GV
         bTRfFubNvECzLPaIOkm5UKbErcat51f5Du9hg7KTpi6nsrsuxWc67SU9o9mu46B4h0nl
         rMn/fGSJn4dq8CT9eixY+NPXCZ35d+nkUN/yf/LQ+KVGdVHj/6FiDdZdZ6xfPHt8D1Ul
         Tcvg==
X-Gm-Message-State: AOAM531RHB0FsUHHm2iWgkeEzu/cS685OQ6bABR2ZOu5jnuKVFNq4yBh
        r6IStf8iW8V1pe3PN/hInA==
X-Google-Smtp-Source: ABdhPJyQvhtlhNMHHZzorRipaObA1Du3fi7371SvdKhXmkL40jSaLnRzeHyCr7cfvLPgGzZDuZ15uA==
X-Received: by 2002:a05:6638:210f:: with SMTP id n15mr17916340jaj.41.1600197064005;
        Tue, 15 Sep 2020 12:11:04 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o8sm9634128ilb.64.2020.09.15.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:11:03 -0700 (PDT)
Received: (nullmailer pid 2329817 invoked by uid 1000);
        Tue, 15 Sep 2020 19:11:01 -0000
Date:   Tue, 15 Sep 2020 13:11:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 11/20] dt-bindings:iio:adc:motorola,cpcap-adc yaml
 conversion
Message-ID: <20200915191101.GA2327664@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-12-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:37PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Conversion from txt to yaml.
> Slightly expanded example to give a bit more context.
> Description lifted from the original driver commit.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/iio/adc/cpcap-adc.txt | 17 -------
>  .../bindings/iio/adc/motorola,cpcap-adc.yaml  | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> deleted file mode 100644
> index ec04008e8f4f..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Motorola CPCAP PMIC ADC binding
> -
> -Required properties:
> -- compatible: Should be "motorola,cpcap-adc" or "motorola,mapphone-cpcap-adc"
> -- interrupts: The interrupt number for the ADC device
> -- interrupt-names: Should be "adcdone"
> -- #io-channel-cells: Number of cells in an IIO specifier
> -
> -Example:
> -
> -cpcap_adc: adc {
> -	compatible = "motorola,mapphone-cpcap-adc";
> -	interrupt-parent = <&cpcap>;
> -	interrupts = <8 IRQ_TYPE_NONE>;
> -	interrupt-names = "adcdone";
> -	#io-channel-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> new file mode 100644
> index 000000000000..7811c0abd5d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/motorola,cpcap-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC ADC binding
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description:
> +  On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
> +  has ADCs that are used for battery charging and USB PHY VBUS and ID pin
> +  detection.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorola,cpcap-adc
> +      - motorola,mapphone-cpcap-adc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: adcdone
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#io-channel-cells"

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
