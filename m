Return-Path: <linux-iio+bounces-16241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B91A4B18B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5227C3AD50F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB491E32C5;
	Sun,  2 Mar 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddwnze2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A865258;
	Sun,  2 Mar 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918182; cv=none; b=REB+lbpzXCE/eRfIQYaSKyE0XYQKbYfDU0QPjhaGrjh+zynhVJOp8bye9AfLDVLYiKuQEEYAomc7DJxUHiiW7ujUvRGMivPpCcueI0HjXdsryRMCkiw7hw54oHGvu9/iBWH+4/OfyzcTrlz/bskDAnRWHeQGaaTk41a5SCdaVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918182; c=relaxed/simple;
	bh=hKBTReK3pH8mU/iYRfyBVCfJp0R5KMbvtZlOdcY8Wf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWzqzqVnwQNhviyMgJNOPb+yCEYL233GZKluLLLur90A6Pm/AdOf4HvzRiVJAZ+PIcIxuv+SgD7qbRe1FpqC9L8iaAz4igAoALzzKtyjwzdCpXfRk7NZ7KyKbqVF7gxJVS7gr5hSYQsWBLN8KKJh7Jqhylb6CESCv5o36NBMjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddwnze2/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5494bc4d741so2831941e87.2;
        Sun, 02 Mar 2025 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740918178; x=1741522978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEnnc1dXj5lNrYUNbaQiHP03Z2g3b2VRGVuLnQpfuiI=;
        b=Ddwnze2/71sSuaH7gOaWV+JhcmO5h91/BNntYcNLnfsriUabwpi22vE9ENV+BgRacl
         Hkbzt9J0q9qIoW0jeSnQP66n3afZ7CrEq6iBV7LoNvl4+9+G09UBMnqLTVyjfJWXTHm1
         TAmVDREzdOWJf0e0+awRYSsSNqC2ACqpuGb/bLNZsgBWiMjiApyZM4yj4fJkzbOAD653
         7PuyfxOGJLn5v7GyAXt5H/4lLEKLlbOnj2auNqIAeN/9BO4Wo7OswjqwX0mXK5aKHWrM
         5kBU0XfgVackkPaa51tOF9NKqWySxTmA6q0IDdEntdqEGH2VKT7CMpedkGKbIne13ZFC
         aazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740918178; x=1741522978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEnnc1dXj5lNrYUNbaQiHP03Z2g3b2VRGVuLnQpfuiI=;
        b=n6RiTy8XWc5Sg6jg89TJ+SWJOaPbVV9NX75JCZaUyeQ5f6ZrUpAiu4pGc9BfyKnSci
         Qfomh9a3IhSjtbjOq0KVrcd9Uo/kCPyPXNvYh0yJmKstaV501rRA1LaH0h35k0c173/d
         lxoOhh4p78Z5+ccxAZW/2gWt3abvbxcBY79PolVDNtzKDVvWPJZkWdu8lrR4dfokbUaM
         PYNIyFawLM51ct4x5eadnn49fW8+q06BBiE1IOeXpPt98AvcqIbMS4K9KnQTT/h79q3p
         gNRp3B3Ba0Ej/XoAzGvoKkMEksgPzs61/m+LZ6xIYU+Q72bMd8XW0M0LSvLIfzU6cekP
         xQEA==
X-Forwarded-Encrypted: i=1; AJvYcCUR9z3yZCWImDzRL7V6LrpweHqwcfX82r99nYILMtR2kG+Qsl/ivlCevJ8uQUTtqneBx0oNQ/bEAjbZ@vger.kernel.org, AJvYcCVEf9S1KGPYnq/ILxlijcbV1Aj88ULVdouwUmdJiYFRYZodPl/JtQ4XBPJuZ4adeTVq+0/PT0ddbXy7TcGx@vger.kernel.org, AJvYcCWOQ3u051Uw+IoP5iqvjypFCbnz4WAc58EzXRoVkEwRVZ5iQlm994HhQZxnpiCMuC5Iq60aoxce44XeSQ==@vger.kernel.org, AJvYcCWf/EazPo9nWIIFits7C0Ei7yLTEzNcbfBQyWPvKzAi1aNZJmgtxVuBbgi2EzMO9iJfUHG04bnb+jsGI1MPiDjvfXg=@vger.kernel.org, AJvYcCXCqoq1/N/48l3Z7xnLazd2EOyomsoFX7ULbsDs+8Jg8PgJFSrWrIGv2vByoGm7wrjSp8IuBMre+NrM@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2Ps7HvfY3D+i7jO3fyRXtAKmI/QJ8kGMRuhAqkoXIQOVrvpV
	MZfZhMRnKz09d6B5sp1NHkbWF9/lBVwPvV9tqAccDYEIurCBUxzm
