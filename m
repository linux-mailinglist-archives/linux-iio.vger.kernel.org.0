Return-Path: <linux-iio+bounces-7087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E779E91D1EA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674621F2147C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25D1422A6;
	Sun, 30 Jun 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deRF3w+6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB113DBB3;
	Sun, 30 Jun 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756014; cv=none; b=WJvf0E7ZLU5E90290TwoX2cmzeO6iHc7O6UzMy3oFyuZ4yrMC/sj/fBpUL7l9pWeX5b2vJerdl3GKm0vhUS6sWycFR4/5OxqcOKABEycIl17djQFrpXBIJRl3HXIeDCkSduzFcB4wfrG/jj2954MBygTrQ9yqMvBGW6oT1ZSSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756014; c=relaxed/simple;
	bh=ih12JHTetNkTeksjpMCJOXUWcwVm9PgEUMFbcuLoU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2k3AkMlCefmFaoYMb81dDn3SguF2TAvWg+xJae3yoRmQiNYSUqeCHHERNTiFnYf1yabEO6vceRnXNIjHsJINyFM6xadHsd/m1+FWBVBzJxD31xHvAHooheruGDIWSrVMP2sGSNbXOE7AtQFO+WVI4LC+WeRK67bqsMUVtnbIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deRF3w+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F8C2BD10;
	Sun, 30 Jun 2024 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719756014;
	bh=ih12JHTetNkTeksjpMCJOXUWcwVm9PgEUMFbcuLoU/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deRF3w+6o/GL1cKMQ/2DJZ4IzzKBGmfvH1u3HoP9jgvptYbMijXhjrbJosjHVYgN+
	 bbDZQFfk/jsMJA8dI+R1aXHRaYp9HR4cs84Gm75Xp/CHGDB3EWA+YGx0GSrUqCOX9r
	 uNltKMWWm4DsM/GWTGtppo2HJixdTfsh+kDwNVGezEcbNAc0SmJqMqXQIZw1ryzku5
	 LStHO9pEpZ04QNAi8snj1PuUrDhJDADEcqO9gYRuGvBxEfqf3zSa/VIxK8pn0vwwon
	 W1Hz2wkB96yOZ/5+xz7Dx+LWe4+QFZCBYphWWCGRf1kO5VnZMfSdDS93+NAxGqk+1P
	 JPzEFWjjEoh+w==
Date: Sun, 30 Jun 2024 15:00:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: adi,ad7606: comment and
 sort the compatible names
Message-ID: <20240630-darling-dairy-f161f784f45a@spud>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
 <20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com>
 <20240629162223.5b8d35b8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gveNh7Lwv1kh1y0C"
Content-Disposition: inline
In-Reply-To: <20240629162223.5b8d35b8@jic23-huawei>


--gveNh7Lwv1kh1y0C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 04:22:23PM +0100, Jonathan Cameron wrote:
> On Fri, 28 Jun 2024 14:48:20 +0000
> Guillaume Stols <gstols@baylibre.com> wrote:
>=20
> > AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
> > to avoid confusion. Also the compatible names were not sorted by
> > alphabetical order.
> >=20
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>=20
> So b4 interestingly picked up both acks from Rob and Conor on this
> one but I can't figure out where Conor's one came from so I've dropped
> it.

My copy of b4 (0.14-dev-d4707) doesn't create one for me:
/stuff/b4/b4.sh shazam -s -S -t shazam 20240628-cleanup-ad7606-v2-2-96e02f9=
0256d@baylibre.com
Grabbing thread from lore.kernel.org/all/20240628-cleanup-ad7606-v2-2-96e02=
f90256d@baylibre.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 20 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v2 1/10] dt-bindings: iio: adc: adi,ad7606: add missing =
datasheet link
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 2/10] dt-bindings: iio: adc: adi,ad7606: comment and =
sort the compatible names
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 3/10] dt-bindings: iio: adc: adi,ad7606: normalize te=
xtwidth
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 4/10] dt-bindings: iio: adc: adi,ad7606: improve desc=
riptions
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 5/10] dt-bindings: iio: adc: adi,ad7606: add supply p=
roperties
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 6/10] dt-bindings: iio: adc: adi,ad7606: fix example
    + Acked-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKIM/k=
ernel.org)
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 7/10] dt-bindings: iio: adc: adi,ad7606: add conditio=
ns
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKI=
M/kernel.org)
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 8/10] iio: adc: ad7606: fix oversampling gpio array
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 9/10] iio: adc: ad7606: fix standby gpio state to mat=
ch the documentation
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  =E2=9C=93 [PATCH v2 10/10] iio: adc: ad7606: switch mutexes to scoped_gua=
rd
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  ---
  =E2=9C=93 Signed: DKIM/baylibre-com.20230601.gappssmtp.com (From: gstols@=
baylibre.com)
---
Total patches: 10
---
 Base: using specified base-commit 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
Applying: dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
Applying: dt-bindings: iio: adc: adi,ad7606: comment and sort the compatibl=
e names
Applying: dt-bindings: iio: adc: adi,ad7606: normalize textwidth
Applying: dt-bindings: iio: adc: adi,ad7606: improve descriptions
Applying: dt-bindings: iio: adc: adi,ad7606: add supply properties
Applying: dt-bindings: iio: adc: adi,ad7606: fix example
Applying: dt-bindings: iio: adc: adi,ad7606: add conditions
Applying: iio: adc: ad7606: fix oversampling gpio array
Applying: iio: adc: ad7606: fix standby gpio state to match the documentati=
on
Applying: iio: adc: ad7606: switch mutexes to scoped_guard

tbh, I'm not actually sure why I didn't ack those patches on v1, they
were all pretty trivial...

--gveNh7Lwv1kh1y0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoFk6AAKCRB4tDGHoIJi
0iCnAP9zN8Iaxw1TB9IzX2VNxydUR9jq65UV0PytiU1hFDgMQQEApfnWKy+/gsil
FNtAR3ceR9p8FnAxjYeK0lPqkRL+PAQ=
=m4Qw
-----END PGP SIGNATURE-----

--gveNh7Lwv1kh1y0C--

