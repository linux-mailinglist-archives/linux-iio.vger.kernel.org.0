Return-Path: <linux-iio+bounces-24762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D22BBCDDC
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 01:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518933A7367
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F545198A11;
	Sun,  5 Oct 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDz10yre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659B22D4C3
	for <linux-iio@vger.kernel.org>; Sun,  5 Oct 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759706723; cv=none; b=Gr7bYErpUzWMUrAtsnd0WMM9TCsLQaYeQY7GlebRZDm18dPnXyZlTPekgpIgzJWL8L1F0X9F1af+J0+UbVSU2MJSwjkn4YcXCEQSfmBt9WJUKZ+AWSETSNtYqiuLoO7EclhvgB7D/WtxWOJKoFeTnpJm6rTFu8yj8vpu7unWj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759706723; c=relaxed/simple;
	bh=nq24OG00nbd2TINXwilaodUVdAgf+dAFMRkKWUpwtuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYALiz6s8hCXEApAzFbMU46eRK5eWThjbHkIw5lXWWE1f9HTivcsy1NoLuzuZV9xLNoNF0+HRrVZpD90ah1e5tzoThTkpk6/sBL9Qw9IxEII595y1VI4JV6Ewt2ilVKcc1SUbDuMvwddJIpLiDL1v9xIjw353wSE/T2W7Yeqnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDz10yre; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b593def09e3so3187068a12.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Oct 2025 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759706721; x=1760311521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYv7vpVBKthNnff+UlSd90a9wZD1vAq0DYVBuSy3Ej4=;
        b=dDz10yreinvjfIWuZWLXoS8YW1dD6uMP3qcutBaqUp6zY/2bw9G++WugdlvyxqLIGz
         fKJNgNQKHJ22UYwCsguXL3ZZq24WYSBwMd0Zx2CHsCn7qZKilT8OImiW20/r02AOLHcG
         RhFe7mdAA20bo6fCL5vn/sqfgbptnplMUDaN9fe+FlXn2ZkpouICPEwYWCdn138p2Q9S
         jhoyxKWIABMbkrBOwYrYQ6AQONs/M0JrZ6dZqGIVqhMEMIF7Rcw78s+ENF4zSlJYDxjH
         OCjNdmtU7Cw1L6kn5D5FI+A32K/CE60NWm/y1KevfihWjR7hhO33W3S1CRYedgMXqRfY
         DExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759706721; x=1760311521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYv7vpVBKthNnff+UlSd90a9wZD1vAq0DYVBuSy3Ej4=;
        b=uzreIlota7+FtW0NO5IlnNqWiW8KvIrdqnQC9nXMBJz2D7Jv8suU/KfrIBpEKXhUQe
         mgyThA6N0CkbngRVTVW4iebXjq0Tz2FbDDPE3DqDWZYRPBcseEetUqy8J5vlLVQbjkbo
         cfVvi0gjHFCiHlqorN2ji2VJwKxp4VMBpIFZLGEYagysNVVB0OSss8bg6DM1lsoiU4+e
         Rh9PX2gBs3DcPOZa7khAmWHRQfUeJGKAglT8cQP8RIRbOrb9kfquLZYtvOPjsYuL59aT
         PiRetdzHglcT57p8eRLj00uLxDQ1F1F9khXG/+YsTZ4qniVm/v/BSL6sCVJNDEFMys8X
         dFUw==
X-Gm-Message-State: AOJu0YyQX7erJbm2Mf/6VisXGWMqDu/TjACLfKv7IhZsJaVlRTLQ3B64
	mYQZGa31DNpbYIQRJzg1ygkYtAgKQNqcyUmEQcw4/c29VhTqdttZu/4T
X-Gm-Gg: ASbGncv/xe5Zl76tmAZFx7bjkyoDAHaKcHaJkRTnZ0gqo9e4yvNx77KcDhjUELTSTtb
	jc7T4CuSOWLH97dT1jBaCsBvrSYmH4zcRBX3kgPMZWaHh7vI1YYuf5a89kwsdTSz+0tt3ww5r8A
	WozCiWfJohNs00QZ4K7lU2uJC9NlpEouvaoXfcefjCf6W8kcKxi65+pf3sZZ+wGJHxGvoaaZLY4
	gCI+C3GK09QNxdfgU4fXzTmUrCPJ8Yly+o9IjrdCJG89V68TCa/dl9ttDtDxkti/0ydegE4L5tg
	42ZA5aO+tW94r+3IanOmQ1r+TsLK2fS0P0StvxuJgWdqvkD9fPXJBZZJqwX/++LRhkk1YrqYA4y
	hVC9ivdLWt0ss958Txsn1V3t4KsdoZIFTeyYsexa4OjTbNNDVtt665W38Z/2XhzvUX6de2qykdQ
	v+goD0K8sXM33vP+4sQn2d6SHicQ==
X-Google-Smtp-Source: AGHT+IFzFKXXmzM6dN5RZJw7Ftapo+Zr47psegQMmyZHZB026uVazIjrxM7ymwGOI3B4kPadLZCnrQ==
X-Received: by 2002:a17:903:1210:b0:266:64b7:6e38 with SMTP id d9443c01a7336-28e9a6dc994mr115732895ad.46.1759706720577;
        Sun, 05 Oct 2025 16:25:20 -0700 (PDT)
Received: from ?IPV6:2804:7f5:b08b:8d8b:4efe:bacf:243c:8ba8? ([2804:7f5:b08b:8d8b:4efe:bacf:243c:8ba8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95a0sm113075095ad.115.2025.10.05.16.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 16:25:20 -0700 (PDT)
Message-ID: <9ee20209-efba-44b1-9902-5885bacfb290@gmail.com>
Date: Sun, 5 Oct 2025 20:25:12 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
 <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
 <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2025 11:03, David Lechner wrote:
> On Mon, Sep 29, 2025 at 7:59 AM Marilene Andrade Garcia
> <marilene.agarcia@gmail.com> wrote:
>>
> 
...
>> +static int max14001_read_raw(struct iio_dev *indio_dev,
>> +                            struct iio_chan_spec const *chan,
>> +                            int *val, int *val2, long mask)
>> +{
>> +       struct max14001_state *st = iio_priv(indio_dev);
>> +       int ret;
>> +
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_AVERAGE_RAW:
>> +               ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
> 
> I don't remember... did you give a reason why this should not be a
> separate channel? Or just use REG_FADC as the raw value and forget
> about REG_ADC? In any case we would want another attribute to control
> the filter window size.
...

Hello David,

Thank you for the review and suggestions.
Sorry for not adding any comments about that in v12. From what I 
understood from our previous conversation, for now the code could have 
one channel to keep things simple, since we’re not sure if anyone will 
actually need to read both the filtered and unfiltered data at the same 
time.

I was thinking of sending a separate set of commits to address that 
after this one gets merged, as it will involve new code changes related 
to adding a function to configure how many ADC readings are included in 
the mean calculation, and adding a new attribute to sysfs.

Since both IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_AVERAGE_RAW are currently 
returning the same value, I could drop IIO_CHAN_INFO_AVERAGE_RAW in v13 
and add it back in the next series of commits to implement the related 
feature.

I would like to know your thoughts about it, because if you prefer, I 
could change my plans and implement it in v13.

Best Regards,
Marilene


