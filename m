Return-Path: <linux-iio+bounces-26272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74014C65F57
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E43F4E89FD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C612C0294;
	Mon, 17 Nov 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EZ2yzndN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60D27B4EB
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407428; cv=none; b=fgEM9nC/RQ3mbox+3UD6dcNz+eGnimjS4kxRziX15Bq/vxgWkDfPA8S4AWWyffT2Hf+PQ+jyS6eNyMpOrgzdH+ZR4X9OvAeX0qOfsDzIu/CcJc+RZD1zckovV4Hx/7uA7LlHMtojiJghZfHW7lTY5QN0YIxaTQeWXv5fNYso9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407428; c=relaxed/simple;
	bh=sTgr/cCR5rQ198gvvRk9lbJy5qEfmwTEVsfJmE9BKcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAEC2GMBVgo9tOsCucgn0/y+5inYYKGWSJZUkNmV8Ek3g9V0LBjMpNK70KaOdOeupxBeQHbzqeOWS5Z2RHtobnaBBR309/AZxqKucYGcvxKRAqgxj76f5W8IY13IUbnE6JdTwDkeBefyjHZK0rM8Ps/+uI6r6U+jTqZBdeVXxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EZ2yzndN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b737502f77bso386992466b.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 11:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763407423; x=1764012223; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTgr/cCR5rQ198gvvRk9lbJy5qEfmwTEVsfJmE9BKcY=;
        b=EZ2yzndNWSBabbKhQcABup443id8g4V0OVTGM5+1YfAYV5KC8spm5weTlK4xsdm74y
         JD6NCfqCFKpvV2Hgb7M9kynHfv4GYqYSYGClvKz69PBRoRm+71KUGfEbiuDrcHYrIV0S
         MBVvicDXxcaaSHwNcFrFnbZwpS5AyLQQ6j7jsr3LFcVROIke4Ejxlapn4RgPFh/ng00/
         YbWLOkOr0qZ4t+/zw8AmZrQOt8otkg589at+Rq8FVmrpOeIlFfTBHR7sTR/Qjk0iCHB5
         6yUjdjE/ZS3SHZqNZ7zR/xKOofrGfnJAluJ2QMOYTZKSAOsqOVsLH6SakiXC1x+Ujvuh
         EADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763407423; x=1764012223;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTgr/cCR5rQ198gvvRk9lbJy5qEfmwTEVsfJmE9BKcY=;
        b=SSfAjV59Ea43lqHSlT6pH/nQEU3mMEpKPuk1PeDd31xlzjawFcvCeGOAKsGPxi3dx1
         TGiB5KCXJh1FQj8OQxhoVwnT9pFDGb9Ah6uJ3riULE+tddCxjSR7jnM15yFm4VPpFLnu
         Nz77XPrawtD7S4u4L1a/MsHwi1KbqAA5SqIwk6TNwVbCUsWC9fg1K3+OzXy9qbrCio2k
         Ftu3MUTV2D+7be2qww1P9rhF3y11DnFG5VL/4n0bWWdiZP0ztgFdlWxjCaN2c6i9buRR
         gDGsPK0Oc/cDC/vRqQ5Y/i/j6/ZReqqjR5m92wABCCY3Xs6VRi5NN6PDg363+AyM3anE
         CXnw==
X-Forwarded-Encrypted: i=1; AJvYcCW0FI5V0vPiAeS79Ah+GM1i6hE+lt5S5v09EMOAbqZlXLXwuRlexDXrVURKIgu92YKrER2rQiCIoY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4rXE9IW4FYPvDm8hym+poe/eja8RNaAfKuNt4Lv4ksv6vtND
	jSb3e/bVTDjtuEJldksn1U8nlVw+kzgjTuSruPBbm1cnZjj3Wqm+2h6tXivtADsHtig=
