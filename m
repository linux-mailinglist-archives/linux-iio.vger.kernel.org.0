Return-Path: <linux-iio+bounces-15487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3D0A33ED6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30053A1D18
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203521D3FC;
	Thu, 13 Feb 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+kX5ZYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A1227EBD;
	Thu, 13 Feb 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448653; cv=none; b=eoGZp9FrxmT3n1TkZ5mMBIOnI7BskzA3XmKNdjRrbZ9iAPvQ6b1SNpjzxTAp/rLtvbCcE5N7sBeb63OSxUsCg6qUx6WCf93fFy+vDWXeDmTLLgCyiFnLK315igqeyaxLvWJH+H93HAlp10Y0ks+cB5vlpVowNzT3sFf8cXxB1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448653; c=relaxed/simple;
	bh=+wHjZEL06fuAlaauWiHBK3k5eI+dCrqBLbeV/oq3oyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIF6QxI/VMp15Ky9ZPMd4OIHuadUHhGo/XdKYb4HTahwDJX7YqJ2IXk8mNIb8CgcsANamwphCZwAD6LWZTAvUPhlxfZRRlmo9pv4aEjSBYqklmJyAmb+gW8xvxwYfng84IqSdhRTfmicEk7KPNdE5zoWZEJfzx+SEh6xRFndCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+kX5ZYm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-545039b6a67so723529e87.0;
        Thu, 13 Feb 2025 04:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739448650; x=1740053450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjbKNWyHu3nICHOpUm1bqACFq6iRvtFsyEWKWP28xMI=;
        b=T+kX5ZYm6wyETopyHK1J5zuD5FY68cZPKQ2EW2tnnPJrO0h5Gq6uNnJH0W0T6RkZjZ
         Bp+o6AAaZ4TfflIdEIpEzt3qOYu1xkOOnY+6DLcKJSJfdkX00sGaP7UNStgSSF+MwlpH
         z0tJrjrK3ERrIm3ONDA8Uig6cR9kyWoqiFO/M3/OxWbXOwUWKcPZSFETmvM3JiNmI5j9
         I7llT/u4m78Jssttvv7ltC9EaNKwu2IqWTqzYfim74T4PzQ/RXyvHNCnPT9Fbhl+fuic
         x5B4xIAT0fBKmKUjKbwrZZq9nDu9DbpCmvmwFCfp/yjTiRIDuAzxQaG46BE9Jgkzu66g
         mSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448650; x=1740053450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjbKNWyHu3nICHOpUm1bqACFq6iRvtFsyEWKWP28xMI=;
        b=gmiIcTk0JKsHoWNmvhXOCZMMYBNhG/BW7u4CkIGXmrF+xqY1CMNmptbqgqHoy1jQej
         UQIB0mnTrchma2msjlMUMY0/VqR1ufnzrsOOxVQLfqGMFgy2LMVJmkPmTv6v7+JPiq/f
         nnjdJoo/dxZmp3ek31KvwPzPqu3/cd+cc8jJCHAHI0X4HMF1Swrzji04rgTzn5mT5Z6h
         bjS1p7l8TDUllj0qTdGBobR10WJO5Q68F/KPtcXag23UPa7XAA5unD5pqzvErpRCApGv
         b5bGlJUR03uWzEpTpuI6erqzZs4T0lj0kmcRqSGGtm6ETvwJHtQycNNT295hi1demnJL
         k19A==
X-Forwarded-Encrypted: i=1; AJvYcCUewLfawkHXUL6s0qBr5d/tlW6M3Rwn2ykNB15xKCjh00JQuFm9ePo/s8js1WbeQ8Aud4+n5qzv14451Q==@vger.kernel.org, AJvYcCVABTxcTkC4EfnZadIOIzawZNl14z3YYVxAia3CjNm9jlS3ZM2zEpgYDZ7M37qNVTQc0zSJaR+JBF5a@vger.kernel.org, AJvYcCVC5XCoqww6kxOTzqbfA3+WV6oWhPvF6FD4w1Q1nyfGkxeQqQiXZixVFxR96BHBIL7qPKN7VlCQlP5y@vger.kernel.org, AJvYcCWBXYDoiE7eqShj1iwRcqWwJwLedb8zfYMgz6RaNila/JhPPR+jjmfS0vMYha593VsVBkavYpXGVQvNymWW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05ipustWcyCtR7C90Q53ItmXp22EmBhKdIxMBMIlr9NpSlN0n
	G7lWfHqyLkZzsSsEXm/qrlFLO6odEfomGmwlboe0Sv72atrHa5O31YcT5A==
