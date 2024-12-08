Return-Path: <linux-iio+bounces-13215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459B9E8553
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443B51644AF
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A314A09E;
	Sun,  8 Dec 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjk6W/uY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6280BFF;
	Sun,  8 Dec 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733663178; cv=none; b=Le7YjfjEMmbYj9k5ru+3Kjn2W4OxAeOwYrHL34Mfo2eqj8NU7+1Wm27k0Nq/bkQJHSg5pgWWaCYA3hONe9w81VXhyjNNQJNx8nePkeDjlsvZYGEDrJ95xjGrp1lSImSY/vW110cgQLb1EhkvOubopnSRoAn/mNTr+T4lWWjQ1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733663178; c=relaxed/simple;
	bh=/ETGJbe51uKA0BVMYVW1Rt+Cfj22/5/aNGMHljJVFaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaE5zbTAiJ/lNldc1qi+GUZu6Ymi/gUL8KbYXeCc3oqQ1Sst1TlRMQgHC3Kz5jH2G8kW/4gLhpHxQmFOl8l66RdhDAJEAW8NSLCqqkFEBAfJ5QtGHAQmmiBIDk4SIkCubOBHW1EGuwXZkCeXiQnkYVi4p3SWvhTe+LchnE9jRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjk6W/uY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa642e45241so381387866b.1;
        Sun, 08 Dec 2024 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733663175; x=1734267975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qwpm+1nZ/cuBK2l3ECYyJsE/xY49jJZUDT4CSwyaVc=;
        b=Yjk6W/uYpXCbMb3WOJ9hEgX/N/pDrw1J9623I5KZ61r7ZqL0yl91FfiYCqHtZUiCY3
         QJROT8M0E9DLSz1cMgzXm7R20L/tPZjyWjj1PadgKBicxKKQF9TylQRK9iN8Z6EtoHLQ
         oeZEIlhreF9O7G+J48oF4kiR6O+cAn16HaXhWOoRUFrp50RbGRU93ZstIinAbk5x84rN
         CJZMZZdG4pGKQ85bWtv+E8jS6QPOgtnHhNe3BPGK/+0yWJZUm1Ql3D4QNzJ04fRXLDWa
         mEEGwbV/lMqn1NfntN2gl3sGMeBKZNyqTMKqXmoNKf0eA66WnrvkdQ3Ny+g8FDMK3MMR
         +FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733663175; x=1734267975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qwpm+1nZ/cuBK2l3ECYyJsE/xY49jJZUDT4CSwyaVc=;
        b=TVsGvh+CweFhcQWWRZzg15FmRT6qodFUelhORsFqe5/6jA5R+W6yJG/hnWznAncAAy
         TbapIQSFq4sV9xVTTHNLfs2OSanSSu+nd/SQHOxVx+NFrlUA6va1R+9cpwM7m/f6r0a4
         7KUcSVmn/NUz4bbL3lkZBeUabWoVwrAIPdYc7PovFpRgFsdJJX+rQgGyYNdA2/ij9Qqf
         lIKFTgcnXkPSen13ncdv8WR11qJzdtHwRHja45wUULN0I0wUxc4JX5B6ylNKbEHh11dB
         o+4oBchEn95FAJ6u0nvrUPgVo4JaAHX6qbA4GH8LGDeSggJ7ty37tweMB62Qal1MnAt9
         jWTA==
X-Forwarded-Encrypted: i=1; AJvYcCVc5MOp40AAGmYeo1fkuDzYMhuZLMhoNYzZY/eUVBZkIo+dgU6LWa9LD06x8AQGE8qY895lJCdPcOeW@vger.kernel.org, AJvYcCX02dBA98o3gTt9J9fsfvQmUSJMRspc74mwk2N/cmu/m3rCDsTebGW29J/MDcICkQ3HaiydwJX/sex6@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYN/eS03CvXx3ZxTjQ/wlXltr5SKo1gnOG2o+zRmox8wRiv9P
	AOk3gGMQU6p2KdaymbG8fDD9Tg2k/Z3nm1mFxjTJIOclZMcLrX+kHLCJs0U+BMmxyBVKmD+UHDS
	u+CBccX7Yx8kUyMEyfuqRkYw3Wf0=
X-Gm-Gg: ASbGncurlEokfQkrOx7bC5bOAhxA+NUgECyTuw4HoZ3cDyl/dBGSJaT+ynm0dXJoY0c
	9PtGKFc6A654cElYzRW9VZWJETNq9qRY=
X-Google-Smtp-Source: AGHT+IENjIyu66J7c5rQnh3UQQCNVvqitV6wwL75q2E6Nmt4Rugd/P7OR/whMqBm5HW/xgfsbK90D87PXHKHDb/W+MU=
X-Received: by 2002:a17:906:cc1:b0:aa6:6e10:61f1 with SMTP id
 a640c23a62f3a-aa66e1062demr309799866b.1.1733663175160; Sun, 08 Dec 2024
 05:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124205.5b297fa4@jic23-huawei>
In-Reply-To: <20241208124205.5b297fa4@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Dec 2024 15:05:38 +0200
Message-ID: <CAHp75Vei1g6iL0qWV2Y7+L4M+kJyLfUDoWd0HiXRbAWqQSR0qQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Fri,  6 Dec 2024 18:28:38 +0100
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

...

> From sparse.
>
> drivers/iio/adc/ad_sigma_delta.c:205:13: warning: context imbalance in 'a=
d_sd_disable_irq' - wrong count at exit
> drivers/iio/adc/ad_sigma_delta.c:218:13: warning: context imbalance in 'a=
d_sd_enable_irq' - wrong count at exit
>
> I saw your discussion with Linus on this...
>
> https://lore.kernel.org/all/CAHk-=3DwiVDZejo_1BhOaR33qb=3Dpny7sWnYtP4JUbR=
TXkXCkW6jA@mail.gmail.com/
>
> So I guess we just treat that as a false positive and move on.

I'm wondering if sparse annotation __acquire and __release may help here...

--=20
With Best Regards,
Andy Shevchenko

