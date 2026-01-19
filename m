Return-Path: <linux-iio+bounces-27943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87529D3A43D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AFE33029627
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41813596F8;
	Mon, 19 Jan 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VQfx8UTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C323587D8
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817095; cv=none; b=UirClUwJ90qA3TaiKPJ0w5INUNRp4IDvaHdWGjcgN1Qj0eBbXTamzZlpn1LB/uCCQkYQzpVRKPdD0dM3sVHwMn+1PO9CA8RcHde6KQdOF6uqm61HocWBWixFnCfg9nUBpqTujvNubxsbtIA9cM2H06vuoIln08vLnm/pfCCkXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817095; c=relaxed/simple;
	bh=vPkYRFbIxUiSkSjQ/QDbSt9MbkgMOqkEOwRhnYELFEE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tBi2oDw4Di1vDu/zdIVvLm2SqcpP56AQlBKVb2XHo6j7z+h2QWT3YqYR0CfehhE6rSi6TXumHL62LPmlJWE11K8cLqXEwoC/bf/BT88YhRUbl6aw6YGeaEiN3TPN4xg5SwWlpWYg/r8ic+VrCU8B1eG7x16D0RJbn8odTurmOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VQfx8UTx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so6431287a12.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768817090; x=1769421890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq1HAr8HJxpfivCoT2O94cro1wREtvkYnxia8tXR8Aw=;
        b=VQfx8UTxcho8VZT+TzlbyVm2sYCikbIxo5EoNf+PlLRhmmOamqaV3+CD7xkTuaLK5b
         85jL+J4E6VknE+6jfBKHulmYUAJwpRZYmZWYCogNIf09D/A+tQOjm9pe5jjV39h/iFnd
         Mc8Quza7FJyCtaoVxVGrUQV3rxoQLXwcL/OvP52n7S8kGHnYzfeWN50dzRmVGbDHakZ6
         7S4WBwCGwlFYSYTAey61EIPYfCw6zUX4JQZoB77bB79fAUV5VukFaYhLBaj28tXQQn+Q
         w1j/FFJQP60qC3qtLySQhYVX/gZPY2SpmMNBogOEUaI2XsLaCk7w+9+8FEprTvzj7FGN
         FXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817090; x=1769421890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq1HAr8HJxpfivCoT2O94cro1wREtvkYnxia8tXR8Aw=;
        b=uNtJcYjAP2RPf+Sc28+P0AwV8GqfldVHfVK47WVwNKiPCo6ehbeLcAvJ6Rn9WRYgzL
         EncRWXVy2DclnqzKKI7cQFGed2Zyt+aTkIpksyIE06SFBOIPoZi5NXQ1y2XkNSpjb/Yz
         rOnkXFMt4q2Fn2cbYqmXlZ3DaamHgyngcOxZ5wW8XvU90qCnm7qq3qeTyhLN9n0h2QGT
         M7wsG7B06xgnnuA2YcIdNJmGA4jF3CnuRn2GBuHHEDHTRVTHJLtuhbuwwtQ6BzYJekVK
         54p10tsqFDXvjVWtL0rciBr4mBrjGceEQ4cIPNujqnHxJySrZ66j1NjLElKWvYY0YpCl
         rD8A==
X-Forwarded-Encrypted: i=1; AJvYcCXgWrx5pYuC+8hV4OmhEMEU/pWpQSBnWvdSKfUcx+N5NDUNhwAT3TQciQKf9OLZe7akWM7rzU8QNis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1FkNLYUql7vxc7ZIw0obTkH9BAY0tK1gP40ZaVWqFWkXmSBr
	VuD4qTzgSbESCKDd3XDv8loUin9L53G5zIe2mZJScdWbQrwWhWedPUg+aE9UfNGgWWI=
X-Gm-Gg: AY/fxX6+N7Y4absBFmE5XfakYX0Fo3YV9qi+xm6DD0btJAhYq3GBrNPwb8gBpUGLp4c
	T/GwCTGCHn0pxfy9/cJFtK+UyVrW88WCPMm3gWpobVnPhpEBoebw8l7VD+1eC+nGv89uhAU2EfO
	taXPSP9G3QE09ksmSl2+PYIdsWBHAJsXY1fuN/ZNO61VZSr9bR1MLbBoK5IILo2mDQ1NV8N9WlQ
	MfPu2Y1xJcHgnz9MdM+3JsRWHKFnDafIo8QFy5a/rKKFyKY096XobW+oID6T7BhUkXxxeAjJohq
	PO+070LWGkaSbx/67r7lmM0Ozcf6sW51iHpfhSyjvbSxA24aJAKVlP1lNWcO5cU5gG3tEd0Kmer
	YLJizlPQ4bpYz7JYrEArrwMapF4EGayP6xqeapi24tu2DfU/FqRAtZao=
