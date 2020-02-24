Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8603316A32D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 10:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXJye (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 04:54:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBXJyd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 04:54:33 -0500
Received: from 114-34-116-233.hinet-ip.hinet.net ([114.34.116.233] helo=cola.voip.idv.tw)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jesse.sung@canonical.com>)
        id 1j6ARb-00078y-FT; Mon, 24 Feb 2020 09:54:32 +0000
From:   Wen-chien Jesse Sung <jesse.sung@canonical.com>
To:     linux-iio@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: st_sensors: remap SMO8840 to LIS2DH12
Date:   Mon, 24 Feb 2020 17:54:26 +0800
Message-Id: <20200224095426.25681-1-jesse.sung@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to ST, the HID is for LIS2DH12.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/iio/accel/st_accel_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 633955d764cc..849cf74153c4 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -110,7 +110,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
-	{"SMO8840", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
+	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
 	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
 	{ },
 };
-- 
2.20.1

