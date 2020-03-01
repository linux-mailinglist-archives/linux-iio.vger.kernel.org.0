Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF9175088
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAWHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 17:07:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33994 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAWHf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Mar 2020 17:07:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id o186so5040722ywc.1;
        Sun, 01 Mar 2020 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPXSJg6s6BbgRfIn2EvRO+J0y9nNBK2HuoAPJTY1510=;
        b=SIx5sYxXU4f4uZpp8ZT/pa86+7PZ8lIr1Hlxm0wAFm42VBGLV045f6pAywIj8ApCdU
         YsySlsCD6a1kQYkXwi1TpW1j6QMcg5KPS0nEVH0WcWsb6Dgy3stNlmKmRu+QWXVan8Ra
         csql7RDwEtGWHkXPR3Okz9Mk2L/QFYRz/HVav8uXE0QZPFRTa6DYgWoByi8aHhqLw+U6
         nqg7Lye0pNnUDYe+qm80AlOBCWdvB0a4Jg9kZOA6Y/DYhm7/V8H4eX82Q5fJHP78pMFI
         sh2yHTg6PkczEU6jGfrWuDFbTgfr0JcHZ+prYAZ+cRuVS3aepp6lE7yeG5hE2VbFAYrk
         b1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPXSJg6s6BbgRfIn2EvRO+J0y9nNBK2HuoAPJTY1510=;
        b=HaqR/WEyy8AFdTQXQhbTIEBeRbI49K6viOFTEJYAdl+gHwn3HjwEcFg57Fuhav+Rvc
         zfmQfI52wczHYKjdHodDyVEIykRpRu53632GGmDFpT+jQZ0787B0dTm+zZZhz05CEO57
         FbGVA29GR/ZXDEJCM5ccZ4Va1MVe4DVIzkVd96SIbIVYi+rnKdYpQpdTmDZQw32udyCu
         398aIU2UQZAhMPkrHNuOpqnSpqxOulOTO3BRa8NzpbqifkEkZaQe8rUKwrF3p+m7bDpB
         7LuYiHt8bPEP16JngEnMAQSCuJm10NGx5CfjR+6D1Uiu+tQLzuO5sGiSPR+GzEXzjq1E
         bX4g==
X-Gm-Message-State: APjAAAVaN4NAKPDpFP3qfPST1ImMwYfGwTeBmZC/cyrDACB5OLfQaS1F
        OCt+niUMEmiq2lvIO47PxAs=
X-Google-Smtp-Source: APXvYqyfbRmQTxhyjDu7eUnt9b8ndsrbSLd4YoFpm1XP2C332JesnLNKlN4I8cAMPffJXzd6PMbbuQ==
X-Received: by 2002:a25:d7d5:: with SMTP id o204mr12847084ybg.102.1583100453869;
        Sun, 01 Mar 2020 14:07:33 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u64sm1902839ywb.103.2020.03.01.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 14:07:32 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3] counter: 104-quad-8: Support Differential Encoder Cable Status
Date:   Sun,  1 Mar 2020 17:07:19 -0500
Message-Id: <20200301220719.25173-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ACCES 104-QUAD-8 series provides status information about the
connection state of the differential encoder cable inputs. This patch
implements support to expose such information from these devices.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v3:
 - Split cable_status attribute into cable_fault and cable_fault_enable;
   both under each Signal so we can control each channel independently
 - Initialize to a default state of disabled for all channels

 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 18 +++++
 drivers/counter/104-quad-8.c                  | 75 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
index 3c905d3cf5d7..eac32180c40d 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -1,3 +1,21 @@
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether a differential
+		encoder cable fault (not connected or loose wires) is detected
+		for the respective channel of Signal Y. Valid attribute values
+		are boolean. Detection must first be enabled via the
+		corresponding cable_fault_enable attribute.
+
+What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether detection of differential encoder cable faults for the
+		respective channel of Signal Y is enabled. Valid attribute
+		values are boolean.
+
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
 KernelVersion:	5.7
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0cfc813ee2cb..9dab190c49b0 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -31,6 +31,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 /**
  * struct quad8_iio - IIO device private data structure
  * @counter:		instance of the counter_device
+ * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
  * @count_mode:		array of count mode configurations
  * @quadrature_mode:	array of quadrature mode configurations
@@ -39,6 +40,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @preset_enable:	array of set_to_preset_on_index attribute configurations
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
+ * @cable_fault_enable:	differential encoder cable status enable configurations
  * @base:		base port address of the IIO device
  */
 struct quad8_iio {
@@ -52,11 +54,13 @@ struct quad8_iio {
 	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
 	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
 	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
+	unsigned int cable_fault_enable;
 	unsigned int base;
 };
 
 #define QUAD8_REG_CHAN_OP 0x11
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
+#define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
 /* Borrow Toggle flip-flop */
 #define QUAD8_FLAG_BT BIT(0)
 /* Carry Toggle flip-flop */
@@ -1143,6 +1147,66 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	return len;
 }
 
+static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
+					     struct counter_signal *signal,
+					     void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id / 2;
+	const bool disabled = !(priv->cable_fault_enable & BIT(channel_id));
+	unsigned int status;
+	unsigned int fault;
+
+	if (disabled)
+		return -EINVAL;
+
+	/* Logic 0 = cable fault */
+	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
+
+	/* Mask respective channel and invert logic */
+	fault = !(status & BIT(channel_id));
+
+	return sprintf(buf, "%u\n", fault);
+}
+
+static ssize_t quad8_signal_cable_fault_enable_read(
+	struct counter_device *counter, struct counter_signal *signal,
+	void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id / 2;
+	const unsigned int enb = !!(priv->cable_fault_enable & BIT(channel_id));
+
+	return sprintf(buf, "%u\n", enb);
+}
+
+static ssize_t quad8_signal_cable_fault_enable_write(
+	struct counter_device *counter, struct counter_signal *signal,
+	void *private, const char *buf, size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id / 2;
+	bool enable;
+	int ret;
+	unsigned int cable_fault_enable;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	if (enable)
+		priv->cable_fault_enable |= BIT(channel_id);
+	else
+		priv->cable_fault_enable &= ~BIT(channel_id);
+
+	/* Enable is active low in Differential Encoder Cable Status register */
+	cable_fault_enable = ~priv->cable_fault_enable;
+
+	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
+
+	return len;
+}
+
 static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	struct counter_signal *signal, void *private, char *buf)
 {
@@ -1180,6 +1244,15 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 }
 
 static const struct counter_signal_ext quad8_signal_ext[] = {
+	{
+		.name = "cable_fault",
+		.read = quad8_signal_cable_fault_read
+	},
+	{
+		.name = "cable_fault_enable",
+		.read = quad8_signal_cable_fault_enable_read,
+		.write = quad8_signal_cable_fault_enable_write
+	},
 	{
 		.name = "filter_clock_prescaler",
 		.read = quad8_signal_fck_prescaler_read,
@@ -1383,6 +1456,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		/* Disable index function; negative index polarity */
 		outb(QUAD8_CTR_IDR, base_offset + 1);
 	}
+	/* Disable Differential Encoder Cable Status for all channels */
+	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-- 
2.24.1

