Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05893E3688
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 19:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHGRer (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 13:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGRer (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 13:34:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203DC0613CF;
        Sat,  7 Aug 2021 10:34:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mt6so21465002pjb.1;
        Sat, 07 Aug 2021 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t7bTmWC+qKcdA7NLxNga3iR1jXOFJu4plAdNWHvCPVI=;
        b=F8BNco+mhTQsTGtrOwf56Dhl9Vt8RVfkmraKHXekG9wIj0hmPapd2zIY97e7bXKnCH
         1+teFvBrR3KxrUKV6B3Lgo8p8LSvIEt49BmyXgTkabSv9oRg9h4drIrYIa+o9uPZBjwm
         oYwIrpsBL5XFUtRcORlGfvQjclvOVPw5skljRFQVG9tmpxHY0Sj6ZPJnyY6hyrnYLQVF
         4VxOSBfba+AfKR0FbcgrkKeoeq9S2RyTt0BkI9NP/Nte66X0GZtNbf/vQACHFvTCvohG
         vj72MILcMOx1KKdCFAnEpVgUqtc5+RoxtE+Q+9p0qH1FvIqyOniRp5z47gr9R7hagp+5
         2GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t7bTmWC+qKcdA7NLxNga3iR1jXOFJu4plAdNWHvCPVI=;
        b=I0H4O3lKMAV/rkcrQYPLEWFOhRY9IGOUIj+29O2GlzQdvebbjMoTXR33vrmXS8VRNc
         1Mvzbrl6xy23deT2ZPoMxoYkPnVVCIN/Q/V7GiQUu9lzJr4OrmPm9sJdWoyEPEJPIQng
         +68Gg4efqDUUreo9fxzeN8XqR7IsAi/0UjeelpJku6fjEIHUoz0df6Wtzu6v/zVylg5e
         AWLX0QxT4d3WAe9J1a63QaYwetfnAxbN2hRjTDyFLfyfWQhmP+xqc/b4NDgYGIs57nfX
         paOkzelCJ41fs4P/mVLs5L0T2q2cKw4t/wPuHXdT03wFttd6lKYuwcI8kPIqKp1RmFoO
         bgEw==
X-Gm-Message-State: AOAM532dYuQh86VBL9d5IuOidTeGcAreacJfiwYPsIEGy+vw9SxHCZjd
        ChcJTRl14RnnIBX2l8AIimt6o4Shzq+W6UKo
X-Google-Smtp-Source: ABdhPJzWwkIRetrjWGd8ubnR9rtch5yOyR+TTkBMXWEmVLnHgSM5Q5E2wF+RI//MFaY/KCtdyhTdOQ==
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr26345668pjp.224.1628357668107;
        Sat, 07 Aug 2021 10:34:28 -0700 (PDT)
Received: from ?IPv6:2409:4072:92:61e9:38ed:54e8:b166:da11? ([2409:4072:92:61e9:38ed:54e8:b166:da11])
        by smtp.gmail.com with ESMTPSA id j128sm15255123pfd.38.2021.08.07.10.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 10:34:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20210807050900.10075-1-dmugil2000@gmail.com>
 <20210807050900.10075-3-dmugil2000@gmail.com>
 <53306463-668e-e291-4539-caca2352ea05@metafoo.de>
 <9b58fb0c-245d-795f-2124-6cc2020bc8c5@gmail.com>
Message-ID: <66d670d6-0374-88ae-c4c1-efd60b54bbd2@gmail.com>
Date:   Sat, 7 Aug 2021 23:04:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9b58fb0c-245d-795f-2124-6cc2020bc8c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry some formatting issues happened in my previous mail.

On 07/08/21 10:56 pm, Mugilraj Dhavachelvan wrote:
> 
> 
> On 07/08/21 5:41 pm, Lars-Peter Clausen wrote:
>> On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:
>>> The AD5110/AD5112/AD5114 provide a nonvolatile solution
>>> for 128-/64-/32-position adjustment applications, offering
>>> guaranteed low resistor tolerance errors of ±8% and up to
>>> ±6 mA current density.
>>>
>>> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
>>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
>>
>> Thanks for the patch. This looks really good> 
>>
>>> [...]
>>>
>>> +static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
>>> +{
>>> +    int ret;
>>> +
>>> +    mutex_lock(&data->lock);
>>> +    data->buf[0] = cmd;
>>> +    data->buf[1] = val;
>>> +
>>> +    ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
>>> +    mutex_unlock(&data->lock);
>>
>> This returns the number of bytes written, which can be less then the number of bytes requested if there was an error. This should check if the right amount of bytes was written and return -EIO otherwise. Same for the other places that read/write from I2C.
> 
> Fixed in v2.
>>
>>> +
>>> +    return ret < 0 ? ret : 0;
>>> +}
>>> +
>>> +static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = ad5110_read(data, cmd, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    data->tol = FIELD_GET(GENMASK(6, 3), val);
>>> +    data->tol = ((val & GENMASK(2, 0)) * 1000 / 8) + data->tol * 1000;
>>> +    data->tol = data->cfg->kohms * data->tol / 100;
>>
>> This is not wrong, but it can be implemented a bit simpler. The tolerance is encoded as a fixed point number, you don't have to treat them as two independent fields, but can treat it as one fixed point number.
>>
>>     data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 1000 / 100 / 8;
>>
> Great, Fixed in v2.
>>
>>> +    if (!(val & BIT(7)))
>>> +        data->tol *= -1;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static ssize_t ad5110_eeprom_read(struct device *dev,
>>> +                      struct device_attribute *attr,
>>> +                      char *buf)
>>> +{
>>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +    struct ad5110_data *data = iio_priv(indio_dev);
>>> +    int val = AD5110_WIPER_POS;
>>> +    int ret;
>>> +
>>> +    ret = ad5110_read(data, AD5110_EEPROM_RD, &val);
>>> +    if (ret)
>>> +        return ret;
>> Maybe apply shift to get consistent behavior with `raw`.
> Fixed in v2.
>>> +
>>> +    return iio_format_value(buf, IIO_VAL_INT, 1, &val);
>>> +}
>>> +
>>> +static ssize_t ad5110_eeprom_write(struct device *dev,
>>> +                       struct device_attribute *attr,
>>> +                       const char *buf, size_t len)
>>> +{
>>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +    struct ad5110_data *data = iio_priv(indio_dev);
>>> +    int ret;
>>> +
>>> +    ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
>>> +    if (ret) {
>>> +        dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
>>> +        return ret;
>>> +    }
>>> +    msleep(20);
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(wiper_pos_eeprom, 0644,
>>> +               ad5110_eeprom_read,
>>> +               ad5110_eeprom_write, 0);
>> This is new custom ABI and needs to be documented

> I'm not aware of this, fixed in v2.
>>> +static int ad5110_write_raw(struct iio_dev *indio_dev,
>>> +                struct iio_chan_spec const *chan,
>>> +                int val, int val2, long mask)
>>> +{
>>> +    struct ad5110_data *data = iio_priv(indio_dev);
>>> +    int ret;
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +        if (val >= data->cfg->max_pos || val < 0)
>> val == data->cfg->max_pos is a valid setting. Writing max_pos puts it in top-scale mode which gives maximum resistance.
> Fixed in v2.
>>> +            return -EINVAL;
>>> +
>>> +        return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
>>> +    case IIO_CHAN_INFO_ENABLE:
>>> +        if (val < 0 || val > 1)
>>> +            return -EINVAL;
>>> +        if (data->enable == val)
>>> +            return 0;
>>> +        ret = ad5110_write(data, AD5110_SHUTDOWN, val);
>> Doesn't val have to be inverted to get the right behavior

> I just replicated the datasheet operation. 
> You mean,
>  1 - shutdown off
>  0 - shutdown on
> If yes, then the user won't get confused with the datasheet and the behavior of the driver?
> Or Is it work like this? But yeah even I like this change it's more convenient.
>>> +        if (ret)
>>> +            return ret;
>>> +        data->enable = val;
>>> +        return 0;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +}
>> [...]
> Thanks for feedback!!
> 
