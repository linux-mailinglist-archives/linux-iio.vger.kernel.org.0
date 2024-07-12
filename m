Return-Path: <linux-iio+bounces-7530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A392F997
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FE2833A8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA01662FE;
	Fri, 12 Jul 2024 11:32:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-3.us.a.mail.aliyun.com (out198-3.us.a.mail.aliyun.com [47.90.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED419156F53;
	Fri, 12 Jul 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720783957; cv=none; b=Kd186+mdTQ6XCUyilo4iO17Z61Ntl9RgHX1lHIKTCQWaOKjeW1rR7wBDI/CKU23bFfSBbQHQn1+GfzEtBl/yfLsU0xa7pAHv7TvGfuE1BZuhnLcbr5RB9qWMAxVtTmwWRo5QPPYp3RbKi1QSIfXvwDLuOXvx2RUUCKKSh3bxp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720783957; c=relaxed/simple;
	bh=AiGGL5G9Z0hWbcXZnuBJS1tPfi4zjidIWSJSHaWDukI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRgmvqz4wW6nMLZZn5BadSGZiD18ebd3zV7I6w01RN1/ey5G5WJonFKv1tNyQRW2skPGGaakRJ+3PiGOgzkUDRWJVMh30DLdHBPPwPMHswS8oydje11aTHSf9piTysxsq9LqRWIXoDC9qz5ijHOrpAScid9jjRx6UOWHHXVMVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08030076|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0128652-0.000250633-0.986884;FP=7877101106054591998|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040106183;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YOU1nrM_1720783926;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YOU1nrM_1720783926)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 19:32:13 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	waqar.hameed@axis.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V3 0/2] Add support for Awinic SAR sensor
Date: Fri, 12 Jul 2024 11:31:58 +0000
Message-ID: <20240712113200.2468249-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add drivers that support Awinic SAR (Specific Absorption Rate)
sensors to the Linux kernel.

The AW9610X series and AW963XX series are high-sensitivity
capacitive proximity detection sensors.

This device detects human proximity and assists electronic devices
in reducing SAR to pass SAR related certifications.

The device reduces RF power and reduces harm when detecting human proximity.
Increase power and improve signal quality when the human body is far away.

This patch implements device initialization, registration,
I/O operation handling and interrupt handling, and passed basic testing.

shuaijie wang (2):
  dt-bindings: iio: Add YAML to Awinic proximity sensor
  Add support for Awinic proximity sensor

 .../iio/proximity/awinic,aw96xxx.yaml         |  127 ++
 drivers/iio/proximity/Kconfig                 |   10 +
 drivers/iio/proximity/Makefile                |    2 +
 drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++
 drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++
 drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++
 drivers/iio/proximity/aw_sar.h                |   23 +
 drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++
 drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++
 drivers/iio/proximity/aw_sar_type.h           |  371 ++++
 10 files changed, 5626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
 create mode 100644 drivers/iio/proximity/aw9610x.c
 create mode 100644 drivers/iio/proximity/aw963xx.c
 create mode 100644 drivers/iio/proximity/aw_sar.c
 create mode 100644 drivers/iio/proximity/aw_sar.h
 create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c
 create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h
 create mode 100644 drivers/iio/proximity/aw_sar_type.h


base-commit: 43db1e03c086ed20cc75808d3f45e780ec4ca26e
-- 
2.45.1


