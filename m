Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA4D59D8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 05:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfJNDUE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 23:20:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39251 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfJNDUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 23:20:04 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191014032001epoutp03a79a24599b283c57992d1af46997b9f5~NZUdCoHUx1541915419epoutp03B
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2019 03:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191014032001epoutp03a79a24599b283c57992d1af46997b9f5~NZUdCoHUx1541915419epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571023201;
        bh=guWS73Xar8HrjOhdAuUg5qMF9KtOPGrAFQr+eZu123w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kHf1z21SEMTSoHVUhfuJPjezdCCYhXZc/4P9jQAxlS9QFi3VQtg8UX/fMO9mndvJY
         ytwO44Fk5xjjlbHAf8VJk1+p8d9/i28xugsinC1xvCwpSNrefCxAGOgLB9xcH0+v1D
         DbyM4k4idSu/CSLdu9Z4IB3mVh3CAD0LgXorX1gU=
Received: from epcpadp1 (unknown [182.195.40.11]) by epcas1p1.samsung.com
        (KnoxPortal) with ESMTP id
        20191014032001epcas1p1b663eff06797338f25ab303df84bebac~NZUc1ptEE2920029200epcas1p1v;
        Mon, 14 Oct 2019 03:20:01 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191014021357epcas1p17a3bd51b9d9521b97fb8614b75d8c5c7~NYaxaexDL0064300643epcas1p1I;
        Mon, 14 Oct 2019 02:13:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191014021357epsmtrp2069ac3055c2d843ed19e18a846801676~NYaxZzNsJ2918229182epsmtrp2d;
        Mon, 14 Oct 2019 02:13:57 +0000 (GMT)
X-AuditID: b6c32a29-9efff70000000ff1-0c-5da3d9e5bccf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.36.04081.5E9D3AD5; Mon, 14 Oct 2019 11:13:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191014021357epsmtip2d937e376bbee24f435118f49c8e754ca~NYaxKsU9W1233812338epsmtip2U;
        Mon, 14 Oct 2019 02:13:57 +0000 (GMT)
Subject: Re: [PATCH 2/2] iio: adc: exynos: use
 devm_platform_ioremap_resource
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <857068247.21571023201523.JavaMail.epsvc@epcpadp1>
Date:   Mon, 14 Oct 2019 11:18:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013123524.1821390-2-jic23@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvO7Tm4tjDW7sMrJ4eUjT4kHTKiaL
        VQuvsVnMO/KOxYHFo+XIW1aPTas62Tz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEr49vJT4wF
        a7krnnReYmlg3MLZxcjJISFgIrH9fT9zFyMXh5DAbkaJSW/WM0EkJCWmXTwKlOAAsoUlDh8u
        hqh5yyhxf0kXC0iNsICvxN6HL8DqRQT0JWbt6gOLMwskSfw6vZkVomEno8TSM2cZQRJsAloS
        +1/cYAOx+QUUJa7+eAwW5xWwk/i5+zc7iM0ioCrxe80/sKGiAhESz7ffgKoRlDg58wnYAk4B
        C4m/j5+yQyxTl/gz7xIzhC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqm
        FhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4mW5g7Gy0viDzEKcDAq8fCeSF4cK8SaWFZc
        mXuIUYKDWUmEl2HCglgh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbB
        ZJk4OKUaGJsW/3+dofrtWGdus7Ol1/relJ3GImfVA4qvulrwaSzs3SM7L8i1zLr89F3dDsGa
        bskWo2/7PNndw7IWrWbh1LSY8H230cTVBYcMlFXFVvrt0OJ6vTI8b9eHG7Oe2+RODMiwS5Ny
        mPvwUdg1FY076eXiegL3lFw//65Su1QQ/UNmp3fES/8qJZbijERDLeai4kQAblYek44CAAA=
X-CMS-MailID: 20191014021357epcas1p17a3bd51b9d9521b97fb8614b75d8c5c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20191013123734epcas2p28874e87fe8c104bc550f642200ce382b
References: <20191013123524.1821390-1-jic23@kernel.org>
        <CGME20191013123734epcas2p28874e87fe8c104bc550f642200ce382b@epcas2p2.samsung.com>
        <20191013123524.1821390-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 19. 10. 13. 오후 9:35, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reduce local boilerplate.
> Identified by coccinelle
> drivers/iio/adc/exynos_adc.c:792:1-11: WARNING: Use devm_platform_ioremap_resource for info -> regs
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index b5a497381452..2df7d057b249 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -769,7 +769,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
>  	struct iio_dev *indio_dev = NULL;
> -	struct resource	*mem;
>  	bool has_ts = false;
>  	int ret = -ENODEV;
>  	int irq;
> @@ -788,8 +787,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	info->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

