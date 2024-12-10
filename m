Return-Path: <linux-iio+bounces-13295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D19EA72C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 05:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FA41888935
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 04:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62BE13B59E;
	Tue, 10 Dec 2024 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPRIbV64"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64CDF58;
	Tue, 10 Dec 2024 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804724; cv=none; b=B02Yy4YbPym/vWqFhIeO9deaExx/bGLosLAkrmAGKQTGU7uobdBXnrxmKVzat+hAmophKG9Ye63tv2kfNTmJ9qpJgHvw0jDl/EpwxDmN5NNr9i5wEoQONepGqISHsPVXKaPKHcFMHsY5h6SsLd+TJeQDMusZPaOsVtaa6V+CUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804724; c=relaxed/simple;
	bh=O/YJGbdJbOlHhILTmMTUAYfkrFvcP/L1BmrrXm3o8Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mon6z8+IA8LtUxnAsrwBENzwszDwx2uUz3mJOxsWiwaCAyf3ja9pFe0vAt05HHCGtEhMNdQqinoEO8J5RdPqZ/Ffa1UjGSvQKPnFrg34uLCwKubmJ8v/NuLQgNRIhT+WvbpwwhQEy8BghV8XiD6sGSXgW8xBwUM02s98daQthc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPRIbV64; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so614527a91.0;
        Mon, 09 Dec 2024 20:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733804722; x=1734409522; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAx+GWAJi0anhzPiJLVBsaiJXUnl3cfKB1/TAlL4BCA=;
        b=UPRIbV64HaBqHwRk+eNbBrX2oHQUwWr6b8gAcjz8t5ZDJURv0hhUZ58jEsk8/k9ZB1
         TRn/O9tRSnSbZRtCQ94vDFDk21xBYM87fwtPUeYq30Fm2er6JA9P7KG5ZH43sgt+Jrms
         N/Uw8+9TTxQjkOnhCyCIhKfuITL5B5tTNngOaDbwJKfUyBg86QR9TFEwsX8mZYkAsOcD
         qMoLLGW+SK0qhbWZoknGT29lILlrQgTPt4wX3b9JUjcNG64xJQ5ckiNsL07/rMWOeyOF
         Sl+SsHr5hsK4sPTs16mxOVoJ8O9gdobwCprsfGbs7u7fFTSp53Jde1Fkz7vlxK5vw1Kx
         rENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733804722; x=1734409522;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAx+GWAJi0anhzPiJLVBsaiJXUnl3cfKB1/TAlL4BCA=;
        b=cqA75767/QilXRGyITOJcwcaKSBUWaHpgvpOBCC01amWOTR5KX15wl+oGFuRnw7RgF
         9d/FpjuhudcRkEGNLK5TtDuUra77zoF57gyByZA0BJZP9a3Tlrz/5NEJ+IrsKP7eehof
         WhbiNFHCO6xpQm3Zu2RmNFAtNY3LSArLbWy3X11+8ZruOnSsqHUPuOa5BoDGd1kKP3Bw
         T+7UZ0WlNJLUKPmpqOSlhyrxvMcjfjkRaSJ8ViryR4wys9JtJR+zb8yBd5S12ycY39JU
         xW9KxI80qKgfGv8uNRBU3AbdofRLQNvh4KXzwBVSIxinF7bAVrd/XGXUUfWCToROk2Qt
         tzQg==
X-Forwarded-Encrypted: i=1; AJvYcCWyAzSEo9sAkDpmVIdzHpMHRK5jqvmZuhADD4NUItX1OUelhGFQg+fl55NEUZ+R4eAKqBYVrBI73La7aqL9@vger.kernel.org, AJvYcCXbuCQm+f7XNnLr6t3ASeU7ri+iqe61QvOEX3xEKiTHPV3vTGcnEG6doAcYG4Cv0ZdA3I5cO2eROGr8l9X3FQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdzhpo46HRSQ7in/XcrQHDG+23RvOss23KJHCEKWOE2oPFMkc
	N24rDNg+5owJWsRXufjVK1aGUTlzE92Yy3w/2jISHPVf+Awz1aKIiRRHsLbp
X-Gm-Gg: ASbGncsIl+bjO16deJLb0T1wD3RPA2Ec06mKDVr0uVxDMBCK1npww4qhfIfljaICpMS
	VS2zf6ZpAZ/kd5rEH1BOcp1N3HGRUoydIUBW/TdaS30bBYyi1qkyLEW5agmY4WkbnlQK7QJ0RIG
	Sy0/IH71Pmb8eSk0Xbufh7B7xHaUFzFbdURBj9AWzO/ZatTxhkdErVdeUC5CG+NooolfBtwKihq
	TVm45kGmKnKcvkriODYOfaNhgwFtwR+K0r+0XiQPUXCo30/SiFgGw==
X-Google-Smtp-Source: AGHT+IF49yUiZ7apgfpCG286ij20yN+7jrsj88L/peESqoBEUxKfj+htZaSL6JKgjMsMkkVUiMKy5A==
X-Received: by 2002:a17:90b:33c4:b0:2ee:e518:c1d4 with SMTP id 98e67ed59e1d1-2ef69462617mr8813373a91.1.1733804722206;
        Mon, 09 Dec 2024 20:25:22 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef779bace5sm6063189a91.31.2024.12.09.20.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:25:21 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 10 Dec 2024 12:24:03 +0800
Subject: [PATCH] iio: proximity: hx9023s: Added firmware file parsing
 functionality
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-hx9023s-firmware-20241209-v1-1-8a736691b106@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGPCV2cC/z2MQQqAIBAAvyJ7TlATyr4SHay22kMWK5QQ/j3p0
 HEYZh6IyIQROvEA40WRjlBAVwKmzYcVJc2FwShjtVFObskpU0e5EO+3Z5S/sY3VGttp9mqE0p+
 MC6Xv3Q85vzhBUjNrAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4140; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=O/YJGbdJbOlHhILTmMTUAYfkrFvcP/L1BmrrXm3o8Lg=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDOnhh9Z1xOnbvTmW02TEtiM/s/fNtj9fzq/Pyi5dkZquL
 /a1M4Kto5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACYSw8LIsGSHTM1eX97dO7Pv
 3r/0QXfHp+DFe6fcnHMv48O3B76LetwZ/vDu9D3hIzGDpfG+eseD34XhYd9iBQ0OqBh52XGlxHx
 QUwMA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Configuration information is now prioritized from the firmware file.
If the firmware file is missing or fails to parse, the driver falls
back to using the default configuration list for writing the settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 4021feb7a7ac..6cb1b688bfa9 100644
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
@@ -998,6 +1010,80 @@ static int hx9023s_id_check(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int hx9023s_bin_load(struct hx9023s_data *data,
+								struct hx9023s_bin *bin)
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
+	return ret;
+}
+
+static int hx9023s_send_cfg(const struct firmware *fw,
+								struct hx9023s_data *data)
+{
+	if (!fw)
+		return -EINVAL;
+
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
+	if (ret)
+		goto no_fw;
+
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		dev_err(dev, "regcache sync failed\n");
+
+	return;
+
+no_fw:
+	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
+								ARRAY_SIZE(hx9023s_reg_init_list));
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
@@ -1036,18 +1122,14 @@ static int hx9023s_probe(struct i2c_client *client)
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
+	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin",
+						dev, GFP_KERNEL, data, hx9023s_cfg_update);
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


