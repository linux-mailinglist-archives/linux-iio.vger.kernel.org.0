Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D7456203
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhKRSOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 13:14:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4109 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhKRSOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 13:14:09 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hw7BP5mSyz67HxV;
        Fri, 19 Nov 2021 02:10:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 18 Nov 2021 19:11:06 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 18:11:06 +0000
Date:   Thu, 18 Nov 2021 18:11:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Wan Jiabing" <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix null pointer on defer_probe error
Message-ID: <20211118181103.000054c7@Huawei.com>
In-Reply-To: <45a5129a-c0b1-4a07-aef8-d6e0845c7b1a@pengutronix.de>
References: <20211118123952.15383-1-olivier.moysan@foss.st.com>
        <45a5129a-c0b1-4a07-aef8-d6e0845c7b1a@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Nov 2021 13:51:44 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Hello Olivier,
> 
> On 18.11.21 13:39, Olivier Moysan wrote:
> > dev_err_probe() calls __device_set_deferred_probe_reason()
> > on -EPROBE_DEFER error.
> > If device pointer to driver core private structure is not initialized,
> > a null pointer error occurs.
> > This pointer is set too late on iio_device_register() call, for iio device.  
> 
> Even if it were set earlier, you should call dev_err_probe with the dev of
> the probe that's currently running. Not any other devices you created since
> then.

+1 on that

> 
> > So use parent device instead for dev_err_probe() call.
> > 
> > Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> > 

No line break between these two tags.  Greg will reject a pull if there
is one (and 0-day probably complain about it...)

Jonathan


> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > ---
> >  drivers/iio/adc/stm32-adc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 7f1fb36c747c..14c7c9d390e8 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -217,6 +217,7 @@ struct stm32_adc_cfg {
> >  
> >  /**
> >   * struct stm32_adc - private data of each ADC IIO instance
> > + * dev:			parent device
> >   * @common:		reference to ADC block common data
> >   * @offset:		ADC instance register offset in ADC block
> >   * @cfg:		compatible configuration data
> > @@ -243,6 +244,7 @@ struct stm32_adc_cfg {
> >   * @int_ch:		internal channel indexes array
> >   */
> >  struct stm32_adc {
> > +	struct device		*dev;  
> 
> Can't you use the parent pointer of the indio_dev?
> 
> >  	struct stm32_adc_common	*common;
> >  	u32			offset;
> >  	const struct stm32_adc_cfg	*cfg;
> > @@ -1986,8 +1988,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
> >  			/* Get calibration data for vrefint channel */
> >  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> >  			if (ret && ret != -ENOENT) {
> > -				return dev_err_probe(&indio_dev->dev, ret,
> > -						     "nvmem access error\n");
> > +				return dev_err_probe(adc->dev, ret, "nvmem access error\n");
> >  			}
> >  			if (ret == -ENOENT)
> >  				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
> > @@ -2221,6 +2222,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >  	init_completion(&adc->completion);
> >  	adc->cfg = (const struct stm32_adc_cfg *)
> >  		of_match_device(dev->driver->of_match_table, dev)->data;
> > +	adc->dev = &pdev->dev;  
> 
> There's struct device *dev = &pdev->dev; defined earlier, so you can use dev instead.
> 
> >  
> >  	indio_dev->name = dev_name(&pdev->dev);
> >  	indio_dev->dev.of_node = pdev->dev.of_node;
> >   
> 
> Cheers,
> Ahmad
> 

