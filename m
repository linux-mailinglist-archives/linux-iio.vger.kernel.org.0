Return-Path: <linux-iio+bounces-13484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3719F2322
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 11:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D2E7A0FE0
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCC145B03;
	Sun, 15 Dec 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GvqISfHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70429320E;
	Sun, 15 Dec 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258092; cv=none; b=PWmjWvrDoDaV3lRc/+lNw72Wd8EUKX1h2LQETdW6B4+csdjHwjJFir8/4LtOF6LMtQT0PuXViVQINdC/ag5648NDdvNES+Q2hUhAEd3fxK00MzDGOEwiNAD+p2BzJUTQCOkkCGGlnnoqsimQkrpspjG3SVpUToktrsmhsL7jPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258092; c=relaxed/simple;
	bh=r5V8psfczmdd9bIMdSaeI4YpJ8jqsbUD6AghctDhCuE=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=L5xhAmmrHDY17tM2GzkUN05JoXZ0CmzNplOXWnhJjHxtpEHo9T5IkjpXJvgJW4Puk0Pz/LwgZzyycbX8X0iiUE7rnOv1vgip5QiFZx54wthVS9yiUnBUf6jSCLoGTfylJEnX6j/B6Wao3OPpnlI47VWw3Q0FyLclRbSvKC/2YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GvqISfHl; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id MlkZtCS8SkTMYMlkZtX4yc; Sun, 15 Dec 2024 11:21:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734258084;
	bh=/5M/zPlc23uhy2VLRDrd31xlfQ9b6/ROThi8peKN7+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=GvqISfHl6w/seoFssrWeUOkB8QSOPC1HxY9VEKEif7of6MMoDA2HTOrVu0k2Tg7R9
	 7XAVOhv99CqehBY8pjPuSPaCKQ7aQrfLSn3ScsPBk4UknSISXOgAIZsI8brFaSvjEb
	 dcAZ3g3I7im+cR5TtAy/DFoRkxlMtpdBCY+zuZ7s2FkzpO53DCXUItF1Ix9J2qdMVm
	 WLRqNQmOLXS/SPcx8NuCYQlHoAtcq5/3854uMNU7/HFi9LzJEh9f6U3kU3wiVZ4pOE
	 vsOphwPMEFb5LNAUG9Mkp7EspU3K9TFrj/VrF1nTCpfDCLOJVlTsOF8x3hHsijHkyH
	 kWvDIFpAKkZKg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 15 Dec 2024 11:21:24 +0100
X-ME-IP: 90.11.132.44
Message-ID: <639acd93-ab8c-48bb-be7a-e5253fd9239b@wanadoo.fr>
Date: Sun, 15 Dec 2024 11:21:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-2-l.rubusch@gmail.com>
 <80b5d56d-b16f-4a93-8868-0a23b10f6ab8@wanadoo.fr>
 <CAFXKEHbebNgDi4cieHO4DU0xO8phGcMre-FHbRGmYtMYOSmAkw@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: vdevicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
To: Lothar Rubusch <l.rubusch@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <CAFXKEHbebNgDi4cieHO4DU0xO8phGcMre-FHbRGmYtMYOSmAkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/12/2024 à 10:32, Lothar Rubusch a écrit :
> On Sat, Dec 14, 2024 at 12:33 PM Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 13/12/2024 à 22:19, Lothar Rubusch a écrit :
>>> Replace the powerup / powerdown functions by a generic function to put
>>> the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
>>> several features of the accelerometer, it is recommended to put
>>> measuring in STANDBY mode.
>>
>> ...
>>
>>> +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>>> +{
>>> +     unsigned int val = 0;
>>
>> Nitpick: useless init
>>
>>> +
>>> +     val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
>>
>> Nitpick: useless () around en.
> 
> Thank you for pointing out. I agree. This is better just in one line,
> initialization directly and no parens. Anyway, since I already can see
> the patch on the iio branch, I'll probably better leave it as is for
> now (?).

It is just a nitpick, it can stay as-is forever.

> 
> Question: Since I'm currently about to build up tooling for linters
> and static checkers. I'm doing checkpatch. I'm running Dan's smatch,
> now. I'm correcting indention/spaces/tabs by some emacs settings.
> DT/bindings I was doing wrong, and just figured out why after
> submitting the last patch (...).
> 
> What is the best approach to find such kind of nitpick issues automatically?

I don't know any.
I only uses ./scripts/checkpatch.pl --strict

I guess that some coccinelle scripts could also spot some things, (the 
unneeded init in this case), but I don't really think that the effort 
would worth it.

Maybe using -Wall and or -Wextra gcc gcc would also trigger additional 
warning that could look relevant?


Adding Dan if he has more ideas.

CJ

> 
> Best,
> L
> 
>>
>>> +     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>>> +}
>>
>> ...
> 
> 


