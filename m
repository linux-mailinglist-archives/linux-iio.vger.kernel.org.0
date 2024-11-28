Return-Path: <linux-iio+bounces-12765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5959DB46D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98853B21164
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8614F115;
	Thu, 28 Nov 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmcgnCHu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814752F88;
	Thu, 28 Nov 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784494; cv=none; b=RR6mA8aJN2Ua8N0+ngagMV94mm5f+DN95rNvohhHZkWOxdmY+kNKB24rBtmis1/NU2aCdeAAf+QKy99vdNwUXbEUndv3p+0OKIAEVqFoTTgmhcqD+GEfGPWxo5maa6H1NTdNbDh9n6NWXV6HKd7w1Ix9KmPvEf5DJgy+OO7P3d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784494; c=relaxed/simple;
	bh=tCgJB+cRsC3uIKktRkpoCoPQuGPMLOY2ZbaYLoeh15E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dd66t24QmRqk3KCtIv/PBsOaNixAPKlBG+uGb+QaaZ3REFPzmpNQO4g6MMUoLTtD42kEqjc6vnCK+BZrrrc7X/f6ZZ+aJQy6pY8Qilqmp9Y5YBpzRtZgIkij4uQN+9N1HdzpSTBUUQmIZzckgB7VdJZgJSudi4Z9csOWF9YNqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmcgnCHu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df1e063d8so610781e87.3;
        Thu, 28 Nov 2024 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784491; x=1733389291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjTtkWu0bnm1QLBvUjT3NH9Dn5DWpbeoLUOPvhQvgAU=;
        b=lmcgnCHu6LqIxBFQv68QU4iHV+99j2Ym/ukJKrFREsOAQ1n/SoycqjXrE5AUC2wXYb
         Ob82cJZxjYwwenHQzy1Qcf6nGEwZmTFh0XpJzyju46MX7fx1blqfpttLCnjfGLxagMcU
         Zjj3WIPeH/lDRe7raBCi7Qv49MircUYtZhcF/PsEnGYHhyrf0PR2htRZimelj7xslHHS
         DkzGgkTJJyKQrDSlU1WUv5fPxNAC4uItn/0j3UNKduJaV31nojmDmDRexcGM5ONpHC8C
         UH5g9rrbYImK/pNzkERMX1iYwBPVYRccTDRwCYYeuGT/WlIiH7OYw2nOP1cCj14qIB60
         QiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784491; x=1733389291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjTtkWu0bnm1QLBvUjT3NH9Dn5DWpbeoLUOPvhQvgAU=;
        b=If5HLN/sAC7Xgvko+MFBhuVbQj3efeCe8osXtzFp/80KbNDR/bhd7sZBPR6+YOjjcp
         TMax0+2huf3p3yBl308biywuGnFYpha1MQU3iNstfeazB69D+S1B7Kt2jLvBEbfqHNGH
         U00pBw+8ansU1qc60ss1c4emFocQ6x7Rn9X6IXSEjSNbSQ/bPBFpo5id45vGuNyBB3k7
         xdoXCZV+sQC0v6HJtIwPgYf86UtNIwtbAuygAg0Owj7BllYd29vVN8SHwNPAZDkJPdYA
         RkBE6npzOzT9c+uvmbG86L3ktCmwJbzgVlW6jqMMfRXVyrqjQi/xb0CFnNXbZMu7f7Rr
         9vWw==
X-Forwarded-Encrypted: i=1; AJvYcCUytQQBxlCnp0CyT5t09vqAa9TAvKRbCHeVX5itgo7BAqx1bBheNVJln4yBivIZI+N8JBT0I+bi8noZ@vger.kernel.org, AJvYcCWCEMSAFR0uH5FNVAkU69lHyDpAS1M4dC6ue9cHRx7dmxD3J4JCQYc1bVlT82hpiqPSi66RmESC6vvb@vger.kernel.org, AJvYcCWcijPuSSg7Yo9aY5gZGZyuw+ZDjKG0mgq55x0ayJkCRJUkY6RfICaMRkyvaRp9I6B9I5WTu9lPDICANccN@vger.kernel.org
X-Gm-Message-State: AOJu0YybLQ5rDEci7ogIAxuK3o+cVcBRyr22Q8AjE+Ij9vLZ4Jk6nwVq
	MTAhz9yF3fwMcjTgPnxvtdEMdMV3o7knRfEpgjUP7j/mKBUUdpHT
