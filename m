Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E113A27BD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFJJI5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 05:08:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3191 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJI5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 05:08:57 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0yc04tffz6N6PS;
        Thu, 10 Jun 2021 17:00:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 11:06:59 +0200
Received: from localhost (10.52.126.112) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 10 Jun
 2021 10:06:58 +0100
Date:   Thu, 10 Jun 2021 10:06:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <peda@axentia.se>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/8] iio: inkern: error out on unsupported offset
 type
Message-ID: <20210610100655.000010ff@Huawei.com>
In-Reply-To: <CBZEWQ0YIIEC.3A2WESVVMHPJM@shaak>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
        <20210607144718.1724413-4-liambeguin@gmail.com>
        <20210609212850.008d7f84@jic23-huawei>
        <CBZEWQ0YIIEC.3A2WESVVMHPJM@shaak>
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

On Wed, 09 Jun 2021 17:40:47 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> Hi Jonathan,
> 
> On Wed Jun 9, 2021 at 4:28 PM EDT, Jonathan Cameron wrote:
> > On Mon, 7 Jun 2021 10:47:13 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > iio_convert_raw_to_processed_unlocked() assumes the offset is an
> > > integer.
> > > Make that clear to the consumer by returning an error on unsupported
> > > offset types without breaking valid implicit truncations.
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > ---
> > >  drivers/iio/inkern.c | 34 +++++++++++++++++++++++++++++-----
> > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index b69027690ed5..0b5667f22b1d 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -578,13 +578,37 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
> > >  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
> > >  	int raw, int *processed, unsigned int scale)
> > >  {
> > > -	int scale_type, scale_val, scale_val2, offset;
> > > +	int scale_type, scale_val, scale_val2;
> > > +	int offset_type, offset_val, offset_val2;
> > >  	s64 raw64 = raw;
> > > -	int ret;
> > >  
> > > -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> > > -	if (ret >= 0)
> > > -		raw64 += offset;
> > > +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> > > +				       IIO_CHAN_INFO_OFFSET);
> > > +	if (offset_type >= 0) {
> > > +		switch (offset_type) {
> > > +		case IIO_VAL_INT:
> > > +			break;
> > > +		case IIO_VAL_INT_PLUS_MICRO:
> > > +			if (offset_val2 > 1000)  
> >
> > What's the logic behind this one? > 1000000
> > would be an interesting corner case, though I'm not sure we've ever
> > explicitly disallowed it before.
> >
> > Why are we at 1000th of that for the check?
> >  
> 
> For these the idea was to go with one milli of precision.
> I don't know if that's a good criteria but I wanted to start with
> something. Do you have any suggestions?
> 
> > > +				return -EINVAL;
> > > +			break;
> > > +		case IIO_VAL_INT_PLUS_NANO:
> > > +			if (offset_val2 > 1000000)  
> >
> > Similar this is a bit odd.
> >  
> > > +				return -EINVAL;
> > > +		case IIO_VAL_FRACTIONAL:
> > > +			if (offset_val2 != 1)
> > > +				return -EINVAL;  
> >
> > We could be more flexible on this, but I don't recall any
> > channels using this so far.
> >  
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL_LOG2:
> > > +			if (offset_val2)
> > > +				return -EINVAL;  
> >
> > Same in this case.
> >  
> 
> For these two cases, I went with what Peter suggested in the previous
> version, to not break on valid implicit truncations.
> 
> What would be a good precision criteria for all offset types?

@Peter, what were your thoughts on this.

I was thinking we'd just not worry about how much truncation was happening
and just silently eat it.

J
> 
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		raw64 += offset_val;
> > > +	}
> > >  
> > >  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> > >  					IIO_CHAN_INFO_SCALE);  
> 
> Thanks for looking at this,
> Liam

