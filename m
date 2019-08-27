Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B909DC2A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 05:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfH0DzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 23:55:15 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:54733 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfH0DzP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2019 23:55:15 -0400
Received: (qmail 14690 invoked by uid 5089); 27 Aug 2019 03:55:13 -0000
Received: by simscan 1.2.0 ppid: 14576, pid: 14577, t: 0.0517s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 27 Aug 2019 03:55:12 -0000
Subject: Re: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device
 identification
To:     Jonathan Cameron <jic23@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, linux@roeck-us.net,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1566310292.git.michal.simek@xilinx.com>
 <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
 <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
 <bca73b6d-87ae-f8cc-b9f4-3b0a558942d9@xilinx.com>
 <20190825190753.7d52c3f9@archlinux>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <af5fdfc3-dbc8-40fc-2893-c786670f28d4@electromag.com.au>
Date:   Tue, 27 Aug 2019 11:55:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825190753.7d52c3f9@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 26/08/2019 02:07, Jonathan Cameron wrote:
> On Wed, 21 Aug 2019 11:12:00 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> On 21. 08. 19 4:11, Phil Reid wrote:
>>> On 20/08/2019 22:11, Michal Simek wrote:
>>>> Add support for using label property for easier device identification via
>>>> iio framework.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> ---
>>>>
>>>>    drivers/iio/adc/ina2xx-adc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>>>> index 7c7c63677bf4..077c54915f70 100644
>>>> --- a/drivers/iio/adc/ina2xx-adc.c
>>>> +++ b/drivers/iio/adc/ina2xx-adc.c
>>>> @@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *client,
>>>>        snprintf(chip->name, sizeof(chip->name), "%s-%s",
>>>>             client->name, dev_name(&client->dev));
>>>>    -    indio_dev->name = chip->name;
>>>> +    indio_dev->name = of_get_property(np, "label", NULL) ? : chip->name;
>>>>        indio_dev->setup_ops = &ina2xx_setup_ops;
>>>>          buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>>>>   
>>> I like this personally. It'd be nice if it was a core function so
>>> it could be an opt in to any iio device.
>>>
>>> Don't know how well received that'd be thou.
>>>    
> I'm not particularly keen on changing the semantics of existing
> ABI, but how about adding new ABI to provide this?
> 
> /sys/bus/iio/devices/iio\:device0/label for example?
> 
> I haven't thought about it in depth yet though.  If you spin
> a patch with that and the DT docs we'll be more likely to get
> a view from DT maintainers if this is acceptable use of label.
> 

I've sent "iio: core: Add optional symbolic label to device attributes"
for further discussion.


> Thanks
> 
> Jonathan
> 
>>
>> Something like this?
>>
>> diff --git a/drivers/iio/industrialio-core.c
>> b/drivers/iio/industrialio-core.c
>> index 524a686077ca..d21b495d36a1 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1647,6 +1647,9 @@ int __iio_device_register(struct iio_dev
>> *indio_dev, struct module *this_mod)
>>          if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>>                  indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>>
>> +       indio_dev->name = of_get_property(indio_dev->dev.of_node,
>> "label", NULL) ? :
>> +                                         indio_dev->name;
>> +
>>          ret = iio_check_unique_scan_index(indio_dev);
>>          if (ret < 0)
>>                  return ret;
>>
>>
>> M
> 
> 
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
