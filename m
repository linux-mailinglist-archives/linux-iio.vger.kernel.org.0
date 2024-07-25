Return-Path: <linux-iio+bounces-7876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE993C17D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2D1C21A6C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA52199380;
	Thu, 25 Jul 2024 12:13:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC822089;
	Thu, 25 Jul 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909623; cv=none; b=ge9AG+Lo+6q0pJqoDbXW3+IMRURNg6ce2Yg27xHgSRVISpnAFfLwsK2VC82awdBotsOUtFi7esy+Z+927TQFth36UgiK2HdXUB/w/u+fijm332mkjYlGa2wvxLZeHmKpeW7yRCY6bIX89RaiPm9tkc3CFnsC7jqj6YXPm6ufcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909623; c=relaxed/simple;
	bh=p+vG2tWN9wZD772RHA71+9xCCaFpZpjigPOUfnzFcSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfN3fvcC7TshNeMm6aE6tx6qpWVoZIqoRabCIeDG6s2c+lJVlxZMIW99m9BmoXFLmqmhhE7vfm5z/AkKCyv4KE3A7jMnPGucC2XQG3QE4xtXP08X5XBYkhbX7KSe8jzP2jzRP3KTAdxaueT3MCBHyn3l8Fds4g/S6RUtvoGz2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07479588|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00828105-0.000170853-0.991548;FP=7876820729503270039|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033071083032;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YZXAOr8_1721909576;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZXAOr8_1721909576)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:13:28 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	waqar.hameed@axis.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V4 0/2] Add support for aw9610x proximity sensor
Date: Thu, 25 Jul 2024 12:12:50 +0000
Message-ID: <20240725121252.865836-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add drivers that support Awinic aw9610x proximity sensors.

The aw9610x series are high-sensitivity capacitive proximity detection
sensors. This device detects human proximity and assists electronic devices
in reducing specific absorption rate (SAR) to pass SAR related certifications.
The device reduces RF power and reduces harm when detecting human proximity. 
Increase power and improve signal quality when the human body is far away.

The specific absorption rate (SAR) is a metric that measures the degree of
absorption of electromagnetic radiation emitted by wireless devices,
such as mobile phones and tablets, by human tissue.

This patch implements device initialization, registration,
I/O operation handling and interrupt handling, and passed basic testing.

v1->v2:
-------
 - Remove unnecessary log printing.
 - Optimize comment style.
 - Issues with modifying the device tree.
 - Optimize code style.

v2->v3:
-------
 - Add a description about the hardware device.
 - Remove inappropriate configuration items.
 - Modify the formatting issues.
 - Modify the structure of the driver.
 - Change the style of the driver's comments.
 - Remove unnecessary log printing.
 - Modify the function used for memory allocation.
 - Modify the driver registration process.
 - Remove the functionality related to updating firmware.
 - Change the input subsystem in the driver to the iio subsystem.
 - Modify the usage of the interrupt pin.
 
v3->v4:
-------
The changes in this patch version are quite significant, and I concur
with Krzysztof's viewpoint that this driver is indeed overly complex for
the proximity sensor. Therefore, I have removed the compatibility for the
aw963xx series, and the driver will now exclusively support the aw9610x series.

 - Modify the software architecture to remove compatibility for
   the aw963xx series.
 - Optimize the parsing of register configuration files (.bin).
 - Remove unnecessary log printing.
 - Delete redefinition of true and false.
 - Remove unnecessary interfaces.
 - Optimize regulator usage.
 - Convert the I2C communication interface to regmap.

shuaijie wang (2):
  dt-bindings: iio: aw9610x: Add bindings for aw9610x sensor
  iio: proximity: aw9610x: Add support for aw9610x proximity sensor

 .../iio/proximity/awinic,aw9610x.yaml         |  61 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/aw9610x.c               | 791 ++++++++++++++++++
 drivers/iio/proximity/aw9610x.h               | 140 ++++
 5 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
 create mode 100644 drivers/iio/proximity/aw9610x.c
 create mode 100644 drivers/iio/proximity/aw9610x.h


base-commit: c33ffdb70cc6df4105160f991288e7d2567d7ffa
-- 
2.45.1


