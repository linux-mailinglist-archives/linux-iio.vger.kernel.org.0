Return-Path: <linux-iio+bounces-9135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81F96BADF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF11C22FA8
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE791D0169;
	Wed,  4 Sep 2024 11:36:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F501CFEC8;
	Wed,  4 Sep 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449777; cv=none; b=QHAy0Zqsgn3kryOFmiMAiFLYFticECM929147hZ8mGCVh1yGL/ipsO3n15hXFS/uPRwPAthVt5JhH6uFSsjv84ZgFho7zARVY43iDWi2vM9HK+VfhZY28meu01MfrONeXfLlJl6ORcITHpv0gh1FuYtzwPYLtT2L7qtlU5Mtsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449777; c=relaxed/simple;
	bh=B6M1g1hdK3cny8QBcvssXakEOMtw5ToZyOK4QcERQ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZAVBKkr+W2eTwiih9ZTqd19sDs7eBx9Pvi978PQx750lopWts/GkEbEOHdSWbPiAYDyteHnn74j+FD/x+F8Kgxr7cO3Hlgnc0C3uOwu+4RNi6k15qnSMZjti86qQZkZU16DodSTTrtVIAxdxojCPkAtjtbUofbjc8E3e5IM1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.ZAvemwA_1725449757)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 19:36:03 +0800
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
	linux-hardening@vger.kernel.org,
	andy.shevchenko@gmail.com
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V10 0/2] Add support for aw96103/aw96105 proximity sensor
Date: Wed,  4 Sep 2024 11:35:53 +0000
Message-ID: <20240904113555.1538635-1-wangshuaijie@awinic.com>
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

v7->v8:
-------
 - Delete aw96103.h.
 - Remove the function of dynamically allocating IIO-related resources.
 - Remove non-essential members from the aw96103 structure.
 - Add some comments.
 - Delete the aw96103_interrupt_clear function.
 - Delete the aw96103_version_init function.
 - Optimize code logic.
 - Modify attribute descriptions in the YAML file.

v8->v9:
-------
 - Remove unnecessary function encapsulation. 
 - Use get_unaligned_le16 and get_unaligned_le32 to obtain data. 
 - Use fsleep for delay. 
 - Optimize other issues.

v9->v10:
-------
 - Modify the included header files.
 - Optimize the code style.
 - Simplify the function aw96103_wait_chip_init by using the
   function regmap_read_poll_timeout.
 - Optimize the parsing of interrupt flag bits.

shuaijie wang (2):
  dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
  iio: proximity: aw96103: Add support for aw96103/aw96105 proximity
    sensor

 .../iio/proximity/awinic,aw96103.yaml         |  61 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/aw96103.c               | 835 ++++++++++++++++++
 4 files changed, 908 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
 create mode 100644 drivers/iio/proximity/aw96103.c


base-commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075
-- 
2.45.1


