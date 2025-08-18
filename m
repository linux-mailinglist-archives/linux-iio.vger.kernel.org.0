Return-Path: <linux-iio+bounces-22902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF1B29BBD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABAB3A5D38
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA32E5D17;
	Mon, 18 Aug 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiqvaUAv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8F28641B;
	Mon, 18 Aug 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504729; cv=none; b=UGcm+dTWcV2tHg8uKub/JOWV91lIdgnt1fu+fl0Odkq/yhG0GCp+PchvMxZXM/35yIgt/PcjnFwBuk7yjykDygRQpAZ1opU1zjnbO3B84Via0SfxqoyeuLewWVzrJMAb8kjOIywYzhWvVoWK5viidhwhK+ygA6rTz29F3XQyiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504729; c=relaxed/simple;
	bh=rx7j6R/mUmhskfRDsVZVvvBWBYKRFfFVTFbXVj9Acbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ARMqWuU4vU9bgiVsg+I0p6vZQ57jfQcmL+LCW2cn+iogm61tkL/SI1/uUa3Czn/J2wB3fUtDSZPqMlNS1fAjccJlp1CT5/Ap13b8coDUepnsrxWV00exIQdhlk/8WEGZP3+qG5bcV8lBnVi6zGdZtiVdfzfqkhmzXFB9ck0RFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiqvaUAv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce509127bso2919964e87.0;
        Mon, 18 Aug 2025 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504726; x=1756109526; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRQX1fprXSUAl9NEBskzM9Agwa8+JxDSTA+pVEm7VOM=;
        b=CiqvaUAv+orSRGteKqn0VDIiKF0G9KUNsWIvLJmaNvWI3T/D8RkOXFmeSCqzN7CY28
         yZhfNilXnCDsFgvY4JvHEjDIvkGUF+4mAmV0MWNeov1Duvi+celu07lDH9MtcR8rSPEr
         KRdcULYVYutoVvhVlzFHUEKuKIJkocST7YkpZEOlaOBIy2qJqMV3MfQ2wB+6zFxMXWtp
         3EpVAXAyVYh0e1uKLao6JhUd+2HCpgcr058ZeD3N0qCUmNT93IGwmUuey8tJwolhLrDR
         XEAqqsvz77y4chh9KK7M6ygCWUhrZYMWlfZmZQb3aJLivU9pIo7d/sPaNIJrpISRvkgB
         fS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504726; x=1756109526;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRQX1fprXSUAl9NEBskzM9Agwa8+JxDSTA+pVEm7VOM=;
        b=ws0DuZNsfGJaoBbwrQ0FTdaNPrf5U7koB50Odng38qabHcud2jISWFHc+H8xndq1aG
         OmDtGysWOJaM+0PLnCi6y+uuMdKcyOpl6c3ENJHYD2ESeNlpXjJP6q5gjUiCOZW3m0mS
         syVg9ThRVSBYZ/5vMSYbVl8ghk5nzDrCqACmrWJspLXNoDcaJJF1lSSjyRl069A5XELL
         likLkylmBsaidk0cBlDTTJzOhoQb6RMyizbqDv0M4iMNgOWtOd1yz2ymcr3E1Fld1mmy
         2Dx38bXj0FvV2ZntLW8xsa/afL/8kHf1wSDu/RoPhiHu7UdgQIH5YS8hBRUYpVIXZJWY
         57WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcFQ5s56ystduUshCDvA0rqG6HeWgdWc9igBul7p1qAvcINCvGUAYROrkk8Mvth6du2oYK3OzuzOM+@vger.kernel.org, AJvYcCVOVjHgGmnl8RTZHcCF9RFwcsjTjPmBRCaLK4gd5v4DFdES6wixWgGUClK/Q/ShqiKeSpudVofFWpiCHkKc@vger.kernel.org, AJvYcCVqjuTifD6lI2lCn0y1imgI94jSkD9oZCHtRgmny1vgL8m1W/WfulZ+R6NPj1U3uH9Hu/nbIj56YuM8@vger.kernel.org
X-Gm-Message-State: AOJu0YytjrDmngBMo+P62VL891AVeQx5kD41M1jZOmkqSLltenKyFY5m
	xgmoSXfuApjb0I/b3LwR12UATqVuBgVCwh4XSxSWuWGtwl7MvoGORERjl/d2LQ==
