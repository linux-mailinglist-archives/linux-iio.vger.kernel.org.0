Return-Path: <linux-iio+bounces-8457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC78951300
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 05:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499B928703A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 03:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5043987B;
	Wed, 14 Aug 2024 03:18:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B9376E9;
	Wed, 14 Aug 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605515; cv=none; b=Tzk3vV0V/VIfTswl1fIXmBb8fPz9wK3Sbg4sDEbaXbZqu3NpntSlFEFerrd8xxIUIbv2E4K3L4y+Ddf4dERIS8kv+o5tpuvOniPldCbjMBUr/g8/U1U8QRZ2KQP516w9GAryvlJkPEUh07IBZP/1ng0Szx7lmc4qEA49sACts8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605515; c=relaxed/simple;
	bh=AgVFMOPfloqSvCiROULfHPqQsTqxzcHX40p5bF4ZmIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eb0XZy14ftcJUr6p2shUv7RyxcYVX/K2XLLNhhx22NQS08wC+grC2yBLt7KxxJUgwTyWlX63Gg3IsQtmIkQNfjvSJDjDMXxKcBqKW7kRc1UAWvx0bCQYRd7pkpMSRH6hhkGH+w047F1DPQrWZ41vwSQuv+ywVTreQb9nFW1QyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Yr7DV9B_1723605491)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 11:18:20 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V7 0/2] Add support for aw96103/aw96105 proximity sensor
Date: Wed, 14 Aug 2024 03:18:06 +0000
Message-ID: <20240814031808.2852418-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add drivers that support Awinic aw96103/aw96105 proximity sensors.

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

v4->v5:
-------
 - Solve errors that occur when executing the make dt_binding_check DT_SCHEMA_FILES.

v5->v6:
-------
 - Rename AW9610X to aw96103.
 - Remove the encapsulation of the i2c communication interface.
 - Delete the update node.
 - Modify the usage of regulator.
 - Delete the remove and shutdown interfaces.
 - Add iio's event-related interfaces.
 - Modify the initialization process of iio.
 - Delete power_supply-related operations.
 - Modify the register names.

v6->v7:
-------
 - Use __free(kfree) when allocating memory.
 - Modify the way to request the register configuration file,
   using request_firmware_nowait to request the configuration file.

shuaijie wang (2):
  dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
  iio: proximity: aw96103: Add support for aw96103/aw96105 proximity
    sensor

 .../iio/proximity/awinic,aw96103.yaml         |  63 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/aw96103.c               | 814 ++++++++++++++++++
 drivers/iio/proximity/aw96103.h               | 116 +++
 5 files changed, 1005 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
 create mode 100644 drivers/iio/proximity/aw96103.c
 create mode 100644 drivers/iio/proximity/aw96103.h


base-commit: 6b0f8db921abf0520081d779876d3a41069dab95
-- 
2.45.1


