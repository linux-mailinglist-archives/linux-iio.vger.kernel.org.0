Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645A3E367E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhHGR1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGR1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 13:27:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF97C0613CF;
        Sat,  7 Aug 2021 10:26:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j3so11582528plx.4;
        Sat, 07 Aug 2021 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0d5C7EFr+pHAYEI9Rz32IM1KwO3F7Q5NLKcNkQW4LNo=;
        b=qh8JnBJKrlOUh0tE+D+6FZNRQDtrQLGh8taf+5wyD0tUVcuRci6T+lXC0SuQ8IdPya
         DFX0UYmAO2zIkk7xLj6jjTZk+c41DamW/DkbmbAgvScwBy7z9tx7qpO9cyQ62fcRdK+m
         K3Kbk8rVOise3+xH331zy9sJSewdkzQjZFTBeqpzAmvnCkDW5qgDO77yrZVSZqxN4CaB
         CSVy2Hqic3Vr+LJ8YHUdFXCfPDVapyHa8+4bq+GuxGEJrvmz+XtP+u6Q2pIJpTd8w5Z6
         jVSJAcXIVEmAEk9Qmmj/gbxb2hq8FijdLinPSDv7rgGJ3DYCOD0MKaYryjybQaF/HixO
         UHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0d5C7EFr+pHAYEI9Rz32IM1KwO3F7Q5NLKcNkQW4LNo=;
        b=oWAwItTU+VuHHU+LdNn7D0U0xmst5fgm3N3sfURjVXggJqj6LObd9Awxo6zKDmOjKV
         famsBzCCCuK2LxHcvcdhwKZOlzuGl0wPwNOGDg9GFkFRRM4qUwrnGun1xraYspPzNRBh
         O57YzLmx3kyuFw3aa3g3PkfTJP1hgFebeSDYyQvRIBw5ksJEgMl663WElmfHQBocLJEw
         iGu07ElTwvo5Vnek7fIhpmAO3KRPC7a+jHUrXlC1R2+G3LL0FPLfiorxNH7u/40oZPL+
         Yu914COmrCnslsXriABOyHJ5VbdRZtOwHuLht4PVefyI1ybK5CsR7mZC6ttMb0jnu/wR
         /VtA==
X-Gm-Message-State: AOAM530vgrmldjk8c7/nQaOOtUBHfEM9Kof/L4l2PFl6tXK9eTmVsZ36
        EJtD7qEH6qA5hcy3Z6wHD9vBEL9o89pJGaOo
X-Google-Smtp-Source: ABdhPJw+YJRRF/wF+ZDUlRzpS4uKxwRE6k7Il63IwY5tcpF2OTJNuWFse5bxv78jwgoFMoaUaOg8Jw==
X-Received: by 2002:a05:6a00:721:b029:3c7:623e:a871 with SMTP id 1-20020a056a000721b02903c7623ea871mr10703947pfm.9.1628357208219;
        Sat, 07 Aug 2021 10:26:48 -0700 (PDT)
Received: from ?IPv6:2409:4072:92:61e9:38ed:54e8:b166:da11? ([2409:4072:92:61e9:38ed:54e8:b166:da11])
        by smtp.gmail.com with ESMTPSA id w67sm14773160pfc.31.2021.08.07.10.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 10:26:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
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
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Message-ID: <9b58fb0c-245d-795f-2124-6cc2020bc8c5@gmail.com>
Date:   Sat, 7 Aug 2021 22:56:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <53306463-668e-e291-4539-caca2352ea05@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 07/08/21 5:41 pm, Lars-Peter Clausen wrote:
> On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:
>> The AD5110/AD5112/AD5114 provide a nonvolatile solution
>> for 128-/64-/32-position adjustment applications, offering
>> guaranteed low resistor tolerance errors of ±8% and up to
>> ±6 mA current density.
>>
>> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> 
> Thanks for the patch. This looks really good> 
> 
>> [...]
>>
>> +static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&data->lock);
>> +    data->buf[0] = cmd;
>> +    data->buf[1] = val;
>> +
>> +    ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
>> +    mutex_unlock(&data->lock);
> 
> This returns the number of bytes written, which can be less then the number of bytes requested if there was an error. This should check if the right amount of bytes was written and return -EIO otherwise. Same for the other places that read/write from I2C.

Fixed in v2.
> 
>> +
>> +    return ret < 0 ? ret : 0;
>> +}
>> +
>> +static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val)
>> +{
>> +    int ret;
>> +
>> +    ret = ad5110_read(data, cmd, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    data->tol = FIELD_GET(GENMASK(6, 3), val);
>> +    data->tol = ((val & GENMASK(2, 0)) * 1000 / 8) + data->tol * 1000;
>> +    data->tol = data->cfg->kohms * data->tol / 100;
> 
> This is not wrong, but it can be implemented a bit simpler. The tolerance is encoded as a fixed point number, you don't have to treat them as two independent fields, but can treat it as one fixed point number.
> 
>     data->tol = data->cfg->kohms * (val & GENMASK(6, 0)) * 1000 / 100 / 8;
> 
Great, Fixed in v2.
> 
>> +    if (!(val & BIT(7)))
>> +        data->tol *= -1;
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t ad5110_eeprom_read(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      char *buf)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct ad5110_data *data = iio_priv(indio_dev);
>> +    int val = AD5110_WIPER_POS;
>> +    int ret;
>> +
>> +    ret = ad5110_read(data, AD5110_EEPROM_RD, &val);
>> +    if (ret)
>> +        return ret;
> Maybe apply shift to get consistent behavior with `raw`.
Fixed in v2.
>> +
>> +    return iio_format_value(buf, IIO_VAL_INT, 1, &val);
>> +}
>> +
>> +static ssize_t ad5110_eeprom_write(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       const char *buf, size_t len)
>> +{
>> +    struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +    struct ad5110_data *data = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
>> +    if (ret) {
>> +        dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
>> +        return ret;
>> +    }
>> +    msleep(20);
>> +
>> +    return len;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(wiper_pos_eeprom, 0644,
>> +               ad5110_eeprom_read,
>> +               ad5110_eeprom_write, 0);
> This is new custom ABI and needs to be documentedI'm not aware of this, fixed in v2.
>> +static int ad5110_write_raw(struct iio_dev *indio_dev,
>> +                struct iio_chan_spec const *chan,
>> +                int val, int val2, long mask)
>> +{
>> +    struct ad5110_data *data = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    switch (mask) {
>> +    case IIO_CHAN_INFO_RAW:
>> +        if (val >= data->cfg->max_pos || val < 0)
> val == data->cfg->max_pos is a valid setting. Writing max_pos puts it in top-scale mode which gives maximum resistance.
Fixed in v2.
>> +            return -EINVAL;
>> +
>> +        return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
>> +    case IIO_CHAN_INFO_ENABLE:
>> +        if (val < 0 || val > 1)
>> +            return -EINVAL;
>> +        if (data->enable == val)
>> +            return 0;
>> +        ret = ad5110_write(data, AD5110_SHUTDOWN, val);
> Doesn't val have to be inverted to get the right behaviorI just replicated the datasheet operation. 
You mean,
 1 - shutdown off
 0 - shutdown on
If yes, then the user won't get confused with the datasheet and the behavior of the driver?
Or Is it work like this? But yeah even I like this change it's more convenient.
>> +        if (ret)
>> +            return ret;
>> +        data->enable = val;
>> +        return 0;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
> [...]
Thanks for feedback!!
