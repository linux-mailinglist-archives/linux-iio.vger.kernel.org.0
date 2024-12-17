Return-Path: <linux-iio+bounces-13591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B809F591B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 22:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D3F164285
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284A1FA262;
	Tue, 17 Dec 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zf/dBjjv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6F1FA256
	for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472054; cv=none; b=K7n8PnQ7/Lc5gKZ8l1tZg+4FldAJzi8cukn5PGpFvdakaBn9KzQKa/hW/A15CTbjiyf6rLJ/UYKqDrcvpz0nnMCdxaKBNZqNMCPIwzputpIxIhXKyDI+IHa1lK90w5E/4I7/I4/cN+zqVZJ4KBX3yacXxlIHgGYbJ4lopkBOm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472054; c=relaxed/simple;
	bh=9LBkbRZjR8OtDCWd3DaTMKnZFmldhuPelOwiNGPdPXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UtG0aMQsi5kDjs4tRApsCnFn5NsYQjtRKdP0/gqq7IB3hlP86slkdWDKcRCP0CZW/wPZNOUVlcE7xetpyN3+yF1cN/jEBJjb/smYYFlvzbSy409nmeqECcIiNIUrSn0aHwxoR9ciqkFeGuAwxKVObyvRqT9A2EzFsI6h3xFTq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zf/dBjjv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4679d366adeso1365711cf.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734472051; x=1735076851; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7E616DPF2CInBFtwDOpZgMtLKnq3DIfHRsefh6j34i8=;
        b=zf/dBjjvgx3inKBocwKksUxiVakIX4FU9hXltC3GipfxVbLkFVHdyiqwQ/8/XZugdI
         IbSg6EI8PKy5llugXKEgTjA189uPiVektYBEqWP/rYn5njfmF9HRRCN/P9tHC72U7Mud
         M5tKKw8pEnfhY2lvLigYAB59ZR4kzrhynD2iycI7tevWbbjlgvQOmx6MU9znX0w886Ma
         Vrw4uotLsyjsF/PxmJJlzvK4vsdWm2ZPwCyOg/QFlhTcI4IZ1SsRzELTNjjbEzCyYGJ4
         k1qxiSr2BU9tSisUIRm7awlMeM0Me4TcMQtHrSibMr465nwBNEvnCRaOTR47Po65eSqZ
         rMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472051; x=1735076851;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7E616DPF2CInBFtwDOpZgMtLKnq3DIfHRsefh6j34i8=;
        b=I6acj2GYauTQZy+ywRRurPpL/iQG2hcwufPtvK+s5KW7gdLQIgLoyRTHePZH6ml5pE
         Ex3cbGj8vxb+ipkKxL03fCBquQHoLMYO5P6dnW0jgaIsig1Qd8j671IJde1aIwZYY42J
         XVjMDGwTVdAatT7zRYHSrO6tqfVDDGDOpeauHUeIoh+5WJY/imyN2i/HdSKF1ReSWGXc
         yjmKKx61DEP7KYhWkSZxoLE/42dxe3Xz7T6LxP5YF3ULFqquWdJtj0Q9C3Uw8xSF88QX
         kuMKweulbn6a4uZns9ZromGWSvulluzg0uh2qENZGQMS+ll8rSle8JYuPGRC4EYAdjX2
         2HcQ==
X-Gm-Message-State: AOJu0Yzh5zpwis+p3Z0uXbmQ9iF2+ALwhc5geTLhXQya/Q7xBQw5EGJX
	lIzDWjpPpLd2K3lxGD7k279QMmqjH3oQIEcA3rxp60uEMXmy/QmpaHUuhATIZCg=
X-Gm-Gg: ASbGncseg7Yy2uAeZLc/TR+H0uui7FgmXWac3VEL8uExRgKEmimDpSJEUEUUTbS5PYG
	huoQcYYz/Kq3eTv53jUmYDNEfuc6u/7Rg/e8eLYHhOt7gFc9She1NGK3SSw4OBBz5WkGpN0FOdm
	JnT1v3k/+MLcPWICjWrtUgN4voRR2p+7KNaRrgojm1ZHFslhLCovdvRnGQ0yTe2kHBN6Tr2n/V/
	e1Q6ZM3+qxpvsINsKHnN9VtJc7e8zqZTw/gEwECWZXKCNEnKPMaOZWKyJm0YGUF9rGCfq9Rn5ut
	7dXglYIxe2bKGSlz
X-Google-Smtp-Source: AGHT+IGoYnyvG2Q7UWCGRRgjtVttlrB1QOCo98O5Isd/VOtrfcyapcvE7rNT79egsgGNsj+K7L6G1w==
X-Received: by 2002:ac8:57c2:0:b0:467:6d36:4c94 with SMTP id d75a77b69052e-468f8cc8052mr76744101cf.2.1734472050941;
        Tue, 17 Dec 2024 13:47:30 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2eccbe6sm43135171cf.82.2024.12.17.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:47:30 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad4695: add oversampling support
Date: Tue, 17 Dec 2024 16:47:27 -0500
Message-Id: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/xYWcC/x3MTQqAIBBA4avErBPyJ6OuEi0sRxsoCwUJpLsnL
 b/FewUSRsIEU1MgYqZEV6jgbQPbboJHRrYaRCcUF3xgxio99uzKGJM574OCZ2JU2q0ojXMSanl
 HdPT813l53w//XlrEZQAAAA==
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add driver logic and documentation for the oversampling feature of the
AD469x parts from Analog Devices. For now, this only works with offload
support, and takes advantage of that mode's higher performance to make
oversampling possible on multiple channels with varying sampling
frequencies. Some significant rework of the driver had to be done in
order to conditionally support this feature, including use of
iio_scan_types to help determine the appropriate spi message
configurations depending on oversampling ratio.

A dilemma that came up during development of this feature was whether or
not the implementation of oversampling ratios against sampling frequency
was actually correct. More specifically, it's unclear if the sampling
frequency attribute is supposed to be the conversion rate or the data
read rate (according to the IIO subsystem). If it's the former, then
this implementation is probably incorrect. David Lechner pointed out
during review that it would be easier if it were defined as the
conversion rate and that it was userspace's responsibility to handle
oversampling ratio, but that might also require more work in the IIO
subsystem. Two other ADC drivers that were referenced for inspiration
when working through this were the ad7380 and the rtq6056. The ad7380
has a global oversampling setting rather than per-channel, and the
rtq6056 seems at least partially broken because it only takes
oversampling ratio into account when getting the sampling frequency (but
not when setting it). Instead of per-driver implementation, these three
drivers might serve as inspiration for changes to how oversampling is
handled in IIO?

This series depends on David's recent SPI engine changes for adding
offload support:

https://lore.kernel.org/all/20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com/

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Trevor Gamblin (2):
      iio: adc: ad4695: add offload-based oversampling support
      doc: iio: ad4695: describe oversampling support

 Documentation/iio/ad4695.rst |  36 ++++-
 drivers/iio/adc/ad4695.c     | 378 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 383 insertions(+), 31 deletions(-)
---
base-commit: 0c6c3bf84f541fb4ec7097baf9eac10136f98c62
change-id: 20241217-ad4695-oversampling-2946fbe3aff3

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


