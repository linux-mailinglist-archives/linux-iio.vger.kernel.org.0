Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7A6C7023
	for <lists+linux-iio@lfdr.de>; Thu, 23 Mar 2023 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCWSVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Mar 2023 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCWSVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2023 14:21:08 -0400
Received: from mail-108-mta62.mxroute.com (mail-108-mta62.mxroute.com [136.175.108.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A514E91
        for <linux-iio@vger.kernel.org>; Thu, 23 Mar 2023 11:21:04 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta62.mxroute.com (ZoneMTA) with ESMTPSA id 1870fb3e23b000edb4.006
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 23 Mar 2023 18:20:59 +0000
X-Zone-Loop: 7fe5e265ba714985c7d342f89ade47de7b03b4279577
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
        Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PwAQ2FqPkhYuKaw3PFrFV9jQAqQU/fJg4xycW+3dre0=; b=t19pnxjhD0zTWu4/eQcTOTFCfH
        vZ3keIovVj03/1U/1GLyh528v+4Mm+H7c6XzJU4G/ihoRqbHP0M+TXtvjrEZPmISHjhqToWN8DT0T
        h1NZ8wzCbYPD6NIJ7FzeZ5ZLQY49Y8epY0GmPheirRRmEXbwcSUiuLYH5vbSDmec0fBvX7ittvaiM
        Q6NBld2xlvgwGYUfwAhQ+uxGM9Zwy5jTeccpF8+AULv74d4M6F6bR6/CPfNIIxxzmcleyOqT7Rzvw
        5pR6tvCu0OHppcXtnraL82bUt4lpLVwsHp2souhGV2o2kLzDS+AAA4B9ims34yo8wWrwUBPJYrYSb
        aq5aiubw==;
Message-ID: <59c33dc5-bc97-8016-72cf-e56c73943eda@ahepp.dev>
Date:   Thu, 23 Mar 2023 11:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH 2/2] iio: temperature: Add MCP9600 thermocouple EMF
 converter
To:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
 <20230319184728.49232-3-andrew.hepp@ahepp.dev>
 <89271a29-5b02-34fe-409b-373e3b8044ef@metafoo.de>
Content-Language: en-US
In-Reply-To: <89271a29-5b02-34fe-409b-373e3b8044ef@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/23 11:59 AM, Lars-Peter Clausen wrote:
> This looks really good. I have some small comments, and I apologize for 
> only having them so late in the review cycle.

No worries at all! I really appreciate the time and effort you, 
Jonathan, and Krzysztof have put into reviewing this.

> 
> On 3/19/23 11:47, Andrew Hepp wrote:
>> Add support for the MCP9600 thermocouple EMF converter.
> 
> Would be nice to have a very short description of the capabilities of 
> the sensor in the commit message.
> 

That seems like a good idea! Should the message be about the 
capabilities of the sensor, or the capabilities of the driver? The 
sensor supports a lot of advanced features that the driver currently 
doesn't support.

Currently I'm leaning towards

"Add support for the MCP9600 thermocouple EMF converter. The sensor has 
integrated cold junction compensation and a typical accuracy of 0.5 
degrees Celsius. The driver supports a resolution of 0.0625 degrees 
Celsius."

>>
>> Datasheet: 
>> https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
>> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
>> ---
>> [...]
>> diff --git a/drivers/iio/temperature/mcp9600.c 
>> b/drivers/iio/temperature/mcp9600.c
>> new file mode 100644
>> index 000000000000..b6d8ffb90c36
>> --- /dev/null
>> +++ b/drivers/iio/temperature/mcp9600.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> [...]
>> +static const struct iio_chan_spec mcp9600_channels[] = {
>> +    {
>> +        .type = IIO_TEMP,
>> +        .address = MCP9600_HOT_JUNCTION,
>> +        .info_mask_separate =
>> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +    },
>> +    {
>> +        .type = IIO_TEMP,
>> +        .address = MCP9600_COLD_JUNCTION,
>> +        .channel2 = IIO_MOD_TEMP_AMBIENT,
>> +        .modified = 1,
>> +        .info_mask_separate =
>> +            BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +    },
>> +    IIO_CHAN_SOFT_TIMESTAMP(2),
> If you do not have supported for buffered capture there is no need to 
> include a timestamp in the channel spec. There is no way to read it 
> without buffered support.

Ack

>> +};
>> +
>> +struct mcp9600_data {
>> +    struct i2c_client *client;
>> +    struct mutex read_lock; /* lock to prevent concurrent reads */
>> +};
>> +
>> +static int mcp9600_read(struct mcp9600_data *data,
>> +            struct iio_chan_spec const *chan, int *val)
>> +{
>> +    __be16 buf;
> buf does not seem to be used.

Oops, sorry about that, I'll make sure to build with warnings as errors 
next submission. I tested the module after changing from 
i2c_smbus_read_block_data but looks like I got a bit ahead of myself 
submitting.

>> +    int ret; >> +
>> +    mutex_lock(&data->read_lock);
> Do you actually need the custom lock? i2c_smbus_read_word_swapped itself 
> should provide locking and there is only a single operation under your 
> custom lock, which will already be atomic.

That seems like a convincing argument to me. It certainly doesn't seem 
like the lock is doing anything, since i2c_smbus_read_word_swapped 
provides locking.

>> +    ret = i2c_smbus_read_word_swapped(data->client, chan->address);
>> +    mutex_unlock(&data->read_lock);
>> +
>> +    if (ret < 0)
>> +        return ret;
>> +    *val = ret;
>> +
>> +    return 0;
>> +}
>> +
>> [...]
>> +static int mcp9600_probe(struct i2c_client *client)
>> +{
>> +    struct iio_dev *indio_dev;
>> +    struct mcp9600_data *data;
>> +    int ret;
>> +
>> +    ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
>> +    if (ret < 0)
>> +        return ret;
> 
> Might as well throw an error message in here for better diagnostics.
> 
>      return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
> 
> 

I think this is how I did it in my original submission, but it sounds 
like the preferred way of doing things is to warn without returning an 
error, in order to support fallback compatibilities?
