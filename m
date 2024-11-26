Return-Path: <linux-iio+bounces-12673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDF9D92B2
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 08:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E651166F4A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE511B3946;
	Tue, 26 Nov 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3m5ooa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A51B0F03;
	Tue, 26 Nov 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606870; cv=none; b=IxyQ3lCRqpx0yXJaIcTbfME7XeMX2P/XVhKC69/wAesS9SntKcEAcvY5VeK87mm56TNzEeNoQOufHxeRKdG1aOWIvKCX2ipzChEgZ3Te44z0YBSb7NcCETccnwwCrzJhbfHLUtH2T4OZh4pJLsZd5ttRG1b0/w3daTgdn7Au51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606870; c=relaxed/simple;
	bh=9M3BUBnWBX84sdrrt1VlsxELzNVpB1zj0Q6e6AiyC+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIHUF7HW/LWdhQldNj0XAYe2eKkuQAeCsg3fdr4JcFI6wTwueAZAHxtjJMi/ZvJ/Tqx35r2CTcWSUT7BDc41SWQrYgVPgpG8/PK5CSKfy9EfQZWN9XHYBT5SRd2xqZv8DLzqixd7TosnoLAek8TdcZIZga3OG6fno8TtMeeFfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3m5ooa2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbd76941ccso2303453a12.2;
        Mon, 25 Nov 2024 23:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732606868; x=1733211668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrogf4XupFy3PHxuOI8Ih5yZ+m/19OXVmkoG5zPH3q4=;
        b=b3m5ooa26T2CI6xiaClP+dAbjJG8rU8HRkKccdWo+WdAWWEL8hdlds2UMVwHmAV0kP
         J6DpsZynzfA8j0hFs60EzDGcEAS8BxfqzQgkE0iAuz1l+4e0JD1RQ6ADVnWvLvGQhRRY
         s4XfArQg4+v0kj6QytmEBYtPUFXWWXHqfvKHS0r8dKbpvxg4EZk32DtbE8MiUmEfHba0
         JhWZ14wsyiaCXiSwIJuk4xkg48UzSoIwhShT8WxsqFIy/QfPylFO1xrPGU3W/kLtR/Lt
         WTfV72j5S6VNpuuNmhAAI35xwchVc/vPpWlocCeYX32Ov6ub7QG5cUOcYpx9fIvHVUAo
         31VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606868; x=1733211668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrogf4XupFy3PHxuOI8Ih5yZ+m/19OXVmkoG5zPH3q4=;
        b=q+Xr7zaqMdj1+jwiuu0xwwFLNh8+L+ukzqS/l5Or07oMzgGIsH0RLcqPYuJyEn0XO8
         foa0a234Hbf87IIw60nPnW+esFJ9cbwgFN3+VIZ3trvBEU0RCUVkTEFpGmdHPo0x9WOc
         pAOEFeZN3LNk2x+MEHrKZahVhtigyJVAaDrKh2pKlv3D7gim5KBthdomXLWQR7rujSVL
         8UnMyK+5bIQbiXDGdAKz0Iw7fgD+CmprONp/zzvmE3l8hgZ7mIfHk1NnP3Wmf2Nhz0Ef
         ta09kEXKI/0/5a9ScCqUW9M4j2QpkKHO14VGmYCKF4cHLv0n4VywDRUUQf/YaZWKwwze
         Al4A==
X-Forwarded-Encrypted: i=1; AJvYcCXjywIpUP00mZvN3smaNgm82VsbRk9QWi6x6i72B4Z7kJNe480f8WAOHo1a2Tc5y+CHnXL7vypjLgqa@vger.kernel.org, AJvYcCXmhAGEj7xH6td1S+kuMgDaxV+b+G430EvvtZJBD2w1hIC9S/XNgQ/30d63txgFRE6y5DXz6RS4rGv0rK2L@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUMwSL5LoIPq4YDLSS2p5vYFVzn14x4EGC/x3Xm7s1n/Rseya
	8PrLLBAxT0Q+WG28wB0Ysurm9uErJsSotMf6eUyEu166jaPqoW/c
X-Gm-Gg: ASbGncsjkTGvkC5OhzyeqBEucsuqhg4SG9TdWiW2IgT1W8yS5vLuwY/2I5sdQklgFkE
	DTazOYiUTGGtKmNasqKWJ8/s81L6hLbon1mXUQWylFSW8SBABkl2JyES1OR/Q9QbmSlLIDV6JO4
	Svgkh1Fozf2OlCYCjiYtBQqM4Z+nTU7CtM54XQFpbZbz9T0XhwnMAX50QkATy0vcI9xbMhMCNZT
	ABntvjExCMJ7sIMaENI8q5WPd+cc1SGEq/KCFcS/nFlb6HisT+6YljHr2PerFtgWo4NYoRk50U5
	oQBU05PSYC2r
