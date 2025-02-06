Return-Path: <linux-iio+bounces-15064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F43A2A1CC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54092167AFF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642522488E;
	Thu,  6 Feb 2025 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPEfgNcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D853FC0A;
	Thu,  6 Feb 2025 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825792; cv=none; b=m1aPQHd80eUGAG33BUcEuwpFXZ0T4xhyKaGDDop55oU34T0UTsWugDD/iSS9jqZ7oraitQqAVBumSntCvd44D7feptf76Fiwn/zX+hyAGuMlglYEacj47gCRBT++OLPmbRhc1Rdfm4gh/Ga3cpC2pEFSy5Wyd0Z6NPo5a6uV3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825792; c=relaxed/simple;
	bh=N5Xf48CCCLxk/fLOZMF3/waP8FdFK9yVMOKxJzMj3us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P7yidX71ymnAqRMUK+ZyNjxP+IdTswLyghxlYOU6mdZuWWqQErVPlhCJZfTnIA3DcqFcpdQ/1R494gbVAqCldeywiWd18tpwVhjZ2XrIh8VHUX9xLKYn3ZTjMY0RBQSCPeynvT+QGqRPmOGU2Yf7PAASVtPHuTmxqVWluq67wzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPEfgNcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76C51C4CEDD;
	Thu,  6 Feb 2025 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738825791;
	bh=N5Xf48CCCLxk/fLOZMF3/waP8FdFK9yVMOKxJzMj3us=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hPEfgNcMmTd2nLYO92k7fnNhL8jliQTrD+BFMT3a9d4cVc7GqKIA+MYfVJOWA4Mq9
	 5SyeL2Sceef6CyUCrcmmuolNayb7nGNAi3ehate/k5elAE/qfT+mlVbSl0Gy97jPXW
	 pfVwiLBtxuPe3Ju5TcJuw1StA/H+226xqlEvbo7om5n1t63sh80iOsT4ilp6oq1w5O
	 wChZv+0OT5GgIkVrt9UP8srUOtVgQQWLAMTb5WqY/Sz/4OOYP6w7G5bNG6gp0I0blF
	 VRHt9/84lY6MY4iX6bYo6jRPUQnuwPX7S5xVuHaJ1qwYwdaW3pNtkzx+JJKVSJ7ekH
	 TBYs5u8a6+4CA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64661C02198;
	Thu,  6 Feb 2025 07:09:51 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Date: Thu, 06 Feb 2025 15:09:42 +0800
Subject: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>
X-B4-Tracking: v=1; b=H4sIADVgpGcC/x3MQQqAIBBA0avErBvQoRK6SrRInWwWmShEIN09a
 fkW/1conIULzF2FzLcUuWKD7jtwxxYDo/hmIEWjIjWhPYWMwpA8bi4Jeh68Jut4nAy0KmXe5fm
 Py/q+HxuTkRdhAAAA
X-Change-ID: 20250206-bmi270-gpd-acpi-de4d12bce567
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yao Zi <ziyao@disroot.org>, Cryolitia PukNgae <Cryolitia@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=vGeYvEdVrXEykpDXoY202pSht7dfgKW3Zo+sT/kvXh0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvV1k1Z21DYUprZlR3Qnl5WmlBR
 2VrWUR1Z0F6MnBiUHAzYzJlV0U4bTVTSjVWL0VRRmJIQzJFM2xOCk5VanFnUVNaUTRoMUJBQVdD
 Z0FkRmlFRXFCdzdrWDUwaW12VUg0UzhZNWdtQ2FKa2ZUd0ZBbWVrWURzQUNna1EKWTVnbUNhSmt
 mVHdwNlFFQTVZODYrTnBvV1pKQmFxYVlQS1JCa1JEU09qaVdqZHdYWDB3ZVE4dk1qMHNBL1JqRQ
 pPMm5uYjZtcjVZbFgvNWp0bUJRMXRxdTZZVU9ySERlSXo5NjZCK1lQCj0zVFB5Ci0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

From: Cryolitia PukNgae <Cryolitia@gmail.com>

Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.

---
Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.

Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip

[1]. See the update nodes in the archive file above

Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 44699ab589097eaa0eec5f2172245496ed031185..f66ae01e301df24f1e563e059da8cc531fc173eb 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -40,6 +40,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
+	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250206-bmi270-gpd-acpi-de4d12bce567

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



