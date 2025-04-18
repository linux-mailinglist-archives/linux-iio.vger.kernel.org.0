Return-Path: <linux-iio+bounces-18235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84005A9357E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985AB462DC1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C4270EB7;
	Fri, 18 Apr 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu54lqbG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FD209F42;
	Fri, 18 Apr 2025 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969566; cv=none; b=ugr1w9EVIqEy0bfQqE1cn9TuugiTo3l2aCD1hMnbqt1qOdg+qR0XkbejPIh6kizPbO1GvMbd9RuWe7kUOUeHnewbxfSLikWAnDGplNCYzS18xOt+3QN6Bqkq6Qq9p2BKb1F+gTfyzX7YopJWCoEfo8rklR127rid2ztZ7ZqTgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969566; c=relaxed/simple;
	bh=kZYbgKw3ukUo4QCzVMR5VmYsOncMtGLSf1fdEUi9EUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwqzH9d/DJNk0IqAhp5qyFHRoe0bOln05AeA5hOgQ+Kwf7QVfIElSXprpdUjRn6tMcL+WcXVpQrqrgXXRGjqssjnsBkqSbI1M/yORxYnaUIL6HlCt7oZZU7Uykxzw3b/1BYkKGQwDnCoarTuo0PUdnCUQ5N0kK3blhw8nOL6Fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu54lqbG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso9422875e9.3;
        Fri, 18 Apr 2025 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744969563; x=1745574363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZYbgKw3ukUo4QCzVMR5VmYsOncMtGLSf1fdEUi9EUE=;
        b=Zu54lqbG5NS8y4+1mHKVCKBpQXkL6+XjWr2q9VWM2rD6ZAj87I0P1EDfBghz4XehJl
         WjoPuBmHYqjy5bAwGL5NQKeZmJxDXNDVNlXtQy7+Ll8hL5FS2/MQeUcHvLjUZfjwUwWz
         DJVayrfhkSRpq3k8h9AI5UThBvNj+n9nI065agZ1lE++T14MetFL1a2bM7GJC7S9dvWf
         C2IadtmRpcWpCn5fte6H76EZUJqEBBfGeH39rGnhi296h529i9pO08h3EehVL4RSSNYY
         JDeEGX7KeIiiYW+ErCdAnfObPfErmbI5+ND6T36X8LmY/Xpr0sLSsHbaQFshokY8PlJq
         Yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744969563; x=1745574363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZYbgKw3ukUo4QCzVMR5VmYsOncMtGLSf1fdEUi9EUE=;
        b=FCfxyoAzVblStrlwKuXVn9/S8vqxPmnKm0miHfvWWiu1YiM6yJp6/ACJJsjmIvkani
         cXqpn0ls54t0LwXsQxJtIE7mWpFagAxaPZ+JDFFtHTfj+Eovho7/3915UPkYzuEITPNl
         djQ+kV5KppZV9uByqiWGbx+pWLELl94baPK9k82KdYXCFZMyx9FRFoFbRhtGRWK4DtY3
         I1RGadB6Tj6TLPknivcKDmACU3tHxMNeceoUHF7oFHWKM8lUYvQhVYWQKoOzT0jGUkJa
         BHIPxdT228VOQ0SrT5431QpBlRdXPvF02q7SldqM7BU4qba/81kHcCpbG6+g4RoYn0v5
         ea3A==
X-Forwarded-Encrypted: i=1; AJvYcCV8RLC07j36kX+2xEQNiUerGG0RxvV1/7zWJEstWUOjekSXmtYJJ+Tx0/sBAW+AQSNdXrHWx8x+Oqg=@vger.kernel.org, AJvYcCVQyIlG0MHdVsJimeQ6VXgNfnbPM2+E/fNrpweJIZWhjSqeljUNW7GSi+3w4ZpqGyDG28RVm9ls/Evd9Inp@vger.kernel.org, AJvYcCVrT1en6Joyc0tlLsStp+wEWkx005HgI4xOdG5Ge36v/j+t170baniCvMRzNUOnEsSleGK0YzvV@vger.kernel.org
X-Gm-Message-State: AOJu0YybayAeCNxPf7CaB6jbtRMannbdkzoghBEs6/YwXJB8rVc3KyZr
	mUr04fVPq3aw2xgo63BbhjPRZ9T3pEFn0jd/GFFuh2/lcNOvEPPU
X-Gm-Gg: ASbGncvcIfmBLf7Z+BEUkS9tBAZdExj6l5GIqohSixyRicEWVp6dpNDjngh2fovkLCb
	fp+HoBe6V6SCD0vF0FOd/fxafIfOupvaMp/Ah8jl2u09clZAqefDjHdE0NaPWnaPlLjMZNC7XU2
	IL5SOwK3DXvm6wP4yVYJgsqnpyrw+AQfMYIdAvG8FxFLEPZuc/QVjcFiw7Gi2XAY9CpP6j4w2Si
	xYkqQOSFYi5sb4BDB1nTQirTvvkCiEA4jpSKlEAdqBmrhHigeNYb0dS7XlPEQi6cyqOdhOVaoHv
	9Ee1m7imGUN7CNJ5N6F21pn8XPzC9yWNfZgcttzOrCk4NLxwWlbH6upkEQub67F4+kC+rIaTEW8
	rVZL4I6hSI6u2M2IJ4kXy1cb23A==
