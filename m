Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6246000F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbhK0QKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346831AbhK0QIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:08:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A85C061574;
        Sat, 27 Nov 2021 08:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1309BB82A02;
        Sat, 27 Nov 2021 16:05:31 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 61591C53FBF;
        Sat, 27 Nov 2021 16:05:25 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:10:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2] iio: adc: stm32: fix null pointer on defer_probe
 error
Message-ID: <20211127161026.2e725d5a@jic23-huawei>
In-Reply-To: <20211122144501.000014a3@Huawei.com>
References: <20211122143809.2332-1-olivier.moysan@foss.st.com>
        <2ca4ad17-d7e5-f4be-1596-7c7de0fa5661@pengutronix.de>
        <20211122144501.000014a3@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 14:45:01 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 22 Nov 2021 15:41:10 +0100
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
> > On 22.11.21 15:38, Olivier Moysan wrote:  
> > > dev_err_probe() calls __device_set_deferred_probe_reason()
> > > on -EPROBE_DEFER error. If device pointer to driver core
> > > private structure is not initialized, an null pointer error occurs.
> > > This pointer is set on iio_device_register() call for iio device.
> > > 
> > > dev_err_probe() must be called with the device which is probing.
> > > Replace iio device by its parent device.
> > > 
> > > Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> > >   
> 
> I'll fix it when applying, but no blank line between Fixes tag and the others.
Applied to the fixes-togreg branch of iio.git.

I'll probably do a pull request later this week,

Jonathan

> 
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>    
> > 
> > Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >   
> > > ---
> > > Changes in v2:
> > > - Use parent device from indio_dev instead of private structure
> > > ---
> > >  drivers/iio/adc/stm32-adc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > > index 7f1fb36c747c..341afdd342cc 100644
> > > --- a/drivers/iio/adc/stm32-adc.c
> > > +++ b/drivers/iio/adc/stm32-adc.c
> > > @@ -1986,7 +1986,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
> > >  			/* Get calibration data for vrefint channel */
> > >  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> > >  			if (ret && ret != -ENOENT) {
> > > -				return dev_err_probe(&indio_dev->dev, ret,
> > > +				return dev_err_probe(indio_dev->dev.parent, ret,
> > >  						     "nvmem access error\n");
> > >  			}
> > >  			if (ret == -ENOENT)
> > >     
> > 
> >   
> 

