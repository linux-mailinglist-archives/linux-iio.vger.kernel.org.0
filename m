Return-Path: <linux-iio+bounces-18853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76646AA10F1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD0B463FFA
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83B23E35E;
	Tue, 29 Apr 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KJhNUmxZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F124113C
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941854; cv=none; b=kSePwvsZRoTVpCBFHdI61ELiw+JLgKeAb4BysVUsVzmDXJYkb8KCI6QfTGeLBEkIcE+s4wzsWgzLge8CEnrMq/wuxIorZh/elWxYwWOTvhD6hQRQrVQj2/BbZIDP4bcnM1dbAweu2+1I8KuM6Z/6mmXnIYYK75TTfeGPo+5SI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941854; c=relaxed/simple;
	bh=27sUWC+HFFtmMxGijGj3WlvDdGSGLfoqsxoR+r6qkAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXxMVRUiK3pLVvdzJjxvwPzx5nLEXjHD7r7YSqxDZhnr+Wj4MyqqZCPL6QPnaAuyiCtku3spRFs68R8WLw9/mRrPyKfe1HlmYh2HDl7kSr+sf+s7eB45dUe3xfxlN6oXXJNG7L4WYCtlVLg8YRAmo4w22sb8wZF0LECyLPnkxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KJhNUmxZ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fb3f4bf97aso1932169b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745941852; x=1746546652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IWwy2Q6p9XeoTqr1hNsCWFixc22wa18HwPhsdqWpx4=;
        b=KJhNUmxZUViGc4hxEpxnvJ+bCIMbraYPDqT5ZdyFX8Ivo5xaVBwDhkd3VIikEdwYFC
         SOyuD2HLr3EFb5SHTf5MNSN6PRC02vVvxrL4jVm8qbXUAXNFYpOif7euAHdXm6RtVcl0
         B4O6Q+S1ZkyaWB2NSdzmovVgPRI/mmjDGwb4VW2rgZPLnII0mhEm9O8JDPNY5ShZq+UT
         7b+Z3lkFcmoKLBe5C0IUN9nF9Z7wNA2tyxnyBC5nr1WuQ3h80cW8iNVMEomtAze5n4m7
         1cCq2UGEIi7nzYMYaKv1Ko/R32qArCPDEPgm6og26jUxR+FT/jXucH9OWbn97T91sM2J
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941852; x=1746546652;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IWwy2Q6p9XeoTqr1hNsCWFixc22wa18HwPhsdqWpx4=;
        b=UZZehoQFpA12KscB1oFvn9Yef7RalF36RXMHA6MiRZZT4OUkaNJJ2pOeUZIUU4PbAG
         +a+6HVrGYoU8A5BfuyXSv8QSCULy9zdQn3tAskyRnP87TVMGcUEvPfbeO/5Gd5kdxef/
         bY1v1FQ0b2y8ujypKz3lIteiCLAs24B4qtjQ3hB6jKFnwLff0bompX3W0tA2xWQu+0N3
         /bzeQ5KxvO1ZkFeNI2pJybk1Jm+ioWC9zKN/CmFVakRS+/CnoApeVGFkhS7w0y7XMBUa
         yUE3LAgLcaGpBnH/tUHqfyigoY3agjBHTUGJvwPDpfcThjztHPLFbo5im568ywqWaBvL
         CLsA==
X-Forwarded-Encrypted: i=1; AJvYcCWJa47iHXkaQSIUeT9nJD4URwVEiBF3kVC5VWwr2NVSRHFbYYuMbYzGUe71Lz4SCkplmGOQ91J5OmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVssm95lTMwzbwom1RGDY0tiqbB5C9+4KnQ2fOnNDzUep9MCA
	7/xZKf9tGIfSHhW72XPtPLLaMvGohpNtOGEJU6eBoiBHs7B5ebfzLvgpmD72euQ=
X-Gm-Gg: ASbGncuq41ZlmPSo1t/+1LgNsAemDXy3WKgUV9Z0P7Y4Q1nWjwBs9pPHHRo8aG0PKdM
	iRChP+bWk8UECYhyzqoiHlsBXLnC0Ls+T6eM48eURNZDrL/hyF4QAbxkGxe+/sWsIswnn6vtrkr
	bBCrNMrE/1OOVDmDPKDqBHWEl9saIVozCiNuzwN87xojOGvr7Ibaaru6KxXyz9zGfBpFi2ve1t6
	h9LKWCRhCs2B/svotLbWpVdAUWGL80cZX/1BYJqD3OOMB/uyDb1pYyqdFAfCdTFk4EygqgukgO+
	/7svzL4cebWSSLmQj6Iq5xSvyRRGhx7ZvgZczqZPbz3uY/J8Dg/fgDjBB3w7p971y5KJs9NHak7
	htMU3M5Y8wpXZaH79wA==
X-Google-Smtp-Source: AGHT+IF3YniFZktmx+wzc5Vvip+TGKj/p4EKeDpAQZouq1NsM4HgUhhkCMBt+xncFToPImadwaDMIA==
X-Received: by 2002:a05:6808:22a1:b0:401:e933:5dd9 with SMTP id 5614622812f47-40211578670mr1858013b6e.20.1745941852264;
        Tue, 29 Apr 2025 08:50:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4021292d759sm302218b6e.27.2025.04.29.08.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:50:51 -0700 (PDT)
Message-ID: <65cabf04-a1ef-482b-9192-d280897f2afb@baylibre.com>
Date: Tue, 29 Apr 2025 10:50:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] docs: iio: new docs for ad4052 driver
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-4-638af47e9eb3@analog.com>
 <9f5b0709-f795-44c5-aa64-aaed81a459bf@baylibre.com>
 <nrffdb34ldh24kjphvebdnc2p466xbmay4pm6pe3nen2wftycv@uyxqjovmm726>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <nrffdb34ldh24kjphvebdnc2p466xbmay4pm6pe3nen2wftycv@uyxqjovmm726>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 8:49 AM, Jorge Marques wrote:
> On Fri, Apr 25, 2025 at 04:44:20PM -0500, David Lechner wrote:
>> On 4/22/25 6:34 AM, Jorge Marques wrote:
>>> This adds a new page to document how to use the ad4052 ADC driver.
>>>

...

>>
> 
> Sorry about this submission, this file was indeed not updated between
> version.

No worries. We all make mistakes from time to time. :-)


