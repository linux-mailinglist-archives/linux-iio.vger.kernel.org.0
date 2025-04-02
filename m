Return-Path: <linux-iio+bounces-17536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700AA78839
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0F93ADC3C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7EB23278D;
	Wed,  2 Apr 2025 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSCFLDfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA0231CAE;
	Wed,  2 Apr 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576269; cv=none; b=ZcVEZDQzCtf2OeQT0H7bXQcPIVhj/diA2fgifC/fXSX9gV0yAfbcZPqbGvppeLC8wn2mGXmfpTW4aCJdU7FgjHVfdjFe9Vg15e3S07Ql5r2ikCU31JAEB9K7qyIT9zfvrByZgwiwR+jPeXUUkUi4/cc5VkvNZLMunEJKZx/607A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576269; c=relaxed/simple;
	bh=wvssUiaAajsbx1V1+ngVwwFLBdfRJOeTQZeabaLQhAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zdf0ds6ImKW4mpGBxFiuSuBs8w9jlrn3LPNviKwWzMu3E2QMvARou70UxcxbJ7Kt9nwVu6mIf705gYP8jmkTr4twO1KpPTiVoRGqC1ZOiOJch3og9OwTB903OeYfQBjBXGTA6jmmIWVSD9DbycAI7S/Ku+RXcl2lOOVFO3FsRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSCFLDfg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54af20849bbso5013775e87.0;
        Tue, 01 Apr 2025 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576266; x=1744181066; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ai+KjUdgq7U8qh2/AfcQIUCKsaxgpkUx0SXuCgrqKU=;
        b=DSCFLDfgjOwHnvUFiZHKKUOdnYYkF6IIpOH/WGfMg9LY619EOqGV1XXdNSPs1tubIB
         bUjkivlW96cJ9qAnp2BHT5+MDYaVwcbkKqQtcIJhPrZFyMxiWBBzrQEU4fsWG14qkpCT
         T/knchzfSlBy5faFPSr+Lz45ITAED0GlRwEeA4o6rzH64LdkzBTN8RVVi/IyI5aoTGE6
         fbRZfeQKbEbB3j9INLK0EQNUWVPRMqnqmLCbzCmiguhzKCoha/3XzfYmooBn0vb/l4s5
         IxvwFUp08f2tu4UCJYcbGBZyABxoJFBPWL57bmCVjTklak+X+0Uv8+UG/du81udGKiVZ
         0G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576266; x=1744181066;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ai+KjUdgq7U8qh2/AfcQIUCKsaxgpkUx0SXuCgrqKU=;
        b=IMkIq8vizVMAkw03PCC3mD2a9i3mbc7dfHE/KEnvF1VfyP4W/UBOKo1eQsQfWlaRlu
         VyWlsnE7DKonMmg84Wxh7ZZQB7cB1wIPNPJ3ugRa85+/ku8qSQDqKXxmzS/rUj9W6iaC
         eO4rOPYgasPZqGXJAzHnMCHZlYLYRCCV9JmXkdUjmXTryBRNQ13afbwQgZBAf3z4ZzDx
         8JXTroxtCGctVBywzRQvl35TSu8i9uK8ZPV1qkph2Myj8JNkqX1uF3JgVMqNUndkAdiA
         56KA4GJJIgplvaEdUGE5mdunk1SJbjwH5F8wX0tBeNmRboVlKNgvg9yNWuxkJTLBCqBO
         SyLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBRQjYa3zT2wN5Ue5aP1jQ2oheQOAdRuj41CRzEGFt7jEGQrFLQgCUuZ7okx0S5C8KZ8iUd5QdimW9@vger.kernel.org, AJvYcCW4He4wvyn99uCqBVD7OhETFr/Z+b4Hqg12w7r8m7nq2v36uRPaNH2B958akBhhxXTbgOgwi+bLkdUf@vger.kernel.org, AJvYcCXIDbCoqy8VZCa64tU1GYyJ2tiHuo32BLuZVOiVp+jzp6VUXAvZ1luCsyQ44+xAcYZRPxj7uR77zX1Bve6Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzKj5+oCvVvGv6qiXcR8C1bBzIbJhUgLv9+Y8bbn77J3bxIMusC
	C1hYG8o6VU4P3G9oLaD//fKL2/kS49vl6ciW7F7zqCtGoMdtA8f3
