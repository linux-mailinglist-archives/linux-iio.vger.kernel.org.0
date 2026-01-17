Return-Path: <linux-iio+bounces-27904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FADD390F1
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CB8E300791B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A762C326C;
	Sat, 17 Jan 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URdoUpw4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57114A4F9
	for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768682632; cv=pass; b=DHPa2ZgKaXCBeoukIg9FV8AMIs/l5VOSLwpR0Qwxe1eMISUSpQiFldKnLnIEfpgeYOrfxs/tnkttj06iMZa1Rmtw5hTtg35PX05n9Z+PAABBRWEcTMmPMjx15UBrefBSr/hFLhtCvKcy8/D1P81W1hWNQsu7PnZMLWUXPExjzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768682632; c=relaxed/simple;
	bh=Ack/GyXmXx26koqD7Di5Vcrce5Yc81O2Iw2iH/z8Qhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYdg4XMq0VTQlQGsoEfTEilgnggMN5sI06lmRgXmH/nzxalRE2ZohlCU2UMSNLSHNmBX7z4rMQxm4Ax71aXJpl5Y3DVJCermtY7RMRlHZio4oLjJjK+jwsh8lRsE/dnyoxyFyihMRZIyZ/CVhhWuRXaeMzkhZ2uOBUGcA7QiirI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URdoUpw4; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so1646964a91.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 12:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768682630; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZ1fmlDc1nFgCZRDQukotJk6UzVfS+Z5ZelNs5s3wQpC/2+VQzIom7gQTUaeBf01Sr
         pFXR/4qr1Q9QkuajiAAlssaAUM0XgwVJ97jYbz9bKxCmUNa1ZqzmfF3hTRVrvW65C0bR
         sSHBh8sjr+Dz7eoO9ze8FffbDJH6qZxwghdAJXZ5OjwDxeTZcjdxy6PeASU9AbFuwd4k
         vntF9mRWPkG2fE9qJ9YfMTm6pnoCNkgjRQg3Tveaf8sAQWGb7FfZ6WzEKpdHbPQLOj08
         VTSWIKCXtme+FjkBfj8aGW+H8QzREciS/AWEGjqADbghJzwlWNJjmoQVp6Tb+Zzwg/hW
         VPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qq0SA8Phm7CBvumULlrPi6PuG1Ohw5RaNb6FsukUo9A=;
        fh=SVOZmnhImt1Z58Z/1meDvzAddi0lpwl4sH3TOHtDxgY=;
        b=TXThu0hXuOAqeDSwb6llBWobNRFrV/9gyPFzDNUkC4+QhzYsJLrQBlWxbnxC+Nxbxb
         gUO0qkVmBvnHVmhrHac//sxccU/LjqNhXzdL6Dlwzmk3FLEpHvcjcNwXkehR1tnPsK98
         iILQfeRgrSGGniKdDH8VC9b25IpCNbhrFaLT/d2MPKX/Hd2tjFt1W5sBXUO4Bff9pcHX
         joDpuOsVuqapbSRcvE0bimWfNbXSYIu8xKWaY0WHQl8arSqa1UxOP/ZDsQKRgANk7x2X
         9AMUjt5j9p+SAUwlVBZfNkQuf2WftjLFXzpk6uwLYvEzfQrJJqBmPCICOKMy9S+03FbD
         a3Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768682630; x=1769287430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq0SA8Phm7CBvumULlrPi6PuG1Ohw5RaNb6FsukUo9A=;
        b=URdoUpw4G7UDIOZRstQ15Upf9jNEPbhYCJMJn61VTdzu3+uUFqFnejd/a1FZzjaqHs
         +Q7S9HmgG+VIu3obEZmQdf6Eub8d7yildIKAgeVroZVNaBSsFxI9ATWUnsg5ZCWaCE4F
         OKGh2Y31/gd+wFp3Q1Z6i+DYcbYmo1qad1PP3wJ/CJM48u/vG1ubV1NZJKUh7HoSTfYN
         AHaKgMYLixtPuzeFFWnr+MokNgJL2DiL4yejNAy8Fp0heAmUzbtVJ6PlhExACR3rPqnS
         8ma59xovICUKrABF9yLNJi0mfgc3nHNEpWInGSWL93vlNRUuUuRftQ68ifCmFP2wQeiu
         SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768682630; x=1769287430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qq0SA8Phm7CBvumULlrPi6PuG1Ohw5RaNb6FsukUo9A=;
        b=HsaWhz98ZJdXFhFK3Lrwshv5dkLHcE48yMOX8Sxb5g+uRK5hbpMKLqTe6I9JSwTiSr
         g4ckL6JB4wsInPdcts9HCrwt9za0if/r+uzYA2v9hiGpw3GSBZcZ7Kz1y+ksjrYVLWOx
         cN48MGyX+anwlibsTUsShyNGbnw4/7Coj32hGy46Z/CPWyGUD/kEs8rKSKgV4BElspMq
         ixSZbKb677o9YDMnlAF1gVwtlTpRFJrrc1uPcTNyb+d2JmrP/2DNaJfw4ShSVTmf8gDa
         3wZN9ML/QC9Vs2XOtVa5YsbfpeqrrjS3e3Y5Lxq8IBw5aexK7Xv87b+NlJhR12W7VD0W
         jGxw==
