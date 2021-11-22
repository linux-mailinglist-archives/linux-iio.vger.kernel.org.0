Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF63E459075
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 15:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhKVOsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Nov 2021 09:48:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4126 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhKVOsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2021 09:48:12 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyVQZ0wGkz6H7s9;
        Mon, 22 Nov 2021 22:44:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 15:45:03 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 14:45:02 +0000
Date:   Mon, 22 Nov 2021 14:45:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2] iio: adc: stm32: fix null pointer on defer_probe
 error
Message-ID: <20211122144501.000014a3@Huawei.com>
In-Reply-To: <2ca4ad17-d7e5-f4be-1596-7c7de0fa5661@pengutronix.de>
References: <20211122143809.2332-1-olivier.moysan@foss.st.com>
        <2ca4ad17-d7e5-f4be-1596-7c7de0fa5661@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 15:41:10 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> On 22.11.21 15:38, Olivier Moysan wrote:
> > dev_err_probe() calls __device_set_deferred_probe_reason()
> > on -EPROBE_DEFER error. If device pointer to driver core
> > private structure is not initialized, an null pointer error occurs.
> > This pointer is set on iio_device_register() call for iio device.
> > 
> > dev_err_probe() must be called with the device which is probing.
> > Replace iio device by its parent device.
> > 
> > Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> > 

I'll fix it when applying, but no blank line between Fixes tag and the others.

> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>  
> 
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> > ---
> > Changes in v2:
> > - Use parent device from indio_dev instead of private structure
> > ---
> >  drivers/iio/adc/stm32-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 7f1fb36c747c..341afdd342cc 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -1986,7 +1986,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
> >  			/* Get calibration data for vrefint channel */
> >  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> >  			if (ret && ret != -ENOENT) {
> > -				return dev_err_probe(&indio_dev->dev, ret,
> > +				return dev_err_probe(indio_dev->dev.parent, ret,
> >  						     "nvmem access error\n");
> >  			}
> >  			if (ret == -ENOENT)
> >   
> 
> 

