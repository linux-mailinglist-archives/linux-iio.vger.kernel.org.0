Return-Path: <linux-iio+bounces-26328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77EC72DDB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6AAB129BEE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2630E0F2;
	Thu, 20 Nov 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="15vXVUsn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337F3093D8
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627180; cv=none; b=C+d5rAF9hYxg5K9KHTpWOsIhMrIILyCHk9kArayz1asfEehhQWYNpmOkowDH/k3GMtllm7uDczRsZA6NXwNCYEKLtjeW5g/VhgIs0xQq6eMEqirnGeszN665Xu8VgaVeDrsD3GaX6FsoMreBnJDgBFkLbqc/ZlZ6ujGh4HXLDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627180; c=relaxed/simple;
	bh=Zjzon7QEGinLWEEXUt35FMbjIuLzT2X0VeWw4uTuyX4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GtpZ1Ll1Ib0S2yM/gDWUtphnF5i5GyZX530zCDLH4nGHpb75s1Zoii8oRokh5lfxZ677CYSheTodpAcHyx3niHExBM2rJ3OEuOiU05U9RZiONZzBvrOncQrejP+U2LcT2OtBQ5RSCz5GiL+9jP2DKXftWeBpLzkfL0QeI8C4EFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=15vXVUsn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a637712so3668495e9.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627176; x=1764231976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMOOHWs1HjaMHww0NFetPmcAVWduwF0PLRUhaG/tXQc=;
        b=15vXVUsn9RVsIgmckrq2scztWiw80duz9N+dZ4mYIRez1C0sNZ7FNo+11Q6UnniUiz
         IOOYeSOS5erqB/hLlpkup/dkLRZzZBAkKOVvSAUG8S0B0mfsVLd1Q/o6dSQZgScEZlgW
         IClo1EMmPUssL9ENX9lQtqJ25KLXC/vUPQyZH57nINTf4bGvWLdE0bcoTIcH3PEdpS7F
         FrFR9ZGZYIzQ3Na5R+UolcDPjY+9G79518cwYGQf0kW8AP/nxrmOXFOv0B4VmLpt3m7v
         oe04my1CMFwy70CgemgPJHf8bWjVl3bU2JO957QhL4Z5d5+gHdMGvjW8QoBrrqQH6/mn
         kJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627176; x=1764231976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMOOHWs1HjaMHww0NFetPmcAVWduwF0PLRUhaG/tXQc=;
        b=XnnJpEg2tRfB/XDidoKySzZQrGAWZonrkY7p0uoWCpzzeuiwvKw3eCN3emA6xLtKGc
         9XNrzTDos577qs1FO3DdJPY/WkcdCL96VJ377q/CNk+1/wV68tSaUuoFuUoH0Yc3E0K4
         U7QTeBebv7S00WkgvBy6x8XSG2KQOJks+tL8O9YWUkTBP2ztoGyOGt7o+uIojbwZc3H6
         nS0HhibHhuPU5rWtXklz/v5kSACr+DVWiWMFpWVflOd+0LIBoggMsNFIAChGD1mbvqdR
         AkUUInK1WFj1M2pvVoBRLKz0pO3LHNmSuRLq4jPJHQI7u19S7bG3uqcnpfjpfFCSUIsG
         CORg==
X-Forwarded-Encrypted: i=1; AJvYcCUkYhAfySOrTerZyS0nmOmJDuxX1CCs4L0/DqA6mRpB1NuhjGVSdeiEj9QjcdiPRBVFnOp3xs2Rs2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXmFV8bVMATSqE7zbhMxt1l4orPN3MIvVmjC9i2qrvj9ieUw/
	Uja4PXn4PqUcT35rTSOEcj4ei3qB7x9Fm9YckJdOM0rIRzmCjJHaWGhV60v3bTsJnRk=
X-Gm-Gg: ASbGncv9CVK5msTa5qlALSta2hGqOIhY9We96z1XGerT8JvXD3J02aoctoH2+PKPhee
	CdGAW9SNBRIU1o8AqN9X3oc4NFTrl+6Rg6nbcO+G5xnSogmFMipV7vxW+AW6fIRAGzE/JMo9QU4
	7PFeyh6ssHn0GpMCpqAEHFlMGjz6UlBlpjZUUW+bNdVVub+UpuQ5Z2f3vMWsJBZPEWBw7U09Uon
	iPTrumbdH0vHcR/zh5sUamA/zPcGvZcefYNVzyrltFjUovKeaCuTaeTqK/l+jGHvYzBB5wtMnPU
	AJ10XRFK8jHoWD+hO7gP7F0HEGKNzaX8k/h3Ml9X1BwHW8Rwek78B/eOPC7mOzdueLOyax4MLS1
	UeTv2TsAWqfC5sMAWASFzKow21J6J7jJo0RutLbdkqL2rknRUzTCoKCE=
