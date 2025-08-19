Return-Path: <linux-iio+bounces-22968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D3B2BE1B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD65E174B39
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64625F79A;
	Tue, 19 Aug 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJxA5X2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074131B13C;
	Tue, 19 Aug 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597167; cv=none; b=OntooY8XP9uUF9qomVw/OOnH/CA3NGaSz0A5j4HaEy1BBJj4myMVT0LOM4R7FAw7cGVGw7UArus7+KZoo0WfYvbZZPEUTJgt3mzQzqNMBofz+kQkIklhm0m6wZWhhYOvPoTJSwW9VwZ1x1K+hapSt5M6Ld7MYkjuwhP3ukN2lF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597167; c=relaxed/simple;
	bh=vZ1zY2qA81zr9nn75hZsEMSdPfEfIVgmSSmTDTVWPdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur819q/ISJx/RXyVM4JM5i1u5D/dcZ/6V/I7EtpLSEcHXzUX7JFlXiO657Gzn4VRVhsnV9xLUdg996+/CtUJwL6wugewl5k5gPlmGB+PHqdDzCm8OpZMC9xUniO5TdALQ7GVSHo7YKSIjJB9yBGsh7PCyfhalr5yitlV50VAvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJxA5X2l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afca41c7d7fso1032502766b.1;
        Tue, 19 Aug 2025 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755597164; x=1756201964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3K1IDPKxKe2xeCpyU2LpG3OGpnhs5ozT1w869Ar1JY=;
        b=NJxA5X2lptzz04E3a07lLYQmI/qjBYghHVbao3szSne3QJTq95OFlSZNlWHsW2PzFY
         nSYnQYIJwVRx8uVRb6sdYPMXeLMib6raaS6tUcjLJ6uYntzgLheG7nqHWevnN25K5u/F
         kJ+ZTLS5qHlZrHCwXI7GvJolnZ95KSdb7w3YC3cFpTXqIAC7U9Y4mTMLzskYFoklgyGN
         V5WwkSwU7ZtvVOg6fNTWzmeTyioyjmkWx13ahbGBVxPCOUt9XHeD/peyoP1w6T2xjBiP
         TcxAICowZc2OuTRuCByV6wCcwlT9uWZrZuaFc/jJFXQrBR4b6cZAcZtAYXptPP+E97ns
         2WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597164; x=1756201964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3K1IDPKxKe2xeCpyU2LpG3OGpnhs5ozT1w869Ar1JY=;
        b=RXr3PfmkBu+qhwV7E0LvwVrqGu8V9x0xxYIKq/DSM7QYFdtpIi3fEcPAxcY7Z5arMU
         tHrf6wGh86nhT0BfaSUS3697DyI3Y8Pt1zAU8K20E37mGfHuvaUmHAy/uv4LbOdtkZOm
         GkPWnI5XKx0k556kdjArSWDyvlcVVI9/8Tua4kApvjEHPoK3+XWHAhYyVEatZdUK6CTa
         pka6cUqInD+rXw+l7yQbS0bw1pkR0kMJjoZDoV/BTay3n5z3zbfHjPYg73Z4nN/ESL1h
         bNsbMmavt1dkOBSQY0VSvAFxq/aLkV/G4gIlKuQNk0eAPj76LyTyNDHgrCsvPVc/LkW9
         Wkig==
X-Forwarded-Encrypted: i=1; AJvYcCUH0ipLnbBOiY3WKfSEJfiEyF91KZebnzLMBqKW6dVZSSG0k5VX+rJzKWmIeFp+tKBCrvhVj1WUfvD2pvtn@vger.kernel.org, AJvYcCVN5enL20RZHBM6AH12g+yUlyAvTmfAhbuBR8PxyIpD7LJWuzp33ZvwFEDbOm4LO16/MXH11N2yH1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQzEWp8fEdaPR6mlNLJ5YpMZbZR+O7m8iBUkXe3MIypP869h2
	fLhI923orU9ygNeqbKoKYkpqRYxD3sTIbZxUDIFnPhAXiyGr7iqPvf7wdkAYCcT5DfX3tzdTDle
	YhAvICOnC2v1nv73rEzpPjmF/k9mRVxb5hcki
X-Gm-Gg: ASbGnctMearF8rWptIcuI5h4YTNXk057WlXQr/ZolbxS52JX49OKxr8eGkDo2n4jCaY
	j3YfuVQYc2LBQBJ/qccmER1iH2DxotzwGPXc1oTyAJ/2zcvop8ROlM2kcFI1dXIYf5KpCX6q1NL
	izaEoj3q62Zz0iiYa5b24Aef+86jWfeUklqpKEXEkl0Ov7HyFt4Fc9m5dHeL7LKHjXB8nK3zP2/
	5BKYUU=
X-Google-Smtp-Source: AGHT+IH3WJeZraAZX1NgTdDjtjn0lbmiRjo9bY3m1dYqj3wxvPh2o66ZHansoDFw3uoIfYV12gjfvglOWrH2Y6GKLXs=
X-Received: by 2002:a17:907:6093:b0:af1:69e3:c074 with SMTP id
 a640c23a62f3a-afddec11a0fmr169649966b.8.1755597164015; Tue, 19 Aug 2025
 02:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815022528.24705-1-junjie.cao@intel.com> <20250816121046.38a9fb92@jic23-huawei>
In-Reply-To: <20250816121046.38a9fb92@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 12:52:07 +0300
X-Gm-Features: Ac12FXw9Vz7WNq878JT9xnU1q7CSRWgmc2rY-Ot1gE3BbHkZuqKXj0Vtap6Z-co
Message-ID: <CAHp75VdSQP8yeHNg7ZEGiYfPLJN9-oRywyASUPQxdazWpi=WdQ@mail.gmail.com>
Subject: Re: [PATCH] iio: core: Cast info mask to 'unsigned long *' in bit-ops
To: Jonathan Cameron <jic23@kernel.org>
Cc: Junjie Cao <junjie.cao@intel.com>, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 2:11=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Fri, 15 Aug 2025 10:25:28 +0800
> Junjie Cao <junjie.cao@intel.com> wrote:
>
> > for_each_set_bit()/find_*_bit() expect 'const unsigned long *' (see
> > include/linux/find.h), but industrialio-core.c passes 'const long *'
> > in iio_device_add_info_mask_type{,_avail}(). Sparse flags a signedness
> > mismatch.
>
> How do you get that warning?  I'm not seeing it.

With or without any warning the casting is a very bad practice for
bitmaps. NAK for any patch like this to any place in the kernel. I
already fixed some of such castings in the past (one may browse the
Git log with my name for that). Yes, I understand that in this case
it's not critical as the sizeof(long) =3D=3D sizeof(unsigned long), but in
general this is not a good style leading to 3 potential issues
(out-of-boundary accesses or endianess).

> > The masks are used purely as bit arrays. Cast them to 'const unsigned
> > long *' at the call sites to match the helpers' prototypes, without
> > changing memory layout or behavior. Changing the field types would caus=
e
> > unnecessary churn across IIO.
>
> Did you have a go?  Superficially feels like we should fix this up and
> that it should be almost entirely confined to relatively few core functio=
ns
> and the types of the various elements of struct iio_dev.
>
> Might just be (builds and I'm not seeing new warning but then I couldn't =
trigger
> the one you saw!)

Jonathan, the patch you provided LGTM as I have in mind to do
something like this a long time ago. Please, proceed with it. It would
be better to have unsigned long * for bitmaps to make it uniform and
follow the API.



--=20
With Best Regards,
Andy Shevchenko

