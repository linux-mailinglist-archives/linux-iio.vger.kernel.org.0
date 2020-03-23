Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78ABA18FA14
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCWQk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 12:40:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbgCWQk3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 12:40:29 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E7219BDF19CD4CCF572A;
        Mon, 23 Mar 2020 16:40:26 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Mar 2020 16:40:26 +0000
Received: from localhost (10.47.90.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 16:40:25 +0000
Date:   Mon, 23 Mar 2020 16:40:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     Mike Looijmans <mike.looijmans@topic.nl>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20200323164021.0000601f@Huawei.com>
In-Reply-To: <20200323104543.GH1922688@smile.fi.intel.com>
References: <20200316073208.19715-1-mike.looijmans@topic.nl>
        <20200315120238.18c10af0@archlinux>
        <20200313140415.20266-1-mike.looijmans@topic.nl>
        <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
        <20200319154842.1950-1-mike.looijmans@topic.nl>
        <20200322001628.GA2824675@smile.fi.intel.com>
        <826f5f78-6ce7-91f0-0ca2-880ac45c8df2@topic.nl>
        <20200323104543.GH1922688@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.106]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 12:45:43 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 23, 2020 at 10:21:07AM +0100, Mike Looijmans wrote:
> > On 22-03-2020 01:16, Andy Shevchenko wrote:  
> > > On Thu, Mar 19, 2020 at 04:48:42PM +0100, Mike Looijmans wrote:  
> 
> ...
> 
> > > > +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
> > > > +{
> > > > +	int ret;
> > > > +	__s16 temp;
> > > > +
> > > > +	mutex_lock(&data->mutex);  
> > >   
> > > > +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> > > > +			       &data->buffer, 2);  
> > > 
> > > sizeof() ?  
> > 
> > The buffer is a shared buffer, it will grow to accommodate reading all axis
> > and timestamp in a single read (9 bytes) and for FIFO reads in foreseeable
> > future.
> > 
> > I could use sizeof(temp) here though, but that wouldn't that be more
> > confusing?  
> 
> Yeah, perhaps comment explaining why 2 is being used there and why you write
> directly to the buffer (no temporary variable being involved)?

This is all about ensuring it's a dma safe buffer without having to explicit
kmallocs on eveyr read.  buffer is the temporary variable.

I would suggest using sizeof(__be16) which would make it clearer perhaps.

Jonathan


> 
> > > > +	temp = get_unaligned_be16(data->buffer);
> > > > +
> > > > +	mutex_unlock(&data->mutex);
> > > > +
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	*val = temp >> 5;
> > > > +
> > > > +	return IIO_VAL_INT;
> > > > +}  
> 


