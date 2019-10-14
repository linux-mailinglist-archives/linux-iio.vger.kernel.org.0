Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BDCD59D9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfJNDUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 23:20:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53301 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfJNDUF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 23:20:05 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191014032001epoutp0202a0ffdf4d07f89c1fb374afd543c9fc~NZUc31lqW3145631456epoutp02e
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2019 03:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191014032001epoutp0202a0ffdf4d07f89c1fb374afd543c9fc~NZUc31lqW3145631456epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571023201;
        bh=ENKwsxPooOWx4gptVxpMHqn1Yk+tYUZ0nYhY0NTtcdA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qfRpIYGLgm5UvPOmL9Iw3UWtttsJV2fTaPWkUpiWrmZDYvyX7zAHf15W3N45+BmEo
         fEgPeWgr8miABCWnjOlRwbwo57ERQ1L0VTrGavwos0Xf5RaE3TcfbWVGMeenoyTAhK
         jYoULZHaBxQfK5pNyyN4Eq+/zecsZEHNE53qI9rc=
Received: from epcpadp1 (unknown [182.195.40.11]) by epcas1p3.samsung.com
        (KnoxPortal) with ESMTP id
        20191014032001epcas1p37b29a7851268037a04bc64250a31b2cc~NZUcp58p90276702767epcas1p3y;
        Mon, 14 Oct 2019 03:20:01 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191014021343epcas1p3a34d546f21007a1a6f73b87792508411~NYakEEAGs1373913739epcas1p3D;
        Mon, 14 Oct 2019 02:13:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191014021343epsmtrp2f0ea5e7afadc487b21cbf32befd69151~NYakDbVkg2918229182epsmtrp2X;
        Mon, 14 Oct 2019 02:13:43 +0000 (GMT)
X-AuditID: b6c32a29-a07ff70000000ff1-ef-5da3d9d7f4e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.26.04081.7D9D3AD5; Mon, 14 Oct 2019 11:13:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191014021343epsmtip2febdaa82f0d782d9f25952082712eb54~NYaj2HdTT1603916039epsmtip2E;
        Mon, 14 Oct 2019 02:13:43 +0000 (GMT)
Subject: Re: [PATCH 1/2] iio: adc: exynos: Drop a stray semicolon
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1019298652.01571023201320.JavaMail.epsvc@epcpadp1>
Date:   Mon, 14 Oct 2019 11:18:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013123524.1821390-1-jic23@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO71m4tjDe7tkLJ4eUjT4kHTKiaL
        VQuvsVnMO/KOxYHFo+XIW1aPTas62Tz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEr48WlNsaC
        HvaK5puJDYzvWLsYOTkkBEwkDr6fC2YLCexmlHg6QQwiLikx7eJR5i5GDiBbWOLw4WKIkreM
        Eg9Wg9nCAo4S7792MILYIgL6ErN29bGA2MwCSRK/Tm8GGskFVN/NKHF+1XE2kASbgJbE/hc3
        wGx+AUWJqz8egzXzCthJtC0+BWazCKhKPDvfww5iiwpESDzffgOqRlDi5MwnYAs4BSwkfi3Z
        wgSxTF3iz7xLzBC2uMStJ/Oh4vISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz23
        2LDAMC+1XK84Mbe4NC9dLzk/dxMjOD60NHcwXl4Sf4hRgINRiYf3RPLiWCHWxLLiytxDjBIc
        zEoivAwTFsQK8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnV
        wMhipf9WxvzgN003Z0Xn2MzY1sbatZu2vMufpZ33IaM70/28uOiOtOi7GqJynmbJ1j/lJec0
        3E2btdH4rxlrQ931mTvEFDbsv/jl9vmHJSabmbfE/SmJvhh9Rr76D2fOrBNM3TO+m/xSmSiq
        nbjh99makOffHFp3tT/3+cHsydO8vF0wzSlZQImlOCPRUIu5qDgRAIlf1lOLAgAA
X-CMS-MailID: 20191014021343epcas1p3a34d546f21007a1a6f73b87792508411
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20191013123734epcas4p138622f17adc5c3baaeba8eb8f4cff1bb
References: <CGME20191013123734epcas4p138622f17adc5c3baaeba8eb8f4cff1bb@epcas4p1.samsung.com>
        <20191013123524.1821390-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 19. 10. 13. 오후 9:35, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Identified by coccinelle
> drivers/iio/adc/exynos_adc.c:654:2-3: Unneeded semicolon
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 42a3ced11fbd..b5a497381452 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -651,7 +651,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  		input_sync(info->input);
>  
>  		usleep_range(1000, 1100);
> -	};
> +	}
>  
>  	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

