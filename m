Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C5107442
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKVOur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 09:50:47 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:48991 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVOuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 09:50:46 -0500
Received: from 122.62-97-226.bkkb.no ([62.97.226.122]:21927 helo=[10.0.1.54])
        by smtp.domeneshop.no with esmtpa (Exim 4.92)
        (envelope-from <eugene.zaikonnikov@norphonic.com>)
        id 1iYAGi-0000wy-54; Fri, 22 Nov 2019 15:50:44 +0100
Subject: Re: [PATCH 0/1] Add support for TI HDC200x humidity and temperature
 sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        development@norphonic.com, linux-iio@vger.kernel.org
References: <71176abd-4997-70f8-8132-137fadda7768@norphonic.com>
 <20191103121921.5b1d0b02@archlinux>
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Organization: Norphonic AS
Message-ID: <996dd531-cbc6-9ecc-0a67-0a9b8e686c0c@norphonic.com>
Date:   Fri, 22 Nov 2019 15:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103121921.5b1d0b02@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan,

Just got back to fixing most of the issues you pointed out, excepting these:

On 03.11.2019 13:19, Jonathan Cameron wrote:

> +
>> +static const struct iio_chan_spec hdc200x_channels[] = {
>> +    {
>> +        .type = IIO_TEMP,
>> +        .extend_name = "Temperature",
> Any use of extend_name changes the ABI and should be done extremely
> carefully.  It basically means that generic userspace code cannot
> use your driver.
>
> Here I can't see any advantage in doing so at all so drop it.

If I have two temperature channels and provide no extend_name to at least one of them, they fail to register.

>
>> +        },
>> +    },
>> +    {
>> +        .type = IIO_TEMP,
>> +        .extend_name = "Temperature_MAX",
> Could we use the IIO_CHAN_INFO_PEAK element for this?  Given
> the different scale, we'd need to do some work to make it
> have the same scale as temp.

Started looking into this.
Are there any examples or docs of using IIO_CHAN_INFO_PEAK? Couldn't find much in the IIO subtree.
Is it used together with INFO_RAW? And temp&max temp channels have different scales already.

>> +{
>> +    char tmp = (~mask & data->drdy_config) | val;
>> +    int ret;
>> +
>> +    ret = i2c_smbus_write_byte_data(data->client,
>> +                    HDC200X_REG_RESET_DRDY_INT_CONF, tmp);
>> +    if (!ret)
>> +        data->drdy_config = tmp;
>> +
>> +    return ret;
>> +}
>> +
>> +static int hdc200x_get_measurement_word(struct hdc200x_data *data,
>> +                    struct iio_chan_spec const *chan)
> These wrappers add relatively little.  I'd prefer that you just call
> the i2c calls directly instead.  Less code and ultimately a tiny
> bit easier to review.

Removed wrappers that are called once. Leaving the wrapper called in different places, makes intent more clear IMO.

--

  Eugene

