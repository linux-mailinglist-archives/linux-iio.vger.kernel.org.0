Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9C42596B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbhJGR2p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242457AbhJGR2o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:28:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8BF6056B;
        Thu,  7 Oct 2021 17:26:48 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:30:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: st_lsm9ds0: Make use of the helper function
 dev_err_probe()
Message-ID: <20211007183052.66be899b@jic23-huawei>
In-Reply-To: <20210929180638.6ddb313b@jic23-huawei>
References: <20210928014055.1431-1-caihuoqing@baidu.com>
        <20210928014055.1431-2-caihuoqing@baidu.com>
        <20210929180638.6ddb313b@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Sep 2021 18:06:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 28 Sep 2021 09:40:54 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > When possible use dev_err_probe help to properly deal with the
> > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > in the devices_deferred debugfs file.
> > Using dev_err_probe() can reduce code size, and the error value
> > gets printed.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>  

+CC Andy who wrote this particular driver.

Change looks simple enough I'll apply it though and at least get 0-day building it.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
work it's magic,

Thanks,

Jonathan


> 
> Hi Cai,
> 
> Picking a random patch to reply to...
> 
> Thanks for your hard work on these.  The ones I haven't replied to look
> fine to me.   It might have been slightly better to slow down your initial
> submission of these as then we could perhaps have avoided 2-3 versions
> of every patch by identifying shared elements to improve in a smaller set.
> Still that's the benefit of hindsight!
> 
> I'll not apply these quite yet so as to allow time for driver maintainers
> and others to take a look.
> 
> If you could tidy up those few minor comments I have that would be great.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
> > index b3a43a3b04ff..9fb06b7cde3c 100644
> > --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
> > +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
> > @@ -24,10 +24,10 @@ static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds
> >  
> >  	/* Regulators not mandatory, but if requested we should enable them. */
> >  	lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
> > -	if (IS_ERR(lsm9ds0->vdd)) {
> > -		dev_err(dev, "unable to get Vdd supply\n");
> > -		return PTR_ERR(lsm9ds0->vdd);
> > -	}
> > +	if (IS_ERR(lsm9ds0->vdd))
> > +		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd),
> > +				     "unable to get Vdd supply\n");
> > +
> >  	ret = regulator_enable(lsm9ds0->vdd);
> >  	if (ret) {
> >  		dev_warn(dev, "Failed to enable specified Vdd supply\n");
> > @@ -36,9 +36,9 @@ static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds
> >  
> >  	lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
> >  	if (IS_ERR(lsm9ds0->vdd_io)) {
> > -		dev_err(dev, "unable to get Vdd_IO supply\n");
> >  		regulator_disable(lsm9ds0->vdd);
> > -		return PTR_ERR(lsm9ds0->vdd_io);
> > +		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd_io),
> > +				     "unable to get Vdd_IO supply\n");
> >  	}
> >  	ret = regulator_enable(lsm9ds0->vdd_io);
> >  	if (ret) {  
> 

