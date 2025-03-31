Return-Path: <linux-iio+bounces-17400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED1A760C0
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E563A4D44
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783041C84C4;
	Mon, 31 Mar 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP1aKwpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B933F3;
	Mon, 31 Mar 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408090; cv=none; b=k6PJSvC5RlYCzIbGKtdhWCsaGzBtw9vWtHPCniKOmikSiQTpGUY0f3NEgZQOpu5kwlajil7wU5EkVqsOrGI3Oe8lLKU28HId128r+/iurpW9fZUy6qA7+N4uMJ5euo/csvO5uvtEyiO9qZIvbUTTAq/HDm2yklkxpFOKcv08zuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408090; c=relaxed/simple;
	bh=P8LsdZh/1QZk+PoV0d1VmLBrJl+PNoKFYEZEwphdA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XetpT/+pPFFUJwKVk45fXN976274Ptd3Tx4r5JiKsNNGEziTwLddMZqpkUQC9FJxUGk/oFKP3WhbkDNLTMcBuvkzhGYsW4igZU44F47hljSyeMRw6j9rDjgiAoxLND5iQ6sAdkSy1iNUIaP1XvPOq/4595q4fVrc/I6Y46aVUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP1aKwpT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b11e20a31so1948315e87.2;
        Mon, 31 Mar 2025 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408087; x=1744012887; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zur5nn2NL7IuozicsGSPwPOUuVgdhdAFZtBxMhXuFCE=;
        b=mP1aKwpTYXTCONjrWuFihdcns7ha3BehFLdD3IyGce6MuLPbrkyjCwbIL6wykPDQo0
         do5R9YAuVN8HoqUA3b2PS832WK56kM8UfT0rw5wMZOsQ+iY5dSlkfhoWOS+5MdL2HZCp
         +vD3yQASRr2WqtrlVUYxPTspFxg81JiwMgkZcPuumDGfsrIMq4tr417a1O2x9bZEqcAn
         NhiFrhF35QccglVGzIueY5UEMSgqrtNAiEHyOwJ5thZ76Ze9W0zpY3ItQQ1sTJB+/Uie
         ReYut7pSfvlWCVgtuwnyVRZ+deiQvMe0eL6eaTmwXKPUwzwrHAFLr9IsBqTa02cCYUVl
         J1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408087; x=1744012887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zur5nn2NL7IuozicsGSPwPOUuVgdhdAFZtBxMhXuFCE=;
        b=jLxbOemHNWjoEwaZCqfCl7AfLded+e/ALsXS1irlHRIE8pMOuPgjWQqdM7AqS7uJOP
         ZgnJo3IbvvmJyIh6RbIUUJ9LbDOieGLGWWmoafY09sgwxmDa9uTH3iKDqY00KM17o+YN
         H91LkzqZ0MNAhjSK6K0ZRvAE/jke29pJ5zJ7RxTVOulZXIC9TU+7XslyG5oXY+XJuMRr
         rz8PFUsX03tN5zJNhw6mJmtQFw6sQ0BS/JB4cE/2yVvAS3bQJrQnOoEe8NQc0q79zi/9
         qiz+2eZzYAZccao3ZPYcknFJiAKfNmS+FTAvC6HTRCd4iXIqEHI5+2HrunOC+rsHo1lz
         Legw==
X-Forwarded-Encrypted: i=1; AJvYcCVxbkmYqdzcOFlViIjgCUNHijwwRKMuxHL9p9EoXYUKqn7zNAc5DNxXzWtpQzHcF2DlnV2pdJCmUdTT@vger.kernel.org, AJvYcCWFEwPXsZYD9GxDcMoo9s2NAEop2A6Ahgn343Zfs1f/mN6xYpQpMwbZgaUHI7RQgStYwiUioZhxoSvX8E9x@vger.kernel.org, AJvYcCXqh/ytaEu3SIr7949LZlCRoVjwCxp9pKkuLJu3pPWZrKBsuQTM6PEItltLeuW3qSLHh7Dy2W7dfq0c@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMqC5ONzplj8N2Fc8fts9mp0ecggHsKqLOHfTEDVqTuf34IQs
	Ovssr3Amg66d2R/hzrcCjrFQyQexbBPB3JsvNSOPLOv1jz+nqcIZ
