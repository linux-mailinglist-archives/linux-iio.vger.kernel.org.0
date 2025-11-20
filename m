Return-Path: <linux-iio+bounces-26341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB13C73C92
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABB083446AB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2828329386;
	Thu, 20 Nov 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T26NRPx1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD6F513
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639000; cv=none; b=hh47ZT/dcPnlxQsw9fF2e2dOjOc8BNt+bQtcCtKjEptTdha1IcYOmGRnpSHmlLzJ+r4LduBAZp9W8+VE6NW3QblpguvNvIrX+akqs997q1x6BX3xQhY5Hia1n91WCWZb59TtVP4wG377QfCtGnQBtLN3bW9o7f7QY3BxYKksPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639000; c=relaxed/simple;
	bh=xa59kuPUNpKkvvjKOuQWAuMlmxeDYgsH8/Ee352z66I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA2BdYUCa+L2u7SDuXvLPPgZKFtQAfNQB3/ktHxZAahEunwIb1tM120yau8wRQWvdU7ZEW0xHBbba/Vxp6GGwM5nf+vjguYStTeRG9kXChShwNJlmASX1guWAVWrtDopYBe4OaWgO6fAezQCj2Odm2n8pZYn72z3jbgLXOZM544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T26NRPx1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so8662385e9.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 03:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763638995; x=1764243795; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa59kuPUNpKkvvjKOuQWAuMlmxeDYgsH8/Ee352z66I=;
        b=T26NRPx19Gq7mBcZQ5ukmceLHfsN8wgiqHNE/yVpzLWKAWVkpFCIwJxhYsOv61Eczp
         mCe+oD+hscJaSef3/2gQeDLzNNaNvw8PKC+uQ4RakGNrr8Y9K3c0K/uI+Z3JYTdQChI9
         LCRCvWeztbwx+ZEyaq5XIF+e670Myln9KASmFi8S9qGrqPxOrCXVwI2eswuqpsvWT3KE
         QaKytvlBBg98yYEf3neUTJHoQrTvf4kIQcdPlZBxThaHqQfETfcGWVacA4Yz+Bezae5k
         bajdO4KeWMFGm5hMEtk3/2sTg698zfU7SmZomUatlrbNF8NzltnKAoci39SlrM6FgmtP
         Yfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763638995; x=1764243795;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa59kuPUNpKkvvjKOuQWAuMlmxeDYgsH8/Ee352z66I=;
        b=NQJRMRXSC9aKlTQcT/lCntRYSkJNHpSmmEMyDZkxCKtXpmIU1m5kfSNjVHc30lQ986
         LDpP9kxKBOWYVSf22yJlW3kOCg7zQl6nYMw/LXLytCQAS+d0JKps3hmD1+lo2+f893w+
         rWzBRJZvzO6x9q8pKuiWHwCca6rVymPAtWsCMw3+Wpf6kLJ/azl54fuxMWg8D4DPxiq9
         cDtI6w00HJ3HPBD3GAAW1haq5/JSZLCkZYU3aCsGSViF1oJoyiV0NE+VvyLBKBiHYj1V
         L7xheVptmmUveveHT9tEoC9MXmLbHghGCnoIPkWFFdNzq5QTi3rIybc+A3RvpYtwIBK1
         iWfA==
X-Forwarded-Encrypted: i=1; AJvYcCX3iBzJPVol3S06fHVnTRu66/UQjZ84NrTq59+fDn+z8CLDKdBWN4IvC3ZhF++/BIvfQELbuNcGGyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wITo+zazaGqgsWaSYwJ/I5tzSReI3aNvkMI8BVFxV0bdKU25
	t4R7LMMokyHO9XJQmZBlI1SRAHuycYdum0CmN2iMNPQmnLD2uP6VM/FHb0nkev+VCfo=
X-Gm-Gg: ASbGncvwUR4RN9s0ofVfiyUryU8uUhNuwYAhciyEk39X21Eb1uCxBqS/z/rJ0iB+fHZ
	+rWpq4oDx6P8Pywi+WWvJT9OdqxyYKIoYu+nbKwbT88/mrNBGisxeb0eub+yTpubJxMz7DlwDMz
	r7Fs13S9UMgWPpEpdIHJ8R2Z0sqjftI8OTwNoGx8/jVLqfqph3fgAJsPTi5E2ZMHvzL5Lx3pgr7
	jIevquH3uhuh2o+0wSm/YVGTfocjrFGe6YXgoLydwVyVJBSP85O1qNJennLPVzYXSbVIj77AyyK
	ntUoglkVR5crY4B9mcpD0p+D/qhSzULEI2wEwgrUz+KOy+zSHrHEE8y0B7Cdf1cQBjnPVbSXlK3
	dbSqkXMXTm+DdlVGHlIZKaY1JH2sivQgbb24XWugbIAGVMevuYQ7Q2y4TW4FS8ztL/jih
X-Google-Smtp-Source: AGHT+IGfI6DW67Mb09pvyI4K4LXeoJ5qIjMacy7WgY5onPltVyo46Dt0Qy2AB1yeoj383xHFcRbZbA==
X-Received: by 2002:a05:600c:c492:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477b8d8f05bmr28214605e9.35.1763638994625;
        Thu, 20 Nov 2025 03:43:14 -0800 (PST)
