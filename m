Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC6353025
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBUL2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:11:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3328 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUL2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:11:28 -0400
Received: from dggeme711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FBrhL1bsRz14BpQ;
        Sat,  3 Apr 2021 04:08:02 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:11:25 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:11:25 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag
 rather than separate irq_disable()
Thread-Topic: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag
 rather than separate irq_disable()
Thread-Index: AQHXJ/Cv4F8kv4WVL0qYjf39JYoloaqhptGA
Date:   Fri, 2 Apr 2021 20:11:25 +0000
Message-ID: <ad2bfea60efb43ec925b6a7275b2de7a@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-3-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-3-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, April 3, 2021 7:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Krzysztof Kozlowski <krzk@kernel.org>
> Subject: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather
> than separate irq_disable()
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Disabling an irq before the driver has actually atempted to request it
> may work, but is definitely not as clean as just requesting it as
> normal but with the auto enable disabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/adc/exynos_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 784c10deeb1a..8c98d8c9ab1f 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -778,9 +778,9 @@ static int exynos_adc_ts_init(struct exynos_adc *info)
>  		return ret;
>  	}
> 
> -	disable_irq(info->tsirq);
>  	ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,
> -				   IRQF_ONESHOT, "touchscreen", info);
> +				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +				   "touchscreen", info);
>  	if (ret)
>  		input_unregister_device(info->input);
> 
> --
> 2.31.1

