Return-Path: <linux-iio+bounces-16931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6BA643CB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FC83A60CD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8781D9A79;
	Mon, 17 Mar 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjQn5LUw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00D5789D;
	Mon, 17 Mar 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196878; cv=none; b=Hupynb2y3bn2MXlD8+KU/hmH1baFYM0w2UO4YR0Bshnet2bd/o3E3/s5kx3F5g7d0NTqv6UxubtOKhVLt6Ly9AlW5OhhEp2qImspPIwU+BywFV8FifX6GSuG6Y/0oMi1Wk7XW+ahuzfqmhB7w1SbDJRDARvhZFjcxVEEZI18ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196878; c=relaxed/simple;
	bh=HAZ2ZjF5Y//1INMWqdilJEwozaioHHXiWdWOATlTSvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnnMfMiQAiBu0g8wXufpHxO/5WbxNCwsNvF52ewW7pofhZIjGsFWVshS117AugWCKftLbUtlGhWJSu/qNOzsQITipHK2tcXsyAaHE7Ue6wBElpsijZ5e0Ozs84pcS9mUdbKfvf8FyDkRUu7jeGtGIakGFSFUOIDBk4zcrguOvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjQn5LUw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549946c5346so4228597e87.2;
        Mon, 17 Mar 2025 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742196874; x=1742801674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3BUn4vCx852IUEwXkUPwvRE/1rcQhbBgz9FRcxU5dE=;
        b=RjQn5LUwRJMZ/enyPSXrL+SmhsTybOMRqzTQC+moiA4CaqapDnnGlTHrvMjED11oZp
         stGX2eD/zaDmGoDiiUNNb4bP/F3/Jo9+PJ2OUgeS+T3hX9qsRRXeTWcPovFsZjqve/iG
         BR3CvDdjOHjnfwgb66sUjUTyruhciWQgl5ciLlhJlKThuhm/NRSjMr3MKKGeRbOIk3sj
         Wqr13Rz1vYIkkjrBg452r8RMZXEztV3YLoAt5GykxZwThzE0g0vLey+UgD+RTempVM5W
         8NklCbeRp4L+CjLAO8lXFwKH3rgc5FnWkmJFwf+hn1spFkjw4Z2NmbPcDuPP5zY2kwfB
         av2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742196874; x=1742801674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3BUn4vCx852IUEwXkUPwvRE/1rcQhbBgz9FRcxU5dE=;
        b=hieueVZ5rsWnlMxH8+BrKLsCH+zGOAWOCltiAUipSc4juqtOrc1+pj2zWsVLgdV5F8
         7dG7xDaVx99rbZ9yTAvG6F4VYzyL6nkid0/GVw62Ydk98csVz8adNSHS6Tebad6LILi1
         XXwVNZltjP//yUTBvMEOOj+07yglKoXZlp8N06/KKRLrNQr+7Gk11L4IUar29bTqWUF7
         cmtf01UoPHqzjSJMhqx30JhkvRdSmZu/FmP24rmfaciMp+EwT0H0b2T/A6UzxmSkuTo6
         5NRgz9nItau2vEpkFHdWcnxiNuGkOFTxfvwoPRyfm884Mg6ZaRRJj3HJqyf5dTQaKWbC
         ndJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW7qwsRfbX/qKM1mhGcaAgklFpUXDLj9a47cKteAKr3nKKQG0z/KPiuy7RQ64siV285Eb2cdll4Zg=@vger.kernel.org, AJvYcCWEhkaGqkICj+0TAZJQMYd64gK+GLXxO5SxIhEPgCifLFKcYbj/HIL0OsQi9+8XgnHZuMXURu8BMlezRLSV@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOJY2jO78RHBCh8pRL1boWJxfpvXS1ZEpiSnAThno3tqUIXbu
	Eb+us8sc8vayxf30PG1XMqQ6hBeUpAspqm9LGrD1K3y+AU5Qekf3
