Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490893A27CB
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFJJKl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:10:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3192 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJJKl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:10:41 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0yf15yzSz6N5Kh;
        Thu, 10 Jun 2021 17:02:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 11:08:44 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 10:08:43 +0100
Date:   Thu, 10 Jun 2021 10:08:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <peda@axentia.se>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/8] iio: inkern: return valid type on raw to
 processed conversion
Message-ID: <20210610100841.00001f76@Huawei.com>
In-Reply-To: <CBZF1GGLRR7Y.2S244HIQOEERN@shaak>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
        <20210607144718.1724413-5-liambeguin@gmail.com>
        <20210609213247.2ad09186@jic23-huawei>
        <CBZF1GGLRR7Y.2S244HIQOEERN@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.112]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Jun 2021 17:46:58 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> On Wed Jun 9, 2021 at 4:32 PM EDT, Jonathan Cameron wrote:
> > On Mon, 7 Jun 2021 10:47:14 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > iio_convert_raw_to_processed_unlocked() applies the offset and scale of
> > > a channel on it's raw value.
> > > The processed value returned is always an integer. Return IIO_VAL_INT so
> > > that consumers can use this return value directly.
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>  
> > This looks likely to cause breakage given that return value will go to
> > consumers directly via iio_convert_raw_to_processed()
> >
> > Looks like this will break lmp91000 which checks for error as
> >
> > if (ret)
> >  
> 
> IIO_VAL_INT seems like a better return value here since the consumer
> gets an integer. I can look at existing consumers and patch those too.
> Or would you rather I drop this patch?
If we were looking at actually allowing this to return other types,
then I'd agree with updating callers appropriately.

For now we aren't doing that, so the only question is success or fail.
So I'd drop this one.

Most consumers don't care about IIO types.

Jonathan

> 
> > > ---
> > >  drivers/iio/inkern.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index 0b5667f22b1d..00d234e87234 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -618,7 +618,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
> > >  		 * raw value and return.
> > >  		 */
> > >  		*processed = raw * scale;
> > > -		return 0;
> > > +		return IIO_VAL_INT;
> > >  	}
> > >  
> > >  	switch (scale_type) {
> > > @@ -652,7 +652,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	return 0;
> > > +	return IIO_VAL_INT;
> > >  }
> > >  
> > >  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,  
> 

