Return-Path: <linux-iio+bounces-25208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE45BEAE53
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A95A7EA7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F02DEA67;
	Fri, 17 Oct 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z+Z/lKsI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB22C1585
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719382; cv=none; b=i/wRzQUngm9Hy99uZIntJx2Xuyh0GkHSeIgzR5LKklzsZIBSEAqifFKLII3lMDBvaCpCKz3ufx/7it6OKw2EMbceR5qyKtqab0LR1hJ8R7i36BQYqXXEdwS/ucrouSDetSb99wB8Q82c3yNXnYOyKrgQhOVeecpyZH6uR2epO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719382; c=relaxed/simple;
	bh=EbGOgWCx+khawQFOQHDAVhH9bYeArl+G3z9a0/QKsAI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=olD2hBJFdrHFvl/B3PQ6MyktZtJmbApoACe4ar4OKiFZ/2sqJ+V5L9gxKvH0j+05UWDYGedEzWt5ueR6FXzWMtBCTyDy+LpVD2j+CSK3avauvDry/KqPSCuW1AFBGkRgb8C1PiQkECiLT8pxJrdG9onHTXAQz2DXkx2bk8vQOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z+Z/lKsI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so913216a12.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760719378; x=1761324178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6ZFTaO484vvvOp+LnE17zfufVeY7YudrTHPSJCX3w=;
        b=Z+Z/lKsIvGlysfkJgc3/URezmV2UibNrUNu+dNfu4x7D3hIhaI488QQKohJSgHdwIW
         AMydoUo0oP3CDDpHSp6nezXsQccvqLMVSyTBbaWl6PvKe3afdFVnHzk7/cpP1W2kPbpY
         NoTyQJ/SQ9xLEv8cj5CZpsmiYZUVCWOhRCd3/izeCl2DbwIE/IZUC3w68XC/sFOt7Nif
         3zyx1NwsJmYfXBC24TuO7/zJCwgZzBhMcsTAwEB+4v+vzLTWU8b4Y4kmyuf9q0bw3Eja
         BqOsGK6wv/ASB4SEOoJCcCnck3XjCdgklzkEnJ+I3gtBwoXCbv146jJS0KH3DCHpraJ7
         CCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719378; x=1761324178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6ZFTaO484vvvOp+LnE17zfufVeY7YudrTHPSJCX3w=;
        b=H7w0V609HHHB2Sqb4h5etVG25Q+znDigLix7A8pAm/2H2ymMClvzzMneXU8xIp0vtT
         g3lYrRqUjZ4YaCAEqoF/uD+NGotPRHVNkGEOxSt0aGNspd4v4d94alH8JQKdo/cvPqIp
         c0GNU+eNL29owBtesGMZULwX1RFVD8bll3puZ+WMnjkvcHj0jYMeN+Ka98KSNSmziN11
         VbUm+XVpu4xARtudUevqfP/SU7e0zNaZ9hVPRWsW2qSqHCvlswMi6jAAl+AEoamEq3YP
         1dk8fdpGXq0Ta9Doy44WtSvFJ00vDmmC2NfyPDjMWJVQy9G4WKWLxAE773RoeoFQkNcY
         1goQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUlQns0MFRep2fJf3Z5dt47Uau3eIkUc4ZxkqPqGRavpDBO3YdIfHTsDYPDRsZ/U5KYdQvXxLHoE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvH9kJTd14ZHWHr99W8Zq45xrVNexpb7j8WadPw0XKwKy3auN
	Vytxj0UksgMU5LMstCYLInWxcCc3NPQPkFjN0xRZqiuDSVrQHuYe+SmRX2SsTbA9quE=
