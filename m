Return-Path: <linux-iio+bounces-22429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E5B1E4C8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC6B1899AEE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235221DF97C;
	Fri,  8 Aug 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOZ8DYEs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216B1F949;
	Fri,  8 Aug 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643049; cv=none; b=f0828kEKkxxPUQz4ePYy8KnU7hKVyzlUC487c9s8ApyemLefp7kuPu3qS2AG0TFr5+72UKknxS5zDI0hEvVHx5qMpvoh4hbe4BxEkV/BeuWJHKR5hADOibHB4dkdmN9odPTwU2elvFzqQCWgUozosP7G/oSQKZXKlKJ+YrC6AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643049; c=relaxed/simple;
	bh=zGmwYkBUKarrnkm+CAx3QEXGyzrDtk1jvklu3vcIFRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=isT+8BF51kALgWq1kK7D77DHsUhJObbEYsdmPu4pIKsc2PEyA3M0DWHIJOyk6StqSDP14k/CpLCGDgBmIj11uzVc4A0C2Xj9afDBbPqAAHrAyucu3v6O24WNsQ7a2/mWpJXoF14FIH/ofGo0/jAbmWvIuDlexpF47v/QwfqlxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOZ8DYEs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-33243562752so13546911fa.3;
        Fri, 08 Aug 2025 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643046; x=1755247846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnX9kfy6TjeE9Iz/6dQjqawQL0fq8KuIJ5ysnoxW2oQ=;
        b=AOZ8DYEs6WBLx3XrhWMS+myHJcWdmTtLJPmMgn5Wqsnb9/3anCm5DjNl2l0T6Po3gc
         +AZZnxg2Eo2x6y1WGw+CtzwnzepJVp6vOaz25sMX3dqfNOES5RCp/sMZajjVNHNmsEJQ
         B+IaClSWoB74SA9W4Md9XDwPO1cepv7Z0s3fV+WwGMQh2NXywalXzXpgc2eqzRycHukV
         ILvuwBZmXatbuyAqPU98S/v8k6MJVRdqCoAldZKL1ZH+6RIpQ1zlmFVB0PHHda9gsXTJ
         hWMlFOXlk9gdox/J528reu3DqvstfhhtVWUQRT0TkAB+eCkG2wKPgaljfXtE09ZgSXuy
         mbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643046; x=1755247846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnX9kfy6TjeE9Iz/6dQjqawQL0fq8KuIJ5ysnoxW2oQ=;
        b=ucFvdOOZ3g1UmRhFpPyvQyD/WCdb72+N9l/fCHPBeHqTAPetjvXqXN2lMl4mBUHRPs
         Mjd/j//wyv4VT3JysPinOqvgQQ2y0VGlRP4yxjMliXUWm0mWbdk0FAP8jCDxut+CiXZH
         u8k0+gN8PVoIQD3tfVxMCliz+7QHAhpi+X9a3jJNXIoFT8F8vKlHS0bzgmn+SY2h74LC
         7WrC8IfhOgDoEkoLdgerAJKPofjgjHKRfDH3DHAOpkFoSmYpfY4ZItVAmgJ448N/xStk
         A+CnEnUtpUvFq8PVCQaviEozJzvXyt9xuYr4XCXL0p6McM+9ZRqoVbv/+D5tFtaHC7PP
         V9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUJakcdiy81q2FD58O+I0cfVo7rXGK8YNW1B1cYmKvuiyO8XckLALr3YVh3kRREE6Cj0ZrfqxG1BQ82@vger.kernel.org, AJvYcCVtABvblTd77V4w04ZuIUGnXOnBwkqOYFn7bnHESIVI19QrLW1bkMKfzHm+ytyWbUB/8i9O6uR79DTy@vger.kernel.org, AJvYcCWM8+60Gb0pI5bQTEA2QBQToly1Q0Gd2UoIsxJhtOIvqxWkIvBHRTFsIXwWxsShuWB5pPjK/oUAb16jLibn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyra9q6fSKuG1pIoYgHhWVbZaDz9rgcx0eGB5VKU+K0kmdoGXYf
	yYe5f2F0BpnVszwxo7UVye946SHOJ/rwyqNGgo6if4K6PG5buB4iIddZ
