Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800D52FBE56
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 18:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbhASRxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 12:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392094AbhASO40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 09:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611068091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmCmuSOhm/IEyEtAJZi780idCmd1/jX8N6bP920KOR8=;
        b=hkc0siRb+HozRCLM4tFKfa26Breloyu0UcXslZ67L+62d9bhAmavUT3Q4Q+wWXHRPgyyJK
        rYI5LXjYN5oOSQI5MK1Nl8nFmwdM4o1erS7vLbpsec2nfJuOb7RvgaPZGeI8DsyvBcw6kX
        ro9ACeerhqZAGuoW+KMnmdAFRgjhqUw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-swvvKOG2OC2Q5ae1m19nzg-1; Tue, 19 Jan 2021 09:54:49 -0500
X-MC-Unique: swvvKOG2OC2Q5ae1m19nzg-1
Received: by mail-qv1-f71.google.com with SMTP id cc1so19974956qvb.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 06:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VmCmuSOhm/IEyEtAJZi780idCmd1/jX8N6bP920KOR8=;
        b=QwosFLqipfc407Mw1n24DL1zWokF7+2eJ/laOVdzcJYjakLRan+DCfQMAQimLu6z+f
         B5F9HGY8mBggHOEsRkegCG7LiGOw9G9uFk1juaQ2ExpWt4eFTxnlBGdY/Y/AiHKax8GJ
         9lpQye+4FDmqQjQeJXR7vtYBaKzFau7KqsJ+/KchYydKfuB3feP3gp5jErG+JusACVd5
         ejQXgpVFlUnLfPlNCGmvp+IVk28b5na5DErQR0BKP9YiNdZSsD53N7R5vHqerRKxwWf+
         eq6wRxtsbvuMjjn2u562Kf3aO86hIgoLeI6ZfRZ/FNbvlVPLec4Jqazl/yJK9el9Z4hh
         ENyg==
X-Gm-Message-State: AOAM530pMlkJHN9zOFXeIjB4CNIT5BCZfxvAiL9Ast2DrPaA5WxJ7k2D
        USszVDNgbK0bLG6zoHYTq4ji3A/bKy7V2kBbHx0pPdqQ0tqbLeXG/9TOFFi/efcA/OBAGVip4rI
        DBiZd+wdxtuPCqhQGbMecs7HZ/VfX2M5BOLDTGg4FfWEMqCZ1Qf9JIYBlvIxjGPq0F/U=
X-Received: by 2002:ac8:6f4c:: with SMTP id n12mr4393273qtv.277.1611068088439;
        Tue, 19 Jan 2021 06:54:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQpQNRGFVXD2hF+GPhLmBlHPlvEfnmjjEidDijfF0kSjpbj8B5DErnaJyeG3nl9cG5Yobt6w==
X-Received: by 2002:ac8:6f4c:: with SMTP id n12mr4393235qtv.277.1611068088083;
        Tue, 19 Jan 2021 06:54:48 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q3sm13028444qkb.73.2021.01.19.06.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:54:47 -0800 (PST)
Subject: Re: [PATCH v2] iio: imu: bmi160: add mutex_lock for avoiding race
To:     Guoqing Chi <chi962464zy@163.com>
Cc:     martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com, huyue@yulong.com, zhangwen@yulong.com,
        linux-iio@vger.kernel.org
References: <20210119112211.26404-1-chi962464zy@163.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c93224b5-008c-fc80-f466-88c387d5b08f@redhat.com>
Date:   Tue, 19 Jan 2021 06:54:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119112211.26404-1-chi962464zy@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/19/21 3:22 AM, Guoqing Chi wrote:
> From: chiguoqing <chi962464zy@163.com>
>
> Adding mutex_lock, when read and write reg need to use this lock to
> avoid race.
>
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> ---
> v2:Follow write function to fix read function.
> Adding mutex init in core probe function.
> Adding break in switch case at read and write function.
>
>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
>  drivers/iio/imu/bmi160/bmi160_core.c | 34 +++++++++++++++++++---------
>  2 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 32c2ea2d7112..0c189a8b5b53 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -3,9 +3,11 @@
>  #define BMI160_H_
>  
>  #include <linux/iio/iio.h>
> +#include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
>  
>  struct bmi160_data {
> +	struct mutex lock;
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
>  	struct regulator_bulk_data supplies[2];
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 290b5ef83f77..e303378f4841 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -452,26 +452,32 @@ static int bmi160_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct bmi160_data *data = iio_priv(indio_dev);
>  
> +	mutex_lock(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = bmi160_get_data(data, chan->type, chan->channel2, val);
> -		if (ret)
> -			return ret;
> -		return IIO_VAL_INT;
> +		if (!ret)
> +			ret = IIO_VAL_INT;
> +		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
>  		ret = bmi160_get_scale(data,
>  				       bmi160_to_sensor(chan->type), val2);
> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +		if (!ret)
> +			ret = IIO_VAL_INT_PLUS_MICRO;

Looking better, another question..

Why does the write() function return the results directly while the read() function

translates them to other values ?

Tom

> +		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = bmi160_get_odr(data, bmi160_to_sensor(chan->type),
>  				     val, val2);
> -		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
> +		if (!ret)
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +	mutex_unlock(&data->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int bmi160_write_raw(struct iio_dev *indio_dev,
> @@ -479,19 +485,24 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
>  			    int val, int val2, long mask)
>  {
>  	struct bmi160_data *data = iio_priv(indio_dev);
> +	int result;
>  
> +	mutex_lock(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		return bmi160_set_scale(data,
> +		result = bmi160_set_scale(data,
>  					bmi160_to_sensor(chan->type), val2);
> +		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return bmi160_set_odr(data, bmi160_to_sensor(chan->type),
> +		result = bmi160_set_odr(data, bmi160_to_sensor(chan->type),
>  				      val, val2);
> +		break;
>  	default:
> -		return -EINVAL;
> +		result = -EINVAL;
>  	}
> +	mutex_unlock(&data->lock);
>  
> -	return 0;
> +	return result;
>  }
>  
>  static
> @@ -838,6 +849,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +	mutex_init(&data->lock);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
>  

