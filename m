Return-Path: <linux-iio+bounces-12368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574349D0DBD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC9A1F22C7E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F74192D7F;
	Mon, 18 Nov 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nSPYUiOl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9D823D1
	for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924381; cv=none; b=lX66fu7m9FfJU6QMV7MmWO2LSDn3JUJWeaElSrDjMIR4WakhCrcF+b9ykUvIOGjj9Pd5H2LvguQL2fh6dpJ0UVUg0AxDBSdlE9Hcm93wfe5ibEwEPmXSlz9mxLol1Wmil925AntZ27+MxbL+LU+wotfcb5lVX/ZifJCuB3Cr7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924381; c=relaxed/simple;
	bh=osaXyN6BouvX3a3zCIwNrMGR31b+e+AEEftUE3CdIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZzgQZIfjq+cvHdIatoEw7w/IdNNFh9nbQI11RODZCt5zG1r3+NoznS6sLK2Sl1/w5B7tjJPBYRdb2XOxP4bYnMOGxGBazZYaDfTdwh2miYwHNDbhSC+XZ8HC3z+pHEV1FefxQkwDG2aoy2yGblDQV7Cl4CP8yeBFm/X/48Gl/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nSPYUiOl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso34888465e9.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731924375; x=1732529175; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XJLItd9ejKzlDHl0N9KDnlBxbviG3QWmhzLzjOLKeM=;
        b=nSPYUiOlL4Wb4ZyKwlUTl3kjKFjyuqPWhLczl1NnqnIkPf5btazWs5pj0LT3W8BoS/
         u8c8ke7NaiMCBp6S0mUDVWw+he3H6eam2Z4lQupYsab/RYTL1l2CW6kRP8uWoNCBgiIF
         xEDewbyOHG017Iv4avdNDcQASzp/z28Tde3znDZD1orJk0dlgYGdBYu/OtydrJvRKBp4
         +YuHRR8GY7iLhSw2FMKDbx1fNxvQ8CmW5aWt2SHHEB1hIG9arEUOkDvT2Iym9+uzsJHD
         BVapcyl0Z65TOhtTueJln36qNO8gT66yc82BX6A/F+yQoYiS5uVEpW9gD2EDxkOyBcrc
         kRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924375; x=1732529175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XJLItd9ejKzlDHl0N9KDnlBxbviG3QWmhzLzjOLKeM=;
        b=SceeK7bYT0TM/iTWPWUvoz37GyiUZBCr2BoKIdIKYfy4T9JZ0C3rW7rTtkygZCX16p
         zBJ6sL5qrvlX3ZCSkaH5I/Ww/cng3TMtiW63Ym5Bd7QrSjfK8aR+XR7RNNSRmprZdgKT
         6r7OQ3lPfqFxp6Bi9JUDY9sY0WXewJNKWOHqjB5q6YT6mT4f0dsMOFrnK4Owgp5wihZM
         +NEjmXG/ahkctRK1JHgkoJNDYoIRq6ga70azfWmifW6OKXHwvWSFYi5UZvjLYERofO1S
         Gu46f8LFC+avs+30HTVeNAxhY0ofqp1EuJg2jCpHASmQro8vmJejAR7RqX2in6E7vEs1
         VW+A==
X-Forwarded-Encrypted: i=1; AJvYcCWffZDbhcRNWHbn4Pyrk/BvUNhMLZ7HlDccCMDEaVBInGFNRMg104KvfO0Lg8hVE5/hvSPfct8WDyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz304RYd6RpLSzi6B4tLKO6P9hTL0M9yLIhYZkIzKni2sskVUsj
	2yPV2iHrJIMs5zpe2iIjWzd3m3UCqHEsYUkqc23pmiPQaj320PM7WmGDRfOuPbk=
X-Google-Smtp-Source: AGHT+IGpCz7tiOpQ6i6dlG9gd1pHCo/Wa+oYfLAhSYidRkbPfpBglZLzLG5HnJrxMZAy3ckz5sMtww==
X-Received: by 2002:a05:600c:4fcf:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-432df722e4bmr93843775e9.6.1731924374816;
        Mon, 18 Nov 2024 02:06:14 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298760sm153013935e9.37.2024.11.18.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:06:14 -0800 (PST)
Date: Mon, 18 Nov 2024 11:06:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 6.13-rc1
Message-ID: <karzhndxysg5whnrp5pby3ulvmircl76a7dkcbinkdyuyx5flg@6al4vimzwjhc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57l3bzelwfcxov3e"
Content-Disposition: inline


--57l3bzelwfcxov3e
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 6.13-rc1
MIME-Version: 1.0

Hello Linus,

