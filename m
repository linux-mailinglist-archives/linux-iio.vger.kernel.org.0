Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D06598E97
	for <lists+linux-iio@lfdr.de>; Thu, 18 Aug 2022 23:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346392AbiHRVBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Aug 2022 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346301AbiHRVAz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2022 17:00:55 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3CD39B4
        for <linux-iio@vger.kernel.org>; Thu, 18 Aug 2022 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=2QMyQigqupjEi14GAS45NlzrLyU
        hyLireoXcynH4Uh4=; b=gx+ljJX5oCKjcl/a7DB2Q22vYw4z4G/kIrSrJNc+CXI
        29lApFaopCKN0uJGBD49YzJ6GDj9Ulhbb9qFzi8G/SaF9D+qtAZzZtEiJ0r/bn52
        0jfaDh7rLDlAzm6cLxobfcQ1HS9iLwj+8L+Vs/X5UM6/Bi6MAS+smuLXQ2ThzFJM
        =
Received: (qmail 3960180 invoked from network); 18 Aug 2022 23:00:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Aug 2022 23:00:17 +0200
X-UD-Smtp-Session: l3s3148p1@abHGRIrm7doucref
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: move from strlcpy with unused retval to strscpy
Date:   Thu, 18 Aug 2022 23:00:16 +0200
Message-Id: <20220818210017.6817-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Follow the advice of the below link and prefer 'strscpy' in this
subsystem. Conversion is 1:1 because the return value is not used.
Generated by a coccinelle script.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 9910ba1da085..35720c64fea8 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -354,7 +354,7 @@ void st_sensors_dev_name_probe(struct device *dev, char *name, int len)
 		return;
 
 	/* The name from the match takes precedence if present */
-	strlcpy(name, match, len);
+	strscpy(name, match, len);
 }
 EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, IIO_ST_SENSORS);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 9b4298095d3f..f7bce428d9eb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -65,7 +65,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 
 			sub_elem = &elem->package.elements[j];
 			if (sub_elem->type == ACPI_TYPE_STRING)
-				strlcpy(info->type, sub_elem->string.pointer,
+				strscpy(info->type, sub_elem->string.pointer,
 					sizeof(info->type));
 			else if (sub_elem->type == ACPI_TYPE_INTEGER) {
 				if (sub_elem->integer.value != client->addr) {
@@ -158,7 +158,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 				char *name;
 
 				info.addr = secondary;
-				strlcpy(info.type, dev_name(&adev->dev),
+				strscpy(info.type, dev_name(&adev->dev),
 					sizeof(info.type));
 				name = strchr(info.type, ':');
 				if (name)
-- 
2.35.1

