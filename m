Return-Path: <linux-iio+bounces-25112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BCDBE03E4
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9A540462
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0B24DD0E;
	Wed, 15 Oct 2025 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OZjNTkPq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558121DE8AF
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553993; cv=none; b=mfdMG9jVX9QMkiE6pVcILsDIdlUqir0LrP84xqVbLzS1mAo0aiA//5wHAekPUJ6KZ36EbGcI62yPf7aIU21aZdT3Wy5wtEiokpgv2lCXNAR9NhxZzfgBB47yaAys0smHG4whnLe4z0/mW5ghFkqKg6/fmQl96cNqisUwG9SCx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553993; c=relaxed/simple;
	bh=YvgiZGtPFbCt2IU0u4vPOg9X+YBDn8GnfhZjI9AxjG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgO2VCVgZBwfaH1/BF0bHfcGcxKt70CeFTXynhNtmM2rd75pUsUhE2vuvqH45Ip2i2nmgS1Jmxu+16Ib1GpIsPnJios24gA2IxL1ueHyK0VBInPT+8+IR3MurIz8vIrE0mjMhAmcwsQk79B9uOU9wEM+oRyEeMbYrqvH9YzRIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OZjNTkPq; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7bc626c5467so5174350a34.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760553990; x=1761158790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=OZjNTkPqz6clw+zEkoi2JtBkcRSS5faiKVbPkh8zt+IremB1i11rtHe5SwqJDD8OI4
         ZtVT8D9M4NqvlSRPdHzXyNICvhv62MJ/cgu2R6N1mNyj2GuXDxjWARQo2ZgZawb7YFJs
         eqG0M2cK8bbxcmLAkIvs/tzucffpGHlE/l36fuZV4BUbU5pc5rlsKr+hsGUe3iubF2hq
         JvL5FbMHayWuKx9XlCpuFfcRKjqvemqLNq5lS9bZ8eT14FWGuGoS4I4Zhnz8pZrR1XXc
         fhwIrWiu+V31qK5MZh8vB3i0cr9chgxS/cA0Eptpi8IiPCHNOS0M7oTOXRx/WuQGFKg8
         09WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553990; x=1761158790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=dmiLsGyrXYFoUFk51Dg76Y1A0BBForu1HhyZ12yiqJg9pT4M9IFF34xF8p+4O2RKM0
         6C5Ms0PIL/z5PKiQOHAWfFIL03LH8orVP1QFuUUz8iAMLRzc10vQR1YDNCgRnEzloXUk
         DpPDrC0eIHXzmET7MBfDZRDyGkmcUkSaRY/8I6m2+wfGJnqrxWGeyKqvn9SQwRiS42n1
         jsqtXv2Ec1VLF+qTq9lm35s8oGM5Mj9JtnH91LLblhmtiQO+g4pppWkUuucKBSzVqLPR
         dyiMvCEyKL+sqy3vfL9ypDriEWsHOgX2QMp0eTgHw6npRMgTvg1lwuJ5jdkXTLwM+UaT
         ymAA==
X-Forwarded-Encrypted: i=1; AJvYcCXWeK/coWZDtLMTj0dJrD8MVhayNO71p1LsfMEmK8ncLHde/B7P7jUaJUPS9ZJy1a/HhJLDXAQPybg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYEkavEIxHPDZPQDQ9AsTUmH2TqbpMBilBy9ygEpOhPxYIa+I
	YBLt7aVGAVYbM6t5j9xtKf+KrBZmgaq4zH6UP0ovbKfg7ELmsI+cmUlNOKbRtLvTvw4=
X-Gm-Gg: ASbGncvyCOJfNND6nAHAR0072EFBtiTL/Jenv4eBMOpMpaLuy7FvTsUqpVB8Y+wUCBS
	iLHI3mDYuqDrOuNtZHbbqfFUURKfGZWIT+GGuBH8YfID8StehLl76r7doKlgEbwjzrpMKWr434Y
	QA1VlSfeZtlW/c4nGBeovUC71VSVUtbKLoFKDNDtSq3MJNM8bEB6dJItZmQxeGTaeemKvqzzaI2
	mPR6tUIm4DoiOfqHo49ze4JULLiZU25TpQ/RBfoTMFtxCPL5hk9GGUrQ9+U/icFeB2JROHe3bUB
	bKnwvJpyLMjm65LfQQM4rAxCHZSObKc8tfHYCJ6MD6Zw9c6+AMZ0uWXKtea8h0Y6yjYmh5Fn4iq
	zSy7FUukcXzUKu1syykr6sS+Tb1ATre+y401CQFfeB1BwO8ZrE1NnJ1gB1kxbBiMrctFkRwHuvY
	l9ZIvN48Qs6cCiI1w=
X-Google-Smtp-Source: AGHT+IEeWyUK5JU0xMQ0zLXGTri5uRlu04b7SEkveGRRQqga9ddNeRw/aypGJc8FLMQHLk6d2PIOZw==
X-Received: by 2002:a05:6808:1b13:b0:43f:7e97:397f with SMTP id 5614622812f47-4417b3de534mr14932239b6e.41.1760553990406;
        Wed, 15 Oct 2025 11:46:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441c9209c34sm3068700b6e.8.2025.10.15.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:46:29 -0700 (PDT)
Message-ID: <1d9704c6-1729-4288-973b-3b3596609553@baylibre.com>
Date: Wed, 15 Oct 2025 13:46:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
 <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 5:36 AM, Nuno Sá wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

...

>>  
>>  	if (st->seq) {
>>  		xfer[0].delay.value = xfer[1].delay.value = t_convert;
>> @@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
>>  			AD7380_SPI_BYTES(scan_type) *
>>  			st->chip_info->num_simult_channels;
>>  		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
>> +		xfer[3].multi_bus_mode = xfer[2].multi_bus_mode;
> 
> Why not doing the above once during probe?
> 

There is nothing else in st->seq_xfer[3] that gets set in probe, so
I didn't really consider it. Seems like it should be fine to do as you
suggest though.


