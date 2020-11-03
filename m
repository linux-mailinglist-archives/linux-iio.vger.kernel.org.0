Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49462A43C5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgKCLLi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 06:11:38 -0500
Received: from foss.arm.com ([217.140.110.172]:46794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCLLh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 06:11:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BA75101E;
        Tue,  3 Nov 2020 03:11:37 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3AE3F66E;
        Tue,  3 Nov 2020 03:11:35 -0800 (PST)
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: fix missing
 clk_disable_unprepare() on error in rockchip_saradc_resume
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-iio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201103074909.195465-1-miaoqinglang@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <50da9bf1-7317-b24b-9a87-e9dfb4e4a694@arm.com>
Date:   Tue, 3 Nov 2020 11:11:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103074909.195465-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-11-03 07:49, Qinglang Miao wrote:
> Fix the missing clk_disable_unprepare() of info->pclk
> before return from rockchip_saradc_resume in the error
> handling case when fails to prepare and enable info->clk.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f3d7d639..5eb566274 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -461,9 +461,10 @@ static int rockchip_saradc_resume(struct device *dev)
>   		return ret;
>   
>   	ret = clk_prepare_enable(info->clk);
> -	if (ret)
> +	if (ret) {
> +		clk_disable_unprepare(info->pclk);
>   		return ret;

No need to add braces, just replace this utterly pointless "early" return ;)

Robin.

> -
> +	}
>   	return ret;
>   }
>   #endif
> 
