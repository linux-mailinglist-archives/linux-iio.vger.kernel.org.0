Return-Path: <linux-iio+bounces-6331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1A90A35A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 07:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81531C21343
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015F17E903;
	Mon, 17 Jun 2024 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYFBRyNw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8A17F5;
	Mon, 17 Jun 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602467; cv=none; b=E0Y3PBmueTUPFCMbC9E7FSi6EMkoXlVbhT1KDsF4OPzcasRpanNc5NvbSjBu2G4pFNHHIl/lQf2y0TrmkIVzR9Bt1f2Ix3Jzw84+TZ+KRezVky/D7u+rCuRjttUo2Ib9WdFEafLHMr2bITzkRwg2cWjlqjI6DB7LE48pFSLV+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602467; c=relaxed/simple;
	bh=icaSQIDrys6BH1yXczYwSFZuCZg6/iaQQNbRtTPdyLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwDNH4h57gtmuAK5nyxXaVC8Lm3O1GddXU9CY1tETJ+6N7Xc10mdyrt3/k9/op5Pvw3WC1GSP1uTizN1TjaWlpT95UySpx3WI2MnZ025RxDgeTJhtlPPts5o7zV07nVapaOuOQvELo0kmJDGcJ6iXbqhKetJgo87kf9BxbgZJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYFBRyNw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so5104081e87.1;
        Sun, 16 Jun 2024 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718602463; x=1719207263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSpZmf1K082PIUbwqLvXPKnERoeKQ/2WmW8jA1K0LCw=;
        b=MYFBRyNw+vKVN1rbr+vi3i/ESMhsi1KYjPZkfzbTT9jbgTU5cKjEQE5rD7g8waDewY
         WaSq/6EgAPRZvA1BVl7ijMgp/clW3tInOqoMQgjTabL6wZGdvWR/h8NSH7UVGVidWfm2
         cSWhNN2SexqEhUmjJnrK0v4i+8rjeUrPmuOuZKQItKKxp4a9fq2LOZfjtziGROQmoYiH
         nyQABufn9NAqw2T83f+QPxo1v/r/y8YwDWYpddBcjOrC5XkOkQhZbKqDksxlWMT+8GSe
         +OecaxCeExsaxC/ojKSoNp8xW5pvTmdQVQktCXlo9hfAFszZHimYcAt0Hw/LUcZBX3QS
         mNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718602463; x=1719207263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSpZmf1K082PIUbwqLvXPKnERoeKQ/2WmW8jA1K0LCw=;
        b=qxbQlRXLC0kczXZDAn3T9CISBEbaWrZSBb/0gcA5UoIkJZdo83VfrVTpssEnsYHrDq
         ujzkznPfqGBFxTjeamI2DObiVfEKV8dD3rTkCmrxkhdrfRodUEaMVu3sxBCxHkBrCUGs
         fhVgROwLhqJqATLfcmgwog1s6NWNt8MzKWrZ5RWv1G493qCsA5swg4gh3iiH5KF6ZoaC
         yxZOxyT/sM3CoVgiq8SpluxTLePJEwunOsi6k9T56M3oyjyog2kZby47Iat/OnmTTgMM
         12CCBrsvYqCMkAI3wD75V2FVnyiKKqFqhvqNLKEEjxlN8P1cmZ/O14gvK39y0tCNaBCR
         SsFw==
X-Forwarded-Encrypted: i=1; AJvYcCXG8k0vwQgZomTcOK+IopFUe79QPvNZ8VTCfqMFJcnhoQB+DBjFHFik9cDcLTp/ekFukBsH5ogBtgvYs8uBAbja1Z4mc6CgJ7IbMtpxFH6E/p8bOFyUdNC+njPz1ET5WbC6obKcgsHR
X-Gm-Message-State: AOJu0YzI5WbuSPj1B8SDJtlG2LEqqSwEJlNRazolHFEJJHiK8nWKARIw
	tHA5++RdujyAJzdxBadOX4TmeS5AIftJQEBjJ0ZVaYq3rV1bIPL2+9OWqg==
