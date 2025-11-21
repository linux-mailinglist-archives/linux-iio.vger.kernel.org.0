Return-Path: <linux-iio+bounces-26365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9656AC7A66B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 850654F2A36
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E0314D31;
	Fri, 21 Nov 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AnzW3Nvl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1462BE7AC
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737090; cv=none; b=bGSTGImYEuChgrJSWsNPHHM06k/ctn64jpGzG+JSw7/Mty6hDPw3AOFwCkak+vPdZ7TIpqRt2VZHBxQJ0wngPJVlYF2DWMKPEGG2yBMrYmSXdwPjfY2l+K5yF1BId8WSXtmfhf7FTBTZJV810mmvRhumMpTwIPh4cef504167Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737090; c=relaxed/simple;
	bh=ZBN61/kQgi5/O9/msU05a3+8B53ER6SruttjusNlF1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLZX3vbsi0yJYSbz7gfrRkxe/WhmyIURDT0LIVgNIhqz8WmTV3YPVpRctpTaXYJgjFUlXlVp/i+txHzWoaaUw9Bjf9cFTP5umI36aas3d0QEtA6+C9Y2lCoj+4wy0SwPP5Qv6sZG/q4ryhptWVCFNAnCQxNO+QoPEcMaIStD3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AnzW3Nvl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so22838755e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763737084; x=1764341884; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBN61/kQgi5/O9/msU05a3+8B53ER6SruttjusNlF1E=;
        b=AnzW3NvlTtIwF/7+JGyHBOaPjEup9QOL7+mHXyz1cThS+F2GlCjpy6MxHVC+BnDqVa
         hc/qq+/r3kcqehs8ocKeLtMR0b23Ow4Av93TMQWzgiIUB13QC2H1sO0heodMF9jSe4AP
         inVoteKulwn78IR8LoWjqDBc3iF8OO6fTVtv42JM5vwM9LHGpVv3Qm4l+yuMYG5dYGkp
         Qb9OWISDnjMV1gsE2d2CiIoRTMl9omA4qHdqt6AV9U1gPZZiAymm910dA8eh+LKZ/piV
         lqgfFU+uCSx6xY7d5MEztoyozhWFhhS+3D16BqFYGW1GrmnUon63Ts1iu0dUG1qrRkDr
         eZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737084; x=1764341884;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBN61/kQgi5/O9/msU05a3+8B53ER6SruttjusNlF1E=;
        b=Wf4rXag/RSAfQlZ9WZbtgHajJnqQ/Iuz+GrvIYdXa9+Ql1xKxfQqywXM+JwjwrTqfk
         zX403JEDyqbpChXkuh1HXPpjqe7X5WG7nsPOBT+A6y2MtiDHeUHhMBcTM1Kge5rRGJwM
         Owm3PVg3B9DKAy4yYPxyQv79XsT/pJ3U8OqRGMVMSM0e5fP+Ry+84rEZDgltXE5p26sR
         qkTzpG4/SMmX4rz3pGWgjqtjOhcBbT5adp9iAd+1V4g/kDUZ0Umksjj7y4eUMPj4o/B4
         I3NqSJhUp6aWAf3YJJlC4YFvuj37W1B/72Y9zVN3bEzRYTJd6ZMiRiLGUH1JI2hITCP/
         9VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvo+0NwssoJsOvrbVdAMPQ7uWmP09yuvhLIFGP4psW5uui0VFoQIFX5W4ShxpYcDd08OywYMT2x0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOlKaRG0BOXOOfgYbDlSbd5L9C/R1Or+9/apzBN+7RstT25To
	K5BKjD5qKfNJ5vHZNJ5oFoT4lL+QePSK9CxZDDg8p/s3Ze6zFM42x5kHOLeBc7ku5Cvyjspd9AP
	Z8X27
X-Gm-Gg: ASbGncs/Zv7gnFHB0gB5WFmJ4iP+cV/IhxPZy8Wn2eTJcFwdo/ELHAUpb0HGGVDVVPm
	xetZGIrw3X6cGGjRTKqSYuy6gGzuQATMvdEbbXfFU8xF9UvBtPTdBFbrGf7BqV7SfXnfNUQdYpZ
	BW5YP3/rYRcvhXjelPz5S/d8qb3JV8y589ZehRoC93miweXs9jgDvxO+4Kt0STJWRU5FGmQAeel
	cwzZn4nnvnBFGZi0biQ96cAZfLXTC1CyfTqNIjSO8TLs+towPpDEwM3ksPraLPt7LN+kNiIUkL0
	olPQX4GCqvDnPESwKaOYaJkZzoGutcf+qUA9dfvIjeQFYI7PJBHQsISCSlrQt//efnYn9HCQ2ox
	kYPWZ5TFqPno9Su81C52l5+7NQJ1spPnrmPood1Al6QzOK+8R8IDQdX9oNbM51TnmIFc4NLA=
X-Google-Smtp-Source: AGHT+IGpWdALqr4BOZVBJ9KeilEj1y1TqBHHrSujBbNxo4Jd3S+sPXH1zq/HRufezIXorjDTGTAZwA==
X-Received: by 2002:a05:600c:1f1a:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-477c114f45fmr25825615e9.28.1763737083994;
        Fri, 21 Nov 2025 06:58:03 -0800 (PST)
