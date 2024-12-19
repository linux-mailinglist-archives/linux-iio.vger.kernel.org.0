Return-Path: <linux-iio+bounces-13632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1229F7A81
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D037A7A31B2
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0622371F;
	Thu, 19 Dec 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eusqXFOh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B721661D;
	Thu, 19 Dec 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608347; cv=none; b=QpWiYSDKNwEzcsDpdn0HrGBhqSbwwXptAbu3obEgzpojHtly6o5rw7rxLzhIZXVAtvAdShP8oi5ypMRC4pmsTQ7ht0cFuH98u659tgqNDU2y2ptiquXYwFyY/obIRYh8IFGVEzn3vkjGJFOkK2SFA7N3ZmVAIeLcL+eu7yffK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608347; c=relaxed/simple;
	bh=TkkRPc10uSqauOTUMY8jj6ucGDskZXgstjwzTWyAEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gPmByhK6HEbQGqcYf0o0/qmGTJAjQPf2BvVI7+Jd9XKE2l4yDpG4Ijtd5h53ck88wOpyUMg1pyoPQ3z32WdOUACeQwtQq+TkNAP7u6wwgSLL1gWC0ZdaDNdGYJygS3phAFvitJV5cXFchsgHhKQzh1veWiHLTvnTpzJt8B72Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eusqXFOh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-300392cc4caso8043051fa.3;
        Thu, 19 Dec 2024 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734608342; x=1735213142; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sdjYwn3aAQLvHw3G13g4cBd9ULlduAL/auqjSZV/i4=;
        b=eusqXFOhh6IOtVZ8sy1k2Q2R+hC903Zs5s0SPu0bqgRZqJAbCO8/lyJ9DeLvh+YSm5
         aQVUKv1Gez4c8gVIEDDPeEyfi2/dcznj2QQpwsSRnKHIM4a2pNCDZdhx5mSvq9Lz5EPR
         7maRBhj2vh1iO8HukR8dHHgvyb0+OBUAriYIEqYuDFEDHE9r4LTVfA42veWzZ8pD5XBJ
         CSeFTviYNotNeMdqNm1EXWux7bLrw2q7MMUG8YqHMW65EWRj9cELMU01w1Ha3FFIjoDE
         f+sEGrancsdcWOuDfn+dOSiAY6HiHfBtJZSW7M6x4+gJlQTwaLKB4mR8CWFQo7kvpXs6
         KhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608342; x=1735213142;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sdjYwn3aAQLvHw3G13g4cBd9ULlduAL/auqjSZV/i4=;
        b=RIojmeyKrsiEWzQ7aUPsh0CfbIVSEu+HVkR9nEZ1l7DcSHMR3MNygaId0nyIw65v7v
         bD6V1Y3EbYo208s0+W2XTcdtrMUGexFZvEdbwSKrWjj5jubiHzjucq0WaK6fwvvZdu16
         g25zhzqy+Xjc8BlaAqR7Ey30YXcqbh6LEa9ePKf6KJJqL1dENg7y7JGpqUACaQb0sydg
         F/m/+xcVCnTHIxTjJeX4ULmlWgbxN731NvOtk5HHUuhFKTQap7Ahf2TBbrNg90rkjESJ
         hjeuu2jwMxPj9AmYZJpAwnIA+7CtxZXnIh5Uuw7Qj9nm7TCRjznV6CqJEIxV7BENsqk5
         Zutw==
X-Forwarded-Encrypted: i=1; AJvYcCUhIoF9fWjm32+bRHwv6DyKx8rE9zTLu/INJL9D7Gd+ssqFPLM9LQpy0afFLiQ9oAIlZyOu0dImWA4Q@vger.kernel.org, AJvYcCUirLleEroiqabnKLSbkHJm+M8S4q7gTkw43Tx1oicUJLkuf0hqqKM0NgND9iKI2BlobzsNkwNZOQOGUl+L@vger.kernel.org, AJvYcCXxRzZIZzrlSOVT5sdG3TgiQk6K8R+UBZdEYAhn+hWofqjIQJy01q5MhNMPn4KU589fUIKSImVZr19j@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkSgFpVzfgMANFPu9DebUGucxV929Is7Ve8h5PTvayyPE7lju
	zo7yvtAHFKoBv/mG8T8J60Im+HPel6H6Tq+nIS4VvcOF+gaMvEtdrREqMg==
