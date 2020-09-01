Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDC258C41
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIAKDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 06:03:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgIAKDD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 06:03:03 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 932E950ED5794A3B0F94;
        Tue,  1 Sep 2020 11:03:01 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 11:03:01 +0100
Date:   Tue, 1 Sep 2020 11:01:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jic23@kernel.org>, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] iio: adc: mcp3422: fix locking on error path
Message-ID: <20200901110125.000007cf@Huawei.com>
In-Reply-To: <20200901093218.1500845-1-angelo.compagnucci@gmail.com>
References: <20200901093218.1500845-1-angelo.compagnucci@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 11:32:18 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Reading from the chip should be unlocked on error path else the lock
> could never being released.

We should also reference the fix that we are fixing so I've added
an additional fixes tag below and a reported by tag for Julia.

> 
> Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
Fixes: 3f1093d83d71 ("iio: adc: mcp3422: fix locking scope")
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Greg, this is the fix for the issue Julia reported.

Sorry for the hassle (and messing this up in the first palce), but
could you pick this one up directly into your staging-linus branch.

If you'd prefer a different resolution to the problem let us know.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/mcp3422.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 219adac2384b..da353dcb1e9d 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -143,8 +143,10 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  		config &= ~MCP3422_PGA_MASK;
>  		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
>  		ret = mcp3422_update_config(adc, config);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&adc->lock);
>  			return ret;
> +		}
>  		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
>  	}
>  


