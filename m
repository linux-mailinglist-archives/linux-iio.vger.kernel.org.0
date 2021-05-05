Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13084373633
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 10:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhEEIZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 04:25:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2995 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhEEIZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 04:25:03 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZqGD0KTFz70gFY;
        Wed,  5 May 2021 16:13:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 10:24:04 +0200
Received: from localhost (10.52.120.138) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 5 May 2021
 09:24:03 +0100
Date:   Wed, 5 May 2021 09:22:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: proximity: vcnl3020: add periodic mode
Message-ID: <20210505092225.00007ec4@Huawei.com>
In-Reply-To: <136a077085488866235636be5884681341fb3644.camel@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
        <20210430152419.261757-2-i.mikhaylov@yadro.com>
        <20210502190054.4bd99a38@jic23-huawei>
        <136a077085488866235636be5884681341fb3644.camel@yadro.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.138]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 May 2021 22:07:53 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> On Sun, 2021-05-02 at 19:00 +0100, Jonathan Cameron wrote:
> > On Fri, 30 Apr 2021 18:24:16 +0300
> > Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> >   
> > > Add the possibility to run proximity sensor in periodic measurement
> > > mode.  
> > 
> > Without an interrupt?  Unusual and perhaps best left to userspace.  
> 
> Do you mean without interrupt handler in driver for this particular interrupt?
> If it's need to be added here, I can add it. In this patch I just added trigger
> to enable/disable periodic measurement mode without interrupt handler.

The model for events in IIO is that they are 'pushed' to userspace.
So it is possible to do this with a polling thread, but on a device
with an interrupt line tied to the event, it makes much more sense
to do it that way.

We don't have read on demand event as there has been little real
demand for them (and they can be implemented in userspase).

Jonathan


> 
> >   
> > > +		if (rc)
> > > +			return rc;
> > > +
> > > +		/* Enable periodic measurement of proximity data. */
> > > +		cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> > > +
> > > +		/*
> > > +		 * Enable interrupts on threshold, for proximity data by
> > > +		 * default.
> > > +		 */
> > > +		icr = VCNL_ICR_THRES_EN;
> > > +	} else {
> > > +		if (!vcnl3020_is_thr_enabled(data))
> > > +			return 0;
> > > +
> > > +		cmd = 0;
> > > +		icr = 0;
> > > +		isr = 0;
> > > +	}
> > > +
> > > +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> > > +	if (rc)
> > > +		goto end;
> > > +
> > > +	rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
> > > +	if (rc)
> > > +		goto end;
> > > +
> > > +	if (!state)
> > > +		/* Clear interrupts */  
> > 
> > Given you don't seem to have an interrupt. I guess this is clearing
> > a status flag?  
> 
> Yes, it is clearing flag in interrupt status register.
> 
> >   
> > > +		rc = regmap_write(data->regmap, VCNL_ISR, isr);
> > > +
> > > +end:
> > > +	if (state)
> > > +		iio_device_release_direct_mode(indio_dev);  
> >   
> 
> 

