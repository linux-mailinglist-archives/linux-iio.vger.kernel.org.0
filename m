Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A993C31307D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhBHLQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 06:16:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2522 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhBHLOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 06:14:19 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZ3Fy5Z2yz67lxg;
        Mon,  8 Feb 2021 19:09:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 12:13:36 +0100
Received: from localhost (10.47.30.32) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Feb 2021
 11:13:35 +0000
Date:   Mon, 8 Feb 2021 11:12:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data
 support
Message-ID: <20210208111249.00002a13@Huawei.com>
In-Reply-To: <aa4c713cb40448109f858b301e7a0f04@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-6-jic23@kernel.org>
        <aa4c713cb40448109f858b301e7a0f04@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.32]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Feb 2021 08:01:10 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Monday, February 8, 2021 4:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> > <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>
> > Subject: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data support
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > There are no mainline board files using this driver so lets drop
> > the platform_data support in favour of devicetree and similar.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 14 --------------
> >  1 file changed, 14 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7150.c
> > b/drivers/staging/iio/cdc/ad7150.c
> > index 0dce1b8ce76d..7ad9105e6b46 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -570,20 +570,6 @@ static int ad7150_probe(struct i2c_client *client,
> >  			return ret;
> >  	}
> > 
> > -	if (client->dev.platform_data) {
> > -		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
> > -						client->dev.platform_data,
> > -						NULL,
> > -						&ad7150_event_handler,
> > -						IRQF_TRIGGER_RISING |
> > -						IRQF_TRIGGER_FALLING |
> > -						IRQF_ONESHOT,
> > -						"ad7150_irq2",
> > -						indio_dev);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -  
> 
> The original code looks ugly, I forget when ad7150 needs
> the second interrupt.
It is one per channel.  That is events on a channel are only indicated on the
line associated with the channel.

I bring it back later in the series.

Jonathan

> 
> >  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >  	if (ret)
> >  		return ret;
> > --
> > 2.30.0  
> 
> Thanks
> Barry
> 

