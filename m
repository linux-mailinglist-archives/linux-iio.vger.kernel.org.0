Return-Path: <linux-iio+bounces-12929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F169DFBCB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD3E16295E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400F1F9AB9;
	Mon,  2 Dec 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhuH940+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70271D6DDC;
	Mon,  2 Dec 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127747; cv=none; b=XzmQTy2iOt1R2s5T8JqMtk1RDBcfQZAQL0y1gJ+VjHzcjdFVhoSfdYGThZa2mECsSH6vf178IX8tmaEIbfAbpSLtfkAEl74hg83VxGeBmCPOnQAf4fE4igiU+zXAC7+lWkQTudfvarkCquilrDwwUhO1QGaFX6tb26gzLv5TwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127747; c=relaxed/simple;
	bh=o+x7UUeIse1yT2KW0S7eGdDE1k0Cu/ERp1FpaTouCzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRsgMOLYVCukLlxhDMunkwb0JqV9K0AgsUOwDC/DJkCZZBkKBI9BaoeV6O9vy44ZkUHsCWo7kGJit8TZ0dFRY0ULzBZEodE//4HoAkZaK+W5Gs7v0leN6ykhBL6BW6DAe0Cml4vAWmAmtRtPWRrrpeNN7Ku+OZcUfHhLGiSckKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhuH940+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so36460501fa.3;
        Mon, 02 Dec 2024 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733127744; x=1733732544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPWMgettyvx+9ptynz/I3mmqhxwTzOb8w8uMAYThgRU=;
        b=EhuH940+SzXhXVPxLyEQB9AqCjuBixooC2y1zg5/SwTDybznGmR6RRSGvdc/6hoKqR
         2JoJ1tqcdIU9PHuvOMm13d2ox1e7JixmT48twwUjEOOpEVqjQD0ftxW459gk6OWUSA7D
         6ThJe4c7VcGkbdJ+XikhKwrVhU1ebR+AM4rm9TCUruoNFZ87wOZbt2ldQh8xwH1Ufz+l
         eRrT631XJeMALL1PmabcwLsTUYyh+qYJniBDAp3Ke8rIsEjKrY4qYo5SGAoYFS+KOVw2
         Pi5e4A9hSL9mGF+Qjg3DTdlmCV0859A3ghM6USn0PoJFSo5hy5cIP5UM1EGbT2M6uBIs
         Q6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127744; x=1733732544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPWMgettyvx+9ptynz/I3mmqhxwTzOb8w8uMAYThgRU=;
        b=JLreSScnjdwT9zcbG/9FJmzWTWrNER43fddbAxuJy6pWG1oS2rAF28f1venGchRQoz
         G4bZXmIGQjpCVoNhn/qUdJuKvLUgAOKSSSCYilhRKiqTuVPHen8r1n71vaetC9y6b+Zj
         zYux07Io7zf0JzTLn3VhbBbmesGsHRpKmEProZm/7vXztmVel2Q9y3LhRgur2sDRefw7
         b6vav7YapI0GEUDgY57aVBd90kP8TuJF9V/MHrUkdL5KgxTcsfj8RnDg+wMmvlsDfQTP
         S7eRDRqCHnh60yb9JK9+wRwx5OFnhpMhNO87CBgcfVjJfefSfongPMcV+2h80Nn8jOFg
         GZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW06zMXd9vlrFxWvO7dJMgtnoC6qVu9U9WjUMuBLma2h31/OFqC7V04By6rbTdjE5KNFz347RikLha7qnEF@vger.kernel.org, AJvYcCWrRzU1bcVNJDHk/dgGgMwUPUSZm7nfJXkfdSFMe9oFMJ4zpGqOn5ZK5TsjrRIFroA03uQBxEo5QcuL@vger.kernel.org, AJvYcCX1VDV2g7QDsOq7r/F9eK1Gsy9QlOjGVEwksNcK05rnzdaGjAxWP2tJ4NPiONKdCiRXaTXRemRsZUFe@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOqzwnPx5pg6VDKU4rMdd/ILYuiC/0H7YMN86ivROiMgycKQe
	j/q+Mbry1nZM+hQPkHJkhyZ6pw0/RbbCpJ3qDXMjmZRdLb4wJpbZ
X-Gm-Gg: ASbGncskRjSNQXJsUq5oHhVauBSodcCVUbZzzHSAL85TEE9FF9N+1kM1OMRe7K6RKoM
	lpLbrhhe3bh0BGheVymo698jvFJfD/kg9o/nycmO36zdRvt/S1CgJCuV9Vh54mofouLpg1foOvj
	AE9/taJgQM8EiaK/RaN/fWvS9PgB1MeAZP1POAply8Vze73xsN8OIh3NjUT/SddL6scZzPjbvOy
	D9lrNdxKLAEjlrnyXG5c6cqlWYtGqgf6ISzF8+jx+wQ6iOAcoiiTcX7PvWULs1mLLQ7xIRperb1
	lCnO3v+dsXkTBmntZY83W8gkwbG7a/0=
X-Google-Smtp-Source: AGHT+IGl+yCwdlz2rSpXO0UlWRXCUO/3cdmsZapEZ2aJOGm7mWsgD9ilm4c0fOahmXqaG90zEwVMmg==
X-Received: by 2002:a05:6512:32c9:b0:52c:dc97:45d1 with SMTP id 2adb3069b0e04-53df00c789cmr10345737e87.10.1733127743618;
        Mon, 02 Dec 2024 00:22:23 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496551sm1376280e87.193.2024.12.02.00.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:22:21 -0800 (PST)
