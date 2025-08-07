Return-Path: <linux-iio+bounces-22372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C51B1D29B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F8018C04B1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 06:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688A1E5B60;
	Thu,  7 Aug 2025 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy89nCdr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7484A06;
	Thu,  7 Aug 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549192; cv=none; b=VfpeQiP73i/bMeQ5UKIirKl4ZS563gOFryLvlDtnKLRc1qIsEaRZkMtoDZDKyKjpb2uSM7JFwdGV5TWWneU8+s+7rprxK+Tb8lHouYhbdf9LCdCVyUC8LoPhX/jebDKKDwutvsMOzFSCjVohtJteGrTK7qWqrDPrxZzyj0bjYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549192; c=relaxed/simple;
	bh=BQw9Ee3xh5tlkCKjINqME/B8sebkBqSB2PSgMl7bdfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5Lcllnm7l/d6sB/4WzrMC+Gz+NzA1wSwihQMDPwTQTonlwnrwV1KqJR8BtU2h8/1YwwFm/Fod0ezikW2kNS/v96xNBmzzFIb6m4A++gytYUWeKrDVoIyxsei14vo9cR9XYsBIb28JbUk1zY1ZmxdHqz3SA2mk3W2A3ZRGjIRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy89nCdr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-33229f67729so5521261fa.1;
        Wed, 06 Aug 2025 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754549189; x=1755153989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFkLRKwmtXs5FXxCDyQ4QjXkb+b+IkADkIzCz8KAzTk=;
        b=Fy89nCdr4udYopun6Tio7mE0YiiyAaEpm/csI6wefQ8kwTFN5JWLs46Tfi2wBpk32P
         RMkl2pqGm/L5Bv1yT7+mOs1ua97vCIf9bZ8mWXLyK2b6XOnKc8mBE2KOxLkeh3XdVnPE
         q5ey7yMrKzaBehirkZQlmjj7uhkcXLvt3BbPXd1nO/NAymUNUeEl5WB7hKQTw4hNZCMa
         StOF8tEnfPYOrjFu64QE6UJ8c1fyF2GjZfq05BZNwJSVCZkm8N79rRMT1Vh47bQbkdq1
         1Zn9B8CYAwwTDfpd6Y0AD0dbYBRRwIKNsnkofkFC+SkDJIMOPMOLzQ64iIczhiRBbtHY
         EkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754549189; x=1755153989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFkLRKwmtXs5FXxCDyQ4QjXkb+b+IkADkIzCz8KAzTk=;
        b=LwRNyzm9VDCmVuV4yHhy6xNIjUrogTPCnD9QjFSuN0fzCWkzLSxS+FzzwFa/zhgGil
         onGtH8CK3OJWeX7VsVQa1tXwapfp2mq00WZjZWYoWPZCcBp+e3uWYcl5HOfoSDGrIjm3
         c1B3eJVI3y871lhGmrJ96i0KGVd4zymC7bqGi0tVQVwsRT/59CP8bkca4kxpkIb+UDub
         NYlUsjkFJM2xWdBTBmMc6+KeF1DOznuqWM1c9lbr4+EC02/8BBKkwsRYc32N81uVb2s5
         vwLEKr4PbCPdkhr0JhuWXU4KMaiQEyoWyL0GtlLE4Ej/11liutq8+9R1sLkHupfH5/FN
         Axmw==
X-Forwarded-Encrypted: i=1; AJvYcCUrXG9djPTHS9wJt0KO3dGNCbdynHeEfW1+cMA2sxfKtHZJAUgHGsn7HoOh0b858pZyyQ5PQPws1ZA0@vger.kernel.org, AJvYcCXHPNP8VIQDNv0cinu+YkkAu6sCr7AG4N+n9Moy62JWPlrv3t8TXKB3QFeQjvZD6ZPvkDYxluvFoTrzc84I@vger.kernel.org, AJvYcCXhOtXgiQT5Atzjbop2A0OD1yhHM2p8wPmMk1Qw84AoXJn/6OXW62QuE5kS7c5Xy/n4a0aNI0GyehRf@vger.kernel.org
X-Gm-Message-State: AOJu0YyiO4SbtRPduBVRGJWSdj8FFg2hXM4S28Aq1L2Wc/PJRtUIjZWG
	ec7Eux5j8cwfHAd9c/Na2qGSfTraLhG+pzibcqPQH+ovdB0RVFSoSY+P