Received: from [10.203.83.45] ([151.35.142.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82d8023sm44808915e9.4.2025.11.20.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 03:43:14 -0800 (PST)
Message-ID: <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 20 Nov 2025 12:43:09 +0100
In-Reply-To: <aR7Z19wgPksymwkw@black.igk.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-9-flavra@baylibre.com>
	 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
	 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	 <aQNueWesrf_vXO06@smile.fi.intel.com>
	 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
	 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
	 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
	 <aR7Z19wgPksymwkw@black.igk.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GJDC4zqvByph2/4pxtOy"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-GJDC4zqvByph2/4pxtOy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote:
> On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra wrote:
> > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra wrote:
> > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra
> > > > > > > wrote:
>=20
> ...
>=20
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D h=
w->enable_event[event];
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D s=
tate ? (old_enable | BIT(axis)) :
> > > > > > > > (old_enable
> > > > > > > > &
> > > > > > > > ~BIT(axis));
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!!old_enable=
 =3D=3D !!new_enable)
> > > > > > >=20
> > > > > > > This is an interesting check. So, old_enable and new_enable
> > > > > > > are
> > > > > > > _not_
> > > > > > > booleans, right?
> > > > > > > So, this means the check test if _any_ of the bit was set and
> > > > > > > kept
> > > > > > > set or
> > > > > > > none were set
> > > > > > > and non is going to be set. Correct? I think a short comment
> > > > > > > would be
> > > > > > > good to have.
> > > > > >=20
> > > > > > old_enable and new_enable are bit masks, but we are only
> > > > > > interested
> > > > > > in
> > > > > > whether any bit is set, to catch the cases where the bit mask
> > > > > > goes
> > > > > > from
> > > > > > zero to non-zero and vice versa. Will add a comment.
> > > > >=20
> > > > > If it's a true bitmask (assuming unsigned long type) then all
> > > > > this
> > > > > can be
> > > > > done
> > > > > via bitmap API calls. Otherwise you can also compare a Hamming
> > > > > weights of
> > > > > them
> > > > > (probably that gives even the same size of the object file, but
> > > > > !!
> > > > > instructions
> > > > > =C2=A0will be changed to hweight() calls (still a single assembly
> > > > > instr on
> > > > > modern
> > > > > =C2=A0architectures).
> > > >=20
> > > > These are u8 variables, so we can't use the bitmap API.
> > >=20
> > > OK. But hweight8() can still be used.
> > >=20
> > > > And I don't
> > > > understand the reason for using hweight(), given that the !!
> > > > operators
> > > > would still be needed.
> > >=20
> > > No, you won't need !! with that.
> >=20
> > I still don't understand. Are you proposing to replace `if
> > (!!old_enable =3D=3D
> > !!new_enable)` with `if (hweight8(old_enable) =3D=3D
> > hweight8(new_enable))`?
> > That won't work, because we only need to check whether the Hamming
> > weight
> > goes from zero to non-zero and vice versa.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_enable =3D hw->enable_event[even=
t];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_enable =3D state ? (old_enable |=
 BIT(axis)) :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (old_enable & ~BIT(axis));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!!old_enable =3D=3D !!new_enable=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
>=20
> If I am not mistaken this will do exactly the same in a simpler way.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D hw->enable=
_event[event];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable | BIT(axis);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable & ~BIT(axis);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((new_enable ^ old_ena=
ble) !=3D BIT(axis))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;

This doesn't look right to me, if new_enable differs from old_enable by
just one bit (which it does), then the XOR result will always have this bit
(and no others) set, so (new_enable ^ old_enable) will always equal
BIT(axis).
We are not checking if the bit was already set or clear, when this code
runs we already know that the bit is changing, what we are checking is
whether all bits are zero before or after this change.

--=-GJDC4zqvByph2/4pxtOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmke/s0ACgkQ7fE7c86U
Nl+0Owv9Fd6Xltaw6zl0SO6umBIDy7yyYmxsUv3ilrrapjWyIO6Z1lpvADYrCf9H
Kv+7PXPN/gQI47gZU9Dk6AA7AcLyi1khlED08BtbsZg60pJAd5snGcZYVhFojJBN
opQ7wW2WpMgMthG/q9de0Kn64vCzTOm5JG9mmu9EbHTZ8zU1K/5lTLPoCPo0DVDM
1462W9JKjUUQm7Xj8F5V7gg2w/byvlfIt5k8ipsEP+5J6egZGQlE5yz/3VgSOVcl
wo1MUsgis575CIFbXnhhzyEXX6/1VC0z/agyVum7uJlTCoxptj2m87ncFkzPx40E
7XKX+ky7vS076IVfeN2ovk1Zt3yFZHXX39Iw0WW9siUMNfKUR6S6ObFwN2QYJqgv
T+murnhgeDTVK5LpmpgH9cDO6G+CQGxEQLWSHopRbh6vEhjBMWMAkh/pEwxmY8Xr
G180UOzjJVscqpqmpMCvgaxco7RMeuBjNZxhLlDUTSsUIdLQNefpk4L5sUWImBRU
onk+7iXH
=WtqX
-----END PGP SIGNATURE-----

--=-GJDC4zqvByph2/4pxtOy--

