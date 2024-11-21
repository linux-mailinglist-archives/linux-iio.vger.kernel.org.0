Return-Path: <linux-iio+bounces-12443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E19D48A2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE36B1F2278D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9ED1C8FB7;
	Thu, 21 Nov 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR68RSX8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5574502F;
	Thu, 21 Nov 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177179; cv=none; b=Hk1/Kf2MOJUT2hdOgIe4N7HLRyFfcH4PRkSPbr28POvb/uJTltF73YxRUieDfgNMMWuFADzz4ApO75pB6ha5PbrwBNb0ONJuUI23+vhvhoGcTIjcJT3HZ11vfVNFnXCBtpFYFk5bf+EtTuawaKd5sz1l34FXTxrt70XjCpSGvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177179; c=relaxed/simple;
	bh=WPdD5/UEOPjLoF6A+GIsLEj9CnaP14w3kT6NsIlW4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CcZ/LIcKdSIyphqmWTaydN12+T2CTdUPqrrRI0OmMZZL/uKIo8XfLYlrKCnt5AzRbW8jPNC1qOHBUIbHtu26rVvdb1y3HHWV/ark3EQokjbzJRmbn3zlz684z6MslIkyf8cNSUgLh9znXI+TKNATBLbGeKXOUnmHZLWWCzT2dVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR68RSX8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53c779ef19cso601770e87.3;
        Thu, 21 Nov 2024 00:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177176; x=1732781976; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFdEv+UI9GjMZSRUyorsGzJEYalDRkuczdcBGUSZQTM=;
        b=PR68RSX8nVaSAxNfTvSd0+5Dv4kyD1I34KlrOK7OzAEInu/vDaXUu4LJokwCMBkQwP
         KBwKlFcvvNWacm0/AG2SYhbE/F6HYI16lAucfy3UaqbYj8MzrhLN9gmlisX+pjXzz4Jy
         xCDyjbmwgAPH4UytPo6wrkt68/uqptHcmFiX9/ZhjXZu/P2WleEp3GIb+ddhnhwrsx2W
         brF2yxBUNlcWYoFCyvqgVtuW7aQYoUpWbNNqUUsN2gHtem0ZvlihNgtjV/i7zHtmgYxW
         AeihxBC40zBX93MULr47gj1HLieA94NgpX0cc1Mbi8gXxBGfRh43nAw+GBuGcwT7WogG
         kU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177176; x=1732781976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFdEv+UI9GjMZSRUyorsGzJEYalDRkuczdcBGUSZQTM=;
        b=ASyzEtle0/14EzePuzAcRMygJVK861upUi0hcuDVBx3jE0Zw9NCWVWrdGCmQJhKU2v
         5igowI67UTawivADRAYm6WZS31Ct7cCiJLHDHv37xbBeykOYTLBcVRcxhCUqpjCm14vT
         vJ/MYOMhGMCcm2AO5It1gHZI85hyTJXJQ4hsxK54MQ6suZCtXhyM7X1taZFhwyx5EZSa
         XYpQYXDGJ4Bb+XQBHLX9MLlnpBc8KVKlybvzeBwajc81Y3bu2f0akQKRV9L1G61eCkU5
         HF5kK7cE1ux2XiVV9BeP37BldP0z3xitImxdRk45ESPWQFISyv2FlGPWseHsnJIT1qr2
         HfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvXifFCurvBYLPQMugldEO44JgBkS3m7KQuzg1fXygjAgVQ1WvnkNbq1RdiCmuguEsypr/+tBVY4OA@vger.kernel.org, AJvYcCVBjZVVEZZ2TBPUxMtSwshw0yTM6m3qJVFVWvYJxsmngoWHCpfwWtNaP5694GJJRM5JcQkGjeCpV0WK@vger.kernel.org, AJvYcCXwoDBj5Gj0BYnfAmlbbWapbD8RgWFnHC/YW8xLzuFlKY+KEwVmOqC5DSIMqWIYJYWT/fAmeA0rXUau7H0f@vger.kernel.org
X-Gm-Message-State: AOJu0YycMPyuGVI4L/JdL369WIc4fsusbHsPwCSwLs8zAMiTLFQsRBI0
	iwvZ0ljBfb1+YPIOcBvzB6KK6Qh7i/s6s0s732QVYDwXeqjRmseuASY5cdq2
