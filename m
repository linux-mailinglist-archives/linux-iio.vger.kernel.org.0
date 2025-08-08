Return-Path: <linux-iio+bounces-22423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443DCB1E1C5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1068B18C37C1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 05:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3D1E520A;
	Fri,  8 Aug 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxeqbLMt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560712F30;
	Fri,  8 Aug 2025 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631535; cv=none; b=TYASYBP399jGdigKUc3JXsmK3tG+5gAU8yY3huZKW6yb9Co5x8Y367D/wcaJAvRca6hEYOWMbgzFr5htyJBF3jz4stN3opRrGSynHHSDZRvk/wfgsxvPeL/MOPLJXJDQ9WdeF4nZc1Hh03pPQiqLCF1aYOdCxU0WXf6X1aHYtI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631535; c=relaxed/simple;
	bh=1gHP9nixaluuWSbyl4kq8VWnyML6PuQEqRGmWUfR9sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGy9Q+J2ucwEs8eEV7WnFVFVQ7qiQ4Uu0x5X5lXQcU0ksS0/VW5cbA4i2C0J4bSTHKT85Yn3h/ef2UnyOO4Z5Pdkf53YAjCdNuuCMZh4LTWcWoHEHrG4Ew7LAGTF8Z1hN4qElEBY//JWn9X1ZkA90HJ9MzW7zKffpVZvnU2gRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxeqbLMt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b823c9129so1819019e87.3;
        Thu, 07 Aug 2025 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754631531; x=1755236331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rr8Arhrz9lJ0mMxP5dIF9d+tkR+qNlI/N2oj+jRMRr8=;
        b=JxeqbLMt9fAUuTexLanJsn0OKmqnaybDEj5QsvMRGKqzR4rA9xPlY1BuQn91RzwkD8
         xKu9/Ylm8G4FU/UOPSTCwj5b93H08zP3+tAuqbAfZMki027m0QHwjkE1ZuekijHasQLp
         2QB3j+QCe7P7nFCG4FO404veiO12TYdx8EslkbtG6L0Cnkbc6fHkScEOU6wIO2rdjwLr
         A1OUb/DnDO9ZZO3zlwEResUUhUXMAXPU+C7dRGXLm8+IZJMUtmSB10zoaddyWZrmt8A9
         nT5hP/lSNjEHL4vN/ElYKyDO3A60ALzQxYnrN1dht/MCo2x13aGNJdL7Xx2HunAydSss
         L9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631531; x=1755236331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr8Arhrz9lJ0mMxP5dIF9d+tkR+qNlI/N2oj+jRMRr8=;
        b=qSb82QDyUQMEafBmoJOM1ixarvtlqUhKm1FrayTEhrom80vZnudjSKuAml820bKwJN
         muiWpBSSRQrgpSPbzlMjnLOyoEsk3ljdQnO4Ahx33QSbJtQ1aCEI6y60Av1iozHqa462
         E1JwBVTgie/UNhyEehbkf2mcQCemT7i3I6/3lTu3VawlLuP19+bwdABPt6XRBzAWmBdK
         6twgM3m2dyAcwyLkOfTS+f1Ee+6AZrZiO4EBWn5uMWaTYXJs55BU8+kV3NW5tqwgE2Sc
         kH7OzoOqHqnXRW9asPqUHaplR/WalCw4aBoOE/RPOQPXFsQio1m2axSYLfqzZspoeKYg
         icKw==
X-Forwarded-Encrypted: i=1; AJvYcCXNbBrPWFLuRjwmwOAeT8O2Zpln8w6yA4kRZO97SBAXX5W00HuWnass4zDc9GmWtCuUEAdWrF8QB/pE@vger.kernel.org, AJvYcCXchE2d45vlg2/QQFEjOs6sf9E1PmVI6Qt9CJlXOciCgQQtJASoQtkaN+xndtkGNg6eNQikzMZKq3VDQ1Hn@vger.kernel.org, AJvYcCXs+8zmC1mNTIUEHdCCALHKzo/CVabcd5gXM6yGfrmvBATbkYBW0rCWK2rfJ0PvpInRIZkw55hQ7aDW@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHKGaSz/TQJRAMvW4SFYLustdW4XjIVFWFlxebH22UQjvs0gr
	G+VA1bnDOIufZHiZI74iQm6Nyhq3fvh3Q9r6/ndXhaI4Bh6P5bM8bV2M
