Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54B52FD3E8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390740AbhATPXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 10:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390198AbhATPH7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2021 10:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611155192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rW85cNgEC6z5VdRtA3F8rGf8KcNV4FVgsl19ZtJYRI=;
        b=Kwy5YxoMCfXwyu3HTTnP3J6Jv2XuEWHlua93HZpioSMwNPj3NFnIVNdg5LYde2hWNxtQXM
        9zraJojIdG6g1vKRXB8tKomlI4ClmQzvl5qRn3N1GdfpQNRdog+xxDr39PI4fRg+c95UaX
        7l5YFImlNt+MtuZ/W/39SAgcH2CIZxI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-bQULZmLwOXSEDfsSHB9-OA-1; Wed, 20 Jan 2021 10:06:26 -0500
X-MC-Unique: bQULZmLwOXSEDfsSHB9-OA-1
Received: by mail-qt1-f197.google.com with SMTP id g9so21524129qtv.12
        for <linux-iio@vger.kernel.org>; Wed, 20 Jan 2021 07:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4rW85cNgEC6z5VdRtA3F8rGf8KcNV4FVgsl19ZtJYRI=;
        b=F+x2u4tRSmgYjippOSHIHgGGXagVTtPdjvP3vRCHEnw0aECSwDf/d+5eWKTeL+GX/P
         yeJ0ue7cb7V6KhJLt4WgOMzUE+pOgwu0NYByFIOFb8iAVjnaam7V1a0rt1UPL/acWytH
         bfNGWS0MEl6ZjR0nXh71RqR5q+K3goDIn8Hvr9WIm1tmeoDb3NeRLRSE0WByB7ik0zD6
         /dELj8s/EQ3/KEfvzxX1Nndc0VVoi5gn4ckKDpuQiuJQurHWri2AhnYUWsPOB70u2yRp
         zjUr/+8v+HQg8ioizNhTKb5UHjRoKv9fub9YhfIYIhupO58tPNLovbza77v7XtmV/MdV
         N2qw==
X-Gm-Message-State: AOAM533AcuXhulUA+JAp1rMSZ+uUaT67vap2OAuN3EoTQccwZJiKK9lB
        pPyiz/kR7yhwRUl36MKyyon2ZkCW3JDWDoG8gA3EyBYOPB/q24L65JpOKI4vil6Pe/YwxSTV8wO
        3Lb5WguXBJQySEXMVtffKJ1tFL0sP304ZgHZ1BMNNxAsRIQOYJK3YiEVzpHUhjapDjs8=
X-Received: by 2002:ac8:1482:: with SMTP id l2mr1667017qtj.301.1611155185832;
        Wed, 20 Jan 2021 07:06:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0F11ZG3j3o/ErvgkXt5eGAC3cLBUGGfXGcudIpshzAxgoNmHaMTe0wu33Uy3MEwtsgcpvCw==
X-Received: by 2002:ac8:1482:: with SMTP id l2mr1666990qtj.301.1611155185562;
        Wed, 20 Jan 2021 07:06:25 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a3sm1275319qtp.63.2021.01.20.07.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:06:25 -0800 (PST)
Subject: Re: [PATCH v2] iio: imu: bmi160: add mutex_lock for avoiding race
To:     Guoqing Chi <chi962464zy@163.com>
Cc:     martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com, huyue2@yulong.com, zhangwen@yulong.com,
        linux-iio@vger.kernel.org
References: <20210119112211.26404-1-chi962464zy@163.com>
 <c93224b5-008c-fc80-f466-88c387d5b08f@redhat.com>
 <20210120094802.00001fee@163.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9c9333cb-bd6c-0f29-f35b-7592f457c746@redhat.com>