X-Gm-Gg: ASbGncuHbK3g5SceDvJ9dUqktVcMpyUgpjT0Z9LHnqgVVWTF5Yu7ZMdero58Xm3MXIM
	vpgcZhaSl4X01YpOMKKMrA25Ct3EFkK3dgBl3j3hID1LhaxK0JXJ1OdMAOpKXfs2O5bxDgm/EgP
	b0ypZc8RDj4psC6ouX78WYJIltK0XR5NuLmvJwh8VslmKkQHQ/CK6OgIxH81fYkv6aeh5cmbiiQ
	cWt9VUc9HS0uMvwdoonwCAV5Dowt4g1OutU6Q/uKDNiDvyp23JKlqVBbWpTD023VnguzxcB6yal
	SvVid3EvLb2ZQtf+GbViYXrhYEBTV7vgjV02v2pEmtxmZcwXcN9Huu8r4JMI96ZSQVPoNGu0ugA
	4b6SD6P/8mSGzgj2Hr9syR5wACw6F6znlX7uYmukK1+n9tSqbLyzm90kUJ5xH7QADPgDWrenqL4
	Fr5gGuQiFqVw2/F2ajy+DEODlbbFlQPeUmSmkD
X-Google-Smtp-Source: AGHT+IFYmw9Y+CWdz19QjFSQJCJMdCKeKiZa3YQOd9OZPKNEuXldvogb8WZLSN/ZGoEzK5VTcC62+g==
X-Received: by 2002:a17:907:c20:b0:b45:27e0:7f35 with SMTP id a640c23a62f3a-b64764e1c66mr519633766b.46.1760719378035;
        Fri, 17 Oct 2025 09:42:58 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm14971166b.54.2025.10.17.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:57 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Fri, 17 Oct 2025 18:42:53 +0200
Message-Id: <20251017164255.1251060-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=flavra@baylibre.com; h=from:subject; bh=EbGOgWCx+khawQFOQHDAVhH9bYeArl+G3z9a0/QKsAI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8nH3tw8+nFc8mO5BnEJGdJ/joIXFe+sacU/oy n46BGq0NheJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJx9wAKCRDt8TtzzpQ2 X0T2DACtX3b4mY2q84kxLKrZkPbIcL7BFRGCz9y6co1vO8c+IaWc+yny1HRM3yOl+OqhDpGlFv9 6KHlI6u9C1NcTZMFjbpJZ6mOCcyzOsVQBeSqqiyQLc8KGfBkCKqyvApwfc31+2jgTreEyvFlXDq 2rrBMk43ZB9p8Eqr2NiGPEWfttxA/hEPDecpNscQQ1tuEEgzL72wsjS/Lh9Vl9Z/n/Ys+Z6Zq0V p1A4qTQqNlklbTqVApNk6Eilh3rPZ8T+HKrMwpN/oMOP8JVR4h56o8kNXxUUwYFuMa8mrRTpWjk odAIUgFF7vR8yeBAg90c5myDBLnMrcQVZdZXMDHKD8TmmCdhjJrXqk8ClnXHGjrzEEKNTn9GE7V G7gB5LzunmiLvRyICrjyYaJ8bQ4AkkcIEBor5dLWWa80quy84zXowhxVbU5K7BY++EFlPgyTVHf oL0NUxzALVfXb1Hq2l0RmV1+IKvTZRzwvjaxIgRzVCnJofkqBCA6qmfG6ZZNCQRWiygD8=
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

Changes from v2 [2]:
 - fixed Fixes tag in patch 1/2
 - removed local variable from st_lsm6dsx_hwfifo_odr_show() (Lorenzo)
 - replaced multi-assignments with on assignment per line (Lorenzo)
 - added Acked-by tags to patches 1/2 and 2/2 (Lorenzo)

Changes from v1 [1]:
 - added Fixes tag to patch 1/2 (Lorenzo)
 - in sysfs store handler, moved iio_device_claim_direct() call to beginning
   of function (Lorenzo)
 - changed new struct st_lsm6dsx_sensor field name from `bdr` to
   `hwfifo_odr_mHz` (Lorenzo, David)
 - replaced min_t() and max_t() calls with min() and max() (Andy)
 - added setting of buffer frequency equal to main frequency whenever the
   latter is updated via sysfs (Jonathan)
 - miscellaneous stylistic modifications (Lorenzo, Andy, Jonathan)

[1] https://lore.kernel.org/linux-iio/20251009173609.992452-1-flavra@baylibre.com/T/#u
[2] https://lore.kernel.org/linux-iio/20251016172122.1220332-1-flavra@baylibre.com/T/#u

Francesco Lavra (2):
  iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
  iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 71 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  2 +
 4 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.39.5


