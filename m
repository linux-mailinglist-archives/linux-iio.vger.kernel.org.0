Return-Path: <linux-iio+bounces-6118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11539018A2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4401F21184
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467F4DA10;
	Sun,  9 Jun 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KytWlnDM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF4179AE;
	Sun,  9 Jun 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976313; cv=none; b=PUYft6UjVgzx6MHvI3lSSe5spr3TF7sr2+u6xyZB3EK5XTL8UcPRnSwZTxOGMl+ViPCmoFHYvTphR7sE8oBZeYx/LOeCHGtzeE2BRiGnmghACGzUpWSNZBFfF5YKy1Ii5sEjwtUGyDo7JM/gRa0ziRU/PS5xsW/RXRiCfGaN9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976313; c=relaxed/simple;
	bh=WQu9K2ue5eeyp0u/2COx1PCNb014zEKrmMT+Lhhs9BU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRkWMrrK3vo50wqshxSBBoC2j/kWcmX0nxfRoRCXqlEG913UwDMW3ZcCLaW9zca3TYtjXpWkkgP+kNLib5F5nzMAw9MQQzwLHdlPi1kgo0E8diLI0Iy366DTKwy09RrZ0zk4gbNDP4UHgNW3/BIv0tr0p5PVt8NLHNzk/YaaBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KytWlnDM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso965228a12.1;
        Sun, 09 Jun 2024 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976310; x=1718581110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02MNU9GYhtO+IwacgDb9GmG63HRnt1F+VZqY4FJZbpg=;
        b=KytWlnDMTi0KiK0ZdcvXrHcaU/ZPCTmwi8LKnQjAWjOWa2XTsT4W4D7MNx7tncTgZA
         wVVS0/TfanRm8iZG1zL0QeGyFjHFaxUMuLqB2gK3nHht9Q3Cp44rwf16JCgFTEs1FdRS
         c0zeLBzpSZKMD6s0D6DCOlV5a/mW5i9GAf73gY0BbUplty42hiT+fdS75nOwGwtYfyyd
         +2yRvuVhq/GJQwblrot8zEqxPXRc0Pjk7TpIhbqwH/YZmOoAchU+vUtW7cQhGPKT19Jz
         NcQa15+HM93J9l6k4oRXZbApYB3vtpwsrqjKIFApGrHnH2cxdN6daJZIaW6lUIjhn0qD
         ur9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976310; x=1718581110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02MNU9GYhtO+IwacgDb9GmG63HRnt1F+VZqY4FJZbpg=;
        b=ZPBQ+9KOw+16Bc6JWlBZlY4ynUSDPN0cGG0WlR1N5dYKbau+Gdr/79aZmOx57SKg9J
         iDxsQT8PtesZnzaO61H2f0be7PsLQca56Og69inoGSCgu646Fo8Z1o7OhitwRWH+wZtt
         uQe9A85EgqciJGlfQjlzuTMgEvUn8pHMtk5ze255/LdoLt5oF3+oWC1u6zdryi8IKSjH
         xzKS0xXQzyTsqmBVZ1e2uQEh5hyLKP4uy395hygdL/PuomHEq4db4Mc0CWX2eKFURRlM
         83Y9pmpOVfq4CHuzIey0MYLWgm/2gXpI4UEutRKs2xIeI7OkUKhmha5dZyWs/fhZ9WxQ
         t55w==
X-Forwarded-Encrypted: i=1; AJvYcCUljDMBdPTNmFk6grM526GTwDczdzbtxdE0tLVeXjoqPLY0aiWGoZayOdlbTtEPopzlkd1H6AjQrsDy8G9qOXzwtnJGFoLS9O5ck88X4lg+FhX5t3AziY3pz4yZb2pLU7x1ejtKyA2g
X-Gm-Message-State: AOJu0YzFiDigufK5nGWdGEoPUKraYCjKoIPsoRxK2ARYrKQZHtSlWbZD
	H1UyrfZdxQYWibdZoDFdFm1qkmtjiw+Hg8cUoh6TYsHQvVSgZtpB
