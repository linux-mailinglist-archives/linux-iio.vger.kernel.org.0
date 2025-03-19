Return-Path: <linux-iio+bounces-17077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2710A684BC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 07:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5213D3AACA5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2124E4CB;
	Wed, 19 Mar 2025 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4J4lsZu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B91598F4;
	Wed, 19 Mar 2025 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364150; cv=none; b=gfYRFuJeSbD6+0VLckv2f4jdXif/zo0WsXkEeXAPZwxXyen5tPWNlki94ueJpBWZbSuJ4EQD/qKhQbmP0swZNguYXs7QfUt7a8tAzmnFzajHyxrbumTKYJ2Mp/4FOiFWWQp3zEs4dRXLsvwFAAvz9d0c4D7yvJdgsYsDeyrptm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364150; c=relaxed/simple;
	bh=eORVI6Tzy9mBaDTciuUmVp6KL8cFOQLJyGQ3DFrXIdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABE2HUw6iuXtzlT1Yzqxs/C3Y6lHBHUnLL7FuDChR7u1zvXnC1D1PCUbN2DEc/ymsSgD7Au84jBPXCPSRuytW48XKTOCHe1FNBhZjvVSGrOx+MT+BEbuf06rvl0Ig2mU6AUOYNv546+rkj+i36aUmAOYjgp0GK5f/ow870iGs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4J4lsZu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30795988ebeso65576861fa.3;
        Tue, 18 Mar 2025 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742364147; x=1742968947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSxloc0O1A/DITw8sYD24uS54HnF7dqpvc1vk/u6miM=;
        b=G4J4lsZueHLWP2G9le7AQ3Y0kVPmglj3/HrIXFStUHghghU9Q0Yeg5Xoo6wXo0QY8h
         2fzuPCtPEflQYvazFlKVvOgO11ri14QrSXIMiC9Cv0qOjKgGrrS5nzP4k9u9E+r4xkIN
         J175W9EigU6bgFLS59jWM8JCtoYUkt2v3FMvcSZxuLKdWcz6pg+SqSQqcr7IHCs1XLK2
         Zg+7D0qogoS20mRb6To+Gv71RH2GC8/tcm6zA9y2+r0AkqGkXg83EGH7fHrZ93F/6krv
         RBeCqTioXujuW+BI5bFQ6W1o40SAPnz/JgmBVgA7hPVGAeiITotXqs6grCTZ32ae23XF
         bP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364147; x=1742968947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSxloc0O1A/DITw8sYD24uS54HnF7dqpvc1vk/u6miM=;
        b=OqJjmT4kSeO06/jPzSYYCQ/6xx40jh9wUUh1saOGevXCc2ibn4Q6LdK1c1DrHpuXbS
         pR+sf2pEuUNyjrno6NdnXnAhceCAP+wZBUbktvgH8oqcVbaURqjIkltzsQoSrh8qTOR6
         nSU1Cjew3OQkdn1XIruxeCiqBQsNkw0XFuprFZk1CBc+6pGjoZZu6uA8Dr8mWGZ1A43Y
         9DGopO73wGqByY4IToIBeaw5J+1c7EUULLOYFkc1XMw0Kl04BkfItwPOIfSK62yBJDn0
         pO28tbrWjRSmXmZqH5cKoodueQpqKsUIn2WkT0Pyn0sn5CYzr2t+LI8O6TcpOlOQlJSu
         yAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHbRl4qVSudWeqCXFf7IlhVsC6Wq8iq+0sqX1Rs8Td219jwHbua92PQnxpOCfHy8wlZQ57TOCPzE9zuDq@vger.kernel.org, AJvYcCVC9fyuOl0dmQ+veyLKzAP+IbdMJisG5MpwA58VSA66yf7LLo31/WnmuHm2ObXPXWpj7TCRoB+HGtn7@vger.kernel.org, AJvYcCVF2AGOiZko/3YELXs7cD0LlxelO4O+Gt+5vUsN7KMjTFMmES2v0Or2/yTlCCAo2SmBmJULFiW2+v+R@vger.kernel.org, AJvYcCW7154Ynh/qEf9JZViUDHZPtqjUP4G4cq9NfeIgmt2A3OxRxlpNzzRjsJTh/aR6DEmP+Wuetj7G@vger.kernel.org, AJvYcCXC+wBUZRdEUTBX+Pg8WVxOBj1hbrf/AH93N/nkkU78w6k04+7QqrFbJfnxSD5CqONTiEKJC9vFHDq+zA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+m9qPme2T6nID+AmHAzMbb+Y9ZKZCEMB//Lzt2kp5o9eoXUc
	hL+8fsKm/h52m1xCXpDYZ7tnI+vtW+hOkdWgEva4UF/CsHG5gOg5
