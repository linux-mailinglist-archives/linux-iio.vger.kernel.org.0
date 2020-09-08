Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0587A26210E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIHUZt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 16:25:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44368 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgIHUZs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 16:25:48 -0400
Received: by mail-il1-f193.google.com with SMTP id h11so156057ilj.11;
        Tue, 08 Sep 2020 13:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jY9UdHICeYt7zlT7tUlhe4/kxIL9pAaiTbl/yxvrt4w=;
        b=CSwN3P+Smp5zOYxW7nH+4M9SO2ezArKowt9Tl+AaxbLhIomnL2of55yizPP3reyT11
         aeHUDqAD6dW0RHFHs2T70/igDGqGhobGeM/MbUVqgUoAmXTegvxGevTupFjKXCDeL7Bd
         jDcT4lua3qT0rGMS2+DgsuMnBF3WC0863GeTT0xiUBFS5A3NIIhp/dXAmn0jKsn3PinT
         rXhkow3YY8tlb92AszWegy3ab7LhoW7+1ibEBaAjPRYMzbdKtw/eqdCeifiUaL7raD58
         mIbZTnu0yVa26y8CD1l6PbzDDASjXP0gZJ1kST+bT9dz1mqG9UuESvxhcG/vXfUIkx+5
         qpVA==
X-Gm-Message-State: AOAM533//DovIRVetqTauRKU8dAtAbBEIHq0OTiNPkb3k/X3yHKp7X53
        O9eEoZMyahlbXEMqubeOGQ==
X-Google-Smtp-Source: ABdhPJzXNYzVQL4xww4DrKkNdGx47Rqhrl6WaRwl4ojNtm5QVw7UMlWvDjZnXk6bhRJ281tteQMOiw==
X-Received: by 2002:a05:6e02:13ce:: with SMTP id v14mr527407ilj.79.1599596746781;
        Tue, 08 Sep 2020 13:25:46 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c12sm148132ilm.17.2020.09.08.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:25:46 -0700 (PDT)
Received: (nullmailer pid 850495 invoked by uid 1000);
        Tue, 08 Sep 2020 20:25:45 -0000
Date:   Tue, 8 Sep 2020 14:25:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/25] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
Message-ID: <20200908202544.GB846754@bogus>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-3-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:18PM +0200, Krzysztof Kozlowski wrote:
> The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> screen.  In such case the second interrupt is required.  This second
> interrupt can be anyway provided, even without touch screens.  This
> fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml      | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index cc3c8ea6a894..89b4f9c252a6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -41,7 +41,10 @@ properties:
>      maxItems: 2
>  
>    interrupts:
> -    maxItems: 1
> +    description:
> +      ADC interrupt followed by optional touchscreen interrupt.
> +    minItems: 1
> +    maxItems: 2
>  
>    "#io-channel-cells":
>      const: 1
> @@ -107,6 +110,16 @@ allOf:
>            items:
>              - const: adc
>  
> +  - if:
> +      properties:
> +        has-touchscreen:
> +          true

This evaluates as true if 'has-touchscreen' is not present too. You 
should use 'required' here.

> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2
> +
>  examples:
>    - |
>      adc: adc@12d10000 {
> -- 
> 2.17.1
> 
