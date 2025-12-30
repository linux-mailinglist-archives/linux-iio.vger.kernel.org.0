Return-Path: <linux-iio+bounces-27417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8BCE876C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 02:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7070C300FE0F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 01:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3272DE6FB;
	Tue, 30 Dec 2025 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNF9eypX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA272D979F
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767056894; cv=none; b=uMU6BYmPHtgkGUn8nYfEzvoHiwSAQgcD69hpDrYrsdmwH9c8wQPoni52BklGX/HHRicJ8fzrzvxFrq6u4fF33nJtz+QmKl6Pwkjq/UDAiodS1H9f3rD1RrrbXNUVJ8yEmAag0wCsGXcfPY/kTImdXsGUWGCQtUaTE/a8wywNhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767056894; c=relaxed/simple;
	bh=bBs7yx3IH7rbuqikyv1k1RP3GLoN2h+HudwG/7Ey+ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFxO8iD/2K2APdNAhaHjoGv5c0eFYlKQmK7g+h2cLyOPhKXQ4JpE7xIa2pLHqTV3GsW0rM+or/mqpOTIYIrlRxZ32Qe+Y76ivMH/UuvFi6PWniCW1ND2//myaYZa3HKUs0VlfeVc9wZomFw6qDT/IiBJ/7TewnNEG0uDLmc9mTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNF9eypX; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b2a09ff61so1952311e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 17:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767056891; x=1767661691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBs7yx3IH7rbuqikyv1k1RP3GLoN2h+HudwG/7Ey+ww=;
        b=HNF9eypX8uiXiNapTCyfTfaiQxjxcfeVk15X27Wcmh4f2tqd9du+DuTSEplaGVKvtS
         A8g5MadgeZUPmQhB5XT95GFh6t3ycVks+TKHmB1G6ZMUxLhd53a9WIfQdZ53v3SNXg+u
         0QvmU3Bb3YL4xScJKMEUTtCv3/TI7BbGShFDMFAE9NV8I6TzOkaFGuuOQZPHdriy+5G3
         sKtyxbprp48MgUC+NnLND2xQPNyBagzsJoiM4OwQWBe5MaL00JfRh3tVzqxtgJllVliQ
         r8auur82R4Errk5Qbk69QLtNdY99078rqO9d8vHMYke5Uj9qDRwsfpwGYXzOloLyiUAK
         Afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767056891; x=1767661691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBs7yx3IH7rbuqikyv1k1RP3GLoN2h+HudwG/7Ey+ww=;
        b=Pxeb4et1hLHYbvJnXu669eSKUEvvkTpqyXev1u50NBwUt/D6VAK+GoUMmiFpCXIiAP
         0Ld8YD94GPVH/GnmMEs98Fr/95tU//qQEz0FHxerH8auGo9XF8eU6FbrsOKdhZgLKLYR
         C7S/szdyhSL4e+5VXh1Xs+AIghWRoTiZw/zwTFxC+JbS72SmsQRHKM8da746d/x5EX0F
         85tVvfw7U6OZnOV+SEbAwHb3IkRwzf87XvPHHEx91DqRkDlIBqPEY0ldZvdPTbrDN2m1
         dueXH4HP12os+j/Nov8skDfeI3SREbtRS4d2xeG0ub9z5+YsNlq+Wb0f33mzBpb9BqsY
         l1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZUUl9AEk0s1iIWGHpJggst8C9X3Wrc5d8q+SrdMKWVFcYoL04uPKfBIZEzX54R/94ybGtMZ5/UMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TYErpQ6llt3lOO7Fs+yLJcvxqi6ymK1f7Av5Sx3Pv2CZFise
	Zh5jZ4PhNUojz36RbZvrDk2gBY9Ygj8eq4Ldj/XpfKBOcneSSWXGPzZiDR0+1gFsLh8oJWeSfX6
	VBqiUG7wjRt4LIwIZ634/7vl1WrOygxg=
X-Gm-Gg: AY/fxX4y7fd1W85wUIb0WR48gbXLrUbdDiBRyP+vhfoGp8rUm4Waxd3UUX9G3knRS1W
	Pll6NOg+LbqGDeYtgvioTG2/h/g3zCvkZ7JL4vBxG2tVqCjd18ho/YyKFzqHEfVJAieb82i22nx
	7VCLdbin24M0fa26X8v0V4jvQN0Qc4oN4+VQa6f18No0URdO0XZvJ7zyFZ8MzFkLXhm39CgUkwG
	cOSEROA9wjPjHq1q1R0fdh3+YZQvhPOAq0y4jJ/JtnW072QO8QZgbAbRZ/zDChd9sTNkDvJ
X-Google-Smtp-Source: AGHT+IGYUCsj/IeFOwgAJyIiSuMBzRqRcmwFTxIdFlvnR9gSlQDZO+6tIch77v8HRL+X5/RRjI0Gp2Vg77Vtmx6PsGc=
X-Received: by 2002:a05:6122:f8c:b0:55b:1aa5:bf88 with SMTP id
 71dfb90a1353d-5615bdc7190mr8170374e0c.7.1767056891522; Mon, 29 Dec 2025
 17:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
 <20251224-add_ltc2305_driver-v2-1-061f78cf45a3@gmail.com> <20251227-chubby-tomato-finch-24fecf@quoll>
In-Reply-To: <20251227-chubby-tomato-finch-24fecf@quoll>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 30 Dec 2025 09:08:00 +0800
X-Gm-Features: AQt7F2rQtCn7wayoIhL7v4gwnPV5xG6DW46TC8ISdPNsUTfILJSJB9dEqyZqW2M
Message-ID: <CAF7HswPViQh5qaHKtRQ+133jKa60Xh9+i8YTcdhfc9RohTOgYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 8:39=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Dec 24, 2025 at 01:37:14PM +0800, Kyle Hsieh wrote:
> > Add documentation for the 2-channel LTC2305 ADC in the
> > existing ltc2497 binding.
> > This enables automatic device tree matching for LTC2305
> > while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
>
> Not relevant sentence. And if I disable automatic matching in the
> kernel, does that invalidate binding? What about BSD?
>
> > since both ADCs share the same I2C interface and 12-bit SAR architectur=
e.
> > The main difference is the number of channels (LTC2305: 2, LTC2309: 8).
>
> These two are fine. Just describe the hardware.
Thanks for the review.

I will remove the sentence about device tree matching and driver usage,
and keep the binding documentation focused on hardware description only.

Best regards,
Kyle Hsieh
>
> Best regards,
> Krzysztof
>

