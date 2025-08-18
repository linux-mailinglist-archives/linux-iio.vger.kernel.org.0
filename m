Return-Path: <linux-iio+bounces-22912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E114BB29DD9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B452165234
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFB30DEBB;
	Mon, 18 Aug 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iASP44vd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D16279912;
	Mon, 18 Aug 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509271; cv=none; b=cIaCoTzXiRYay1YSzl6BrtCUkmeNUfIBeQqOcUd6KYHu2yLOguiswLPMZCQPMbQZjzvELJYKHLo7vc0s32XIy4vY9ApFz/LVEPSu/1KpPMZDdA+CgIA6ecOiLkrvHtQk4iL5KoDbPlFEk/CVNt66A0ouvMm+kjvpm00ex83XboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509271; c=relaxed/simple;
	bh=T3h75QK9Tsh944aIAWPzDUoh+xcqI+0YoNiz/P+LZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtuGn0hiwABxEpp6xvcIEc03hIsnhAPliRTBk3hRoAkTCZj7F/pxdv5SlWE/zpjhG93NpZ+BgUMWRUZEb11YkZhvCuLzM5VRQUdWyaQYQWWxZHKWcUjLkePmV0of/SG5V/NoG4zkrY2oIFdhJTkskI3sH12nkzGw5+WaB5ewtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iASP44vd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so31043765e9.3;
        Mon, 18 Aug 2025 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509268; x=1756114068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jRVts6LRG2/Gb+qaQATAkJMio7fpnA+naA4YFP9RCg=;
        b=iASP44vdomf+w6xQXdVd95iZyO3q2QaVr3AgcXS4d2/fGSojMmt4y03No5N9v1jTbv
         faNh/XZ149S9llmZTL+/n0/W7r5jWuBbwg0gnyZgVGE/tdeBS+u/WURSnC3dXd48cQDx
         ZZwmj+TiVZiMif9jRYD3xl/pbV/hD9O23p2h/by+OeyU2w3Q2skxAPowRmw3UTNZSV94
         n704t23R3Netgo8FmnW8lCIUUYh24+oni5XGcvCPb3ks5kprDy2pQlZpUcYN1WZQbwEj
         6YXxU8GSQDh87BoAg7q8pUiTxW++xBnekyhugxK2Yuq5udjZqzE2C/J/kh8+P5RmmxX0
         V7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509268; x=1756114068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jRVts6LRG2/Gb+qaQATAkJMio7fpnA+naA4YFP9RCg=;
        b=QNNOn4ZCe5uwo/VwTz8gwckxJBnWm1o+nZPxeuS/IXGt88cwZC0C8JF6/vtg7sa3Fu
         S+VLGJ2oSkutF6kq3f4fk9rvqvy/WR9OT469t+tgD31rcEOi7cFoOTDT4dhnRgMu/PUJ
         ETLLpA+PktOf94HdZhjhWRT/GyRXZZbsdp70mneoRk7/Wc9fYjg2/m+cVHhFuW8RcmQl
         k/dd/UymV2scAtjEpM1Zj6Sre2gD93XrocKqR+NBQ57+Fz8fXgKdV08SsKF2zM9tV14r
         2lfDuv4VeuYoVmfR3GpmqWYayMOuHdw8YxS4h6khCqVrAUpfKnxpd178a7Yy0HChc5DJ
         PrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8UtR/ybML+cowkruMLCHdkoS9ajaN1+UqYlPsfYa8hSqdvQZjLpMUVPiiTS+IApyp02tbF8ipCd0Fbwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfM/BaIKpL+vZ+NWkxHs4CeO36JCo9vtS/7s3HmSfphmgFPu8y
	0zVDWGRnCTfZJ0LLc0PHiF7pxqc/EKrpyWVaswrgIjFmY96xJTgXfCR+4lEPVA==
X-Gm-Gg: ASbGncsBDd0PBiQ6HQMAnLiK2dkW02r6SsRa7pQ2PVuVtiCGV/QstrjTM7kRdsPrmst
	CUtxi1wi1cTqKDmT+YkQ7lPrTRTx1tMn6kFrG77nnTNp8CTqKKBffU1U6Xy3W4iBzY7EHn9Jf+x
	DuUOSncbuX3qhXRJCW2XMRL3tazj471bizLW6uJKYy9PMTcIJDSX0JOTM4SfcvNu497N9Sqjm01
	WTJ45UrYPipbAeEho77DhX4t8yCSjIWRxurifzWB/ZbcMDrJqwX0I8OLFZnTh+4kK/bC79cOJ8/
	3J7UyXR/QtzRJx9vV9L2ws3XcbufLKWPvzphVp0sEv5SVkoj5B8qplP5aTFdn1fWQEoWK+oiO78
	X+LcMP5CO9vL2gnd/asfmhd66uPpQj1dDXmg=
X-Google-Smtp-Source: AGHT+IE0KJGzBnCHpB/7kPnoVkVMWr4NaRVPXbUL7TABMJzHoVxSvtNalKbKBFA4EahccyTsRFYwnA==
X-Received: by 2002:a05:600c:c87:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-45a2186e395mr74740235e9.33.1755509267361;
        Mon, 18 Aug 2025 02:27:47 -0700 (PDT)
Received: from localhost.localdomain ([165.51.41.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm173793365e9.3.2025.08.18.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:27:46 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v4 0/3] iio: pressure: bmp280: GPIO error handling and cleanups
Date: Mon, 18 Aug 2025 10:27:29 +0100
Message-ID: <20250818092740.545379-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series improves the GPIO error handling and addresses small
cleanups in the bmp280 driver.

Changes in v4:
  - Split patch 2/2 into two separate patches, as suggested by Markus
    Elfring.

Changes in v3:
  - Split into two separate patches, as suggested by Andy Shevchenko.
  - Improve the error message to "failed to get reset GPIO", as
    suggested by David Lechner.
  - Add Fixes and Cc tags where appropriate, as suggested by Markus
    Elfring.

Changes in v2:
  - Use IS_ERR() instead of IS_ERR_OR_NULL()
  - Drop dev_info()
  - Use gpiod_set_value_cansleep()
  - Improve commit title and message

Salah Triki (3):
  iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()
  iio: pressure: bmp280: Remove noisy dev_info()
  iio: pressure: bmp280: Use gpiod_set_value_cansleep()

 drivers/iio/pressure/bmp280-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