X-Gm-Gg: ASbGnctywNXsVRbj8yelIOrvEOtYkeemnoZU7hQy/4c0E4BdPJfSRVG7nNlrwbeD4lP
	Nul/G0oRQbUDQJSVppSpmO6BdzF/DVZfAdnjNREho3O36GwYnq8JPLpRvIYA4rmmiypPJ8M9piQ
	UtPCf5/gDCSG3X5qNqHvXZGcxqP3/cmNE3of2ePvpiLg7hulwiSU+3SUHCjDwKmTfvqNlzmXcCw
	21bH/u/bHq3kO3OXNP8SXZ5Fr7RuKjMGqZhyLYjnCvtRaOR11IUb2l1ElYw/VkgGhhgTxKtNcH1
	/x0XJ5NbqLcbnmHzs5yq4N6TyQ5Wi7Ter0+/C4PDdvFYEyu4Zvt5FC04a3bN8CGop8PTkLcLJfo
	88ePNigBMaHqGLgc+PQkOjT3kH4i7aeoXXMBFNPd4OlnvIAraf7U6o9OwFKHOv3YXsAMeud+2rV
	8UE6OyLwflyU8h4Q==
X-Google-Smtp-Source: AGHT+IFneUhtOvhFzu2sBeJ9GfQ3QS+MKB6C3adzy8PGoiSDTRYFRQlZwQzcl5uV7vnTsp1Ose5XBg==
X-Received: by 2002:a2e:bea5:0:b0:332:1720:2eb3 with SMTP id 38308e7fff4ca-33380fd6cc7mr16829411fa.0.1754549188517;
        Wed, 06 Aug 2025 23:46:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33250984d0bsm20215391fa.1.2025.08.06.23.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 23:46:27 -0700 (PDT)
Message-ID: <b1023916-23bb-455f-816a-1ca9412a6e32@gmail.com>
Date: Thu, 7 Aug 2025 09:46:26 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iio: adc: ad7476: Use correct channel for bit info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <7c353ad496e0056e9fb3869bf07e7fd66d816018.1754463393.git.mazziesaccount@gmail.com>
 <20250806160413.00005a75@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250806160413.00005a75@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2025 18:04, Jonathan Cameron wrote:
> On Wed, 6 Aug 2025 10:03:43 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ad7476 supports ADCs which use separate GPIO for starting the
>> conversion. For such devices, the driver uses different channel
>> information if the GPIO is found. The bit information is still always
>> used from the original (non 'convstart') channels.
>>
>> This has not been causing problems because the bit information for the
>> 'convstart' -channel and the 'normal' -channel is identical. It,
>> however, will cause issues if an IC has different characteristics for an
>> 'convstart' -channel and regular channel. Furthermore, this will cause
>> problems if a device always requires the convstart GPIO and thus only
>> defines the convstart channel.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> It appears that the _only_ difference between the 'convstart' -channel
>> and the 'normal' channel is a lack of the 'raw-read' support. I might
>> prefer seeing the _same_ channel information being used for 'convstart'
>> and 'normal' channels, just setting the IIO_CHAN_INFO_RAW -bit when the
>> CONVSTART GPIO is found. This would allow getting rid of the 'convstart'
>> -channel spec altogeher. Having only one channel info spec would also
>> help the code-reader to understand that the driver really provides only
>> one data channel to the users. Currently a quick reader may assume the
>> driver for some reason provides both the 'convstart' and the 'normal'
>> channels.
>>
>> Adding the IIO_CHAN_INFO_RAW when CONVSTART GPIO is obtained would
>> however require the channel information structs to be mutable - which may
>> be seen as a "no, no" by some. Hence this minimally intrusive patch.
> If you duplicate them before updating that is probably fine, just keep the
> ones in the chip info static const.

This will mean allocating a new channel spec for each instance of this 
driver. Tradeoff seems to be clarity Vs memory consumption then. Well, I 
suppose systems don't have that many of these ADCs, right?

Well, I'll do this if no-one objects then.

>> ---
>>   drivers/iio/adc/ad7476.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index 7b6d36999afc..fc701267358e 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c
>> @@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>>   
>>   		if (ret < 0)
>>   			return ret;
>> -		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
>> -			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
>> +		*val = (ret >> chan->scan_type.shift) &
>> +			GENMASK(chan->scan_type.realbits - 1, 0);
>>   		return IIO_VAL_INT;
>>   	case IIO_CHAN_INFO_SCALE:
>>   		*val = st->scale_mv;
>> @@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
>>   	/* Setup default message */
>>   
>>   	st->xfer.rx_buf = &st->data;
>> -	st->xfer.len = st->chip_info->channel[0].scan_type.storagebits / 8;
>> +	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;
>>   
>>   	spi_message_init(&st->msg);
>>   	spi_message_add_tail(&st->xfer, &st->msg);
> 