X-Gm-Gg: ASbGnctzqYfd9qeldPXRFYoNtZW06Of4F13mBmjLeLECU0FjqSQQzRli93JsO9LToFt
	TwMEWnAfmCLZbpo9uHmYJbEIHsGvjO+uT02NLB9qUUdHNoODu0qcNDSH95KTqGNTObgpy9Bxrlj
	IMLcbEU5tbtNEPik8wh/BtrJCqG1zqEPEnN2DF6xi3YAYjuLrh8YjL2Da8mu6Rm85UfAyfh/8ou
	cSFc7mA4RRuqU3jvpJeHc3K7Zrurk58ioCsmOTMyvYBbKKn/MpHcNcQwGCOS+U+w3mubwSG7nlW
	AWXz9WAks7KqJiH2j62yedebw3/hxe29L9BOqE4OhF08CrlFP8HBTamiQvTcp86fbEna2BeEf1O
	exNQJrEWnIqgf+y2Ru9vEEN9/2/WXzqgx/FTMYk9zk36XnfcsNbWcw+YkGDITgxm7yBACzdotsu
	n6ACc=
X-Google-Smtp-Source: AGHT+IEPgc36lapohq1VSRQx+aQ7f+9pYgP7BC3ABCoZhFDG5Wu3pjTH9/9zRAs2UCKpVrLOOy77cg==
X-Received: by 2002:a05:6512:3f10:b0:55b:842d:5825 with SMTP id 2adb3069b0e04-55cc0135fc8mr470181e87.43.1754631531313;
        Thu, 07 Aug 2025 22:38:51 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899dc75sm2855416e87.40.2025.08.07.22.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 22:38:50 -0700 (PDT)
Message-ID: <13505077-fb36-4126-9767-fead98e01009@gmail.com>
Date: Fri, 8 Aug 2025 08:38:49 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 00:16, Andy Shevchenko wrote:
> On Thu, Aug 7, 2025 at 11:35 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> The ad7476 driver defines separate chan_spec structures for operation
>> with and without convstart GPIO. At quick glance this may seem as if the
>> driver did provide more than 1 data-channel to users - one for the
>> regular data, other for the data obtained with the convstart GPIO.
>>
>> The only difference between the 'convstart' and 'non convstart'
>> -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
>> channel's flags.
>>
>> We can drop the convstart channel spec, and related convstart macro, by
>> allocating a mutable per driver instance channel spec an adding the flag
> 
> and adding
> 
>> in probe if needed. This will simplify the driver with the cost of added
>> memory consumption.
>>
>> Assuming there aren't systems with very many ADCs and very few
>> resources, this tradeoff seems worth making.
>>
>> Simplify the driver by dropping the 'convstart' channel spec and
>> allocating the chan spec for each driver instance.
> 
> channel
> 
> (you already used 'channel spec' above, be consistent)
> 
> ...
> 
>> -       int ret;
>> +       int ret, i;
> 
> Why? Is 'i' going to be used to hold a signed value?
> 
> ...
> 
>> +       /*
>> +        * This will never realize. Unless someone changes the channel specs
> 
> realize --> happen
> 
>> +        * in this driver. And if someone does, without changing the loop
>> +        * below, then we'd better immediately produce a big fat error, before
>> +        * the change proceeds from that developer's table.
>> +        */
>> +       BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
> 
> We have static_assert(). Why can't it be used?

Don't know. Can you please enlighten me why one is preferred over the other?

Thanks for the review Andy!

Yours,
	-- Matti