X-Google-Smtp-Source: AGHT+IHNNB/3LGr1i+HPYhABm3T8utR98PQiAC4kknD7VukesQVSFFTOP4biqjfRB+thHojMG+1lFw==
X-Received: by 2002:a05:600c:3547:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-477b9dddc94mr12363365e9.6.1763627176470;
        Thu, 20 Nov 2025 00:26:16 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm3983571f8f.41.2025.11.20.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:16 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] st_lsm6dsx: add tap event detection
Date: Thu, 20 Nov 2025 09:26:06 +0100
Message-Id: <20251120082615.3263892-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=flavra@baylibre.com; h=from:subject; bh=Zjzon7QEGinLWEEXUt35FMbjIuLzT2X0VeWw4uTuyX4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtBwAOgtzMjv99xwPP4C29l8FvNcZZLhqzuav 9RQeMVyFi2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QcAAKCRDt8TtzzpQ2 XzFAC/9jszRHQ0UaPMi023LzQtj7YPFcZPHbybA1Le81bW2XLiT53f+a7yOvN9mUUOM3XXJZimj GFS2C3b7/dy3rr29b75cK8qma0XNvE05NTwSDWOpsDHTq+e6FJlcNZHK8cYEA5FG2k2xP47Ih/U +63lklq8S1GQ3f9OOYzFqcFK7cBCHpdEQjkVGJH5nt4ZCU7I6QmWTZEv9jVeesu64UViHZVv9jl ovlaJEF1KV2UvDueRAz1CGw3nJtnVEc48B0AL8bb9uKZPRY7Bitcukc8dNHO/YBzRioRibtgexv hPZ4QRv5evcsKW2EsQkBci7sCRAaSfCkRB6wx/zPUNpR9/1qz5DUhfmq9pxEvG+SDc/jb+5LW1b F7UQraadKn6YbmnWe0DAVCGfa3i4Px2ZmM3Nm23UOpLt/CMUDLCJbpXVfWCj52HrJ/fYi0ImS5i XBJJy1YDLG7i81oHe5MJayKSd032iEJb9hC2nEM7dRps//Qvvyrvp5bGDzrT82FG4/s/o=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The bulk of this patch set consists of reworking the existing code for
event detection (which supports IIO_EV_TYPE_THRESH events only) in order to
make it generic to accommodate different event types. Actual support for
tap events is implemented in the last patch.
Tested on LSMDSV16X.

Changes from v1 [1]:
- added Fixes tag to patch 1/9 (Andy, Lorenzo)
- added st_lsm6dsx_field_get() temporary macro, to be removed once the
  generic FIELD_GET() macro lands (Andy)
- refactored st_lsm6dsx_write_event_config() with the addition of two
  helper functions st_lsm6dsx_check_other_events() and
  st_lsm6dsx_events_enable() (Andy)
- replaced dynamic allocation of iio_chan_spec and iio_event_spec arrays
  with the addition of new static arrays (Jonathan)
- changed line wrapping to 80 characters (Lorenzo, Andy)
- changed line wrapping for commit messages to 75 characters (Jonathan)
- added comments to st_lsm6dsx_event_setup() and st_lsm6dsx_get_event_reg()
  (Andy)
- miscellaneous stylistic changes (Andy)

[1] https://lore.kernel.org/linux-iio/20251030072752.349633-1-flavra@baylibre.com/T/

Francesco Lavra (9):
  iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event
    detection
  iio: imu: st_lsm6dsx: make event_settings more generic
  iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
  iio: imu: st_lsm6dsx: rework code to check for enabled events
  iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
  iio: imu: st_lsm6dsx: make event management functions generic
  iio: imu: st_lsm6dsx: add event configurability on a per axis basis
  iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec
    initializer
  iio: imu: st_lsm6dsx: add tap event detection

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  56 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 538 +++++++++++++------
 2 files changed, 395 insertions(+), 199 deletions(-)

-- 
2.39.5