X-Gm-Gg: ASbGncu1dnEaA/IqTGHz4Gm1JixBmzQt5K8Iqqgne682cU+8SJATOLbnfMMrKaBzvY3
	mDDJmANtPYb0RUetlUOUTrmoyN9UFKz1DYOpygJ5MTmpzHUuedVD1iR7eOEOMG2Kogub1EWRsai
	3ylBk8/b89NoesqqdboGfdwSVvlQVyqvs5+5LG0yCaL43R+ZUr5DZ3UL2+ik5SjIHVtM/u6rvEa
	wnYv5CgkUqd0sy0GZ+dSaoHWhFwyu0qUKBx4jTE+lYLe6QdUYprv8tAGiWcgbc4jBaUI8+r0jhv
	5mSISFaB/ndfwcs7I5RLfTFXofdFThb2q3v+p8JCsk6VJCs3r5QPTfvMn6s3PDCbdCXbZ6UB
X-Google-Smtp-Source: AGHT+IGpoMZI8fDUOZxAPW4mBHjYJsXr848WE/kVH+W3ywBpTFiALih+hfZBi9v6rHw63YfKkpY7tw==
X-Received: by 2002:ac2:4e91:0:b0:53e:fa8b:822e with SMTP id 2adb3069b0e04-545181893d7mr1793358e87.37.1739448649637;
        Thu, 13 Feb 2025 04:10:49 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083535sm149241e87.32.2025.02.13.04.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 04:10:49 -0800 (PST)
Message-ID: <74331ea3-d292-4048-8bdb-32d089b151a6@gmail.com>
Date: Thu, 13 Feb 2025 14:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
 <6867812e-7269-4686-9fc2-55afd9fa91bf@gmail.com>
 <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
 <a52933a2-8b87-4e49-a346-91266fe3b675@gmail.com>
 <CACRpkdYMytiXoXrjTX3ts6ce1T6Xf4rSyk=sDP9fYz730Q-3bQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdYMytiXoXrjTX3ts6ce1T6Xf4rSyk=sDP9fYz730Q-3bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/02/2025 13:53, Linus Walleij wrote:
> On Thu, Feb 6, 2025 at 11:09 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> 
>> I just realized I should've shared the link to the v2 - which may not
>> include all the recipients (because it no longer touches all the
>> subsystems - and the get_maintainer.pl probably reduced the list of
>> recipients). So, for anyone interested, here's the v2:
>>
>> https://lore.kernel.org/all/cover.1738761899.git.mazziesaccount@gmail.com/
> 
> Well it touches (uses) the gpio subsystem so the GPIO maintainers
> should have been on CC...
 > > This is one of the shortcomings of get_maintainers.pl really (also what
> b4 is using): it does not know that if you use some specific APIs from
> some specific .h files then some specific maintainers need to be on
> CC.
> 
> It's because there is no hard rule: <linux/slab.h> - who cares? It's not
> like the memory management people want to look at every user of
> kmalloc()... <linux/gpio/driver.h> - this is a different story because
> it's possible to get the semantics wrong.

This is a tough one. There are also a few other subsystems (besides mm) 
where maintainers can't stay on track for all the users. Also, AFAIR, 
some maintainers don't want to be CC'd by users of their subsystems, but 
only care the subsystem core changes. It's hard for an occasional 
contributor to know who to CC - it's often safest to just go with the 
get_maintainer.pl.

Still, I recognize the problem. I'm also trying to review users of some 
of the APIs I've added to IIO, lib or regulator subsystems. What I use 
is for this is lore + lei which fetch me mails with specific keywords 
(APIs / API prefixes / headers which I'm interested in) from the mail 
lists. Regular email filters could also do the job, but it'd required 
subscribing the lists which tend to quickly fill ones mailboxes.

Anyways, I believe it'd be best if maintainers who want to review users 
of their APIs did pick the mails with specific keywords from the lists. 
Maintainers know what they want to pick, (occasional) patch senders can 
only guess this ;)

> That said, I looked at the patch in lore:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for patch 4/5!

Thanks! I do appreciate all the reviews as usual!

Yours,
   -- Matti


