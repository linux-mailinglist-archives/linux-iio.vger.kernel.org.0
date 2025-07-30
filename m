Return-Path: <linux-iio+bounces-22153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB8B160CE
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC3D1AA1237
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A029617F;
	Wed, 30 Jul 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKdZFenv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087A27AC34;
	Wed, 30 Jul 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880187; cv=none; b=XHnDFeVpyohIdIKfb1KbNuaTswLkJOM1/7VlYtChCWxn3ntJ4SWRGfs82dndgulRPRO6I0xaE2+IO9llnDxiIC2SPA5PjG3xHhd4aljRpAsxi45GuJcPj1pjgWTYsxYE82U2lT/dLmKmGnbkQEPNeV7S2puP3uDAQtGWsNEs8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880187; c=relaxed/simple;
	bh=DACPd/y8QWIW1UrMQhXjMSxlXYxRti2Z23/eSzS9wGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SoXK0wP1LFRaZSOmfqpiA17XQcayoGj2HD+a83QqgvwEXwqCVymK9uDr/SXDvo0gV/+xUGCP+LD49mneI1t69Fv+OImtuwRVestH6V3e64qIiKqskg8JWcDC9njSdtDySugCTo50iuuja9hz115l8oomix/5mElComoerPSgPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKdZFenv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15083C4CEE7;
	Wed, 30 Jul 2025 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753880187;
	bh=DACPd/y8QWIW1UrMQhXjMSxlXYxRti2Z23/eSzS9wGA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RKdZFenvScq7XtzpdrLi0gfRBmU1GLujceubsD0WUGuuAsyEpsJf2WVnhNf4N12kd
	 01F7TEAZKIoJrPz6SfAs/zMNWfY32aACsqVf/tr6pRDyyI0qOAoA8aY2sOg1GWr93w
	 IJWmdQjioXKhfSRF06i3Xh5O7brlTkLG3dMR9SsV+baDGLLzSZuthfAsDgS+Obt017
	 3OzzU+USli+PCVoNcF+pERhZgRpWfMHx9KhL4nsdPrgzXYbXDwtlFqy7wQUW1bqScJ
	 lHE1OcmILw7tjeIf+AvaT242pLh9wmN+cJIskK7ocjcvJAKE+fV2NkFbsgDno5B3ct
	 TANxbGQC8wDvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38B5C83F26;
	Wed, 30 Jul 2025 12:56:26 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Wed, 30 Jul 2025 20:56:16 +0800
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
Message-Id: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAG8WimgC/x3MQQqAIBBA0avErBvQoRK6SrRInWwWmShEIN09a
 fkW/1conIULzF2FzLcUuWKD7jtwxxYDo/hmIEWjIjWhPYWMwpA8bi4Jeh68Jut4nAy0KmXe5fm
 Py/q+HxuTkRdhAAAA
X-Change-ID: 20250206-bmi270-gpd-acpi-de4d12bce567
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>, 
 Jun Zhan <zhanjun@uniontech.com>, Cryolitia PukNgae <liziyao@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753880186; l=1662;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=tfDPKjat9rlbUiCQbb3HHtNunn+iGtYvXq3O0y2Qh+g=;
 b=LLI6ML1UHHB/RjQT+LS52yxqoWtKT7VwVJIiqKv+jIcM3jHAegOP76mcKY0NMnSU9cVg8zPFb
 WtHkRien4rQCN9mPTIntTTuagB5l141KW9fbX8/e0xzL3aoHwvd+z0w
X-Developer-Key: i=liziyao@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for liziyao@uniontech.com/20250730 with
 auth_id=471
X-Original-From: Cryolitia PukNgae <liziyao@uniontech.com>
Reply-To: liziyao@uniontech.com

From: Cryolitia PukNgae <liziyao@uniontech.com>

Some GPD devices ship a buggy firmware that describes on-device BMI260
with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
let's match the correct ID to detect the device. The buggy ID "BMI0160"
is kept as well to maintain compatibility with older firmwares.

Signed-off-by: Cryolitia PukNgae <liziyao@uniontech.com>
---
Some GPD devices ship a buggy firmware that describes on-device BMI260
with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
let's match the correct ID to detect the device. The buggy ID "BMI0160"
is kept as well to maintain compatibility with older firmwares.

Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip

[1]. See the update nodes in the archive file above
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index c77839b03a969f6f149c025a0305c4b9b8ac6571..b909a421ad0176ee414f2f96ff09db2297586ded 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -41,6 +41,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
 	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
+	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 

---
base-commit: 0db240bc077fd16cc16bcecfd7f4645bc474aa7e
change-id: 20250206-bmi270-gpd-acpi-de4d12bce567

Best regards,
-- 
Cryolitia PukNgae <liziyao@uniontech.com>



