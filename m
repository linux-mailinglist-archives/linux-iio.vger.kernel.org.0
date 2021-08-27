Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C703F932F
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbhH0DtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbhH0DtY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C3C061757;
        Thu, 26 Aug 2021 20:48:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so7190773pje.0;
        Thu, 26 Aug 2021 20:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06S6aEygv6SQ/wVlttAzgyw3/lRN6L4b7rC8FG/18VY=;
        b=nBbkkhlz31Uj2V5tiBI5vUoixf9y3bKMmbG5Z+zz+PHdh+7vOgPU18bIkQqQbfCHKO
         eJVeyS9JS5qWF9aCTF1By0sYPRDFZPbOzYXxzBiT3ghaqVbTxnkZK5LC3WQ5IEpXDF90
         2GnecM8qkDPntnz3s1llyHYwvHU0TMi95L61pTb0zvOAgyf8++LjQJHR1bUiHLeBrnUU
         lCILwHP70oTMe++IVWtus6g4BchL0wdBCsKhC3H77JmWn7IkptfCId7LnwPp5BubcJEv
         420xPHPfOVTE+HD8F49OtEtMyaL9GOYRm77YYrUkyUuIrJrhaeIyO3NWZptSFlv4B9/B
         c/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06S6aEygv6SQ/wVlttAzgyw3/lRN6L4b7rC8FG/18VY=;
        b=qRA2i98+1YgYItbdknUp1H6YoaED8LnHV5dff7kp948plLAkGjNalaxie/2RrzNBwU
         T+v603atXo/f//nSQOw0MXSvB9GcPJTcR0/c6T8kNLSv+cKR+zb2POpP6vXJ4/M5ihyg
         Yxr6wfbNRs4i+LItksuMyJaEOEPZczdL3MRstFjViVverqVY2kjY00Jl7xCgcz7uvzUl
         5xH68OfdDKsTvR6OOhCkqB5BOn5Qp0EEKnWhusLNyf6pUPV68z5cYcibT6BhOEMJdBjM
         ygk+654GtcHThuIVvLi446sjvbM5y0K6NL9aDimPLTTvHjnbHh8L1SxPb8Ufcgm8v2J8
         2YIw==
X-Gm-Message-State: AOAM531MzmRjq8CKVf72VeTaQcd8A5P9pgL0VzNq4xWfvchA6BGxFw9v
        ChFBEn24galWRLrm9+hucdM=
X-Google-Smtp-Source: ABdhPJxG65tebe0r8wOg6wva3BKyIfybbBGK9hwJk7gAHH3Ck6XhzxGysSsyxvFWQR5036fgZMTI/A==
X-Received: by 2002:a17:902:c401:b0:12d:b1c4:5df3 with SMTP id k1-20020a170902c40100b0012db1c45df3mr6693796plk.15.1630036114991;
        Thu, 26 Aug 2021 20:48:34 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:48:34 -0700 (PDT)
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
Subject: [PATCH v16 04/14] counter: Update counter.h comments to reflect sysfs internalization
Date:   Fri, 27 Aug 2021 12:47:48 +0900
Message-Id: <19da8ae0c05381b0967c8a334b67f86b814eb880.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
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
 drivers/counter/counter-core.c |  3 ++
 include/linux/counter.h        | 62 ++++++++++++++++------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index c533a6ff12cf..3cda2c47bacb 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -38,6 +38,9 @@ static struct bus_type counter_bus_type = {
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
index b69277f5c4c5..445f22d8bfe2 100644
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
@@ -243,27 +241,27 @@ struct counter_count {
 
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
+ * @signal_read:	optional read callback for Signals. The read level of
+ *			the respective Signal should be passed back via the
+ *			level parameter.
+ * @count_read:		read callback for Counts. The read value of the
+ *			respective Count should be passed back via the value
+ *			parameter.
+ * @count_write:	optional write callback for Counts. The write value for
+ *			the respective Count is passed in via the value
  *			parameter.
  * @function_read:	read callback the Count function modes. The read
  *			function mode of the respective Count should be passed
  *			back via the function parameter.
- * @function_write:	write callback for Count function modes. The function
- *			mode to write for the respective Count is passed in via
- *			the function parameter.
- * @action_read:	read callback the Synapse action modes. The read action
- *			mode of the respective Synapse should be passed back via
- *			the action parameter.
- * @action_write:	write callback for Synapse action modes. The action mode
- *			to write for the respective Synapse is passed in via the
- *			action parameter.
+ * @function_write:	optional write callback for Count function modes. The
+ *			function mode to write for the respective Count is
+ *			passed in via the function parameter.
+ * @action_read:	optional read callback the Synapse action modes. The
+ *			read action mode of the respective Synapse should be
+ *			passed back via the action parameter.
+ * @action_write:	optional write callback for Synapse action modes. The
+ *			action mode to write for the respective Synapse is
+ *			passed in via the action parameter.
  */
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
@@ -291,7 +289,7 @@ struct counter_ops {
 
 /**
  * struct counter_device - Counter data structure
- * @name:		name of the device as it appears in the datasheet
+ * @name:		name of the device
  * @parent:		optional parent device providing the counters
  * @ops:		callbacks from driver
  * @signals:		array of Signals
-- 
2.32.0

