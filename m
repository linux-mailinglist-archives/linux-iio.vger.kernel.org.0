Return-Path: <linux-iio+bounces-13023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF629E1D14
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 14:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB90FB3AC62
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFB1EE034;
	Tue,  3 Dec 2024 13:03:52 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743C1E0E0C;
	Tue,  3 Dec 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231032; cv=none; b=dI2Ea8RHIMPlS4fSPP+Oth7+146MvjXcN+bS1jSjcZtPStjOZTNWxjwCPVfm0Yq3tnPT3NVpgpF+doOCY5IGR77GOQUO+MNAbRRan75a3z2GBE6ghLueD/0CCJ0jzB+EeEF4Dz3vs8gETk9vyRK9xksrHhn1RmnftZUbEd2iWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231032; c=relaxed/simple;
	bh=ulhV8p19khZo4FSRs3NgrLM359uPbLHsOWsvdJIfP+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS6FhU+mAtkc66MxhSquVEPewjOmIuXoJTlot/Jz2VNNRA7cAptNPYeRwxmhOjrEIy464MFBj374u8/arSfk8ql61POaQsYVDvBony/flJHfdj2JNPDQT2YlV+KENTWfqq8VeP6T6D+VmB3lJ6iLjX7fmW7vupw7PJPZ0KQJ4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: cThaTchoSu24saTRNojErw==
X-CSE-MsgGUID: moxWudRiTVaFLZlderrHNA==
X-IronPort-AV: E=Sophos;i="6.12,205,1728918000"; 
   d="asc'?scan'208";a="226786721"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Dec 2024 22:03:47 +0900
