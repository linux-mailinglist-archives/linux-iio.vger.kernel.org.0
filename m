Return-Path: <linux-iio+bounces-3581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4BB87E584
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0861F215C1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0528E2B;
	Mon, 18 Mar 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le02hEea"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06528E22
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753414; cv=none; b=h4mwHfkKxV7VCeS2wa1XOCjZKnsZ3W34Euqd1enUlEBxW5Sy8vlZem+imzasZB5iUWxHZdpqvyzviKNymgahRkkE/DYzzF6/D3qf6QLZU//Ms7kwmLncbd+SGgKDXoXELlL3maCigzT8ejNqA5WVWtYHYPGYnxMy+meYgiU4M+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753414; c=relaxed/simple;
	bh=BE2s4spaxz2JV5fG1hg+0xedY8C62gqs47KNuQ9Bj24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2ku+5rPJxmJtRaD5As5Luz4wm/Q03MFu2DWeFmu/2QiEwasfQoU64ecB+X2PDag812koAWhk23qYK1kLCxgN7mrAXlEdHaZF0LBARDBi4DeVuq3NhMYHcchV5pMjcFNEyc1ts7WIBLevN+xZCeCYNdJ73PpGR+OfzcuF4QnHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le02hEea; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e675181ceaso2359656a34.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710753412; x=1711358212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5l0x+oGJ/qn2zWLeEBYquAx/qYhFRQ2JoGZJ1DOKe/A=;
        b=Le02hEeari8ePooCXPbmtfQuvZ2BWNEJtBdL3qUfx8yCYpq6GM6MPgJizYuWTidW59
         9Yt/UhdiliSBmIfIX1FLXxRj7LbuUmTtFgN35gHI97checFxJbP+v6B6mMwm1kQcMKVG
         Np+5IGZvLQyR6gkqgH9pusxsVeU/zYV9ackG6QhJWhCdj3JdZKELm2VgCpLqFpmwRSvb
         I1xvkiUWrw7igDEfoKqMZjDugA/1HUGZWBm2WOVbu8rQd3qIzQXRpM+ugVpKlI0LcjfS
         PkqXvmzPGnGqt0YDrOBfJWZXOyteewc1qbfcMf0qgTPk2SWFox1xxSR3zxgOTbKthuu+
         Jg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753412; x=1711358212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5l0x+oGJ/qn2zWLeEBYquAx/qYhFRQ2JoGZJ1DOKe/A=;
        b=t5SrqNps+fSARigYrjBv1IsMtdkhrk/nv4oYo9m4PB+2naCbnySSxWAEX+TZ5qI0ut
         +0MPIIsV7hcSn7FGwBzFRUeeltML6hVn5fXKdYaQ1WrdBcbVOAfNGQeMQKk4iT28tKSk
         VrqONN69ZAbn1psSTmy9Ew6OCk79JhnwFj9f64d83rJCSD2nIHDMx85PiqJ6M20Eb4Ov
         HlEho8uZNxfy/ycOtU0mpOtUcLAKheeuFVeEi2QdouQM4k58fRpTDUFgIX3bMFtlBUY8
         xYM70jMfSno9fSH5rzaSPEG1quCzLQcSmE0Jf3bgb3Q5TGowG+FpESzP6IIfSfLxuiYY
         PBwg==
X-Gm-Message-State: AOJu0YyR8rzgHmsjObYUvqBRBxxi9aqafGmij7C2aobun3iJ9QKrJir7
	1atW8N45neWUn23FMUcY7yQ478GMjgfnookkKfvlOcicWEls4Z7b
X-Google-Smtp-Source: AGHT+IE1jmY2bXjrcEcbJCCW9jYx4vFbwlv0pWXfZGiPynf1uQnzSauZQX5mDCb4Db6AwJZYZ88Iew==
X-Received: by 2002:a9d:798f:0:b0:6e4:e1c2:9465 with SMTP id h15-20020a9d798f000000b006e4e1c29465mr10505686otm.4.1710753412059;
        Mon, 18 Mar 2024 02:16:52 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id gf8-20020a056214250800b00690f8192656sm5073100qvb.112.2024.03.18.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:16:51 -0700 (PDT)
Message-ID: <6de1c271b3e4bee83e858141d6e22d5c12024458.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen
	 <lars@metafoo.de>
