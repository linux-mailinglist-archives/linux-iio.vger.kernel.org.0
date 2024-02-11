Return-Path: <linux-iio+bounces-2439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E1F850B62
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EF4282BD8
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368805F466;
	Sun, 11 Feb 2024 20:15:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797445EE6B
	for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682539; cv=none; b=V5D6n3qL6XidOWrGEwvMm9kI9JObhbwNI8m+vOr3quriVBK7EXULI7pQZT9KzhN8k2qvlLtzCbU6vA11qnxroTAnpWLX5FGwwHAF2U9Yxq7gL2sM0V3Pueb+lel4getL/wsc+yL4UfvAf1OwjJSqs5U/QR6z3PQUwRmaTiYt6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682539; c=relaxed/simple;
	bh=irykZsem+8NgONVmxffWWO1MotG6wqG1fRYrdV08RAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hp/W9dcwDEOhhC8GeV701hBzVZ1H9TEDgjuDxbbkxF/LepOaI/F25xdAbdz8XNA3070j/2Ut0ae31uMcgZR5Aa/2MDC8geYatLPWcpgjCF0M6MghvZhlHrPzAJkbcEpUMuRbU5tCCR9NE9yFGNPt7eYGDGRuMPUr8AFAhnj1xwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 4cee4963-c91a-11ee-b3cf-005056bd6ce9;
	Sun, 11 Feb 2024 22:15:29 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marius Hoch <mail@mariushoch.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/3] iio: st_sensors: lsm9ds0: Miscellaneous cleanups
Date: Sun, 11 Feb 2024 22:14:31 +0200
Message-ID: <20240211201526.1518165-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a few ad-hoc cleanups. No functional changes intended.

Andy Shevchenko (3):
  iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
  iio: st_sensors: lsm9ds0: Don't use "proxy" headers
  iio: st_sensors: lsm9ds0: Use common style for terminator in ID tables

 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h      |  5 ++++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c | 21 +++++++++-----------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c  |  6 ++++--
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c  |  4 +++-
 4 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0