X-Gm-Gg: ASbGncvZYxpM8HeA9rYhSWFN6RROliNUcNXLh4GquICQiS4PFeo7wp/KHfF0wQY03j0
	6jY5d+9FUKjrXVf6HloHnXYUgner+EgAxdM944xP5wmBRfW+01Ek/l7lhsv1YUmKyb8pH2StkBx
	HPhTQlNSb5VPh3LxpZQsn/WjcvmrgwV6WXZtJAwOBcOk7NGrVDTTTi6v74gXNXg3UeObmkpuTbX
	Q+tH8STAcQ8XPrhUrYM2ii4bqARUTG96dUJ7omekv3Y5fQiP/eQJudOShc2i0D7Lr5Di0gWb3jn
	v0pIxWw/eg2U3Te1HjdrIVrRK53PZAAATbw7KdT6pbGEzTEY6ue+1uDbVUaESms1rDG617gXM+F
	KPgA6TIu63E96QZCt3sTe9tlHL8A0oqekctdky4x+LvP/yoetcXTOEH0cgVMXehdv/E/61uoROI
	8O7KAWOgMuIz8DFzTfZ0VcnH34TyUtJPCF4f9MvMtm+ojYYsoZx94Rw3Lgi0jE
X-Google-Smtp-Source: AGHT+IG+yiygqQm9CiObIS61IUqNuGkJpW3m2zFGp1F2YDfUOa+COxpnpwQncvBwCC8zgRehSyQj6w==
X-Received: by 2002:a17:907:1b14:b0:b73:8d2e:2d30 with SMTP id a640c23a62f3a-b738d2e3694mr664368966b.39.1763407423214;
        Mon, 17 Nov 2025 11:23:43 -0800 (PST)
Received: from [10.203.83.1] (mob-176-247-43-136.net.vodafone.it. [176.247.43.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fda8da2sm1120970666b.55.2025.11.17.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:23:42 -0800 (PST)
Message-ID: <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Nov 2025 20:23:35 +0100
In-Reply-To: <aQNueWesrf_vXO06@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-9-flavra@baylibre.com>
	 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
	 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	 <aQNueWesrf_vXO06@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LMDfikblbUQzONUIIIpj"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-LMDfikblbUQzONUIIIpj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra wrote:
> > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D hw->enabl=
e_event[event];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D state ? (=
old_enable | BIT(axis)) : (old_enable
> > > > &
> > > > ~BIT(axis));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!!old_enable =3D=3D =
!!new_enable)
> > >=20
> > > This is an interesting check. So, old_enable and new_enable are _not_
> > > booleans, right?
> > > So, this means the check test if _any_ of the bit was set and kept
> > > set or
> > > none were set
> > > and non is going to be set. Correct? I think a short comment would be
> > > good to have.
> >=20
> > old_enable and new_enable are bit masks, but we are only interested in
> > whether any bit is set, to catch the cases where the bit mask goes from
> > zero to non-zero and vice versa. Will add a comment.
>=20
> If it's a true bitmask (assuming unsigned long type) then all this can be
> done
> via bitmap API calls. Otherwise you can also compare a Hamming weights of
> them
> (probably that gives even the same size of the object file, but !!
> instructions
> =C2=A0will be changed to hweight() calls (still a single assembly instr o=
n
> modern
> =C2=A0architectures).

These are u8 variables, so we can't use the bitmap API. And I don't
understand the reason for using hweight(), given that the !! operators
would still be needed.

--=-LMDfikblbUQzONUIIIpj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkbdjcACgkQ7fE7c86U
Nl89Pgv+IELjf0J8E61Wde2AB7Nhrv3vDN2XuVUPNmjXu4mKEtJ0TZwI7dIblLMP
4aR06Mu7FinPtgV3Ks8WcETmJl8CU4XRc2/TesrTFQqoKjxrw6AwR5QS5d0imrwh
L43b05j7Z6UadnXP4AqIHns0PBWLNQiFFr4BEDcOv/hBpS58DlUbntoSZYJ3nqdr
KzX8GJ1EiqQuShUZeqVWF/Y1FMrS+CGg+XiU0Dv5gD0Xe2XNGAF6QOZGfUufbFXJ
vQWtohGsow7Prdxc5LUhE8/KpVcnfQjOnfAaDLRRDm6lInYljm1iGpybd9xJfLIK
FOPE/LwhGGwzEYqr95wBtvJF8mOVxnWoi8R0rL6b+xV4p6sLm9jVvnIciZT9ec81
elsm680NP2WyoIBJ0Bw0UFx4hVHP9O1v4cBF6UuHHrWP2nZ7IQrr/R9lM0vTA/6z
Mw77zajP867LjbNds95WnHo+G4rJltfJ+anohXFUi88uQlKooBSxlwCbp4lbhnIq
3YrXp7Qx
=g5jt
-----END PGP SIGNATURE-----

--=-LMDfikblbUQzONUIIIpj--

