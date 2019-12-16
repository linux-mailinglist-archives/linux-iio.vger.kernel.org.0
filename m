Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BF11FF38
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLPHvc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 02:51:32 -0500
Received: from www381.your-server.de ([78.46.137.84]:40008 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPHvb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 02:51:31 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iglA8-0004QN-T0; Mon, 16 Dec 2019 08:51:28 +0100
Received: from [93.104.119.42] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1iglA8-000U55-K6; Mon, 16 Dec 2019 08:51:28 +0100
Subject: Re: [PATCH v3] iio: buffer: align the size of scan bytes to size of
 the largest element
To:     =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <kcis.016016E0AABB4ABC824358438D87FE25@mail>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9e68de59-db62-5ba7-c5b6-26d2a59610a2@metafoo.de>
Date:   Mon, 16 Dec 2019 08:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <kcis.016016E0AABB4ABC824358438D87FE25@mail>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25664/Sun Dec 15 10:51:05 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/15/19 10:09 PM, Lars Möllendorf wrote:
> -----Ursprüngliche Nachricht-----
>> Von: Lars Möllendorf <lars.moellendorf@plating.de>
>> Gesendet: Freitag 13 Dezember 2019 14:58
>> An: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
>> CC: Lars Möllendorf <lars.moellendorf@plating.de>
>> Betreff: [PATCH v3] iio: buffer: align the size of scan bytes to size of the largest element
>>
>> Previous versions of `iio_compute_scan_bytes` only aligned each element
>> to its own length (i.e. its own natural alignment). Because multiple
>> consecutive sets of scan elements are buffered this does not work in
>> case the computed scan bytes do not align with the natural alignment of
>> the first scan element in the set.
>>
>> This commit fixes this by aligning the scan bytes to the natural
>> alignment of the largest scan element in the set.
> 
> 
> 
> After re-reading my commit message, I come to the conclusion that it really is sufficient to align the scan bytes to the natural alignment of the *first* element. This would save us the `max()` comparisons for each bit. At the moment I am not at my workstation, but I could submit a v4 next Friday.
> 

I thought so too in the beginning, but as Jonathan pointed out, it does
not work for all cases. Lets say you have u16,u16,u32,u16. If all
channels are enabled the size is aligned to the first element, but the
u32 would not be aligned in the second dataset.

> 
> 
>> Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable much more
>> general.")
>> Signed-off-by: Lars Möllendorf <lars.moellendorf@plating.de>
>> ---
>> v3:
>>   - Fix the problem description in the commit message
>>   - Add "Fixes" tag
>>
>> v2:
>>   - Fix subject of patch which marked it the first in a set of three.
>>   - Add a description of the problem in the commit message
>>
>> ---
>>  drivers/iio/industrialio-buffer.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 5d05c38c4ba9..2f037cd59d53 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>  				const unsigned long *mask, bool timestamp)
>>  {
>>  	unsigned bytes = 0;
>> -	int length, i;
>> +	int length, i, largest = 0;
>>
>>  	/* How much space will the demuxed element take? */
>>  	for_each_set_bit(i, mask,
>> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>  		length = iio_storage_bytes_for_si(indio_dev, i);
>>  		bytes = ALIGN(bytes, length);
>>  		bytes += length;
>> +		largest = max(largest, length);
>>  	}
>>
>>  	if (timestamp) {
>>  		length = iio_storage_bytes_for_timestamp(indio_dev);
>>  		bytes = ALIGN(bytes, length);
>>  		bytes += length;
>> +		largest = max(largest, length);
>>  	}
>> +
>> +	bytes = ALIGN(bytes, largest);
>>  	return bytes;
>>  }
>>
>> --
>> 2.23.0
>>

