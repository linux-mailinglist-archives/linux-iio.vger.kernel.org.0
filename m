Return-Path: <linux-iio+bounces-2922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A5860BFC
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 09:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40639284B9A
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A411F168C4;
	Fri, 23 Feb 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx0CGWFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CF171CC
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676238; cv=none; b=ZmSZjuLfQWKjlgKtUB9GNENuYcb3q+tyUKKcnXT9btaQSK9Wj7acVp7t6fJuTp8VqcPuyMu7DinyXvt+KMB2ogWDfGkb43fq4DEpo3lEdPTgAFgSv0fzANOxfB82NTOI8167jS8A3/0gB920KiFT+044k0+R6Y9M/y3rw8P3Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676238; c=relaxed/simple;
	bh=WhkuRRTATeRQsW2ArBD8d1el8JnD2Lmq86KmSs95sqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sd/J6s46vufpcrbh5xvx4SuB8926OR7fMZcAOlDllSGAg+D3FTa0jEE1T5/BWkvECo0+LGG4wL6F3uKEC9/WVhT8TCjlGSbXBfZdHIyVRl9Md5Bd6Jk9JQJos8ZixZ4qOvo4ZWGKfY7U1yn8TXMyS1P3g+hRtjXjpRM43b/O6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx0CGWFx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so10690066b.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676235; x=1709281035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lovCi5KexcC0vrrtRKXVoNJPekRxeKsrXFSXa7Nnbwo=;
        b=Sx0CGWFxzQO+b/xDHa6FEU+U11yx950gKZXoX0vjvhQ+Lx85yiJb4kKHw9rzAeDXk7
         YG4bTCwnQZhIyH+mpCbEI7jcBgsULc/1wi1QrrGWmA9hD/HQ+5pSwrBParie3TlbLO5H
         sXSDYqfohXQWnjzuaQlVFfRz/R6iXfZmjUAaX+kuQPp311bGZwouGlMHwQXnpsB7Px/r
         zGxxBc8MOT7I0WxT+DivI5VOv/EMJ+0C7H8t9aYRURhQcmm7TCs5Ef1x082T9I7kVkKT
         AJJs5ycd707hUfpUbrEBSC7XnAMN/9oZwzLL5DCvUX5aowEGw6Fir8QSBd/LB6Vlh5Ow
         mwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676235; x=1709281035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lovCi5KexcC0vrrtRKXVoNJPekRxeKsrXFSXa7Nnbwo=;
        b=mEH47+yKp6R4pXwU7HUVmfV4ymEBu+Zj6IYA2yH/uwgEq+E9fjsMDsyhZkMaa1eLwR
         0+U8yS6eYU5lR7C6M0Pnu8Y4tGq+QXmXJB99kHLr78uwcmwwABn1N3VCz2gTOV2lXa1i
         cAKkNj5BBYNeDG49mrk2YdT/zAvw+SsXKr5qfj1bhTuFL+sI2GU+7unwPgM4RPMKvCpp
         T00huJ11ST1QezwJpRZq3XxSkT20TJJD4/Jla6oHJy0sTHiRE4vHid96RaxEo8Zcvhoc
         tlO3I2sRBY0eYJObKKI4iDwPFhdekR/DQ+zFnsmYPjZdoZSL/MOgcN2nlg6sGjS8eRoO
         hh2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4wdF89SQ+YH/4ZZXQmD4JfDgTNc8VQu495xDulJSQXw2Vp4V5hJ6IzuSD6nmXs6JYTT4Lm3DUmn6qJLkNH1dCRjxbk6EU5acS
X-Gm-Message-State: AOJu0YyARgki/O7EanQ5f3BEtwH4GdJZRSx5qzscayH7361Io1KwAdnL
	DcflP6UN5DxkA9km3VN1jk9Q0bI7iTgEk9MkohvB6N6aqU5D2FIx
X-Google-Smtp-Source: AGHT+IFftpKF6iAFjLGt7lhSBbPn/P8WepHBF/dJADOS/YCpywTL8Ymptal/bptfGGd6EOJw5H4KVA==
X-Received: by 2002:a17:906:ae92:b0:a3d:d1da:1247 with SMTP id md18-20020a170906ae9200b00a3dd1da1247mr708249ejb.56.1708676234630;
        Fri, 23 Feb 2024 00:17:14 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id qc20-20020a170906d8b400b00a3f980309a0sm1062571ejb.207.2024.02.23.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:17:14 -0800 (PST)
Message-ID: <a596b6c24fae2a5d163d2f37cf3c914d53bc68d5.camel@gmail.com>
Subject: Re: [PATCH 1/5] iio: core: move to cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Fri, 23 Feb 2024 09:20:35 +0100
In-Reply-To: <20240222192245.6470638c@jic23-huawei>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
	 <20240221-iio-use-cleanup-magic-v1-1-f9c292666f26@analog.com>
	 <20240222192245.6470638c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-22 at 19:22 +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 14:26:52 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Note that we keep the plain mutex calls in the
> > iio_device_release|acquire() APIs since in there the macros would likel=
y
> > not help much (as we want to keep the lock acquired when he leave the
> > APIs).
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-core.c | 52 +++++++++++++++-------------=
----------
> > ---
> > =C2=A01 file changed, 19 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-
> > core.c
> > index 9b2877fe8689..7e6497828364 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -11,6 +11,7 @@
>=20
>=20
>=20
> > @@ -1806,31 +1803,22 @@ static long iio_ioctl(struct file *filp, unsign=
ed
> > int cmd, unsigned long arg)
> > =C2=A0	struct iio_dev *indio_dev =3D ib->indio_dev;
> > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D
> > to_iio_dev_opaque(indio_dev);
> > =C2=A0	struct iio_ioctl_handler *h;
> > -	int ret =3D -ENODEV;
> > -
> > -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > =C2=A0
> > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > =C2=A0	/*
> > =C2=A0	 * The NULL check here is required to prevent crashing when a
> > device
> > =C2=A0	 * is being removed while userspace would still have open file
> > handles
> > =C2=A0	 * to try to access this device.
> > =C2=A0	 */
> > =C2=A0	if (!indio_dev->info)
> > -		goto out_unlock;
> > +		return -ENODEV;
> > =C2=A0
> > =C2=A0	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
> > -		ret =3D h->ioctl(indio_dev, filp, cmd, arg);
> > -		if (ret !=3D IIO_IOCTL_UNHANDLED)
> > -			break;
> > +		if (h->ioctl(indio_dev, filp, cmd, arg) !=3D
> > IIO_IOCTL_UNHANDLED)
> > +			return 0;
>=20
> Changes the return value if ret returns something other than
> IIO_IOCTL_UNHANDLED
> which it can I think...

Yeah, I think for the multi buffer support we can actually return the anon =
fd...
Pffff, one of those changes I made right before sending out the series thin=
king
I could remove one LOC without properly looking at the code :/

Will send a v2.

- Nuno S=C3=A1


