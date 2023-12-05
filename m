Return-Path: <linux-iio+bounces-635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720AD805675
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EE4281BB1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0525E0CB;
	Tue,  5 Dec 2023 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCbI+sOY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B490A8;
	Tue,  5 Dec 2023 05:50:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso4240277a12.2;
        Tue, 05 Dec 2023 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701784238; x=1702389038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CnnPrYJbZn+ydGuLss8Ol0k4CEJ0cAzskXkdkO+me0=;
        b=jCbI+sOYMcqvCfkaSvqiPRMEDIE9RYid9bXyurZiLwNWzp/eH+butlRkZkX+ixtzF/
         aaBeaumkWlcBie4ltwG1Uh9wcsLo/wQwU+e+yD587pgcSzSJDwLd2JSy+YyJ/lzupI4a
         JpS2CeX0OkwQP9JX4P+fRHRA4yMpoOklXCCksVsJKErjQFwCo547HPv/GxOCSF0uuyZQ
         oGdNF+iRkmyctcllSWbnkqDwDGjICekoDAf2Hcmw4CskmXazJsk2FmD8XbM+CPckNZiB
         sedONh/OB9NtDkRWCxPRYbBJyhEw6UTfahAYF1CoyeS7UtC8Xb3oQfb9gY2fBstypPak
         /giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784238; x=1702389038;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CnnPrYJbZn+ydGuLss8Ol0k4CEJ0cAzskXkdkO+me0=;
        b=sVgV+Ux6+0rZtsYJNWfAGifWpJQwGREqp9cY5DdzKDGXuAww6sl5fkvxaa4vXcixkY
         qqRjJjZHaKvw0qHUcPZRRI6PRg0rg9O0NlwWYkgBS8Kg35+hH4y8Er6Q4BPSXgN8Vkmi
         UND3Rf1eo7i0qeheadHxYWhgPBKsLmM0nOM56YtEKTmGoQz5LntZnrGjFXoMEVkMbBXO
         Jlttf9L9h7d/F9jcD+JmjoF2fTyQmEpSPHAWnW32xnKPhnjjV9hRc6OP4tiwr7DHsUzG
         KU3S7Bj/JoWu5PAFIpzULDcSoMJ75k79QPZ0vD3JlTxsqlJb/2ubI7rbw6O4uCjXVP7U
         DYmA==
X-Gm-Message-State: AOJu0YxGfyrB8tO/k4cCy/MeuCYQyELjR4v764bQ5cXWvVR7qBn6xGOh
	ko12yYsa0hqXyfVeSzfgk/UeUqE47rTTNUYi8ug=
X-Google-Smtp-Source: AGHT+IFRaJTQe39dBZzAkMfzbK51eiz+syrbne0p2I0XfRFqE6HVR4Nw6vvZ01b7wOMFjjnYC/bSOw==
X-Received: by 2002:a17:906:10ce:b0:a1c:aa9e:17e4 with SMTP id v14-20020a17090610ce00b00a1caa9e17e4mr468382ejv.49.1701784238338;
        Tue, 05 Dec 2023 05:50:38 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090637c900b00a1cdf29af64sm424678ejc.45.2023.12.05.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:50:37 -0800 (PST)
Message-ID: <9717981d-2f41-4664-afd4-bf9a1544bb95@gmail.com>
Date: Tue, 5 Dec 2023 15:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
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
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231205134223.17335-1-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 12/5/23 15:42, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 

Bindings V6 -> V7
 - remove redundant bipolar attribute
 - add reference-select example