X-Google-Smtp-Source: AGHT+IHhyhrhbQSvtvUTpaBHdlwQYymca0wYStYyTz3imcKjZYpxET3kcRP5cRgFg1pAlCdVehN2eA==
X-Received: by 2002:a19:6b15:0:b0:53d:c15a:307d with SMTP id 2adb3069b0e04-53dc15a328amr1871624e87.45.1732177175518;
        Thu, 21 Nov 2024 00:19:35 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4723c0sm890050e87.194.2024.11.21.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:19:33 -0800 (PST)
Date: Thu, 21 Nov 2024 10:19:23 +0200
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
Subject: [PATCH v2 0/8] Support ROHM KX134ACR-LBZ
Message-ID: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+z5gtmrLHvQWYdLR"
Content-Disposition: inline


--+z5gtmrLHvQWYdLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch series introduces support for ROHM KX134ACR-LBZ and
KX134-1211 accelerometers.

The KX134ACR-LBZ is almost identical to the KX132ACR-LBZ. Similarly the
KX134-1211 is almost identical to the KX132-1211. The differencies
visible to the driver are different g-ranges and the "Who am I"
-identification register's values.

This series does also convert parts of the GTS helpers and the kx022a
driver to use __cleanup - based scoped free/unlock operations, and fixes
the value of required wait time after sensor reset. The wait time value
fixup is cosmetic/documentational, as the time that has been slept has
likely been larger than required due to the msleep() implementation.

Revision history:
v1 =3D> v2:
 - Rebased on iio-fixes to avoid conflicts with queued fixes.
 - Added the reset delay change to the series to avoid conflicts. Was
   previously sent as an individual patch:
   https://lore.kernel.org/all/ZzWfXbjaDkFnu_Jg@mva-rohm/
 - Added support for kx134-1211

The v1 can be found from:
https://lore.kernel.org/all/cover.1731495937.git.mazziesaccount@gmail.com/


The patch 1/8 is the delay fixup mentioned above.

The patch 2/8 contains GTS helper change, which is independent from the
rest of the series. It can be applied/rejected independently.

Patch 3/8 changes kx022a to use scoped mutexes. It can also be applied
as an independent improvement even if the kx134acr-lbz support was not
added.

Patch 4/8 adds mechanisms for supporting sensors with different
g-ranges in the kx022a driver.

5-8/8 add support for new hardware, kx134acr-lbz and kx134-1211.

---

Matti Vaittinen (8):
  iio: accel: kx022a: Improve reset delay
  iio: gts: Simplify using __free
  iio: accel: kx022a: Use cleanup.h helpers
  iio: accel: kx022a: Support ICs with different G-ranges
  dt-bindings: ROHM KX134ACR-LBZ
  iio: kx022a: Support ROHM KX134ACR-LBZ
  dt-bindings: iio: kx022a: Support KX134-1211
  iio: accel: kx022a: Support KX134-1211

 .../bindings/iio/accel/kionix,kx022a.yaml     |  11 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |   4 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   4 +
 drivers/iio/accel/kionix-kx022a.c             | 170 ++++++++++++------
 drivers/iio/accel/kionix-kx022a.h             |   6 +
 drivers/iio/industrialio-gts-helper.c         |  19 +-
 6 files changed, 147 insertions(+), 67 deletions(-)

--=20
2.47.0


--+z5gtmrLHvQWYdLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7QYACgkQeFA3/03a
ocUxdgf/WIjdPxRbMVlVfOS1RcZcxBagWdrHGmSaHVbs1fc5gDm3E/VcxO/JNBR5
kYhooddWQ1z/8zixVa9rAoXzP5j34b2PfvYuOTAVynUJ0TAsouNMbAosZ6dKhbN2
I1sxIR8lzpzXikv/VIQG9rv3nd8FUi/i5b2oKOS+081ifyydQyr5JImUigg6Iwf4
6sdUgksO8ZABXEvOiFU/KdSEzlfK1KUFLK905OCK2CthHn/DxhUycmzVw+JIz/85
YeFhEwFawGY2YhsuVqmvKMAzjuP6B9RiR3AimSmDjmWJcDLmKs5gIs1xsHJwpTFU
m94x26ADD2VZkLSlMXCfJq0xnaqNHg==
=dyFF
-----END PGP SIGNATURE-----

--+z5gtmrLHvQWYdLR--

