Return-Path: <linux-iio+bounces-18796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735DA9FAA9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8166016C884
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EBF1DE2DC;
	Mon, 28 Apr 2025 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aCFbJrme"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C841CAA85
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872434; cv=none; b=goGn3iJpwQexz2UmecE/IcTI8OXWw89V0OABSt/LNzZauiaxlWObYPscMM3eEBZgIvIi3+ACMmAHnTJlMqAMuwrSm6MTXRt7QlQDGt3yH6f4CJSPh1dwC/v2seCJ7CCEbIcUiYdJroLAdb2fT7CguB7qxdeljBpURDMvUos0h3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872434; c=relaxed/simple;
	bh=79oGkqwqtoEAg+LJ8PFwsRkiBa1NsJHHWe5PT8aLALc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTyVDPADBy7qR2TRCzd3rkED2DyPb10E42f0EX0/NiJkFF4mB9wUULpyT2fDZ9yEPpmnvDEBGjieK3fr6BtMIqyTgMEyhPO1ARQSpdkeniVddYBz83ct1Qj97hxGiLT40U/NvILQtvp4lF1BMmilc9zMrtFms8McpHf4KNcsev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aCFbJrme; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08f9d0ef3so329508685a.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745872431; x=1746477231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79oGkqwqtoEAg+LJ8PFwsRkiBa1NsJHHWe5PT8aLALc=;
        b=aCFbJrmezUCmMNcZWmYIrcdg/p+lw3Aw5kAkIzPcLqClR0fxumM5hDsvZ08vcR39pw
         Wh9OHIFhOF/NdQ1DzU4X01N1/K26gahtzPCTSUQ53ZXIxN4jBdTlySwsQhILqptzL283
         5bHprCsFYwkOWlaxFxS6Oelhc/+4eA7550YASVLgpIdJU4jDLpMwv2XELhNu39AVrL5g
         wB8wP73UiJHc6CHdNYr6sSPiRT2o0jiTHMDpYA3ZR3tvlpb6z4clPem/MYaGk1bxSmRO
         iEq5qW3XlxcfdW1Xf4TK/TvtTOlavemQ3mpYgC6930J3km+ACgGdB2d1FP97fb+dEmjy
         Hxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872431; x=1746477231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79oGkqwqtoEAg+LJ8PFwsRkiBa1NsJHHWe5PT8aLALc=;
        b=bTSwiJ9Kf1VpP5w6qUhhKxDcnDZ1ss3oNSqv/vuWojicuSfO+CdhoTOtj44SUPJhOS
         nJTzXW0k+t09c2L64n6jdbMjTphedhmRlPUj0Gwsltar8f8b8iRjHc6wr26I/Niw17mI
         w2PZ6XhJgCFDX9/6L//SP0cgWLeofsUhIKPjaxF94LYRTggBVllQ77zg2WiOEzf/KF2K
         yep4D6C1Ta2zOzKn28VsllUatgTnM+zDl2MzwEiLDIyN25gviY9dlYiwR9h1j1R6VCPc
         56d3ISZrXaYKwNFVcc2CpSPMBvCUCtphSYCqqSnUhorIJgq2st3GbRuCV6wH6RfgxYCq
         nfbA==
X-Gm-Message-State: AOJu0YzDrzjsEk5qaq6XrYL048woMC89cfSTDdfePJ2nczRUVyLlDerq
	0UcJmgd/U7KcoUm+0fugTinbR30A7QUtM/8gWXW2XIp7LUBG/pYGZtvXuwLo4JY=
X-Gm-Gg: ASbGncuvfzhay38SbV/uz50spbeFDNmgHg8HSSwwzfbTwP28VpQxYxsa9EV6N2sf2l0
	Kwq1iHzYR/2dVKm62wxn8Ky1HdR76z4W/SXqOK3VbI7mO9QwGhvRJ08QSr0jZ5FlgIq9lvcGQcg
	kdR1UMgKjuuX5hdFGkuojOH2f5d4Vlnp58ByjeeZvYQlqBe7eCccOz1Oo0+UqoD5LJ1xNQbjuH6
	1rQMiD8qeoTZReDlr+0IoeDqm4+tvDXSsu0+SS1iMZGZJ6Qw0JQFp4mFlJFqxgbrn8otnibY6XH
	hfJ525nEFBu01gc+tPaBPMd+CqYU+TTJChUYY26+Ni0JOtEIba4yNydYbXiCwoBDN/SON6guScW
	DEUkmXjChRfwvyZjAx94=
X-Google-Smtp-Source: AGHT+IFlcN5nnqIp3+wIDhbfjG3UuYw4IWpcYOaPFaUvM68K3UVRPZ8o7MouMxjeweLiSpXKf08LaA==
X-Received: by 2002:a05:620a:2894:b0:7c5:4463:29aa with SMTP id af79cd13be357-7cabddaef62mr157852585a.40.1745872431252;
        Mon, 28 Apr 2025 13:33:51 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d87309sm661055085a.80.2025.04.28.13.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 13:33:50 -0700 (PDT)
Message-ID: <5d76e5d1-1cdb-4921-bbb8-a611c831cfb8@baylibre.com>
Date: Mon, 28 Apr 2025 16:33:49 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
 <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-3-6f7f6126f1cb@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-3-6f7f6126f1cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-04-28 16:23, David Lechner wrote:
> Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
> used with iio_push_to_buffers_with_ts(). This makes the code a bit
> easier to read and understand.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