The following changes since commit 517fb4d77c44c7519ae6937329c496894461f416:

  MAINTAINERS: add self as reviewer for AXI PWM GENERATOR (2024-10-25 11:31=
:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.13-rc1

for you to fetch changes up to b2eaa1170e45dc18eb09dcc9abafbe9a7502e960:

  pwm: Assume a disabled PWM to emit a constant inactive output (2024-11-07=
 12:03:39 +0100)

----------------------------------------------------------------
pwm: Changes for v6.13-rc1

This pull request prominently contains a new abstraction for PWM
waveforms that is more expressive that the legacy one. Compared to the
old abstraction it contains a duty_offset member instead of polarity.
This new abstraction is already used in an ADC driver merged into the
iio tree. So I expect you will get a part of this tree also via the iio
pull request for 6.13-rc1 (tag pwm/duty_offset-for-6.13-rc1).

Otherwise it's the usual collection of fixes, cleanups and dt doc
updates.

This time around thanks go to Andy Shevchenko, Clark Wang, Conor Dooley,
David Lechner, Dimitri Fedrau, Frank Li, Jun Li, Kelvin Zhang, Krzysztof
Kozlowski, Nuno Sa, Shen Lichuan and Trevor Gamblin for code
contributions, testing and review.

----------------------------------------------------------------

The new API requires changes to the lowlevel drivers. For now there are
two drivers that are converted to the new API (axi-pwmgen and stm32).
Converted drivers continue to work with the old API. Drivers not yet
converted only work with the older API.

Please pull these changes for 6.13-rc1.

Thanks
Uwe

Andy Shevchenko (1):
      pwm: core: use device_match_name() instead of strcmp(dev_name(...

Clark Wang (1):
      pwm: imx27: Workaround of the pwm output bug when decrease the duty c=
ycle

David Lechner (3):
      pwm: axi-pwmgen: Rename 0x10 register
      pwm: axi-pwmgen: Enable FORCE_ALIGN by default
      pwm: core: export pwm_get_state_hw()

Frank Li (1):
      pwm: imx27: Use clk_bulk_*() API to simplify clock handling

Kelvin Zhang (1):
      dt-bindings: pwm: amlogic: Document C3 PWM

Shen Lichuan (1):
      pwm: atmel-tcb: Use min() macro

Uwe Kleine-K=F6nig (13):
      pwm: Add more locking
      pwm: New abstraction for PWM waveforms
      pwm: Provide new consumer API functions for waveforms
      pwm: Add tracing for waveform callbacks
      pwm: axi-pwmgen: Implementation of the waveform callbacks
      pwm: stm32: Implementation of the waveform callbacks
      pwm: Reorder symbols in core.c
      pwm: Add kernel doc for members added to pwm_ops recently
      pwm: stm32: Fix error checking for a regmap_read() call
      pwm: axi-pwmgen: Create a dedicated function for getting driver data =
=66rom a chip
      Merge tag 'pwm/duty_offset-for-6.13-rc1' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/ukleinek/linux
      dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to 3
      pwm: Assume a disabled PWM to emit a constant inactive output

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    |   4 +-
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       |   1 +
 drivers/pwm/core.c                                 | 885 +++++++++++++++++=
----
 drivers/pwm/pwm-atmel-tcb.c                        |   4 +-
 drivers/pwm/pwm-axi-pwmgen.c                       | 199 +++--
 drivers/pwm/pwm-imx27.c                            | 161 +++-
 drivers/pwm/pwm-stm32.c                            | 612 +++++++++-----
 include/linux/pwm.h                                |  66 +-
 include/trace/events/pwm.h                         | 134 +++-
 9 files changed, 1571 insertions(+), 495 deletions(-)


--57l3bzelwfcxov3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc7EZIACgkQj4D7WH0S
/k6cZwgAoMkjVDFUq9QM8g87/DWUZABFHzVKCIyRCCmql+pxVSnE5xBrG9fNK70Q
ijkdSDtrRpCWSHBMLm09+Qnb2vkJpyy0fYwMUfgaU0GcE+z9zpgfbu4Z8mY4A59d
Nj7yfpmYYrusKAZRgUnijI7QC5hC7EJa598qPhZP/D91fm89BlK7y6TJosRzCbpq
m9xAzXGzQiKq1Z1tX3XzmVn5Mt2KrfXCUjFX75Zk3eKrzOOuWQ804X4g+qynKDuz
STyRfyrskqfKZOGENAJr/N5G1bT4dDybkBp6Zz1dB7s5TQ0GXnSSA9n8LHl3ojPk
F1b+lwfWaQqwDS1qjEGU2pHbWUUwxg==
=R4t8
-----END PGP SIGNATURE-----

--57l3bzelwfcxov3e--

