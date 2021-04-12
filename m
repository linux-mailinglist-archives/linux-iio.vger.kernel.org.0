Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A9935C39C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhDLKUJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 12 Apr 2021 06:20:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2833 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbhDLKUH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 06:20:07 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJl2y4ZRdz688lj;
        Mon, 12 Apr 2021 18:14:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 12:19:48 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 11:19:47 +0100
Date:   Mon, 12 Apr 2021 11:18:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: adis16480: support burst read function
Message-ID: <20210412111821.00004183@Huawei.com>
In-Reply-To: <CY4PR03MB3112C03AD3DDF60A10F0018699709@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210408075643.70183-1-nuno.sa@analog.com>
        <20210411154002.159c4018@jic23-huawei>
        <CY4PR03MB3112C03AD3DDF60A10F0018699709@CY4PR03MB3112.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > +static irqreturn_t adis16480_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct adis16480 *st = iio_priv(indio_dev);
> > > +	struct adis *adis = &st->adis;
> > > +	int ret, bit, offset, i = 0;
> > > +	__be16 *buffer;
> > > +	u32 crc;
> > > +	bool valid;
> > > +	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
> > > +
> > > +	adis_dev_lock(adis);
> > > +	if (adis->current_page != 0) {
> > > +		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> > > +		adis->tx[1] = 0;
> > > +		ret = spi_write(adis->spi, adis->tx, 2);
> > > +		if (ret) {
> > > +			dev_err(&adis->spi->dev, "Failed to change  
> > device page: %d\n", ret);  
> > > +			adis_dev_unlock(adis);
> > > +			return ret;  
> > 
> > This is an interrupt handler, you should be careful what you return
> > as they will be treated as irqreturn_t not ints.
> > 
> > return IRQ_HANDLED even in error paths.  
> 
> Hmm, yeah, this is definitely not ok. Also imposes the question if we should
> call ' iio_trigger_notify_done()' in these error paths? I'm pending to do it as
> it might be a big assumption to say the device is 'broken' if some spi transfer
> fails...

Yup, that has always been a bit of an open question in drivers. As likely
as not, any breakage leaves the device in a state from which we can't recover
anyway.  I've mostly left whether to call iio_trigger_notify_done() to the
discretion of the driver writers.

> 
> Not doing it means we will never receive another irq (I think this is also true if
> we do not return IRQ_HANDLED)...
> 
> Also need to check other places as I'm fairly sure we have this problem (at least)
> in the adis16475 driver...
oops. Guess I missed it there ;)
> > > +		}
> > > +	}
> > > +
> > > +	adis->spi->max_speed_hz = ADIS16495_BURST_MAX_SPEED;
> > > +
> > > +	ret = spi_sync(adis->spi, &adis->msg);
> > > +	if (ret) {
> > > +		dev_err(&adis->spi->dev, "Failed to read data: %d\n",  
> > ret);  
> > > +		adis_dev_unlock(adis);
> > > +		return ret;
> > > +	}
> > > +
> > > +	adis->spi->max_speed_hz = cached_spi_speed_hz;
> > > +	adis->current_page = 0;  
> > 
> > Does it make more sense to move this to just after we changed the
> > page?  
> 
> Yes, it does. If the second spi transfer fails, we already moved to page 0
> but did not updated this variable...
> 
> - Nuno Sá

