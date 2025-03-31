Return-Path: <linux-iio+bounces-17472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E695CA76763
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4E1637C4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2021148F;
	Mon, 31 Mar 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WVOrmz9Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3F3234
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430086; cv=none; b=H/thuoRFLovqX0SLf7r2Zk65qzkeW5kv51c56iLfryU1/40nwBspae6H7kKgwHI4x6ucEKCqOC8/ffbR6AwzlZQa/VggwWRmY+LAg3QVkNXDe/mnEOnmLilOxlL+JMtpD/MXh3iUeP0pFN59NZyp2//qA8OMXZA+bTpnNn9e4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430086; c=relaxed/simple;
	bh=vqHtoDFk9NNCkWk0CkWjRlB9MO9zyXmuE0+kvzwpbjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKQ8Yy0MIbGl3IB/JE4DFaFlYTMvZWysVITLHEgpe7BLNg65sw3hIwzvjAbJjRoj7uDGEdYU9VUIrG9eLriU1zBwCLrdaBeZBGBod4O6xxuthHA/S03lBXlWh0z14bX/zg0RO8jiO8l6rJuP1hkmiMmGzC24LqiPhOdhDAyvDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WVOrmz9Q; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c14138668so999444a34.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743430083; x=1744034883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aJ0oyy3deiRAjr42tmkffgJixQ4EW8wDzTBzJcIcZs=;
        b=WVOrmz9QP9C6NOe/pdaHTXFcJCrsnP0D5SrRYbVUHYjm09tVRLF4ismJp+5gpdh059
         3BiIgxa3kQeM9k0dJMC0xpJfPHwY5MkWi8H1Esbp21H/EO/IENuOkF6BUWG32JDCP6+s
         fn7fkaP5bgLmdyzqVFOAVnXaCkF+BPkfndHGN3WIsrUwWsr3Z7Qv/VUk0balGvN3ozsx
         MH0BDdSX/0uWM+M6ujB3kduwigL6/lNVuOEacrHhxxcndH5m66zcuOzZF1Nsl+P1ZOpN
         SvG/ejqVmJImpyNdCEIDTOZg9NEgiaoMO/px17iAIurkdeh7eoTcQpwOAswfi8cxj30q
         8ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430083; x=1744034883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aJ0oyy3deiRAjr42tmkffgJixQ4EW8wDzTBzJcIcZs=;
        b=PCW3w9Wf231GcDIfAe6Zd1j1Gl1Jf08C3ezto7IAg9yJS0CI21/DLQy+SalsrPUQ9Y
         R+kGP/bvGbsLxZNO2hItPK9nUaE9utBUUFBwug4rwhmqt8QYYoJELLEVyzasDpPFG9O0
         +PkR/YfpvYlrjIUa3I6UR/IZjZ3U7mzEVwOchrNOtaHPqPt4NVDKS1o62c7rseYUHTVv
         cFOOJ3m8EKDGQZ4A4QaVbNFhoDDKOxd5vcpdmqqKit+aAxibtclamgROVrAasTMLw1pD
         q2HPNU74JR8mmNWADyMaZ+D/Ll/vvR3+VehtSOaYac2TK4b2QrKfJukQIsHJNy19tEXw
         qPKQ==
X-Gm-Message-State: AOJu0YzyJN2w8JpY/Tfg+P4P2ZunEEZ7M8VX4EzI3RU1v5nPnl4UQ4T+
	U2cM4Of/FeDhVogHudx743V8PunmLQL1Yuw+xQg2X1HsffDnmvZtsMELn9wgfQ0=
X-Gm-Gg: ASbGncsCGgd/ilrtE9yQArKjM/f8M8eItfdkETnYU9MYeAs6ecRu9g2XdiBbG9o7WRl
	MbykMT5JZdZWaYnEiI171Q5IQ5vdl3rgM73SInSi4mgk59/LkZFkCIhXPCSR/iF85jN0WO3cHoO
	raMLBhbQkAYeLBBS7D5ZX9Dec1M1HlKaGcA1FdhKiCB90tk28T6EYolH9U0oJtaWCKWPRwf2zHX
	B+Wg5PxV1AmocBt72S/qfb9JmggFAyATRS8nMxEPgCggct+gc+hq2SX6DfEg+I4WRjfCDGOPeKr
	IreSuwOVsqeaqurOOzTFcsX1d7GDuCaHjUy7POyuvcGK5kPHjfp+jJPSnbDg7D6ZS6XXLeakida
	OJxWM7w==
X-Google-Smtp-Source: AGHT+IF2AF+U9Slk8GjBjMyi2XF0X17I1bL9WNJWZ6a/VpLIemirrNp3PzZOsL5uHrEeyl+9e2sQgQ==
X-Received: by 2002:a05:6830:730c:b0:72a:1ecc:d23a with SMTP id 46e09a7af769-72c637b09f9mr6425733a34.15.1743430082947;
        Mon, 31 Mar 2025 07:08:02 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a40336fsm1847493fac.3.2025.03.31.07.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 07:08:01 -0700 (PDT)
Message-ID: <8acae4c6-2a48-42d4-b74d-3f9d52857384@baylibre.com>
Date: Mon, 31 Mar 2025 09:07:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/37] iio: Adjust internals of handling of direct mode
 claiming to suit new API.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>,
 Jyoti Bhayana <jbhayana@google.com>,
 Nishant Malpani <nish.malpani25@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Shen Jianping <Jianping.Shen@de.bosch.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Yasin Lee
 <yasin.lee.x@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-38-jic23@kernel.org>
 <CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 8:41 AM, Andy Shevchenko wrote:


> That said, perhaps also get rid of static inliners and have
> them to be real functions?
> 

That requires fixing sparse first. It doesn't currently support __cond_acquires().
So we are suck with static inline until then.

longer explanation: https://lore.kernel.org/linux-iio/20250209180624.701140-1-jic23@kernel.org/

