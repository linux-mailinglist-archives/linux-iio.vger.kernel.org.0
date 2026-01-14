Return-Path: <linux-iio+bounces-27808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDADD21913
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E685E3024112
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 22:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0ED2D4B68;
	Wed, 14 Jan 2026 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rzQ9DGe1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24D3B52E9
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429812; cv=none; b=pSiS1dHHNMeAXvRbzL56I9LJINIoZJ/TjUeq+Et5W52M8QsJcYdgZe4jekCMzUwurttLFWTM5lndQ+onKBG2UQmR9zscIJkhi+FwD5/p4imIKfdV/0mEwVsV/qVlh2aPYdyjlFcEdNtRl7OOOaZRXRSc8X9K/cEK8lL7hjXcUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429812; c=relaxed/simple;
	bh=PXVggypcbBwJihCtpCrmBLopaA1RXwINv+2Iwfde8Lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kz3j7rsWiV9vtKCX4VtlWywJDZm90HvcjCEMYU4NYH41EryHvKSKgoPicgssiipRboDOhwqAS9yjjs7RfTfWwZ3rhXujNLTpPdR9tEkKET7mafh58yFFRJZH9On7XXSjMTRaYJTMW5PAZl+H5bYu1XpDS0QDRaYHRpnm++rmsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rzQ9DGe1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f223c70d8so229014b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768429805; x=1769034605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymy5giR6WrVAtVFXMff8n5QnBmgyVv03sjiXQEbjz38=;
        b=rzQ9DGe1vQYjvJmJI6BuZ7gB0/d8ncL1Nq0OTaqvyRvHoGfemAwaUORwMWkPJLdClU
         srNXLcCX0jEwyWFvPlEmc12LFh0Wy72lVDoL+Myg/s0aq6WCpUzto5zf1wXAwyjI+Jmq
         M/110jGt04M36BNknYY7K1Bp5EkYEhkF1ZoVyTtpRYPYwDnrYZB8uK+4S2Uti9Wy0Xtz
         AaMtIIXJhtXYWC8kK1mY46bK+2IK839vGUIFj56ix2lVjKQZCeU9aKxKktV+I6cuJ54V
         R6c1lI6ZnEgLpdQtXWa1VkRQIF1fTAbhwTxg9I5bHZxR43v8d8zmVddxJBnXbB9vsRlo
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429805; x=1769034605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymy5giR6WrVAtVFXMff8n5QnBmgyVv03sjiXQEbjz38=;
        b=u+WjQH4MXKhlOZ53D/f96We31rvmFjqK40Pexnvsq96h5HDvTUrVGIjmT05jxkr+rF
         sJdq8+oUb6duT4pwg+60yMXhshYNp5kYx71FoxCb77mgqJpCgUcy8CG5JWcO2K8BNF60
         sk5Lw/AM1/Ek5mE5uiHKTT7kb9NgnION14ITgiTnqbl3IWSCurc/SabSH3kEtA8FxOoz
         7Kdia4er1KAY1XpdWCd54S3csi+KqLhXv4mEafhIqqDVFKZA/yQLYFDR2b4f5AMsh79t
         WUQ82ePPdyGp8pe+7Mgm/O0H6i9jjaLjryXMQt2iNkKi/GPd+KYa/i+4wt2w+/DVrA7d
         lBkw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5zeTOTnowMfEpetRb1nVX3moKI6h8H5Vbn9OpIN2zpzVXylImQeOD3UKPRykQMgl7Vp4HXp+gus=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmNq+DYolifSNoXXc5zSNP6LRpWQMwxDUheT7bWYCDLfHPot0
	Nd4MLlgJ4d9ltVWYOFQ+JamBwVaWx0ANm2ouGW+X+Rgp16U0vqBWgHHNrdD0M1UKLpk=
X-Gm-Gg: AY/fxX49LXjPv2J1bnXAjCbfqGnBZ2xU4IT01x3KyUTQINiYKgwXhUj0rJpHQq4VMm1
	JnuQytsKD/aOmXUv9r5CVpM/brOAqOj/e3Qqz7nARVkzRrX66v9lTEraid7s5Y4wACkV9pNtJ9Z
	D0flHTRPzgDvpya8fOIApwtP8hXXXdKpUijYFGmOcEihE+AOyUiMs0gA7Ibr4U7Pv7p6T6sPfaH
	hYkAfr//gqpg+6aVir1E1etvD7vYhuibPs9urZVRW1EH1C4TvpSswx0zEtG5iBd5txt6yV5yw66
	w6JklwSs1FrxeOCNY8Ly7WM5JUI0rbVJgW+glMELbSNvS9ABU2+LqdcFrltmwWJXmoHUaU+PkMh
	VLIDvLCApLdF26TNcRuEc7v1ifu6Z8D6Vr1pFEONY+kwjAyQw64cU+MaV2PSbol8/WbqhmTMTV4
	wa6NBJiRoF
X-Received: by 2002:a05:6a00:4145:b0:81f:3d13:e069 with SMTP id d2e1a72fcca58-81f81cdee8amr3317222b3a.8.1768429804947;
        Wed, 14 Jan 2026 14:30:04 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e64c33dsm515228b3a.44.2026.01.14.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:30:02 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>, Jonathan Cameron <jic23@kernel.org>
Cc: akemnade@kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
In-Reply-To: <20260112094259.4648cfaa@kemnade.info>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
 <20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
 <20260111123200.6871a41b@jic23-huawei>
 <20260112094259.4648cfaa@kemnade.info>
Date: Wed, 14 Jan 2026 14:30:02 -0800
Message-ID: <7ha4yfzv2t.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> On Sun, 11 Jan 2026 12:32:00 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Wed, 31 Dec 2025 22:14:17 +0100
>> akemnade@kernel.org wrote:
>> 
>> > From: Andreas Kemnade <andreas@kemnade.info>
>> > 
>> > Define interrupts properly. Unfortunately, this hides a bug in the linux
>> > driver, so it needs to be used with the driver fixed only.
>> > 
>> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
>> 
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Not related to patch 1 so if TI soc folk can pick this up that would be
>> great.
>> 
> well, it needs things fixed via patch 1 to avoid creating havoc...
> But from a strictly dogmatic point of view the devicetree describes the
> hardware, so it is unrelated.
> ... but from a more pragmatic point of view, I do not want to have interrupts
> enabled for drivers which do not handle them correctly.
>
> Of course this should be picked up by omap folks.

Based on the changelog comments, I will pick up the DT patch when the
driver fix gets applied.

Kevin

