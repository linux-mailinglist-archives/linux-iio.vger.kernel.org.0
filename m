Return-Path: <linux-iio+bounces-18534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977BA97874
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEED1B601B1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0151E990E;
	Tue, 22 Apr 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cgN0kn2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EF262FC4
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356971; cv=none; b=Glem9MRZfGxjJM7Koqq7FQUJUGUB2qG/CRvuuW02HyEEjAmjz8jAXooaUO5velDA2qXmnvY2YWEweaflWZ1t58NqrjBpCjLrWp9Mv3v+b04u6J9a1tf2mI2bcIb3lWdaReUpKqnTvBJzVcfqs4GZ+3L4uXw/XjJZ8/4U7SWQeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356971; c=relaxed/simple;
	bh=W841TAzS9Pgf+kaExtU6OALsXMJdOqew/TQJAigKTzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CE6jWXxd8vyeGtv4JXsRty6txyTEzHf427mK7vcCbCrYKShSBMcid5VkGW7vKkKpRg3Co8Vuu7mJ20kT4Jx67udz+9Oq06xouhvrZB/3gAqhgPMlfQ1/7FFVSRSY8kX/jvza4sGOuwDivmBu9i797DclgqIZdBLb3QCb7hcHtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cgN0kn2/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3feaedb4085so3057767b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745356966; x=1745961766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7TT6AktatuR9V4aotE2WsOxNczSAdd4gkXQfpRGYa4=;
        b=cgN0kn2/Y0SlXLbBNCrK2u/+sE9ntT3AzzTeHW3Jx3qtbofInUNhU2hwTIYOp4YKwO
         qdkeGiM8lTknRXoR3rHUzT5RYR9g23DiDLFg7tWEnAYq1r7Ilxyzi+guXa3LExyHQlq4
         UWqbUXbp93PyHmdj9s02fQCIaAKm9pZc83R/rTmfp4aMSsYS5743nwudjt754E5YSSsQ
         LdEbRvPZwToU4hjM2iN5cnu+uhlIk7ni0/tHjSzvsm0NADAsCAvlIvBNLdmCt7rdly9n
         Sf15jJFCBnitwe1RF0wA1IK/b5LBSmDEk6PEqEn8W7d0UoRmzW7dODPIEdxMo/PY0TQD
         3cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745356966; x=1745961766;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7TT6AktatuR9V4aotE2WsOxNczSAdd4gkXQfpRGYa4=;
        b=Z8YBJLN+q9p2vKhKJzl2bvSqucfl8w4ttmcEv54//sqz1MdTFKYxIQcUC/05a/CdNL
         EQPlfvbHjmct/u5xdxm4mmYt6pvCTIhIPxVy9aL2ABVPHHzyBGjczlUndHlnWCHFpal4
         TM3c0Suy5K7KpgDFntqjmhmH52jae5lO8HrLy7KvhIWSxruPJ9EkDqPYHGcpLqFYmOZb
         5k1oiQvT1l0JQ8k6GPCVN92JAmIZy8tezYpl9ArGXEHOwyVQ+qtw26lcV2imBPko3bo6
         +USlg/2srsfpbI7bGu9INR+34ew5Sj2NFT1g4wgWusDw8KA/EliV+j7En1pOlV7RvUGo
         6Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCU/y0a5rRzL9UA/ncsvdYjnm7ha32uem6hSV06wyKHHcbAtNldIyXUuK1ufeGBgsMnUVXgl05Y5gqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkTrmz2SpPKv9FBILGObsNDPMTMHPGd4YllW7o42rvwx2sT/i
	ivml2chWyN8816rdBNfydAJbLgwI6iUYKKJ7AFnM6BFLc3b9NZXYGqr1LGTrmiM=
X-Gm-Gg: ASbGnct2und2SzW8p1gIrdrMwJvz++3w00Sr0RQJKFnbK0RH4Tjx88An/h7wFJSvTlZ
	oeyHwTDBM7dw3N2OuO8lZomYA2/s1z/btKOW14usIIJ7lcmcsIQa2buOYejd62GCeD5gC7rCXtr
	6yqdnYUDTfnocpwZ+1b05rUt2JJULlm9/zjw9C9I/BPAafBTVPvkC80IgvD/0cAC9W8CAya2F5A
	KPU2pcCmB3aarbgwOLCL9i2AE7gJyW9WVTug+l5Smfml5O5IV4P11TVBikbBJdKjvDOytvaFSut
	fxf7JYBLdog7tX8xgk1qjG0nRNqP2Ruc4dBP1ae6p+/zjtlUhTBUXXE9fySq3SftHXFc8xiX8H5
	RxS3DmrE40KZvqAWII/HhzBxuoslm
X-Google-Smtp-Source: AGHT+IHhf/Du65w2gsf8LB0BSIGka1F4nn2MvgiOYXQWe8VfxLVecdKEmWU3SxNZhCRA5bkBDDkDrg==
X-Received: by 2002:a05:6808:8214:b0:3fa:8bfd:773f with SMTP id 5614622812f47-401c0a5bf36mr9644378b6e.2.1745356966369;
        Tue, 22 Apr 2025 14:22:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf8f2sm2265760b6e.10.2025.04.22.14.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 14:22:46 -0700 (PDT)
Message-ID: <12dac98d-3e6b-4c2b-8ac0-d526bdb5efd4@baylibre.com>
Date: Tue, 22 Apr 2025 16:22:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: bmp280: drop sensor_data array
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
 <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75Ve_C6BXo75xy4+xZ5b1O9-TT5TGGQDgTR_F1s3TFK3p6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 3:57 PM, Andy Shevchenko wrote:
> On Tue, Apr 22, 2025 at 10:28 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Drop the sensor_data array from struct bmp280_data and replace it using
>> local structs in each interrupt handler.
>>
>> The sensor_data array in struct bmp280_data is not used to share data
>> between functions and isn't used for DMA, so there isn't really a need
>> to have it in the struct. Instead, we can use the struct pattern for
>> scan data in each interrupt handler. This has the advantage of allowing
>> us to see the actual layout of each scan buffer for each different type
>> of supported sensor. It also avoid juggling values between local
> 
> of the supported

I think what I wrote is correct grammar. Same as if I would have written
"each type of sensor". I would not write "each type of the sensor".

> 
>> variables and the array which makes the code a bit simpler by avoiding
>> some extra assignments.
>>
>> We can also drop the BME280_NUM_MAX_CHANNELS macro as it is no longer
>> used.
> 
> I like this change so much, thanks!
> But one comment below.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
>>         /* Pressure calculations */
>> -       memcpy(&data->sensor_data[offset], &data->buf[3], 3);
>> -
>> -       offset += sizeof(s32);
>> +       memcpy(&buffer.comp_press, &data->buf[3], 3);
>>
>>         /* Temperature calculations */
>> -       memcpy(&data->sensor_data[offset], &data->buf[0], 3);
>> +       memcpy(&buffer.comp_temp, &data->buf[0], 3);
> 
> Shouldn't these memcpy():s be get_unaligned_be24()/get_unaligned_le24()?
> 

The scan_type.endianness is already defined as IIO_LE, so we must preserve the
the little-endian order, even on big-endian systems.


