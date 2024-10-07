Return-Path: <linux-iio+bounces-10260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDA992500
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16CC1F216FD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 06:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F1154429;
	Mon,  7 Oct 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h0BZborK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04C5733A
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283179; cv=none; b=HiaA5uHt1qsC77Ylj1lD2ZYggL2EcxYTIH8WHoq4ADelv4waSelqvvRJ9xuBIcs5sZHLYrO2/l26K/J9wONUT1jVO38IZjLTyoETlT0q3Z8L5/3PNYul+BvgFAtN2DvnmMP+LxtFJuxpOjkqJKz2QDZExtKauGTWL3DbPr/b8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283179; c=relaxed/simple;
	bh=TZFDlrODtvM5KSBWTXvjkPPDJN2tjc3XdeT1AClxC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CfunCsKyMVOmbktFzIKGLaEQtVzOZ3nkYSfPDG24494KDb6n8mkMKDYGofvaVQ4vTqm+xO8X3G8eYQSMmJAgpVGERj8w2lpYPaXkGPek0MYiyg7x/jh+ZQd1eDR6nS7J1At1OG0+BjRLzmhauPwbHXj7CoPi32qtXoJseu9ARCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h0BZborK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53988c54ec8so4485261e87.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Oct 2024 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728283175; x=1728887975; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knVc37pFUNZU8QI60OfoU1jKqk4r0vo6c8j3Bz4G4GU=;
        b=h0BZborKdChYnCuzx5sAi7VKDhJCcH/1lbNNGjTDybWNJtwMTC2L3IIUo9AqsvPwQK
         BFaQLYTf521/anGcUpzOuhwrf8cMCIEPYfHHb7BXZluwR3tR5RmON5H7t+soSwe786+l
         i8RM1D4fjFOzDWfTAdc7Rt0KUyfv8AOVUJtNgqgnJDkYfGGFgi51RvHlePO77NHfZ6Aj
         nN8pm8levu2/ZjvEuyctUBoaA6UbKn+346f0UBI++TpeV7NHOL2kAoV/V3hA1ptp1xng
         qc+00ZvCyPoQI9RFnBY4tHuE6iP1ABCgPJmgSbg1vsld77k0J/Dq5+99IiUorH1gao9B
         55Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728283175; x=1728887975;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knVc37pFUNZU8QI60OfoU1jKqk4r0vo6c8j3Bz4G4GU=;
        b=lKsLP3Z1nsOElXG7BSHcMJRWG7avIpiYuq51fKT9E41opmQs6rA7/ZIDYx6uuofsnw
         s6tEs7n8Ze9gXkDXmjs95ZBew1GGDZKMqCUY/OWjK4Qgx9AUg/8NTSQC1UuflswaKAth
         4WDa21KR6YOYTDYpusB5xa3XWuSrSB6uaMYMlC89UwV+mMZQzlCs5aggdX4UnaSFUWw1
         HesMAbLy+G1Hk5Tk4bBv4gvnzWDG8BWHhv7MB4mtFeZh45lC5poSDsXfJsvODcH28E7S
         3Ghs3E85pJzx8PopRBbCp9MA5aHWxHIR+SFgDydqNwe2hXuQSLoi3oIXkb+JI10Eac/B
         3SrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6HFnl0r74umrSCxP426RkjsuJzFGf2WOaz/mvhgjZ4yQJB7n4yapOvMDPcYLxmtIxdw67sb2vfB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcr1tuEQOxOVrOK/DSI4YL7ZfFaZ4DpwCoW9LztDNKGtjRA9yg
	B3mdZmWSfP9kaMkn/jq00sZKhwaojWI8P630ouIZTxN2ntgWUOwluHlgIF7fwhw=
X-Google-Smtp-Source: AGHT+IG4/LwhASmcQ5l6UcdRhaEHEj1pzqAxkUVM0FN5sCjsG/gX1o4w892zU2AKvFq4l5uWbwU7cg==
X-Received: by 2002:a05:6512:1250:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-539ab88cec1mr4373121e87.26.1728283174369;
        Sun, 06 Oct 2024 23:39:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:170e:f866:159f:369e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0afc1sm82833785e9.1.2024.10.06.23.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:39:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:39:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [git PULL] pwm: Support for duty_offset for iio
Message-ID: <7p2rd2634e5ucqc2xub5sibreezblsynvssqvyjlgloolsoy5i@avm2tq37ybmv>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lwna3iqfgafzjmt"
Content-Disposition: inline


--2lwna3iqfgafzjmt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

The following changes since commit d242feaf81d63b25d8c1fb1a68738dc33966a376:

  pwm: stm32: Fix a typo (2024-09-16 15:24:59 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/duty_offset-for-6.13-rc1

for you to fetch changes up to 9c918959e198d25bd3d55068331312812406dec2:

  pwm: stm32: Fix error checking for a regmap_read() call (2024-10-04 19:03=
:12 +0200)

The base is contained in v6.12-rc1. The head will be part of my pull
request to Linus for the next merge window. If you pull that into your
tree, you can apply Trevor's series for the ad7625.

The tag contains two fixes on top of the original series that cure a few
warnings. The commits were in next a few days now without further
reported fall-outs, so it should be reasonably safe for you to pull it
into your tree.

----------------------------------------------------------------
pwm: Support for duty_offset

Support a new abstraction for pwm configuration that allows to specify
the time between start of period and the raising edge of the signal
("duty offset").

This is used in a patch series by Trevor Gamblin for triggering an ADC
conversion and afterwards read out the result. See
https://lore.kernel.org/linux-iio/20240909-ad7625_r1-v5-0-60a397768b25@bayl=
ibre.com/
for more details.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (9):
      pwm: Add more locking
      pwm: New abstraction for PWM waveforms
      pwm: Provide new consumer API functions for waveforms
      pwm: Add tracing for waveform callbacks
      pwm: axi-pwmgen: Implementation of the waveform callbacks
      pwm: stm32: Implementation of the waveform callbacks
      pwm: Reorder symbols in core.c
      pwm: Add kernel doc for members added to pwm_ops recently
      pwm: stm32: Fix error checking for a regmap_read() call

 drivers/pwm/core.c           | 857 +++++++++++++++++++++++++++++++++++----=
----
 drivers/pwm/pwm-axi-pwmgen.c | 154 +++++---
 drivers/pwm/pwm-stm32.c      | 612 +++++++++++++++++++-----------
 include/linux/pwm.h          |  60 ++-
 include/trace/events/pwm.h   | 134 ++++++-
 5 files changed, 1389 insertions(+), 428 deletions(-)

--2lwna3iqfgafzjmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcDgh8ACgkQj4D7WH0S
/k5zyAgAuE2xy8MYsFFn2VO5HqKkDKwSvc8sUWrDYDqoE1MLUOWBr5vbL1IaKCcA
xxy9PC8OBITDL/uEh2AYv2wNNea0BpONQZ4kXYLbzUFzr+SrOiuaU5+6jjL1nZ60
bbcEdxdvb+yWy1P4IkhmyRbaLXfP2sUl5z/eSOA5HAoVYyixZ3XTRWxeb+xZgin2
HOUpqBAsUUBMEgfuPtz77Dyb/STaoGkTRlwd+O/bk0kQorIuDVDtWV7QclR5vlAE
GcOMCaUic2lZmXs1HhbKly9e3hK+4E2UWHnOufudz0D1ZPrxTK6j1TLrjUgpdUdP
/OlNxakLJkfj9SBTluhX/0WzX64ezQ==
=1c3g
-----END PGP SIGNATURE-----

--2lwna3iqfgafzjmt--

