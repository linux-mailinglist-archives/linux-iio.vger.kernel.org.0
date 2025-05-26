Return-Path: <linux-iio+bounces-19950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95414AC4447
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47981189A8E2
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037723DEB6;
	Mon, 26 May 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvPKZC8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E33594F;
	Mon, 26 May 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290385; cv=none; b=PRImnmVgCwjs4MZmyaT98PGnuv1QwqLaocLpBhkVAOSWDlW6LyHv7UxpK0snEOiQMRsEyWajGiu3RakSyvqWffKJmnwFCXB+fDV/FfD60D4j4I4bLtuhGCbWIk4gtxEFC4KiHOLzeG4yx8hQSVRBnA7fpmAIEY5VikuU4nkaj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290385; c=relaxed/simple;
	bh=bnsE2ty017q1zNmvzRrPKR1CTQHHJV7d8zVVaWLVRxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrvV7ar+keY3hWEaSJS1MxtwaSYcVaekzLPO+6pjEBMvEk0ARH3e8+j1PqeOtd1R8k2iwLSOZWpVA1xezCek+b+z+0HZZjL3Pef4zgByJN60oOkaEyi1bTnWixifvc3s8+e7bMku66YqeGH5nbRNeq8w2bCYGHpvxDX8WahHPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvPKZC8B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so21822775e9.0;
        Mon, 26 May 2025 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748290382; x=1748895182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnsE2ty017q1zNmvzRrPKR1CTQHHJV7d8zVVaWLVRxo=;
        b=YvPKZC8B1tdGLXyJRO1p9yf+5DzOyLAYRP53ITXYuZMAveyt1Iffu+TyjjfNn2ciWM
         lj4ZHzD7BEg8j8WtV++RgKZ9oW5y6lac1FhuShhgibFKGUPsPCkJ4G/xVvMyrfjsa5wN
         TyfpwYKd0pqp/R7KGZgSwl9AHmh8NS5Sx5rGXGLLWffMK826ubh0ChcKvyaianosF9Zy
         9OyeIKZHfN0FuVXx+dk7LYJDN74xEkZq5bwBGKzOkL1vSxDWGc1Hw9O6qpeu5xrUVwi+
         Ju/hMzKqqK2Gee76igoxnn0pQXXApPHgOQrWpuOZ4V/ZzHrvNTSeyNDm4TUwDBhghVQx
         1wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748290382; x=1748895182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnsE2ty017q1zNmvzRrPKR1CTQHHJV7d8zVVaWLVRxo=;
        b=D8Z1j9RojGQBW99Yui1quCZe6dCqXZHc99pQsPWLUGWKbO2O7kcqzEWcYmzOO8+MXj
         xpiG7YJyWM1VlYYoG7giOLFL7IU5uudck/7xyVBVjs/mOFy2gcK+OcKdS+FM9YNwi/wD
         fYjX7cKrPY1QRuIlg5oXLdeX3qu9PKoUbPE/ccAZ6aPzMdOOouS97OIFZ6veYaydXm1d
         Glu8adOgT3VbyZlsCHp+aua91wV11tifH+3ZluC/xaBIWlEfBgNEUKQJ5YxLFC7yOqsY
         kRkvGJcu0QRdNF3itskOoGbMdVMqZfbF3ymRtJ1rEq8q3rjNChl9HcblAiV+EjHjGZFw
         AQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZp5YVbzQmEBaFtV9PJwscWoogOyYc40TIF8lpYB0wTVSDwKyIl48xq0undrww9nuS5VvdukygyOo33wfT@vger.kernel.org, AJvYcCWz4B7BGyDi+8WWwsYhIUzytVHiqOgEqp0eR6SGxiEkIU1EDG/LVwmKzyuGjU1+93XBSia1NSXnC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIN/sNJg9BpfQxqbKSxQdS9rUOeyCmKr4B3gl4RFd1ZVaEqMnI
	0LnY4weODuWjg5NKi20F1osP4vjHrpsKoia3T5e2I/Oa5xj2BjDNa810
X-Gm-Gg: ASbGncsluuMxhxeMhhZZoQ79lKsc7cBj8EABExi3WRSnGmdXHsOIlboCBy16WcDSAE4
	GDVodC3rO8C21NhV0Bvftb2nBaQEI5LmqZ1/+gwwCcX8Xh3GkgrM6nxTM58fI2tSvfthg1jhS3f
	kNSFpTmjvlzPLho3f1NPagTrhr0YWJavhPiHrittOQPjGtZ0t/Uf9h7YXcsEVcTHhnSUjYlmE/0
	SaECAJU4trAniS/SjnVMFnwUd0lsn00IsyWMDFfwlkBJOT5C4ML2aWvvBZ/Iu4+Wb/r+QUKFXxK
	fKHWiCV/4+0itMYZECmNtX9o0oqjgnUnwv9hO9stT+GdH0eGw3WE4+aBOHbQ7T10G/Y4k6RHfQ=
	=
X-Google-Smtp-Source: AGHT+IHRZVOvtRV5Ua48CC2FCczPsJuD9og79DxVJ6hZ7v7AwFdZsBQwSfPuQKUMK2DQgn0Nmq04mA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:d0fe:42af with SMTP id ffacd0b85a97d-3a4d0fe4f10mr6659054f8f.33.1748290381612;
        Mon, 26 May 2025 13:13:01 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78b2f19sm242080575e9.32.2025.05.26.13.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 13:13:01 -0700 (PDT)
Message-ID: <86d1b019-faec-40ab-b850-8fad22dc4321@gmail.com>
Date: Mon, 26 May 2025 22:13:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: fix suspend and resume triggering for bmi160
 and bmi270
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250525142530.71955-1-benato.denis96@gmail.com>
 <aDTHzs5AtiNmYIAF@smile.fi.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aDTHzs5AtiNmYIAF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/26/25 21:58, Andy Shevchenko wrote:
> On Sun, May 25, 2025 at 04:25:28PM +0200, Denis Benato wrote:
>> Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
>> a common usecase: fix the aforementioned bug about triggering not resuming
>> after sleep in the same way it was solved for the bmi323 device driver.
>>
>> The bmi270 patch has been tested on a device where the device irq pin
>> is connected to the CPU ensuring it doesn't cause harm to devices that
>> do not use hrtimer or other external triggers.
>>
>> Changelog from v1 [1]
>> - include linux/pm.h where needed
>> - used "Closed" to reference the solved issue for each driver
>> - merged two lines into one (on both drivers)
> I got this series twice without any (?) difference in the versions. Care to
> explain what's going on?
>
>
I am sorry: mails were not being sent to the main lkml nor the iio mailing list and so
I resent to everybody, otherwise doing "answer to all" would have created a mess
where discussions would get lost.

