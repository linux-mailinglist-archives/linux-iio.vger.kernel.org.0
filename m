Return-Path: <linux-iio+bounces-12794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A36B9DBC8F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F55281BEC
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6D1C1F2E;
	Thu, 28 Nov 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZXUZ7tm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954FAD4B;
	Thu, 28 Nov 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822508; cv=none; b=iR6dgJIrpsKVz225WH/nVaqVe8Nm2zLiB8jR1aTtYMAOr7NkXpy9l4MqO/ucrs/vwuo0xkxnfxO4aeeoBfBE4RQFmLXMXR9TS+2udcyvJAnWJPwr8xzQEyIWxM76WFME7I9aRad5SJvxG4QQJw844ZsFV8HfVSh3EAUOSzlpqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822508; c=relaxed/simple;
	bh=vJODEIaZ2Tk0TcMVGftBiRx4K5pn/fhJg/Vb9eMsC3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lKvG5PeEv98y5PQImgvmpyrmxtucGZyu21HqZFblVNRbP8vXR67/Tpt4vrqcnbTp1CAdkte0mNeo4kYRLd8TLYjOzg5D407uBkzr/w4LZUbWJp+jIgG5KX9oV7oPjW8QUh3CTadFTeTLhyQs2NW2O4ZNI2jID9gxEUnqYCBT70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZXUZ7tm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df67d6659so1811820e87.3;
        Thu, 28 Nov 2024 11:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822504; x=1733427304; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiuBkltoshHqmQZQ6j9L1A2DeubyGCxNG0ntjnAqc2s=;
        b=QZXUZ7tm3FZrAxqMAzDDIEMHLxCr3GdFWstaN5c2p9JwX35MJZ/r3P9DZJH+4tDBw0
         lNwB6fFYfQo7NIKR5y0J18bVZN9x+n4RGPgHwKjADVa/e1Biea4HJQuzY9D2bI050hKV
         s3LPM/KDdrqTJrkVlQzgiXcQB0Wr/QdPnrDu96GGmgY/GyrpsESkVWLKzQUD6IW57gM9
         JNS4YXKs8cTBd0K9vchEuGMvAarClX5yC2XoM1sU/3mIF5kfniCrNdltovygjKwIbRmO
         YjHV6bJXnPpU2kbdlx86MLlO5bbnZmr26d9o+K9OB7284Gv/wB5H7XwttibcM1vXuSRD
         J9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822504; x=1733427304;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiuBkltoshHqmQZQ6j9L1A2DeubyGCxNG0ntjnAqc2s=;
        b=D770VdzYK09snhyc3VEk82EqArmOyz1fYS66IFVJMOKULdkBgAfbsJ63RGtiPlmvUs
         rmShlYbDZ0Xgd/XN+n4DBXnEYu+QK0QNvrev7h11Ub8JIWwchZFK8A1WZ2cac6vmRVr3
         2DYoqAi/EuTMI1Qjjt5sNOGi8Hy8u5j8cjQ5fh+Ai1vZ2EipSLZ8fqE5OQEQBOyNN08V
         z6+vFFctePPIVHR3Gia5KPNiwDpoXZBVJNAGVMfJJmJKcfkJ9e81eDGFoQieFzAgS24U
         R1gh3s4zNXlCQRlTzewskzTXP7mAFrJzBTp/ndXWFUw6gy9fwuO1/rasQVMPkHFkGM2R
         ymqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTO+q73zyNXTIcWUfw/WNaBsFr25spK5l5X7eBl+QPjOCoUErkbRSOYxyQnW8q8Svbbujeahrq3FWp@vger.kernel.org, AJvYcCVmQ+kdbsa2r49enBbZEqifOt22SM4ot9jg2swEXa2fHH0RhN6NJbYd6aDjauTWovoa+cODi8rDdQdl7Y5M@vger.kernel.org, AJvYcCWFeYLuWGhtGCIH5WEFY7LX8WOIWURNGFBR5OD5egI1eOn7oIYYaKeucYIUtpitqf0u1iSx6lJcf562@vger.kernel.org
X-Gm-Message-State: AOJu0Yzly4K0DZiHYtjvtz6DS54UIVos+Tiwxx6uUvMzMKAV45S1iANo
	Aku31B0fz9yEHslJrreY/fHoEmw1aWkbQ95gpZ38ecY3fN5F0kKJ