X-Google-Smtp-Source: AGHT+IE+oP5gd6y4Ilih3B8Y873F2t0Zlq/eZmOaCtQcy94VN0cVrL+gLRetes43IBmHFwr34RUS3Q==
X-Received: by 2002:a05:6512:749:b0:52b:bee0:54b0 with SMTP id 2adb3069b0e04-52ca6e90523mr5188931e87.54.1718602462976;
        Sun, 16 Jun 2024 22:34:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca4035856sm1085735e87.178.2024.06.16.22.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 22:34:22 -0700 (PDT)
Message-ID: <59111915-f77b-42e2-af5e-ca479d1a037f@gmail.com>
Date: Mon, 17 Jun 2024 08:34:20 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718013518.git.mazziesaccount@gmail.com>
 <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
 <20240615185036.7d1934c2@jic23-huawei>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240615185036.7d1934c2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 20:50, Jonathan Cameron wrote:
> On Mon, 10 Jun 2024 13:01:40 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27034 light sensor has two data channels for measuring
>> different frequencies of light. The result from these channels is
>> combined into Lux value while the raw channel values are reported via
>> intensity channels.
>>
>> Both of the intensity channels have adjustable gain setting which
>> impacts the scale of the raw channels. Eg, doubling the gain will double
>> the values read from the raw channels, which halves the scale value. The
>> integration time can also be set for the sensor. This does also have an
>> impact to the scale of the intensity channels because increasing the
>> integration time will also increase the values reported via the raw
>> channels.
>>
>> Impact of integration time to the scale and the fact that the scale value
>> does not start from '1', can make it hard for a human reader to compute the
>> gain values based on the scale.
>>
>> Add read-only HARDWAREGAIN to help debugging.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Other than the thing the bot found with fallthrough on the switch statement
> not being marked LGTM.
>> ---
>>   drivers/iio/light/rohm-bu27034.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
>> index 51acad2cafbd..b299ff2aacce 100644
>> --- a/drivers/iio/light/rohm-bu27034.c
>> +++ b/drivers/iio/light/rohm-bu27034.c
>> @@ -149,7 +149,8 @@ static const struct iio_itime_sel_mul bu27034_itimes[] = {
>>   	.channel = BU27034_CHAN_##_name,				\
>>   	.channel2 = IIO_MOD_LIGHT_CLEAR,				\
>>   	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>> -			      BIT(IIO_CHAN_INFO_SCALE),			\
>> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
>> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
>>   	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),	\
>>   	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),		\
>>   	.info_mask_shared_by_all_available =				\
>> @@ -992,6 +993,13 @@ static int bu27034_read_raw(struct iio_dev *idev,
>>   
>>   		return IIO_VAL_INT_PLUS_MICRO;
>>   
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		ret = bu27034_get_gain(data, chan->channel, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +
>>   	case IIO_CHAN_INFO_SCALE:
>>   		return bu27034_get_scale(data, chan->channel, val, val2);
>>   
>> @@ -1036,12 +1044,16 @@ static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
>>   				     struct iio_chan_spec const *chan,
>>   				     long mask)
>>   {
>> +	struct bu27034_data *data = iio_priv(indio_dev);
>>   
>>   	switch (mask) {
>>   	case IIO_CHAN_INFO_SCALE:
>>   		return IIO_VAL_INT_PLUS_NANO;
>>   	case IIO_CHAN_INFO_INT_TIME:
>>   		return IIO_VAL_INT_PLUS_MICRO;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		dev_dbg(data->dev,
>> +			"HARDWAREGAIN is read-only, use scale to set\n");
> 
> return -EINVAL here.  You could use a fall through marking but it gains
> little so I wouldn't bother.

Right, thanks.

> 
>>   	default:
>>   		return -EINVAL;
>>   	}
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


