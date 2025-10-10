Return-Path: <linux-iio+bounces-24907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0556BCD80C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F954146E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A072EFDAD;
	Fri, 10 Oct 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkl6NKmR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F61E0DFE;
	Fri, 10 Oct 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105996; cv=none; b=saD1Zr3SBKCi5uYWmvKkwlQLK2/lkwH1IHNryOXaiVDdcAVO5iRiuVq0HJwiwhKYpwiEFngQlIqFiQNY98bo9CSxElg/CMadGj+y4DKYEU7KDBkUr6dhHuZcZReMqoiZLbUVDD+X4kmqxzoV3HvdyDEooszdS8ZSGPMSm0XY5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105996; c=relaxed/simple;
	bh=cnxpNF5oAzC3psAy/x0fBmyQxHTFD0K4Zk1GsmPaKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b79pUXzoREWaBrT+rW/RjkX+YAAA1pIJaXk5YnUwdhoM0RKlXNE1eGJe3QyBp8I+3mqOmNJfEy+oJ6hWGonRPufXzijBvk1X05MTtERj1tKpjf0LXWLsoBqzuC4JRLB4bOzsATgSlZXJIZRHuoybiwt1xORGuZ4UvcWwIq5ohaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkl6NKmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD6C4CEF1;
	Fri, 10 Oct 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760105996;
	bh=cnxpNF5oAzC3psAy/x0fBmyQxHTFD0K4Zk1GsmPaKTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gkl6NKmRfM0ydP8448tgSAq6xZcm51b9wSgot4Td4X9iEAywhU4bM7VS79h+GBm1b
	 eKg9z4+XiMs/Pzh5LiAxhFM1wkq9rmQRuH4fWM6uJ2Z8KbFKStek27Bk7Dz1FU73bH
	 TZGLR3gOSyZhuckvVryxUZUfB6eiXl4lMtbMovqx7hTI6qkFf41LAywJ7L0uahg0e7
	 dh+OP96RKt5Nfbf9o2Az83jlvt0tRVUrA8B0hdCttHbdRUVi60w0EpX/Gk2MQ/HYu6
	 X3XZHbTmINxAaStbO6OKxpyCxFQbgP7AxR/iaKa20MGLkgw9a5MqSHveLpwQrIVVMG
	 jv76II99NprhQ==
Date: Fri, 10 Oct 2025 15:19:51 +0100
From: Conor Dooley <conor@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>,
	"Frauendorf Ulrike (ME/PJ-SW3 M/PJ-AIP)" <Ulrike.Frauendorf@de.bosch.com>,
	"Dolde Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>
Subject: Re: AW: [PATCH v5 1/2] dt-bindings: iio: imu: smi330: Add binding
Message-ID: <20251010-purse-lunar-66f7209afb83@spud>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
 <20251009153149.5162-2-Jianping.Shen@de.bosch.com>
 <20251009-squishy-poem-ddb0fdd9583d@spud>
 <b4436b4f-a54b-4294-8dd9-7a4b95711dc4@kernel.org>
 <AM8PR10MB472118D128FC27000C09C49ACDEFA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lBYu72WoRi+kMI37"
Content-Disposition: inline
In-Reply-To: <AM8PR10MB472118D128FC27000C09C49ACDEFA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>


--lBYu72WoRi+kMI37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 08:13:12AM +0000, Shen Jianping (ME-SE/EAD2) wrote:
> Hello Conor and Krzysztof,
>=20
> Sorry for that. The patch is automatically generated. The ack shall be au=
tomatically added to patch. For some reason the ack was not properly handel=
ed in the automatic generation. This will not happen again.

I don't care if the patch is automatically generated, it is still
your responsibility to do these things correctly - doubly so I would say
if you are using some AI or automatic assistance to create the patch.

You signed off on it, you need to make sure it is right.

> We have a kernel test robot finding in v4.   [jic23-iio:testing 119/122] =
smi330_core.c:undefined reference to `ffs'.  The patch v5 is to fix this fi=
nding.

Given the patch has been applied, the typical thing to do is to send a
follow-up patch fixing the issue.

Maybe you automatic patch generator should also tell you not to top
post, but since it hasn't: don't top post. Also don't use whatever tool
is mangling links.

Thanks,
Conor.

>=20
> Best regards
> Jianping
>=20
> >>> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> >>>
> >>> Add devicetree binding for Bosch imu smi330.
> >>> The smi330 is a combined three axis angular rate and three axis
> >>> acceleration sensor module.
> >>>
> >>> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> >>
> >> https://lore/
> >> .kernel.org%2Fall%2F20250916-henna-rinsing-32a18a4d30b9%40spud%2F&data
> >>
> >=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Cb16bd41f74b6439328e908de0
> >7a0
> >>
> >6a33%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63895658272275205
> >1%7
> >>
> >CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
> >CIsIlA
> >>
> >iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdA
> >%2F
> >> lUR6HfaamYwPotYUdUrHiaG2LgGJm8LEcmRth%2FjQ%3D&reserved=3D0
> >>
> >> Why did you ignore my ack?
> >> Didn't Jonathan already apply v4 of this two weeks ago, why is there
> >> even a v5 to begin with?
> >
> >Not only v4, but also v2 and reminder in v3:
> >
> >https://lore.kernel.or/
> >g%2Fall%2F20250514-deserve-marina-
> >224bef5b2db3%40spud%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com
> >%7Cb16bd41f74b6439328e908de07a06a33%7C0ae51e1907c84e4bbb6d648ee58410
> >f4%7C0%7C0%7C638956582722772435%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> >0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIld
> >UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7lgke1m7JvcNjIKigI4ugH4fffFSZBZgZ
> >PQvClYsAsk%3D&reserved=3D0
> >
> >
> >and here I exactly reminded what has to be done:
> >https://lore.kernel.or/
> >g%2Fall%2F1196da81-ecd7-487c-8afc-
> >e0d3660fa158%40kernel.org%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.c
> >om%7Cb16bd41f74b6439328e908de07a06a33%7C0ae51e1907c84e4bbb6d648ee58
> >410f4%7C0%7C0%7C638956582722786576%7CUnknown%7CTWFpbGZsb3d8eyJF
> >bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> >sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtoM%2BhpSCP6sNu8PU7Ed8iDG
> >sQIRm6IvdYiWV8sdGjmo%3D&reserved=3D0
> >
> >which was completely ignored.
> >
> >So I can write detailed instructions and Jianping will just ignore it, b=
ecause who am I
> >to say anything?
> >
> >I will ignore future contributions from Jianping in such case. It is was=
te of our time.
> >
> >Best regards,
> >Krzysztof

--lBYu72WoRi+kMI37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkWAwAKCRB4tDGHoIJi
0nJFAQD0cyo80Sf5z/EG9yOUsLaQRNWs4bPCvpd2CWJIAaJS+wEA5706LQ/85jfb
gtQd6shYF5jJHlYUzVK3+8IbOiBwYAQ=
=EvaS
-----END PGP SIGNATURE-----

--lBYu72WoRi+kMI37--

