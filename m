Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40256585311
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiG2Prh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 11:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiG2Pre (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 11:47:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6338875C
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2022 08:47:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id v28so3859093qkg.13
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2022 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+5irFiUay6OqzYY1Rv5ub9Cnd0lFOiyTrIqFEDJ7JXI=;
        b=eE7Ch6REvTQtiVtNny1Li0UJrMD0OJJ3UoM73LbvtAv6U5T0duy3fJH7mbhUHwx/ZY
         qVq7s19dzdDPAYjDILF+kBNNDKHvo06LCv0gunJgiX/EdyKvcriX/wZe8kbK6/Kpa5ZS
         FmDimA9txg4GhwV/D4oymVKnV4Vf0R1x46MPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+5irFiUay6OqzYY1Rv5ub9Cnd0lFOiyTrIqFEDJ7JXI=;
        b=y2C1cCEMDXfcDpfCI1U93AK1ToihZh0P5T1LgjefdLcogo120T5w+vOEN3mQnGTOHu
         sZadDxXBfrT5sdIh2TnAM2h+3Oi1ghHo8lH5Lcn5SptiMZs9+o7ogm2hU3hQxkiCr33s
         m3G1EZa8IXaWnyHjd2HQRuth7Awrh1fpTSVHli4IbTZ/n0aloO6v6PTAl8AU8YpILYpC
         R09GbiHqaokBvWeh2c1wTnC8ZazKHbvwJwfbXDH4OXUpzKQQCc4NZOv5ShYrhHovDKzK
         7bsKajbmSIYpfIx5p29uAsfXQaKfBKgmD0X7Sk6zuD1BdDBKurikugLv0MN68Fg+2uYi
         Hbbw==
X-Gm-Message-State: AJIora8SA34KEgcfz/KpBLzSCPMOd4aHeXeJcXCZW0G88tibHmwhUfnI
        cXYKfn5scv6Jp6wv1myXvLq0BQ==
X-Google-Smtp-Source: AGRyM1s+MKXZCbBRd0Hwqk5spGxfkWWDE5Mi8oOFz+B57d6YT73OhqJSdDL3Fw1nd3TIV4ce0TpYqQ==
X-Received: by 2002:a37:c15:0:b0:6b5:e820:d0a8 with SMTP id 21-20020a370c15000000b006b5e820d0a8mr3192112qkm.452.1659109651842;
        Fri, 29 Jul 2022 08:47:31 -0700 (PDT)
Received: from roguebox.lan ([159.65.38.31])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a048700b0031ea1ad6c5asm2491247qtx.75.2022.07.29.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:47:31 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
Date:   Fri, 29 Jul 2022 23:47:23 +0800
Message-Id: <20220729154723.99947-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for 3x 10-bit ADC and 1x DAC channels registered via
the iio subsystem.

To prevent breakage and unexpected dependencies this support only is
only built if CONFIG_IIO is enabled, and is only weakly referenced by
'imply IIO' within the respective Kconfig.

Additionally the iio device only gets registered if at least one channel
is enabled in the power-on configuration read from SRAM.

Cc: Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/hid/Kconfig       |   3 +-
 drivers/hid/hid-mcp2221.c | 207 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ce92830b5d1..eb4f4bb05226 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1298,7 +1298,8 @@ config HID_ALPS
 config HID_MCP2221
 	tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
 	depends on USB_HID && I2C
-	depends on GPIOLIB
+	select GPIOLIB
+	imply IIO
 	help
 	Provides I2C and SMBUS host adapter functionality over USB-HID
 	through MCP2221 device.
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index de52e9f7bb8c..ab8ca2a65592 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -16,6 +16,8 @@
 #include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/gpio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include "hid-ids.h"
 
 /* Commands codes in a raw output report */
@@ -30,6 +32,8 @@ enum {
 	MCP2221_I2C_CANCEL = 0x10,
 	MCP2221_GPIO_SET = 0x50,
 	MCP2221_GPIO_GET = 0x51,
+	MCP2221_SET_SRAM_SETTINGS = 0x60,
+	MCP2221_GET_SRAM_SETTINGS = 0x61,
 };
 
 /* Response codes in a raw input report */
@@ -89,6 +93,7 @@ struct mcp2221 {
 	struct i2c_adapter adapter;
 	struct mutex lock;
 	struct completion wait_in_report;
+	struct delayed_work init_work;
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
@@ -97,6 +102,17 @@ struct mcp2221 {
 	struct gpio_chip *gc;
 	u8 gp_idx;
 	u8 gpio_dir;
+	u8 mode[4];
+#if IS_REACHABLE(CONFIG_IIO)
+	struct iio_chan_spec iio_channels[3];
+	struct iio_dev *indio_dev;
+	u16 adc_values[3];
+	u8 dac_value;
+#endif
+};
+
+struct mcp2221_iio {
+	struct mcp2221 *mcp;
 };
 
 /*
@@ -745,6 +761,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 				break;
 			}
 			mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
+#if IS_REACHABLE(CONFIG_IIO)
+			if (mcp->indio_dev)
+				memcpy(&mcp->adc_values, &data[50], 6);
+#endif
 			break;
 		default:
 			mcp->status = -EIO;
@@ -816,6 +836,32 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		complete(&mcp->wait_in_report);
 		break;
 
+	case MCP2221_SET_SRAM_SETTINGS:
+		switch (data[1]) {
+		case MCP2221_SUCCESS:
+			mcp->status = 0;
+			break;
+		default:
+			mcp->status = -EAGAIN;
+		}
+		complete(&mcp->wait_in_report);
+		break;
+
+	case MCP2221_GET_SRAM_SETTINGS:
+		switch (data[1]) {
+		case MCP2221_SUCCESS:
+			memcpy(&mcp->mode, &data[22], 4);
+#if IS_REACHABLE(CONFIG_IIO)
+			mcp->dac_value = data[6] & GENMASK(4, 0);
+#endif
+			mcp->status = 0;
+			break;
+		default:
+			mcp->status = -EAGAIN;
+		}
+		complete(&mcp->wait_in_report);
+		break;
+
 	default:
 		mcp->status = -EIO;
 		complete(&mcp->wait_in_report);
@@ -824,6 +870,158 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+#if IS_REACHABLE(CONFIG_IIO)
+static int mcp2221_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+
+	struct mcp2221_iio *priv = iio_priv(indio_dev);
+	struct mcp2221 *mcp = priv->mcp;
+	int ret;
+
+	mutex_lock(&mcp->lock);
+
+	if (channel->output) {
+		*val = mcp->dac_value;
+
+		mutex_unlock(&mcp->lock);
+	} else {
+		// Read ADC values
+		ret = mcp_chk_last_cmd_status(mcp);
+		if (ret < 0) {
+			mutex_unlock(&mcp->lock);
+			return ret;
+		}
+
+		*val = le16_to_cpu(mcp->adc_values[channel->address]);
+
+		mutex_unlock(&mcp->lock);
+
+		// Confirm value is within 10-bit range
+		if (*val > GENMASK(9, 0))
+			return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int mcp2221_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp2221_iio *priv = iio_priv(indio_dev);
+	struct mcp2221 *mcp = priv->mcp;
+	int ret;
+
+	if (val < 0 || val > GENMASK(4, 0))
+		return -EINVAL;
+
+
+	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
+
+	mutex_lock(&mcp->lock);
+
+	memset(mcp->txbuf, 0, 12);
+	mcp->txbuf[0] = MCP2221_SET_SRAM_SETTINGS;
+	mcp->txbuf[4] = BIT(7) | val;
+
+	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);
+
+	hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
+
+	if (ret) {
+		mutex_unlock(&mcp->lock);
+		return -EINVAL;
+	}
+
+	mcp->dac_value = val;
+
+	mutex_unlock(&mcp->lock);
+
+	return 0;
+}
+
+static const struct iio_info mcp2221_info = {
+	.read_raw = &mcp2221_read_raw,
+	.write_raw = &mcp2221_write_raw,
+};
+
+static int mcp_iio_channels(struct mcp2221 *mcp)
+{
+	int idx, cnt = 0;
+	bool dac_created = false;
+
+	// GP0 doesn't have ADC/DAC alternative function
+	for (idx = 1; idx < MCP_NGPIO; idx++) {
+		struct iio_chan_spec *chan = &mcp->iio_channels[cnt];
+
+		switch (mcp->mode[idx]) {
+		case 2:
+			chan->address = idx - 1;
+			chan->channel = cnt++;
+			break;
+		case 3:
+			// GP1 doesn't have DAC alternative function
+			if (idx == 1 || dac_created)
+				continue;
+			// DAC1 and DAC2 outputs are connected to the same DAC
+			dac_created = true;
+			chan->output = 1;
+			cnt++;
+			break;
+		default:
+			continue;
+		};
+
+		chan->type = IIO_VOLTAGE;
+		chan->indexed = 1;
+		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		chan->scan_index = -1;
+	}
+
+	return cnt;
+}
+
+static void mcp_init_work(struct work_struct *work)
+{
+	struct mcp2221 *mcp = container_of(work, struct mcp2221, init_work.work);
+	struct mcp2221_iio *iio;
+	int ret, num_channels;
+
+	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
+
+	mutex_lock(&mcp->lock);
+
+	mcp->txbuf[0] = MCP2221_GET_SRAM_SETTINGS;
+
+	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
+
+	hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
+	mutex_unlock(&mcp->lock);
+
+	if (ret)
+		return;
+
+	num_channels = mcp_iio_channels(mcp);
+	if (!num_channels)
+		return;
+
+	mcp->indio_dev = devm_iio_device_alloc(&mcp->hdev->dev, sizeof(*iio));
+
+	iio = iio_priv(mcp->indio_dev);
+	iio->mcp = mcp;
+
+	mcp->indio_dev->name = "mcp2221";
+	mcp->indio_dev->modes = INDIO_DIRECT_MODE;
+	mcp->indio_dev->info = &mcp2221_info;
+	mcp->indio_dev->channels = mcp->iio_channels;
+	mcp->indio_dev->num_channels = num_channels;
+
+	iio_device_register(mcp->indio_dev);
+}
+#endif
+
 static int mcp2221_probe(struct hid_device *hdev,
 					const struct hid_device_id *id)
 {
@@ -902,6 +1100,11 @@ static int mcp2221_probe(struct hid_device *hdev,
 	if (ret)
 		goto err_gc;
 
+#if IS_REACHABLE(CONFIG_IIO)
+	INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
+	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(500));
+#endif
+
 	return 0;
 
 err_gc:
@@ -920,6 +1123,10 @@ static void mcp2221_remove(struct hid_device *hdev)
 	i2c_del_adapter(&mcp->adapter);
 	hid_hw_close(mcp->hdev);
 	hid_hw_stop(mcp->hdev);
+#if IS_REACHABLE(CONFIG_IIO)
+	if (mcp->indio_dev)
+		iio_device_unregister(mcp->indio_dev);
+#endif
 }
 
 static const struct hid_device_id mcp2221_devices[] = {
-- 
2.36.1

