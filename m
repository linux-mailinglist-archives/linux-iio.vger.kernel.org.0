Return-Path: <linux-iio+bounces-13534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98179F2B6F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 09:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD99188C1F7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DE1FFC60;
	Mon, 16 Dec 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh8wa8rN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702351FF7BC;
	Mon, 16 Dec 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336071; cv=none; b=NR9bj/FFRb6xQFsvllG0oM93P7rIZiB/MX2Ox/AMQ1D8UyQwHhL8Fm5b5mb+OGvplDQra3XDI0G2NIq2m+0e5aizU/5WLCTG4f0Qqok1v2CBeN7ggQRQNJA8bYRk4HRVahSecAIcVnw5J6pNPz8i0zp+hkO1Bm2imQXdNgPhncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336071; c=relaxed/simple;
	bh=lhTD1xtsnfe9gVQvJwMXbUYQjIUYAYA3/l7q5tSFC4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fKai0F7zBq6/n/SgP1Kkv7G4XxqGhL4mU+RTDMkkA90RX9ZSJX586uQKVhOtHmo5WaD/LrFnPffrCiC8Opekb08FrKmeH8Le954HFhfuyWfVCFbzqAJQjNWkeb6D7qjBLzMMUbHmyFxTJICiG/T/2bwxREgvVkOy7VmFs/Fz+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh8wa8rN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215464b0432so3513205ad.0;
        Mon, 16 Dec 2024 00:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734336069; x=1734940869; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v57IcqBQbatDtclCvaJ3hvMsJ4mdDv1UaAkTvQRYm+E=;
        b=Wh8wa8rNw1Z2bQeKEMW/Gz4DfyQ6t0dyPp4VyH/qqe8AThI8lBKfWnLA34iiGD4Zyz
         wY/BAxyF9c77BpsTcMSCSaKXKCT6Wy/h5eRG14TUyqU0zE4WAceRfVoJFlKkfro7yP43
         G3d8YyouHcpNJW2g16u7Z6yEXmUA+5nGI6a+NYAvT3Ce6PugC2WR7wtvygjia/XTPvT7
         SF+6KDGuSboxjX6kCWDT5zTYhfOiWozojmRxPXj16DzVt3jJAoVMar+KjaxTuADLRmiv
         jPj9+NU6v30XBAgGaFK6qpVSO0Q2t7ebugnO4khEvANvbviNc7cTBQx7wkNSDJONgLJr
         aIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336069; x=1734940869;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v57IcqBQbatDtclCvaJ3hvMsJ4mdDv1UaAkTvQRYm+E=;
        b=LoR6uNRxW7J+sHaOHQyJHSSbBoqSoZHFjws2c1iD+ll3lDtBnBAL9CDszzD9jrW0w1
         dLNI601lqUG6rN2ysdwUmuROSUcvI66KMVIV12KNH1swFbQwH3SFyLl7tXrDZ0mztW7b
         qnEmz3mMHpHAn5xWca32NKmVjwNhCaGNVbtzGQBsATwysLPe6Gl5NmCe9vNaA1okL/Wh
         Ouj1Kem/i3uZRDDhlk6o9OB5l6xVhoOi3rKGGKgDcz6iBd6MPPne1evrAQlv0IvtP+3v
         EHYHF48Pq6L9tHl3P26Y56S68P0hd675Qj9MkGs2IYCNxwI3LGxpxR5gLHtDXoVyuEq5
         B+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWAbA+FP+RwNyJItB6RpL84fITTuBI3y9/d0JZWpyK0yibAAnGfYd/zIjlPMNblDNF6QtUYQPb8Nqt8QWqrNmM=@vger.kernel.org, AJvYcCXeG9OYVU+e8FXw9JAlVl3J302c7dyHR/QeAVbMHISZCIaKUqBu5nZn7pi03n8+lFHUPaoxDTEqc5ld6AR9@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdBDosXXx8yu/fyMfYNxKOjLkWKlxHwXu1oq6Hv3/SUw4HltA
	97+M6S4+XzZWKr6q0zAphuSIKIKLJlK6iV8J41gWgmJMxayu68ZOpf9LMg==
X-Gm-Gg: ASbGnct8owJvN7JU1bru0WQb8sJl6SgplE2waOjnz8+P52Uj+mKnR1e22uIYLQnuQ+4
	8ZMenomw0UhKoT0/WVdXWS3ApWTanSyEGmzwILCF9tT0kx28I2x+CmjKb/XuUAQzTXlxU6NZ85r
	lYCdp5xHU5/k4JX8Fag3/VdzFJZFdkTpJg5OeME332iXJrOLfDAX3Vml8xGZShmys3jykmDXC4k
	xitbyORSh1WL1xMQRBwkOFFVcAjRRIv3p0afga1xBrMbTeo/7e0r51G
X-Google-Smtp-Source: AGHT+IG+EwHj8aSdE1HDdWaIfqBuEhvv/e4LR0vp8CiFvt/Adw7PCjXuswkZJ9BXX3UehKHbeOWzJQ==
X-Received: by 2002:a17:902:d483:b0:215:2f19:1dd with SMTP id d9443c01a7336-21892a441damr62564215ad.11.1734336068626;
        Mon, 16 Dec 2024 00:01:08 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5c228sm37075355ad.171.2024.12.16.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:01:07 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 16 Dec 2024 15:59:40 +0800
