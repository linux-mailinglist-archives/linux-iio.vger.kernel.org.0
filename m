Return-Path: <linux-iio+bounces-3081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEE866ED5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D714B224CF
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9709692FA;
	Mon, 26 Feb 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne1BqgLR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29A69949
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937830; cv=none; b=N+UHFEiTbej/hEzSYEt2exmZ/d+yquVrNg9eqg1Z867D2GGiS63Jq2amLsKVsZZROILwelozWiSzmWQ6iL1EFSxoWPnnySHpWfGUeoRkJvr1zZ6L1H8aG23uU9cUtDv3hiXcZb9ZGU2+BOTySC2/rk/k+HG2y8qaBKCoFaaIFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937830; c=relaxed/simple;
	bh=Rv/f7Kx+/wX6cgrtmyMGPUfaC4kY0TT4rW++Wp2s+xo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9eV7fFhHhOgBbg9b0iGaeWeinE5OYc2yJtb3mj0h14cJjsaYoVNNxrWEsYX3ByA1iNu8JyCJPdEDnwAkpJIkhK3RBrwmGlEuEqG+P9mmbrVGOfDdHhQ6018XjYt/+hJQCSRlveECY0oYFMsQU9Dffu5TO03TnZXAqPyyyQYrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne1BqgLR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56533e30887so2770383a12.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 00:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937827; x=1709542627; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qih9sOLr1ouhjx17fprtxliERlyS0pCuF5rZvL5haFA=;
        b=Ne1BqgLR2Td+bnX0F+uDJstel+sc5O+nnq30W0svmtC0RcNzBiO/Cwvt/6wyUjLxqa
         V53OQMjYucV+Z1IYKZXSJwfd/KP03BKN6HsXNcflU8WSWoHEduIjd/D7aii3d9Q4bAyU
         8Co3pdfl0akRnH/eZBw5h18WMvr8RwVQEEIxpg4zdWHyXTGChBqVu+2KCtnyWsDN6ZiT
         Ozuq7KtsGSVH+pqA80VxfUakUBDN3xCx+donAeGKmfDhCN1Gh5OleEznzL3qPUwWl76o
         uQ+zQY0PkHoLq9dI778ucWC1jwYJQv4803CK/LHxHXWTZ7Ezr/YXn7bAsPnWWf19y4pB
         SppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937827; x=1709542627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qih9sOLr1ouhjx17fprtxliERlyS0pCuF5rZvL5haFA=;
        b=Llzg2OjvMOMU70splJE6qJHeWFiDP/M5blXvHcRJfDX8dYoQdeI3Zf+TMQp8VR/vuD
         2KkskNHwk9Mu/jsaKA9Tl28RYXgfcw5ohF3M+kEJ+Q+26l6qCa1bogfeEK+NgRFlqxTg
         L1Z2scFlJi0UY8WtyQPLcsGpwRcGPzPyvnf6QEDa37boHScMuBdDVzfjj+7nHA6iyN55
         M/UYfKuGdoatktbu8MnrMYWQsClDPGvqlSfihLBd6zIXW8x+e7yhQSkFYFGSfKtDdFXX
         KQk2p+SHFq16EL3HlJlJR5GiIY4iiuN8vCJ1geOZhrzHZXX2WlHxeygc1u2lKjKYG4LL
         dtpQ==
X-Gm-Message-State: AOJu0YwFAcHdOMulFsoZ7p9IyA/AI9PW71ifnQIgmw8LPivgJjvSw79X
	ujlqj1mI88rLf0zc98Q/Gj1zpOHczqrmHdBLwD7lsqZYrxJkMo8M
X-Google-Smtp-Source: AGHT+IFiQ9X4MAMdnjqTn/Yelxh5v9bKHYcSXXaE3rdhe4mTP5DTikI0m3dUhnJtK2CcYB9lhzfzPw==
X-Received: by 2002:aa7:d290:0:b0:565:9dbe:768a with SMTP id w16-20020aa7d290000000b005659dbe768amr3545070edq.25.1708937826925;
        Mon, 26 Feb 2024 00:57:06 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b005661a50b7c5sm5553edv.13.2024.02.26.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:57:06 -0800 (PST)
