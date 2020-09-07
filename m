Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531825FFF6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgIGQmB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:42:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730306AbgIGQj4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:39:56 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5432B9CCF7EE259F5AD4;
        Mon,  7 Sep 2020 17:39:53 +0100 (IST)
Received: from localhost (10.52.124.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 7 Sep 2020
 17:39:52 +0100
Date:   Mon, 7 Sep 2020 17:38:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 02/25] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
Message-ID: <20200907173819.00005a48@Huawei.com>
In-Reply-To: <20200907161141.31034-3-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
        <20200907161141.31034-3-krzk@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.38]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Sep 2020 18:11:18 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> screen.  In such case the second interrupt is required.  This second
> interrupt can be anyway provided, even without touch screens.  This
> fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

Or I can pick this up through the IIO tree if that makes sense.
I doubt anything else will touch this binding this cycle, so either
way works for me.

Jonathan

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
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2
> +
>  examples:
>    - |
>      adc: adc@12d10000 {


