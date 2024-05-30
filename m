Return-Path: <linux-iio+bounces-5503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A38D4E43
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B489D285318
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3817C22D;
	Thu, 30 May 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y15W4OkV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B9441F;
	Thu, 30 May 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080337; cv=none; b=BUAr0UEFHJ47zJ8A2nXx+prAUxDA/aSQGBMXnfUW4YjQyo0UzCrqUvyv2lFhs40PnNjrjCceYjkfpn2J2PL7gOJGDp7hY0Y97+G8DvA2vTe/NakQIwjni7TqzItPuGsZVoANBVe0ZWW4tP0vZIjcoCVunXIXuOM10GbeqtGcrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080337; c=relaxed/simple;
	bh=HxzS0b0qqJevaZ/UZ5nL3/LnUN7ON1g88Gtn9Rz3ZEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpaGF0u1+kghON4MQjIOmjQlgVtIoObo+mD9HnYcQukDZldI1kW5cm5l3ExYPJ9QdE0x3kpxgLzA1MDu6gQG4uc1DaDviWLb9vxo0mvDTw0yu6Lzb3v8lNfcZh6UBhZY8tvkFBgwwge8xP4w56tVkmyj+YHmWk1xeao9Ga1k8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y15W4OkV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43fe3505abbso9852711cf.1;
        Thu, 30 May 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717080335; x=1717685135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB9iJT3M7oalHwJVs27bPG9EyFP6/UDFrKyVApA2LyE=;
        b=Y15W4OkVBXRcVQZhplnOaAE9mJTRCN19s4vGfv69mtrg2B+8fJOHi3UxxP+++iNNt6
         MAkFYoqtdb5cDBdkcG45Cmzb9v1Cj+UhkELOhi6MIyI1HPwyp0jxqsb+2rzQYRqbNg1g
         1jlE72d7OdMRELda1MIvISrlnYGiU6Lejl26O6cYFaQ/acKja09W0BtOUwig7BLnduER
         +ikK0ZH6LegmmNSwc8EYI1iSkY9wx01JZzX6y7xphFiS6fQZLk4o94gFJOowf8LfFojI
         jG/is4nxVsHvfQ277h248ZH+PhQffNhgKJW/fYHcjWihqJpFBLOPI/PgV5ycqe6MA495
         7HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080335; x=1717685135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB9iJT3M7oalHwJVs27bPG9EyFP6/UDFrKyVApA2LyE=;
        b=MjlfHkMzAT7WthWDIDVHqRCy/F8DO3H/RiOtz1Qdq7beyQ6uWxsZIK09uvA8HgN+cw
         CV9GpaOgp7ItRRta5CTfRqEzzrUrcUFiLQPGMVJFetIOuggRWVXPgoAsnw/at16K7Mu1
         jra8Y7BO+pI7Nj3A15x0dghgTzGhafdwQ9D7r4kNKcXRr1bRDhg0K9D49L4MDufHob/h
         sCVoMaRs8qFtjcsiR201efhobJE8t8nkuspg1FYRKMwD+Qon+UWhaQ1C3kCkK0/aMFmu
         NL5neUBwfgB/S7uwtFlD2LMx8BVq8HCjFEZl9XI+1EQHUs7G1/hFN7almC9CU7g0Efhf
         Hlhg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zWfdbUH6zomdjWmRT9QAS7RjXrmR1P/kMCtJgyTbeqKSAradfG5eqfIzlGFIVpZ7teH16eXNWrLmStFywIF1xTvtzzRRWxuwHfXDVeoMeQV59um76gC70nrkPcGVm6gNwXmjPQEVWqsOOjuYsVezcg48d963VizfMy3A3kGr9RnbuA==
X-Gm-Message-State: AOJu0Yx9BD3rXUwROfZh0e7AoxhPxK/5rJ+O5xNLe1GIic5RjiOmblp7
	yB1pGZimB0rA/5UNpAGUTssO/OCWGf7UltRsGfJ5dFx+GjPfP5k4
X-Google-Smtp-Source: AGHT+IE5JBT8PErngIbt9sfKo/Khb+GPD9NOkKVJ9Qt8nCjJW0g1J6UKdp+uHOEwnHhTmI7GLlwfxA==
X-Received: by 2002:a05:622a:201:b0:43b:173e:ce1b with SMTP id d75a77b69052e-43febff5acbmr29916671cf.32.1717080335137;
        Thu, 30 May 2024 07:45:35 -0700 (PDT)
Received: from [10.76.84.175] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18af564sm66255591cf.70.2024.05.30.07.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:45:34 -0700 (PDT)
Message-ID: <d2f4e6da-75b1-4450-b295-45772dfb3f33@gmail.com>
Date: Thu, 30 May 2024 17:45:31 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] iio: adc: ad7173: refactor ain and vref selection
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
 <71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
 <4b704b553282c0689dfef714c49ba97a33198898.camel@gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <4b704b553282c0689dfef714c49ba97a33198898.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2024 15:49, Nuno Sá wrote:
> On Wed, 2024-05-29 at 14:27 +0200, Nuno Sá wrote:
>> On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>

...

>>> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>>> +					      unsigned int ain[2])
> 
> Pass the pointer and size of it... Also, it should be made 'const'
>

I'm learning here: what is the purpose of passing the size of it?
This is a specific case where the size will always be 2

Also, this will make it awkward in the following patch where I'm using
the assumption of size 2 to check if both inputs have a voltage divider
                                                          ain[(i+1) %2]

>>> +{
>>> +	struct device *dev = &st->sd.spi->dev;
>>> +
>>> +	for (int i = 0; i < 2; i++) {
> 
> Use the size in here... At the very least, ARRAY_SIZE() if you keep it like this.
> 


