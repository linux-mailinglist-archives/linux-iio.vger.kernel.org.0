Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9887035302F
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDBUO6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:14:58 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3329 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUO6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:14:58 -0400
Received: from dggeme761-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FBrmN19YYz14BpQ;
        Sat,  3 Apr 2021 04:11:32 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme761-chm.china.huawei.com (10.3.19.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:14:04 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:14:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq
 request then disable
Thread-Topic: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq
 request then disable
Thread-Index: AQHXJ/CzrOEYtRwmREKmm2yEgWF0hKqhp4mQ
Date:   Fri, 2 Apr 2021 20:14:04 +0000
Message-ID: <6bc3945795144f739f55a7cb817b89c9@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-6-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-6-jic23@kernel.org>
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
> <jonathan.cameron@huawei.com>; Tomasz Duszynski
> <tomasz.duszynski@octakon.com>
> Subject: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request
> then disable
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new flag cleanly avoids the need for a dance where we request the
> interrupt only to immediately disabling it by ensuring it is not
> auto-enabled in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

>  drivers/iio/chemical/scd30_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c
> b/drivers/iio/chemical/scd30_core.c
> index 261c277ac4a5..d89f117dd0ef 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -655,19 +655,19 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> 
>  	indio_dev->trig = iio_trigger_get(trig);
> 
> +	/*
> +	 * Interrupt is enabled just before taking a fresh measurement
> +	 * and disabled afterwards. This means we need to ensure it is not
> +	 * enabled here to keep calls to enable/disable balanced.
> +	 */
>  	ret = devm_request_threaded_irq(dev, state->irq, scd30_irq_handler,
> -					scd30_irq_thread_handler, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					scd30_irq_thread_handler,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> +					IRQF_NO_AUTOEN,
>  					indio_dev->name, indio_dev);
>  	if (ret)
>  		dev_err(dev, "failed to request irq\n");
> 
> -	/*
> -	 * Interrupt is enabled just before taking a fresh measurement
> -	 * and disabled afterwards. This means we need to disable it here
> -	 * to keep calls to enable/disable balanced.
> -	 */
> -	disable_irq(state->irq);
> -
>  	return ret;
>  }
> 
> --
> 2.31.1

