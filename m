Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE73141CF59
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 00:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbhI2Wpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 18:45:40 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42782 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2Wpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 18:45:40 -0400
Received: by mail-oi1-f179.google.com with SMTP id x124so4846165oix.9;
        Wed, 29 Sep 2021 15:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T8APqhpdvdjHTLThoNtJxr2heTVR3fvx1c+V3RxbGck=;
        b=J4LWuI9DSt+1AMzYhJAt1j2+wa2R3VI0p1lKo+GQ+ai4b8VSEG8UBMS/bfmY7LL9CH
         ODFJbMMJnZIzEmgvhTzBps8gEo5BDhMkRJa6kyueKftVLdrGMYyc2lXLYWPwQ0bz4glC
         02VUVIGY/nN5Vn+w6YpD9S5T/iG2osuF1sKyJJ+gMLl4XUsPBq1t5e3ZziLyDMnXpMq6
         HxyADei+1ssqBL4iygr4+2Z2jo8lxQqCkMdoK+JLwA5SYXF/JlfZmtN/RUhi9jKTAI/k
         nLSTxw2nANDXaFXdS9AyqCTePBJGi9vtALK0n5FvmzrCA+j11oAjYNeyEAu2Tp/QrqDk
         IwOA==
X-Gm-Message-State: AOAM533NCuDcfIMdYt777ICQ1Tjx6yAeO9+mSJ9iwPg4typ8pRCzisMc
        GmAkg7DbacMu3Ysj0yFElw==
X-Google-Smtp-Source: ABdhPJwwPxNzNLpiGomj6KTstkT9hjABrI0VCrhl7CURyVw3lhsS6xNgluVA4oyLsdemsTydrZ7Zww==
X-Received: by 2002:a05:6808:187:: with SMTP id w7mr68956oic.140.1632955438083;
        Wed, 29 Sep 2021 15:43:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w23sm245173ooj.19.2021.09.29.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:43:57 -0700 (PDT)
Received: (nullmailer pid 364176 invoked by uid 1000);
        Wed, 29 Sep 2021 22:43:56 -0000
Date:   Wed, 29 Sep 2021 17:43:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        Jonathan.Cameron@huawei.com, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: ad779x: Add binding document
Message-ID: <YVTsLDrAFbHyZTBQ@robh.at.kernel.org>
References: <20210929104607.2699117-1-florian.boor@kernelconcepts.de>
 <20210929104607.2699117-2-florian.boor@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929104607.2699117-2-florian.boor@kernelconcepts.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 29, 2021 at 12:46:07PM +0200, Florian Boor wrote:
> New binding documentation for AD799x series of I²C ADC ICs.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
> ---
> Changes in v5:
> - Correct errors in documentation found by
>   'make DT_CHECKER_FLAGS=-m dt_binding_check'
>   + Reduce title length
>   + Move information to description
>   + Add I²C bits to example
> 
>  .../bindings/iio/adc/adi,ad799x.yaml          | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> new file mode 100644
> index 000000000000..cdba1ea91f42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad799x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD799x analog to digital converters
> +
> +maintainers:
> +  - Michael Hennerich, Analog Devices Inc. <Michael.Hennerich@analog.com>

I think the ',' here will throw off email parsing. Drop the Analog 
Devices.

> +
> +description: |
> +    Support for Analog Devices AD7991, AD7992, AD7993, AD7994, AD7995, AD7997, AD7998,
> +    AD7999 and similar analog to digital converters.
> +    Specifications on the converters can be found at:
> +    AD7991, AD7995, AD7999:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7991_7995_7999.pdf
> +    AD7992:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7992.pdf
> +    AD7993, AD7994:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7993_7994.pdf
> +    AD7997, AD7998:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7997_7998.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7991
> +      - adi,ad7992
> +      - adi,ad7993
> +      - adi,ad7994
> +      - adi,ad7995
> +      - adi,ad7997
> +      - adi,ad7998
> +      - adi,ad7999
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      ADC power supply
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply, optional for AD7991, AD7995 and AD7999
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
> +       adc1: ad7991@28 {

adc@28

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +               reg = <0x28>;
> +               compatible = "adi,ad7991";
> +               interrupts = <13 2>;
> +               interrupt-parent = <&gpio6>;
> +
> +               vcc-supply = <&vcc_3v3>;
> +               vref-supply = <&adc_vref>;
> +        };
> +    };
> +...
> -- 
> 2.30.2
> 
> 
