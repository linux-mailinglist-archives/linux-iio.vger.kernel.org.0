Return-Path: <linux-iio+bounces-25158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE6BE4D43
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F6A1899CA0
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF12D2490;
	Thu, 16 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uPDFTHTc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155761FF1B5
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635289; cv=none; b=bFq5JKe50CAzSafv2rJAHDLbyANWddr3Ufwig9f1HHFfMMrBdRIm6qfC3Qy56VaorNa1aAsvEznYjHIU4oZNcdG0P8D7udj2k/+yiIn4y1smQ7WEz5DytX2k+niZfZsuT61mSdTx1amwi1TGTO0UhM14TG0dNiefQRTi5/qCaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635289; c=relaxed/simple;
	bh=qhvgN3FL5LhV/QrYODPhFDcWPmr4o6Hpg4UP8n5lETY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZWHESHrjWvApjBcmjdPTO3nIictT5jdxckpnizNL2wgzjXr/I4QbnWM8DHe8dFqlm3cow9xugHpbQujM9c2zCz3BsnClyQr9Crfa4WA9d9gZMO9lrFABbjEB+0H8f4O6kVZ7N1SUG2jZpoHik0+ru613JcjPfS1Ndznk3LLxPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uPDFTHTc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4256866958bso690156f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760635284; x=1761240084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm9oHzTwa+9jdxvUFGS71kAV2vG5mm11Kk5UjOrH9s4=;
        b=uPDFTHTcQ4BjEoW4zK+53a6hcD/4oi4LQ3z1xbCZHJO8uBo+Em2GflCxJtjMNQlly0
         nYBQ4wReyAk7RBSY48LHNDhWqYegh2i/Jz410rXPyOHQAeAQavxvIvBJJEWP+TKtes97
         O9uVFqnQ3j1VXB9FCk01awpgPJFCGahXKR2xxzWFpR/ue/FIq+U92+DklU/B/l4pfm5D
         zpfm5UMl4JPokn/UGPR8pGhI0/JyB3pAjhvKxg4UAg0m33NnKhg719S8J0MvRCPTWOPQ
         FdHcLTuTFBFq2zHKOFDSXPM7OI5o05SKc4edhZHPhipJVGNh0XrOtkChoWnTNV9Z1ti4
         dJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635284; x=1761240084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm9oHzTwa+9jdxvUFGS71kAV2vG5mm11Kk5UjOrH9s4=;
        b=ZxRgfAfTpLqRi8LciNuTAFsP3uHDpW/2CFBFOmK09wxRU5XZSt2jR9BWHHg1MI49JN
         BqTspJeDJOtTXazCPKfpaZU6Qb9AoTIiKbkcNGa1ubcgr/T2SLGVEfBzQHAQ/3z6YcjC
         VvN8QD4ledAW5kl6S12Rdgy74NYCWWtC4Ym/Cv12QOy46BlehOSe46tjRvaHfSXvdn+F
         yGGA/9KhL4J1zZkKPFTsi9Ea7Xg9of9Guc8a5m93WDybJxi380EDwdShRrwRiJvFgNQJ
         hhKcLTDItyQK/jfGphYlwgMba91VRs0cHGVfU2vGmGGSD5kBt0lnwA74mp+IvVf/bqOD
         ekXg==
X-Forwarded-Encrypted: i=1; AJvYcCWY2eqTStbkSe6qltIipsQUexNaai0Z31HRv5hcffZkakY0nYzkgn248pj+YeL9LnfXhV2FdP68oWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhOKnYb+zaQAPW7tBR4OfBgwDxpDuXxhKbAxmk7ErCMzeSuqd
	bETAAIkCQcSPkeBk4eGf6kVGPIkHlerBdum4BgTBsfdOIi5A9tf8i8zP+jHXp9CAi/Q=
