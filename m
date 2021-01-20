Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF31E2FC720
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 02:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbhATBti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 20:49:38 -0500
Received: from m12-11.163.com ([220.181.12.11]:34688 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731080AbhATBtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Jan 2021 20:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mWE8B
        GrSCST/Lvs23PP13hDMEeF1wBOp2zAgXhM4x9s=; b=j1WUgc6NTHAJaYLR4zoGd
        Upck7U2vD5TJWt2w9zPOr/iYTxdXIuF0KDQHnvx53bLhSOPWr3S281E4kVECS9fG
        Qv+O80gd2DhmrsgKHsgQ9LCOzj/k73LLpTERmBRuzs4PgkAHgp7gy6o9ixq3r0Aq
        OiDDbhTX2xFdzw6A/dY7Bc=
Received: from localhost (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowACXkJDHiwdg8ASkJg--.29556S2;
        Wed, 20 Jan 2021 09:47:52 +0800 (CST)
Date:   Wed, 20 Jan 2021 09:48:02 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Tom Rix <trix@redhat.com>
Cc:     martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com, huyue2@yulong.com, zhangwen@yulong.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi160: add mutex_lock for avoiding race
Message-ID: <20210120094802.00001fee@163.com>
In-Reply-To: <c93224b5-008c-fc80-f466-88c387d5b08f@redhat.com>
References: <20210119112211.26404-1-chi962464zy@163.com>
        <c93224b5-008c-fc80-f466-88c387d5b08f@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C8CowACXkJDHiwdg8ASkJg--.29556S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw17Aw43GF18CrWrJFy3XFb_yoWrWry5pa
        4UCF45ArWrXF1xCrnFqr95CFyYv3ySgF1DW34xKa45ZayYyFnakrn8J34Fvr9YyryDAr1I
        qrW8ZrZ8uF1kZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkkusUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/1tbiRAkgRFSIiKDXlwAAsd
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Jan 2021 06:54:45 -0800
Tom Rix <trix@redhat.com> wrote:

> On 1/19/21 3:22 AM, Guoqing Chi wrote:
> > From: chiguoqing <chi962464zy@163.com>
> >
> > Adding mutex_lock, when read and write reg need to use this lock to
> > avoid race.
> >
> > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
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
> 
> Looking better, another question..
> 
> Why does the write() function return the results directly while the
> read() function
> 
> translates them to other values ?
> 
> Tom

It is original design in this driver. In order to
differentiate raw to scale and SAMP_FREQ, while the scale and SAMP_FREQ
are needless. I think log information can be added for this purpose,
and return results directly.
It is not change the return values for my modify.It's best to keep the
original design.Is that all right?

Guoqing Chi
> 
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

