Return-Path: <linux-iio+bounces-27825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87081D2475F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A62A30221BB
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611D395DBD;
	Thu, 15 Jan 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ITJ/R6iV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94928469E
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479878; cv=none; b=ufsaiTqBg4fXOrilncromZGS3b8MiQ0K0fLfXvY8XKYdp8zHcsmrcDiF/vCKInk8EbQnS0OVjmdqkIBihinYgMLaMR4SyWdc2SYEasj7MuBzH+Q3xn8v4aaItFEnCQDO805Isp+XV2pfvvBsv5RBWuRRvdH4Y18tujXLOf2hKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479878; c=relaxed/simple;
	bh=q/+MOscl/md1a2Q943dhUJRpXKCdXx95NGeO7wjX/c8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=f7yN3PjWwXBDT7P6v01d4+6PI9Bwk5IT5/t1p/34S+NE2WDNXURpuqGV4aSaZ6S9ZYnGEZA3gAhpy2BY12pr+O1dirl1Rc7aaipMg2h8NPGukzsp4lxQbTQNMd0DKyoLd5uI3T2+TEZv6Xnt+pygrMXKc3I/i4NjEggXE2Km0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ITJ/R6iV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso1786276a12.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768479873; x=1769084673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGyEKRHJB6WwePDhwb24jiceYhPUCYfTIdehJWyENAg=;
        b=ITJ/R6iVK8vv2XYvkT0jN/s4W1z8RTRtsnojBN8Il/F7oQE7TFMIrJ2DPswKv3yCd9
         8fltRHF2ab9ixIeUNOgmzqloBxFdfeHW0QuYACOzmaMg6BcISe3vvGX4XXnyPu/tkw7u
         2ResfM67mUmYP3VBWjUDk6kEbLbcWqC8agB0+mfMRsn+onpJ2LnVBO0H5DeAxUpI4uGs
         u2cmhhqsllhZ9axHPKudgYRjv6JGJle/nMG2Gm7ufHRvuxxxVzB1rQSz0b0DAARS66W1
         uXh2dUFRodgBu+QKOnUHuH6WBcX37d9/b99dKwTPTaE5QY9i3J3jqu/Px6PMODJ6dUmV
         U76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479873; x=1769084673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGyEKRHJB6WwePDhwb24jiceYhPUCYfTIdehJWyENAg=;
        b=JEUdrilPnSikyRBXUC3aGh2dEqA8/1qCYl2czlzPPqucH7cdUZhhQkXn9EeC7yGcjy
         ldzhK1Bo139YfiDNo3Ezu/M0Or5DCh36Ljz85ZILGAiM/uasos0Be7kZdVgQX6Otud32
         u5a2PvjTgOqtD52FxSbT8B8UdYAZsUd511yUw5NrPseahH8fo+gSdx4l0TEPzYjpTU6l
         zUjlRvMNOaCr8jf2EFSOZrzeX5ygdPIb+u9t61OI38ovx+vWliAo5oodVKxhC3s6EDyb
         VAmZccF+xoTjAbtI/VVIKqsYmI2tZkKHJbgeNv+pyktaoqpzN19bLfYoB+iL/8vCJJa4
         PsXA==
X-Forwarded-Encrypted: i=1; AJvYcCWoiKhe24lhQOiu8RMNcmfJCQ6JwDyqyCpTbk7BHNwsuLymqC8/OKX6nGbrCydYyw+KpCOmCpLMp6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbvwCfQC7vSTZibGyF9D8xLNImecw0tHWfYjUQFHF7s8PQfg2
	9L+/r+mtninKpn4ZMhisCjcf2aBpox1nEV6jPbFyhaZRxTbsVE4yE754oe7U58fpMdY=
X-Gm-Gg: AY/fxX7Eja8t3sCWtPg972TqcKB926jjfp8Re1PLotK3eGD/xD7nQ2AxOCwzT1wLt0f
	PDLwpaohuBCXRgwsvEG7Q4qZCLwonrCyYkKHvq8XiAY58XHL+5OHfYpo8J1Q2/AvTeW+dpOFLkr
	IZxkeYBd0IP/5e7KC5NK34ye5LbxdxAJe2Ia97uelFnpRNBZybbxPCmwh/IE9V5i54go1jpS3sn
	+r6W5sIlZ+fGeRUsLIN8lBs7VFXbGqtcBxwLsUHjzpJQr80z4ohbhLSISF9jEfZVMwTgCUA30r6
	6Q3Ipwtl1rS1j5vAINdoN7j/M3UshIqEEmURnQtRbRBbVcmCNOjAobbrx8SWGTwT0RQHLSpfk+3
	Kr+XR+/ISVfmjwUfg+Pf7gePqPJB8dRHDeq+Q8AaJ5Ql+MQDd7eL0FfEH9w20so9BWjOe
X-Received: by 2002:a17:907:1c14:b0:b87:1ffc:bfbc with SMTP id a640c23a62f3a-b8760fde847mr586522866b.12.1768479873526;
        Thu, 15 Jan 2026 04:24:33 -0800 (PST)
Received: from localhost ([151.47.157.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8713416418sm1288982466b.49.2026.01.15.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:33 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] imu: st_lsm6dsx: Add support for rotation sensor
Date: Thu, 15 Jan 2026 13:24:28 +0100
Message-Id: <20260115122431.1014630-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=flavra@baylibre.com; h=from:subject; bh=q/+MOscl/md1a2Q943dhUJRpXKCdXx95NGeO7wjX/c8=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaNxiT5zsmxUWvA0EOwPEyVnC2ev0kmPBEAyph KGKkwo4ZI+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWjcYgAKCRDt8TtzzpQ2 X03EC/9jvk1oC4AauAPL2Mrbi6ex4yXVvUfEx/9Eyyp/ta/LPbVM9Wsi9cyOxR8TmOZKO8odsbe fpxLW5ALiI7q34nrMqO+JRtQ3pFF6rZ83pfMjFBM63gUd9bXcqMRxOEAqIciO19mtvAfuqU0E7N DssyK/VLc7D2VCjxKJo1rgmejvFW8zQclA0gm964er1IXfqMnBhThdPX+ZtiMSH2hyZuTsbsyBO Xoui3PB3+m9K7vrfznIZpvJTKrWU1iIix0AfeaECKftR+uBnivB0U8S2cjmom9ubDX6ui+d6zGB GNU3oo5btzh2AhAR/RrkHILiPYmr5TlwauxnTM/3jFJSQ1LWR8jVEXp8i3IDEFPE5Z5FCeEdbaD e3KBRzDpXB+lOsGfBvmAIEUahR748mfrWASG1Ka54oLQzlhZB/5vNmeMcwkzqli430+ym4Ru518 WWYL7KnAEsN8bIc5mAoUuQXY1t9CzR8QngzJr9yg58JlIjFoUCMWOaEuipiGuPEacg6J4=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The second commit is a fix to a previous commit of mine [*] which made it
to 6.19-rcX; the fix technically changes userspace, but this should be OK
as long as it goes in during this release cycle.
Tested on LSM6DSV16X.

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
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 212 ++++++++++++++++++
 5 files changed, 320 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5


