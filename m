Return-Path: <linux-iio+bounces-23969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB7B52252
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 22:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE15D1899B95
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6632F9993;
	Wed, 10 Sep 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg3NrRM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA12EF649;
	Wed, 10 Sep 2025 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536142; cv=none; b=Apu7Z0avaSDfwZPkrYdobo28nNKRbPxvLzNFQsLc+az21Vb3u2Fw2+DqTTWaxKcdpHv7hsBWKuk1kiMnrZ4JMKU63dZiVLg4X5wew8w9KfsgO12geEmLXD9ifQ0LYKaKf2wixy0XwRmmnyAqCZgXs7mjdLK5lnoF4ILvFT8rQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536142; c=relaxed/simple;
	bh=2g8mr7Hqv+MS1W1CXy9T7WAwkwk1+OsFYsHS+bnRKVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPmbhdr9RrHUBhzKGynNoNiI+XG7Ih81UdlHtArp9SdF8+9AFe25ELlq/xBUKq+2ZSiBGiQzAZnRmbpfwWhlH0yIAId1UO3pQufcAHRRZUE/KP8BaWF9QEffEpMXleXlQg3vssSloyvsujSQpSubGzpKjk7ZaJapWRWbTHR6Za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg3NrRM0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b043a33b060so1136468166b.1;
        Wed, 10 Sep 2025 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757536139; x=1758140939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4B4aiPEb0LiSOlZmFJpv6hP2/ZNa1GUokKu/b0X24U=;
        b=Zg3NrRM04Hw/fRq3Az/EeiNEIz5gNEqDEXKQVx46iLELVqYKX8j70aGj0kfMzuE/5F
         wrSa/M5XzDrxQQVmaNxh0skXyzoBQ3J9akINaa2bA9TECqGyoA4AqLl/DCzuULoNEpzD
         jLCYCWI4qygcFufyUmyJHLTlxtaXXudFvBeBYxW+Vs1QtDi04iBA/eyci4DVySyhI2gq
         51Zfhl9jOf5tlkGHvfeXjJTKjhASMo6E0uct96RTFDBAT62YGgFONXTn9Damb7mbIN2G
         I8jjlNu9D1rENsoD1Ssm2Vu9lzAgIJboI1wr9QPTO/1rclrMbnV4wU49NsFZlqz0bJsT
         DFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536139; x=1758140939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4B4aiPEb0LiSOlZmFJpv6hP2/ZNa1GUokKu/b0X24U=;
        b=StBGByn5FTWg8ENN6jCs4IEpf5MGcCShOnEYKFtdHcBc5OMdIuchApoCXH3q/d95KW
         XG6HwuIxGcYP17AakpL1FIfGvws3DShxlfN+FmgmM+44EOO6UTV0JtB+bAUr2KQFADFp
         5e0NuVpFaf30RC1IV4wtmY5LpFhU16YbRLyqf29R4n8YZ2t8MlLFplL0NKfvu22+riit
         wCPhX0sBD4coRxB2+ZNP6DTim4bMATnsDFa9jkYtVeAIwVlAPI3Xdnc/rY/Fi3Q5QgQ3
         9VLogkeQjNIwjWzlPGzju266ItxJ1/HFZZOnJbKvRxQUlBohQ2kuQT0lJGXh7y00FTbU
         8RIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU09mQAf3pzSXP3X9CsZOaAYeKfkn9ToTc3dFPnxkab48wq+9B5izK1ykJ7LuAZinkdQmuiVv81AECA@vger.kernel.org, AJvYcCVJIW8hRH3m73kYYL8yX94fcnBC9J5qD5FtmghkFjfpzvIu1ZYvOANP9P7vPW5HX0/w/2ydQ1MLzPOo@vger.kernel.org, AJvYcCWFWGMLjppRmjyNoF+a0upfGquzTDiVqbWbcjD4alpI80JW2ZRluAkwO5AlbKb3S0XViFdsbo988BrqFiNU@vger.kernel.org
X-Gm-Message-State: AOJu0YzueyzkQhU2h2zemJiayAWFOWz3FYvEu8xPkRjblXCCH+6+9in7
	HSzdLl9/vi62ITn7J6oqMT0xIIBUHKqydga9NeL87Bv+7V4BVJfH73n/fvzkBFKOvPiWxgWGOJL
	0We2ihLmv3Xn5lZ6piuPR1xSdC53b42M=
X-Gm-Gg: ASbGncuPGBD7egr6l2CdQXVtkzy+kAhabosQauQP7gyVmIpLaLYw7FVCC9ARTX+fFda
	Hi1V/ch6jr5Z68G+oA2SRiczT5Qrwv8tp+iSmtIDLkPWrJDxuxliOJZjOS0XMKOf9rAjS0u4xr0
	4LeEp1Nzh2sxmtRelejpUe88AUcSpYwYkO/RZgpVdNptIYAirh5CQTxwL5A9XuZQqn52EojlRLt
	oLtPlY3d+dtuE96iA==
X-Google-Smtp-Source: AGHT+IHtRtXVd/EJ9yTuNZ4XATlQBuskIDOxI2L5HZESPp1tnTq/HcAyuBLz1Bt2QdUB83Cmu7G1ejVuyS4Eai9jUdg=
X-Received: by 2002:a17:907:96aa:b0:afd:d94b:830d with SMTP id
 a640c23a62f3a-b04b1767317mr1709402666b.62.1757536138715; Wed, 10 Sep 2025
 13:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-6-e23f4f2b9745@subdimension.ro>
 <20250910185841.075594bb@jic23-huawei> <aMHIzUuNx9LXQdag@lipo>
In-Reply-To: <aMHIzUuNx9LXQdag@lipo>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Sep 2025 23:28:21 +0300
X-Gm-Features: AS18NWBUuQogOoEVC-LBTA2LIYWWTUqXU1KiggrjdFP-_BymArr8L1ifO4vziQo
Message-ID: <CAHp75VfuZ_5akK8qc1zOtNXpwOWCUTB0tZhJqs=tZ-+71Wdosg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] iio: accel: bma220: add get regulator check
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:52=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
> On Wed, Sep 10, 2025 at 06:58:41PM +0100, Jonathan Cameron wrote:
> > On Wed, 10 Sep 2025 10:57:11 +0300
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >
> > I don't follow the 'add get regulator check' of the patch description.
> > This is ensuring they are powered up if necessary.  So I'd
> > just go with the vague: "turn power supplies on"
>
> to be honest I added this just because I've seen the devm_regulator_bulk_=
get_enable() function used all over the place in iio code.
> but looking at the linux/regulator/consumers.h header I was more puzzled.
> just some forward declarations and then static functions doing exactly no=
thing.
> I'm afraid to ask what that is all about. placeholder for a future API?

You probably see two things in one place:
1/ declaration of the function that is implemented in the C-code
2/ stub for the case when implementation is switched off (usually via
kernel configuration).

I recommend using elixir.bootlin.com to browse the code, or locally
via cscope or similar.


--=20
With Best Regards,
Andy Shevchenko