X-Gm-Gg: ASbGncv3tOc8C7iaZyQ4tyv79VOna7F8oDfYGd7CvSGrZe1OuhGelnx9vD/zKekTBOi
	3cBHLEjfEj7KKmRQQGkAlchCmrLjD6RJODTayBhNCV03WADAq/Gg0Pzj3ssiT5mr0ZSLAOsa+UT
	yeknoNvhEjVrsJma8MRZsBLW7TwH8fyWXQO4xlyLcHdeX4RK5HjXVa1N3wW/3ZosdXfEuCuPQXe
	tFHRahp8VQq8dAdeENktSG5i1yZwO7/jx1hsaW0zBN42277F6mV
X-Google-Smtp-Source: AGHT+IHngURtjvb5FulsYPcB24f20uEabO31eosgAlr/GoFtLwVBk1igg+xWXPDB1RSU9Td3ZXWofg==
X-Received: by 2002:a05:6512:3c9c:b0:53d:e5dc:eac7 with SMTP id 2adb3069b0e04-53df011267cmr4039824e87.55.1732784490621;
        Thu, 28 Nov 2024 01:01:30 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64964efsm113193e87.194.2024.11.28.01.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:01:28 -0800 (PST)
Date: Thu, 28 Nov 2024 11:01:22 +0200
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
Subject: [PATCH v3 0/7] Support ROHM KX134ACR-LBZ
Message-ID: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TzEIvRldgEISf33v"
Content-Disposition: inline


--TzEIvRldgEISf33v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch series introduces support for ROHM KX134ACR-LBZ and
KX134-1211 accelerometers.

The KX134ACR-LBZ is almost identical to the KX132ACR-LBZ. Similarly the
KX134-1211 is almost identical to the KX132-1211. The differencies
visible to the driver are different g-ranges and the "Who am I"
-identification register's values.

This series also converts the kx022a driver to use __cleanup - based
scoped unlock operations.

The last patch depends on the if_not_cond_guard() - which is not yet in
iio/testing. All other patches should be working as they are.

Revision history:
v2 =3D> v3:
 - Drop applied reset delay time fix
 - Drop the part converting the gts-helpers to use cleanup
 - Add patch which gets rid of the lock+disable and unlock+enable
   functions. This depends on not yet in IIO-tree if_not_cond_guard().
v1 =3D> v2:
 - Rebased on iio-fixes to avoid conflicts with queued fixes.
 - Added the reset delay change to the series to avoid conflicts. Was
   previously sent as an individual patch:
   https://lore.kernel.org/all/ZzWfXbjaDkFnu_Jg@mva-rohm/
 - Added support for kx134-1211

---

Matti Vaittinen (7):
  iio: accel: kx022a: Use cleanup.h helpers
  iio: accel: kx022a: Support ICs with different G-ranges
  dt-bindings: ROHM KX134ACR-LBZ
  iio: kx022a: Support ROHM KX134ACR-LBZ
  dt-bindings: iio: kx022a: Support KX134-1211
  iio: accel: kx022a: Support KX134-1211
  iio: accel: kx022a: align with subsystem way

 .../bindings/iio/accel/kionix,kx022a.yaml     |  11 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |   4 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   4 +
 drivers/iio/accel/kionix-kx022a.c             | 262 ++++++++++--------
 drivers/iio/accel/kionix-kx022a.h             |   6 +
 5 files changed, 170 insertions(+), 117 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
--=20
2.47.0


--TzEIvRldgEISf33v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMVQACgkQeFA3/03a
ocVQ4QgAhHp0bdPb0TYtBVxsLolpz67ProoFs3RBK87sunp6sYCXvQqEmSyEcQMG
abKu4A90rlU/s4RR+dJSKMzcbgifGve6eQKjPVVsFQX/FKVmJXO8qHiYXbJhhvFv
ZwqMTFuFkhm8jC980UsM/DCkF0xU6Qe8jpZXK4XCg7tgonEio6KgadOq54dxGk6+
CSg5Osj5P3Wplg30h6YjyaIfLq1acw3Ro5xog+qEakc5M8uZFzeX8I2TMw+cJ7xk
QAF46AUyxywHCY04wXURPTWvHdPCB93JoMFoQ4EPtW8kkMb/ssQ77aAcE+LCnAvg
VHrMZFObIxyI3/tdd4CxHXsdQEY88Q==
=HMc5
-----END PGP SIGNATURE-----

--TzEIvRldgEISf33v--