X-Gm-Gg: ASbGnctX1isdaxC2p1DOTQvoja5tWQ7jkHH6KTHqEcPbvtuRWaJ4nVo4lSOrlqANOvn
	es97hB2oTZBGysQPAf4m2X+c3ViTE6TO5BarV7JKA77CEj35lxdhUpkaP+YvZkc+E3U0FmTV0ko
	IG6eeeXAjq6g04KlCenbzOGyYGiCMDAuzbg1C8KNl7D1TM10x8eIJnytWcLfJtmBqFCFP8sT1dA
	OLVnvyC+Nofle3Zb0dGveds7rBwwae0fUTRtFtgAZ3amw1DsPaZDHUNWCMchtRsbjp7kZSA9zzR
	MsCyZ/tNmkjC8vWUFRNL9UJZgUIoOwH35NWChr2AVcjBtcpSU3E1kY5Qjw7eRen9SfBsj6Grh+i
	Jvjl80xS4P8MUg0sqEWJ08vr7fYYm6SasjFJ5Pc7s4e0RIdggEnrW21P6oX5VHlHNtLc=
X-Google-Smtp-Source: AGHT+IEqisaXdckEsmmcxObj6O4FSoVTk3hYpVc9SVopAMX5ioSdl8WKqu61bvDnQa3GhxoROjJGWA==
X-Received: by 2002:a05:6000:240b:b0:427:2e8:fe48 with SMTP id ffacd0b85a97d-42704d830d5mr616099f8f.4.1760635284356;
        Thu, 16 Oct 2025 10:21:24 -0700 (PDT)
Received: from localhost ([151.35.142.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0efasm35684377f8f.41.2025.10.16.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:21:23 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu, 16 Oct 2025 19:21:20 +0200
Message-Id: <20251016172122.1220332-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=flavra@baylibre.com; h=from:subject; bh=qhvgN3FL5LhV/QrYODPhFDcWPmr4o6Hpg4UP8n5lETY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8SlAOLOUkrUqpaC+DPMV2Y3DzkHj8CeEQmfOE +xiTdzKd0qJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPEpQAAKCRDt8TtzzpQ2 X/WxC/9aT7H5WIL3KMz9t5NerFm9Go4Vc0IP9cV+4Htbxvo3FpWzCwS7oAWQdhQNvvt+GkgyKY7 qSoGjbH5knDjg7H1vOtEMfIPdmxCWXWBg1uD6x3F6L1NwWwQ8eAwE84RRWBkvxS6bgymvVs47eM O+MIU3aJnWUyxsRkxwvjPOhvfuNl0HbeIhFg0cJyn9KsZouRp4C1dJeTLm29JY/lJJ7dfFoaccL lorvyW6l9LynEW+DoMipUft+RmjfdsFar6/PUVGkATY0ZGEfvIJnAtLzqu711DHSMZOKAkuUcc4 OeVEP08sDM+bULrf0qlaJDK7wLeWmnL8qigXXzJ/uJ3zYf9D3ukP+bd0YVtlFCYmdadO/Ar7CZL fCBDf9eW2gwa3LF1K2TkeS7YMPD7Ro2DI8ZEAUXmgvkSP9noz70Lc9NVKTN8duKL/gJPOgAdIx+ UzJuK2YWnbODAKbFuSj+6TSvMaJJ69TDgwDV8gFseedL8Wi4oWi/x0is2NI2D6c4r368o=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate (e.g. to
minimize the amount of I2C or SPI traffic and the rate of periodic
interrupts).
This change set amends the st_lsm6dsx IIO driver to support the above
use case. The first commit is a trivial fix to the source code comment
that indicates what measurement unit is used for the `odr` field of
struct st_lsm6ds_sensor, while the second commit introduces a new
`hwfifo_odr_mHz` field in the same struct to implement the new functionality.

Changes in v2:
 - added Fixes: tag to patch 1/2 (Lorenzo)
 - in sysfs store handler, moved iio_device_claim_direct() call to beginning
   of function (Lorenzo)
 - changed new struct st_lsm6dsx_sensor field name from `bdr` to
   `hwfifo_odr_mHz` (Lorenzo, David)
 - replaced min_t() and max_t() calls with min() and max() (Andy)
 - added setting of buffer frequency equal to main frequency whenever the
   latter is updated via sysfs (Jonathan)
 - miscellaneous stylistic modifications (Lorenzo, Andy, Jonathan)

v1: [1]

[1] https://lore.kernel.org/linux-iio/20251009173609.992452-1-flavra@baylibre.com/T/#u

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  3 +-
 4 files changed, 70 insertions(+), 11 deletions(-)

-- 
2.39.5