X-Gm-Gg: ASbGnct61DVI/m5TijTOPHVCoJ5vS7Nm+vfXfgCF0pKpDnO8lbD+9Ck5mUUucK80M20
	jlNLSg7hDU/L2zfg0ZPe77VlYCkYWy7rhkPqo9gRVeiwVySftpNbgKL7I8coyehpNpGRrUgVhMS
	UPakwNOcgB2xeWWBOmypsW02fZcKUeMLZi+afnip/VpoTWVu8ZHZFR9EfFOE/govNB46OlxqzXA
	GYik2j5axQybc2RX7R94jNTFoiUpOstR+qELYgrKK/nGJwUr6rpjACZMazj7AYCch33k5B24HXi
	DZNzC2ZOimYvEiPkc4yDF9hLTc+rEpJP8JoHmiGSOkIRqGQfTzrG+5QOQLaTrxiBSFl4vSnwN7W
	FKvN4cfJr7k9pdo8WYsNvyVZCqg==
X-Google-Smtp-Source: AGHT+IGzZOd1/B02IxZfr4aBje6krfoPxLPc1fsPRoUlTQWF7jrLAwZCd5QWTmq/yw9opL1lzwKo7Q==
X-Received: by 2002:a05:6512:1044:b0:543:baa3:87ab with SMTP id 2adb3069b0e04-5494c354581mr4068349e87.47.1740918178086;
        Sun, 02 Mar 2025 04:22:58 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bb1098ef6sm2276001fa.42.2025.03.02.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 04:22:57 -0800 (PST)
Message-ID: <44b1cc7f-a5e1-4c61-8b9c-1ba0c51e6343@gmail.com>
Date: Sun, 2 Mar 2025 14:22:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAL_Jsq+av-fptMQqBeVieKwA9c7+uUCaqZMLGu-RVJzWZ_7+Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 19:07, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 12:33 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> There are some use-cases where child nodes with a specific name need to
>> be parsed. In a few cases the data from the found nodes is added to an
>> array which is allocated based on the number of found nodes. One example
>> of such use is the IIO subsystem's ADC channel nodes, where the relevant
>> nodes are named as channel[@N].
>>
>> Add a helper for counting device's sub-nodes with certain name instead
>> of open-coding this in every user.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> v3 => v4:
>>   - New patch as suggested by Jonathan, see discussion in:
>> https://lore.kernel.org/lkml/20250223161338.5c896280@jic23-huawei/
>> ---
>>   drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
>>   include/linux/property.h |  2 ++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index c1392743df9c..3f85818183cd 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -945,6 +945,34 @@ unsigned int device_get_child_node_count(const struct device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(device_get_child_node_count);
>>
>> +/**
>> + * device_get_child_node_count_named - number of child nodes with given name
>> + *
>> + * Scan device's child nodes and find all the nodes with a specific name and
>> + * return the number of found nodes. Potential '@number' -ending for scanned
>> + * names is ignored. Eg,
>> + * device_get_child_node_count(dev, "channel");
>> + * would match all the nodes:
>> + * channel { }, channel@0 {}, channel@0xabba {}...
>> + *
>> + * @dev: Device to count the child nodes for
>> + *
>> + * Return: the number of child nodes with a matching name for a given device.
>> + */
>> +unsigned int device_get_child_node_count_named(const struct device *dev,
>> +                                              const char *name)
> 
> I think this should be implemented as
> fwnode_get_child_node_count_named() with the device variant being just
> a wrapper.

I thought of that but it'll mean we had two very little used APIs 
instead of just one. Well, perhaps we see new users though so I'll 
follow this suggestion for v5.

Yours,
	-- Matti