X-Gm-Gg: ASbGncvuNl5zEWXUhf7Q/I+ySAe/w5FLrWvDXWdVxglXIPgg0jRxGR1Up7+ncV5gijG
	PD4N2WP19I8sV/I+l8LPMXag7ZIFTjrcSmAUthRGsrO/LGSKzhNTEvGuTr5/s2SkXErq6BvaOHW
	B3H+0GUvZPHdKj3mw9mqtRVuwX8rUxST8Gze2beV3LZNtU8fKYK2LO1N2/YSJZdFOqiK7vbovyA
	LFWZFK1O5lgmWNuHXHpMXpKDN8Vj4Si1WE6cdCtb34C1YOA9pwUmCk81urzoXAhl54k77a9cbet
	/C1AqDdXF1wbJ14PZmfUZgEVlfLDn2kBe/ggK9ricTD5Xa7U7I5fdQFYDLcqhISEdDtNMeyVFzI
	/ERoCKWZ8gP5xc1SMoiyED1CYY4Qwctnh3zwIu+Y=
X-Google-Smtp-Source: AGHT+IGTO49yDhMnwkXyPxsZ9jxEbh6k9E/a8w64/GLWr+EmEpEo/qoppIFA5hfB2Q9QjBxK0vytgg==
X-Received: by 2002:a05:6512:3086:b0:553:a469:3fed with SMTP id 2adb3069b0e04-55ceeaaa76cmr2938588e87.11.1755504725903;
        Mon, 18 Aug 2025 01:12:05 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm1532487e87.13.2025.08.18.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:12:04 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:11:56 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sukrut Bellary <sbellary@baylibre.com>,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v2 0/4] Support ROHM BD7910[0,1,2,3]
Message-ID: <cover.1755504346.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2HZVFUzRKeRqsuso"
Content-Disposition: inline


--2HZVFUzRKeRqsuso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for ROHM BD7910[0,1,2,3] ADCs.

The ROHM BD79100, BD79101, BD79102 and BD79103 are ADCs derived from the
BD79104. According to the data-sheets, the BD79103 is compatible with the
BD79104. Rest of the ICs have different number of analog input channels.

This series adds support for these ICs using the ti-adc128s052.c.

NOTE: There has been work on couple of other patch series [1][2] touching
this same driver. I haven't considered those changes because, AFAICS,
there has been no new revisions of these series since mid June.

[1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.=
com/
[2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.co=
m/

Revision history:
  v1 =3D> v2:
    dt-bindings:
    - Fix the fallback compatible for BD79103.
    - Drop the excess 'items'
    other:
    - Rename the channel structs as discussed during v1 review.

Matti Vaittinen (4):
  dt-bindings: iio: adc: Add BD7910[0,1,2,3]
  iio: adc: adc128s052: Simplify matching chip_data
  iio: adc: adc128s052: Rename channel structs
  iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]

 .../bindings/iio/adc/rohm,bd79104.yaml        |  10 +-
 drivers/iio/adc/ti-adc128s052.c               | 132 ++++++++++++------
 2 files changed, 95 insertions(+), 47 deletions(-)


base-commit: 856d7be7f3c459a6d646b1f8432c6f616ade0d10
--=20
2.50.1


--2HZVFUzRKeRqsuso
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmii4EcACgkQeFA3/03a
ocUSsgf9GQN0Seuwmrz/CsjteZj5vKT5LG0sYJ+n2GvSb/IVmBd6zP/j0IRr/X5q
lMq8NPKXAt2s3QZ88UxFmnjw8oifTEDf8HYhGeVpdWLwub6SOtwRmg6uX5V8AZZ2
91XA+RSk+Gl9dL8D8o9VT687iThh+QAtQIHeGxVoxrR3rmdviAabqGti+IkQvgP/
wJAd757VVp6dOTJFZyzkx6TvUPsBJ82caRxgPlmZ5mFZ4wLEQu1Yd8FJaJTYdDB2
24EaXEalwCnLny6eY3xaq6gt5oauGWn1ArKWYUVFiA+WInczIWzIe4ct8f27rDPr
S/kXm2vbIbky/YLZ9FBpQ3erm+buQA==
=Gega
-----END PGP SIGNATURE-----

--2HZVFUzRKeRqsuso--