Message-ID: <9d810e5c-c7a5-41e5-8073-b703717faf3d@gmail.com>
Date: Mon, 2 Dec 2024 10:22:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>,
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
 <20241124211545.194a9f87@jic23-huawei> <Z0eY+1X1ZSkNui9U@uva.nl>
 <20241201132054.0c063a11@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241201132054.0c063a11@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan & Mikael,

On 01/12/2024 15:20, Jonathan Cameron wrote:
> 
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, apds9160_of_match);
>>>> +
>>>> +static struct i2c_driver apds9160_driver = {
>>>> +	.driver	  = {
>>>> +		.name	= APDS9160_DRIVER_NAME,
>>>> +		.owner = THIS_MODULE,
>>>> +		.of_match_table = apds9160_of_match,
>>>> +	},
>>>> +	.probe    = apds9160_probe,
>>>> +	.remove	  = apds9160_remove,
>>>> +	.id_table = apds9160_id,
>>>> +};
>> First, regarding the integration time/gain/scale parameters. I took a look at the datasheet again as there is a table
>> provided to get lux/count (scale?) for the ALS sensor depending on gain and integration time.
>>
>> It looks like the correlation in the table is almost linear but it's not as there is a loss of precision.
>> For example, at 1x gain with integration time 100ms the lux/count is 0.819 but at 3x the table is stating 0.269 instead of exepected 0.273.
>>
>> Is it still possible to use the gts helpers in that case?
> 
> Ah. Probably not if it goes non linear.  Matti? (+CC)

Disclaimer - I didn't go through the patch and I just respond from the 
top of my head :) So, please take my words with a pinch of salt.

AFAIR, it is not required that the impact of integration time is 
_linear_ through the range. The "multiplication factor" can be set for 
each integration time separately. So, it is perfectly Ok to say:

time 1 => multiply by 1
time 2 => multiply by 2
time 10 => multiply by 9 <= not linear, as linear would be 10.
time 15 => multiply by 15

...

The notable limitation of _current_ implementation is that the 
"multiplication factor" needs to be integer. So, this may result loss of 
accuracy.

>> Second, regarding the use of the IIO_CHAN_INFO_HARDWAREGAIN channel info.
>> I took a look at a couple of recent drivers, some use the IIO_CHAN_INFO_SCALE to ajust gain type registers.
>>
>> In my use case, it feels like the scale is read-only as it is affected by the gain and integration time and both can be set independently
>> with their respective available values. How should I handle this?
> The general preference is for the scale to be the primary control.
> For a light sensor assuming the device doesn't support very long integration times, the
> trade off is normally set the integration time as high as possible (as that gives lowest
> noise) then tune the gain as necessary.
> 
> Another model is to let the integration time be controllable and then try and adjust
> the gain to keep as close as possible to a requested scale.  Matti has spent more
> brain power on this than anyone so I'll over to him for more precise suggestions!

This is the very reason why I wrote the gts helpers. The recently 
removed rohm-bu27008.c light-sensor driver and the rohm-bu27034.c allow 
setting integration time. When time is set the driver will also set the 
gain, and does this so that the scale is maintained. (Eg, if gain caused 
by time is doubled by the user request, the hw-gain is halved by the 
driver).

For scale setting I used logic where the scale setting tries to maintain 
the integration time when possible, and only set the hardware gain. 
Ideology is that when the driver allows user to set the time, the user 
is expected to know whether to prefer longer time (and typically better 
accuracy), or faster measurement with more hw-gain.

There are still some corner cases in these drivers where the scale can't 
be maintained when time is set, or time can't be maintained when scale 
is set. AFAIR, These drivers chose to in any case set the requested 
time/scale - which means the userland needs to be prepared to "pick up 
the pieces" and deal with the other entity changing. Other option would 
be to deny such changes, but it would limit the use of the hardware - 
and I hate drivers trying to outsmart the users.

Where this gets really hairy is when there are multiple channels and 
some of the controls can be set per channel, and some are common for all 
channels. As an example, I've faced sensors where gain can be set 
separately for the channels but the time is common for all. Here we may 
end up in situations where part of the channels can compensate the 
changes while others can't. Furthermore, there were situations where 
some of the scales could only be achieved with a specific integration 
times. This can get very confusing for users.

In order to make it somehow tolerable the gts helpers support also 
advertising only scales which can be supported with currently selected 
integration time via the "available_scales". Also, I strongly recommend 
having at least a read-only hardwaregain to help understanding which 
part of the scale is contributed by time, and which by hardwaregain. I 
think this is very helpful when debugging ;)

I know Jonathan (and maybe rest of the world :) ) prefers keeping the 
scale as the single main way of changing the gain. Still, my personal 
opinion on this is that there are cases, where having both the 
hardwaregain and integration time directly changeable would be the 
simplest and clearest solution.

Putting my opinions aside (as this is not a battle I feel like fighting 
- nor do I feel I am the best expert on this!), with the current 'one 
scale to rule them all' approach, my recommendation is to consider if 
always using largest integration time and smallest hardwaregain to 
achieve the requested scale fits your users. (Also, I think your case 
where the impact of integration time is not strictly linear will cause 
some scales to be 'almost same' but not quite. I am not sure if it makes 
sense to support all of these, or just always round to the scale where 
the integration time is longest). If yes, then maybe do it.

If you think the longest times may cause unacceptable wait times for 
some users, or that the small scale differences really matter, then you 
may want to go the route bu27008 / bu27034 drivers took - but it may get 
hairy.

Finally, maybe taking a look if the integration time multiplier in gts 
helpers could support fixed point wouldn't be completely futile(?) No 
promises on that route though, I haven't considered this when writing 
those so it may lead to dead end - but one never knows before taking a 
look, right? :)

Ha. Looking all the letters I typed, I feel I helped really little while 
being very verbose ... Sorry bout that but I really don't have a great 
recommendation :(

Yours,
	-- Matti

