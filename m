Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB03216990E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2020 18:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBWRc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Feb 2020 12:32:57 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33875 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgBWRc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Feb 2020 12:32:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id b186so4178470ywc.1;
        Sun, 23 Feb 2020 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70VpPYr+0L0MVq2PShKk8nKiIMW+oqGMjSYrERE6AFc=;
        b=IHQwvbHOb4/ZBWdEpm8t3UmpUCRcyea6cHcccwCmTl+ZnKWVggvB1f4MTOsTXt1ijg
         J4i8XbWow4DwQQPANTvTPRoqlamUISvuMTYPBMm4B9V8Ntexmd1cn11+CK/7kh6wH5X3
         1AOLFn6579MXO43Z4Hjor1VvCNIiWkiZCYVMGNFJvmON4jP7svelVWfNYWqsCAyhgMfZ
         yuj8cMPfcaeEowU/Vhkc+lS8nx5UxuEtvhO3lhrc0VA80k9NMfuKGaD/Dxt7cSo9mbOH
         h2IW5UHG7upeMr6KgaF6Wc5eKgeMyGreD1WFXEx+38ELOakRcfjDQUFdvV56/xITS0DT
         bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70VpPYr+0L0MVq2PShKk8nKiIMW+oqGMjSYrERE6AFc=;
        b=M3ZqGHgq7vZpK34tHe3b9ZSFli6BwzMvJzpATahzXL33kvh5YU5i9ESSKzWz/9W2Qx
         SAotweeAVjnP/L9FuYWJu4wGFLW353eO73+WhoiCrHpjZtj7yazSN4OOW0GjCKSIP2Ye
         YvAobZagp0QnASG6UFjjtFLbBHZ1bmK51/gTQ5B+xQsWq+uEokCzVHEQ4diz7PuVSVDX
         aA1y33mgduSPVlMmDxTjrJgoHTALGpjBaz6WQ3QiUMf/FGYRg8P7u9JfjfGs6KBZlSJc
         XT0y62IeIKXK2bOAV+ggfPllPNyrQQ/ZKCZLisNws+pHg20WSXCY2NamH6GzIU7nbSbN
         mCzA==
X-Gm-Message-State: APjAAAWWVzQufmy8DtoZgRZiL8mfIJWlNgpDmv60zjfXrxHIBneSIO8M
        N5nf46NDegA8LoL9iTgixwZ9pGUFuz3bSg==
X-Google-Smtp-Source: APXvYqxDiMX47GctZzfNliuUOKG+BRLhyhW1BeTu3OoDiOoIe2J/H2VkbP0z2/zj6rhMXuekoe6/1g==
X-Received: by 2002:a81:a189:: with SMTP id y131mr39466379ywg.329.1582479175215;
        Sun, 23 Feb 2020 09:32:55 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id b195sm4215980ywh.80.2020.02.23.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 09:32:54 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2] counter: 104-quad-8: Support Differential Encoder Cable Status
Date:   Sun, 23 Feb 2020 12:32:40 -0500
Message-Id: <20200223173240.4341-1-vilhelm.gray@gmail.com>
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
Changes in v2:
 - Set num_ext so quad8_device_ext is actually read

 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 12 ++++++
 drivers/counter/104-quad-8.c                  | 39 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
index 46b1f33b2fce..492b3e98f369 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -1,3 +1,15 @@
+What:		/sys/bus/counter/devices/counterX/cable_status
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Differential encoder cable status; bits 0 through 7
+		correspond to channels 1 through 8. Writing a 0 to the
+		corresponding bit will enable the status of the
+		respective channel.
+
+		Logic 0 = cable fault (not connected or loose wires)
+		Logic 1 = cable connection good or cable fault disabled
+
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 17e67a84777d..cd911e223b48 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -56,6 +56,7 @@ struct quad8_iio {
 
 #define QUAD8_REG_CHAN_OP 0x11
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
+#define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
 /* Borrow Toggle flip-flop */
 #define QUAD8_FLAG_BT BIT(0)
 /* Carry Toggle flip-flop */
@@ -1268,6 +1269,42 @@ static struct counter_count quad8_counts[] = {
 	QUAD8_COUNT(7, "Channel 8 Count")
 };
 
+static ssize_t quad8_cable_status_read(struct counter_device *counter,
+				       void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned int status;
+
+	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
+
+	return sprintf(buf, "0x%X\n", status);
+}
+
+static ssize_t quad8_cable_status_write(struct counter_device *counter,
+					void *private, const char *buf,
+					size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	u8 enable;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &enable);
+	if (ret)
+		return ret;
+
+	outb(enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
+
+	return len;
+}
+
+static const struct counter_device_ext quad8_device_ext[] = {
+	{
+		.name = "cable_status",
+		.read = quad8_cable_status_read,
+		.write = quad8_cable_status_write
+	}
+};
+
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
@@ -1304,6 +1341,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
 	quad8iio->counter.signals = quad8_signals;
 	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
+	quad8iio->counter.ext = quad8_device_ext;
+	quad8iio->counter.num_ext = ARRAY_SIZE(quad8_device_ext);
 	quad8iio->counter.priv = quad8iio;
 	quad8iio->base = base[id];
 
-- 
2.24.1