X-Gm-Gg: ASbGncs53NiBpa812zdslwca0ukk8fseizLy9zRZrqcNvShO+EJUEHhxL8BXNmw0St1
	2ABdFVWq5kRj3w1iliiz/lZixonnemMkVEijzQtIkZBiPqO0r5i0BrhCz5a3ZllmkM5GzZgAYUj
	76nlJCooHorsYHGcpaqTZo4j9yAXWRz31XO+Vou+ZbsyFYYIOaPfCZXNS7cgbYAYZgC8e+/e760
	WXv4BmwlkchyZjNqLh03rRK9ThQAwvoJJnv24ArYqywLvdyHqom8QdQ34U70SVX2txQzqPUc5JQ
	pqcAksfu/MgHOI7x719rGck2N5IRXpnMAzebq+p9D+NHgOUwfvDfMC5vxiQ8ALXfoo38XfAMSST
	l/g2w2CoYRxDTt1ZZ37VkK23hyA==
X-Google-Smtp-Source: AGHT+IECU/HaiXIpx+kOzl0KCkWIkHUEs4v7kwUKNX6P59xrQ+6eN+uCfNBLwQp9ZO06uKklNlVcGg==
X-Received: by 2002:a2e:a54b:0:b0:30c:5c6:91e0 with SMTP id 38308e7fff4ca-30d6a3c622bmr5069121fa.2.1742364146428;
        Tue, 18 Mar 2025 23:02:26 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f10ab4bsm22288601fa.50.2025.03.18.23.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 23:02:25 -0700 (PDT)
Message-ID: <b6b62ddd-ab59-4112-8f6e-c72618c45910@gmail.com>
Date: Wed, 19 Mar 2025 08:02:24 +0200
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9mQPJwnKAkPHriT@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Moro Sakari,

Thanks for the review.

