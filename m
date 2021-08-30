Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEE3FB428
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhH3K5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235818AbhH3K5v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:57:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5954C610FD;
        Mon, 30 Aug 2021 10:56:55 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:00:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Message-ID: <20210830115954.02fcca60@jic23-huawei>
In-Reply-To: <OSZPR01MB7019F9AF40E5E8626DD0E168AAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20210819132416.175644-1-yangyingliang@huawei.com>
        <OSZPR01MB7019F9AF40E5E8626DD0E168AAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Aug 2021 14:04:15 +0000
Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Hi Yang,
> 
> Thank you for the patch.
> 
> > -----Original Message-----
> > From: Yang Yingliang <yangyingliang@huawei.com>
> > Sent: 19 August 2021 14:24
> > To: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; jic23@kernel.org
> > Subject: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()
> > 
> > Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >   
> With subject line changed to, iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in rzg2l_adc_pm_runtime_resume()
> 
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Patch title updated as suggested and applied to the fixes-togreg branch of iio.git
which will go upstream sometime after rc1.

Thanks,

Jonathan

> 
> Cheers,
> Prabhakar
> 
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c index
> > 9996d5eef289..c38f43ea624f 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -570,8 +570,10 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
> >  		return ret;
> > 
> >  	ret = clk_prepare_enable(adc->adclk);
> > -	if (ret)
> > +	if (ret) {
> > +		clk_disable_unprepare(adc->pclk);
> >  		return ret;
> > +	}
> > 
> >  	rzg2l_adc_pwr(adc, true);
> > 
> > --
> > 2.25.1  
> 