X-Received: by 2002:a17:907:6d0e:b0:b83:95d7:9d50 with SMTP id a640c23a62f3a-b8796aee48amr801195866b.38.1768817090381;
        Mon, 19 Jan 2026 02:04:50 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9bc9sm1040276866b.33.2026.01.19.02.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:04:50 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] imu: st_lsm6dsx: Add support for rotation sensor
Date: Mon, 19 Jan 2026 11:04:46 +0100
Message-Id: <20260119100449.1559624-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; i=flavra@baylibre.com; h=from:subject; bh=vPkYRFbIxUiSkSjQ/QDbSt9MbkgMOqkEOwRhnYELFEE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgGjzBuSVe74o9KeFcSogGQe+3U9DQcV4YN8s kZJe0/UkdaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4BowAKCRDt8TtzzpQ2 X3vIDACPMkWb4qadGs9SRj2KHTzstuATxqthHIjtVkdrs6wIOcA5lut86WBiYVLFil6DBw3kZ82 THAHwFI0O6c3YF1P47hzfHVFOYBpfYiNhIq7hSORdppqEBjAv46PvcCDxsRj8qza18zQV+jDLd+ hurlqiwc8ui05AJMz0V8PmwHA5BriQ5yFB8YCOWLWF2HxLNJL2zOJvbeQm/5ecjYMaonxmIIhZr N37JuLM894zf8KE4gxXIe2JHg5Pq4m3zSS9+wHdDsMZs/gu/KVEw+uU3UERVlb9M/FYwuhRdlm6 1MIVPJXMNeXSJgpRmodXgi2uVW4sd/kRNNpRwg8GKfSjB8LrvGe791+4cbpaNifk5ko/T+vEUEx xK9u2gMDp+DvIgd4KRTJtSwFpe72UvjHiuoUNkplHpoJyjINWauS6K5ga+iMNP89gEtYicgWGki 9xSQH3IRTCIANpU6xsgQkx3ssXb3aM/Q9jR0lQ98amjDedHfUhmZHWK2kOJj6T7QACGZI=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The second commit is a fix to a previous commit of mine [*] which made it
to 6.19-rcX; the fix technically changes userspace, but this should be OK
as long as it goes in during this release cycle.
Tested on LSM6DSV16X.

Changes from v2 [2]:
- amended description of patch 2 to point out that there are no supported
  gyro events (Jonathan)
- removed superfluous parentheses in st_lsm6dsx_fifo_setup (Lorenzo)
- added Lorenzo's acked-by tag to patch 3
- added missing checks of st_lsm6dsx_sf_set_page() return value (Jonathan)
- added comment in st_lsm6dsx_sf_write_raw (Jonathan)

Changes from v1 [1]:
- swapped patches 1 and 2 (Jonathan)
- miscellaneous stylistic changes (Andy)
- fixed usage of MICRO and MILLI constants in st_lsm6dsx_sf_read_raw and
  st_lsm6dsx_sf_write_raw (Andy)
- replaced scnprintf() with sysfs_emit_at() in
  st_lsm6dsx_sf_sampling_freq_avail (Andy)
- replaced scnprintf() with snprintf() in st_lsm6dsx_sf_probe (Andy)
- clarified in a comment in st_lsm6dsx_set_fifo_odr() that only internal
  sensors have a FIFO ODR configuration register (Jonathan)
- modified patch 3 description to explain justification for the extra IIO
  device (Jonathan)
- moved page lock from st_lsm6dsx_sf_set_page() to the callers (Jonathan)
- s/magnetometer/gyroscope/ in patch 2 description

[*] https://lore.kernel.org/linux-iio/20251017164255.1251060-3-flavra@baylibre.com/
[1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/

Francesco Lavra (3):
  iio: imu: st_lsm6dsx: set FIFO ODR for accelerometer and gyroscope
    only
  iio: imu: st_lsm6dsx: set buffer sampling frequency for accelerometer
    only
  iio: imu: st_lsm6dsx: add support for rotation sensor

 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  29 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 220 ++++++++++++++++++
 5 files changed, 328 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5


