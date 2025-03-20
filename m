Return-Path: <linux-iio+bounces-17134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E8A69FF1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 07:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6403B1C89
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4A1EDA1A;
	Thu, 20 Mar 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePy8Qwn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9215A8;
	Thu, 20 Mar 2025 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453032; cv=none; b=eLK7PgJU3HKshvFUyphnsyJID5GA/2bR29uYKR6hYj2xTBmYgUlh/tXWvaB2BHpx+Xq8oJOqjH7CdmSa/qAT+fAC8Zh+GMRHOncszxEDQicZpCT+tN+ovb4mUg+VckJKJneHy92LpM20f0E8QpCEEIj7DLLhbAcjmLO9p2ITHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453032; c=relaxed/simple;
	bh=bxV10aeKuKpjW/XnZP7EGhWHdrE3XnNoXKKs+2oEYy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqthBT1mvrgFjtT/S5sXzXf7/KPklgPvYa5lYMwVky7ygmOXrHD1loZ5TXzp9PBA51rQhJwqdigZIRkOvFbgAijhZsnve/zxx3jKznD70LAglps83RzlkrfYb3CLbbs2hfVhrDtUKmxnmSPpxNAz3T+6E7pisY6h4c+HWOZMNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePy8Qwn+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-548409cd2a8so456546e87.3;
        Wed, 19 Mar 2025 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742453029; x=1743057829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjA9p+f6Pwh48uDlltqQXJZ0FW06r+cLM9uK0XZnr+Q=;
        b=ePy8Qwn+n9dn514DCTAD1fVEIIe5MwIngfmJh/jwmf0Ht/2173kBKIbyz+YfPNLYpe
         LecFiiGYoYUorLB38S+ZXsRvkOQcUD4Yqg++//YO29GXFlIadori7bikqhwwQa/QhwAM
         bglyby7oJ+M6mUVaCfp7WocQYKpu1661q8DXeOuy6XLnTV+u1f65V44ZLZTKQJmbNuby
         dRMC4K/tpWL4MrwWKd6QUVVTyLLdumwZQ12EOTntAX2eaa23tPeHrqavad7qqWyoI6wI
         hTZDAefEPtPgBv+BHXe9XS5bXX3nNR5iCNySMMU/ksqqukplaLywQqlKk0JMgEEVhC4p
         ZRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453029; x=1743057829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjA9p+f6Pwh48uDlltqQXJZ0FW06r+cLM9uK0XZnr+Q=;
        b=civCISnBgZ94HhmZOCn9Pab52Gs67s2eByEOzRFfbycpiDnFDdjW3iW2FObtvUk67X
         J9VADulhm1qqs1k8mPJDeprplc8fFBy0crovSSsjkhfi6NzD5Ftzlku+0Y8SILzMWR1g
         pOflirHlW0URBFCxKY9jMJAX4vhKG4mrjhwgCnMy2SYlBBUl0qLjpVtyNmKi4PPj+jTR
         OYfTJll5KJDl4/fMqT//q0QS0pCXIze3S0DAa1IMX92n6XnyvkB85fufzkd9JhBvHriW
         odedJcDjk/MK2lMBMFZ8YA3ldzqsJKfOwJMQfcz3D+JMoRRNVzeyWjlI5FYdFJEVwuRi
         lwqA==
X-Forwarded-Encrypted: i=1; AJvYcCUAaJlHqPS5TZr84HYLcyiZ8mgEg1pdzwdLGIhhzgvKjjBYausPbKnWHHIYuNwa5Jv+QJvSVr2pt/NA@vger.kernel.org, AJvYcCVOI/rYLlzfGYGrBx8aLwmt2R656xp3ic1OTLhRgjzTPhmSjvAAa+q8NP6jjMoLwYCy2ThnUx0J@vger.kernel.org, AJvYcCXfo1B01aMRNU+kVzn409jWWCKVULUdgepVVAz94wLoA34hlTA73DGOy0v9E35Dm0/a8cE/bYQcPg7/Fg==@vger.kernel.org, AJvYcCXlBnffSM3H8NCPLXAlnszyTBXlyqGHBH8tQNTnNJVjNN7Kg/BW+XZDV2Yj18TTfYhiYYAppZ5F3B/K@vger.kernel.org, AJvYcCXwjNkcJ+JtkEZM/OUqSPsBdhQYP4QArp5YzVcvWEPJ6Bj0yFCJB4L1B3jbk30EBK3GpcMqPuZJnlMKP+7u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5g58Tg8n9CFe3Z5xSUw42neTloxJAMVeenaXm4d/mctvGdlTJ
	qCf5IkpE39oskOJ2WGeaN8k7p/wlujHqosaCiiDw94EA4tW506qw
X-Gm-Gg: ASbGncsDtlLr39HxTovJR6CybPQ/3ppqxxXq67xfYLR0aaCwh9uMso/URq/CXnaAx2n
	PG/95QBj/O9KXlGg7Y8bpaqCsEVZBODsvD5OyD35wlyEMwcS5zDT8coa5ioAvEK6d8b7lBMXfy0
	yVyZuGxbqTz8X8toOM0DOrhjqftD3F1lMNLJbiIf3Fpk7WyDbqmnMn/1mC/qB2O8aMhTzlwmRO3
	4JFhrqSqDYTzlDQOMYYg60+72eUgqO1oO6J3umfnDjk7D7ZBnZMyVJbv63vkSU8pvLXrUkq6g8Y
	hekYOz8+atoZkOqhFO4Xyg5lu41im7KoaExso9g1vb1XGJgR/p9DDVP0UGsh4NG67PNy88FibCv
	qm6andFpJdWtvGzk78u8dpGzpog==
