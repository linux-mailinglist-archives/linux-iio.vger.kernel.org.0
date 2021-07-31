Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD03D3DC794
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGaSGf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhGaSGf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 14:06:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C980C0613CF;
        Sat, 31 Jul 2021 11:06:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso1292464otq.6;
        Sat, 31 Jul 2021 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kkXChpviXo2g9C3NzdUsOIvhQv77EXpLWm7556u8OXs=;
        b=DoQHLhm2JCFEZfnF6AjQv337TkzhQPxSJAJM+bdjchfgrjjYSD/RTPc+oS4O46vOmf
         vYNrYIT9HEdZnSVFLntxUapr/b/aq6XxwqMgkzAW8QbYlls3nA4Paf/mIky/dWeZ4Y+d
         b5enySD6jWCrPtNM1/6QogzrnRUQ8wiTrhI9FFUEwZYJuZS5kUKIRwVJC8RP8pHpP08i
         qYf+yXYYBlNL+e+cqQ3sZlDItbDplb00QLJbTCBZHC2kcMb0N/JgjqTaM7FtxQMFNBdj
         nusaaC9MU9S6PSOqHSkZfUy5SUehntKMbUaQGsNm3FfQjjlJBp7WyQk0swIWn/ZW9hY0
         lDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkXChpviXo2g9C3NzdUsOIvhQv77EXpLWm7556u8OXs=;
        b=sOHQFZi5JekXUKMCXrF7/CvBWs+Xe5ZDB8vshB+hTgls7DU0HSGqsGauIsfe3gQ5bm
         MLMv6Gs+hPIA1VSrVQA6iiBf9HxZD7cQtd352TQu2yeiXbTFQlqnRw0GDE/qKScfhQG9
         mc2rgtAoqcYsBDKOflpgIQ6FmvQwAShuLhRQlcanddQ/csVrjRtc6/ja8MLdNEzqL4FH
         T5gMPZFH1dBPrZLJJ6iesxDqOb1G6UneKkKWxb3Ci1Mr+5mAmNdwF3fWc/kUFYYpoxL1
         ChIf99NMBbsPEERk+LUvw2Jhf5cjmwQvVqpLPIBI+fJqF6bmXMJzhE/jhL6Dr5VEtsiL
         cnwA==
X-Gm-Message-State: AOAM530zfv5Y7TLmw5JI+Q/y8U+lmSSxkAsoD0ULHOhH7/TST6TrS13/
        M4ltZznsxqHYqQBJEzYV11E=
X-Google-Smtp-Source: ABdhPJyQpO9WO+JOAej5L+nwDlJDHRdm1PxLRK29l8JeaSGW35l4oC0po0pqlC4DTuuDNyCS6lmrdg==
X-Received: by 2002:a05:6830:2452:: with SMTP id x18mr6326465otr.196.1627754788583;
        Sat, 31 Jul 2021 11:06:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16sm970334otu.26.2021.07.31.11.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 11:06:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] iio: chemical: Add driver support for sgp40
To:     Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
References: <20210727163517.GA3468@arbad>
 <20210731173928.08d6812f@jic23-huawei>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <42e31edc-445c-06ac-dd3a-80db1b439996@roeck-us.net>
Date:   Sat, 31 Jul 2021 11:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731173928.08d6812f@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/31/21 9:39 AM, Jonathan Cameron wrote:
> On Tue, 27 Jul 2021 18:35:19 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
>> sgp40 is a gas sensor used for measuring the air quality.
>>
>> This driver is reading the raw resistance value which can be passed to
>> a userspace algorithm for further calculation.
>>
>> The raw value is also used to calculate an estimated absolute voc index
>> in the range from 0 to 500. For this purpose the raw_mean value of the
>> resistance for which the index value is 250 might be set up as a
>> calibration step.
>>
>> Compensation of relative humidity and temperature is supported and can
>> be used by writing to device attributes of the driver.
>>
>> There is a predecesor sensor type (sgp30) already existing. This driver
>> module was not extended because the new sensor is quite different in its
>> i2c telegrams.
>>
>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> Hi Andreas,
> 
> Non standard ABI in here, so we are missing documentation in Documentation/ABI/testing/sysfs-bus-iio-*
> 
> Otherwise a few suggestions inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
[ ... ]

>> +static int sgp40_read_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *chan, int *val,
>> +			int *val2, long mask)
>> +{
>> +	struct sgp40_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	u16 raw;
>> +	int voc;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&data->lock);
>> +		ret = sgp40_measure_raw(data, &raw);
>> +		if (ret) {
>> +			mutex_unlock(&data->lock);
>> +			return ret;
>> +		}
>> +		*val = raw;
>> +		ret = IIO_VAL_INT;
>> +		mutex_unlock(&data->lock);
>> +		break;
>> +	case IIO_CHAN_INFO_PROCESSED:
>> +		mutex_lock(&data->lock);
>> +		ret = sgp40_measure_raw(data, &raw);
>> +		if (ret) {
>> +			mutex_unlock(&data->lock);
>> +			return ret;
>> +		}
>> +		ret = sgp40_calc_voc(data, raw, &voc);
>> +		if (ret) {
>> +			mutex_unlock(&data->lock);
>> +			return ret;
>> +		}
>> +		*val = voc;
>> +		ret = IIO_VAL_INT;
>> +		mutex_unlock(&data->lock);
> 
> You are holding the lock longer than needed - it would be good
> to reduce this, hopefully removing the need for unlocking separately
> in each of the error paths.
> 
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
> 
> Drop this as you can't get here.
> 

Are you sure ? I see several "break;" above.

Guenter
