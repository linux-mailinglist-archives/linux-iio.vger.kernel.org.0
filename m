Return-Path: <linux-iio+bounces-9893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF29896CB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150451F21CAD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD59487BF;
	Sun, 29 Sep 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUDst9rb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC118641;
	Sun, 29 Sep 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635546; cv=none; b=MSO8eIZKRH7BihtIF7TFBKsrwlnNk3DuSPQ5fkAg52jZ69j3VeFNtafx/ePWLVHn6WIOsCJnA6JAxO7KkwnHjqZU9sjm3bwIwc5fqGzCNf972U+/qgPXBNy+oX4+GKZw5Ee3jSTAJf0VOMLhARf0Jf1shtos1BDC3nmYz6S+Xow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635546; c=relaxed/simple;
	bh=uYls481jlDe0DTJnA7lUtIOzYy0kIMsHafgrDtax/FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knnWyZ8v8uWEjvzphq21y873/qdXh/Kc+6deLf/tRMfW2nFJYm84QbG9iNeQT4wVEEt+qWr8Je/2aj2hHioAdVZqUdclKiqX5xJKbB4jmfSz35nhBjoYXQwGcCm5q2GiKUxPchUiI1V5nm79EHsV7yU12NVLQiNmJgllAZPp1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUDst9rb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso4252688a12.1;
        Sun, 29 Sep 2024 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727635543; x=1728240343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XQ5+9bYl+OA/OhjnjesBHAyLC1+4svUXWybex59KOE=;
        b=EUDst9rbK3lNwVv30ju3kdHcoj0mKeXt2SVTGg6WzHvnZBjhW+7X8h74ko/TREVG6h
         cW7PKoJfA274pBZKnVGXBDE88MhwJj8rCiEXvMXDEOnD9N2LO0xdy+GbrwubiAKYhyOV
         VgEae6ujObJkVPkLxJAdEpwqO7RH+U60mOCd8ehArT25aUaGkwc9u45Zwm23ofm3WmNU
         92omiCryNeU4ruIhOW09dLUzvx7hcqg00B+rVaJKURbqf8Bs7rv75UlsLV9v1cYDdLio
         QuejJ8cP/6Jf1QFIWecMK6ubM/JuMIwhuvLWn5TNLX3rsjNLi45aiWDFyP494wjMu0mF
         ulaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727635543; x=1728240343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XQ5+9bYl+OA/OhjnjesBHAyLC1+4svUXWybex59KOE=;
        b=qw67HMr4uSJTLV7BiP8Udd4x4GoxX+38j0LfAPTUTG7Oiz7Bvu0SsiAo4IPr1TPZlj
         a93RZCGNsxX37aWOEeUUrwSCHCohNJ5ZdjaFQPCfIf/OBGhxY8Y0Sy3pL4aoDLHqK/uh
         +svlafMV1yRnSEgkQg8xnMzmqDH5vpemKIU8+AO4S3rcF2o6EFcEXRKERpyWveuIQN5j
         CBWhfi5lhG3b4SYRp4FBaTJZdhRqBoS1x92h34Y4iRA7jiSOWet4eOnHL+YGrs+NkL1P
         uaPXziSJP1468+vAwNd/gLwjKHsLuG4aYxOdNzvWDrP5m5KdIIu+ICVRjHFmgjN5Ut+H
         xxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAuYG667eo3RJSnOe53Wby6x4D8IX33wv5a/2RrbtIGvOkXCXsyXC3WwWiF1nJcPzTdHzNJoR49qGm@vger.kernel.org, AJvYcCWHsGZe7TaDcqPs1SWxWz1ABLlA7jKig+cxidhiYrGG/2ZLNa0PBXEN0XBJQo0q7xuHIUTNcTKHSU1vm/+d@vger.kernel.org, AJvYcCWJQcWet3KCqitzcPXZO0ZCRpk69xaBfmJaHZTb3j6PlMIvM2uEhOgMDHFuy9T5DfCBbOT0hqrW4Ydo@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9WR7i4Hw7cceVTeCQe7G3GL6s3+XEK/+7VAWV5iwbUhdNlPX
	irTHkVuMVVeYg+vtRhaV3KT+r09sQTw/yrfWx7rAqG2d/fx+l5IQ
