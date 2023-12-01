Return-Path: <linux-iio+bounces-538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B74801292
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 19:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9B1C20FD7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D404F5F5;
	Fri,  1 Dec 2023 18:25:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BE106;
	Fri,  1 Dec 2023 10:24:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ShhDr5Hjtz6K5yg;
	Sat,  2 Dec 2023 02:20:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E5C9F140B33;
	Sat,  2 Dec 2023 02:24:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Dec
 2023 18:24:54 +0000
Date: Fri, 1 Dec 2023 18:24:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Angel Iglesias
	<ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <20231201182453.00005673@Huawei.com>
In-Reply-To: <ZWX55o_-WT5BQlo-@sunspire>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
	<20231126183334.625d2d8b@jic23-huawei>
	<ZWX55o_-WT5BQlo-@sunspire>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > > +	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE];  
> > 
> > This is used for SPI transfers so should be DMA safe. It's not currently.
> > Look at how IIO_DMA_MINALIGN is used in other drivers to ensure there is
> > no unsafe sharing of cachelines.
> > 
> > On some architectures this is fixed by the stuff that bounces all small transfers
> > but I don't think that is universal yet.  If you want more info find the talk
> > by Wolfram Sang from a few years ago an ELCE on I2C DMA safe buffers.  
> 
> that was a nice rabbit hole, thanks for the pointer.

:) 

> 
> now, based on [2] I will skip explicit i2c dma-related code since my requests
> are 4 bytes long. according to the document, any i2c xfer below 8bytes is not
> worth the overhead.
> 
> [2] https://www.kernel.org/doc/html/latest/i2c/dma-considerations.html
> 
> > > +static int hsc_spi_probe(struct spi_device *spi)
> > > +{
> > > +	struct iio_dev *indio_dev;
> > > +	struct hsc_data *hsc;
> > > +	struct device *dev = &spi->dev;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	hsc = iio_priv(indio_dev);
> > > +	hsc->xfer = hsc_spi_xfer;  
> > 
> > Also, pass the callback and spi->dev into hsc probe. Easy to use
> > a container_of() to get back to the struct spi_device *spi  
> 
> I'd rather simply pass along the client struct.
> 

I don't like the fact it has to be a void *

The core code has no idea what is in there.  At least we constraint it
somewhat with a struct device.

If you want to use a union of the possible types, that would also be fine.

> > > +	hsc->client = spi;
> > > +
> > > +	return hsc_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
> > > +			 spi_get_device_id(spi)->driver_data);  
> > Don't use anything form spi_get_device_id()
> > 
> > Name is a fixed string currently so pass that directly.
> > For driver data, there isn't any yet but if there were use
> > spi_get_device_match_data() and make sure to provide the data in all the
> > id tables.  That function will search the firmware ones first then call
> > back to the spi specific varient.  
> 
> along the way driver_data became redundant, so it was removed from the function
> prototype.
> 
> best regards,
> peter
> 
> 