X-Google-Smtp-Source: AGHT+IGdwQHN41vKDt7TdqZdCPUhvA/CvukjpsYuLQYJQHGAPy/n5hOLeTb7Ch9Qr25KePDhjhw/MQ==
X-Received: by 2002:a05:600c:4e4c:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-4406ab99615mr20004245e9.12.1744969562833;
        Fri, 18 Apr 2025 02:46:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa3a1685sm2285627f8f.0.2025.04.18.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:46:02 -0700 (PDT)
Message-ID: <a32503d98ffe162f48de019fab1a37f86af1666e.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: Revoke valid channel for error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	sonic.zhang@analog.com, vapier@gentoo.org, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org, stable@vger.kernel.org
Date: Fri, 18 Apr 2025 09:46:23 +0100
In-Reply-To: <CAKUZ0z+FKxHcYTYiGvrZ3RLiMKT1P4gtTdq8d7=+ZFC0RMQzqA@mail.gmail.com>
References: <20250415182038.523186-1-gshahrouzi@gmail.com>
	 <fb712c034eda0d5d711a90a00b6382315fb5f929.camel@gmail.com>
	 <CAKUZ0zL88AyuRxzhoAv2iZO7N7qOMy1G3yKscqG3rQiiOS0gog@mail.gmail.com>
	 <e8b24cf22c87e5b5ce0cc8919eca79f6e60ab6e3.camel@gmail.com>
	 <CAKUZ0z+FKxHcYTYiGvrZ3RLiMKT1P4gtTdq8d7=+ZFC0RMQzqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 13:08 -0400, Gabriel Shahrouzi wrote:
> On Thu, Apr 17, 2025 at 10:02=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > On Thu, 2025-04-17 at 08:53 -0400, Gabriel Shahrouzi wrote:
> > > On Thu, Apr 17, 2025 at 6:06=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote:
> > > >=20
> > > > On Tue, 2025-04-15 at 14:20 -0400, Gabriel Shahrouzi wrote:
> > > > > According to the datasheet on page 9 under the channel selection =
table,
> > > > > all devices (AD7816/7/8) are able to use the channel marked as 7.=
 This
> > > > > channel is used for diagnostic purposes by routing the internal 1=
.23V
> > > > > bandgap source through the MUX to the input of the ADC.
> > > > >=20
> > > > > Replace checking for string equality with checking for the same c=
hip ID
> > > > > to reduce time complexity.
> > > > >=20
> > > > > Group invalid channels for all devices together because they are
> > > > > processed the same way.
> > > > >=20
> > > > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 de=
vices")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > > ---
> > > > > =C2=A0drivers/staging/iio/adc/ad7816.c | 15 +++++----------
> > > > > =C2=A01 file changed, 5 insertions(+), 10 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > > > b/drivers/staging/iio/adc/ad7816.c
> > > > > index 6c14d7bcdd675..d880fe0257697 100644
> > > > > --- a/drivers/staging/iio/adc/ad7816.c
> > > > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > > > @@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct =
device
> > > > > *dev,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (data > AD7816_CS_MAX && data !=3D A=
D7816_CS_MASK) {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for
> > > > > %s.\n",
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data, indio_dev->=
name);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strcmp(indio_dev->name, "ad7=
818") =3D=3D 0 && data > 1) {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dev_err(&chip->spi_dev->dev,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel =
id %lu for ad7818.\n", data);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strcmp(indio_dev->name, "ad7=
816") =3D=3D 0 && data > 0) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (data !=3D AD7816_CS_MASK &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (data > AD7816_=
CS_MAX ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (chip->id =3D=
=3D ID_AD7818 && data > 1) ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (chip->id =3D=
=3D ID_AD7816 && data > 0))) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(&chip->spi_dev->dev,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel =
id %lu for ad7816.\n", data);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel =
id %lu for %s.\n", data, indio_dev-
> > > > > > name);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > Hmm, maybe I'm missing something but the code just looks the same a=
s before
> > > > (from a functionality point of view)? I'm really not seeing any fix=
...
> > > I might have to change it for readability. From my understanding, if
> > > channel 7 is selected (AD7816_CS_MASK), it never enters the error pat=
h
> > > whereas in the old code, if the chip were either ad7816 or ad7818, it=
 would
> > > end up returning an error because it skips all channels above either =
0
> > > or 1.
> >=20
> > Ahh, right!
> >=20
> > One good refactor is to add a chip_info struct (renaming the existing o=
ne) with
> > let's say a name and max_channels. Then, the condition could be reduced=
 to:
> >=20
> > if (data > st->chip->max_channel && data !=3D AD7816_CS_MASK {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(...);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > }
> Makes sense. I sent a V2 with the updates. Also included enum
> ad7816_type as a member for chip_info but not sure if it is necessary.
> Renamed the existing one to ad7816_state.
> >=20
> > Being this in staging, I guess we don't care much about having the fix =
as the
> > first patch to make it easier to backport.
> In other words, combining the refactoring and fix into one patch is
> fine but normally they would be split?

Yes, in theory we want to have the fixes first before any refactor because =
we might
want to backport the fix and we do not want to backport more code than need=
ed. Not
totally sure but being this on staging we might not care that much about th=
is.

- Nuno S=C3=A1
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> > >=20
> > > >=20
> > > > Having said the above, not sure if grouping helps with readability.=
 But I do
> > > > agree with moving from string comparison to use chip->id. And we al=
so have
> > > > redundants 'else'
> > > >=20
> > > > - Nuno S=C3=A1
> > > >=20


