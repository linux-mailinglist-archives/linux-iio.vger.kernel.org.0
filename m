Return-Path: <linux-iio+bounces-13027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19F9E1EEF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A735163622
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855151F4713;
	Tue,  3 Dec 2024 14:21:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F931DE4FA;
	Tue,  3 Dec 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235675; cv=none; b=kold5hO9qjVebjEmtWHAQ+fp1gtI/z4rQQWVzhy4AEEQ/o5LdfCXsaryFosghTVjgnxsIobSt1iCmEt6AdrCL4v97p3IsHvMgN7l1m1DUGCdD5YFCGTUN08jun6oL2KENylLCHxglCHRf5YJhrCoDYN6AW3PVD7t+aOOPyEGGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235675; c=relaxed/simple;
	bh=HkUi1jcKUP5m19r0eDKvTJLU5NYjHEejWfffRVQs+ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqC17wqp+3xrshzRCrFGpzRyn1/xx4DjpPNx5p/VDccJ4a011rTDsHffK38NnmKOSrTBE1R+C6rd6cqdfLbMM5VISXyNogtrNh9QXZTo3vA+sQyBnPOrZGZayhmj3oVoHpYCTicy+MGEzb1J0EQfA3HEW71cdrBhD/gKZSPCdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: k7SdQu3iSUCtVLOTnTwljg==
X-CSE-MsgGUID: eX+qpK93QEeZPTEecziZpA==
X-IronPort-AV: E=Sophos;i="6.12,205,1728918000"; 
   d="asc'?scan'208";a="230765382"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Dec 2024 23:21:10 +0900
Received: from [10.226.93.8] (unknown [10.226.93.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 086B540061A9;
	Tue,  3 Dec 2024 23:20:56 +0900 (JST)
Message-ID: <d37b9776-0727-46b6-93f2-02fb7b58732f@bp.renesas.com>
Date: Tue, 3 Dec 2024 14:20:55 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Content-Language: en-GB
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
 <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
 <3f2dc65c-61e9-4d4b-9610-4b106bb691cc@tuxon.dev>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <3f2dc65c-61e9-4d4b-9610-4b106bb691cc@tuxon.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JKO102IA7gtgdP3Gxe3rS4vs"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JKO102IA7gtgdP3Gxe3rS4vs
Content-Type: multipart/mixed; boundary="------------U7sqSrZ5ANkDJGrimd65030S";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Message-ID: <d37b9776-0727-46b6-93f2-02fb7b58732f@bp.renesas.com>
Subject: Re: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
 <9fbf057c-164b-4451-85a8-cf4d5807b4c1@bp.renesas.com>
 <3f2dc65c-61e9-4d4b-9610-4b106bb691cc@tuxon.dev>
In-Reply-To: <3f2dc65c-61e9-4d4b-9610-4b106bb691cc@tuxon.dev>

--------------U7sqSrZ5ANkDJGrimd65030S
Content-Type: multipart/mixed; boundary="------------Wbl7X980XAMYTlSgOy0kxJvM"

--------------Wbl7X980XAMYTlSgOy0kxJvM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On 03/12/2024 13:40, Claudiu Beznea wrote:
> On 03.12.2024 14:53, Paul Barker wrote:
>> On 03/12/2024 11:13, Claudiu wrote:
>>>  static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rz=
g2l_adc *adc, u8 ch)
>>>  {
>>> +	struct device *dev =3D indio_dev->dev.parent;
>>>  	int ret;
>>> =20
>>> -	ret =3D rzg2l_adc_set_power(indio_dev, true);
>>> +	ret =3D pm_runtime_resume_and_get(dev);
>>>  	if (ret)
>>>  		return ret;
>>
>> Should we check (ret < 0) here instead of just (ret)? According to the=

>> docs [1], pm_runtime_resume_and_get() can return 1 if the device is
>> already active.
>=20
> The v6.13-rc1 implementation of pm_runtime_resume_and_get() is:
>=20
> static inline int pm_runtime_resume_and_get(struct device *dev)
> {
> 	int ret;
>=20
> 	ret =3D __pm_runtime_resume(dev, RPM_GET_PUT);
> 	if (ret < 0) {
> 		pm_runtime_put_noidle(dev);
> 		return ret;
> 	}
>=20
> 	return 0;
> }
>=20
> It can return zero or negative error number.

Ah, ok. The docs say that pm_runtime_resume_and_get() will "return the
result of pm_runtime_resume" (which can return 1), but it doesn't do
that exactly. I'll send a fix for the docs.

Thanks,

--=20
Paul Barker
--------------Wbl7X980XAMYTlSgOy0kxJvM
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------Wbl7X980XAMYTlSgOy0kxJvM--

--------------U7sqSrZ5ANkDJGrimd65030S--

--------------JKO102IA7gtgdP3Gxe3rS4vs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ08TxwUDAAAAAAAKCRDbaV4Vf/JGvTQk
AQCXHPEoYKvqfnUipHr1UNlyGnrmNPNeJT8jnL+aDf6RlQEApt4Ly3FIhmvqtvdaEi0TB5VUUhBj
kNq6vqdHYEpmuQQ=
=Eapy
-----END PGP SIGNATURE-----

--------------JKO102IA7gtgdP3Gxe3rS4vs--

