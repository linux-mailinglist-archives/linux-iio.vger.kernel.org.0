Return-Path: <linux-iio+bounces-26427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A7C812FD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 945F74E2487
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79853128D5;
	Mon, 24 Nov 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApmgCuXb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC030E835
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996270; cv=none; b=a76ZHZbkT9AiGOXIq8SqyAb9qCEiqq6jmIKjXR2B3aTuvfHMvY6Vw1MiXlgSFy/HOwVu5tUb5NP9Cn1Y5HEs3W3LD+pvVKizlyUnJ9nxSOdId6Ii08RPLEpBcLoBRb68AXQPXTXojZc0l9Y5asamnSfuoDwPOaiUQo7x32pfrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996270; c=relaxed/simple;
	bh=9FmIn5+O6pplszlZNBe0xUbPZ2eW2tGYBT5NNzL3no0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq5jrW0rJNMYrYAB5Bj4krxnlIq4Yg9toEOTfuwl1oH6idUoH9361Z/BLXTkmDgePQ3JQ0qbgSOzn3B3fW1KozykDdr8rCi7gdJ3AVed0WuweXAFAqHHTW//P1h4ejMKTjdRfqUr6ssPssjAKlCVFCiiBmbyppykhUI5WEmkVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApmgCuXb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29568d93e87so40472365ad.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763996266; x=1764601066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FALb1VTIhpeGmUmdPxwMYe1b68LagWWlMgk97eqLtjo=;
        b=ApmgCuXbxhBMeAv+LlvKVKt3gJJoUjsTNxVkISmec0U2LRi4CjyBzhUA/e0pWSD9hU
         h8nJVu+wDjuJ2zdX6sB/NV0kG9SU5mkbypq0zrQABKPlNZMRYI+P+l7NYErjPxHQQ7DI
         VmdeI0z6xecEtWnwhrbW+2frgXqa6IBoC5zmpiwOAY1n0M8QKBmmNCDz11sdXb6QUqSl
         hFT4MKrxYoL3KhzQEBzsaISu2hwsSUaUhmNzrXfQ6iU7Y3BtcomsG/l5/7Y9ujGnZM23
         IOwBdGbUWFfcRclgqSdQ8a2EmYYk18wXDh7buV23fu/LbqP+DvN2FBQSiCiMQxl3kq9C
         zfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996266; x=1764601066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FALb1VTIhpeGmUmdPxwMYe1b68LagWWlMgk97eqLtjo=;
        b=ehD5lN13dMCkDEAyw58eqPmGitzm1s6jifRvu9aSsPwxifol1Eg8121mX8N8enIsjZ
         9BeS9JVxhRL0CvopUowbOLeymXChetrCWZGeC3ewvH8SE5yl5dpgbhJteG5YbpuZqkZZ
         HRZZmwidyxgEG/RhJjIfhVbRJC3MXQG5QttEgCWLX1/G5wFP/3F6+k0pysj8Ahqa40LK
         a6pw44bjb2LjNfda+tV6/Kb09NHUCsAzcfTuqdTfPn0M1s0Yh511P44uhZlfF1i1y4G2
         L57G8EyQAlfTw+/q9ruGgo3O98KuAJxQ9guwNtRQb+4/6LHsKbpNbuMKmzFWgVkflXP2
         /Kww==
X-Forwarded-Encrypted: i=1; AJvYcCUb9EhkgzhgChOUrMs5mR+SeVZPt2BENc+tpw+12lLuTofLanH/uGR0taTiJGLK8Hc8b8bAnDl6Jgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8ywdkenORSDL7G6wkrhtODQt4oRWO7qiYIw5w2QHlSolpzXU
	Ul16h+M0piJxYNzgOHE/DzEzjHrTab75UsJviGtycIeSFHaZCeTvbG1b
X-Gm-Gg: ASbGncuWzpcs5QK32lGtOVvAppcTNwif+a5rMh7S2/TtWpKzOs4a+BYkGkBKFRHrmqz
	Hp1cg1WEb7S3tasobSLYyNNp51fYRnuQ2Re6k/cN3iXxrhNyhiqMJgVIQNSHl/5cuyqR+VwxZff
	02rSQqL6fAmeJPm6LhnhbbceZba/7VsAoj2VAd18wrBlYh308XGzZ29PvPKtb2BL+GfvIjJjF+9
	5RNLqY4tc2tsCaXl21iv68fsBNmnxaIX0J47C6RHaC1BYq3FWKGj6V4YKOBfGOJ+LbDcfja14Pe
	KjRMwFqh4pkMcAAUoumDdi4oTJkNx+6IMeR49i8roLz5usB8eg+3au/EkzRoAHJZjcJuQOKH1H3
	pdBXM81+ZyPYjxe7q72O6vnjZZaszgBpHW0on7Kxaa33JDsZSNR0Sa+1uHgJKFtA9YZrGvduZ3z
	M/uuIFi18ns8ulB82U86Zmi4ODAXnlhejOY/cSkAOdKV99rVEP8aq6Zl56gsE=
X-Google-Smtp-Source: AGHT+IGm6VR7ymXhUxDgQYPR+X4tmdJ1Gi8wp35kJdoj8OsT5ltSTjhw1rEj+afKxTCeu7PC9j8nHw==
X-Received: by 2002:a17:903:1b46:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-29b6bf7f231mr98043775ad.51.1763996266291;
        Mon, 24 Nov 2025 06:57:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ac81bsm140085885ad.93.2025.11.24.06.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 06:57:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
Date: Mon, 24 Nov 2025 06:57:41 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
To: Romain Gantois <romain.gantois@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Peter Rosin <peda@axentia.se>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 06:48, Romain Gantois wrote:
> Hello everyone,
> 
> This is version four of my series which adds initial support of the Linear
> Technology LTM8054 voltage regulator. The driver supports a fixed voltage
> and a tunable output current limit using a DAC-controlled pin.
> 
> I'd say that the most unusual part of this series is the usage of the IIO
> consumer API in a regulator driver. I think this makes sense here, since
> the regulator driver has to access a DAC to read/set the output current
> limit.
> 

I don't think that is a valid reason. Literally every driver measuring voltages
or current uses a DAC to do it. How else would one convert an analog value
into a digital value ?

Guenter