X-Gm-Gg: ASbGnctwhgBY/mwkKbGvmDRhOvqW2Qrlwq0cWY3MWAfSQ/LixLG8GzDAoq+aSv3UMqV
	Op6c38A+/rMfH6rAIhIXmWiAtpNpGs1UFHfpCCk8Ak5MvHBdcNFRlyUDyFFB0+1fWx4PPodLofR
	BVSLDAeNdxiihH3566eXymWA4EFvnwAAtCtuwZDHO5uvBxo6ZBoxPakaj5l4D5THQQGakMBN2SF
	eLffj9+ZiT+Bd/TEsRV5ya8O/RZatgG+xLIet2LVDgxHVl2GEdILQMyLDY=
X-Google-Smtp-Source: AGHT+IEnfRIl7BJOHCGZhtLTu20hQ0ALHxyPu/F854wB0msKXn6h5SdyQ6n7nJIvF7ZvckvBLdPHwg==
X-Received: by 2002:a05:6512:114a:b0:53e:23ec:b2e7 with SMTP id 2adb3069b0e04-541e6751465mr2119456e87.34.1734608341356;
        Thu, 19 Dec 2024 03:39:01 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f64c1sm147235e87.51.2024.12.19.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:39:00 -0800 (PST)
Date: Thu, 19 Dec 2024 13:38:54 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Support ROHM BD79703 DAC
Message-ID: <cover.1734608215.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PZ+NvlxHLXMmC+Vu"
Content-Disposition: inline


--PZ+NvlxHLXMmC+Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD79703 DAC

The ROHM BD79703 DAC is a 6-channel 8-bit digital to analog converter
which can be controlled over SPI bus. This series adds support for
controlling the analog channels via IIO direct mode.

Matti Vaittinen (3):
  dt-bindings: Add ROHM BD79703
  iio: dac: Support ROHM BD79703 DAC
  MAINTAINERS: Add maintainer for ROHM BD79703

 .../bindings/iio/dac/rohm,bd79703.yaml        |  61 +++++++
 MAINTAINERS                                   |   5 +
 drivers/iio/dac/Kconfig                       |   8 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/rohm-bd79703.c                | 162 ++++++++++++++++++
 5 files changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/rohm,bd79703.=
yaml
 create mode 100644 drivers/iio/dac/rohm-bd79703.c


base-commit: 4d112ebd02d10faf202aa8335b06de0aca8b536b
--=20
2.47.0


--PZ+NvlxHLXMmC+Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdkBcoACgkQeFA3/03a
ocVK4gf+IRKgfN2/zqILGTVf3xvBKsvXRs2F5ZGdVkVmFFyZJvpHOXBxKL+DPNRK
hR24Xg6OcorZN1+OIPL4R/h07gpfmYV8CLLTYRIvkHR014jv44F+9HTAaVhNzQTr
67tGtQ5uFRNGTTsj/sfzeLFaRDLhr6NXkj4pVHbXzSZ4si301wSeM2l/z8i6E+p2
ZKWgQQ/X2gM/mReDvtN9IvL/fErjeIcDhDbY/3YB5uCOkYiREABLIe4Qm4z6RQk5
bWXpgF8WdYzWSDk1YQ9W/wtGWGoWON1a5j611fsQ5ecF/xZVIsFJmNNTkHTnaEp4
K46PPS9NMQkGAWShyAZrXP1BZ9C4XA==
=cZvR
-----END PGP SIGNATURE-----

--PZ+NvlxHLXMmC+Vu--

