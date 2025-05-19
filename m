Return-Path: <linux-iio+bounces-19696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6AABC243
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04C57A58B6
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A956C2857C9;
	Mon, 19 May 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NOyVp3Uc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB38281351
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668148; cv=none; b=OBpW0QhlYv3kCtrYe6mnMZlwr+GMnGoKVH19b4+8kf/IQzusUUDaUKjOofnbnMJm9Brrtj6ym+3PFAlIat85HlhJEfPkLGXpf2ufIHKpn7VspNKrYlftCRIqifxx46ttBmetlyrEMSpGxk77Dxsclqu1s0X6KwdW3jG7YnvRgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668148; c=relaxed/simple;
	bh=p4CkxdSpwoxKhGX1PMyY8JUS3X9caCIepN2G/OGryK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pnZm296oD9XtTUzE4jAc4D/DTHgAl2EKb/8y+C1HuxEN04AJzs6IDiqkFQVtQyLrZF+uh6/C5s6GLytwq1+OSAd6JLclZL+aVo8/JgfziWKZVmb3zr66gR9jfCrTM+OfA6vjqyuuxEfqaNIGXraV8VZGyyAVboIlwBV20DLdS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NOyVp3Uc; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2e41064e247so1058393fac.3
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747668145; x=1748272945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtqdqspNTvytDy8WFC/Wqlqs65C7PdRK37lEhGHGnU4=;
        b=NOyVp3UcztYhdMrfPtIwHprlOmF586SiJICG/u98SwN4hHnS+RN3IZsIAsufMubzvj
         DIHFtWOb3SbVI9cg4FG+oLKq01JGcSN64V1xOYpL7VWC76Gy4TpMRLk4Hh/Bv0tpIsCj
         8z+yqZg2h9qiZ7kOQz2q8SIUGfeQ/Clv8f3GaE0Zey2t3B+DJj2G6n4ve44QAInXVhfF
         7WWaCEQHfKOPiY2foFr2riptrMztE5XEMFIJo4AcAwfy9HXjKBEY5CNUDqG3j8dDX+Nm
         7gYy4rj4hI5alNG1QFeDggUUXy6YqftL6ovxEQnq1jIIM3rSTZ8S0nVnYnc9LpC4Ug7j
         UwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668145; x=1748272945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtqdqspNTvytDy8WFC/Wqlqs65C7PdRK37lEhGHGnU4=;
        b=tc20VzkUJXUY3Q1YJb0T4eaZjjJidnpUBnFFEiUoabQiAfAZVl+AZAESht63ZCUL9y
         6CHupXAqhOIxeds9Oyf+eMbJqProkPzzJBPCCdsc/JTrBmu/ldv76n/JnReg+hgutW7b
         icmw39xDyytwC+A0piM1RBWaD73KNanKxxArZK9TPYpeANLV1D4WsfylOUCykDitPeKP
         rlvJissl7TfcU4MCmrD/ewnqQ7cwJtC5r9OMzJubbUcxHEyKJHo7rf0BsEf28LMOF1H4
         tK5X0tcB0dAC/cq28eRt44AvDEF0S98S4HOB7k6zQkaPnq2Zj9STytUJtbcZI9wKyD3a
         7SNA==
X-Forwarded-Encrypted: i=1; AJvYcCVWKZUBNQ74f4Iq6bzuabs673941LEIKSwXg1Gje3jC7iBzagYkIQTO22ET2uMcTIwcby/NWmkBtTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZH/aqeHwpu1oMOxIwE5JEWTwaQjvyBt1XvHbI2wwSHPoWAsG
	q4Rv5oPSSKELCRqi6XQG3seN5jBoChpwjmTn6VQ3RmpYB9Jw1GBad1VRkMAV2Y16aKc=
X-Gm-Gg: ASbGncu9aUn6SZjvAzC38bnTIt64H3SzD1fZO8dtWrrndyf2diOCs4Lu5hiM6SR/4rx
	zlIcmlFHt766ByngZzEjC5pyxl2nI/nNxkIsouiG/iAHhzO13Sj1kOXXylaKOn2tVF8mBGkWVsH
	VvhK3Kxh+RAX0BsMYoQWlDpPylbsk8wB5oFlu5aJPGw6b/Dgp5UOC3rdmb6mgLfbg4U4xfYsScl
	2vEW6idQY3YFac8PBVOLL/nq/bG5DgvqsanYYbE60WNUNCqpY+J3IDNPpebQpWU7QS+oY4cjKeU
	nabebT5iWOoLd0f1jXdAYFJu+FMq99R0coZxuE2POPaK6sTIu0SuS3wcp3AY3etfNchic1skevk
	aKscJ+5Sq8x/p9D1FmVJfXbNOxA==
X-Google-Smtp-Source: AGHT+IH2otVyhPZxLp/VL+teUieHdCcA35d9h2jnmXZKnSkeaWPFws7WNcU20mosSx8Qw9AH8t1yUg==
X-Received: by 2002:a05:6871:ca42:b0:2e3:e277:4722 with SMTP id 586e51a60fabf-2e3e27747admr5863151fac.16.1747668145438;
        Mon, 19 May 2025 08:22:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5? ([2600:8803:e7e4:1d00:a628:91ca:eb5:d6f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c06083d4sm1798272fac.10.2025.05.19.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:22:24 -0700 (PDT)
Message-ID: <fc47b801-6d10-478e-a551-6a325c25907a@baylibre.com>
Date: Mon, 19 May 2025 10:22:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add support for AD7405/ADUM770x
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Herve Codina <herve.codina@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/25 9:02 AM, Pop Ioan Daniel wrote:
> The AD7405 is a high performance, second-order, Σ-Δ modulator
> that converts an analog input signal into a high speed, single-bit
> LVDS data stream, with on-chip digital isolation based on Analog
> Devices, Inc., iCoupler technology. The AD7405 operates from a
> 4.5 V to 5.5 V (VDD1) power supply and accepts a differential input
> signal of ±250 mV (±320 mV full-scale). The differential input is ideally
> suited to shunt voltage monitoring in high voltage applications
> where galvanic isolation is required.
> 

Adding links to the previous revisions, e.g. on lore here is helpful
for lazy reviewers. It saves time having to manually look them up to
see what was discussed before.

> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Odd to have email headers in the message body.


