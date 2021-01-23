Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEC30165B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 16:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAWP1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 10:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbhAWP1q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 10:27:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2610423331;
        Sat, 23 Jan 2021 15:27:03 +0000 (UTC)
Date:   Sat, 23 Jan 2021 15:26:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Guoqing Chi <chi962464zy@163.com>,
        martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com, huyue2@yulong.com, zhangwen@yulong.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi160: add mutex_lock for avoiding race
Message-ID: <20210123152659.563cddeb@archlinux>
In-Reply-To: <9c9333cb-bd6c-0f29-f35b-7592f457c746@redhat.com>
References: <20210119112211.26404-1-chi962464zy@163.com>
        <c93224b5-008c-fc80-f466-88c387d5b08f@redhat.com>
        <20210120094802.00001fee@163.com>
        <9c9333cb-bd6c-0f29-f35b-7592f457c746@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Jan 2021 07:06:23 -0800
Tom Rix <trix@redhat.com> wrote:

> On 1/19/21 5:48 PM, Guoqing Chi wrote:
> > On Tue, 19 Jan 2021 06:54:45 -0800
> > Tom Rix <trix@redhat.com> wrote:
> >  
> >> On 1/19/21 3:22 AM, Guoqing Chi wrote:  
> >>> From: chiguoqing <chi962464zy@163.com>
> >>>
> >>> Adding mutex_lock, when read and write reg need to use this lock to
> >>> avoid race.
> >>>
> >>> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> >>> ---
> >>> v2:Follow write function to fix read function.
> >>> Adding mutex init in core probe function.
> >>> Adding break in switch case at read and write function.
> >>>
> >>>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
> >>>  drivers/iio/imu/bmi160/bmi160_core.c | 34
> >>> +++++++++++++++++++--------- 2 files changed, 25 insertions(+), 11
> >>> deletions(-)
> >>>
> >>> diff --git a/drivers/iio/imu/bmi160/bmi160.h
> >>> b/drivers/iio/imu/bmi160/bmi160.h index 32c2ea2d7112..0c189a8b5b53
> >>> 100644 --- a/drivers/iio/imu/bmi160/bmi160.h
> >>> +++ b/drivers/iio/imu/bmi160/bmi160.h
> >>> @@ -3,9 +3,11 @@
> >>>  #define BMI160_H_
> >>>  
> >>>  #include <linux/iio/iio.h>
> >>> +#include <linux/mutex.h>
> >>>  #include <linux/regulator/consumer.h>
> >>>  
> >>>  struct bmi160_data {
> >>> +	struct mutex lock;
> >>>  	struct regmap *regmap;
> >>>  	struct iio_trigger *trig;
> >>>  	struct regulator_bulk_data supplies[2];
> >>> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c
> >>> b/drivers/iio/imu/bmi160/bmi160_core.c index
> >>> 290b5ef83f77..e303378f4841 100644 ---
> >>> a/drivers/iio/imu/bmi160/bmi160_core.c +++
> >>> b/drivers/iio/imu/bmi160/bmi160_core.c @@ -452,26 +452,32 @@ static
> >>> int bmi160_read_raw(struct iio_dev *indio_dev, int ret;
> >>>  	struct bmi160_data *data = iio_priv(indio_dev);
> >>>  
> >>> +	mutex_lock(&data->lock);
> >>>  	switch (mask) {
> >>>  	case IIO_CHAN_INFO_RAW:
> >>>  		ret = bmi160_get_data(data, chan->type,
> >>> chan->channel2, val);
> >>> -		if (ret)
> >>> -			return ret;
> >>> -		return IIO_VAL_INT;
> >>> +		if (!ret)
> >>> +			ret = IIO_VAL_INT;
> >>> +		break;
> >>>  	case IIO_CHAN_INFO_SCALE:
> >>>  		*val = 0;
> >>>  		ret = bmi160_get_scale(data,
> >>>  				       bmi160_to_sensor(chan->type),
> >>> val2);
> >>> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> >>> +		if (!ret)
> >>> +			ret = IIO_VAL_INT_PLUS_MICRO;    
> >> Looking better, another question..
> >>
> >> Why does the write() function return the results directly while the
> >> read() function
> >>
> >> translates them to other values ?
> >>
> >> Tom  
> > It is original design in this driver. In order to
> > differentiate raw to scale and SAMP_FREQ, while the scale and SAMP_FREQ
> > are needless. I think log information can be added for this purpose,
> > and return results directly.
> > It is not change the return values for my modify.It's best to keep the
> > original design.Is that all right?  
> 
> Ok.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>

Hi Guoqing Chi,

For some reason the original patch email (start of this thread) never
made it to my inbox or indeed the archive at lore.kernel.org.

Please resend (picking up Tom's reviewed by) and make sure to cc
linux-iio@vger.kernel.org + jic23@kernel.org

Then check if they make it to lore.kernel.org as that should highlight
any issues where it is getting blocked etc.

Thanks,

Jonathan

> 
> > Guoqing Chi  
> >>> +		break;
> >>>  	case IIO_CHAN_INFO_SAMP_FREQ:
> >>>  		ret = bmi160_get_odr(data,
> >>> bmi160_to_sensor(chan->type), val, val2);
> >>> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> >>> +		if (!ret)
> >>> +			ret = IIO_VAL_INT_PLUS_MICRO;
> >>> +		break;
> >>>  	default:
> >>> -		return -EINVAL;
> >>> +		ret = -EINVAL;
> >>>  	}
> >>> +	mutex_unlock(&data->lock);
> >>>  
> >>> -	return 0;
> >>> +	return ret;
> >>>  }
> >>>  
> >>>  static int bmi160_write_raw(struct iio_dev *indio_dev,
> >>> @@ -479,19 +485,24 @@ static int bmi160_write_raw(struct iio_dev
> >>> *indio_dev, int val, int val2, long mask)
> >>>  {
> >>>  	struct bmi160_data *data = iio_priv(indio_dev);
> >>> +	int result;
> >>>  
> >>> +	mutex_lock(&data->lock);
> >>>  	switch (mask) {
> >>>  	case IIO_CHAN_INFO_SCALE:
> >>> -		return bmi160_set_scale(data,
> >>> +		result = bmi160_set_scale(data,
> >>>  					bmi160_to_sensor(chan->type),
> >>> val2);
> >>> +		break;
> >>>  	case IIO_CHAN_INFO_SAMP_FREQ:
> >>> -		return bmi160_set_odr(data,
> >>> bmi160_to_sensor(chan->type),
> >>> +		result = bmi160_set_odr(data,
> >>> bmi160_to_sensor(chan->type), val, val2);
> >>> +		break;
> >>>  	default:
> >>> -		return -EINVAL;
> >>> +		result = -EINVAL;
> >>>  	}
> >>> +	mutex_unlock(&data->lock);
> >>>  
> >>> -	return 0;
> >>> +	return result;
> >>>  }
> >>>  
> >>>  static
> >>> @@ -838,6 +849,7 @@ int bmi160_core_probe(struct device *dev,
> >>> struct regmap *regmap, return -ENOMEM;
> >>>  
> >>>  	data = iio_priv(indio_dev);
> >>> +	mutex_init(&data->lock);
> >>>  	dev_set_drvdata(dev, indio_dev);
> >>>  	data->regmap = regmap;
> >>>      
> 

