Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71962A3A5A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 03:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKCCVL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 21:21:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36055 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCCVK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 21:21:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so14641185otm.3;
        Mon, 02 Nov 2020 18:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrqZs+nGGuhMP+TDXRyocDsd9RFfgW9aTEkfoYK22tw=;
        b=pOtU6cWMfDAdl8RYqhk74wjdmmVLAzyYwYTzLgbLfZrIhVLJV71qPdoTCHkUvcP+nE
         WIl1S8LxfBtCDASTWw92xt+z6Kho0Qo9s8srQUYfOqxdR69vEe1Zv2JP48BMnWd2KL2E
         O9KAFQfa4DbO/IMZkuHIw5i5efVXm3Vrh4xInsQkJpDlXINnfM+v2UQi346+GNbdUgep
         057diB0MhchreLcQvnpoVcMPczOilM+2mijKoGObLZy633VT8mBJlGP6b91Nnn0dYMuw
         SZ1EsF3xoXZT4hcMgV21pmrP8svccqUw2lstzAvybRjB2E4NLlgW1OYesG9bfXGEB2lR
         8Hhg==
X-Gm-Message-State: AOAM533k1ZkRBoViSDKbDxZnHz1DPBcIuz9saS7/GVivw2L8chEjae0E
        ZbUzar/7G25bodNV13I/JQ==
X-Google-Smtp-Source: ABdhPJx2iXbr56juZ04sAT9DbvvpUVUg2DuKNV28wbDgK0lhRLZDPyKf8zUNITQghEX6ejAxARoMDg==
X-Received: by 2002:a05:6830:22c9:: with SMTP id q9mr15153829otc.48.1604370069868;
        Mon, 02 Nov 2020 18:21:09 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm79671oic.54.2020.11.02.18.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:21:09 -0800 (PST)
Received: (nullmailer pid 678788 invoked by uid 1000);
        Tue, 03 Nov 2020 02:21:08 -0000
Date:   Mon, 2 Nov 2020 20:21:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml
 conversion
Message-ID: <20201103022108.GA674527@bogus>
References: <20201031134110.724233-1-jic23@kernel.org>
 <20201031134110.724233-17-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031134110.724233-17-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 01:40:57PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly simple conversion with the exception of the XOR between
> spi-cpha and spi-cpol.
> 
> Is there a better way to specify that?
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
> v2:
> * Family typo
> * Put back the reference regulator in example.
> * Added checking of XOR of spi-cpha and spi-cpol
>   (dropped Rob Herrings Reviewed-by due to this change)
>   
>  .../bindings/iio/dac/ti,dac082s085.yaml       | 79 +++++++++++++++++++
>  .../bindings/iio/dac/ti-dac082s085.txt        | 34 --------
>  2 files changed, 79 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> new file mode 100644
> index 000000000000..192b314c99d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC082s085 and similar DACs
> +
> +description:
> +  A family of Texas Instruments 8/10/12-bit 2/4-channel DACs
> +
> +maintainers:
> +  - Lukas Wunner <lukas@wunner.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac082s085
> +      - ti,dac102s085
> +      - ti,dac122s085
> +      - ti,dac084s085
> +      - ti,dac104s085
> +      - ti,dac124s085
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +  spi-cpol:
> +    description:
> +      Should be either spi-cpha, or spi-cpol but not both.
> +
> +  vref-supply:
> +    description: Needed to provide output scaling.
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +allOf:
> +  - $ref: '#/definitions/cpolXORcpha'
> +
> +definitions:
> +  cpolXORcpha:

No need for a definition. Just put the below in the allOf entry.

> +    not:
> +      required: [spi-cpha, spi-cpol]
> +    oneOf:
> +      - required:
> +          - spi-cpha
> +      - required:
> +          - spi-cpol
> +
> +examples:
> +  - |
> +    vref_2v5_reg: regulator-vref {
> +        compatible = "regulator-fixed";
> +        regulator-name = "2v5";
> +        regulator-min-microvolt = <2500000>;
> +        regulator-max-microvolt = <2500000>;
> +        regulator-always-on;
> +    };
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "ti,dac082s085";
> +            reg = <0>;
> +            spi-max-frequency = <40000000>;
> +            spi-cpol;
> +            vref-supply = <&vref_2v5_reg>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> deleted file mode 100644
> index 9cb0e10df704..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Texas Instruments 8/10/12-bit 2/4-channel DAC driver
> -
> -Required properties:
> - - compatible:		Must be one of:
> -			"ti,dac082s085"
> -			"ti,dac102s085"
> -			"ti,dac122s085"
> -			"ti,dac084s085"
> -			"ti,dac104s085"
> -			"ti,dac124s085"
> - - reg: 		Chip select number.
> - - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
> -			either spi-cpha or spi-cpol (but not both).
> - - vref-supply: 	Phandle to the external reference voltage supply.
> -
> -For other required and optional properties of SPI slave nodes please refer to
> -../../spi/spi-bus.txt.
> -
> -Example:
> -	vref_2v5_reg: regulator-vref {
> -		compatible = "regulator-fixed";
> -		regulator-name = "2v5";
> -		regulator-min-microvolt = <2500000>;
> -		regulator-max-microvolt = <2500000>;
> -		regulator-always-on;
> -	};
> -
> -	dac@0 {
> -		compatible = "ti,dac082s085";
> -		reg = <0>;
> -		spi-max-frequency = <40000000>;
> -		spi-cpol;
> -		vref-supply = <&vref_2v5_reg>;
> -	};
> -- 
> 2.28.0
> 