X-Gm-Gg: ASbGncslKOHxLMfTanLqJSX35y6VkB8mKSVmlUQP8TTIBIvKlYlUnbpjqoYT6rRd45t
	H3bdGtVHSxO0vm8kwMxpPakdBmO7TXW0XsppNXeDrTs/TRr8sDcROF+fNV1UI/WrWBPfNBE95g+
	SE6J0oCQvwRK4ZJI6mSfYQcKIfvpyWjn8pSp+x6j1zz5AbWx8CByVNYLjWcKFqtLVVih0mMI6Qt
	z3V5qBPYssjDCO0jZ2bNUH6RV+kos3FFPkUxRiTTP73PGN+yKQ64xKgOXItRvxWTQAAPcEPQoCo
	14Wqg4pug03s9UCP0Z1A7Y6Pvo1rdRl9AFGVM9KDBu0ghGExQnI=
X-Google-Smtp-Source: AGHT+IEx/9wiZYo5gwVCXWcnn4okiErtjVcnUweikH01b1Y/wRlJLMlCLohF+kTktu1ga+TW5zSt7Q==
X-Received: by 2002:a05:6512:e9c:b0:54a:d68f:6ecc with SMTP id 2adb3069b0e04-54b10db7de4mr2099868e87.2.1743408086414;
        Mon, 31 Mar 2025 01:01:26 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09590d71sm1073557e87.161.2025.03.31.01.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:01:25 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:01:16 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Support ROHM BD79104 ADC
Message-ID: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OrT+kjxloHse/l6n"
Content-Disposition: inline


--OrT+kjxloHse/l6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79104 ADC is a 12 bit, 8-channel ADC controlled via SPI.

The communication over SPI uses similar protocol as the ti-adc128s052.
In order to avoid code duplication, the support for the ROHM IC is
added in the same driver.

The driver side differencies between the ti-adc128s052 and the ROHM
BD79104 are related to the supply regulator handling. The BD79104
requires supplies for the VDD and IOVDD. The ti-adc128s052 driver
handles only the reference voltage supply, even though the TI data-sheet
indicates it can also have separate supplies.

Hardware vise the ROHM BD79104 requires SPI MODE 3, and has also some SPI
frequency limitations.

I decided to add own binding document for the ROHM BD79104 so it is
easier to document the SPI limitations. It also allows using the supply
names from the data sheet. And finally, it gives users of this IC a
better hint that it is supported.

Finally, I didn't find maintainer information for this driver from the
MAINTAINERS file. I would like to add myself as a reviewer for the
driver, so I can stay on track of the changes to it. AFAIR, having
R-entry without M-entry was not appreciated. Any suggestions how to
handle this?

This series was based on the v6.14, but it should apply cleanly on
iio/testing - please let me know if I should rebase.

---

Matti Vaittinen (6):
  dt-bindings: ROHM BD79104 ADC
  iio: adc: ti-adc128s052: Fix ADC value on BE systems
  iio: adc: ti-adc128s052: Be consistent with arrays
  iio: adc: ti-adc128s052: Use devm_mutex_init()
  iio: adc: ti-adc128s052: Simplify using guard(mutex)
  iio: adc: ti-adc128s052: Support ROHM BD79104

 .../bindings/iio/adc/rohm,bd79104.yaml        | 69 +++++++++++++++++++
 drivers/iio/adc/Kconfig                       |  2 +-
 drivers/iio/adc/ti-adc128s052.c               | 66 +++++++++++++-----
 3 files changed, 118 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79104.=
yaml


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--OrT+kjxloHse/l6n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqS8QACgkQeFA3/03a
ocVfaQgAipHMyUcaDkkMKa5olC1mcerEhhNSsdxfbcna+aiIOXxzlZfiks2dwMtO
PlSBKBQkaLNtZQ6hW9QTSerq74TL7/77OLksDnB/Fb5F2RKlouJh8ScGWNxyQYhM
U32pr20gfj+JnqaOzPz5nDuYW865YqaWpsUI8UQsoUNmSPgG3zcmFglkgVW8ADVM
QchTYdNGKB9pA770KiGOxxRqjxMaDg/WKPq+mInKvJNbPXdogdtu1ehV3/Goy1Qc
7QxfA2+azaZTQC6HW3d3Oeq3J9JdBbrqGDmtxl8ZAYLD12WqI5JgF/KDub0RpVMb
VCpR7o0BHB51TtvJ9WVWTkuYJF6+xA==
=ndOc
-----END PGP SIGNATURE-----

--OrT+kjxloHse/l6n--

