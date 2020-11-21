Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD962BC096
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKUQj0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:39:26 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59546 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgKUQj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 11:39:26 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 44EAF9E0076;
        Sat, 21 Nov 2020 16:39:21 +0000 (GMT)
Date:   Sat, 21 Nov 2020 16:39:19 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
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
Message-ID: <20201121163919.2fcb9e71@archlinux>
In-Reply-To: <20201108154128.57f4162f@archlinux>
References: <20201103120743.110662-1-miaoqinglang@huawei.com>
        <20201108154128.57f4162f@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Nov 2020 15:41:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 3 Nov 2020 20:07:43 +0800
> Qinglang Miao <miaoqinglang@huawei.com> wrote:
> 
> > Fix the missing clk_disable_unprepare() of info->pclk
> > before return from rockchip_saradc_resume in the error
> > handling case when fails to prepare and enable info->clk.
> > 
> > Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> > Suggested-by:Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>  
> 
> Looks good to me.  I'll just give it a little longer on the list so Heiko
> and others have a chance to sanity check it.
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> > v2: remove useless braces because early return is pointless.
> > 
> >  drivers/iio/adc/rockchip_saradc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> > index 1f3d7d639..12584f163 100644
> > --- a/drivers/iio/adc/rockchip_saradc.c
> > +++ b/drivers/iio/adc/rockchip_saradc.c
> > @@ -462,7 +462,7 @@ static int rockchip_saradc_resume(struct device *dev)
> >  
> >  	ret = clk_prepare_enable(info->clk);
> >  	if (ret)
> > -		return ret;
> > +		clk_disable_unprepare(info->pclk);
> >  
> >  	return ret;
> >  }  
> 