X-Gm-Gg: ASbGnctdjwzDX+XGOw6IYaEdDAdRTK1dBLumuGB0mlRUwmI5yotGiqvTWd/pTGxKcCj
	U4mMC3FL04UhiPEu0I+R0ZsRSBEMKfudR/BaUQzv37QKxk6X/H4bR1tJpf4t6UY11UkGbDFqZI8
	OLqyxHObn4c5I74+uGWE4IraWBLfteRXII4gntEOivgmEM68YXuaTYJMX1ep2mC8gXP2zVBcPbh
	+m122FiI3sGTw52G4OLy2nU0irSTuUW3YoAxQwl8RnkI8+4y/cVH0uct1hUS2W20ScugWSMVx4Y
	TUHyjMFj3Nj+USMQurZOMG2E71MTdepm1zDNtt+gq9enTcn90+yx6DLgpTxU8OxYZ19hSQzvZ6r
	nnvNYHYca5vocqD89LI3+QtOS9g5hgNnZtvaa
X-Google-Smtp-Source: AGHT+IHZPjXeWVFI+Z1E3JE9A/ohBWh8Aj+xDCWS62hptTNWadpTm5hBbZAE0liVet2I9B9BdCtTuQ==
X-Received: by 2002:a05:6512:3d17:b0:549:4bf7:6464 with SMTP id 2adb3069b0e04-549c3925125mr5757299e87.38.1742196874118;
        Mon, 17 Mar 2025 00:34:34 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8650cfsm1218413e87.137.2025.03.17.00.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:34:32 -0700 (PDT)
Message-ID: <6bfe66a8-5c98-4e1f-90dd-60a8f45f213d@gmail.com>
Date: Mon, 17 Mar 2025 09:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <20250316110237.0b558248@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250316110237.0b558248@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2025 13:02, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 09:19:03 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus the driver does not support the BD79124's manual measurement mode
> Given you are going to be doing a v8 and I'm bored on a train, so utterly
> trivial comments that you get as a frequent contributor as things to
> consider for future patches. (I'm sure it's just what you always wanted
> :)

I don't mind these! :)

I can admit (and I have admitted it), sometimes I get irritated by 
comments. Maybe that's just natural. Still, in many occasions I am not 
irritated/annoyed at all, but I am actually genuinely glad I've learnt a 
thing or 2. Maybe it is also connected to the tone of voice when 
comments are given?

> In theory should be imperative though I don't care as much as some.
> 
> Hence, do not support the....
> 
>> but implements the measurements using automatic measurement mode relying
>> on the BD79124's ability of storing latest measurements into register.
>>
>> The driver does also support configuring the threshold events for
>> detecting the out-of-window events.
> Trivial editorial comment: that 'does' is not providing anything use
> in modern English (might have done in the past, no idea!)

I have learned my English back in the 90's. Back then they told us we 
were taught British English. My teacher had probably been taught 
somewhere in the 70's. So, what I've learned is likely not modern 
English - besides, I liked girls and sports more than school, so I never 
was an A-class student ... ;)

I suppose you might know better than I (do) ;)

Well, I rarely get feedback from what I write - so this kind of things 
are valuable. I think I've developed a habit of adding this 'do' to the 
places where it's not necessary. Sometimes just out of a habit, and 
sometimes (in my ears) it strengthens the meaning. And I have no idea 
how correct the usage is unless I (do) get the feedback.

So, thanks.

> "Also support configure the threshold..."
> 
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus the driver masks the received event
>> for a fixed duration (1 second) when an event is handled. This prevents
>> the user-space from choking on the events
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Those pins which don't have corresponding ADC channel node in the
>> device-tree will be controllable as GPO.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> A few trivial things inline.
> 
> Jonathan
> 
>> +/*
>> + * The high and low limits as well as the recent result values are stored in
>> + * the same way in 2 consequent registers. The first register contains 4 bits
>> + * of the value. These bits are stored in the high bits [7:4] of register, but
>> + * they represent the low bits [3:0] of the value.
>> + * The value bits [11:4] are stored in the next regoster.
>> + *
>> + * Conver the integer to register format and write it using rmw cycle.
> Convert?

Right. As a note to self, also register, not regoster.

Thanks!

Yours,
	-- Matti


