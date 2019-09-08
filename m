Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E30ACCB9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfIHMbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfIHMbg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:31:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD2E2081B;
        Sun,  8 Sep 2019 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945894;
        bh=cj9qbMaSD8MXlVqXVwfmJA/SjgnhVIKx/gTAE+c1dlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t2RRi7mW+3tu/jy1I2SaOW1JzHCOyPqUO5GBsm25WL58hRJ4RhNbW+rD9XJajrJcX
         MqCeQ8v59luoDp+hUTwiTZbriCOiKAp0ylWvanNdXzsSNLIEWzNxiDwu1ri7QDYuqt
         6zyOwYF6aLtfFHe8LUKauJjbZtD+w2UEBUSWs2/I=
Date:   Sun, 8 Sep 2019 13:31:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 11/11] dt-bindings: iio: adc: exynos: Remove old
 requirement of two register address ranges
Message-ID: <20190908133122.7080a124@archlinux>
In-Reply-To: <20190907092007.9946-11-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
        <20190907092007.9946-11-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Sep 2019 11:20:07 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Commit fafb37cfae6d ("iio: exyno-adc: use syscon for PMU
> register access") changed the Exynos ADC driver so the PMU syscon
> phandle is required instead of second register address space.  The
> bindings were not updated so fix them now.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Seems sensible. Thanks for cleaning this up.

As before I'll wait on review from Rob or similar. If they
are going via another path (fine by me as well).

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for
both IIO related binding patches.

Thanks,

Jonathan

> 
> ---
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml     | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index dd58121f25b1..b4c6c26681d9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -25,8 +25,7 @@ properties:
>        - samsung,s5pv210-adc
>  
>    reg:
> -    minItems: 1
> -    maxItems: 2
> +    maxItems: 1
>  
>    clocks:
>      description:
> @@ -55,7 +54,7 @@ properties:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
>      description:
>        Phandle to the PMU system controller node (to access the ADC_PHY
> -      register on Exynos5250/5420/5800/3250).
> +      register on Exynos3250/4x12/5250/5420/5800).
>  
>    has-touchscreen:
>      description:
> @@ -83,19 +82,8 @@ allOf:
>                - samsung,exynos4212-adc
>                - samsung,s5pv210-adc
>      then:
> -      properties:
> -        reg:
> -          items:
> -            # For S5P and Exynos
> -            - description: base registers
> -            - description: phy registers
>        required:
>          - samsung,syscon-phandle
> -    else:
> -      properties:
> -        reg:
> -          items:
> -            - description: base registers
>  
>    - if:
>        properties:

