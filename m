Return-Path: <linux-iio+bounces-24344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C840B8F2EE
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282031897100
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5B27467D;
	Mon, 22 Sep 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwXkXpwN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E534BA39
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523348; cv=none; b=Uj+2sjyt1sjAVI/VqQ+JEfPvhGm5t34ZB4whsQ8zqGUcI6bod3F+LAXl2waqAP27ZdvnJ+uWqk1yYzmuLV2kPwbLOpxxzLUcqyLGYNoQ7BnSzvulB0za1YAYTIkIDoZ9sYrmfdogtFXAvFnvMwXL0dGPfjE7VhIgRtwKbY/INPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523348; c=relaxed/simple;
	bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1cD7i9H0EFIcJyG6SMrOaW/0z7UtWfd4gWoHJ9sw+ktDry9qCB78W1d3pH60gREr6pXNnxrbWzjQVi5L53p4NwaAj3HWAWAZJc6NIv7ZIrqt5Siagv4T78O/FdeZ8QgUdHkzMLuuX4mFhhVwgvGlSszJLQ3PYjulh0FJoPIyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwXkXpwN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso4743605e87.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758523345; x=1759128145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
        b=YwXkXpwNn1ceFOJHZpTsWgjOoTAtJCa7vELI67bKKPh1dfctGU2P+lo1v5BSwkvvQ0
         p0/b2BQAGiq5863CQqYrNzPracE14jsi3Dn5KsMZJ/Ww5os93XxyFXG3oiS6Fa5pLyWG
         1FMZyOBY2osQhJlIKRZ7BIs9S5OzJbU9RF55AQl+i1BQfcsFSeKh/W0ev39LEUHd4lxx
         3CM23hCZuMxP9EeW82Fp7ad0HCxJUJ6rgohmjVDt0JCkJbNyCrqieVMI66brWTfCurqJ
         /YC+/rqjo4wh0zLfgnzOtaJ2XIC0pnN+O/pvz+/4XQKKkSRniqsXPE/2VhZCuvQqft6t
         T52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523345; x=1759128145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6smKOVXzK4TtOACukffUuOtD2ISMvekgmozYkJoZ6Fo=;
        b=C0lqE+Jf0lUMo46j8SWHyZniIZTWoQgiAUdD9592VB01k2jgdq88KVn6gVdxYATgVn
         38NxSf9vXQIdNoFVAijzEVFBxPj+aQ4JpTBLFe/9iGfd+VEORLCyCdcKVnmvxevHP0uh
         HBwRY1IAwih5Sa2qVOw+f1m9Dx4ZoqDPD9+muUKEFX6UHA5hwgFtHXPwm0a6QgbDrGh3
         QY95++aYtp4JtWN509Bc2f5l6NJd12xXmmpAjzSNO/MBLWtQqE7vWfLhIfuPQBOcrHlJ
         P2eAFOq7C2GKYDnIeT7+MoRZ0QVYvhRaCjlH01u5bpzLqHx/BxWg7t/HFmF79XxVZnnv
         Ipsg==
X-Forwarded-Encrypted: i=1; AJvYcCUsN9JwpYV2J9uaBzMd783UC/HCQNILIW9NDP4V7+WXI3FRGwklADD79km8BmBydcwcjGT7M59TXmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZEtOqpRNdwzduNkQ4wvGz3DFDC9Q/fazBhcCdtoO8pNInohX
	a+5CzAzT6YEtykgFzK9XKsI+lqbMHribQ5ydFEZHKrxvhszM//kva8Lj2VZxSnx4MSGGzOD204m
	F8PIhdqzo6AFElmrQAPqJq5dYWI2HIHE=
X-Gm-Gg: ASbGncsuq/rLnDm0NE76HAaN5pJyqkU6Ikq13XsvBe8qzh5wpfS/kk1MM73kp6tzeqh
	3yrNQZSfRW/65ywE5VuI4X9Vg4iFXwnNNJaw7XMU3Pfu6+cat6uZ8l4HTbiOl0XjAwvonrctRZr
	saaDnjYLs+GCBLseuWheqNaMxHXYRfjXfR6Z8XUnE8fbRTMQRqqznGlH3ahT5D7sb0rripwNy0p
	pNeCrU=
X-Google-Smtp-Source: AGHT+IEJyATaRYNVQDMBkUluGRl8pdeW9VZthXRdIxDEQPmbKIq9RynzjSszeFrN/Ll/mI4kF3FXXvHfX91orqRNP5c=
X-Received: by 2002:a05:651c:3051:b0:361:3594:2b2c with SMTP id
 38308e7fff4ca-3641a214c62mr26907771fa.21.1758523344902; Sun, 21 Sep 2025
 23:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
 <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
 <CAE3SzaReUnhWyzA8RtdizKeRU2zMsGbvQaVT-ug6v+=Pqq8WzA@mail.gmail.com>
 <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com> <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
In-Reply-To: <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 22 Sep 2025 12:12:12 +0530
X-Gm-Features: AS18NWD8uuPsW3QaVzQg7NLjgx1tJM9VxuNg69Ahm84sisgdKeXzjoT24F_cl-U
Message-ID: <CAE3SzaTgA5noCL8E-9ELHpwV0gY_Fs2XKm6t5WqKrGxEXE9PPA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, dan@dlrobertson.com, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 22, 2025 at 5:59=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> >
> > Hello Reviewers,
> > Is there any feedback?
>
> No top-postings!
> No HTML!
>
> Please.
Apologies Andy, I was travelling, hence replied from my mobile.
Was not aware that plain text mode will not be obeyed.
Will make sure it does not get repeated next time.

Thanks,
Akshay.