Message-ID: <51dc0e063c835c5c851fbc0b9bb8acfc03e8f6b4.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: inkern: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 26 Feb 2024 09:57:06 +0100
In-Reply-To: <20240225131202.165d9c34@jic23-huawei>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	 <20240223-iio-use-cleanup-magic-v2-5-f6b4848c1f34@analog.com>
	 <20240225131202.165d9c34@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 13:12 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:43:48 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/inkern.c | 224 ++++++++++++++++----------------------=
-------------
> > =C2=A01 file changed, 71 insertions(+), 153 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 7a1f6713318a..6a1d6ff8eb97 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -3,6 +3,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright (c) 2011 Jonathan Cameron
> > =C2=A0 */
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/export.h>
> > =C2=A0#include <linux/minmax.h>
> > @@ -43,30 +44,26 @@ static int iio_map_array_unregister_locked(struct i=
io_dev
> > *indio_dev)
> > =C2=A0
> > =C2=A0int iio_map_array_register(struct iio_dev *indio_dev, struct iio_=
map *maps)
> > =C2=A0{
> > -	int i =3D 0, ret =3D 0;
> > +	int i =3D 0;
> > =C2=A0	struct iio_map_internal *mapi;
> > =C2=A0
> > =C2=A0	if (!maps)
> > =C2=A0		return 0;
> > =C2=A0
> > -	mutex_lock(&iio_map_list_lock);
> > +	guard(mutex)(&iio_map_list_lock);
> > =C2=A0	while (maps[i].consumer_dev_name) {
> > =C2=A0		mapi =3D kzalloc(sizeof(*mapi), GFP_KERNEL);
> > =C2=A0		if (!mapi) {
> > -			ret =3D -ENOMEM;
> > -			goto error_ret;
> > +			iio_map_array_unregister_locked(indio_dev);
> > +			return -ENOMEM;
>=20
> break this out to a separate error path via a goto.
> The cleanup is not totally obvious so I'd like it to stand out more
> than being burried here.=C2=A0 This wasn't good in original code either
> as that should just have duplicated the mutex_unlock.
>=20
>=20
> > =C2=A0		}
> > =C2=A0		mapi->map =3D &maps[i];
> > =C2=A0		mapi->indio_dev =3D indio_dev;
> > =C2=A0		list_add_tail(&mapi->l, &iio_map_list);
> > =C2=A0		i++;
> > =C2=A0	}
> > -error_ret:
> > -	if (ret)
> > -		iio_map_array_unregister_locked(indio_dev);
> > -	mutex_unlock(&iio_map_list_lock);
> > =C2=A0
> > -	return ret;
> > +	return 0;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(iio_map_array_register);
>=20
> ...
>=20
> > =C2=A0EXPORT_SYMBOL_GPL(iio_map_array_unregister);
> > =C2=A0
> > @@ -337,17 +329,17 @@ static struct iio_channel *iio_channel_get_sys(co=
nst char
> > *name,
> > =C2=A0		return ERR_PTR(-ENODEV);
> > =C2=A0
> > =C2=A0	/* first find matching entry the channel map */
> > -	mutex_lock(&iio_map_list_lock);
> > -	list_for_each_entry(c_i, &iio_map_list, l) {
> > -		if ((name && strcmp(name, c_i->map->consumer_dev_name) !=3D 0) ||
> > -		=C2=A0=C2=A0=C2=A0 (channel_name &&
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(channel_name, c_i->map->consumer_cha=
nnel) !=3D 0))
> > -			continue;
> > -		c =3D c_i;
> > -		iio_device_get(c->indio_dev);
> > -		break;
> > +	scoped_guard(mutex, &iio_map_list_lock) {
> > +		list_for_each_entry(c_i, &iio_map_list, l) {
> > +			if ((name && strcmp(name, c_i->map->consumer_dev_name)
> > !=3D 0) ||
> > +			=C2=A0=C2=A0=C2=A0 (channel_name &&
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(channel_name, c_i->map->consumer_ch=
annel) !=3D
> > 0))
> > +				continue;
> > +			c =3D c_i;
> > +			iio_device_get(c->indio_dev);
> > +			break;
> This mix of continue and break is odd. But not something to cleanup in th=
is patch.
> It's based on assumption we either have name or channel_name which is che=
cked
> above.
> 			if ((name && strcmp(name, c_i->map->consumer_dev_name) =3D=3D
> 0) ||
> 			=C2=A0=C2=A0=C2=A0 (!name && stcmp(channel_name, c_i->map-
> >consumer_channel =3D=3D 0)) {
> 				c =3D c_i;
> 				iio_device_get(c->indio_dev);
> 				break;
> 			}
> is I think equivalent. Still too complex for this patch I think.
>=20
> > +		}
> > =C2=A0	}
> > -	mutex_unlock(&iio_map_list_lock);
> > =C2=A0	if (!c)
> > =C2=A0		return ERR_PTR(-ENODEV);
> > =C2=A0
> > @@ -469,7 +461,7 @@ struct iio_channel *iio_channel_get_all(struct devi=
ce *dev)
> > =C2=A0
> > =C2=A0	name =3D dev_name(dev);
> > =C2=A0
> > -	mutex_lock(&iio_map_list_lock);
> > +	guard(mutex)(&iio_map_list_lock);
> > =C2=A0	/* first count the matching maps */
> > =C2=A0	list_for_each_entry(c, &iio_map_list, l)
> > =C2=A0		if (name && strcmp(name, c->map->consumer_dev_name) !=3D 0)
> > @@ -477,17 +469,13 @@ struct iio_channel *iio_channel_get_all(struct de=
vice *dev)
> > =C2=A0		else
> > =C2=A0			nummaps++;
> > =C2=A0
> > -	if (nummaps =3D=3D 0) {
> > -		ret =3D -ENODEV;
> > -		goto error_ret;
> > -	}
> > +	if (nummaps =3D=3D 0)
> > +		return ERR_PTR(-ENODEV);
> > =C2=A0
> > =C2=A0	/* NULL terminated array to save passing size */
> > =C2=A0	chans =3D kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
>=20
> as below, consider dragging the instantiation down here and use __free(kf=
ree) for
> this
> plus make sure to return_ptr() at the good exit path.
>=20
> > -	if (!chans) {
> > -		ret =3D -ENOMEM;
> > -		goto error_ret;
> > -	}
> > +	if (!chans)
> > +		return ERR_PTR(-ENOMEM);
> > =C2=A0
> > =C2=A0	/* for each map fill in the chans element */
> > =C2=A0	list_for_each_entry(c, &iio_map_list, l) {
> > @@ -509,7 +497,6 @@ struct iio_channel *iio_channel_get_all(struct devi=
ce *dev)
> > =C2=A0		ret =3D -ENODEV;
> > =C2=A0		goto error_free_chans;
> > =C2=A0	}
> > -	mutex_unlock(&iio_map_list_lock);
> > =C2=A0
> > =C2=A0	return chans;
> > =C2=A0
> > @@ -517,9 +504,6 @@ struct iio_channel *iio_channel_get_all(struct devi=
ce *dev)
> > =C2=A0	for (i =3D 0; i < nummaps; i++)
> > =C2=A0		iio_device_put(chans[i].indio_dev);
> > =C2=A0	kfree(chans);
>=20
> Could use __free(kfree) and return_ptr(chans);=C2=A0 Not a huge gain thou=
gh
> so maybe not worth it.
>=20

I'll see how it looks like. Even though not a huge gain, I guess it makes t=
he code
more consistent as we move to the cleanup "idiom"...

- Nuno S=C3=A1=20

>=20

