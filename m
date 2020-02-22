Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29D1168FD3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2020 16:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBVPn7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Feb 2020 10:43:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38210 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVPn7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Feb 2020 10:43:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id x9so288818ybl.5;
        Sat, 22 Feb 2020 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arWDm/3kLJm5rI8N0qQm53HGCCCM1TrzgwNwRa0+tjc=;
        b=jyYsTTy2l60KPfihKG5ZkKn8T/o2ge+FHBhs2TfPMgneaCmIl07wmpxcvyzDZByJBF
         ITFrSnW2MStxqSDZd1qjRTZptoDupZz06d/NJQdBIoAe7zVUQMYMROQkJ2D9iOpkIvzh
         pR5saTpLal99kj+WqEto/Hqlkm++L+yQwZGvoNuz15uc9PDf704w+UBdNFu6+v9XKeph
         biGf9oCuVsJJtPkC6wjbuAnZZB3txDP9DAce7rnUdKFnoq8RBsecojZReHSkl7jl1BbT
         VtobwlixQ/IJw1cZnUVUv9GoprHk8Vv9rIrdmigCYdI3FJLJCTxGM5tk6le/NNvgZLHv
         obWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arWDm/3kLJm5rI8N0qQm53HGCCCM1TrzgwNwRa0+tjc=;
        b=cQK0Z9UpaA0Xq0xbJgEZFagvtatMmYSd8pY4ol8xrXxsmuL9idQucJR6pJMgTr3r6O
         7dhUo4gYXQQk8GfFveSYPvG0EnFEBEfo6neEt9RzEvabnoklFftdbkGW/YLtP4deecd2
         4kmUN8E7wd5E8mxSPLyPPvWYyPqJn/uGSYLXaLI9z3YnoK4yh9TgiggC4F5AgS7zAfhg
         2PFkFtZpJ0tQJr0nPXhiWyWnn06rKS1lfcFqX5p22CKNrCdrrkij1hfsOmuJA8vFD6li
         O1L8j2dy/szN4gByfMEH1W3LWwdNC9ovzHq8e2UPPrhN4SWXRlRkCbuHitM1YLYbzZ4P
         Qjpg==
X-Gm-Message-State: APjAAAXGwd81eyOkLD6ti1MOYLelgIJdQ0/IQo0AGXgng1kQZp4baHRj
        7aDwUbGq7p0CoeK0a8wlq2j31RRG8QAN8Q==
X-Google-Smtp-Source: APXvYqylRu63VslzkP/CTd/NhDeoW859/K/hILADJmdwa2v/0OGJz3gQy2bA8H9ESkxmCJizrtpbuQ==
X-Received: by 2002:a25:aa32:: with SMTP id s47mr3154655ybi.137.1582386237073;
        Sat, 22 Feb 2020 07:43:57 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id s3sm2855329ywf.22.2020.02.22.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 07:43:56 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: 104-quad-8: Support Differential Encoder Cable Status
Date:   Sat, 22 Feb 2020 10:43:40 -0500
Message-Id: <20200222154340.89464-1-vilhelm.gray@gmail.com>
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
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 12 ++++++
 drivers/counter/104-quad-8.c                  | 38 +++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 17e67a84777d..1cbaf7e100a3 100644
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
@@ -1304,6 +1341,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
 	quad8iio->counter.signals = quad8_signals;
 	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
+	quad8iio->counter.ext = quad8_device_ext;
 	quad8iio->counter.priv = quad8iio;
 	quad8iio->base = base[id];
 
-- 
2.24.1

