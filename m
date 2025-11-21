Return-Path: <linux-iio+bounces-26352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E257C7814C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9937A4EA380
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E633EAF8;
	Fri, 21 Nov 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hR/XHQOW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31928339B53
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716457; cv=none; b=NgihQJ4WELUyx98PV0v5R8matUZLhVsEozfyiLSVEHt0eMODcHwi1tCRBwQ1cMDifGc/S0GDS9RBi8DZJuywnrHGKCMvHoYuBycQBEke+JNSD1I1QMRvVTixTbSa0dJFja/cKkUY2oRpWLsCfoQfbBEGIWiFuGU1fUwz/X+jowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716457; c=relaxed/simple;
	bh=1Cad4Yu7sxw2yU1HvK2lu14O1FOytLHWk5gMsFz2OzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaPjzLMesQIlhEYe+XjwjCEG4ueaZihGWPWwSVtihOWhYeEzsNUNq2xfoZQhMPCv7Zcq9DDRIIDgYZbfDwZgYK4cx/JhlDoEYrpBFf7or5SSuNRGRdwuLErYaziJSR3cJzFWuNSDhyV4PswhaufKsq7cbL9y+7J/9jZNrhPGfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hR/XHQOW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso1479692f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 01:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763716453; x=1764321253; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Cad4Yu7sxw2yU1HvK2lu14O1FOytLHWk5gMsFz2OzM=;
        b=hR/XHQOWrTUmXdrJ8v8iIkfllE50OZkuPKVtphpwc2cdyEelLP00EWLHDzks3csaZQ
         4b6vh5y7ypwvm1vlFDMb+lXPXrwMJbcIzFulluGsFW+PFMKqqpGYyPKbWxTcNDBhIpyl
         mxONeJECYt7+c2gb8sd+fsRNWhhp25B9qgfU4sn/uZlcAF2TVzukTcd8DE1YPWenc6HV
         1MrS64Fa9djtWWlVpfnzzy+cpB+ebDWNVXUbE0MxkhlSnwl3kGNtTpfwTtbOwCLU6a8t
         v2jfDV9QwMo4ychY5piK1VTKGVw2oJcL8poTzQRY6NOIWWBQ7WQ039tEueODmxB/dmdF
         cVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716453; x=1764321253;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Cad4Yu7sxw2yU1HvK2lu14O1FOytLHWk5gMsFz2OzM=;
        b=Clh5smyVmpzGmct66eKOgGQ5DoHxQp5SOGfVU2fM6K7S03CZj0224I9mrkU/JME9dM
         QqMHb4B6MiMoXwT1rFh5LfYMtDTDZ6x3CvLfZXwGOTmFybtblEMWjrdchOJdZeEHoSKg
         4prU82OMquVIhWWd6Cfn+9SCiPDPQ+pmFrEqjddOo+ScZHO63l/jPIvl6J6yI0AxY+Io
         kJoLS93Bu8CByTB5jZZ8ivFWRUn2Qe5oC0Xf7zRpKx09Kf3RvPGpylXU0H19sbgYvCRS
         tJVjcQoUOOOfo5S/ReHIDs5MlpSFGcM927X3hV8/q9ArN6wlkO7ve0xgdVHzs5NIGkyh
         2aUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9unN4wR2f2m4GhzcGcosxCOFFSUpSILlOaQv2A5EdIrOe/XXY5rVmCtt9uFxIvve4UFvaM2a/ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxZxERYG9xZUqEovt8sT9rs1x3al4asr9mqxnQNXg2uY/RXL9
	9HyMSs4mqejY5YrEGROcI6Us+ORFCRyd6cvFDC9fSPQzjaiwgksrSLciiQ4lXFnVHXh4omQgZA4
	HbhsE
X-Gm-Gg: ASbGncv9SrCOO426sGPsrBtgvozOz5XuzcEOXPUnLT11dV5NB945gpZE6aa7F3Amvzh
	cBIAE06oV1p/LeV+GuXq75OnCX5WwtNk1ke9EIv4qhAOcfnXD1V9vIAQKtkraed8fP1kGaL02jC
	kTO884ptK2Gj9jnAqqO8/Kcrrcvn0iMqObsaTvSlCZSTfhcICNtIrL5jqr9R7bQWhLA5IcK3JtT
	Qmtr50/r8zs5yj9FZ98TMzWsyvehzr2h82wEpglakLvU8o3sIxD7iT11l8RB05uxYWlo2TI3+qO
	Sz9FYQzdQTdvPefVaApl7+OR/wS+YP9DXyTUqMfU+HGzwJYlTsuXX6X+CayP5vZrSCh53/GQvXg
	M5vV9E1MOeWOU08uMSw/7tdg/2eLGlQADAKvS0GzCkBqNPg6FC2MnKzErvxpQp4IGOV9FQNs51h
	DL9Wcky0q9ogvVBQ==
