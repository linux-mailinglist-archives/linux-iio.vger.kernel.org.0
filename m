Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFEB648BF
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGJO4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 10:56:54 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:46688 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbfGJO4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 10:56:45 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B72EEC29D6;
        Wed, 10 Jul 2019 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562770605; bh=sOpj8TE1EeqTTmLP+gVrHPLSRTjiZw/fiM84RPPD9QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZSarFZ81Y0ty/U857owIccjTuKsH8AFSrWfYL3mH1CkTSmsm83Ipv2f/2IMRtcH79
         QKsI+ZE37TIGNA5eh98OsXw7/aiaA3J3hfvE4oq0DKaqOUmHqB6p66UiH34MNOq+LC
         nZyQMZIbanEpJkRBALFV4GhiIwo33PfCLPRVmG8XlU5jwfsOAajgoUTh7PWJIQ8WR2
         m1Zb9URB/toRCjwJm4bCqTPVSD3KkmjoFeO4ul1kxyTD0uWXga+x4wrKVEcpRC6tOw
         iZbl8guZ9rM70PoawhO5qzOXHpQBrre+BWFCLaSr/Ju1BXCtq417FA2T04HIHJfypG
         V2JpW6LezXWUg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5BBF6A0061;
        Wed, 10 Jul 2019 14:56:42 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E64D83FA36;
        Wed, 10 Jul 2019 16:56:41 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, lorenzo@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, bbrezillon@knernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 2/3] i3c: move i3c_device_match_id to device.c and export it
Date:   Wed, 10 Jul 2019 16:56:38 +0200
Message-Id: <debadccffef84c541601a97162ac656cd7c58478.1562767521.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562767521.git.vitor.soares@synopsys.com>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1562767521.git.vitor.soares@synopsys.com>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The i3c device driver needs the i3c_device_id table.
Lets move it to device.c and export it to be used.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Changes in v3:
  Remove i3c_get_device_id
  Move i3c_device_match_id from drivers/i3c/master.c to drivers/i3c/device.c
  Export i3c_device_match_id

Changes in v2:
  move this function to drivers/i3c/device.c

 drivers/i3c/device.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master.c       | 45 ---------------------------------------------
 include/linux/i3c/device.h |  4 ++++
 3 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 69cc040..383df3b 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -200,6 +200,52 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_to_i3cdev);
 
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
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
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

