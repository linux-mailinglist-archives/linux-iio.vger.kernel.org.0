Return-Path: <linux-iio+bounces-27686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC3D1CF58
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C823300957B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4137BE70;
	Wed, 14 Jan 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLHgKgWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641037BE60
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377154; cv=none; b=WklSuK6Q4FjPofCcBBGNwVz51634c/v21jifxtpP78H/mYj7RdQPM1441Mqd/OkiwouLc6Fi3jNQmVqZ0x1aRdOzfvtIhgs5Zxs/BdpsgUcGEo2US3lolvsyNS7dPt2zSv1U2Vo4FtGYqisc7ccI30TbIxInhUm2iC8RGy4IaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377154; c=relaxed/simple;
	bh=DF7b70pBupJjJSYrJW/WIuTpLTQPt4Y6vhs3+PuJ4aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrSh9ZMfZx332oskst10+j5hUxB+DDC6vjggj/rVkXL9af7m3sqHBrxT2S93nMrPjUAMZCUMGQ/Nx4aopRm8vhy5WgYzQwXcDDM/4y1f6haT4p2SjqmnBEQ0NtoQGo6A9IzMdVXz0VMdkBg3Bx0MIjwYBRjVMTi30YXeXGDbwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLHgKgWf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b86f81d8051so99980266b.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 23:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768377149; x=1768981949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HlHk/yn+DJ+PoyGINyvAugKwAmsS2dK4Xs4PHsv5ew=;
        b=JLHgKgWfGaV71HqIASpPVrbXIZZITlk82QFvLgs3mhSbqR4gpt5OIF1nDSJkobtDMj
         L3Z5P0BvF9mYnaBbTw7tZc4B2/9P1WNTvA1gEky2JKOaknbCtP4NyU4m6ySEmPl43kZX
         XqBIPmzqEdy3uwdHxHSyFIKfkMrcbyi3DuOoz7mqJNFPU9gLytu6fzhMqmCpNQImCFq0
         tXQyxzMZLudEC9yNTkvWPWU4OObnnrnUmJmI3sEuz+O5tEY69iwPi6DcV+XPURmp29xT
         YpN9CfYtReoqHGiCRuyNAemSiJXJIgJ9g6QWKNu0Mo6v8HWD7nUWp5ZuiTGZmQ4rfWHB
         eMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377149; x=1768981949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HlHk/yn+DJ+PoyGINyvAugKwAmsS2dK4Xs4PHsv5ew=;
        b=jSf0ATBv9BkeCBCUvpmIS4hiKz6reQcm4bGJdURKHiXgOTI4Ke2flbQAOpTzalkOnp
         9bEz1WoHp0f+VkOqkx62H+u8UMMX4fxAAHCmfP8QhaCJZc01xMR1va50H53O4vCTE5+/
         QyRE04QlY71Ze/KC1MxDT4R25FOI1vBxSz8M8ZEQcq8BBM0wKJIpXN7WLdknwmqqguqF
         S2iZNeQXSKc1p7Ld6hGGi0qquJSX0EwhL42jUortgue++JD9VeJTIVo1YDPMROOnemYA
         ZVtlWoOQGua/LXFVDyCZSsFp2aSoZdDtEhGj41IBftlSl0PiA/AlhdEHgp20CCF64Nkz
         Ef0g==
X-Forwarded-Encrypted: i=1; AJvYcCVZmtjPMJ3qZcu2QjlLe8I+uZpbXjryypV7i2cVy5R4DSgqgsgDgEPcfGUnP3mcqFa8H2pbPTjDYAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWduQWjFJ+hdbYc2V3uYH6vR3yHIEQxSaUPTM8TSSW9wZnBgi
	hxYcI4QH1hle7dCy/twjZZVYwKXo2670CMyT/rHP8gea0T0T1gvG2yh6Ag4VeGKI/4rJzykSEEF
	LI5IMqbBLV4Zh3Uf09ggDxzIB9Zo9Dwk=
X-Gm-Gg: AY/fxX5xg/3qT7KoO8cwl02jD4hj80GmYtDWHJim2Ytoe5/TwXR1zeS6tApsjCYPeU3
	rX2D6SdP1791dw+1yTiwlTwa+66oPlmBWWLp9iMtAAp9YttPf7mRhF4jaDssawIdlhS+ATwS/Mo
	oY7OHHFPCLSTFP5S0aaEuwv65s+mWR66GzoVjsLsWX2+79IXRiF0WA4Z2ClIelseb5ONPTcrO7D
	FHIoWLnN2IAEZp4g9rvkgAYcuVJuc15z8xHbNFTM3U+TOIuxGwonNvay30Rse+tQtscpMinFY9M
	ZEWg+4kCufmtVjWJeNgMui4jFq97bomLNXYWKczU0CCuw58RHHDkKh0vJrzS/SwyoIgUdSk=
X-Received: by 2002:a17:907:3faa:b0:b87:136e:7c80 with SMTP id
 a640c23a62f3a-b87357dbae1mr527464266b.11.1768377148848; Tue, 13 Jan 2026
 23:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
 <aWaz2JrwtwwE3dEc@smile.fi.intel.com> <1a0adfe1-3847-40c6-ae95-73cd3f41786c@vaisala.com>
In-Reply-To: <1a0adfe1-3847-40c6-ae95-73cd3f41786c@vaisala.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Jan 2026 09:51:52 +0200
X-Gm-Features: AZwV_QgYJrOYER1FUm_AYUNwaF9AitiJjkHjyv8J7g6XLfjWFlalMk7_VgFs-N8
Message-ID: <CAHp75VcrHMnzi7F5kzFeHOGt47Jbq=fSsSun0s+=01o9HMMf5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: industrialio-backend: support backend capabilities
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:39=E2=80=AFAM Tomas Melin <tomas.melin@vaisala.co=
m> wrote:
> On 13/01/2026 23:06, Andy Shevchenko wrote:
> > On Tue, Jan 13, 2026 at 12:12:48PM +0000, Tomas Melin wrote:

...

> >> struct iio_backend {
> >
> >>      u8 idx;
> >> +    u32 caps;
> >
> > Please, run `pahole` to see if there is a better place for a new member=
.
> > (I bet there is.)
> Indeed, there seems to be. Thanks for the suggestion, will update.

Basically it should be your, as a developer, tool at hand to check the
data type layouts whenever the new member is added or rearrangement is
made.

> >>  };

...

> >> +enum iio_backend_capabilities {
> >> +    IIO_BACKEND_CAP_TEST_PATTERNS =3D BIT(0),
> >> +    IIO_BACKEND_CAP_BUFFERING =3D BIT(1),
> >> +    IIO_BACKEND_CAP_CALIBRATION =3D BIT(2)
> >
> > Add trailing comma, it will allow to avoid unneeded churn in the future=
.
> Sounds good, was just following existing style.

I haven't checked the rest, but the rule of thumb is that:
1) potential of the adding new entries after the last one =E2=80=94 (almost=
)
always add a trailing comma;
2) termination entry =E2=80=94 never add a trailing comma;
3) exceptions are some arrays which are located on one line, like
  static int foo[] =3D { 1, 2, 3 };
means no trailing comma.

> >> +};

--=20
With Best Regards,
Andy Shevchenko

