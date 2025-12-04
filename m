Return-Path: <linux-iio+bounces-26740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C363CA4280
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78655300A27E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44A2D7DEB;
	Thu,  4 Dec 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoTJ33YU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C72D879C
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860890; cv=none; b=ZGaFtMU2N+27u91NKNkgEcFtBNa38kzOYkWFXSPSUjQVjPZ7c8Y49Bv4LtfkwFrp4cm8BrvLCpJR+oOUWV38wWeKx0HjrW4TZrKpqMM42azMdZK8KftbUd9tBzNRZaRRooAV12B2cU1umGvsNaduifY0AfirAzWh9tV1veuz9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860890; c=relaxed/simple;
	bh=V08uaRjfaEg2wLqAVhUd3vtB545Y9YlqH+LX5++XV6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBJy8fwlfT175a0x5dRbjQ2PiY6heROOI367pqJEfZ3e6C9aRmN2U7IVXANi892mlTv6evozceDwOPz77h7KJkdOIRtekG2HsLRrMLEkxo0YKwtNPUhW42gr9cSkNsmSTkGMObZiM34QkRhVFkt+rCReG2Rd/71FLSdPdEGN2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoTJ33YU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b736d883ac4so178798266b.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860885; x=1765465685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSSRRIrYsHc+BU7z4a8pMplGe0ESdbsiENi8Hosq9ek=;
        b=aoTJ33YUE1hRynhKfH/3qCmVLpOCorL8rHq2X4PO1zWETHLWGnbzZUy5b1jKQ2OFwS
         QmsdF7jUyde2BAu/tsSEpXg+h7vLYwQlTnGMjV4ejb47MpbwPDJB9U4ydTcNswzXCzCx
         ChR6ZAvmkUkH8q0C9kAvuMPUTXyOLdZiYCrQKUMzgsaeVnHJh7hs4TCl3cHAfqdm6euC
         xSoo+haRdChy8VSrquB0RK9WChRXAt1fthTObpF3zG0GYci4KizefQBL/K4cBKyIm+wJ
         drdpZ6S4njdXEaG9gFDGZnj0XNmmlHd5+1MP0J7bLO5iNSDI5ozIfD2xr5c7k9vMWaFn
         zF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860885; x=1765465685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSSRRIrYsHc+BU7z4a8pMplGe0ESdbsiENi8Hosq9ek=;
        b=r8enA7ISf8IGF4eOVBUfJ5DuJusrmj1AmPhnLeLO/7SEPoavUyUJAkxmoMZtq/OmxE
         UkPxROYs4FFNyDOJQ/VbUXORNUVYFXlpJJ6riCAidtyP4pA+esFs0YXijZEpJQvY0VSq
         Rr9XL0ULL5o/QOgcatVMINxllfTwPNxytq7L3pZd09GF+v3Fb3RdtdPIjCrsIHJyh8b0
         8VY60aGkhoRcKKtk9DrOWrZj6ZpizKSmmwIoEgU+jK5XSMlApI2mFBG1SyBZ3eTNRWVn
         4aKPNthh/7r6Jadbjo5QA5tr++snCAA4UTAVuwNrCuLvEqoL4ds+glINPyhkGLx7eiUQ
         /uhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEyZasumAHJBKneXuWMMQdH8Q762i+2N/BdiVEPDHsB2sHLEL+8Xe6g2XSwRKEg70FCCd/P7h1wSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8/dbIz9GaRvMGWjpCX9owlhpOe3jDgTliKG1gaGfePHW//9E
	ZSpjILcC3UIqHgspwA7HYWwvJN1Ko8MdcFSMdssVItlglGaQ1SWGFqgoRni0KYqkZKM6br9+84N
	0LUOGFrAN8kxP/4Z8PecTm6ClU9j6uU8=
X-Gm-Gg: ASbGncsAy0QQau2hfE5oZET0kijf+nRww6QpWL8uFoo/sy0S/xW80jcKII+PKU88DRt
	mh644FAkYu4PqvuKmNqUh40rPvlkIAU+uOAFIwhWhLqcS7Oaqu2gb0wrhifgukkTGh2dHoPLwB1
	eninG671Ljiwir6Oqtiso0IB5zZcoz07IijBesVAXF28B/n3f0mRoiTe5Hoq7TLFd6sLTx7BEHw
	E1MfUOAX7Eb2d9PkI7mb6I5iy1Fbb75f5nMN5PSWqSwaSkuaXLGvnrkOwwt59CPQNG+e0YcqbbK
	WVm1NWXq2x/3aUUuqbG96axxR4ep0+1uRqMr7k/bQRbgkIJzB3fpBE/3BGBwzrQgDG+48Qh4hnB
	EdBPoQw==
X-Google-Smtp-Source: AGHT+IFAol8FvXCQ/hzm9jQyOszGYW1+GC5PlRTh2p4qUMEuQIBmClzMD5AVXoFgMQXWWHxnQr0H1H4I0vDWKP8M6oE=
X-Received: by 2002:a17:907:3f11:b0:b73:7652:efc2 with SMTP id
 a640c23a62f3a-b79dc77c26amr662911366b.60.1764860885095; Thu, 04 Dec 2025
 07:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com> <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
In-Reply-To: <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 17:07:28 +0200
X-Gm-Features: AWmQ_bmly8zqW9i6ZFrS7i-LUxALKOP59XpLcQJF_VzkA0upKuwiwj5K7wgTCUA
Message-ID: <CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode locks
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> >
> > In a recent driver review discussion [1], Andy Shevchenko suggested we
> > add cleanup.h support for the lock API:
> >
> >       iio_device_claim_{direct,buffer_mode}().
>
> We already went this patch and then reverted it. I guess before we did no=
t had
> ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better. L=
ooking at the
> last two patches on how we are handling the buffer mode stuff, I'm really=
 not convinced...
>
> Also, I have doubts sparse can keep up with the __cleanup stuff so I'm no=
t sure the
> annotations much make sense if we go down this path. Unless we want to us=
e both
> approaches which is also questionable.

This, indeed, needs a (broader) discussion and I appreciate that Kurt
sent this RFC. Jonathan, what's your thoughts?

--=20
With Best Regards,
Andy Shevchenko