X-Google-Smtp-Source: AGHT+IFOZFQUTLWY7kdVEDbwWE9GVkSr3ezpnMEaf9UamCwAtr86MOfeL+o7Mv47hqGghyTofWfdCw==
X-Received: by 2002:a17:906:794d:b0:a7a:9ca6:527 with SMTP id a640c23a62f3a-a93c48f0dd1mr1198590566b.8.1727635542572;
        Sun, 29 Sep 2024 11:45:42 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:e2c0:9a60:64a8:717a? (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5a7dsm412361266b.62.2024.09.29.11.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 11:45:42 -0700 (PDT)
Message-ID: <b4a72e65-b8b0-41da-ac6e-372371f3943a@gmail.com>
Date: Sun, 29 Sep 2024 20:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iio: light: veml6030: use read_avail() for
 available attributes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
 <20240923-veml6035-v2-6-58c72a0df31c@gmail.com>
 <20240928171922.0caccaf3@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240928171922.0caccaf3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2024 18:19, Jonathan Cameron wrote:
> On Mon, 23 Sep 2024 00:17:54 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> Drop custom attributes by using the standard read_avail() callback to
>> read scale and integration time. When at it, define these attributes as
>> available by all channels, as they affect the values of both the ALS and
>> the WHITE channel.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier
> 
> Some comments inline
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/light/veml6030.c | 64 +++++++++++++++++++++++++++++++-------------
>>  1 file changed, 45 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>> index 89c98bfc5191..a3190fab3add 100644
>> --- a/drivers/iio/light/veml6030.c
>> +++ b/drivers/iio/light/veml6030.c
>> @@ -58,25 +58,24 @@ struct veml6030_data {
>>  	int cur_integration_time;
>>  };
>>  
>> -/* Integration time available in seconds */
>> -static IIO_CONST_ATTR(in_illuminance_integration_time_available,
>> -				"0.025 0.05 0.1 0.2 0.4 0.8");
>> +static const int veml6030_it_times[][2] = {
>> +	{0, 25000},
> Really minor but I'm trying to get IIO standardized on formatting for this
> sort of array and I'd like not to introduce more instances of it
> done without the extra spaces as it will just give more to clean up
> at some point.
> 
> 	{ 0, 25000 },
> etc please.
>> +	{0, 50000},
>> +	{0, 100000},
>> +	{0, 200000},
>> +	{0, 400000},
>> +	{0, 800000},
>> +};
>>  
>>  /*
>>   * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
>>   * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
>>   */
>> -static IIO_CONST_ATTR(in_illuminance_scale_available,
>> -				"0.125 0.25 1.0 2.0");
>> -
>> -static struct attribute *veml6030_attributes[] = {
>> -	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
>> -	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
>> -	NULL
>> -};
>> -
>> -static const struct attribute_group veml6030_attr_group = {
>> -	.attrs = veml6030_attributes,
>> +static const int veml6030_scale_vals[][2] = {
>> +	{0, 125000},
>> +	{0, 250000},
>> +	{1, 0},
>> +	{2, 0},
> 
> As above, add some spaces for minor readability improvement.
> 
>>  };
>>  
>>  /*
>> @@ -197,9 +196,11 @@ static const struct iio_chan_spec veml6030_channels[] = {
>>  		.type = IIO_LIGHT,
>>  		.channel = CH_ALS,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> -				BIT(IIO_CHAN_INFO_PROCESSED) |
>> -				BIT(IIO_CHAN_INFO_INT_TIME) |
>> -				BIT(IIO_CHAN_INFO_SCALE),
>> +				BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					       BIT(IIO_CHAN_INFO_SCALE),
> This bit is an ABI change and technically old code wasn't a bug, so
> we don't really have a good enough reason to change it.  So Please
> leave these as separate.
> 
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SCALE),
> That doesn't stop us sharing the available as that always was shared
> in the attribute naming above.
> 
>>  		.event_spec = veml6030_event_spec,
>>  		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
>>  	},
>> @@ -210,6 +211,10 @@ static const struct iio_chan_spec veml6030_channels[] = {
>>  		.channel2 = IIO_MOD_LIGHT_BOTH,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  				BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +					       BIT(IIO_CHAN_INFO_SCALE),
> This confuses me.  Is it fixing a bug by effectively adding attributes for this
> channel that were previously missing? If so we'll have to go with searpte
> even though they are shared to avoid breaking the ABI for other channel.
> 
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>> +						     BIT(IIO_CHAN_INFO_SCALE),
>>  	},
>>  };
>>  
> 
> 

This confused me as well, because even though the attributes where
defined as separate for the ALS channel, modifying their values affected
the values from the WHITE channel.

The integration time and the scale affect both channels, and therefore I
thought they should be shared attributes. But in that case, and to avoid
breaking the ABI for the other channel, I will make them separate even
though writing to one of them will change the value of the other as well.

Thanks and best regards,
Javier Carrasco