On 18/03/2025 17:24, Sakari Ailus wrote:
> Moi,
> 
> On Mon, Mar 17, 2025 at 05:50:38PM +0200, Matti Vaittinen wrote:
>> There are a few use-cases where child nodes with a specific name need to
>> be parsed. Code like:
>>
>> fwnode_for_each_child_node()
>> 	if (fwnode_name_eq())
>> 		...
>>
>> can be found from a various drivers/subsystems. Adding a macro for this
>> can simplify things a bit.
>>
>> In a few cases the data from the found nodes is later added to an array,
>> which is allocated based on the number of found nodes. One example of
>> such use is the IIO subsystem's ADC channel nodes, where the relevant
>> nodes are named as channel[@N].
>>
>> Add helpers for iterating and counting device's sub-nodes with certain
>> name instead of open-coding this in every user.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>> ---
>> Revision history:
>> v7 => v8:
>>   - Fix the example in fwnode_get_named_child_node_count() documentation
>>     to use the fwnode_get_named_child_node_count() and not the
>>     device_get_named_child_node_count()
>>   - Fix the rest of the new macro's indentiations
>> v6 => v7:
>>   - Improve kerneldoc
>>   - Inline device_get_named_child_node_count() and change it to call
>>     fwnode_get_named_child_node_count() inside
>>   - Fix indentiation of the new macros
>> v5 => v6:
>>   - Add helpers to also iterate through the nodes.
>> v4 => v5:
>>   - Use given name instead of string 'channel' when counting the nodes
>>   - Add also fwnode_get_child_node_count_named() as suggested by Rob.
>> v3 => v4:
>>   - New patch as suggested by Jonathan, see discussion in:
>> https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
>> ---
>>   drivers/base/property.c  | 27 +++++++++++++++++++++++++++
>>   include/linux/property.h | 24 ++++++++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index c1392743df9c..f42f32ff45fc 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -945,6 +945,33 @@ unsigned int device_get_child_node_count(const struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(device_get_child_node_count);
>>   
>> +/**
>> + * fwnode_get_named_child_node_count - number of child nodes with given name
>> + * @fwnode: Node which child nodes are counted.
>> + * @name: String to match child node name against.
>> + *
>> + * Scan child nodes and count all the nodes with a specific name. Potential
>> + * 'number' -ending after the 'at sign' for scanned names is ignored.
>> + * E.g.::
>> + *   fwnode_get_named_child_node_count(fwnode, "channel");
>> + * would match all the nodes::
>> + *   channel { }, channel@0 {}, channel@0xabba {}...
>> + *
>> + * Return: the number of child nodes with a matching name for a given device.
>> + */
>> +unsigned int fwnode_get_named_child_node_count(const struct fwnode_handle *fwnode,
>> +					       const char *name)
>> +{
>> +	struct fwnode_handle *child;
>> +	unsigned int count = 0;
>> +
>> +	fwnode_for_each_named_child_node(fwnode, child, name)
>> +		count++;
>> +
>> +	return count;
>> +}
>> +EXPORT_SYMBOL_GPL(fwnode_get_named_child_node_count);
>> +
>>   bool device_dma_supported(const struct device *dev)
>>   {
>>   	return fwnode_call_bool_op(dev_fwnode(dev), device_dma_supported);
>> diff --git a/include/linux/property.h b/include/linux/property.h
>> index e214ecd241eb..a1856e6b714c 100644
>> --- a/include/linux/property.h
>> +++ b/include/linux/property.h
>> @@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>>   	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
>>   	     child = fwnode_get_next_child_node(fwnode, child))
>>   
>> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
>> +	fwnode_for_each_child_node(fwnode, child)			\
>> +		if (!fwnode_name_eq(child, name)) { } else
>> +
>>   #define fwnode_for_each_available_child_node(fwnode, child)		       \
>>   	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>>   	     child = fwnode_get_next_available_child_node(fwnode, child))
>>   
>> +#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
>> +	fwnode_for_each_available_child_node(fwnode, child)		\
>> +		if (!fwnode_name_eq(child, name)) { } else
>> +
> 
> OF only enumerates available nodes via the fwnode API, software nodes don't
> have the concept but on ACPI I guess you could have a difference in nodes
> where you have device sub-nodes that aren't available. Still, these ACPI
> device nodes don't have meaningful names in this context (they're
> 4-character object names) so you wouldn't use them like this anyway.

I believe you have far better understanding on these concepts than I do. 
The reason behind adding fwnode_for_each_available_child_node() was the 
patch 10/10:

-	fwnode_for_each_available_child_node(sensors, node) {
-		if (fwnode_name_eq(node, "sensor")) {
-			if (!thp7312_sensor_parse_dt(thp7312, node))
-				num_sensors++;
-		}
+	fwnode_for_each_available_named_child_node(sensors, node, "sensor") {
+		if (!thp7312_sensor_parse_dt(thp7312, node))
+			num_sensors++;
  	}


> So my question is: is it useful to provide this besides
> fwnode_for_each_named_child_node(), given that both are effectively the
> same?

So, I suppose you're saying the existing thp7312 -driver has no real 
reason to use the 'fwnode_for_each_available_child_node()', but it could 
be using fwnode_for_each_child_node() instead?

If so, I am Ok with dropping the 
'fwnode_for_each_available_named_child_node()' and changing the 10/10 to:

-	fwnode_for_each_available_child_node(sensors, node) {
-		if (fwnode_name_eq(node, "sensor")) {
-			if (!thp7312_sensor_parse_dt(thp7312, node))
-				num_sensors++;
-		}
+	fwnode_for_each_named_child_node(sensors, node, "sensor") {
+		if (!thp7312_sensor_parse_dt(thp7312, node))
+			num_sensors++;
  	}

Do you think that'd be correct?

Yours,
	-- Matti