X-Google-Smtp-Source: AGHT+IGvN+NRd9/lp2uzQGttdVgBslYzo5B5MPCzEnO/SNMzbSFCld5QIZV9Bb+qCG1fRnaGNK329A==
X-Received: by 2002:a05:6a21:898c:b0:1e0:d229:253 with SMTP id adf61e73a8af0-1e0d2290620mr5036094637.32.1732606867651;
        Mon, 25 Nov 2024 23:41:07 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2ceb3sm76237235ad.283.2024.11.25.23.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:41:07 -0800 (PST)
From: Ming Yu <a0282524688@gmail.com>
X-Google-Original-From: Ming Yu <tmyu0@nuvoton.com>
To: tmyu0@nuvoton.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cmo@melexis.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: temperature: Add Nuvoton NCT7718W support
Date: Tue, 26 Nov 2024 15:40:05 +0800
Message-Id: <20241126074005.546447-3-tmyu0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126074005.546447-1-tmyu0@nuvoton.com>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the Nuvoton NCT7718W temperature sensor.

Signed-off-by: Ming Yu <tmyu0@nuvoton.com>
---
 MAINTAINERS                       |   1 +
 drivers/iio/temperature/Kconfig   |  10 +
 drivers/iio/temperature/Makefile  |   1 +
 drivers/iio/temperature/nct7718.c | 505 ++++++++++++++++++++++++++++++
 4 files changed, 517 insertions(+)
 create mode 100644 drivers/iio/temperature/nct7718.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d147ce6b060..5600b4f7c4bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16546,6 +16546,7 @@ M:	Ming Yu <tmyu0@nuvoton.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/temperature/nuvoton,nct7718.yaml
