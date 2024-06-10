Return-Path: <linux-iio+bounces-6143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6762901EB0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 12:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7154C1F244DA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0F7441A;
	Mon, 10 Jun 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXhVE3gV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78134380;
	Mon, 10 Jun 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013662; cv=none; b=jD013Tk197d2yG1Ph/eeF6EcnN/9oSE2FfvKErmZR30ayI6hwMtx/pDSNU2fnxBqKMn2DYJgpu5xHNMUtbWvOHMCKdWMR33HHUGQMO1F5G7yp2+fcp/8KhUDduOsJLYO+Vgi7apeK9Wr1U8/FzToHXSGMPc2rus+AjN9wiERlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013662; c=relaxed/simple;
	bh=rpfBCewrJ57m1XhK04q4oYOZWvFgVJ0ofLHYyQPUef4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i19uIAIAqynhnynNzY/3iHgReXG3GIAxgt93wrs9B1CrOyHDLNjaoCxz+4Nfcnqi6giEJI0o8cOCDwSWUnCCWeVsw8JrSvhx+lCFoyIZeAmWpxcDMzVFc0LtCAY7nH1dDJxtzfkgtUzGJ77kt1fkLKfEOEdppTBCjlQnVDobXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXhVE3gV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so9808971fa.2;
        Mon, 10 Jun 2024 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718013658; x=1718618458; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyl3+XIog9dQIWNoiS9a4VyeYbrY08OnYSdGirX7m4g=;
        b=dXhVE3gVE/t0zZCcy+jeF364VLo2gBkJcMadWZ6lB840vIm127AybOwj3RyXYdVYU/
         qY8NjHfJ6eX5iafdpsOuCujbHQerIZY6niSIoAPLRNkSZOy10dz5mRaRfne4AtB8u5WS
         2u1YQZEKh0820Yw64sIco0IGUDtga2lmRFuyzFQiyF2R5GyhPBxdXlDN3iBkoGXnBu9t
         Wx9Jfdb37MljZjmA+0ntg5eggFBXwNshWc8kratzp7S06io+jNIMyXiz7ed/4YC/t0ZZ
         2GzpSGq7+NrKSw0CNsLxYACwTsHT6z02j0XEj3uVDfACawnjw0skVImvQvVV/3JRq6xj
         Gi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013658; x=1718618458;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyl3+XIog9dQIWNoiS9a4VyeYbrY08OnYSdGirX7m4g=;
        b=Kr1YCbIgU43C/RqECsayJ3MRgxw8BRQJSoVm+PFxMZLX1+lExwwvtfHkw9hiK8k7Sz
         vrdacrDMTXPx7hx4kOAjlrC085pakeQmWjOIyEjeej72S2CwNmGQAqcg7veeRa1i+dZl
         v09y4V5CI/6q9y4CEbVAFQCUK0TQ8NmLP6ju0UeEWdehdRS4+1YaBVPaJWxuctc+Kb/h
         VN9OgsUoSo+31lFFpO8G7ksUv5EFJlJkGLjiCJnH/euzNdIZnD2VWEoXH2gHp9BVKwso
         3IvTKYphhdFQoc3CaYH44VMwoe2L4+gi9AWq3SH70vHGmiTfPWiTbqzb0WQ44Mib9PnD
         KxZw==
X-Forwarded-Encrypted: i=1; AJvYcCWnfrIlbeq1BCVBUWlh2eDZs3U62W9ToGu1GXHNc2jVK0Ba375sI1I/M2FpkiIxIS33Of12r87MjN+a2ZaAC8seVJU/XjBG+2Smf41hWo/tm7HiUq2bvSs29DW9w0QMEhn5vxR0ACZ3
X-Gm-Message-State: AOJu0YzCiecuvaK0q4P/lqKqpG5t8n2HACX1Wh82bDC167gFoBoehbRJ
	BN0uvDJuNRnTwF2GfLwxkVkGCVfXZwUbOkSWazrX82qPvJTDpk6MZVsQgw==
X-Google-Smtp-Source: AGHT+IHYwH5HvnX7+uGS3MXTFaW9Dca/4/+dswkaIFItmBYaI4u4DAoTeT96gCvdDKlObor6luRbgw==
X-Received: by 2002:a2e:9043:0:b0:2eb:e429:13df with SMTP id 38308e7fff4ca-2ebe42915f6mr17454221fa.18.1718013658124;
        Mon, 10 Jun 2024 03:00:58 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd9167b31sm9132541fa.120.2024.06.10.03.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:00:56 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:00:46 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ROHM BU27034NUC to ROHM BU27034ANUC
Message-ID: <cover.1718013518.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wquGZ2/YnxfLTbx/"
Content-Disposition: inline


--wquGZ2/YnxfLTbx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As discussed here:
https://lore.kernel.org/all/ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com/

The ROHM BU27034NUC was cancelled before it entered mass-production. A
replacement was developed and named to BU27034ANUC. (Note the added
'A' in the model name). The BU27034ANUC has several changes that make
the old BU27034NUC driver unusable with it. I was told the old BU27034NUC
should not be encountered anywhere.

Hence, this series converts the rohm-bu27034.c to support the new
BU27034ANUC instead of the obsoleted BU27034NUC. Additionally, the
series adds a read-only entry for the HARDWAREGAIN to help understanding
what part of the scale is contributed by the gain, and what by the
integration time. This is useful when figuring out why some transitions
=66rom one 'scale' to other are failing.

---

Matti Vaittinen (2):
  bu27034: ROHM BU27034NUC to BU27034ANUC
  iio: bu27034: Add a read only HWARDWAREGAIN

 drivers/iio/light/rohm-bu27034.c | 335 ++++++++-----------------------
 1 file changed, 81 insertions(+), 254 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--wquGZ2/YnxfLTbx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZmzsoACgkQeFA3/03a
ocUYDgf9GnIKYIWxGv1aiYQKnalRlH/SV2zybaI3hhSVehGbJWgzYWHBkq674CK2
KnJXtnMQvCLS4FLaUAFHrDDvuNcfswHpLnbBjQnwmgbIySMI+Q9VK+8S/mRnC0aB
xbSJLhhoZXEp8ki2cH5CzF7r+RpzUVR4wMm2mllzTIkx5/PMVZElucRD2A/N7sZP
kAH0rYoulRQFR4B0nrWgjc9yZczwJN0g9YnF88x/FEgebkeg3JccZkmp9CWVunQQ
cRE6Dq1Zj1qLoSY/6+9UTz0obx3PGakvwJIBsRLJkMM973sCfSs+fncB+n8It0uh
V45zTzPSAKbTkMZmD8X7N5TjdL18qg==
=PuWi
-----END PGP SIGNATURE-----

--wquGZ2/YnxfLTbx/--

