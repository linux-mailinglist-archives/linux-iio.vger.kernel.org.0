Return-Path: <linux-iio+bounces-19900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5CAC3527
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D717A8E6D
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E71F30A4;
	Sun, 25 May 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU+p4ALR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487E28EA;
	Sun, 25 May 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183152; cv=none; b=MmO7i7rrg6J1ZHW/t5cpAv+UiKgQ23FJHBXKGvXIVYT0F+EY/TPc2CyZVULKDGpWxefOUQ/XefRVAm1CZVyzb1qZFwlMnOSFxTdSjL/Dzt0j8PX3vYRp1z0sE+mdQjF+L/qrM+klJWQIVY8M+9cnu14nXJmW+OpqnVr5D0BL2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183152; c=relaxed/simple;
	bh=NM90G492BjfiEyV5vFQ000BYD+6mBLBrhX0tYBF96BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5ZX01gTh4tfTQ0xjv68AScP8l5A3GqQpiRYt8JhQhHh9a3i65syCeAa6QMeKilglUx8zu+1xeJwQyx1sBgjQuHkqy2nFP9BWRc7UKazYekhKY11zda2YAb3ETEwnipW/dZkjoE+L5dgLxc8XeaWT2/qdfdLR8/Ri1dEMBVyWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU+p4ALR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so12328335e9.1;
        Sun, 25 May 2025 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748183148; x=1748787948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdoZ2ya22aHbPyZMrQvrZTKBeG1YIBpjxgwBrdwhTo=;
        b=eU+p4ALRCbnSBJXEIs2Dc1oA+AK64wGKe5Wq/yDq8xDzaw1Jp9HooD2oMeXZdwNhlq
         Idb4UIpaWMStCxfHRSi5C6lAauw7uuUPGVLQJeZzxnJWVqCJ9YBFUHObSnIzCsOYDAdf
         6mfFI6nv8TylcJS6OeoV7oWppfqszUrVtqNwdzIEqXJWrcVB0R5k/tggmhmK7aubuv5l
         iJ4AhuylO0syJA9HPvTfKVM+cd6Du2zqwTyTsog6M5HgIqIIU6zUibqb3bz2569nqUK5
         7NtxN3SHRXxqOszBKdL4r4jUHC5XUtm8V5WRm34S2iELJpIhXERNs4fhJi2p0CT3Fghz
         A/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748183148; x=1748787948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFdoZ2ya22aHbPyZMrQvrZTKBeG1YIBpjxgwBrdwhTo=;
        b=G0zYUAr1mMNQtrY++1iValKV/G1wBXRweEKlgCIdLNhUSwwOER4JkxxAAh/srBmXUI
         cHDncy9xVEK0j/HQRd3hyH5RkT8Ra/zMsWNWFNQmGinLenVZzPlMGzvVrK0WJaKs4iou
         8U40z7nQRYpfAN89MM5ngE33cGU5sjKpD1vZnXCgBTbHQ++e91ewYXKlg0XnvHrg7N3i
         k7aqSjxq+SpT/D/o163MevUOtXeIYZ4UN8UjCjjj8G+YwDQDLEUG7yg5XYOEIj8vic4X
         h09Iettxzr3X9vlgmTEy5AuCog8m2vDy52EKkjP8K3KlKQddB8qyp/GNbx/GoBXjNYk4
         DKnw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZaLvG5JgC2nmnRJyBIKFi8UbSrSOqO+CLHHwWH4xPCF07eKCGN10E9Bq6XbIp7njH5EfQKScawMlKp9u@vger.kernel.org, AJvYcCV0kAnWiqTNcoyEVJKtZyqb+0m6BCqfwWBSEOjdb6HgNstuMc+N9Su9CH/zxp+USXDNFvkaFvrc2cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxay3UBnIppEVkUpDYfxkBfXoUC0EbBNKhpV7HktuwUwvv9Et70
	RMY8wYv/5vbt+x2XcK/Zu9F7Z+X19gLCzEW3i1+u9diikCXdT6eKcmwI
X-Gm-Gg: ASbGncvnSlPCuE/z5n2absnZnzLogjgVCKE9ULKi1vHEORE2dhbjSEi9yPlZGdB5kSM
	DPzHaemT3V7jEj+2wddUv+Mmd0r8znGWdJeSDC8V0TuY+EiWzoGpFCH+jCquczw4539NFP74uys
	qzzDPNoUXoHNwJU1LH0eYWSKWotEH3vjiVGzEfsf/+RCva/GMBstk5SZ2vRifwIq3zh6IHTd1x0
	4FbQz+XDL8szoMEZ4BSsFf01oC/pRFoYKzHAGIIYSTtjlF27x/8PTECaSoYfsenqc41d9pMVecu
	6U5WasRMfFY5GD3SBcyVjvUHuz8+dqcbivqujqhPptRJQsaE8EHUCxdSF5LWAEkOvkDXrY8=
X-Google-Smtp-Source: AGHT+IEkR1nsqU30zj8uMIZHv80ZMDYVqMCujmXxgz5uqOOKRB7EaW5IsmYL09ADmJEZJbc9R0pkzA==
X-Received: by 2002:a05:600c:8219:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-44c91dcba6amr59869765e9.16.1748183148541;
        Sun, 25 May 2025 07:25:48 -0700 (PDT)
Received: from localhost.localdomain ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb8c92d9sm216428135e9.2.2025.05.25.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:25:48 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v2 0/2] iio: fix suspend and resume triggering for bmi160 and bmi270
Date: Sun, 25 May 2025 16:25:28 +0200
Message-ID: <20250525142530.71955-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
a common usecase: fix the aforementioned bug about triggering not resuming
after sleep in the same way it was solved for the bmi323 device driver.

The bmi270 patch has been tested on a device where the device irq pin
is connected to the CPU ensuring it doesn't cause harm to devices that
do not use hrtimer or other external triggers.

Changelog from v1 [1]
- include linux/pm.h where needed
- used "Closed" to reference the solved issue for each driver
- merged two lines into one (on both drivers)


[1] https://lore.kernel.org/all/20250509171526.7842-1-benato.denis96@gmail.com

Denis Benato (2):
  iio: bmi270: suspend and resume triggering on relevant pm operations
  iio: bmi160: suspend and resume triggering on relevant pm operations

 drivers/iio/imu/bmi160/bmi160.h      |  2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 19 +++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  2 ++
 drivers/iio/imu/bmi160/bmi160_spi.c  |  2 ++
 drivers/iio/imu/bmi270/bmi270.h      |  2 ++
 drivers/iio/imu/bmi270/bmi270_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  2 ++
 drivers/iio/imu/bmi270/bmi270_spi.c  |  2 ++
 8 files changed, 51 insertions(+)

-- 
2.49.0


