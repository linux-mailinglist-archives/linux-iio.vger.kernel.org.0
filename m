Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62725FFEE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgIGQlX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:41:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730672AbgIGQlR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:41:17 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AF5932BF7D43679AE781;
        Mon,  7 Sep 2020 17:41:15 +0100 (IST)
Received: from localhost (10.52.124.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 7 Sep 2020
 17:41:15 +0100
Date:   Mon, 7 Sep 2020 17:39:41 +0100
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
Subject: Re: [PATCH 03/25] dt-bindings: iio: adc: exynos-adc: do not require
 syscon on S5Pv210
Message-ID: <20200907173941.000054ed@Huawei.com>
In-Reply-To: <20200907161141.31034-4-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
        <20200907161141.31034-4-krzk@kernel.org>
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

On Mon,  7 Sep 2020 18:11:19 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The ADC in S5Pv210 does not have ADC phy registers in separate block for
> which syscon would be needed.  Remove this requirement to fix dtbs_check
> warnings like:
> 
>   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 89b4f9c252a6..75174af72288 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -81,7 +81,6 @@ allOf:
>                - samsung,exynos-adc-v2
>                - samsung,exynos3250-adc
>                - samsung,exynos4212-adc
> -              - samsung,s5pv210-adc
>      then:
>        required:
>          - samsung,syscon-phandle


