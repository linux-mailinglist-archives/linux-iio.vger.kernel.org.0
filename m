Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2511D62AC
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEPQiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEPQiA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:38:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98535206D4;
        Sat, 16 May 2020 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589647080;
        bh=pbJEkTsR5rZqT6w3UvXcgntFessnxR6qlEIS6uOhmmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kY50VS7EwjdDATTzjCFc6sF9nBArlTI/SFSWXia74Y9iHa2Gxz0Zr0Jk+tqspo0TK
         J9KB0jTDaRbI9YTxoyVJoYVY390OrgGd2LxGCMlzygLgY3nfkBaxIe1pW0SDf+wYmY
         PXe00W/UTwuPNLRV7QOyyX3e97wd6p4o+BZYVcBM=
Date:   Sat, 16 May 2020 17:37:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Alim Akhtar" <alim.akhtar@samsung.com>
Cc:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Hartmut Knaack'" <knaack.h@gmx.de>,
        "'Lars-Peter Clausen'" <lars@metafoo.de>,
        "'Peter Meerwald-Stadler'" <pmeerw@pmeerw.net>,
        "'Kukjin Kim'" <kgene@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: exynos: Simplify Exynos7-specific init
Message-ID: <20200516173755.2b759618@archlinux>
In-Reply-To: <037501d627b8$56f06870$04d13950$@samsung.com>
References: <CGME20200511083406epcas5p18e835634e60f362dc408d73886aa5563@epcas5p1.samsung.com>
        <20200511083348.7577-1-krzk@kernel.org>
        <037501d627b8$56f06870$04d13950$@samsung.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 22:49:28 +0530
"Alim Akhtar" <alim.akhtar@samsung.com> wrote:

> Hello Krzysztof,
> Thanks for the patch.
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 11 May 2020 14:04
> > To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack
> > <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-
> > Stadler <pmeerw@pmeerw.net>; Kukjin Kim <kgene@kernel.org>; Krzysztof
> > Kozlowski <krzk@kernel.org>; linux-iio@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Alim Akhtar <alim.akhtar@samsung.com>
> > Subject: [PATCH] iio: adc: exynos: Simplify Exynos7-specific init
> > 
> > The Exynos7-specific code bits in ADC driver do not play with PHY:
> > the field exynos_adc_data.needs_adc_phy is not set in exynos7_adc_data
> > instance.  Therefore the initialization code does not have to check if it  
> is true.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >   
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Tested on exynos7-espresso board so,
> Tested-by:  Alim Akhtar <alim.akhtar@samsung.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > ---
> > 
> > Only build tested.
> > ---
> >  drivers/iio/adc/exynos_adc.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c  
> index
> > 22131a677445..219c8eb32d16 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -449,9 +449,6 @@ static void exynos_adc_exynos7_init_hw(struct
> > exynos_adc *info)  {
> >  	u32 con1, con2;
> > 
> > -	if (info->data->needs_adc_phy)
> > -		regmap_write(info->pmu_map, info->data->phy_offset, 1);
> > -
> >  	con1 = ADC_V2_CON1_SOFT_RESET;
> >  	writel(con1, ADC_V2_CON1(info->regs));
> > 
> > --
> > 2.17.1  
> 
> 

