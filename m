Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118D31B621
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBOJEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 04:04:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33496 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBOJCe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 04:02:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210215090150euoutp029f37c75ab0061a18cf51aef955869698~j4Ex8Ad8a0733007330euoutp02B
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 09:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210215090150euoutp029f37c75ab0061a18cf51aef955869698~j4Ex8Ad8a0733007330euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613379710;
        bh=jiP+nJSjo6L1xm7XfWgPLSvKoUJiuAel4CFXvAa2woc=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=dzEasE+1eWy/VdThwFLq8zPEP5Sz7VVF21r7VSLf+9+28nZHtREpwjRns0L32W9Zg
         fTRICx1QKdMUQ5FWSJODE90BqilY3qTYQpfedHlQkLzlQWgpkWnoAApyMqXNTqPIYk
         PzSScgpL3dw0G/z4pkf5ZHumoykIuWDR8Iqo6YUM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210215090150eucas1p2da724076e50193ec84892f00ef9d05e7~j4ExdTZ171652416524eucas1p2j;
        Mon, 15 Feb 2021 09:01:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.11.44805.D783A206; Mon, 15
        Feb 2021 09:01:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215090149eucas1p1eddfe8bce0f247b4a5bac74fd2878ab4~j4ExDo66B0431904319eucas1p1z;
        Mon, 15 Feb 2021 09:01:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210215090149eusmtrp1583b42eaadcfd89eff5b3f8f571a3985~j4ExC3AaS1787517875eusmtrp1M;
        Mon, 15 Feb 2021 09:01:49 +0000 (GMT)
X-AuditID: cbfec7f4-b4fff7000000af05-5c-602a387d45ee
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.A3.21957.D783A206; Mon, 15
        Feb 2021 09:01:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210215090148eusmtip1f8de62d6d3a9b2533d3510e628949509~j4EwV_jPE0885608856eusmtip1a;
        Mon, 15 Feb 2021 09:01:48 +0000 (GMT)
