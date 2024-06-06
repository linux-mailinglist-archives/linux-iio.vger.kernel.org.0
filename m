Return-Path: <linux-iio+bounces-5945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC28FF6A9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233E51C25AD8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8041991D4;
	Thu,  6 Jun 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTuVLjR1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFE19923C;
	Thu,  6 Jun 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709036; cv=none; b=fB3RBblPZcM9dsak+QzLuMHiJRJY30ApoAMTLABS5Bg9u8bKx4OObF9u9n/7jeVrStkC/rHjU7GxkyLEXqddqAfeOoDtxznEyjV9CJmrPRbtUV2icKM5MrZQq6ocWEENQysMaittswVeHp6Iomz5cpLrNYXori1/tIvJsp4wSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709036; c=relaxed/simple;
	bh=bmxUJHowpjH7X0sPNbbjvVklAayEp/GdxMz6ivwC53k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jt9MnFdKKbHqPsoNoKBI2KhX7NOGiQ58xScjF1mRX4NRTx24JZREIqJMDLePo85VCwIHTm8aXFLQcCBDqoDty/AXHPYseqeRr6pim/LQ1GxTnuSo8J7AjEvLBifPt58LbNRkqe9YM0giQVDVhbwKxdd3JxTVi43t5iCBN+y8Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTuVLjR1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a62ef52e837so190878266b.3;
        Thu, 06 Jun 2024 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709033; x=1718313833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj+N12ANjcz0Boot32zbPmO4h+27nJH8spZAom8g9y4=;
        b=cTuVLjR1i8Lud0t2kJk6ITETX9Hu8UC0Jo+SWu4nbmP8Lobsx0C+4WWMDPlCAbWcXu
         3+slln5d1o+EFbuNDoLe+3KSlV5gFeQKS8YQQuyF10GKV3jg0JJtqMQggQxj6UQlrm5M
         w2UB/MZ/+WnHfF6RNxb885nHM8Dfj+GWSU2rRM1M05GAY0TK3tK3fTya/rD+PhYTNGb6
         FIxO5WWVfx6e5Jz9ZPhO1u3o3GKNLpAvtlbgWYAhR08E4iPHChK+RqE3CkFIZiGB28P2
         CETOHm8RJZOfSsb0u3kJ0LA54CgGsC1VXX/iwtZtmCN/3AUYC2wjsAC+DcffWV4slZ+C
         Ia0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709033; x=1718313833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj+N12ANjcz0Boot32zbPmO4h+27nJH8spZAom8g9y4=;
        b=Qz3wk4tvbBTdPKvMz8aJl+7vXNFHMzDCcDhLkrWrwd+lUkfb9QNTFUQhG8O6e8IDvB
         djNlzt1TPTPxS+C7+g3yApOXcGfOs/ilgB1qHg85AKUpz5m/hnd1PjgmBxr6c9MYseoD
         q3G8+blC0Twyt7L8a0t4QpMO8upvN1EZ1Uv3SS1b4Ux8U/DmoHeHxDPJmWOCw4hpY1qU
         eKtVwdMksmrddtTg+L6OoA2WrlMZlKMivaEGbNAHe4BH2PnHCCd2TXlUWb/hKF8c1gMO
         9Tvzct0ffynBy8VzpQD2xXTi6HhovDYSMtAvZNlP6fKvITaAwKg+VNARkdmR1TFbVmTg
         LT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA66b8g04VRVE+gOrkfM2KMeRiJqRkAkiPx03Rlyh5mQqKBKXNeKd44Xidg4ZEUJVWGjE0vDCiaTCc6YdlTnKem3ggoNCMwW7sV7T/37SeRf9KQ0pU5GJ4yz2k017qPswcESlo8z2k
X-Gm-Message-State: AOJu0YwUB/1cOAKyRvJl72+5M8Zl6uPGGlzpnxVtMRWvBuYQnTblbLBx
	eXqHgVc3sJdR5S/v6xjGqKfh8RhL9Y4jZxpp/eaACTBB6hXpGy1I
X-Google-Smtp-Source: AGHT+IGrXHXIJQxRglbEP9KNvEqIfPmV2ZGIO1A1sEjEGI8lw3YZShwcqaPgXOyhymok3ibLpFrjBw==
X-Received: by 2002:a17:906:2f89:b0:a66:e009:eb53 with SMTP id a640c23a62f3a-a6cd5613d45mr58319966b.13.1717709032883;
        Thu, 06 Jun 2024 14:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:52 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 00/19] iio: chemical: bme680: Driver fixes and cleanup
Date: Thu,  6 Jun 2024 23:22:52 +0200
Message-Id: <20240606212313.207550-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

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

Vasileios Amoiridis (19):
  iio: chemical: bme680: Fix pressure value output
  iio: chemical: bme680: Fix calibration data variable
  iio: chemical: bme680: Fix overflows in compensate() functions
  iio: chemical: bme680: Fix sensor data read operation
  iio: chemical: bme680: Fix typo in define
  iio: chemical: bme680: Fix read/write ops to device by adding mutexes
  iio: chemical: bme680: Drop unnecessary casts and correct adc data
    types
  iio: chemical: bme680: Remove remaining ACPI-only stuff
  iio: chemical: bme680: Sort headers alphabetically
  iio: chemical: bme680: Remove duplicate register read
  iio: chemical: bme680: Use bulk reads for calibration data
  iio: chemical: bme680: Allocate IIO device before chip initialization
  iio: chemical: bme680: Add read buffers in DMA safe region
  iio: chemical: bme680: Make error checks consistent
  iio: chemical: bme680: Modify startup procedure
  iio: chemical: bme680: Move probe errors to dev_err_probe()
  iio: chemical: bme680: Remove redundant gas configuration
  iio: chemical: bme680: Move forced mode setup in ->read_raw()
  iio: chemical: bme680: Refactorize reading functions

 drivers/iio/chemical/bme680.h      |  43 +-
 drivers/iio/chemical/bme680_core.c | 669 ++++++++++++++---------------
 2 files changed, 337 insertions(+), 375 deletions(-)


base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
-- 
2.25.1


