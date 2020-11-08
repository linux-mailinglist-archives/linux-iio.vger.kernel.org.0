Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9832AABF7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgKHPle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKHPle (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:41:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBEC206ED;
        Sun,  8 Nov 2020 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604850093;
        bh=Ro0XFlRfJTxsmdUsm+VsUuYHfoz4ChDTnZqn6A2mBCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a1b7mIEmiDKom1i3FfZH1EVwV11OCSXeE0soCh2G3P8PGWCvIHVZMi0yfXvajA/Mg
         kuCeEFjysVB/RasYm7Lw6qC+ERq59s2Nfl1fZM6Hi+hsk1NlSM/uNXt4QChYPn6b4D
         IRjdwhtdGkADNnqSjA6f2Rt8wdsCERmh9riR07rY=
Date:   Sun, 8 Nov 2020 15:41:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: fix missing
 clk_disable_unprepare() on error in rockchip_saradc_resume
Message-ID: <20201108154128.57f4162f@archlinux>
In-Reply-To: <20201103120743.110662-1-miaoqinglang@huawei.com>
References: <20201103120743.110662-1-miaoqinglang@huawei.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 20:07:43 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Fix the missing clk_disable_unprepare() of info->pclk
> before return from rockchip_saradc_resume in the error
> handling case when fails to prepare and enable info->clk.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Suggested-by:Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Looks good to me.  I'll just give it a little longer on the list so Heiko
and others have a chance to sanity check it.

Thanks,

Jonathan

> ---
> v2: remove useless braces because early return is pointless.
> 
>  drivers/iio/adc/rockchip_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f3d7d639..12584f163 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -462,7 +462,7 @@ static int rockchip_saradc_resume(struct device *dev)
>  
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret)
> -		return ret;
> +		clk_disable_unprepare(info->pclk);
>  
>  	return ret;
>  }