Subject: [PATCH v2] iio: proximity: hx9023s: Added firmware file parsing
 functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-hx9023s-firmware-20241209-v2-1-ce1b0a1121d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOvdX2cC/32NzQ6CMBCEX4Xs2ZpuaQp48j0Mh1IW2ER+0pqKI
 by7lRiPHr+ZzDcbBPJMAS7ZBp4iB56nBOqUgRvs1JPgNjEoqTQqWYlhraTKg+jYj0/rSfwaXWh
 EKl1rZQNpv3jqeD3ctzrxwOEx+9dxFfGTfq0o/1gjChSlLXJjKmxQmms/Wr6f3TxCve/7G2g4x
 DnCAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=lhTD1xtsnfe9gVQvJwMXbUYQjIUYAYA3/l7q5tSFC4w=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDOnx94zO8miENksJ697yj72YM00uQPW+/oKH+R5KiXPmf
 jQ0XLCpo5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACbSrcrI8NYt1Zhz/hXl57eX
 MJ2YbH+qwnLqCvf/pXZ8gm+aCicuvszIcPUgX9aKeqd103Q3hGeZH22+8Pz2xeui1/t3bbn4c1q
 34C4A
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Configuration information is now prioritized from the firmware file.
If the firmware file is missing or fails to parse, the driver falls
back to using the default configuration list for writing the settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v2:
- Removed unnecessary null checks for firmware loading logic and ensured consistent return values.
- Adjusted code formatting and indentation to comply with Linux kernel coding standards.
- Enhanced error handling: clearly notify users about firmware loading failures through logs.
- Removed unrelated CC recipients.
- Link to v1: https://lore.kernel.org/r/20241210-hx9023s-firmware-20241209-v1-1-8a736691b106@gmail.com
---
 drivers/iio/proximity/hx9023s.c | 93 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 4021feb7a7ac..d5b1522d3c19 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -14,6 +14,7 @@
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
@@ -100,6 +101,17 @@
 #define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
 #define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
 
+#define FW_VER_OFFSET 2
+#define FW_REG_CNT_OFFSET 3
+#define FW_DATA_OFFSET 16
+
+struct hx9023s_bin {
+	u16 reg_count;
+	u16 fw_size;
+	u8 fw_ver;
+	u8 data[] __counted_by(fw_size);
+};
+
 struct hx9023s_ch_data {
 	s16 raw; /* Raw Data*/
 	s16 lp; /* Low Pass Filter Data*/
@@ -998,6 +1010,77 @@ static int hx9023s_id_check(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
+{
+	u8 *cfg_start = bin->data + FW_DATA_OFFSET;
+	u8 addr, val;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < bin->reg_count; i++) {
+		addr = cfg_start[i * 2];
+		val = cfg_start[i * 2 + 1];
+		ret = regmap_write(data->regmap, addr, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
+{
+	struct hx9023s_bin *bin __free(kfree) =
+		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
+	if (!bin)
+		return -ENOMEM;
+
+	memcpy(bin->data, fw->data, fw->size);
+	release_firmware(fw);
+
+	bin->fw_size = fw->size;
+	bin->fw_ver = bin->data[FW_VER_OFFSET];
+	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
+
+	return hx9023s_bin_load(data, bin);
+}
+
+static void hx9023s_cfg_update(const struct firmware *fw, void *context)
+{
+	struct hx9023s_data *data = context;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	if (!fw || !fw->data) {
+		dev_warn(dev, "No firmware\n");
+		goto no_fw;
+	}
+
+	ret = hx9023s_send_cfg(fw, data);
+	if (ret) {
+		dev_warn(dev, "Firmware update failed: %d\n", ret);
+		goto no_fw;
+	}
+
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		dev_err(dev, "regcache sync failed\n");
+
+	return;
+
+no_fw:
+	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
+				     ARRAY_SIZE(hx9023s_reg_init_list));
+	if (ret) {
+		dev_err(dev, "Error loading default configuration\n");
+		return;
+	}
+
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		dev_err(dev, "regcache sync failed\n");
+}
+
 static int hx9023s_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1036,18 +1119,14 @@ static int hx9023s_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	i2c_set_clientdata(client, indio_dev);
 
-	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
-				     ARRAY_SIZE(hx9023s_reg_init_list));
-	if (ret)
-		return dev_err_probe(dev, ret, "device init failed\n");
-
 	ret = hx9023s_ch_cfg(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
-	ret = regcache_sync(data->regmap);
+	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin", dev,
+				      GFP_KERNEL, data, hx9023s_cfg_update);
 	if (ret)
-		return dev_err_probe(dev, ret, "regcache sync failed\n");
+		return dev_err_probe(dev, ret, "reg config failed\n");
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq,

---
base-commit: 8d4d26450d71289a35ff9e847675fd9c718798b8
change-id: 20241209-hx9023s-firmware-20241209-47411e8cda0b

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


