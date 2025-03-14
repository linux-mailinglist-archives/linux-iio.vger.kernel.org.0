Return-Path: <linux-iio+bounces-16832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68802A60D21
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65B317DD0B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EC11C84DD;
	Fri, 14 Mar 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwMPI7bd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6B1E633C;
	Fri, 14 Mar 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944165; cv=none; b=V5iJtqrQhJ7mk+4FS0o5hmchHdubCACltI0O3FfBQD0uO+riIsobKx1gfLpCrnYT2fg0hXBKvY0e92f6mULUrd0m9HX/Bsb027+qICCxMQkvvMaC+F20YWZjM/5Ue1uuL+jiGFMQ+PAEH76YCmtCAS1BgN64bpkGg33uafid+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944165; c=relaxed/simple;
	bh=nGWcyRV0f9+IrmVuV2ClcshOVIahsrNDbic5jzscPn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDBsQ5wtgHsUdWsaC6rRYWkD2lEhVhsYgrPVWau3Uzd8TQFDDH6Tczp+pkv7pE3V7Tb0EU54P9Rj5tuVp9QSyqngTdR3HIiB7OjS6SpY33i1gtAQzhaEaf8dfvD4RD19brWim5/FtOnoFQYG4kurRJ4m8kJbTJIch2k21u/pwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwMPI7bd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30761be8fcfso20625371fa.0;
        Fri, 14 Mar 2025 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741944162; x=1742548962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6mNnSing0kqpfgH/mSuQWTLvwKA4C3MvqXbpOXhFME=;
        b=RwMPI7bdXWCGmZrggIj1yqCWa/LMxe48H8NebwRfpYJR1/9l453404CTJWW8flZwgP
         /wHb6qgTNz6T5jauoENoxOJ5tePWh6PY+X0O9PPsUSy2mkRUcKhYi0CLRI1iXTr8jyTx
         vpoY4qhlB8oMKcrE7PgxApe4ou32/AmT3iafHYBmFo/gc8akKq943tZmIeG8zTXrDuGH
         vkkqmRCPwG+8IBdi1BCeiuggGtjwNX00gckPQuiGfS00trYDLYiiCelf77+hx0BxW7GZ
         7ER5jNn6VJpV3xz9Hsom92o+wt67vYI8UoK0ap2WSgCJvwfJIZrrNcx2lN60U9V3zkkx
         cR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944162; x=1742548962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6mNnSing0kqpfgH/mSuQWTLvwKA4C3MvqXbpOXhFME=;
        b=bXJM1yv3OoRfYpn3mz70AvTReMlQ5lkvRObGUhQmFkaorJz1Z54/yHZhwR9QfZcVST
         F33s8Eo1M7glOdCPCgnazMTsi6RUHmjEwBRq2A+jyzCxT+HzV+QfIhruhinrKqJbQjl1
         SvJ58TTJ8hG5TuiiSVYXhFSBnhFE8YL0r6Sw1HfFhSloXRUKx7f3hvxJCcG8M8vvoYqN
         GmYCydss6puKHawAFpZKyFkmHA3Kz/UZSBoSeC6RR2TbQ2DjJ9hhPSkBp/A9Y42ODjL/
         9KR5RMQTd8rhRSX7gvP/9pO6SapJLYybbZFf5ZeMDa9e4UMkHD0f3R8vwCblatpVsEGd
         lmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUapi77eKW8L7kWFM23D1acSFWhz69H9AhJquzLu+N49UCHgetLWq12CNJNYRyuoIz/qBWdsKNw3P++lsCL@vger.kernel.org, AJvYcCV6QzrWBkYfGzj63JppHDcce52b6pVWdn9CUEHC7o6gHtHUhDj65exXMnGi0ZmlFt5clRIKq4i8RJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYH4XUhKnwSjwxXTDvD60jWgiR76Yw8ftuKFGaCKNQ9bVqUje
	mk0DhfRAwRxO4jqSxk1JKx7JxzNNCcOHsJs3ZQbltVgTjM9yw8Z2
X-Gm-Gg: ASbGncuuVOsue9bKEUo2cx5Bzl7bQQ20ZPrKEPRlyfRZTmcUnXQC9dySQzqNusvRjMZ
	uMIukU8+FZ6vV0NOuIPcaaneHhaRyIq8O1Pp4DQYLvOQ7lz+Lec+wHJrRnPJ4IPO28fSlL63odM
	FRNpGmshLYiJUtrlWPlmpkjrvsEJOPRop3lqh+4IpY1b/DLFxW9AyndGUZ2CLRSh0AFdEaHzm+q
	skiG39eQ4xOcGwLJGbrkFrm+kvGig9QwRJcp/CbgZCSlgSgrsw506IeVJ4trKb1MhqJVDKc05ou
	USPjlE4Em9fKcRoraEehgy5LNWaK5Khf12btRRXB5mOSFOyIl68IfqimUzL3auXFhGuUk+8AmBz
	LnZdTynfKBeDeAFKmc2Fyi6JR5yyLjbkpfSOH
X-Google-Smtp-Source: AGHT+IGobC/JOvKfHLq/dU7ReuIOaTqTD32p1orQfOs5sriSPZ1/e4QuzKAwaWAv9sJ3Ke+R2KlC6w==
X-Received: by 2002:a2e:a542:0:b0:30b:9813:b00e with SMTP id 38308e7fff4ca-30c4a8d8bbfmr7110691fa.24.1741944161569;
        Fri, 14 Mar 2025 02:22:41 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm5118641fa.112.2025.03.14.02.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:22:39 -0700 (PDT)
Message-ID: <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
Date: Fri, 14 Mar 2025 11:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2025 15:19, Andy Shevchenko wrote:
> On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:

>> +	/*
>> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
>> +	 * subsystem to disable the offending IRQ line if we get a hardware
>> +	 * problem. This behaviour has saved my poor bottom a few times in the
>> +	 * past as, instead of getting unusably unresponsive, the system has
>> +	 * spilled out the magic words "...nobody cared".
>> +	 */
>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
>> +	if (ret)
>> +		return IRQ_NONE;
> 
> Only I don't get why you can't use bulk read here.
> The registers seem to be sequential.

After taking another look - there seems to be undocumented register 
(0x1b) between the BD79124_REG_EVENT_FLAG_HI (0x1a) and the 
BD79124_REG_EVENT_FLAG_LO (0x1c).

I won't touch it unless there is a real verified performance problem.

> 
>> +	if (!i_lo && !i_hi)
>> +		return IRQ_NONE;
>> +
>> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
>> +		u64 ecode;
>> +
>> +		if (BIT(i) & i_hi) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_RISING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
>> +			/*
>> +			 * The BD79124 keeps the IRQ asserted for as long as
>> +			 * the voltage exceeds the threshold. It causes the IRQ
>> +			 * to keep firing.
>> +			 *
>> +			 * Disable the event for the channel and schedule the
>> +			 * re-enabling the event later to prevent storm of
>> +			 * events.
>> +			 */
>> +			ret = bd79124_event_ratelimit_hi(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +		if (BIT(i) & i_lo) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_FALLING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
>> +			ret = bd79124_event_ratelimit_lo(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +	}
>> +
>> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
>> +	if (ret)
>> +		return IRQ_NONE;
> 
> In the similar way bulk write.

definitely not due to the 0x1b.

>> +	return IRQ_HANDLED;
>> +}