+F:	drivers/iio/temperature/nct7718.c
 
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index ed0e4963362f..e57d643fa664 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -180,4 +180,14 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+config NCT7718
+	tristate "Nuvoton NCT7718W thermal sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7718W
+	  thermal sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct7718.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7..fa1543ebd105 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MCP9600) += mcp9600.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_MLX90632) += mlx90635.o
+obj-$(CONFIG_NCT7718) += nct7718.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o
diff --git a/drivers/iio/temperature/nct7718.c b/drivers/iio/temperature/nct7718.c
new file mode 100644
index 000000000000..60624b3de629
--- /dev/null
+++ b/drivers/iio/temperature/nct7718.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * nct7718.c - Support for Nuvoton NCT7718W Thermal Sensor IC.
+ *
+ * Copyright (C) 2024 Nuvoton Technology Corp.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+
+#define NCT7718_LDT_REG			0x00
+#define NCT7718_RT1_TEMP_MSB		0x01
+#define NCT7718_RT1_TEMP_LSB		0x10
+
+#define NCT7718_ALERTSTATUS_REG		0x02
+#define NCT7718_CONFIG_REG		0x03
+#define NCT7718_ALERTMASK_REG		0x16
+#define NCT7718_ALERTMODE_REG		0xBF
+
+#define NCT7718_LT_HALERT_REG		0x05
+#define NCT7718_RT1_HALERT_MSB_REG	0x0D
+#define NCT7718_RT1_LALERT_MSB_REG	0x0E
+#define NCT7718_RT1_HALERT_LSB_REG	0x13
+#define NCT7718_RT1_LALERT_LSB_REG	0x14
+
+#define NCT7718_CID_REG			0xFD
+#define NCT7718_VID_REG			0xFE
+#define NCT7718_DID_REG			0xFF
+
+#define NCT7718_CHIP_ID			0x50
+#define NCT7718_VENDOR_ID		0x50
+#define NCT7718_DEVICE_ID		0x91
+
+#define NCT7718_LSB_REG_MASK		GENMASK(7, 5)
+#define NCT7718_STS_RT1LA		BIT(3)
+#define NCT7718_STS_RT1HA		BIT(4)
+#define NCT7718_STS_LTHA		BIT(6)
+#define NCT7718_MSK_RT1L		BIT(3)
+#define NCT7718_MSK_RT1H		BIT(4)
+#define NCT7718_MSK_LTH			BIT(7)
+#define NCT7718_MOD_COMP		BIT(0)
+
+#define NCT7718_LOCAL_TEMP_MAX		125
+#define NCT7718_LOCAL_TEMP_MIN		-40
+#define NCT7718_REMOTE_TEMP_MAX_MICRO	127000000
+#define NCT7718_REMOTE_TEMP_MIN_MICRO	-40000000
+
+struct nct7718_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u16 status_mask;
+};
+
+static const struct iio_event_spec nct7718_local_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_event_spec nct7718_remote_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec nct7718_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = nct7718_local_temp_events,
+		.num_event_specs = ARRAY_SIZE(nct7718_local_temp_events),
+	},
+	{
+		.type = IIO_TEMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_TEMP_OBJECT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = nct7718_remote_temp_events,
+		.num_event_specs = ARRAY_SIZE(nct7718_remote_temp_events),
+	}
+};
+
+static int nct7718_read_temp_raw(struct iio_dev *indio_dev,
+				 u8 msb_reg, u8 lsb_reg)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u16 reg_val;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, msb_reg);
+	if (ret < 0)
+		return ret;
+
+	reg_val = (u16)(ret << 3);
+
+	ret = i2c_smbus_read_byte_data(client, lsb_reg);
+	if (ret < 0)
+		return ret;
+
+	reg_val |= FIELD_GET(NCT7718_LSB_REG_MASK, ret);
+
+	return reg_val;
+}
+
+static int nct7718_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->channel2) {
+		case IIO_MOD_TEMP_AMBIENT:
+			ret = i2c_smbus_read_byte_data(client,
+						       NCT7718_LDT_REG);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(ret, 7) << 3;
+			break;
+		case IIO_MOD_TEMP_OBJECT:
+			ret = nct7718_read_temp_raw(indio_dev,
+						    NCT7718_RT1_TEMP_MSB,
+						    NCT7718_RT1_TEMP_LSB);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(ret, 10);
+			break;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 125;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int nct7718_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	unsigned int mask;
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		if (dir == IIO_EV_DIR_RISING)
+			mask = NCT7718_MSK_LTH;
+		break;
+	case IIO_MOD_TEMP_OBJECT:
+		if (dir == IIO_EV_DIR_RISING)
+			mask = NCT7718_MSK_RT1H;
+		else
+			mask = NCT7718_MSK_RT1L;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return !(data->status_mask & mask);
+}
+
+static int nct7718_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	unsigned int status_mask;
+	int ret;
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		if (dir == IIO_EV_DIR_RISING)
+			status_mask = NCT7718_MSK_LTH;
+		break;
+	case IIO_MOD_TEMP_OBJECT:
+		if (dir == IIO_EV_DIR_RISING)
+			status_mask = NCT7718_MSK_RT1H;
+		else
+			status_mask = NCT7718_MSK_RT1L;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_read_byte_data(data->client, NCT7718_ALERTMASK_REG);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret &= ~status_mask;
+	else
+		ret |=  status_mask;
+
+	return i2c_smbus_write_byte_data(data->client, NCT7718_ALERTMASK_REG,
+					 data->status_mask = ret);
+}
+
+static int nct7718_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 msb_reg, lsb_reg;
+	int ret;
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		if (dir == IIO_EV_DIR_RISING) {
+			ret = i2c_smbus_read_byte_data(client,
+						       NCT7718_LT_HALERT_REG);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(ret, 7);
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+	case IIO_MOD_TEMP_OBJECT:
+		if (dir == IIO_EV_DIR_RISING) {
+			msb_reg = NCT7718_RT1_HALERT_MSB_REG;
+			lsb_reg = NCT7718_RT1_HALERT_LSB_REG;
+		} else {
+			msb_reg = NCT7718_RT1_LALERT_MSB_REG;
+			lsb_reg = NCT7718_RT1_LALERT_LSB_REG;
+		}
+		ret = nct7718_read_temp_raw(indio_dev, msb_reg, lsb_reg);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret, 10);
+		*val2 = 8;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int nct7718_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct nct7718_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 msb_reg, lsb_reg;
+	s16 thresh;
+	int ret, s_val;
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		val = clamp_val(val, NCT7718_LOCAL_TEMP_MIN,
+				NCT7718_LOCAL_TEMP_MAX);
+
+		if (dir == IIO_EV_DIR_RISING) {
+			return i2c_smbus_write_byte_data(client,
+							 NCT7718_LT_HALERT_REG,
+							 val);
+		}
+		break;
+	case IIO_MOD_TEMP_OBJECT:
+		s_val = (val < 0) ? ((val * 1000000) - val2) :
+				    ((val * 1000000) + val2);
+
+		s_val = clamp_val(s_val, NCT7718_REMOTE_TEMP_MIN_MICRO,
+				  NCT7718_REMOTE_TEMP_MAX_MICRO);
+
+		if (dir == IIO_EV_DIR_RISING) {
+			msb_reg = NCT7718_RT1_HALERT_MSB_REG;
+			lsb_reg = NCT7718_RT1_HALERT_LSB_REG;
+		} else {
+			msb_reg = NCT7718_RT1_LALERT_MSB_REG;
+			lsb_reg = NCT7718_RT1_LALERT_LSB_REG;
+		}
+
+		thresh = (s16)(s_val / (1000000 >> 3));
+		ret = i2c_smbus_write_byte_data(client,
+						msb_reg, thresh >> 3);
+		if (ret < 0)
+			return ret;
+		return i2c_smbus_write_byte_data(client,
+						 lsb_reg, thresh << 5);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info nct7718_info = {
+	.read_raw = nct7718_read_raw,
+	.read_event_config = nct7718_read_event_config,
+	.write_event_config = nct7718_write_event_config,
+	.read_event_value = nct7718_read_thresh,
+	.write_event_value = nct7718_write_thresh,
+};
+
+static irqreturn_t nct7718_alert_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct nct7718_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+	ret = i2c_smbus_read_byte_data(data->client,
+				       NCT7718_ALERTSTATUS_REG);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	if ((ret & NCT7718_STS_LTHA) &&
+	    !(data->status_mask & NCT7718_MSK_LTH)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_MOD_TEMP_AMBIENT,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+		data->status_mask |= NCT7718_MSK_LTH;
+	}
+	if ((ret & NCT7718_STS_RT1HA) &&
+	    !(data->status_mask & NCT7718_MSK_RT1H)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_MOD_TEMP_OBJECT,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+		data->status_mask |= NCT7718_MSK_RT1H;
+	}
+	if ((ret & NCT7718_STS_RT1LA) &&
+	    !(data->status_mask & NCT7718_MSK_RT1L)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
+						  IIO_MOD_TEMP_OBJECT,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+		data->status_mask |= NCT7718_MSK_RT1L;
+	}
+
+	i2c_smbus_write_byte_data(data->client,
+				  NCT7718_ALERTMASK_REG,
+				  data->status_mask);
+
+	return IRQ_HANDLED;
+}
+
+static bool nct7718_check_id(struct i2c_client *client)
+{
+	int chip_id, vendor_id, device_id;
+
+	chip_id = i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
+	if (chip_id < 0)
+		return false;
+
+	vendor_id = i2c_smbus_read_byte_data(client, NCT7718_VID_REG);
+	if (vendor_id < 0)
+		return false;
+
+	device_id = i2c_smbus_read_byte_data(client, NCT7718_DID_REG);
+	if (device_id < 0)
+		return false;
+
+	return (chip_id == NCT7718_CHIP_ID &&
+		vendor_id == NCT7718_VENDOR_ID &&
+		device_id == NCT7718_DEVICE_ID);
+}
+
+static int nct7718_chip_config(struct nct7718_data *data)
+{
+	int ret;
+
+	/* Enable MSK_LTH, MSK_RT1H, and MSK_RT1L to monitor alarm */
+	ret = i2c_smbus_read_byte_data(data->client,
+				       NCT7718_ALERTMASK_REG);
+	if (ret < 0)
+		return ret;
+	data->status_mask = ret;
+	data->status_mask &= ~(NCT7718_MSK_LTH	|
+			       NCT7718_MSK_RT1H	|
+			       NCT7718_MSK_RT1L);
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					NCT7718_ALERTMASK_REG,
+					data->status_mask);
+	if (ret < 0)
+		return ret;
+
+	/* Config ALERT Mode Setting to comparator mode */
+	return i2c_smbus_write_byte_data(data->client,
+					 NCT7718_ALERTMODE_REG,
+					 NCT7718_MOD_COMP);
+}
+
+static int nct7718_probe(struct i2c_client *client)
+{
+	struct nct7718_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!nct7718_check_id(client)) {
+		dev_err(&client->dev, "No NCT7718 device\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->name = client->name;
+	indio_dev->channels = nct7718_channels;
+	indio_dev->num_channels = ARRAY_SIZE(nct7718_channels);
+	indio_dev->info = &nct7718_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = nct7718_chip_config(data);
+	if (ret)
+		return ret;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev,
+						client->irq,
+						NULL,
+						nct7718_alert_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"nct7718", indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "Failed to request irq!\n");
+			return ret;
+		}
+	}
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id nct7718_of_match[] = {
+	{ .compatible = "nuvoton,nct7718" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nct7718_of_match);
+
+static const struct i2c_device_id nct7718_id[] = {
+	{ "nct7718" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nct7718_id);
+
+static struct i2c_driver nct7718_driver = {
+	.driver = {
+		.name	= "nct7718",
+		.of_match_table = nct7718_of_match,
+	},
+	.probe		= nct7718_probe,
+	.id_table	= nct7718_id,
+};
+module_i2c_driver(nct7718_driver);
+
+MODULE_DESCRIPTION("Thermal sensor driver for NCT7718W");
+MODULE_AUTHOR("Ming Yu <tmyu0@nuvoton.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


