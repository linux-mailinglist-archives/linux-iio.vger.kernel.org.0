Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764411E1CF8
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEZILw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 04:11:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:48338 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgEZILw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 04:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xfYub+yQ7jsj/QVTK9Uu/YqjHz1s+CGG/Kvu5cs7s+E=; b=A3FVnYAW/kZpK1k61i+qoWt7fy
        sITfhUuebVL4FNmDacE4RrF++8ayET5TR7ONdkwYb3R3nFHpvTxNQdk8px0Ek7b4S/9/Ch3gBzklI
        xviTsBcri7N3eZL2n9wvP3Zn7AbxBF0D72lSh6Lz6Wsoo9hv0RILjM7QzRwwHy1/iplq2o23ttuOY
        zxdG2D3K/wWwC1Di1bui8Uj/NWLv1TYi7eXTUjn3+cINvHo2h0NCaMAx398XlD6ksSgi0R5YY+hgM
        Kx98Vug1V5VHPyv9TFM4uBeGMFEBRlbUSMqYoeHWP8SAvLvg4tUfZDwIbgDPRhTY5wYbFg2Rx0aSW
        m1dUp0pQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jdUgb-0004XE-Tm; Tue, 26 May 2020 10:11:46 +0200
Received: from [82.135.76.6] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jdUgb-000UMU-LI; Tue, 26 May 2020 10:11:45 +0200
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-20-jic23@kernel.org>
 <20200525175236.GG1634618@smile.fi.intel.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <da67e0e4-5889-eb87-7bc0-fac07ae54e57@metafoo.de>
Date:   Tue, 26 May 2020 10:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525175236.GG1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25823/Mon May 25 14:23:53 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/25/20 7:52 PM, Andy Shevchenko wrote:
> On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> One of a class of bugs pointed out by Lars in a recent review.
>> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
>> to the size of the timestamp (8 bytes).  This is not guaranteed in
>> this driver which uses an array of smaller elements on the stack.
>>
>> Here we use an explicit structure and rely on that to enforce
>> alignment on the stack.  Note there was never a data leak here
>> due to the explicit memset.
>>
>> Fixes: ecc24e72f437 ("iio: adc: Add TI ADS1015 ADC driver support")
>> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/iio/adc/ti-ads1015.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 5ea4f45d6bad..05853723dbdb 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -385,10 +385,14 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>>   	struct iio_poll_func *pf = p;
>>   	struct iio_dev *indio_dev = pf->indio_dev;
>>   	struct ads1015_data *data = iio_priv(indio_dev);
>> -	s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
>> +	/* Ensure natural alignment for buffer elements */
>> +	struct {
>> +		s16 channel;
>> +		s64 ts;
>> +	} scan;
> Hmm... On x86_32 and x86_64 this will give different padding. Is it okay from
> iio_push_to_buffers_with_timestamp() point of view?

No, this is terrible. IIO expects 64 bit words to be 64 bit aligned. 
Looks like we can't rely on implicit padding, but need to always 
explicitly specify it.

Or maybe we can typedef and IIO timestamp type with an explicit 
__aligned attribute. I wonder if that works... After having a quick 
look, the kernel already defines aligned_u64, so maybe using that is an 
option.

