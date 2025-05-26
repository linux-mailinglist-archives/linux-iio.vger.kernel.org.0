Return-Path: <linux-iio+bounces-19958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BEAC458D
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 01:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081253B8E61
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 23:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8221F866B;
	Mon, 26 May 2025 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0BSZ9x9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D32198E91;
	Mon, 26 May 2025 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748302646; cv=none; b=nYxXCdDAWw0UNykKyEaS3KATWlsgrKzVtfNF3pjSKGq64RUgKtbGRmhQJNOy5FScANtazKKN4FKcA8yGNBSBE059F4NVqvy7DJAQVic+0WrkJTQQQg4ALdZt8eLZz7xJAPa/kpT5K6T6CyO6bwtUV/OdAKFKdm3QnLFQTmS7u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748302646; c=relaxed/simple;
	bh=Io1s0ucwQzNq4LIHtzo99IEww7I3qEbMJYor71jOtuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y68wSfMSnj9prO5CqCWeD5FcyUmMC+6rCf6bsWqdcIB8hFF01V0taN0PazvcyDSvojp10OwPJGU6PE2p4KqRJIsQxh7DkPZykiSxz8TOVEkcNDe2PeNDEnzc42sXy9ZWALAFpnJXMo8/KYkEt4ComR2xplnolaRazCTMXl0ZsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0BSZ9x9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so18549915e9.0;
        Mon, 26 May 2025 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748302643; x=1748907443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io1s0ucwQzNq4LIHtzo99IEww7I3qEbMJYor71jOtuM=;
        b=b0BSZ9x9l46n1aTDtbUYtwgTcIoAOJEkk87FNJ7dwkX8wPFdVTBxKdXsgzi8oTzEiz
         0KHnRb476XKZ7coiFA9hAaT2Sw2xLYgaGgRj/rSFI5hjwRKPI86lzz4dbZz1MEia0tGQ
         xKG+3i53E2NJh7xWoghYICiCwQ09kQ7ZvPirRV2jQKA9DslXNTLVpK+YRpNH4SqrlmFO
         AqqIuXUu0wm23PRgVMxo3YWp14yrLHNRC0G0CRN6S12EVQsXpyh8WPQVsPAm6xP5Es6q
         xUGCAlwVWUzIH+iiD/T+Yn7N9nAuBPcCu/v2Xzl21yNXxJMA+ddr2RZDeMEW7jbQ+KP4
         ogGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748302643; x=1748907443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io1s0ucwQzNq4LIHtzo99IEww7I3qEbMJYor71jOtuM=;
        b=sKlrNmbrK5JFVx+84N6VDpGxDUD0+hfs1q7Puog+lqX4bTkXtF7C1opnyEwn3B12E1
         1l9WW1Gp5enW/kEytguySteZ1MdXPuOVFvEW0+M9UME/CPikPTYEJvNGkcx5U1cEcK3h
         3EKVIxQoBMm4vcdPabISQwqmz8eMM9dZliJzf6uMSe+VIirCmyufA2SJoSCYjJRbcHgp
         jHrY7b12xwUtdl1aW9i6fjQCusIut6ViXGl3T0OG5YJctvzNJ6iL5nELsxYtwBuEE6A9
         4yftQ7UA7uqfXYrWz5f9+sUzJnlNL29HqbPIE8kxEfR26c4sG6Z+Lwp9S1StXe3uJGSR
         PLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVWf3Kz0IjL5UIkEZcdP11haBPWLX0Ag5pyipx7w8z+UqbiJxTHrxKP+XrxsZIX8QD8c3fquIOEEI=@vger.kernel.org, AJvYcCW27LU6r9hXXVyC8Z0IcIQMf/UxKgGtDHrnbDwwPgyFf7J3nE4qEM4SbAVfxdTrlnA3UjwCEl9h3kb10eZz@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvI8Phq6GADJhZDZyDJQpN7LJddy5lpQt3Px3wLfCXqV/Ltc8
	51s1297JfS3NqPu1do3VcX79e+JkbcT75V1AbXc14hpqKmNvApeF+KgS
X-Gm-Gg: ASbGnctCuxQ20zrsSHdcfx+vEqOhaXhovXxIKCiTyFG9otWMpYlgGwhOqnbodocX+sI
	vbgZoXRseBnl5DAD5PMOJ7wTfzZnByU4b4HJwaVa+0CO/mbg4iPw400cyywIhKIaxKALi+nHGGw
	oy/fGvov8M1r2905OLp3h3dRA+8d9CPgLW9ALyEXrMfKDY6B23GKSEu5j3y4f3jt0SISOVDhzc1
	JgLZpZCDlACuodb2RLrBz2eItFVa8bnrFky7z442F4jN86cy8e26hCqwed3HdPMPygBzyB/hS5r
	J5tRaXz+XmxSyh9+cA9QoO4CLY77Ndu6XYYmv5Wkqu/yvTgulVtXrNgGYW2bDQA=
X-Google-Smtp-Source: AGHT+IEeW10VyZ+dmhwNbjqDFFTTiEqy50O9g1oMePmSq7t+DvTZrAFmo26tTi90MSvFkL28S0mWEw==
X-Received: by 2002:a05:600c:4f46:b0:442:7c40:fda4 with SMTP id 5b1f17b1804b1-44b516966damr119157985e9.1.1748302643043;
        Mon, 26 May 2025 16:37:23 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef035csm245570305e9.11.2025.05.26.16.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 16:37:21 -0700 (PDT)
Message-ID: <b552663f-b3f3-44b0-8042-533d249dcabe@gmail.com>
Date: Tue, 27 May 2025 01:37:21 +0200
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
 <86d1b019-faec-40ab-b850-8fad22dc4321@gmail.com>
 <aDTMseDPCGoTRJR_@smile.fi.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aDTMseDPCGoTRJR_@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/26/25 22:18, Andy Shevchenko wrote:
> On Mon, May 26, 2025 at 10:13:00PM +0200, Denis Benato wrote:
>> On 5/26/25 21:58, Andy Shevchenko wrote:
>>> On Sun, May 25, 2025 at 04:25:28PM +0200, Denis Benato wrote:
>>>> Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
>>>> a common usecase: fix the aforementioned bug about triggering not resuming
>>>> after sleep in the same way it was solved for the bmi323 device driver.
>>>>
>>>> The bmi270 patch has been tested on a device where the device irq pin
>>>> is connected to the CPU ensuring it doesn't cause harm to devices that
>>>> do not use hrtimer or other external triggers.
>>>>
>>>> Changelog from v1 [1]
>>>> - include linux/pm.h where needed
>>>> - used "Closed" to reference the solved issue for each driver
>>>> - merged two lines into one (on both drivers)
>>> I got this series twice without any (?) difference in the versions. Care to
>>> explain what's going on?
>>>
>> I am sorry: mails were not being sent to the main lkml nor the iio mailing list and so
>> I resent to everybody, otherwise doing "answer to all" would have created a mess
>> where discussions would get lost.
> Always mention this kind of things in a cover letter when resending and
> ideally add a word 'resend' to the Subject.
>
Thank you. I wasn't sure if using RESEND was a good idea because I have only read about it being mentioned in
the context of the original being lost and was thinking about the mailing list receiving a RESEND without the original one.
I will keep this in mind for the future, hoping I won't do this silly mistake again.

Thanks for you patience.

