Return-Path: <linux-iio+bounces-643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00089805A00
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F23E28206B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472776125;
	Tue,  5 Dec 2023 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqi2MDNB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838009E;
	Tue,  5 Dec 2023 08:33:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so412684566b.1;
        Tue, 05 Dec 2023 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701794004; x=1702398804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHAUfP9J9hYw6Y/D0QYfGV3SZNbPrYlP0cxK2LyLc5w=;
        b=dqi2MDNBAxf+t3ir3KC6vS3FtXx/NgPOyE9cvc3FlxuNnf9qYjYlvo/PhtQnFPH77w
         w6t9U8VS/QEtK2F2ZR4qMzcclbaXVzg/d028pdtk30GF098Is7gKC1Xa4a80xS/BUE4y
         iUVPu6JNZHV1eGvpEOj4AyWEEzkRuzLe4U5LJKvfBY1qqO2+s4J5/Gv4cYT8+notRIRx
         jXwEi1FuK6nI+lGrwHuHCl2B3reaJFd2z0PGfxp2FJy4GfyQenGG9ZEPVnKQWSM3fsUs
         Y5k5/LzFufwKpXt8MQYy09kZ/qpk5HToejBn2E0OpIDAZPu2Hxh4zDsgagl5L/j26nyd
         ytvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794004; x=1702398804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHAUfP9J9hYw6Y/D0QYfGV3SZNbPrYlP0cxK2LyLc5w=;
        b=SVEJAk9OKTqvxaJL89BbkPAyAB7K53M5/lUAlJJxM4WT4Ge/S89uoaCMXmy3J/VkVV
         ENtkC1WB/mjclX9cyeTlxib9Bfkab9Jw+9tw4eBgZY90ldK1oax83vwPV95hPwLqkqqQ
         PQ523e1VrIHggcbFJTl3ghaDiyL8yNYczwUC76K3vFtsamy0DRh8gQn9GrwBacxI7p+Y
         OYme4BMpILVV8MOJqz7PhqpJTKI9MrBKvRkw7owIzO+338H5uZCOGtgw3oRpTn7Sy+Gc
         KD3ybFTr4UowEP+FLJImpvOX59PPPE2NwngoSi1Yl5iSSWCQqy1/tTYdXEPQZFCCpN9X
         qhXg==
X-Gm-Message-State: AOJu0YxbV0Kf261r3DvBNdtM6VksQNWm/qtFAxRmlBOAQlu76hNZq1MA
	S7u4sgypIdSB03mIQUpgsKIUrH5v86g6WO2o+y8=
X-Google-Smtp-Source: AGHT+IGczDP9zD/T4pczBEFyAzDxRTWLESnCkO+AaVNv7qm7h1SrX5Wou+uF+c/hxOW2vL6k8xWsvA==
X-Received: by 2002:a17:906:6bd9:b0:a1a:e3c6:f50 with SMTP id t25-20020a1709066bd900b00a1ae3c60f50mr1509048ejs.66.1701794003689;
        Tue, 05 Dec 2023 08:33:23 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b00a1d18c142eesm299267ejr.59.2023.12.05.08.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:33:23 -0800 (PST)
Message-ID: <ac34ef21-493e-4a79-8a0a-1c37e2d9cbb4@gmail.com>
Date: Tue, 5 Dec 2023 18:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
 <20231205-jockey-chance-bc324d8809f9@spud>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231205-jockey-chance-bc324d8809f9@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/23 18:25, Conor Dooley wrote:
> On Tue, Dec 05, 2023 at 03:42:20PM +0200, Dumitru Ceclan wrote:
>> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
>> which can be used in high precision, low noise single channel applications
>> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
>> primarily for measurement of signals close to DC but also delivers
>> outstanding performance with input bandwidths out to ~10kHz.
>>
...
>> +  required:
>> +    - compatible
>> +    - reg
>> +    - interrupts
> 
> This is at the wrong level of indent (as Rob's bot pointed out) and
> should come after patternProperties too.
> 

Yep, it was fixed in V6, forgot to include it