X-Google-Smtp-Source: AGHT+IF9C1z74yl1sSJHydBt4B4BwcMPHGHILNFAg/vkmACHM/u3tnCTEIMtoF3jGucjxVM+AFMbkQ==
X-Received: by 2002:a05:6000:2411:b0:42b:3a84:1ee1 with SMTP id ffacd0b85a97d-42cc1cbd1f6mr1434468f8f.18.1763716453421;
        Fri, 21 Nov 2025 01:14:13 -0800 (PST)
Received: from [10.203.83.154] ([151.37.169.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm9815487f8f.18.2025.11.21.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:14:12 -0800 (PST)
Message-ID: <e448a6fdb420b0c0561ab2255820d2ba62f838a1.camel@baylibre.com>
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 21 Nov 2025 10:14:06 +0100
In-Reply-To: <aR9ej_7o0te-HO8P@smile.fi.intel.com>
References: <20251030072752.349633-9-flavra@baylibre.com>
	 <aQMgxUNA8XNhPZdG@smile.fi.intel.com>
	 <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	 <aQNueWesrf_vXO06@smile.fi.intel.com>
	 <5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
	 <aRxN_Gnsl0qq8wDn@black.igk.intel.com>
	 <82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
	 <aR7Z19wgPksymwkw@black.igk.intel.com>
	 <50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
	 <aR8esn94zI140351@smile.fi.intel.com> <aR9ej_7o0te-HO8P@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZIeMP/I06AU+I7WukbTm"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZIeMP/I06AU+I7WukbTm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-20 at 20:31 +0200, Andy Shevchenko wrote:
> On Thu, Nov 20, 2025 at 03:59:18PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 20, 2025 at 12:43:09PM +0100, Francesco Lavra wrote:
> > > On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote:
> > > > On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra wrote:
> > > > > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote:
> > > > > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra
> > > > > > wrote:
> > > > > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrote:
> > > > > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco Lavra
> > > > > > > > wrote:
> > > > > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko wrote:
> > > > > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Francesco
> > > > > > > > > > Lavra
> > > > > > > > > > wrote:
>=20
> ...
>=20
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable=
 =3D hw->enable_event[event];
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable=
 =3D state ? (old_enable | BIT(axis))
> > > > > > > > > > > :
> > > > > > > > > > > (old_enable
> > > > > > > > > > > &
> > > > > > > > > > > ~BIT(axis));
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!!old_=
enable =3D=3D !!new_enable)
> > > > > > > > > >=20
> > > > > > > > > > This is an interesting check. So, old_enable and
> > > > > > > > > > new_enable
> > > > > > > > > > are
> > > > > > > > > > _not_
> > > > > > > > > > booleans, right?
> > > > > > > > > > So, this means the check test if _any_ of the bit was
> > > > > > > > > > set and
> > > > > > > > > > kept
> > > > > > > > > > set or
> > > > > > > > > > none were set
> > > > > > > > > > and non is going to be set. Correct? I think a short
> > > > > > > > > > comment
> > > > > > > > > > would be
> > > > > > > > > > good to have.
> > > > > > > > >=20
> > > > > > > > > old_enable and new_enable are bit masks, but we are only
> > > > > > > > > interested
> > > > > > > > > in
> > > > > > > > > whether any bit is set, to catch the cases where the bit
> > > > > > > > > mask
> > > > > > > > > goes
> > > > > > > > > from
> > > > > > > > > zero to non-zero and vice versa. Will add a comment.
> > > > > > > >=20
> > > > > > > > If it's a true bitmask (assuming unsigned long type) then
> > > > > > > > all
> > > > > > > > this
> > > > > > > > can be
> > > > > > > > done
> > > > > > > > via bitmap API calls. Otherwise you can also compare a
> > > > > > > > Hamming
> > > > > > > > weights of
> > > > > > > > them
> > > > > > > > (probably that gives even the same size of the object file,
> > > > > > > > but
> > > > > > > > !!
> > > > > > > > instructions
> > > > > > > > =C2=A0will be changed to hweight() calls (still a single
> > > > > > > > assembly
> > > > > > > > instr on
> > > > > > > > modern
> > > > > > > > =C2=A0architectures).
> > > > > > >=20
> > > > > > > These are u8 variables, so we can't use the bitmap API.
> > > > > >=20
> > > > > > OK. But hweight8() can still be used.
> > > > > >=20
> > > > > > > And I don't
> > > > > > > understand the reason for using hweight(), given that the !!
> > > > > > > operators
> > > > > > > would still be needed.
> > > > > >=20
> > > > > > No, you won't need !! with that.
> > > > >=20
> > > > > I still don't understand. Are you proposing to replace `if
> > > > > (!!old_enable =3D=3D
> > > > > !!new_enable)` with `if (hweight8(old_enable) =3D=3D
> > > > > hweight8(new_enable))`?
> > > > > That won't work, because we only need to check whether the
> > > > > Hamming
> > > > > weight
> > > > > goes from zero to non-zero and vice versa.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_enable =3D hw->enable_even=
t[event];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_enable =3D state ? (old_en=
able | BIT(axis)) :
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (old_enable & ~BIT(axis));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!!old_enable =3D=3D !!new_=
enable)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > >=20
> > > > If I am not mistaken this will do exactly the same in a simpler
> > > > way.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =3D hw->=
enable_event[event];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable | BIT(axis);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable & ~BIT(axis);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((new_enable ^ o=
ld_enable) !=3D BIT(axis))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > >=20
> > > This doesn't look right to me, if new_enable differs from old_enable
> > > by
> > > just one bit (which it does), then the XOR result will always have
> > > this bit
> > > (and no others) set, so (new_enable ^ old_enable) will always equal
> > > BIT(axis).
> > > We are not checking if the bit was already set or clear, when this
> > > code
> > > runs we already know that the bit is changing, what we are checking
> > > is
> > > whether all bits are zero before or after this change.
> >=20
> > The check I proposed is to have a look for the cases when old_enable
> > was 0 and
> > the BIT(axis) is set and when the BIT(axis) was _the last_ bit in the
> > mask that
> > got reset. If it's not the case, the code will return 0. I think my
> > check is
> > correct.
> >=20
> > Should I write a test case?
>=20
> FWIW, https://gist.github.com/andy-shev/afe4c0e009cb3008ac613d8384aaa6eb

The code in your gist produces:

Initial event: 0x92, new state: True for bit 0x20
[-] 0x00 | 0x20 --> 1: handle
[0] 0x92 | 0x20 --> 1: handle
[1] 0x93 | 0x20 --> 1: handle
[2] 0x93 | 0x20 --> 1: handle
[3] 0x97 | 0x20 --> 1: handle
[4] 0x9f | 0x20 --> 1: handle
[5] 0x9f | 0x20 --> 1: handle
[6] 0xbf | 0x20 --> 0: return
[7] 0xff | 0x20 --> 0: return
[-] 0xff | 0x20 --> 0: return

But this is not what I need. I need "handle" to be there only when the
bitmask goes from 0x00 to non-zero (in the above example, only at the first
[-] iteration); all the other cases should be a "return". Likewise, if
there is '&' instead of '|', I need "handle" to be there only when the
bitmask goes from non-zero to 0x00.

--=-ZIeMP/I06AU+I7WukbTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkgLV4ACgkQ7fE7c86U
Nl/Y3Av/XW7ygoTih0T8fziBumdJw46kU/oPnzwU+y6yUkYs3n8pwzEYJAdfVwuA
0pP7aGpsaMBC6J0iAfQyB9EX5rdpTS7WXVszBCy2bSgHPTUJX87b/icb3GERqb9q
zEXYl+qZEfgconDuTQrtmMfBwqFUOtJ3q3CdTylt8bh0rkJDP7RNB7MfXyQswrOW
Hbbz27rzQkusr7JF+oDcwkRXVbWM2AuW56H0cFwBRteDEtU49QvwZO9IotDZ0SxS
FlicHEARYbbI8SWI932avg3mql9+YLZBGL3iO93CV3Hud3Bw1QhdzuGk3diezFIt
Ps3JXCRhCHT46WBAKlDehvK0LIRSyoxORH5Yu29NMsQkWGPmasRldUf9cutaFhfo
3/PQvzaEGsjMi87rOVcSZjTwAbkZzO1vGzbvEO20kYbrVXj4s103esC5mi/bX2pi
3SLzlK87XJUtUZ01R2VbG2t7JKOTNDyatYfY7BOVAHGhIcwxm+eYeRa8vnCm972+
nsaT6Bay
=Bv3V
-----END PGP SIGNATURE-----

--=-ZIeMP/I06AU+I7WukbTm--

