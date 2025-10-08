Return-Path: <linux-iio+bounces-24846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF3BC4464
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1032040143E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B882F5A1E;
	Wed,  8 Oct 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7412F549E;
	Wed,  8 Oct 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918622; cv=none; b=gOZE99uTTk2ZCzdffO30PRFLiyhj+FuBiQgw5cwGpssqgQFC7y02qEU/2KmoWk+a+Qy+vt0BW0PaqXybpoRNuk0U9QOfsPL+8sQjf44x+qN40lwIxldurIzfiwoHXjCIEJMCRnQTYLwG7y6swyTd3Gn2NpHgAJOQKmMXZ0IDh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918622; c=relaxed/simple;
	bh=9XS1pNKDtAD2Onci5vX1bjLV+rfp87Vv4zAq3FciJTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ts5mrdicLm9vfUxuviqLAEOBRahDmee9728185HooZL4hzxN2PSQ60xnQ2Yovnd9Qq0eO8tXMGaNM4xxzR/Zxfbgi6vJBUCjNjQXSkiHcDJLiGhOmUO9NkWaVR3gK7g933heO6BgNnwyG/lSY8QnlAGzUTsXiJOQ94HOvcpAnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B09620166B;
	Wed,  8 Oct 2025 12:07:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5305201671;
	Wed,  8 Oct 2025 12:07:18 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 54A6A180218D;
	Wed,  8 Oct 2025 18:07:17 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	peterz@infradead.org,
	jstephan@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v4 0/2] iio: temperature: Add support for NXP P3T175x temperature sensors
Date: Wed,  8 Oct 2025 15:37:11 +0530
Message-Id: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This patch adds support for the P3T1750/P3T1755 temperature sensors under the IIO subsystem.

P3T1750/P3T1755 support two operational modes:
1. Comparator Mode
2. Interrupt (Latched) Mode

The HWMON subsystem is more suitable for implementing drivers for comparator mode operations.
Reason:
  - Temperature thresholds can be polled and exposed via sysfs.
  - Register reads do not clear status, allowing safe alarm state derivation.
  - Matches existing drivers under hwmon.

The IIO subsystem is more suitable for implementing drivers for interrupt (latched) mode operations.
Reason:
  - Interrupt mode uses edge-triggered ALERT/IBI signal interrupts, which can be pushed to user space using iio_push_event.
  - IIO’s event API (IIO_EV_TYPE_THRESH) supports timestamped rising/falling edge events.
  - I3C IBI integration maps naturally to IIO’s event push model.
  - No persistent alarm bits are available; so polling in HWMON may result in  missing events.

This patch adds interrupt mode support under IIO while leaving comparator mode support in hwmon untouched.
The split reflects the sensor’s dual behavior and aligns with subsystem semantics.

Changes since v3:
  - Added cover letter for the first time.
  - Updated commit message to clarify P3T1750 vs P3T1755 difference.
  - Minor cleanups and style fixes.

Thanks for your time and review.
-------------------------------------------------

Lakshay Piplani (2):
  dt-bindings: iio: temperature: Add NXP P3T175x support
  iio: temperature: Add driver for NXP P3T175x temperature sensor

 .../bindings/iio/temperature/nxp,p3t1755.yaml |  62 +++
 drivers/iio/temperature/Kconfig               |   2 +
 drivers/iio/temperature/p3t/Kconfig           |  28 ++
 drivers/iio/temperature/p3t/Makefile          |   5 +
 drivers/iio/temperature/p3t/p3t1755.h         |  45 +++
 drivers/iio/temperature/p3t/p3t1755_core.c    | 363 ++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1755_i2c.c     |  67 ++++
 drivers/iio/temperature/p3t/p3t1755_i3c.c     | 108 ++++++
 8 files changed, 680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
 create mode 100644 drivers/iio/temperature/p3t/Kconfig
 create mode 100644 drivers/iio/temperature/p3t/Makefile
 create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c

-- 
2.25.1