Received: from [10.203.83.225] ([151.37.150.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22ea00sm47639735e9.14.2025.11.21.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:58:03 -0800 (PST)
Message-ID: <0da1f46640226ab52ef0a726a5110cc56b85cdd4.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 21 Nov 2025 15:57:57 +0100
In-Reply-To: <aSAxjBCfiw-iCWhI@smile.fi.intel.com>
References: <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	 <aQNueWesrf_vXO06@smile.fi.intel.com>
	 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
	 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
	 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
	 <aR7Z19wgPksymwkw@black.igk.intel.com>
	 <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
	 <aR8esn94zI140351@smile.fi.intel.com> <aR9ej_7o0te-HO8P@smile.fi.intel.com>
	 <e448a6fdb420b0c0561ab2255820d2ba62f838a1.camel@baylibre.com>
	 <aSAxjBCfiw-iCWhI@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/TigasTORFHwyr9i7yRy"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-/TigasTORFHwyr9i7yRy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-11-21 at 11:31 +0200, Andy Shevchenko wrote:
> On Fri, Nov 21, 2025 at 10:14:06AM +0100, Francesco Lavra wrote:
> > On Thu, 2025-11-20 at 20:31 +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 20, 2025 at 03:59:18PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 20, 2025 at 12:43:09PM +0100, Francesco Lavra wrote:
> > > > > On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote:
> > > > > > On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra
> > > > > > wrote:
> > > > > > > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > > > > > > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra
> > > > > > > > wrote:
> > > > > > > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > > > > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco
> > > > > > > > > > Lavra
> > > > > > > > > > wrote:
> > > > > > > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko
> > > > > > > > > > > wrote:
> > > > > > > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco
> > > > > > > > > > > > Lavra
> > > > > > > > > > > > wrote:
>=20
> ...
>=20
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_en=
able =3D hw->enable_event[event];
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_en=
able =3D state ? (old_enable |
> > > > > > > > > > > > > BIT(axis))
> > > > > > > > > > > > > :
> > > > > > > > > > > > > (old_enable
> > > > > > > > > > > > > &
> > > > > > > > > > > > > ~BIT(axis));
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!!=
old_enable =3D=3D !!new_enable)
> > > > > > > > > > > >=20
> > > > > > > > > > > > This is an interesting check. So, old_enable and
> > > > > > > > > > > > new_enable
> > > > > > > > > > > > are
> > > > > > > > > > > > _not_
> > > > > > > > > > > > booleans, right?
> > > > > > > > > > > > So, this means the check test if _any_ of the bit
> > > > > > > > > > > > was
> > > > > > > > > > > > set and
> > > > > > > > > > > > kept
> > > > > > > > > > > > set or
> > > > > > > > > > > > none were set
> > > > > > > > > > > > and non is going to be set. Correct? I think a
> > > > > > > > > > > > short
> > > > > > > > > > > > comment
> > > > > > > > > > > > would be
> > > > > > > > > > > > good to have.
> > > > > > > > > > >=20
> > > > > > > > > > > old_enable and new_enable are bit masks, but we are
> > > > > > > > > > > only
> > > > > > > > > > > interested
> > > > > > > > > > > in
> > > > > > > > > > > whether any bit is set, to catch the cases where the
> > > > > > > > > > > bit
> > > > > > > > > > > mask
> > > > > > > > > > > goes
> > > > > > > > > > > from
> > > > > > > > > > > zero to non-zero and vice versa. Will add a comment.
> > > > > > > > > >=20
> > > > > > > > > > If it's a true bitmask (assuming unsigned long type)
> > > > > > > > > > then
> > > > > > > > > > all
> > > > > > > > > > this
> > > > > > > > > > can be
> > > > > > > > > > done
> > > > > > > > > > via bitmap API calls. Otherwise you can also compare a
> > > > > > > > > > Hamming
> > > > > > > > > > weights of
> > > > > > > > > > them
> > > > > > > > > > (probably that gives even the same size of the object
> > > > > > > > > > file,
> > > > > > > > > > but
> > > > > > > > > > !!
> > > > > > > > > > instructions
> > > > > > > > > > =C2=A0will be changed to hweight() calls (still a singl=
e
> > > > > > > > > > assembly
> > > > > > > > > > instr on
> > > > > > > > > > modern
> > > > > > > > > > =C2=A0architectures).
> > > > > > > > >=20
> > > > > > > > > These are u8 variables, so we can't use the bitmap API.
> > > > > > > >=20
> > > > > > > > OK. But hweight8() can still be used.
> > > > > > > >=20
> > > > > > > > > And I don't
> > > > > > > > > understand the reason for using hweight(), given that the
> > > > > > > > > !!
> > > > > > > > > operators
> > > > > > > > > would still be needed.
> > > > > > > >=20
> > > > > > > > No, you won't need !! with that.
> > > > > > >=20
> > > > > > > I still don't understand. Are you proposing to replace `if
> > > > > > > (!!old_enable =3D=3D
> > > > > > > !!new_enable)` with `if (hweight8(old_enable) =3D=3D
> > > > > > > hweight8(new_enable))`?
> > > > > > > That won't work, because we only need to check whether the
> > > > > > > Hamming
> > > > > > > weight
> > > > > > > goes from zero to non-zero and vice versa.
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_enable =3D hw->enable_=
event[event];
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_enable =3D state ? (ol=
d_enable | BIT(axis)) :
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (old_enable & ~BIT(axis));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!!old_enable =3D=3D !!=
new_enable)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > >=20
> > > > > > If I am not mistaken this will do exactly the same in a simpler
> > > > > > way.
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D =
hw->enable_event[event];
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable | BIT(axis);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable & ~BIT(axis);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((new_enable=
 ^ old_enable) !=3D BIT(axis))
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > >=20
> > > > > This doesn't look right to me, if new_enable differs from
> > > > > old_enable
> > > > > by
> > > > > just one bit (which it does), then the XOR result will always
> > > > > have
> > > > > this bit
> > > > > (and no others) set, so (new_enable ^ old_enable) will always
> > > > > equal
> > > > > BIT(axis).
> > > > > We are not checking if the bit was already set or clear, when
> > > > > this
> > > > > code
> > > > > runs we already know that the bit is changing, what we are
> > > > > checking
> > > > > is
> > > > > whether all bits are zero before or after this change.
> > > >=20
> > > > The check I proposed is to have a look for the cases when
> > > > old_enable
> > > > was 0 and
> > > > the BIT(axis) is set and when the BIT(axis) was _the last_ bit in
> > > > the
> > > > mask that
> > > > got reset. If it's not the case, the code will return 0. I think my
> > > > check is
> > > > correct.
> > > >=20
> > > > Should I write a test case?
> > >=20
> > > FWIW,
> > > https://gist.github.com/andy-shev/afe4c0e009cb3008ac613d8384aaa6eb
> >=20
> > The code in your gist produces:
> >=20
> > Initial event: 0x92, new state: True for bit 0x20
>=20
> Initial event is 10010010b, we assume that we got in the code when
> required
> state is to 'set' (True) with axis =3D 5 (means 00100000b when powered).
>=20
> The [-] are special cases just to show the algo.
>=20
> > [-] 0x00 | 0x20 --> 1: handle
>=20
> If initial event is 0 we handle
>=20
> If _after_ that the bit 5 set (which is NOT the case in _this_
> iteration),
> we will stop handling.

We have to stop handling not only if bit 5 is set, but also if any other
bit is set after that.

> > [0] 0x92 | 0x20 --> 1: handle
>=20
> So, it's again step 1. I _assumed_ that your code works and sets the bit.

Even if it's again step 1, this is not supposed to be handled, because
there are bits already set in the current bitmask.

Enabling an event source for an axis may need two registers to be set:
1) an axis-specific enable register
2) an event-specific enable register (global for all axes)

If no events are enabled on any axis, when we enable the event source for
axis X, we have to do both steps above; if then we enable the same event
source for axis Y, we have to do just step 1 but not step 2; and that's
what the (!!old_enable =3D=3D !!new_enable) check is supposed to do: to che=
ck
if, after setting the axis-specific enable register, we have to set also
the event-specific enable register. If I replace that check with
((new_enable ^ old_enable) !=3D BIT(axis)), then I'm doing both steps for
every axis, which is unnecessary when enabling the event (because we don't
need to set again the event-specific register after we set it for the first
axis), and is wrong when disabling the event (because disabling the event
for a single axis would inadvertently disable it globally (i.e. for all
axes).


--=-/TigasTORFHwyr9i7yRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkgffUACgkQ7fE7c86U
Nl9szgv+LKhxgC+3fxp0jw/GnRB32LR5SN9ZJD2dVgU6VQ5PQXmjChx2HhsKnfYs
jRxfYE5UkEgifgKva2ohC/z/3+XkZxKDYnOH0KGixmJuAipDUJzdSugGb1upeArT
D7I3eFEdNKmyB6SaXenhbWWEg8NsWTcGQxt/qk6qEJnlj4R+DMMw4ATMPg89b9mu
Pnm+yMK3DoQQrGaQvDhzVr2k5qk0abjeCLB04TRn46qc9P58jGo9qm0bqOpfLznb
jFWLXYxXLgW3yqw12tDaSaCFvGvXimfNxGCW7CqCotAU6w1H7PVdQtVt4kUGe3C3
xSmS3TaK73XCWtNXx5oQWdQwZza+c6RlzPAs9+awoZxK4baMGf10XbxVr83E+Iy5
R+xq0R9oFzvsAcpt+2cvlNrK8dvnDhKOTBYwvhjUK+tqWEdXRqOJjqBNUBqc0Vl4
IPiZNE4dcWoBpI72WgWoi0Ap0EFaavKJC/nVsd2qWoXFe28K2VIel7ApFYpxATtd
QG9CQdDN
=qgju
-----END PGP SIGNATURE-----

--=-/TigasTORFHwyr9i7yRy--

