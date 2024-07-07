Return-Path: <linux-iio+bounces-7392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E769297A1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09F81C209C3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F230125B2;
	Sun,  7 Jul 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="so/gFp3d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EF1C287
	for <linux-iio@vger.kernel.org>; Sun,  7 Jul 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352061; cv=none; b=U3ccJaRSOz0kNqE3SxVNGkoXKjjlPdPzjoluYdrq/B9HUMDi0DAcGJIiAO+0mm+LsZzKfDHybKVPBkgGatxnNA3B7moDQpvr43t7z/ZVGtYIf2N0OV6nM6UzEZJHR9T/bapvfsor2jh8D2Ny/2y4a41+tfqkwJTBcRxpjVWDmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352061; c=relaxed/simple;
	bh=vY6PzZOCbOC1viidshl5tOo2Zra46bFIO6bOWZUs3XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ4mZaLi+i/gXXw3WoWQzz4cbUAV6XC8t6QeZGifyY/Vlpa5b9pHQpDql9f8PXQcg1cry9gQSJ4TZcpjmOm7BAP2wWUNrXijzC7eVwwi0+14ADhNIFEse6D3il44ZIaS/YebEjdfvdMXjOArK1jTyeJwV6qUO9Ln7pRfw6iB3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=so/gFp3d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso1067516f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Jul 2024 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720352058; x=1720956858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3yH9xifrd/g0NDORw3hhTVPNXMDgMFTGnLv+zCStb8M=;
        b=so/gFp3dkDtBzh7v1OJXNd6c1SNU6b4PHzo31Fc4gSw2QoGllm+I7k1fa3Tb+/q/31
         Zx0DoUc9fB13OlF69RXyiQEWujExXbgvSf4XeSJmO5nolkgeCg4kqytOevdt+mwMu2NB
         u2g/EfwBw/4U7iWeuLmmWv73wsBmJQaXhq4/mn7ueFLalBfltxXOnJi43SVImTsTDsst
         1yFgVe1lIHEfmS3BuIk/Z91SQNhepSBbAOgYACvUPDNv09wsQRCUzJmjmtekqx2DOFF4
         AslJupY5Cp341gotGuiYCj7z5c8kVPIetjduQaROVOe/odwPj4QzQOrO+4dYzTAW7EOX
         Bf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720352058; x=1720956858;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yH9xifrd/g0NDORw3hhTVPNXMDgMFTGnLv+zCStb8M=;
        b=Uhcl8grMLGE728cDj3QC4TkkmC3bLBUFxJUpl4/pfRRMII6933D/Gg5h33xBPimNkg
         htpnEzsCSLNFTQ7TPlcjksUxHMVz9GzcubcV3eR/2T1bfg9hRIjFb/zVA2//rCbpcb0Z
         XXr5LVCKdmo5cBfKWsklDrSGyfLI3rSaFETr8v67tZWobaV/Ua6ynMg/NRA0xL1Noi2t
         C/uY9tgkkDUjLnSc4YF2m2y2DKC3chjcqod6rhIejh3+PGl1nVULyOMTsqFuygDk+x4Q
         8TB4gk7RU59M6WNA0ctyeN3Qyx67RqsJ30zMaewctUf15GAQXi6Hbz7qCm2RELmHLm4G
         sUfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQisaHmklcI4VWq0pHAbBMUZowdjyeoMvqt7QbrWajygTadlXSiPmMnoiDXX/3dW4QpyfdgPHCOjf5rGtt8zH5n3XIa9654BAX
X-Gm-Message-State: AOJu0YzlvsgHsVRqWaIp8iIEvOtTxQ3zPQ+mMBNrCivCRxDHUtHx9KnD
	2qm4mI+Aap43tdtHtSG1xnOvWoNNxFnp8ubJK21zTswsk0GqZ+9QmhsuvXoU4L7hkPCOOE1uo7V
	5
X-Google-Smtp-Source: AGHT+IHV5e4omoB3KWOUfpwGhyAzN8qvbwpk21SnEb0UN+PGYukM68hTIpEnYkFuF7KQvDpY9/tANA==
X-Received: by 2002:a05:6000:c8e:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-3679dd442a7mr6600318f8f.28.1720352057773;
        Sun, 07 Jul 2024 04:34:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm25388838f8f.8.2024.07.07.04.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 04:34:16 -0700 (PDT)
Message-ID: <656f7294-7d69-4f4f-95c9-477ee507ca79@linaro.org>
Date: Sun, 7 Jul 2024 13:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad5755: drop redundant devm_kfree()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Robertson <dan@dlrobertson.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Sean Nyekjaer <sean@geanix.com>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
 <20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
 <20240706115229.47b8d7fa@jic23-huawei>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240706115229.47b8d7fa@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/07/2024 12:52, Jonathan Cameron wrote:
> On Fri, 05 Jul 2024 12:40:49 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The driver calls ad5755_parse_fw() only from probe() function, so
>> devm_kfree() during error path is not necessary and only makes code
>> weirder.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> The path this is in doesn't result in the driver failing to probe as it
> falls back to a const default structure.
> So whilst it's not a 'bug' to remove this free, we are removing data the driver
> is not going to use - so to my eye at least this is a deliberate design
> decision.

Ah, I missed that part - just looked at !pdata in the probe.

> 
> Mind you it's not a particularly big allocation so maybe worth not cleaning
> up until driver remove in order to save on complexity.
> 
> Sean, your code I think.  Do you care either way?

I think the code was correct and my patch can be abandoned.

Best regards,
Krzysztof


