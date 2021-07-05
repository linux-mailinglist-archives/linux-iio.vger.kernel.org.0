Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C436B3BB8C9
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGEIWn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGEIWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:22:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D070C061760;
        Mon,  5 Jul 2021 01:20:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso11339748pjp.2;
        Mon, 05 Jul 2021 01:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8w3H0E2Vn1sT5Yu/HP9gvbQ2v5uZuQwgYPJqq4exoQ=;
        b=kzs+3wre7cUn9/u8OvLOPsE7notGqdhoTOpQdz/vOdw4aoHFEO44zojcX5kiP58QOy
         VvzXwCjlJj+LsgcV3aIsJFHhLw3tDk9KgSrtGzVevCI/w10EW5covU8TgJ739S/tskdB
         JjFTj97gQBLb1cqOQ8M2VGrukqbAiHq/gvRRk0vLdPWVNW7B3GLMOjLQQ4XNu8DgNMR9
         ETYFcZi9T8AKdGeIKqHHtbZpgsRSWmZrurL+xeb6yjTNV7z0uCBSAYKUAOe1pEHkcIdH
         wIWWcWwSauWI60T0sRNFp3g3xuAtJiDwhk4f7KkWwWNvYCkfldlEmqIXtf2RxppJCE6A
         aEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8w3H0E2Vn1sT5Yu/HP9gvbQ2v5uZuQwgYPJqq4exoQ=;
        b=esfKN+jPeVWbVSO11jM3V5S+WfkJIFEo+Q69Bg94v/6yHY1prTn/mTEJodg/bX5XvZ
         6pt5xNkCJwRmbmglM0JknEFEy3C+sYokDMxFFHM0jtV+Inoe1slxPMC/4fSnA5ar6AN4
         Ta5ly8DK8uorqWXCilT5iUPjsXaA/syXnAaY53GiXTzy5NmSgInJ1iDUb67b4IJBocD4
         7jq6/UTdmHSW0yOpBt1VYbPrjCnFYczsz8ByzZhgdjJbaji0odiyg9V0DT7VGh5EiMEp
         /u5a+49UmbHHa6t/xA3nVXCQvYbd6m7qrsjy7BXIZaMzGClrXlPUJ0hVaL5RleMqsT2i
         +S1A==
X-Gm-Message-State: AOAM5308EYTzo3ugYnBrxEj4aRMJS8kc4Lv7m+0Vo20JR28L0oVL5Zk/
        +2ipp134Bcl8O6GEEpD5z+8=
X-Google-Smtp-Source: ABdhPJzMf9xgDADDSXNkZDgrDUTtf/aU8hFXFiMa55I0/wRtPoKEtzrPNESksCIb7z7v26x3cM5TKw==
X-Received: by 2002:a17:90a:73ca:: with SMTP id n10mr13975765pjk.16.1625473200779;
        Mon, 05 Jul 2021 01:20:00 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:20:00 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 07/17] counter: Update counter.h comments to reflect sysfs internalization
Date:   Mon,  5 Jul 2021 17:18:55 +0900
Message-Id: <4223302f61b77b82b3927bd3280d0df791418d76.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Counter subsystem architecture and driver implementations have
changed in order to handle Counter sysfs interactions in a more
consistent way. This patch updates the Generic Counter interface
header file comments to reflect the changes.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-core.c |  3 +++
 include/linux/counter.h        | 43 ++++++++++++++++------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 15f735ef296e..9442e3b91468 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -41,6 +41,9 @@ static struct bus_type counter_bus_type = {
  * This function registers a Counter to the system. A sysfs "counter" directory
  * will be created and populated with sysfs attributes correlating with the
  * Counter Signals, Synapses, and Counts respectively.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
  */
 int counter_register(struct counter_device *const counter)
 {
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b69277f5c4c5..e7fd6d81a929 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -188,11 +188,10 @@ struct counter_comp {
 
 /**
  * struct counter_signal - Counter Signal node
- * @id:		unique ID used to identify signal
- * @name:	device-specific Signal name; ideally, this should match the name
- *		as it appears in the datasheet documentation
- * @ext:	optional array of Counter Signal extensions
- * @num_ext:	number of Counter Signal extensions specified in @ext
+ * @id:		unique ID used to identify the Signal
+ * @name:	device-specific Signal name
+ * @ext:	optional array of Signal extensions
+ * @num_ext:	number of Signal extensions specified in @ext
  */
 struct counter_signal {
 	int id;
@@ -206,7 +205,7 @@ struct counter_signal {
  * struct counter_synapse - Counter Synapse node
  * @actions_list:	array of available action modes
  * @num_actions:	number of action modes specified in @actions_list
- * @signal:		pointer to associated signal
+ * @signal:		pointer to the associated Signal
  */
 struct counter_synapse {
 	const enum counter_synapse_action *actions_list;
@@ -217,15 +216,14 @@ struct counter_synapse {
 
 /**
  * struct counter_count - Counter Count node
- * @id:			unique ID used to identify Count
- * @name:		device-specific Count name; ideally, this should match
- *			the name as it appears in the datasheet documentation
- * @functions_list:	array available function modes
+ * @id:			unique ID used to identify the Count
+ * @name:		device-specific Count name
+ * @functions_list:	array of available function modes
  * @num_functions:	number of function modes specified in @functions_list
- * @synapses:		array of synapses for initialization
- * @num_synapses:	number of synapses specified in @synapses
- * @ext:		optional array of Counter Count extensions
- * @num_ext:		number of Counter Count extensions specified in @ext
+ * @synapses:		array of Synapses for initialization
+ * @num_synapses:	number of Synapses specified in @synapses
+ * @ext:		optional array of Count extensions
+ * @num_ext:		number of Count extensions specified in @ext
  */
 struct counter_count {
 	int id;
@@ -243,15 +241,14 @@ struct counter_count {
 
 /**
  * struct counter_ops - Callbacks from driver
- * @signal_read:	optional read callback for Signal attribute. The read
- *			level of the respective Signal should be passed back via
- *			the level parameter.
- * @count_read:		optional read callback for Count attribute. The read
- *			value of the respective Count should be passed back via
- *			the val parameter.
- * @count_write:	optional write callback for Count attribute. The write
- *			value for the respective Count is passed in via the val
+ * @signal_read:	read callback for Signals. The read level of the
+ *			respective Signal should be passed back via the level
+ *			parameter.
+ * @count_read:		read callback for Counts. The read value of the
+ *			respective Count should be passed back via the value
  *			parameter.
+ * @count_write:	write callback for Counts. The write value for the
+ *			respective Count is passed in via the value parameter.
  * @function_read:	read callback the Count function modes. The read
  *			function mode of the respective Count should be passed
  *			back via the function parameter.
@@ -291,7 +288,7 @@ struct counter_ops {
 
 /**
  * struct counter_device - Counter data structure
- * @name:		name of the device as it appears in the datasheet
+ * @name:		name of the device
  * @parent:		optional parent device providing the counters
  * @ops:		callbacks from driver
  * @signals:		array of Signals
-- 
2.32.0

