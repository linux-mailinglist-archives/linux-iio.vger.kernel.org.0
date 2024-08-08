Return-Path: <linux-iio+bounces-8324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296694BB02
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28EE1F256EF
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA018B49B;
	Thu,  8 Aug 2024 10:29:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35A18B491;
	Thu,  8 Aug 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112965; cv=none; b=cTNteuEilS8RgkxScPqW1AKIv3FaMLtNCGmtpdH83FSA7os0S8nP1JfMq94HYWhGDt9rJw4bZr7clB79JFdJiPHcx7VjVPD0KXkVWazUwKlFygqsdLPa6iSTBpW9uArGG0qldKskzQLpTPnKsn5/vctuGz43xDCErfPHorfY2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112965; c=relaxed/simple;
	bh=KtgGdJ8vrLeHFc2F3n5IvsT/QPfBnUUD6jiL7mEkelQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os8xoUslas2tIqWHsxdeV4aZzZ55u2lm0NhSnH+Y5gZ6DrHBJ8oHQ2jamyyjmQ+I0cixIQsxYSgy55uOc+0XZOnBmUUm2D+R4of5K6alZqSijaO1RYxKAaaKmIyKRSlFQfN9kYk2ZiO8f8pzh/Aml3pKSek0Ug19CVOmh2PJIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0747498|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0273787-0.0022905-0.970331;FP=7876838320615572631|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.YlkvBzD_1723112934;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YlkvBzD_1723112934)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 18:29:01 +0800
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
Subject: [PATCH V6 0/2] Add support for aw96103/aw96105 proximity sensor
Date: Thu,  8 Aug 2024 10:28:49 +0000
Message-ID: <20240808102851.4024025-1-wangshuaijie@awinic.com>
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

shuaijie wang (2):
  dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
  iio: proximity: aw96103: Add support for aw96103/aw96105 proximity
    sensor

 .../iio/proximity/awinic,aw96103.yaml         |  63 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/aw96103.c               | 833 ++++++++++++++++++
 drivers/iio/proximity/aw96103.h               | 116 +++
 5 files changed, 1024 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
 create mode 100644 drivers/iio/proximity/aw96103.c
 create mode 100644 drivers/iio/proximity/aw96103.h


base-commit: 6a0e38264012809afa24113ee2162dc07f4ed22b
-- 
2.45.1