Date: Mon, 18 Mar 2024 10:20:17 +0100
In-Reply-To: <ZfX3gnbwYcZlGpBq@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	 <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
	 <ZfX3gnbwYcZlGpBq@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-16 at 21:48 +0200, Andy Shevchenko wrote:
> Thu, Feb 29, 2024 at 04:10:28PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > While at it, also use __free(kfree) where allocations are done and drop
> > obvious comment in iio_channel_read_min().
>=20
> ...
>=20
> > =C2=A0int iio_map_array_register(struct iio_dev *indio_dev, struct iio_=
map *maps)
> > =C2=A0{
> > -	int i =3D 0, ret =3D 0;
> > +	int i =3D 0, ret;
> > =C2=A0	struct iio_map_internal *mapi;
>=20
> Why not making it reversed xmas tree order at the same time?
>=20
> > =C2=A0	if (!maps)
> > =C2=A0		return 0;
>=20
> ...
>=20
> > -error_ret:
> > -	if (ret)
> > -		iio_map_array_unregister_locked(indio_dev);
> > -	mutex_unlock(&iio_map_list_lock);
> > =C2=A0
> > +	return 0;
> > +error_ret:
> > +	iio_map_array_unregister_locked(indio_dev);
> > =C2=A0	return ret;
> > =C2=A0}
>=20
> Do we really need to split this? (I'm fine with a new code, but seems to =
me as
> unneeded churn.)
>=20
> ...
>=20
> > +	struct iio_channel *channel __free(kfree) =3D
> > kzalloc(sizeof(*channel),
> > +							=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>=20
> I would indent a bit differently:
>=20
> 	struct iio_channel *channel __free(kfree) =3D
> 					kzalloc(sizeof(*channel),
> GFP_KERNEL);
>=20
> (maybe less TABs, but you got the idea)
>=20
> > =C2=A0	if (!channel)
> > =C2=A0		return ERR_PTR(-ENOMEM);
>=20
> ...
>=20
> > +	struct iio_channel *chans __free(kfree) =3D kcalloc(nummaps + 1,
> > +							=C2=A0 sizeof(*chans),
> > +							=C2=A0 GFP_KERNEL);
>=20
> Ditto.
>=20
> > =C2=A0	if (!chans)
> > =C2=A0		return ERR_PTR(-ENOMEM);
>=20
> ...
>=20
> > =C2=A0	/* first find matching entry the channel map */
> > -	mutex_lock(&iio_map_list_lock);
> > -	list_for_each_entry(c_i, &iio_map_list, l) {
> > -		if ((name && strcmp(name, c_i->map->consumer_dev_name) !=3D
> > 0) ||
> > -		=C2=A0=C2=A0=C2=A0 (channel_name &&
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(channel_name, c_i->map->consumer_cha=
nnel) !=3D
> > 0))
> > -			continue;
> > -		c =3D c_i;
> > -		iio_device_get(c->indio_dev);
> > -		break;
> > +	scoped_guard(mutex, &iio_map_list_lock) {
> > +		list_for_each_entry(c_i, &iio_map_list, l) {
> > +			if ((name && strcmp(name, c_i->map-
> > >consumer_dev_name) !=3D 0) ||
> > +			=C2=A0=C2=A0=C2=A0 (channel_name &&
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(channel_name, c_i->map-
> > >consumer_channel) !=3D 0))
>=20
> I would kill these ' !=3D 0' pieces, but I see they are in the original c=
ode.
>=20
> > +				continue;
> > +			c =3D c_i;
> > +			iio_device_get(c->indio_dev);
> > +			break;
> > +		}
> > =C2=A0	}
>=20
> ...
>=20
> > -	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> > +	struct iio_channel *channel __free(kfree) =3D
> > kzalloc(sizeof(*channel),
> > +							=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>=20
> Indentation?
>=20
> ...
>=20
> > -error_no_chan:
> > -	kfree(channel);
> > =C2=A0error_no_mem:
> > =C2=A0	iio_device_put(c->indio_dev);
> > =C2=A0	return ERR_PTR(err);
>=20
> Effectively you move kfree after device put, would it be a problem?
>=20

This one got my attention... But I think we're fine. But yeah, subtle order=
ing
change that I did not unnoticed.

- Nuno S=C3=A1