Subject: Re: [PATCH] dt-bindings: iio: samsung,exynos-adc: add common clock
 properties
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <85ed4a70-5cd8-3bce-100f-33a1fba7f3fa@samsung.com>
Date:   Mon, 15 Feb 2021 10:01:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212163816.70058-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7p1FloJBgfXMllMffiEzWL+kXOs
        Fg+aVjFZnD+/gd1iyeT5rBb3vx5ltNj0+Bqrxbwj71gsLu+aw2Yx4/w+Jovfu46xW7TuPcLu
        wOOxaVUnm8eda3vYPDYvqfdY8uYQq8f55iOMHp83yQWwRXHZpKTmZJalFunbJXBlvPl6nK3g
        Pk/F6jdd7A2Ms7m6GDk5JARMJC5teM7YxcjFISSwglFi97nfLBDOF0aJ4/9ns4NUCQl8ZpT4
        M1cEpqPrZz9Ux3JGiQvrT0M5H4E6unazgVQJC0RIXPvVzQSSEBFYzyxx8tNiFpAEm4ChRNfb
        LqAiDg5eATuJw8vtQMIsAqoSh18sZQKxRQWSJP7+vglm8woISpyc+YQFpJxTwFTi+hFLkDCz
        gLzE9rdzmCFscYlbT+aDrZIQ+MEhsabzOhPEpS4Sj2Z+ZYawhSVeHd/CDmHLSJye3MMC0dDM
        KPHw3Fp2CKeHUeJy0wxGiCpriTvnfoEdyiygKbF+lz5E2FFiVed2sIMkBPgkbrwVhDiCT2LS
        tunMEGFeiY42IYhqNYlZx9fBrT144RJUiYfEq97gCYyKs5A8OQvJZ7OQfDYL4YQFjCyrGMVT
        S4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAlPX6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8VyU0
        EoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzJm1ZEy8kkJ5YkpqdmlqQWgSTZeLglGpg4rDU/SD1
        3WV6usDxty5v5Fem/3h4U23z5mdTkgvkpDfkeG97JnVQ/PAEq/jVCvLXT8jbWbQ5bOySvnY2
        /OjKmSf+fC+84W+Y1/9eXzvlUkHB7kqPRzZmwTncm33rjdmcNfsPLzzHcWzXlMLzNqyJ6mL3
        DlWuMXDIfiWT+3RZVqi5T0T6J7vXhSkrqguFek8y8fDcmqeeIq28yYv7j1lAxdfo3qkfJIQm
        TNz2YkaT2XRpw5mcfxq8JvyTuG23fGN4ljjLomL34ASPgLcuW2K5/ER150pu5IzPmtUbVrio
        b0owX1yW9M9Ak6mpyzYcveAa87Pp7YOP5fc+nQh87n3oh/I//eKFqo+7ZN4EznBXYinOSDTU
        Yi4qTgQAa4Cul8wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7q1FloJBi0n5S2mPnzCZjH/yDlW
        iwdNq5gszp/fwG6xZPJ8Vov7X48yWmx6fI3VYt6RdywWl3fNYbOYcX4fk8XvXcfYLVr3HmF3
        4PHYtKqTzePOtT1sHpuX1HsseXOI1eN88xFGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy3nw9zlZwn6di9Zsu9gbG2VxdjJwcEgIm
        El0/+xm7GLk4hASWMkqc/3CZFSIhI3FyWgOULSzx51oXG0TRe0aJXyePsYAkhAUiJK796mYC
        SYgIrGeWWH9nExNEVQejxJ/XJ5hAqtgEDCW63oK0c3DwCthJHF5uBxJmEVCVOPxiKViJqECS
        xPrpN8FsXgFBiZMzn7CAlHMKmEpcP2IJEmYWMJOYt/khM4QtL7H97RwoW1zi1pP5TBMYBWch
        6Z6FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzLbcd+bt7BOO/VR71D
        jEwcjIcYJTiYlUR4r0poJAjxpiRWVqUW5ccXleakFh9iNAV6ZyKzlGhyPjAx5JXEG5oZmBqa
        mFkamFqaGSuJ826duyZeSCA9sSQ1OzW1ILUIpo+Jg1Oqgak1doe4wd/zMk2PK/cqqyRuNlpd
        3FmzT337ZZWjGz/8NplTW7czmE+O4QTf1wXTLc7eOhE2MSW7ae/Tw7JNq/oZNhRvz2tu6Vo/
        WfCD88xkEce70n6zbPxKeufnseiYFnO1zq7KvJtTu7OLJ6HS7c3Mp91Z2lbnVx+Yn6zyQi+m
        lP2jX8Xumc91/vvfP3/OaZfYp/Rr+znnOWziYb+9cnpieDfTldsbQo9rTLCIOeZy7g7PP76+
        MNPK4G/TZGa75woFiJ6uTX/LtYMzqvOxUbbDng5xdxezeT2eJVUh/aFbpfW33gySrH0cfKH4
        bv689BZZn8yWZu0t65cWndxQ5v/ETdc3+v6FrL8mNpaTlViKMxINtZiLihMBLHHbElQDAAA=
X-CMS-MailID: 20210215090149eucas1p1eddfe8bce0f247b4a5bac74fd2878ab4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7
References: <CGME20210212164148eucas1p2ab09436a82d50161ff1a9fc1a169f7d7@eucas1p2.samsung.com>
        <20210212163816.70058-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

On 12.02.2021 17:38, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (assigned-clocks and similar)
> to fix dtbs_check warnings like:
>
>    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
>      adc@126c0000: assigned-clock-rates: [[6000000]] is not of type 'object'
>    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml:
>      adc@126c0000: assigned-clocks: [[7, 238]] is not of type 'object'

Does it mean that assigned-clocks related properties have to be added to 
almost all bindings? IMHO this is an over-engineering and this has to be 
handled somewhere else...

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   .../bindings/iio/adc/samsung,exynos-adc.yaml         | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index c65921e66dc1..ce03132f8ebc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -27,6 +27,18 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  assigned-clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  assigned-clock-parents:
> +    minItems: 1
> +    maxItems: 3
> +
> +  assigned-clock-rates:
> +    minItems: 1
> +    maxItems: 3
> +
>     clocks:
>       description:
>         Phandle to ADC bus clock. For Exynos3250 additional clock is needed.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

