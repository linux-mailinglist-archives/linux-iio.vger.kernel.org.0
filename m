Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF1352742
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBINc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 04:13:32 -0400
Received: from www381.your-server.de ([78.46.137.84]:40276 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBINb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 04:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WJYHZD/yI9+GiC21G4z8as+Vha9BjY024yCLrBq/FNg=; b=gfrgzGBNOQeO+oZDrXCXU45Y9f
        68hnYKo9Xt0kzKUxqowB//IILbH82VFLsbpBztU4bs3hbL77VLV6Gtici84oyaO6i7/3x4DMT5tZT
        8zTOt5XOnuvrN2WFmdbGDJigIaAS/BLfGAlpuTBT8MNx7+8SktcSqhkeXh2YJAfJoHqw5wHUK9PLK
        azHnpsjZrP1VVRJgL3q9mbmQFa6Xw9iH+kewsuxKpLK4/1BmIJpH8Few+uJuk6qNq9UNisvRG/WWC
        zKzJfe94RHNRnrKBofDV5+ErOuYUmJ/7fH+xZOrtQeU/PuwPPknklPgY2kdNj82eXLRYxlmsrmmqv
        M+lmShPA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lSEvm-0002av-8M; Fri, 02 Apr 2021 10:13:26 +0200
Received: from [2001:a61:2aa1:1e01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lSEvm-000DeJ-17; Fri, 02 Apr 2021 10:13:26 +0200
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401091648.87421-1-puranjay12@gmail.com>
 <20210401091648.87421-3-puranjay12@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7a9097bf-9f8d-0fe7-7b5e-84643bcff760@metafoo.de>
Date:   Fri, 2 Apr 2021 10:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401091648.87421-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26127/Thu Apr  1 13:11:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/1/21 11:16 AM, Puranjay Mohan wrote:
> TMP117 is a Digital temperature sensor with integrated NV memory.
>
> Add support for tmp117 driver in iio subsystem.
> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Nice and clean driver. Just some comments about the CALIBBIAS.

> [...]
> +#define TMP117_RESOLUTION_10UC		78125
Isn't the unit here 100 uC?
> +#define TMP117_DEVICE_ID		0x0117
> +
> +struct tmp117_data {
> +	struct i2c_client *client;
> +};
> +
> +static int tmp117_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int *val,
> +		int *val2, long mask)
> +{
> [...]
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +					TMP117_REG_TEMP_OFFSET);
> +		if (ret < 0)
> +			return ret;
> +		*val = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> +								/ 10000;
> +		*val2 = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> +								% 10000;

If I understand this right CALBBIAS is written in one unit, but read in 
another unit. E.g. if you do `echo 100 > ..._calibbias` and then `cat 
..._calibbias` you'd read a different value back.

I think that would be quite unexpected behavior. The unit should be the 
same. Here in the read function you can just return the register value. 
Just make sure to properly sign extend like for the RAW property.

> +		return IIO_VAL_INT_PLUS_MICRO;
> [...]
> +}
> +
> +static int tmp117_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	s16 off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = (s16)val;
This should have some input validation to avoid writing bogus values to 
the register when the value is out of range. You can either reject out 
of range values or clamp them into the valid range (using the clamp() 
macro).
> +		return i2c_smbus_write_word_swapped(data->client,
> +						TMP117_REG_TEMP_OFFSET, off);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
[...]