X-Gm-Gg: ASbGnctQcZOZG4s7sVY6O7qnS8/Hqrzk+bGN9kWzsCav9sxFRR1HgvpWzZwYKDNPw3a
	xkFILsA9XTbdYkZUN6fTbN3omDyssbQsbPRL6ttBLCJUGIUI8yYfGNrSSHIpUW+eyYgaiPEIH8Y
	1FS0sFzPeFSytDybpZan4JPu5BwerpY96tGK8Ey65IN+jt7RETUstlNjq6ImYcLwu8rd3Dg3eUf
	bSBbpEGadeYw4AHLDAOiokdWYdXew3g9FdNEFggef49+lZ55pVCD1LBTfxzqdKAG9pIq4G15nou
	WkV8WJhQViEQMWa19jaJUZqneIrdYOoJUaWlDIsSyYXCo2X19EzJywX7MYdx8UFzw3AyedtrhSE
	gw5UhLLQEVe4SK4poKwqPc+UL4zm8
X-Google-Smtp-Source: AGHT+IE+UKzY/9ChBPp5JDLuATv8Sve9ZYNzJ3r8ZVVuz8tgHrTucNsDuzMG6o+MDWAX7vhSJgyNsQ==
X-Received: by 2002:a2e:2c02:0:b0:332:7291:c1a7 with SMTP id 38308e7fff4ca-333a223deb0mr3788291fa.19.1754643045928;
        Fri, 08 Aug 2025 01:50:45 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238275015sm27982681fa.16.2025.08.08.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:50:44 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:50:41 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] Support ROHM BD79105 ADC
Message-ID: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZszCD37r8RLJtKdH"
Content-Disposition: inline


--ZszCD37r8RLJtKdH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for the ROHM BD79105 ADC
(and do some minor simplifications to the ad7476 driver while at it).

The first 2 patches were originally sent as an RFC:
https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/

Revision history:
  v2 =3D> v3:
   - Drop 5/10 "Limit the scope of the chip_info"
   - Add 5/10 "use *_cansleep GPIO APIs"
   - Multiple fixes as suggested during v2 review. More accurate
     changelog included in individual patches

  v1 =3D> v2:
   - Two new patches:
     5/10 "Limit the scope of the chip_info" and
     6/10 "Drop convstart chan_spec"
     Please, let me know if you think some of the changes should be
     squashed.
   - Multiple fixes as suggested during v1 review. More accurate
     changelog included in individual patches

  Simplification RFC =3D> ROHM BD79105 support series v1:
   - Use spi_get_device_match_data()
   - Fix uV to mV conversion
   - Rewording of commit message
   - Added patches 3 to 8.

Matti Vaittinen (10):
  iio: adc: ad7476: Simplify chip type detection
  iio: adc: ad7476: Simplify scale handling
  iio: adc: ad7476: Use mV for internal reference
  iio: adc: ad7476: Use correct channel for bit info
  iio: adc: ad7476: use *_cansleep GPIO APIs
  iio: adc: ad7476: Drop convstart chan_spec
  iio: adc: ad7476: Conditionally call convstart
  dt-bindings: iio: adc: ad7476: Add ROHM bd79105
  iio: adc: ad7476: Support ROHM BD79105
  MAINTAINERS: A driver for simple 1-channel SPI ADCs

 .../bindings/iio/adc/adi,ad7476.yaml          |  54 ++
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/ad7476.c                      | 461 +++++++++---------
 3 files changed, 292 insertions(+), 228 deletions(-)

--=20
2.50.1


--ZszCD37r8RLJtKdH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVuloACgkQeFA3/03a
ocWmLgf+NiyLEI1c9vAMm1Hfoo/i5kemnqvM311uP6K4KSt6EXYukBkNeA4xNa4D
YMJ97SuRnRV30i8m4FmYH1KXeFwS/fgJETbZ7+to/kq1oXybn8pbwQmf933be3rI
4iRUgEHTshvnkPZ8zYKHokcXE5ucRtT8jG9n/cP5FGPUX7spXD0uwSgYZlqmzl+E
bk1ZM71L+616YANWcsGzu8472EcMcriuGu/slMBDLQJGla3Dez25G6Robs+nVrOx
LnacDXmtdxgzv+GEnWbQCMuXDGM2v/oPtmhk43a+/TsgFSW/p2M7HiP1C6WE7FIl
u25uG+rP9yKv+1lbpxR8qqsLEmGpcA==
=2zU1
-----END PGP SIGNATURE-----

--ZszCD37r8RLJtKdH--

