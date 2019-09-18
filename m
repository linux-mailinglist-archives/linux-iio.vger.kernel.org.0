Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A53B635B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfIRMg5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:36:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41169 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRMg5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:36:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id w17so5784798oiw.8;
        Wed, 18 Sep 2019 05:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGvS6AhUHn5wf4afwTlLa7uTvF5Onr61XOQ/Aq65EDw=;
        b=qTUvkhvx0YzDWQob2m2Am5cOXu0qOELP3yBP4mrRnlZMMEM+xC60K3AknmBOXvplyE
         RPWeTFERbp1PRuXBwVKSopP/md8IRUArYuvONXcgigljRiMPGOCPN58PBTHQsruXDV4B
         eZnuTN1NYN5u1XAZNE6Bmg2r8r5pdOZxND9Ij8gKdtHEKbabCY7LJYau6Lf5qRs0tX4d
         W6rs79OVmocBJovwLJPO1d9MFmLq+9fsrkmW4O8x0mIX/49RxL8BMO21cCY4lDJp6P4J
         RnEkg23MKEWiN+h2v86DdCQ8DtVV3YQ4Cyq0CapZUVarg4KMC/acbp5+WpMhKFraLwbj
         Qn/A==
X-Gm-Message-State: APjAAAWhyGk00785u5sPIE7jqLYYJF3RAdlz76v4+DvwMIWVHpQo+Lxl
        uhw6GDwAlP2IrTPPy/RqVw==
X-Google-Smtp-Source: APXvYqwHsTIV2zcgkEiykj1HNn8414Z7SeIjp6LokpIJB26rTRdmqxJN2riKchid6WJKJLxLC/bZ5Q==
X-Received: by 2002:aca:1303:: with SMTP id e3mr1821190oii.6.1568810215772;
        Wed, 18 Sep 2019 05:36:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm1616286otp.49.2019.09.18.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:36:55 -0700 (PDT)
Date:   Wed, 18 Sep 2019 07:36:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 08/11] dt-bindings: arm: samsung: Convert Exynos
 System Registers bindings to json-schema
Message-ID: <20190918123654.GA318@bogus>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907092007.9946-8-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 07, 2019 at 11:20:04AM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos System Registers (SYSREG) bindings to DT schema
> format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Example somehow fails:
> Documentation/devicetree/bindings/arm/samsung/pmu.example.dt.yaml:
> system-controller@10040000: compatible:0: 'samsung,exynos5250-pmu' is
> not one of ['samsung,exynos4-sysreg', 'samsung,exynos5-sysreg']
> 
> It seems that PMU schema is applied to sysreq nodes (and vice-versa).
> ---
>  .../bindings/arm/samsung/sysreg.txt           | 19 -----------
>  .../bindings/arm/samsung/sysreg.yaml          | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt b/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
> deleted file mode 100644
> index 4fced6e9d5e4..000000000000
> --- a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -SAMSUNG S5P/Exynos SoC series System Registers (SYSREG)
> -
> -Properties:
> - - compatible : should contain two values. First value must be one from following list:
> -		- "samsung,exynos4-sysreg" - for Exynos4 based SoCs,
> -		- "samsung,exynos5-sysreg" - for Exynos5 based SoCs.
> -		second value must be always "syscon".
> - - reg : offset and length of the register set.
> -
> -Example:
> -	syscon@10010000 {
> -		compatible = "samsung,exynos4-sysreg", "syscon";
> -		reg = <0x10010000 0x400>;
> -	};
> -
> -	syscon@10050000 {
> -		compatible = "samsung,exynos5-sysreg", "syscon";
> -		reg = <0x10050000 0x5000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> new file mode 100644
> index 000000000000..a3d44646e441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/samsung/sysreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S5P/Exynos SoC series System Registers (SYSREG)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - samsung,exynos4-sysreg
> +          - samsung,exynos5-sysreg
> +      - const: syscon

The problem is this will by default match any node with 'syscon'. You 
have to add a custom 'select' entry. See the LVDS panel bindings for an 
example.

I'd like to kill off 'syscon'...

> +
> +  reg:
> +    maxItems: 1
> +
> +examples:
> +  - |
> +    syscon@10010000 {
> +      compatible = "samsung,exynos4-sysreg", "syscon";
> +      reg = <0x10010000 0x400>;
> +    };
> +
> +    syscon@10050000 {
> +      compatible = "samsung,exynos5-sysreg", "syscon";
> +      reg = <0x10050000 0x5000>;
> +    };
> -- 
> 2.17.1
> 