X-Google-Smtp-Source: AGHT+IHGUK3HewyiQse5hGY++z4CyK4iNp6IEb/XXw2pnNDNO4zh1yb5EXufOlBswwNLqXIWSjkcug==
X-Received: by 2002:ac2:4e0d:0:b0:549:9009:77c8 with SMTP id 2adb3069b0e04-54acb1a4a45mr1640970e87.9.1742453028540;
        Wed, 19 Mar 2025 23:43:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7ce9e3sm2137164e87.106.2025.03.19.23.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:43:46 -0700 (PDT)
Message-ID: <726281b2-66f5-45e9-94f2-4f79b4ab159d@gmail.com>
Date: Thu, 20 Mar 2025 08:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/10] property: Add functions to iterate named child
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>
 <Z9mQPJwnKAkPHriT@kekkonen.localdomain>
 <b6b62ddd-ab59-4112-8f6e-c72618c45910@gmail.com>
 <Z9rhfJUlCbi7kA2m@kekkonen.localdomain>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9rhfJUlCbi7kA2m@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 17:23, Sakari Ailus wrote:
> On Wed, Mar 19, 2025 at 08:02:24AM +0200, Matti Vaittinen wrote:
>> On 18/03/2025 17:24, Sakari Ailus wrote:
>>> On Mon, Mar 17, 2025 at 05:50:38PM +0200, Matti Vaittinen wrote:
>>>> There are a few use-cases where child nodes with a specific name need to
>>>> be parsed. Code like:

...

>>>> --- a/include/linux/property.h
>>>> +++ b/include/linux/property.h
>>>> @@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>>>>    	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
>>>>    	     child = fwnode_get_next_child_node(fwnode, child))
>>>> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
>>>> +	fwnode_for_each_child_node(fwnode, child)			\
>>>> +		if (!fwnode_name_eq(child, name)) { } else
>>>> +
>>>>    #define fwnode_for_each_available_child_node(fwnode, child)		       \
>>>>    	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>>>>    	     child = fwnode_get_next_available_child_node(fwnode, child))
>>>> +#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
>>>> +	fwnode_for_each_available_child_node(fwnode, child)		\
>>>> +		if (!fwnode_name_eq(child, name)) { } else
>>>> +
>>>
>>> OF only enumerates available nodes via the fwnode API, software nodes don't
>>> have the concept but on ACPI I guess you could have a difference in nodes
>>> where you have device sub-nodes that aren't available. Still, these ACPI
>>> device nodes don't have meaningful names in this context (they're
>>> 4-character object names) so you wouldn't use them like this anyway.
>>
>> I believe you have far better understanding on these concepts than I do. The
>> reason behind adding fwnode_for_each_available_child_node() was the patch
>> 10/10:
>>
>> -	fwnode_for_each_available_child_node(sensors, node) {
>> -		if (fwnode_name_eq(node, "sensor")) {
>> -			if (!thp7312_sensor_parse_dt(thp7312, node))
>> -				num_sensors++;
>> -		}
>> +	fwnode_for_each_available_named_child_node(sensors, node, "sensor") {
>> +		if (!thp7312_sensor_parse_dt(thp7312, node))
>> +			num_sensors++;
>>   	}
>>
>>
>>> So my question is: is it useful to provide this besides
>>> fwnode_for_each_named_child_node(), given that both are effectively the
>>> same?
>>
>> So, I suppose you're saying the existing thp7312 -driver has no real reason
>> to use the 'fwnode_for_each_available_child_node()', but it could be using
>> fwnode_for_each_child_node() instead?
>>
>> If so, I am Ok with dropping the
>> 'fwnode_for_each_available_named_child_node()' and changing the 10/10 to:
>>
>> -	fwnode_for_each_available_child_node(sensors, node) {
>> -		if (fwnode_name_eq(node, "sensor")) {
>> -			if (!thp7312_sensor_parse_dt(thp7312, node))
>> -				num_sensors++;
>> -		}
>> +	fwnode_for_each_named_child_node(sensors, node, "sensor") {
>> +		if (!thp7312_sensor_parse_dt(thp7312, node))
>> +			num_sensors++;
>>   	}
>>
>> Do you think that'd be correct?
> 
> I'd say so. Feel free to cc me to the last patch as well.

Thanks. I'll drop the fwnode_for_each_available_named_child_node() then.

> I guess one way to make this clearer is to switch to
> fwnode_for_each_child_node() in a separate patch before
> fwnode_for_each_named_child_node() conversion.

I suppose this makes sense.

I think this series can't make it to 6.15-rc1. Meaning, these 
*_named_*() APIs perhaps land in 6.16-rc1. I assume these *_named_*() 
APIs will go through the IIO. This rather simple IIO driver's review 
took longer than I predicted, with more versions I intended (as always) 
- and I kind of dislike respinning the whole series, with this large 
audience, when changes are not interesting to the most.

Maybe it is simplest to drop the thp7312 (and gianfar) from this series, 
and respin them only when the 6.16-rc1 is out. It's going to be couple 
of months though - so there's always a risk that I forget.

The proposed change for the thp7312, from 
fwnode_for_each_available_child_node() to fwnode_for_each_child_node() 
can be done earlier though.

> There are also just a handful of users of
> fwnode_for_each_available_child_node() and I guess these could be
> converted, too, but I think it's outside the scope of the set.

Definitely not in the scope of the bd79124 support :)

Yours,
	-- Matti