X-Gm-Gg: ASbGncsNmWN1VY0Eoiur312uXPdYuhWmDXap0tTxUvkI2FQ7J9hWLJYVzgbr2W9balD
	QKO5MVNx/L/gZSEXEWST7Q8nJ9LhQ9FeegdsKX4zPU4dpQIhabn3GGEi6AOQ2oJfRXYfVZr48LA
	AbnjHj2EcFXlyN1j7Ka/CWCdGKvAfTkGdZs+i317f6DvyV3y4EwwfYaen6YmoshhFFHqZnLKZ5F
	1rkmCTyEPqV+69OkQeq2QvtKADFOjgU4fcRJP3jG4BaqIv0NfGqTbBumPHQBMt1AkNKLWbahEc6
	Ay5T3lPn7EjGodru8T499J7tkOFHuXylMmFrTuO7OkkAkpTFE9TDApZrval2YQ==
X-Google-Smtp-Source: AGHT+IF+2OKSId8d/Y0oPhayDuyaGknQL5XNMTAv8kgbf9fXRWfj0r9px7Szmyk9qCVoqc22GMM6lg==
X-Received: by 2002:a05:6512:baa:b0:545:4d1:64c0 with SMTP id 2adb3069b0e04-54b10eca960mr3890070e87.27.1743576265850;
        Tue, 01 Apr 2025 23:44:25 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b095806b2sm1545423e87.155.2025.04.01.23.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:44:24 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:44:20 +0300
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
Subject: [PATCH 0/5] Support ROHM BD797xx DACs
Message-ID: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="coY4FNYkVBrlXXH4"
Content-Disposition: inline


--coY4FNYkVBrlXXH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD797xx DACs

ROHM BD79700, BD79701 and BD79702 are very similar to the already
sipported BD79703. Main difference is the reduced number of channels.
Also, the *00 and *01 variants lack of the separate Vfs pin.

This series adds support for the BD79700, BD79701 and BD79702.

---

Matti Vaittinen (5):
  dt-bindings: Add ROHM BD7970x variants
  iio: dac: bd79703 Store device address to 'address'
  dac: bd79703: Add chip data
  iio: bd79703: Support BD79700 and BD79701
  iio: dac: bd79703: Support ROHM BD79702

 .../bindings/iio/dac/rohm,bd79703.yaml        |  33 +++--
 drivers/iio/dac/rohm-bd79703.c                | 116 +++++++++++++++---
 2 files changed, 126 insertions(+), 23 deletions(-)


base-commit: 543da6252b48bbfe13e194fb980bdd2b161f6838
--=20
2.49.0


--coY4FNYkVBrlXXH4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3LcACgkQeFA3/03a
ocXnXgf/cmTK9neGOPdoxg2ccvfMBTyB8gCkxUE/LRGqbfHm4pdeOs/2lV7ud7vE
5acK8OSAThzbTCJdBJrw3bXdH/g1tNHDPfMpiKP3VGPMxzy8y2pQXQ+DYvCbpBny
HtYGaFBClGLMYjUED1enMUkTF0AVT6+bc8Knif8P+WMJpDXVsZ57JLtmToXAwYrG
LJrwb2eCRUHoL89idgXgvdO9aZQCT6c66Sn7QMNOwF+27UuzjnnfBow2efWlqvTW
H/ovOzTC0vJmcGRyn8+YRPgL3xzci/jz1fi68tFnKqNrfvYZRv64qc/j7O6vZscu
4R5epaiJ3KMOeXKAJavTwYWh/0Rlmg==
=srJf
-----END PGP SIGNATURE-----

--coY4FNYkVBrlXXH4--

