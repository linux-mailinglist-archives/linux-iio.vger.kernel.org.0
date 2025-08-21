Return-Path: <linux-iio+bounces-23080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6683B2F020
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DD45C3E5F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111828315A;
	Thu, 21 Aug 2025 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jayZIx1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01422765E6;
	Thu, 21 Aug 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762761; cv=none; b=b3NjdWKaQ1V+/my2nDm0fllUk0Se5Hx4JFduA5kThdw+1sbxvcESzw021dxzMQTbHNJwpHmjUXld4XfGkdjxds9vSpI++gVJUvTfAGidb0BRpySQDlu30CQQumXl310huT2evOuBTYi9s8Y9lFhRJn9ceKxaOELRqWGSPd4YxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762761; c=relaxed/simple;
	bh=jzcCdTjPTWy/0kOJUgFpIqxD/aXSjqhNEsia/RAnZS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mHAZoPLGSEed4DmLQFAZR4ZY5Rbby3Q97mv6gLBM/dzKUW8Tf+5N/OqxSQ1mH0pemkh7Bx/oWWhp6veBm2Uo1Zf16jWXHopQwcoWIpfsRLAE+aCEulrC4U/hzBvA6e9QCDOmwpgi8OkuvYUQYS16vlXgfQuImwxLeZbhL1YCifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jayZIx1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AF9EC4CEED;
	Thu, 21 Aug 2025 07:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755762757;
	bh=jzcCdTjPTWy/0kOJUgFpIqxD/aXSjqhNEsia/RAnZS4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jayZIx1Z/4gVH6BBYAnZaS6n5teXepESyBtDnfrhutKSXimzl4S7qLPTVWRZg+yOK
	 RFTchG9zWczJ2Jgumh5yqfdRmRMWLl1GeIvurLC8+ldq8QNPWYhQMxeu557UIVkW3g
	 hgb1wHClDT3TS6Qu2YQmDER4BLqyzYgyNoWX/pVTsHjbwUjDHNtX9LVoGz4RxQRyLV
	 DN4aG8coxs8mETcdJWM3brd23dO1mDwX8i6mcoSKKi26fMgyObZMw+vgcBnb8Ii9Qg
	 XvJAh8eAEvs1JaiHulsT97uVeeJcVfom8XGEh3Cw26XVG0evWv/cyWRplg1EYiJniZ
	 KnRTceJE8m6BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A62CA0EEB;
	Thu, 21 Aug 2025 07:52:37 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 21 Aug 2025 15:52:36 +0800
Subject: [PATCH v4] iio: imu: bmi270: Match PNP ID found on newer GPD
 firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-bmi270-gpd-acpi-v4-1-5279b471d749@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAEPQpmgC/23OTQ6CMBAF4KuQrq3pTKGtrryHcUHbAbrgJ4BEQ
 7i7BRcaMbN6k7xvZmYD9YEGdk5m1tMUhtA2MaSHhLkqb0riwcfMUGAmUChu64Ba8LLzPHdd4J5
 SD2gdZUqz2Op6KsJjE6+3mKswjG3/3A5MsG7flpZiZ03A4xSFM5kFjUpd7k38ZyRXHV1bs9Wb8
 GMYyPYGRsMQeKuMl8rDP0N+GQh7Q0bjBLnR0lmjnfg1lmV5ARyBTGo6AQAA
X-Change-ID: 20250206-bmi270-gpd-acpi-de4d12bce567
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@deepin.org>, 
 Jun Zhan <zhanjun@uniontech.com>, niecheng1@uniontech.com2, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755762756; l=2972;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=ojAJFV6f2om+HVH8bpvM3aYA+vv3G8FtLoA7jKNCvHg=;
 b=Jz9YMcWQ7tePottvnpeSdzAj/hcp0KG7YXA9FjsfqPib6HKh2wgudPVAd2P9cVKm5ukVliv/q
 T3Oi0c117LbCujb0ONlaTaQ/oF5cujJVBRlliSsDwgi6iEmoNR9dllT
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
When they switched to BMI260 sensors in newer hardware, they reused
the existing Windows driver which accepts both "BMI0160" and "BMI0260"
IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
devices, causing driver mismatches in Linux.

1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
BMI260 sensors to avoid loading the bmi160 driver on Linux. While this
isn't Bosch's VID;
2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
3. We're seeing real devices shipping with "BMI0260" in DSDT

The DSDT excerpt of GPD G1619-04 with BIOS v0.40:

Scope (_SB.I2CC)
{
    Device (BMA2)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_HID, "BMI0260")  // _HID: Hardware ID
        Name (_CID, "BMI0260")  // _CID: Compatible ID
        Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
        Name (_UID, One)  // _UID: Unique ID
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (RBUF, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.I2CC",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
        }
        # omit some noise
    }
}

Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip #1
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Changes in v4:
- Improve commit message
- Link to v3: https://lore.kernel.org/r/20250821-bmi270-gpd-acpi-v3-1-91a873cb87c0@uniontech.com

Changes in v3:
- Improve commit message
- Link to v2: https://lore.kernel.org/r/20250815-bmi270-gpd-acpi-v2-1-8e1db68d36d1@uniontech.com

Changes in v2:
- Improve commit message
- Add DSDT table
- Link to v1: https://lore.kernel.org/r/20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com
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
base-commit: 24ea63ea387714634813359e2c8e0e6c36952f73
change-id: 20250206-bmi270-gpd-acpi-de4d12bce567

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



