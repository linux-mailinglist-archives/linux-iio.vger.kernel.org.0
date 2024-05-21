Return-Path: <linux-iio+bounces-5147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FBC8CA634
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 04:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B53B20FFB
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6ABA53;
	Tue, 21 May 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ahepp.dev header.i=@ahepp.dev header.b="R+0IK7Ws"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-108-mta150.mxroute.com (mail-108-mta150.mxroute.com [136.175.108.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D317C6D
	for <linux-iio@vger.kernel.org>; Tue, 21 May 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258836; cv=none; b=GGAC+/eZ1TO46nOzKumJ3Q8va5XyWH/2NweWTTabu+2o52QEfBNzoSXBQKekOgARNTW/3RcGr8l077PiT7Pq08zqDgtff7iHQxJFuzf+ndf1pGiG3N9/UacvBg9IKQB8PNeTSieEuF64Txuj1gMmU+Ypfv7VafwYFX99fs3fUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258836; c=relaxed/simple;
	bh=zmXrS54sHl2ot3sb0GSDnnJCgcLWipCPzke2GVOr8Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXJbDS9DTf/X6+zNUqpR1USBhkO+Moorp6rhlTsUN4ptLY1c78H/c5oYd/WCSuZVxBAeIDRzRDisLA1AZ+s1TkeNZdZStoIO4OWOkqhd/ZyZpbYKJGR8qFjtllRZfjyd/IZeYoiyzKdLSZ4AwQiNmnu/WnXJRJWtkUtoKWVUZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ahepp.dev; spf=pass smtp.mailfrom=ahepp.dev; dkim=fail (0-bit key) header.d=ahepp.dev header.i=@ahepp.dev header.b=R+0IK7Ws reason="key not found in DNS"; arc=none smtp.client-ip=136.175.108.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ahepp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ahepp.dev
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta150.mxroute.com (ZoneMTA) with ESMTPSA id 18f98faac6c000efce.006
 for <linux-iio@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 21 May 2024 02:28:36 +0000
X-Zone-Loop: b3278291c8182f5a2e2e7283047ba864dab6f5a6a5af
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:
	To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iWaHaAPhmhUih0P5E+3/squCGgKZImlbCGWTxIoVtmU=; b=R+0IK7Wsi9kaNB0UenGOVgeVnd
	IK7juYKmsAkINgqylrSS/Na05o+Xd39u5o7GOgXoZBzroVuJTtD8HBFfbbG1BZcOExfyZD2MKnL/X
	VUKl8kDeTHmIPPrRMcMZcifw4f8PIFYUkcfwni54ycK05PqwrGKanJAtv4LO4bbinCMahMUs2TiC6
	WM4PoV5JY9TM/TsV953t56wl6SDsaxS7j8wbwkMq4cjHXuY24YUspHL1YyIYipPkixxSUCkhykMMT
	OLO8QxiNnA6l6gGhED2xo7TbqczUZdZRwmDX6Uk+XM0BMj+qTMeU2MGdPNsZU0tGjlsQYg9f3bXD8
	Yi95XZzg==;
Message-ID: <23efcf4c-b5b2-d245-931f-0420e61701fe@ahepp.dev>
Date: Mon, 20 May 2024 22:28:10 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for both
 channels
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>,
 Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
 <20240517081050.168698-2-dima.fedrau@gmail.com>
 <20240519171438.08810789@jic23-huawei>
From: Andrew Hepp <andrew.hepp@ahepp.dev>
In-Reply-To: <20240519171438.08810789@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev

Hi all,

I attempted to send this yesterday, but I guess I leaked some HTML into 
the message and it was rejected from the lists. I am resending it now as 
plain text. Apologies for any inconvenience or confusion.

On 5/19/24 12:14 PM, Jonathan Cameron wrote:
> On Fri, 17 May 2024 10:10:49 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
>> The mapping from cold junction to ambient temperature is inaccurate. We
>> provide an index for hot and cold junction temperatures.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Hi Dmitri,
> 
> I'm not sure you replied to the question in previous review of what
> sysfs files exist for this device.  Whilst I am at least a little
> open to changing the ABI, I'd like to fully understand what
> is currently presented and why iio_info is having trouble with it.
> 
> I also want an ack from Andrew on this one given might break it existing
> usage.

I’m not actively using the cold junction temperature reading, so I would 
be happy to see any deficiencies in the ABI corrected.

> 
> The current interface is perhaps less than ideal, but I don't think it
> is wrong as such. Whilst I wasn't particularly keen on the cold junction
> == ambient I'm not sure moving to just indexed is an improvement.
> Hence looking for input from Andrew. +CC Nuno as someone who is both
> active in IIO and has written thermocouple front end drivers in
> the past.

The ABI docs state

     The ambient and object modifiers distinguish between ambient 
(reference) and distant temperatures for contactless measurements
Reading more of the Linux Driver API docs, those say that .modified is 
"used to indicate a physically unique characteristic of the channel”, 
and that .indexed is "simply another instance”.

I’m not sure whether measuring temperature at a different location meets 
the bar of a “physically unique characteristic”. Maybe it does. But I 
don’t think of the cold junction temperature as “simply another 
instance”. Perhaps that’s a mistake on my behalf.

Reviewing temperature drivers using IIO_MOD_TEMP_AMBIENT, they all seem 
to be reporting die temperatures. Some are IR sensors, but there are a 
couple other thermocouples like the MCP9600.

Reviewing drivers using “.indexed”, one is an IR sensor and one is a 
thermocouple. In both cases, the indexed channels seem to represent a 
“full featured” channel. The IR sensor also reports 
IIO_MOD_TEMP_AMBIENT, so they chose not to make it an additional index.

It seems to me that using IIO_MOD_TEMP_AMBIENT is more in line with what 
has been done in the past. But I may be misunderstanding something and I 
am not opposed to using and index if it’s determined that is more correct.

Thanks,
Andrew

> 
> Jonathan
> 
> 
>> ---
>>   drivers/iio/temperature/mcp9600.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
>> index 46845804292b..22451d1d9e1f 100644
>> --- a/drivers/iio/temperature/mcp9600.c
>> +++ b/drivers/iio/temperature/mcp9600.c
>> @@ -14,6 +14,9 @@
>>   
>>   #include <linux/iio/iio.h>
>>   
>> +#define MCP9600_CHAN_HOT_JUNCTION	0
>> +#define MCP9600_CHAN_COLD_JUNCTION	1
>> +
>>   /* MCP9600 registers */
>>   #define MCP9600_HOT_JUNCTION 0x0
>>   #define MCP9600_COLD_JUNCTION 0x2
>> @@ -25,17 +28,19 @@
>>   static const struct iio_chan_spec mcp9600_channels[] = {
>>   	{
>>   		.type = IIO_TEMP,
>> +		.channel = MCP9600_CHAN_HOT_JUNCTION,
>>   		.address = MCP9600_HOT_JUNCTION,
>>   		.info_mask_separate =
>>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +		.indexed = 1,
>>   	},
>>   	{
>>   		.type = IIO_TEMP,
>> +		.channel = MCP9600_CHAN_COLD_JUNCTION,
>>   		.address = MCP9600_COLD_JUNCTION,
>> -		.channel2 = IIO_MOD_TEMP_AMBIENT,
>> -		.modified = 1,
>>   		.info_mask_separate =
>>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +		.indexed = 1,
>>   	},
>>   };
>>   
> 