Date:   Wed, 20 Jan 2021 07:06:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120094802.00001fee@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/19/21 5:48 PM, Guoqing Chi wrote:
> On Tue, 19 Jan 2021 06:54:45 -0800
> Tom Rix <trix@redhat.com> wrote:
>
>> On 1/19/21 3:22 AM, Guoqing Chi wrote:
>>> From: chiguoqing <chi962464zy@163.com>
>>>
>>> Adding mutex_lock, when read and write reg need to use this lock to
>>> avoid race.
>>>
>>> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
>>> ---
>>> v2:Follow write function to fix read function.
>>> Adding mutex init in core probe function.
>>> Adding break in switch case at read and write function.
>>>
>>>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
>>>  drivers/iio/imu/bmi160/bmi160_core.c | 34
>>> +++++++++++++++++++--------- 2 files changed, 25 insertions(+), 11
>>> deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/bmi160/bmi160.h
>>> b/drivers/iio/imu/bmi160/bmi160.h index 32c2ea2d7112..0c189a8b5b53
>>> 100644 --- a/drivers/iio/imu/bmi160/bmi160.h
>>> +++ b/drivers/iio/imu/bmi160/bmi160.h
>>> @@ -3,9 +3,11 @@
>>>  #define BMI160_H_
>>>  
>>>  #include <linux/iio/iio.h>
>>> +#include <linux/mutex.h>
>>>  #include <linux/regulator/consumer.h>
>>>  
>>>  struct bmi160_data {
>>> +	struct mutex lock;
>>>  	struct regmap *regmap;
>>>  	struct iio_trigger *trig;
>>>  	struct regulator_bulk_data supplies[2];
>>> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c
>>> b/drivers/iio/imu/bmi160/bmi160_core.c index
>>> 290b5ef83f77..e303378f4841 100644 ---
>>> a/drivers/iio/imu/bmi160/bmi160_core.c +++
>>> b/drivers/iio/imu/bmi160/bmi160_core.c @@ -452,26 +452,32 @@ static
>>> int bmi160_read_raw(struct iio_dev *indio_dev, int ret;
>>>  	struct bmi160_data *data = iio_priv(indio_dev);
>>>  
>>> +	mutex_lock(&data->lock);
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_RAW:
>>>  		ret = bmi160_get_data(data, chan->type,
>>> chan->channel2, val);
>>> -		if (ret)
>>> -			return ret;
>>> -		return IIO_VAL_INT;
>>> +		if (!ret)
>>> +			ret = IIO_VAL_INT;
>>> +		break;
>>>  	case IIO_CHAN_INFO_SCALE:
>>>  		*val = 0;
>>>  		ret = bmi160_get_scale(data,
>>>  				       bmi160_to_sensor(chan->type),
>>> val2);
>>> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>>> +		if (!ret)
>>> +			ret = IIO_VAL_INT_PLUS_MICRO;  
>> Looking better, another question..
>>
>> Why does the write() function return the results directly while the
>> read() function
>>
>> translates them to other values ?
>>
>> Tom
> It is original design in this driver. In order to
> differentiate raw to scale and SAMP_FREQ, while the scale and SAMP_FREQ
> are needless. I think log information can be added for this purpose,
> and return results directly.
> It is not change the return values for my modify.It's best to keep the
> original design.Is that all right?

Ok.

Reviewed-by: Tom Rix <trix@redhat.com>

> Guoqing Chi
>>> +		break;
>>>  	case IIO_CHAN_INFO_SAMP_FREQ:
>>>  		ret = bmi160_get_odr(data,
>>> bmi160_to_sensor(chan->type), val, val2);
>>> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>>> +		if (!ret)
>>> +			ret = IIO_VAL_INT_PLUS_MICRO;
>>> +		break;
>>>  	default:
>>> -		return -EINVAL;
>>> +		ret = -EINVAL;
>>>  	}
>>> +	mutex_unlock(&data->lock);
>>>  
>>> -	return 0;
>>> +	return ret;
>>>  }
>>>  
>>>  static int bmi160_write_raw(struct iio_dev *indio_dev,
>>> @@ -479,19 +485,24 @@ static int bmi160_write_raw(struct iio_dev
>>> *indio_dev, int val, int val2, long mask)
>>>  {
>>>  	struct bmi160_data *data = iio_priv(indio_dev);
>>> +	int result;
>>>  
>>> +	mutex_lock(&data->lock);
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_SCALE:
>>> -		return bmi160_set_scale(data,
>>> +		result = bmi160_set_scale(data,
>>>  					bmi160_to_sensor(chan->type),
>>> val2);
>>> +		break;
>>>  	case IIO_CHAN_INFO_SAMP_FREQ:
>>> -		return bmi160_set_odr(data,
>>> bmi160_to_sensor(chan->type),
>>> +		result = bmi160_set_odr(data,
>>> bmi160_to_sensor(chan->type), val, val2);
>>> +		break;
>>>  	default:
>>> -		return -EINVAL;
>>> +		result = -EINVAL;
>>>  	}
>>> +	mutex_unlock(&data->lock);
>>>  
>>> -	return 0;
>>> +	return result;
>>>  }
>>>  
>>>  static
>>> @@ -838,6 +849,7 @@ int bmi160_core_probe(struct device *dev,
>>> struct regmap *regmap, return -ENOMEM;
>>>  
>>>  	data = iio_priv(indio_dev);
>>> +	mutex_init(&data->lock);
>>>  	dev_set_drvdata(dev, indio_dev);
>>>  	data->regmap = regmap;
>>>    

