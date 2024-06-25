Return-Path: <linux-iio+bounces-6862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A83915C03
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 04:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F33B21E99
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE822940D;
	Tue, 25 Jun 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvcKo7Gu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BC3D97A;
	Tue, 25 Jun 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281212; cv=none; b=bYIjpLsajrmEnLMbF0X1haEGiOLeeVbhy2qaXwwGxXC2E6g7zU8a3d9WV/yBa6NJMy9ijWBorR6Uw329cCt7vvPODWKfnhoLRtuE/RBqUAh+9zBKm1EnzDZFsmkKg6sX0RJbsEmbPs2bLeF0FI6PYw1CkO1TUz8EdWSFCMM3kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281212; c=relaxed/simple;
	bh=5KL98og9uMF31NjXCcCAQLZoRkddM022JoSLrUUNr5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak/rH4n76jJbOk21B3vNlytp+3m8kV9Meb9nKKQJGlbGqlE5zOAASHbqahdznTiGmljVhAlF9TxipVF/A/VhfBA+kD0aZzPSG06ZHSE3lVXE8IXWj9hV6aHh/1XtUE2bi9u4FAcSLtb5kD4i4UIOj03l6Xq+DbPOMz1wgfO+Bpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvcKo7Gu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9b364faddso40555805ad.3;
        Mon, 24 Jun 2024 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719281211; x=1719886011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5+jYxkflkx9FU3L/r+kaaNsX5V61zLxkmSOfktg4Ew=;
        b=TvcKo7GuL8vSQ4QoF6tYX/aXBQmJcrW9y72QS65iaBjdKllkPLRXtgiTXbQg/AABjt
         7Wj8CSyi2Zckxu4c2wrykJ4rVyx/yiokJ9/MhaAjzaeRa6bgirmXL396ctCg112TKAmg
         AxjbjyqsECY/vdWHgUKmx2yjTf8rcen2oeBF8RFWDHI1suM9dcQnDXKRY7l6idR2xvrJ
         0EN1sbNhaiy//l9dpo0EiU1/HpVBf698xT7O1SWe+jlx6/txEsBLbHdYhNsgLZL+C6Lt
         Uo2imA7Af+tDl1xcEUaXFvHP+26t3bhu1HfuVDRReoDOaOv39c6BVRO+MDchrjz6CWRu
         a1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719281211; x=1719886011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5+jYxkflkx9FU3L/r+kaaNsX5V61zLxkmSOfktg4Ew=;
        b=vhCw3POvWInoc8ssV/+zjGGwWM1hB10eBjNg8YT3lzdsO7KOgxcy9tpjYvtMUC5zF0
         iXypeB63IjbZUVNEhEWAjwXsZy+CBxw1Dh1hHH1nbSvQyCVXyyt7MAHWMd+Y1knFNLH4
         xv5kbLhkQVWtjN3gYG6KTXiLUzuWe5t4xb15AkoeO5rNsljUbcOmgNZ2YTQ5TsSkGJfb
         g/vi3anbuhz+pIKPYVKcJ73cBxuDEFvdstjbvkqMTZoIwdPonFcqdfXlBlmvCsNENhZW
         H5T3ziDY+jkfbGyHDFb1eJZxMXWtBJuLbfucjMHLyuOLJeqEszsxEqa5Q+QkRibiUimn
         2dtg==
X-Forwarded-Encrypted: i=1; AJvYcCUeHJVh6rOhiHWt82ZZr0TBS4J6oNlPgJsjhw42mD0gqoZoV5o7vl4X7Ub6HdSYw7B+SH8VPu3uqQ+nATdzqI/jCzMZKJN5Y5Ap3xASy2iQ2Ju5DPD2OoeQeTbPoHYpKWtQtlltj2NpAzQFjaO6+mZvUMxfSMj5puUvQD0bFA8Fus9xbg==
X-Gm-Message-State: AOJu0YyTzmvlwvlwazEPBvna51GQ11s1U3jw/yiCWhNrAHhelUSTeGcs
	wNd3VCA1xnUuMvIrBSk0SsB4fuwDfoy3nw8+N0tVA6QtnNZ8pjgB
X-Google-Smtp-Source: AGHT+IHtF20TnRzBfjPcf6+0ZlMGemQNkKCLH9aHjbdkzrSUQ1w9cLMXsYmnsa124FSuNlKZm5URQA==
X-Received: by 2002:a17:902:e542:b0:1f9:b35f:65f4 with SMTP id d9443c01a7336-1fa23f07246mr71955405ad.13.1719281210634;
        Mon, 24 Jun 2024 19:06:50 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7ccasm68892795ad.299.2024.06.24.19.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 19:06:49 -0700 (PDT)
Message-ID: <4eae8b55-d1de-4a03-a75f-4d85f200f1c3@gmail.com>
Date: Tue, 25 Jun 2024 10:06:41 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 yasin.lee.x@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
 <20240623125621.07d1617c@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240623125621.07d1617c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/23 19:56, Jonathan Cameron wrote:
> On Fri, 21 Jun 2024 15:40:51 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> Hi Yasin,
>
> Some good reviews in already for this version, so I only took a quick look
> this time. It seems to be in a reasonable state now.
>
> Jonathan


Hi Jonathan,

Thank you for your very patient guidance. I have updated according to 
each reviewer's suggestions.

Best regards,

Yasin
>> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
>> new file mode 100644
>> index 000000000000..1d8cb9a05d8a
>> --- /dev/null
>> +++ b/drivers/iio/proximity/hx9023s.c
>>
>> +struct hx9023s_data {
>> +	struct iio_trigger *trig;
>> +	struct regmap *regmap;
>> +	unsigned long chan_prox_stat;
>> +	unsigned long chan_read;
>> +	unsigned long chan_event;
>> +	unsigned long ch_en_stat;
>> +	unsigned long chan_in_use;
>> +	unsigned int prox_state_reg;
>> +	bool trigger_enabled;
>> +
>> +	struct {
>> +		__le16 channels[HX9023S_CH_NUM];
>> +		s64 ts __aligned(8);
>> +	} buffer;
>> +
>> +	struct mutex mutex;
> Add a comment explaining the data this mutex is protecting
> (that may be in this structure, or for example on the device)


Done, you will see this comment in V7.


>> +	struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
>> +};
>
>> +
>> +static int hx9023s_sample(struct hx9023s_data *data)
>> +{
> ...
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +		value = sign_extend32(value, 15);
>> +		data->ch_data[i].lp = 0;
>> +		data->ch_data[i].diff = 0;
>> +		if (data->ch_data[i].sel_lp == true)
>> +			data->ch_data[i].lp = value;
>> +		if (data->ch_data[i].sel_diff == true)
>>
> Run checkpatch.pl --strict and it will probably moan about these.
> if (data->ch_data[i].sel_diff) is the same thing so just use that.


Done, and I have fixed the issues identified by the script.



