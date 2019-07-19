Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2791F6E66F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfGSNbB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 09:31:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:35552 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728323AbfGSNbA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2019 09:31:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6FAEBC1C32;
        Fri, 19 Jul 2019 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563543059; bh=guLzfTDm0DCrYL34tliMIlpOGpkWKVhqKlozyTjq22U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gBNVRQG3fcgBpP9c+ZTPkHfktcuLn/rIeT9QocKk8tg9L3pMAXKnWzjeKqwXieytv
         CVuhcnFzn2RLqLL32/iLCfWPobtbP8a2mQ+NiJyxuNKAgZtTeoKWLQpudFkQttRyi4
         zwnNRr392g61iEbQKHr7R8S9BryUZrIE9EIftI456GCfhsrqISQzgl57r/glyRUWWp
         YOyeoYNKmSQul4uGkSq/1uChzbb4PIe9btAHa+brE/b7REsbUIVcMSr3HX7/WA7ZnW
         3/fnFwiXGsyQPHc293dcxUlIjZPv6pQanpHANEX7UnZdAvJ+wFv89JwAobzNHlQJT6
         NYOyKkuLK+qqg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 45915A0057;
        Fri, 19 Jul 2019 13:30:57 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E7DF53EBC6;
        Fri, 19 Jul 2019 15:30:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v6 1/2] i3c: move i3c_device_match_id to device.c and export it
Date:   Fri, 19 Jul 2019 15:30:54 +0200
Message-Id: <2f94d66bab7e1d47f7eae8cde8028fd37fa4c423.1563542515.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1563542515.git.vitor.soares@synopsys.com>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1563542515.git.vitor.soares@synopsys.com>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some I3C device drivers need to know which entry matches the
i3c_device object passed to the probe function

Let's move i3c_device_match_id() to device.c and export it so it can be
used by drivers.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Changes in v6:
  Improve kerneldoc

Changes in v5:
  Add kerneldoc
  Improve commit message

Changes in v4:
  None

Changes in v3:
  Remove i3c_get_device_id
  Move i3c_device_match_id from drivers/i3c/master.c to drivers/i3c/device.c
  Export i3c_device_match_id

Changes in v2:
  move this function to drivers/i3c/device.c

 drivers/i3c/device.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master.c       | 45 ---------------------------------------
 include/linux/i3c/device.h |  4 ++++
 3 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 69cc040..c15f5ca 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -201,6 +201,59 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_to_i3cdev);
 
 /**
+ * i3c_device_match_id() - Returns the i3c_device_id entry matching @i3cdev
+ * @i3cdev: I3C device
+ * @id_table: I3C device match table
+ *
+ * Return: a pointer to an i3c_device_id object or NULL if there's no match.
+ */
+const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table)
+{
+	struct i3c_device_info devinfo;
+	const struct i3c_device_id *id;
+
+	i3c_device_get_info(i3cdev, &devinfo);
+
+	/*
+	 * The lower 32bits of the provisional ID is just filled with a random
+	 * value, try to match using DCR info.
+	 */
+	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
+		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
+		u16 part = I3C_PID_PART_ID(devinfo.pid);
+		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
+
+		/* First try to match by manufacturer/part ID. */
+		for (id = id_table; id->match_flags != 0; id++) {
+			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
+			    I3C_MATCH_MANUF_AND_PART)
+				continue;
+
+			if (manuf != id->manuf_id || part != id->part_id)
+				continue;
+
+			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
+			    ext_info != id->extra_info)
+				continue;
+
+			return id;
+		}
+	}
+
+	/* Fallback to DCR match. */
+	for (id = id_table; id->match_flags != 0; id++) {
+		if ((id->match_flags & I3C_MATCH_DCR) &&
+		    id->dcr == devinfo.dcr)
+			return id;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_device_match_id);
+
+/**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
  * @drv: driver to register
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52..7667f84 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -270,51 +270,6 @@ static const struct device_type i3c_device_type = {
 	.uevent = i3c_device_uevent,
 };
 
-static const struct i3c_device_id *
-i3c_device_match_id(struct i3c_device *i3cdev,
-		    const struct i3c_device_id *id_table)
-{
-	struct i3c_device_info devinfo;
-	const struct i3c_device_id *id;
-
-	i3c_device_get_info(i3cdev, &devinfo);
-
-	/*
-	 * The lower 32bits of the provisional ID is just filled with a random
-	 * value, try to match using DCR info.
-	 */
-	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
-		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
-		u16 part = I3C_PID_PART_ID(devinfo.pid);
-		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
-
-		/* First try to match by manufacturer/part ID. */
-		for (id = id_table; id->match_flags != 0; id++) {
-			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
-			    I3C_MATCH_MANUF_AND_PART)
-				continue;
-
-			if (manuf != id->manuf_id || part != id->part_id)
-				continue;
-
-			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
-			    ext_info != id->extra_info)
-				continue;
-
-			return id;
-		}
-	}
-
-	/* Fallback to DCR match. */
-	for (id = id_table; id->match_flags != 0; id++) {
-		if ((id->match_flags & I3C_MATCH_DCR) &&
-		    id->dcr == devinfo.dcr)
-			return id;
-	}
-
-	return NULL;
-}
-
 static int i3c_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct i3c_device *i3cdev;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 5ecb055..de102e4 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -188,6 +188,10 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
 struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
 struct i3c_device *dev_to_i3cdev(struct device *dev);
 
+const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table);
+
 static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
 				      void *data)
 {
-- 
2.7.4

