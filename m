Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4254C30A0B5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 04:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBADwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 22:52:39 -0500
Received: from m12-16.163.com ([220.181.12.16]:53914 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhBADwf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 22:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=unf2M
        8g1vcN4LaTMbREEj/+XheFvd1gQDauXFepBi60=; b=iAzkMIdBir37pMVEsLJsH
        p7mhSGtx34xpQRD51BXDlIuwU7fPnZfy4Ci7SMpLoVvHOiJrrKqAZbnc9cO4qq0E
        6FEEUiuFuNVhwXvTN25DhAC8rt0CIw8gEasErT933dzzIFGdThQHSV57c4MCouS2
        EsGXMXVPo9Jh1adJh4l9+E=
Received: from localhost (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowACXZGEsVhdg+daNZw--.25668S2;
        Mon, 01 Feb 2021 09:15:24 +0800 (CST)
Date:   Mon, 1 Feb 2021 09:15:35 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     trix@redhat.com, linux-iio@vger.kernel.org, huyue2@yulong.com,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        chiguoqing@yulong.com
Subject: Re: [PATCH v2 resend] iio: imu: bmi160: add mutex_lock for avoiding
 race
Message-ID: <20210201091535.000035d7@163.com>
In-Reply-To: <20210131112143.200cf70a@archlinux>
References: <20210125015344.106-1-chi962464zy@163.com>
        <20210131112143.200cf70a@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowACXZGEsVhdg+daNZw--.25668S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xJry8Jr4DKFWrGFW3Wrg_yoWrtF43pa
        47KF15CrZ5XF1xCr12qr98CFyYv34SqFnrGwn7Ka45ZrZ0yFn3Kr1UJ34FvF9YkrWDAF1S
        qrWUXrZ5uF1vv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvLv_UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiNxsrRFWBjbYHmQABsz
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Jan 2021 11:21:43 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 25 Jan 2021 09:53:44 +0800
> Guoqing Chi <chi962464zy@163.com> wrote:
> 
> > From: chiguoqing <chi962464zy@163.com>
> > 
> > Adding mutex_lock, when read and write reg need to use this lock to
> > avoid race.
> > 
> > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>  
> 
> Hi.  Looking at this again, I'm not entirely sure I understand what
> the race is.  Could you give any example?
> 
> Individual regmap accesses have their own internal protections
> against races.  We don't have an read modify write cycles that
> I can see here, so I don't think there are any races.
> 
> On another note however, there is a regmap_bulk_read into
> a variable on the stack which is a problem for spi.  Unlike i2c
> the spi patch in regmap for bulk_reads can be zero copy which
> means that the variable on the stack can be dma'd into.  That's
> a potential issue for some systems in which you can end up wiping
> out whatever else gets changed in the same cacheline.
> 
> To fix that, the variable should be in it's own cacheline. Either
> do that by using kmalloc etc to put it on the stack, or add a
> suitable buffer to priv, marked ___cacheline_aligned.  Though once
> you do that you will need locks to protect it as you've done
> here.
> 
> Jonathan

Hi Jonathan

It's my mistake. The regmap_bulk_read func has their own lock.
So maybe we can give up my patch.

Thanks.

> 
> 
> 
> > ---
> > v2:Follow write function to fix read function.
> > Adding mutex init in core probe function.
> > Adding break in switch case at read and write function.
> > 
> >  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
> >  drivers/iio/imu/bmi160/bmi160_core.c | 34
> > +++++++++++++++++++--------- 2 files changed, 25 insertions(+), 11
> > deletions(-)
> > 
> > diff --git a/drivers/iio/imu/bmi160/bmi160.h
> > b/drivers/iio/imu/bmi160/bmi160.h index 32c2ea2d7112..0c189a8b5b53
> > 100644 --- a/drivers/iio/imu/bmi160/bmi160.h
> > +++ b/drivers/iio/imu/bmi160/bmi160.h
> > @@ -3,9 +3,11 @@
> >  #define BMI160_H_
> >  
> >  #include <linux/iio/iio.h>
> > +#include <linux/mutex.h>
> >  #include <linux/regulator/consumer.h>
> >  
> >  struct bmi160_data {
> > +	struct mutex lock;
> >  	struct regmap *regmap;
> >  	struct iio_trigger *trig;
> >  	struct regulator_bulk_data supplies[2];
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c
> > b/drivers/iio/imu/bmi160/bmi160_core.c index
> > 290b5ef83f77..e303378f4841 100644 ---
> > a/drivers/iio/imu/bmi160/bmi160_core.c +++
> > b/drivers/iio/imu/bmi160/bmi160_core.c @@ -452,26 +452,32 @@ static
> > int bmi160_read_raw(struct iio_dev *indio_dev, int ret;
> >  	struct bmi160_data *data = iio_priv(indio_dev);
> >  
> > +	mutex_lock(&data->lock);
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> >  		ret = bmi160_get_data(data, chan->type,
> > chan->channel2, val);
> > -		if (ret)
> > -			return ret;
> > -		return IIO_VAL_INT;
> > +		if (!ret)
> > +			ret = IIO_VAL_INT;
> > +		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val = 0;
> >  		ret = bmi160_get_scale(data,
> >  				       bmi160_to_sensor(chan->type),
> > val2);
> > -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +		if (!ret)
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		ret = bmi160_get_odr(data,
> > bmi160_to_sensor(chan->type), val, val2);
> > -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> > +		if (!ret)
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> >  	default:
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> >  	}
> > +	mutex_unlock(&data->lock);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int bmi160_write_raw(struct iio_dev *indio_dev,
> > @@ -479,19 +485,24 @@ static int bmi160_write_raw(struct iio_dev
> > *indio_dev, int val, int val2, long mask)
> >  {
> >  	struct bmi160_data *data = iio_priv(indio_dev);
> > +	int result;
> >  
> > +	mutex_lock(&data->lock);
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SCALE:
> > -		return bmi160_set_scale(data,
> > +		result = bmi160_set_scale(data,
> >  					bmi160_to_sensor(chan->type),
> > val2);
> > +		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		return bmi160_set_odr(data,
> > bmi160_to_sensor(chan->type),
> > +		result = bmi160_set_odr(data,
> > bmi160_to_sensor(chan->type), val, val2);
> > +		break;
> >  	default:
> > -		return -EINVAL;
> > +		result = -EINVAL;
> >  	}
> > +	mutex_unlock(&data->lock);
> >  
> > -	return 0;
> > +	return result;
> >  }
> >  
> >  static
> > @@ -838,6 +849,7 @@ int bmi160_core_probe(struct device *dev,
> > struct regmap *regmap, return -ENOMEM;
> >  
> >  	data = iio_priv(indio_dev);
> > +	mutex_init(&data->lock);
> >  	dev_set_drvdata(dev, indio_dev);
> >  	data->regmap = regmap;
> >    


