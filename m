Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F118AE71
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 09:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgCSIi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 04:38:59 -0400
Received: from www381.your-server.de ([78.46.137.84]:50264 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSIi6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 04:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hKAEd+CZG7zQHnD4IiKme34IoCaYfigdFzSOMMibNAA=; b=CPhk2aQyZbF0pNeM9BrP2x6HLF
        pULBTC7yBJqNu5sfAp9p+xwS1+L8McuoZUeBo5f+sDK2MAJKVnt7zdemGwaXjjForCkVJWUtFt0oZ
        stnaz2t92cxh3NWE8lx6Y0ecZ923C5o8VusltxFwbbqXiIV9yy4nVnft24DZZEoprb403gyhCCUYB
        xTPcZwwY/KnEPgt+ZQsCtEN/qChxqkBxEmQYzvWcEMbDvLLqbpD5UezzobSnXlcMK46xEYlxy7Qs7
        cNT6rkKtY6r4Mvi2DAoaPWL/bj7DFrXA132IsaTU8SzK0lov4nhGV1NDS5F5rjE4IO2/HDZw2Db0w
        1EZYJgzg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEqhZ-0000Mk-9I; Thu, 19 Mar 2020 09:38:53 +0100
Received: from [93.104.102.217] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEqhY-000Unr-VN; Thu, 19 Mar 2020 09:38:53 +0100
Subject: Re: [PATCH 5/5] iio: adc: ad7793: use read_avail iio hook for scale
 available
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
 <20200318134042.30133-6-alexandru.ardelean@analog.com>
 <ffe8008d-5506-0e88-7ab2-6b221e36afba@metafoo.de>
 <e4a2757a8eaa148b15111830e4cf783319d0d68b.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4f00fe26-cb42-fc82-c97a-4c2191c0a243@metafoo.de>
Date:   Thu, 19 Mar 2020 09:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e4a2757a8eaa148b15111830e4cf783319d0d68b.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/20 8:58 AM, Ardelean, Alexandru wrote:
> On Wed, 2020-03-18 at 16:10 +0100, Lars-Peter Clausen wrote:
>> On 3/18/20 2:40 PM, Alexandru Ardelean wrote:
>>> This change uses the read_avail and '.info_mask_shared_by_type_available'
>>> modifier to set the available scale.
>>> Essentially, nothing changes to the driver's ABI.
>>>
>>> The main idea for this patch is to remove the AD7793 driver from
>>> checkpatch's radar. There have been about ~3 attempts to fix/break the
>>> 'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
>>> it to be an arithmetic operation and people were trying to change that.
>>
>> Yeah, probably a good idea!
>>
>>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>>> ---
>>>    drivers/iio/adc/ad7793.c | 53 +++++++++++++++++++++++++++-------------
>>>    1 file changed, 36 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
>>> index 5592ae573e6b..fad98f1801db 100644
>>> --- a/drivers/iio/adc/ad7793.c
>>> +++ b/drivers/iio/adc/ad7793.c
>>> @@ -354,29 +354,28 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>>>    static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
>>>    	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
>>>    
>>> -static ssize_t ad7793_show_scale_available(struct device *dev,
>>> -			struct device_attribute *attr, char *buf)
>>> +static int ad7793_read_avail(struct iio_dev *indio_dev,
>>> +			     struct iio_chan_spec const *chan,
>>> +			     const int **vals, int *type, int *length,
>>> +			     long mask)
>>>    {
>>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>    	struct ad7793_state *st = iio_priv(indio_dev);
>>> -	int i, len = 0;
>>>    
>>> -	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
>>> -		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
>>> -			       st->scale_avail[i][1]);
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		*vals = (int *)st->scale_avail;
>>
>> Can you change the type of scale_avail to int so we don't need the cast?
>>
> 
> So, I don't want to come-up as looking lazy.
> [I mean, I am lazy, but I don't want to look lazy.]
> 
> I took a look at what it means to change this to a simple array.
> The rework feels to me like a bit more noise than is probably worth it.
> I mean, if the purpose of the rework is to just get rid of this cast, then it
> feels noisy [to me].
> 
> That being said, if you insist, I can take a look and do a patch [before this
> one] to convert it to a simple array.

Hm, ok, looks like is more complicated to get rid of the cast than I 
though. So keep it.