X-Gm-Message-State: AOJu0YymlSNL4iLSG2569RdmgPqTlQ2xcbmZ3KLL4mDHRq/6ME2H5fcU
	B6CUpoDp9ZOajDyALi6KleJsOol7EU/nOAQr7KJJp/utFNjSW/ANKTpU0E7bNgmWHy3wgSTlkJs
	quCWEKHKLESj0PfAgs3YxAnbTJ38Om+pAJFRm
X-Gm-Gg: AY/fxX4DXHSPnCdCeeWA+nBgKdPNtXvEzbll8uxdEpY7ugW5nm1hjYq6u5oT2wAUNDu
	DZmdq1d4xvS+rkW8S4rbV9UQCkJbuHwByPP3XinrXRDO4oD9xYf+/evO4EtY+/1mfd06vgYhjn3
	irqiJVt+39Q38ulD+zQPZWISTYMMF15MfFWlsZlacxF2NtZ9k72yQk/kpLkVKXcoMNfHEoJGe8A
	8uP1keHqFzZBzTKnwPsLOOqkz+ijDHrHtKVjMX4XSy7V2wS8K9LNMOOuyDevCdRVgIIPYpN4XWH
	hqpZJM+IY4WQrxW7pw1waeY=
X-Received: by 2002:a17:90a:d88f:b0:34c:37b8:db34 with SMTP id
 98e67ed59e1d1-35272fa46c2mr5392833a91.32.1768682629877; Sat, 17 Jan 2026
 12:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103192442.10826-1-gabrielsousa230@gmail.com> <20260111125844.493fe5ac@jic23-huawei>
In-Reply-To: <20260111125844.493fe5ac@jic23-huawei>
From: Gabriel Almeida <gabrielsousa230@gmail.com>
Date: Sat, 17 Jan 2026 17:43:38 -0300
X-Gm-Features: AZwV_Qh6tkqugI4Sc7gQFG5V4se06p6MMfzjLqoWvHVr6BPbYB7CtRnl6UPIgoY
Message-ID: <CALsHKmWEZotPVc8G=hWa5kRHJNO269nZo1E5u8bnhCB3Oi=0cQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: zopt2201: use lock guards
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em dom., 11 de jan. de 2026 =C3=A0s 09:58, Jonathan Cameron
<jic23@kernel.org> escreveu:
>
> On Sat,  3 Jan 2026 16:24:42 -0300
> Gabriel Almeida <gabrielsousa230@gmail.com> wrote:
>
> > Use guard() to handle the mutex lock instead of manually
> > locking and unlocking it.
> >
> > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> Hi Gabriel,
>
> Welcome to IIO and thanks for your patch.
Hi Jonathan, thanks for the review.

It's a pleasure to be part of the IIO.

>
> > ---
> >  drivers/iio/light/zopt2201.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.=
c
> > index 1dba1b949cc3..f5a41c293d9c 100644
> > --- a/drivers/iio/light/zopt2201.c
> > +++ b/drivers/iio/light/zopt2201.c
>
> Needs cleanup.h include to be added.  The headers in this in this driver
> aren't ordered, so just put it so it's in the correct order with one
> of them! (alphabetical)

Sure, I'll add cleanup.h in the proper alphabetical position.
>
>
>
> > @@ -351,15 +351,13 @@ static int zopt2201_write_scale_by_idx(struct zop=
t2201_data *data, int idx,
> >  {
> >       int ret;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       ret =3D zopt2201_set_resolution(data, zopt2201_scale_array[idx].r=
es);
> >       if (ret < 0)
> > -             goto unlock;
> > +             return ret;
> >
> >       ret =3D zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
> >
> > -unlock:
> > -     mutex_unlock(&data->lock);
> >       return ret;
>         return zopt2201_set_gain();
>
> >  }
> >
> Whilst this change is reasonable subject to comments above,
> you should be looking at the rest of the driver to see if similar
> changes apply. zopt2201_read() for example can use a guard with the
> trivial increase in scope of the final endian swap occuring under the loc=
k
> (which is harmless!)  There are other places as well so take a good look.

Understood. I'll review the rest of the driver and update other places
(e.g. zopt2201_read())
>
> Thanks,
>
> Jonathan

Thanks,

Gabriel
>
>
>
>

