Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAF3A47E2
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFKRaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhFKRaK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:30:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27407613CF;
        Fri, 11 Jun 2021 17:28:10 +0000 (UTC)
Date:   Fri, 11 Jun 2021 18:30:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] iio: frequency: adf4350: disable reg and clk on
 error in adf4350_probe()
Message-ID: <20210611183005.1d657e36@jic23-huawei>
In-Reply-To: <1ebd111a-a34a-5d3b-a807-db8176bd19c8@huawei.com>
References: <20210601142605.3613605-1-yangyingliang@huawei.com>
        <20210603171822.14376c28@jic23-huawei>
        <1ebd111a-a34a-5d3b-a807-db8176bd19c8@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Jun 2021 09:35:49 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> On 2021/6/4 0:18, Jonathan Cameron wrote:
> > On Tue, 1 Jun 2021 22:26:05 +0800
> > Yang Yingliang <yangyingliang@huawei.com> wrote:
> >  
> >> Disable reg and clk when devm_gpiod_get_optional() fails in adf4350_probe().  
> > Hi.
> >
> > One small thing. It would be useful if you could check if the bug exists other
> > than in next (this one has been their for some time!)  If it does, please
> > don't add the -next in the patch title (as basically it makes me not worry
> > about reading it for a few days :)
> >
> > Also, make sure to cc the author of the patch in the fixes tag
> > +CC Linus  
> OK
> 
> Thanks,
> Yang
Hi Yang,

Change of plan on this one as we are late in the cycle and I don't have
any urgent fixes queued up.  I'm moving over to the togreg branch of iio.git
and lining it up for the current merge window.

Thanks,

Jonathan

> >
> > Obvious enough fix (I hope) that I've applied it to the fixes-togreg branch of
> > iio.git and marked for stable.
> >
> > Thanks,
> >
> > Jonathan
> >  
> >> Fixes:4a89d2f47ccd ("iio: adf4350: Convert to use GPIO descriptor")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> ---
> >>   drivers/iio/frequency/adf4350.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> >> index 1462a6a5bc6d..3d9eba716b69 100644
> >> --- a/drivers/iio/frequency/adf4350.c
> >> +++ b/drivers/iio/frequency/adf4350.c
> >> @@ -563,8 +563,10 @@ static int adf4350_probe(struct spi_device *spi)
> >>   
> >>   	st->lock_detect_gpiod = devm_gpiod_get_optional(&spi->dev, NULL,
> >>   							GPIOD_IN);
> >> -	if (IS_ERR(st->lock_detect_gpiod))
> >> -		return PTR_ERR(st->lock_detect_gpiod);
> >> +	if (IS_ERR(st->lock_detect_gpiod)) {
> >> +		ret = PTR_ERR(st->lock_detect_gpiod);
> >> +		goto error_disable_reg;
> >> +	}
> >>   
> >>   	if (pdata->power_up_frequency) {
> >>   		ret = adf4350_set_freq(st, pdata->power_up_frequency);  
> > .  