X-Google-Smtp-Source: AGHT+IF3roP40+TYpz5PRfIoispVy2DR35Z1i5AUefec1eXO8p0db4vS3R5nnFHOZf9MZF6lGSro/A==
X-Received: by 2002:a17:906:478c:b0:a68:e58b:2c35 with SMTP id a640c23a62f3a-a6cd6660cbemr696404666b.31.1717976309923;
        Sun, 09 Jun 2024 16:38:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 00/15] iio: chemical: bme680: Driver cleanup
Date: Mon, 10 Jun 2024 01:38:11 +0200
Message-Id: <20240609233826.330516-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on fixes-togreg as the 4 first commits are already applied

Patch 1/15: Added comment for explanation of what mutex is used for

Patch 2/15: Removed fixes tag

Patch 3-15/15: Reworded the commit messages to come close to convention
	       of 75 chars per line.

v2: https://lore.kernel.org/linux-iio/20240606212313.207550-1-vassilisamir@gmail.com/

Patch 4/19:
	- Combined the bme680_conversion_time_us() and bme680_wait_for_eoc()
	  into one function.
	- Added better comment for the calculation.
	- Added checks in the bme680_wait_for_eoc() function.

Patch 5/19:
	- Fixed typo in commit message.

Patch 6/19:
	- Added a fixes tag since without the mutexes, read operations can be
	  broken.

Patch 10/19:
	- Converted shifting operation to FIELD_GET()

Patch 11/19:
	- Changed convention from &data->bufer[0] to data->buffer.
	- Removed IIO_DMA_MINALIGN as it is not needed anymore.

Patch 13/19:
	- Removed IIO_DMA_MINALIGN

Patch 14/19:
	- Splitted from Patch v1 14/19

Patch 15/19:
	- Splitted from Patch v1 14/19

Patch 16/19: **NEW**
	- Use dev_err_probe() where applicable.

v1: https://lore.kernel.org/linux-iio/20240527183805.311501-1-vassilisamir@gmail.com/

This started as a series to add support for buffers and the new
BME688 but it ended up being just a cleaning series. These might
be quite some patches for such a thing but I feel that they are
are well split, in order to allow for better review.

The patches are mostly small changes but essential for the correct use
of the driver. The first patches looked like fixes that should be
marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
is quite straightforward and 17/17 is basically a duplication of a
very similar commit coming from the BMP280 driver [1].

In general, the datasheet [2] of the driver is not very descriptive,
and it redirects the user to the BME68x Sensor API [3]. All the things
that were identified from the BME68x Sensor API have been marked with
links to the original locations of the GitHub code. If this is too much
and we don't want this type of information on the commit message, please
let me know and I will fix it.

[1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
[2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
[3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master


Vasileios Amoiridis (15):
  iio: chemical: bme680: Fix read/write ops to device by adding mutexes
  iio: chemical: bme680: Fix typo in define
  iio: chemical: bme680: Drop unnecessary casts and correct adc data
    types
  iio: chemical: bme680: Remove remaining ACPI-only stuff
  iio: chemical: bme680: Sort headers alphabetically
  iio: chemical: bme680: Remove duplicate register read
  iio: chemical: bme680: Use bulk reads for calibration data
  iio: chemical: bme680: Allocate IIO device before chip initialization
  iio: chemical: bme680: Add read buffers in read/write buffer union
  iio: chemical: bme680: Make error checks consistent
  iio: chemical: bme680: Modify startup procedure
  iio: chemical: bme680: Move probe errors to dev_err_probe()
  iio: chemical: bme680: Remove redundant gas configuration
  iio: chemical: bme680: Move forced mode setup in ->read_raw()
  iio: chemical: bme680: Refactorize reading functions

 drivers/iio/chemical/bme680.h      |  41 +-
 drivers/iio/chemical/bme680_core.c | 631 +++++++++++++----------------
 2 files changed, 291 insertions(+), 381 deletions(-)


base-commit: 4241665e6ea063a9c1d734de790121a71db763fc
-- 
2.25.1