Received: from [10.226.93.8] (unknown [10.226.93.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 801B540727CD;
	Tue,  3 Dec 2024 22:03:30 +0900 (JST)
Message-ID: <6f627195-6c55-4687-b6b6-7fb791d13819@bp.renesas.com>
Date: Tue, 3 Dec 2024 13:03:29 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in
 rzg2l_adc_read_raw()
Content-Language: en-GB
To: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6t5Uabc36aLXyj0ONpUFbPVQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6t5Uabc36aLXyj0ONpUFbPVQ
Content-Type: multipart/mixed; boundary="------------SWTOlpOL7ORz8bE0b0020s80";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Message-ID: <6f627195-6c55-4687-b6b6-7fb791d13819@bp.renesas.com>
Subject: Re: [PATCH 06/14] iio: adc: rzg2l_adc: Simplify the locking scheme in
 rzg2l_adc_read_raw()
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241203111314.2420473-7-claudiu.beznea.uj@bp.renesas.com>

--------------SWTOlpOL7ORz8bE0b0020s80
Content-Type: multipart/mixed; boundary="------------VivEKTRZRP7bCjISc0I0PIV1"

--------------VivEKTRZRP7bCjISc0I0PIV1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On 03/12/2024 11:13, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Simplify the locking scheme in rzg2l_adc_read_raw() by saving the conve=
rted
> value only if the rzg2l_adc_conversion() returns success. The approach
> simplifies the addition of thermal sensor support (that will be done in=
 the
> next commits). The downside is that the ret variable need to be checked=

> twice.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 62932f9295b6..eed2944bd98d 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -227,14 +227,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *ind=
io_dev,
>  		mutex_lock(&adc->lock);
>  		ch =3D chan->channel & RZG2L_ADC_CHN_MASK;
>  		ret =3D rzg2l_adc_conversion(indio_dev, adc, ch);
> -		if (ret) {
> -			mutex_unlock(&adc->lock);
> -			return ret;
> -		}
> -		*val =3D adc->last_val[ch];
> +		if (!ret)
> +			*val =3D adc->last_val[ch];
>  		mutex_unlock(&adc->lock);
> =20
> -		return IIO_VAL_INT;
> +		return ret ? ret : IIO_VAL_INT;

It would be maybe slightly neater to use:

	if (!ret) {
		*val =3D adc->last_val[ch];
		ret =3D IIO_VAL_INT;
	}
	mutex_unlock(&adc->lock);

	return ret;

Thanks,

--=20
Paul Barker
--------------VivEKTRZRP7bCjISc0I0PIV1
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGS4BNsBEADEc28TO+aryCgRIuhxWAviuJl+f2TcZ1JeeaMzRLgSXKuXzkiI
g6JIVfNvThjwJaBmb7+/5+D7kDLJuutu9MFfOzTS0QOQWppwIPgbfktvMvwwsq3m
7e9Qb+S1LVeV0/ldZfuzgzAzHFDwmzryfIyt2JEbsBsGTq/QE+7hvLAe8R9xofIn
z6/IndiiTYhNCNf06nFPR4Y5ZDZPGb9aw5Jisqh+OSxtc0BFHDSV8/35yWM/JLQ1
Ja8AOHw1kP9KO+iE9rHMt0+7lH3mN1GBabxH26EdgFfPShsi14qmziLOuUlGLuwO
ApIYqvdtCs+zlMA8PsiJIMuxizZ6qCLur3r2b+/YXoJjuFDcax9M+Pr0D7rZX0Hk
6PW3dtvDQHfspwLY0FIlXbbtCfCqGLe47VaS7lvG0XeMlo3dUEsf707Q2h0+G1tm
wyeuWSPEzZQq/KI7JIFlxr3N/3VCdGa9qVf/40QF0BXPfJdcwTEzmPlYetRgA11W
bglw8DxWBv24a2gWeUkwBWFScR3QV4FAwVjmlCqrkw9dy/JtrFf4pwDoqSFUcofB
95u6qlz/PC+ho9uvUo5uIwJyz3J5BIgfkMAPYcHNZZ5QrpI3mdwf66im1TOKKTuf
3Sz/GKc14qAIQhxuUWrgAKTexBJYJmzDT0Mj4ISjlr9K6VXrQwTuj2zC4QARAQAB
zStQYXVsIEJhcmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+wsGU
BBMBCgA+FiEE9KKf333+FIzPGaxOJ/SzRZ8AIlcFAmS4BNsCGwEFCQPCZwAFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQJ/SzRZ8AIlfxaQ/8CM36qjfad7eBfwja
cI1LlH1NwbSJ239rE0X7hU/5yra72egr3T5AUuYTt9ECNQ8Ld03BYhbC6hPki5rb
OlFM2hEPUQYeohcJ4Na5iIFpTxoIuC49Hp2ce6ikvt9Hc4O2FAntabg+9hE8WA4f
QWW+Qo5ve5OJ0sGylzu0mRZ2I3mTaDsxuDkXOICF5ggSdjT+rcd/pRVOugImjpZv
/jzSgUfKV2wcZ8vVK0616K21tyPiRjYtDQjJAKff8gBY6ZvP5REPl+fYNvZm1y4l
hsVupGHL3aV+BKooMsKRZIMTiKJCIy6YFKHOcgWFG62cuRrFDf4r54MJuUGzyeoF
1XNFzbe1ySoRfU/HrEuBNqC+1CEBiduumh89BitfDNh6ecWVLw24fjsF1Ke6vYpU
lK9/yGLV26lXYEN4uEJ9i6PjgJ+Q8fubizCVXVDPxmWSZIoJg8EspZ+Max03Lk3e
flWQ0E3l6/VHmsFgkvqhjNlzFRrj/k86IKdOi0FOd0xtKh1p34rQ8S/4uUN9XCVj
KtmyLfQgqPVEC6MKv7yFbextPoDUrFAzEgi4OBdqDJjPbdU9wUjONxuWJRrzRFcr
nTIG7oC4dae0p1rs5uTlaSIKpB2yulaJLKjnNstAj9G9Evf4SE2PKH4l4Jlo/Hu1
wOUqmCLRo3vFbn7xvfr1u0Z+oMTOOARkuAhwEgorBgEEAZdVAQUBAQdAcuNbK3VT
WrRYypisnnzLAguqvKX3Vc1OpNE4f8pOcgMDAQgHwsF2BBgBCgAgFiEE9KKf333+
FIzPGaxOJ/SzRZ8AIlcFAmS4CHACGwwACgkQJ/SzRZ8AIlc90BAAr0hmx8XU9KCj
g4nJqfavlmKUZetoX5RB9g3hkpDlvjdQZX6lenw3yUzPj53eoiDKzsM03Tak/KFU
FXGeq7UtPOfXMyIh5UZVdHQRxC4sIBMLKumBfC7LM6XeSegtaGEX8vSzjQICIbaI
roF2qVUOTMGal2mvcYEvmObC08bUZuMd4nxLnHGiej2t85+9F3Y7GAKsA25EXbbm
ziUg8IVXw3TojPNrNoQ3if2Z9NfKBhv0/s7x/3WhhIzOht+rAyZaaW+31btDrX4+
Y1XLAzg9DAfuqkL6knHDMd9tEuK6m2xCOAeZazXaNeOTjQ/XqCHmZ+691VhmAHCI
7Z7EBPh++TjEqn4ZH+4KPn6XD52+ruWXGbJP29zc+3bwQ+ZADfUaL3ADj69ySxzm
bO24USHBAg+BhZAZMBkbkygbTen/umT6tBxG91krqbKlDdc8mhGonBN6i+nz8qv1
6MdC5P1rDbo834rxNLvoFMSLCcpjoafiprl9qk0wQLq48WGphs9DX7V75ZAU5Lt6
yA+je8i799EZJsVlB933Gpj688H4csaZqEMBjq7vMvI+a5MnLCGcjwRhsUfogpRb
AWTx9ddVau4MJgEHzB7UU/VFyP2vku7XPj6mgSfSHyNVf2hqxwISQ8eZLoyxauOD
Y61QMX6YFL170ylToSFjH627h6TzlUDOMwRkuAiAFgkrBgEEAdpHDwEBB0Bibkmu
Sf7yECzrkBmjD6VGWNVxTdiqb2RuAfGFY9RjRsLB7QQYAQoAIBYhBPSin999/hSM
zxmsTif0s0WfACJXBQJkuAiAAhsCAIEJECf0s0WfACJXdiAEGRYIAB0WIQSiu8gv
1Xr0fIw/aoLbaV4Vf/JGvQUCZLgIgAAKCRDbaV4Vf/JGvZP9AQCwV06n3DZvuce3
/BtzG5zqUuf6Kp2Esgr2FrD4fKVbogD/ZHpXfi9ELdH/JTSVyujaTqhuxQ5B7UzV
CUIb1qbg1APIEA/+IaLJIBySehy8dHDZQXit/XQYeROQLTT9PvyM35rZVMGH6VG8
Zb23BPCJ3N0ISOtVdG402lSP0ilP/zSyQAbJN6F0o2tiPd558lPerFd/KpbCIp8N
kYaLlHWIDiN2AE3c6sfCiCPMtXOR7HCeQapGQBS/IMh1qYHffuzuEy7tbrMvjdra
VN9Rqtp7PSuRTbO3jAhm0Oe4lDCAK4zyZfjwiZGxnj9s1dyEbxYB2GhTOgkiX/96
Nw+m/ShaKqTM7o3pNUEs9J3oHeGZFCCaZBv97ctqrYhnNB4kzCxAaZ6K9HAAmcKe
WT2q4JdYzwB6vEeHnvxl7M0Dj9pUTMujW77Qh5IkUQLYZ2XQYnKAV2WI90B0R1p9
bXP+jqqkaNCrxKHV1tYOB6037CziGcZmiDneiTlM765MTLJLlHNqlXxDCzRwEazU
y9dNzITjVT0qhc6th8/vqN9dqvQaAGa13u86Gbv4XPYdE+5MXPM/fTgkKaPBYcIV
QMvLfoZxyaTk4nzNbBxwwEEHrvTcWDdWxGNtkWRZw0+U5JpXCOi9kBCtFrJ701UG
UFs56zWndQUS/2xDyGk8GObGBSRLCwsXsKsF6hSX5aKXHyrAAxEUEscRaAmzd6O3
ZyZGVsEsOuGCLkekUMF/5dwOhEDXrY42VR/ZxdDTY99dznQkwTt4o7FOmkY=3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------VivEKTRZRP7bCjISc0I0PIV1--

--------------SWTOlpOL7ORz8bE0b0020s80--

--------------6t5Uabc36aLXyj0ONpUFbPVQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ08BoQUDAAAAAAAKCRDbaV4Vf/JGvVgY
AP9xoHxYUzRAXikKlbEGaySUX2sauonk6OzOZCKl3ET1wgD+LAWpd6JAzuokpIiTdQtTmfhgdZ1i
AN+1R/m9yw0bQgE=
=rjmV
-----END PGP SIGNATURE-----

--------------6t5Uabc36aLXyj0ONpUFbPVQ--

