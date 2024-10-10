Return-Path: <linux-iio+bounces-10396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130D998E04
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC222835D4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1519C55F;
	Thu, 10 Oct 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GDklZcCV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEE199FDE
	for <linux-iio@vger.kernel.org>; Thu, 10 Oct 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579917; cv=none; b=fqRjxOntZVhchofuUBFq6VUNKrtJqDFOABdII7jUuR6PxQMM4cWt7ArD0HHEsuWTEBHo5X9wnJa6Gr67VSlh/A2VhYhszEVqvna8fXLdzHRezgr4X/J8onD9rZvSkd9mB/TdCatk/vhAGiT37gEyLIKs1aaePp3ykmz7p3PNFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579917; c=relaxed/simple;
	bh=9FveIuz13TN1AblFtkPdTceZQD0iMtQCCXeK7qgN+sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9hwQF5Ir2KnN+p3dPW5lzikPA96GLzVHJFDkW925C6dO93QGFjkt7RGgLMOfDdevwNQcxb+e3OcAOLEHfOoNbIeTFdsZCOpFQT79BafVFVqwkVN9RD7l/L+VrGgRoeDE01c1OZY9F4Jmf60z9d5tP1TqV0C5PU/eUUysxQQz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GDklZcCV; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-287c5745a9bso499774fac.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Oct 2024 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728579914; x=1729184714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4N1UJJB6VzHlLEJOiTTygzAjBQKfKndu8bsLaiWrQc=;
        b=GDklZcCV0V5t69mCLp1hPAlZj7Q34mB9pilkAHCuQ6GD7zjq76KR/cWymcoOR8ECb3
         rz22mG8RUFoSwg2QVZJJmA+zpZFd5TKPlsUzviEhX6JF4RgH2ktFRkrbabKlJH1c1DQI
         Usj9x4m/TATFDzqO2qxwznag8+tz/nqSq2uMBVcwTfp1CLx7+tvrGZYJVA4OmfdwvJS2
         k7mCGiaTpx6jj+GSqMp6gK9LYArn0PR/Fe5xQSA5Min2PgJ0dQ5v5eHJx7L8xZE7hGzB
         21G+FjgF06zXGQotXD7Qfh6fvCluxUJlS60/45VSF86fM9vK8oOPcZJLKilIvTCiUpV2
         lESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579914; x=1729184714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4N1UJJB6VzHlLEJOiTTygzAjBQKfKndu8bsLaiWrQc=;
        b=DxHObPXAH4dxfBdyG/Idxilbl+mmbqWdSBNCPtjyLGWpY0en4gKm/vyYTqmxNs+Eml
         1BeWAhoVBsPRTwPYtQQf6avtz3/uJefEf+USm2KjJQSzwDI/IY1wYRXHTbelMJSyCftY
         ib7qGe4vrga3m2QcXeAzSr7AlV7se3mgPvBSTPIaevAqCxgVHuGQHXFPgPRoZcXBr5DM
         BYC6LD0ZRHlP/MyfE97I94xqe5KSEC8BSDswsu2rXdRo+Du/CLIpqdte45tK/mz4P27f
         0u3jlS+4NbgAad6gBSjBwJM1m2iK3xrKBMxwsQayN/TC05QFu4fykaTpSrd+8bFJhZaj
         vQLg==
X-Forwarded-Encrypted: i=1; AJvYcCW4aeGj2LSrPdQETYhGysXEqFWNBMq7IfmdFa6Ir1YTGH2nmL+WppQP1uSVoMtY3jSoVbs+ucF6Mv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw205ZVUhiDrQkKVKEmpYpmNOOve5zSvX2vyDW/qvUAS3iaSJwy
	IeEW/p1IMpCAx/zyM/xyFfJJqk4lmDq6IQ7TppLBj5kBDr/no7l7sYoctWQsMjs=
X-Google-Smtp-Source: AGHT+IFBejNCLo9F+D5dkmW3LXQHsQ8mLCJvv5I50aqSbJ78R7mOKvr0yeKfoBHIYX6hJzvpQBBBrw==
X-Received: by 2002:a05:6870:c1c3:b0:277:c027:1960 with SMTP id 586e51a60fabf-2883434b155mr4612084fac.25.1728579914084;
        Thu, 10 Oct 2024 10:05:14 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2885844a8b7sm369613fac.58.2024.10.10.10.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 10:05:12 -0700 (PDT)
Message-ID: <71c4a073-1b5e-42d3-8fee-a2a5215d5856@baylibre.com>
Date: Thu, 10 Oct 2024 12:05:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
 <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 5:48 AM, Miclaus, Antoniu wrote:
>>> +static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *val, int
>> *val2)
>>> +{
>>> +       unsigned int reg_val;
>>> +       int gain;
>>
>> Should be u8 gain[2] and...
> 
> As discussed in previous patch series, the bulk operations won't work for these
> chips. The CS needs to be raised between each byte read/written.
> 

So the datasheet is wrong and Streaming Instruction Mode doesn't actually work?

There is also Nonstreaming Instruction Mode if we need to read/write nonconsecutive
registers without deasserting CS.