X-Gm-Gg: ASbGncscwSSIJLtjtI1qnteay48ht1AZ3SH7Clt8HnSoAjIGW6toxkNb+oe0x8Jb8x4
	K1ZeX41KtHtIdubWhNkmuByIrmhDzFzxxkt6HejSdsrTTM8Z87230KNZEXX1+3uJRw9YHcQzN+N
	1xTtS2s+CaXSCj/fakzfe0T6rPoWsIcOeyr8edHUdVYhdxlym2AYvkwgds8v3BE/UTPLNCuipv2
	CZcLWnZB8qk1tSoy4S2LmeEm5SLm93QHUe/f6CdYKsrI3/vqXmPZdQL
X-Google-Smtp-Source: AGHT+IGYLoHGWkQJXnAzeKrdRDS0vmOTvQPRKIanLd5PWhAbFb0S2vmelRt0CIpv/ocrMS8a6iOggw==
X-Received: by 2002:a05:6512:3985:b0:53d:ed76:4607 with SMTP id 2adb3069b0e04-53df00d031amr7271570e87.22.1732822503919;
        Thu, 28 Nov 2024 11:35:03 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64433a7sm264469e87.89.2024.11.28.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:35:01 -0800 (PST)
Date: Thu, 28 Nov 2024 21:34:54 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	0001-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org,
	0002-dt-bindings-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Drop BU27008 and BU27010
Message-ID: <cover.1732819203.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2ZuBoV+n69sWCAY"
Content-Disposition: inline


--o2ZuBoV+n69sWCAY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop the support for ROHM BD72008 and BD72010 RGB sensors

I accidentally hit a BU27008 data-sheet which had a big red text saying
"Obsolete". After a few queries I received a word that the ROHM BU27008
and BU27010 RGB sensors were cancelled and never entered mass production.
Supporting not existing hardware makes no sense, so it's probably best
to drop the drivers and dt-bindings.

There is still a RGB sensor from ROHM called BU27006.
https://www.rohm.com/products/sensors-mems/color-sensor-ics/bu27006muc-z-pr=
oduct
Based on a quick glance this should be very similar to the BU27010. If
someone wants to create a driver for this, then the bu27008.c might be
worth looking at.

As writing of this I don't have the BU27006 at my hands, and when I
asked about creating a driver for this IC from the HQ ... I got an
impression that at the moment ROHM rather pays me for doing something
else. So, currently I have no plan to add support for the BD27006.
We can always dig the bu27008.c from the depths of the git, if it later
appears such a driver would be a good idea.

Matti Vaittinen (2):
  iio: light: Drop BU27008 and BU27010
  dt-bindings: iio: light: Drop BU27008 and BU27010

 .../bindings/iio/light/rohm,bu27008.yaml      |   49 -
 .../bindings/iio/light/rohm,bu27010.yaml      |   50 -
 MAINTAINERS                                   |    1 -
 drivers/iio/light/Kconfig                     |   16 -
 drivers/iio/light/Makefile                    |    1 -
 drivers/iio/light/rohm-bu27008.c              | 1635 -----------------
 6 files changed, 1752 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml
 delete mode 100644 drivers/iio/light/rohm-bu27008.c


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
--=20
2.47.0


--o2ZuBoV+n69sWCAY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIxdkACgkQeFA3/03a
ocULKQf+L8iz9xnbZfAUoNrlOioNgQ/gUbdDHuxJTkAtW7H/VXE3mjRjLL9hzdW8
sRRh1zvnIEwcFH8dULwI5WHdnWE4VTtqySmO70KUNBG5mMj5EZAWU0I65JG9oLqW
1Vf8JSM1dhKDVmTFWzSZ7BAUBQmOuiVzTJrAlr5dbI9HSoPisw7ep5dE2QJEveyf
BHi1SZjIQbNqUEBwLOVakn/1YBFC+SleADhRtLAxGYhDMiNtHm2Qe7YbEkYpUINx
f88JyqVHJRwGtcUVDbiwMaqayWURlvHixfUuC/Zr7oezQQ+08h4ztiGVvIYr/N3W
ET4Gqj/W/Qa4mWv3eSbF8mpDaK/AKQ==
=V+y8
-----END PGP SIGNATURE-----

--o2ZuBoV+n69sWCAY--

