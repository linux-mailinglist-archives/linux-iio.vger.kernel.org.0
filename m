Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5E3A095C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhFIBgM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhFIBgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD9CC061574;
        Tue,  8 Jun 2021 18:33:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h12so14308033pfe.2;
        Tue, 08 Jun 2021 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkSx8Vf1Tz6fwzIYbi6rwpZtCNu/e+eDIABNRaP/144=;
        b=besEoPuEmN2IoqPsc32XE6KxQoY/YZAz7MRoUXiEPtRzjPXT5SWfOpiQbCkgQ8c4ui
         yKCbNuVn98JJYaFemAnHysM1/UE6OmvJXm8Q7oREsVH0YtGxqUBwBMc+BzGLRhip5eZh
         frVe2wnzl5ldG5KqgVbNuPzOzozOY4G145Y0J8M+ZTge/ezpKocCTC/ZiT6/568WSczn
         pH3bp1D6ToEOCa/6zARX0VTH/m21FwybQGLZnIJ8Uo77p74s4QUOaxGi0LrXFZ6Xde+1
         bHyW1tnaa8v1dMk6Cq6SWH3tKW0pebW8+cZWnFZqMQuHGnF2TOAVho16F1oGyHSeDB7P
         sKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkSx8Vf1Tz6fwzIYbi6rwpZtCNu/e+eDIABNRaP/144=;
        b=YewHTabsWUn4moajUUBw0MkEmzZKY2+mQ2IV6gAqFGTTpZyv9d4kLBZJyu2QorlSxS
         wUGLJa6E7GZqXqBF+41dBx3THICPMHqnMq35oipHa7KBxZ0cE1lIbewl9D8vUfpfBcLV
         +JfkssuBAj4ykDWO+Cr/i1ShloowJ7DQebgjXmvffxZ+Z3DyMAQ8jVcv/D9G8fg3KjFa
         HvMeq/WxiBsTybjktrdwNpLDAU/hvme9r45vXjqXt62z7Wz2tvnsRDSL5WcRrjDa2vIh
         4sPsLPBMwyL4MEBy8MS0GnYN/czM1PnSoovEXW4d5/St3P9omSHZzDqck1/c5+pwWf5R
         Oufg==
X-Gm-Message-State: AOAM530Pw0gEzWx7eAyugDYd7A349fafdaLUpD4397wyV7Ga6qLhn7x/
        82wWEknPWU5JHJgt8xYrcY1FtZmrUM3XGQ==
X-Google-Smtp-Source: ABdhPJwb4ZdtWsfmipCBGbUaJc0+8DtLXBPwiFiUTfAKjJX10fc4+RZr7KjgbT41NEFNeedUGa7sSQ==
X-Received: by 2002:a62:7ccd:0:b029:2be:1466:5a28 with SMTP id x196-20020a627ccd0000b02902be14665a28mr2660293pfc.55.1623202429750;
        Tue, 08 Jun 2021 18:33:49 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:49 -0700 (PDT)
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
Subject: [PATCH v11 23/33] counter: Update counter.h comments to reflect sysfs internalization
Date:   Wed,  9 Jun 2021 10:31:26 +0900
Message-Id: <ae1707aec1f9d647f88a6c5159ed83009289fcc1.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
 include/linux/counter.h        | 72 +++++++++++++++-------------------
 2 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index e7dd6ea01c8a..407661c6feb0 100644
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
index 567471818ec3..e7fd6d81a929 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -188,12 +188,10 @@ struct counter_comp {
 
 /**
  * struct counter_signal - Counter Signal node
- * @id:		unique ID used to identify signal
- * @name:	device-specific Signal name; ideally, this should match the name
- *		as it appears in the datasheet documentation
- * @ext:	optional array of Counter Signal extensions
- * @num_ext:	number of Counter Signal extensions specified in @ext
- * @priv:	optional private data supplied by driver
+ * @id:		unique ID used to identify the Signal
+ * @name:	device-specific Signal name
+ * @ext:	optional array of Signal extensions
+ * @num_ext:	number of Signal extensions specified in @ext
  */
 struct counter_signal {
 	int id;
@@ -207,7 +205,7 @@ struct counter_signal {
  * struct counter_synapse - Counter Synapse node
  * @actions_list:	array of available action modes
  * @num_actions:	number of action modes specified in @actions_list
- * @signal:		pointer to associated signal
+ * @signal:		pointer to the associated Signal
  */
 struct counter_synapse {
 	const enum counter_synapse_action *actions_list;
@@ -218,17 +216,14 @@ struct counter_synapse {
 
 /**
  * struct counter_count - Counter Count node
- * @id:			unique ID used to identify Count
- * @name:		device-specific Count name; ideally, this should match
- *			the name as it appears in the datasheet documentation
- * @function:		index of current function mode
- * @functions_list:	array available function modes
+ * @id:			unique ID used to identify the Count
+ * @name:		device-specific Count name
+ * @functions_list:	array of available function modes
  * @num_functions:	number of function modes specified in @functions_list
- * @synapses:		array of synapses for initialization
- * @num_synapses:	number of synapses specified in @synapses
- * @ext:		optional array of Counter Count extensions
- * @num_ext:		number of Counter Count extensions specified in @ext
- * @priv:		optional private data supplied by driver
+ * @synapses:		array of Synapses for initialization
+ * @num_synapses:	number of Synapses specified in @synapses
+ * @ext:		optional array of Count extensions
+ * @num_ext:		number of Count extensions specified in @ext
  */
 struct counter_count {
 	int id;
@@ -246,29 +241,26 @@ struct counter_count {
 
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
- * @function_get:	function to get the current count function mode. Returns
- *			0 on success and negative error code on error. The index
- *			of the respective Count's returned function mode should
- *			be passed back via the function parameter.
- * @function_set:	function to set the count function mode. function is the
- *			index of the requested function mode from the respective
- *			Count's functions_list array.
- * @action_get:		function to get the current action mode. Returns 0 on
- *			success and negative error code on error. The index of
- *			the respective Synapse's returned action mode should be
- *			passed back via the action parameter.
- * @action_set:		function to set the action mode. action is the index of
- *			the requested action mode from the respective Synapse's
- *			actions_list array.
+ * @count_write:	write callback for Counts. The write value for the
+ *			respective Count is passed in via the value parameter.
+ * @function_read:	read callback the Count function modes. The read
+ *			function mode of the respective Count should be passed
+ *			back via the function parameter.
+ * @function_write:	write callback for Count function modes. The function
+ *			mode to write for the respective Count is passed in via
+ *			the function parameter.
+ * @action_read:	read callback the Synapse action modes. The read action
+ *			mode of the respective Synapse should be passed back via
+ *			the action parameter.
+ * @action_write:	write callback for Synapse action modes. The action mode
+ *			to write for the respective Synapse is passed in via the
+ *			action parameter.
  */
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
@@ -296,7 +288,7 @@ struct counter_ops {
 
 /**
  * struct counter_device - Counter data structure
- * @name:		name of the device as it appears in the datasheet
+ * @name:		name of the device
  * @parent:		optional parent device providing the counters
  * @ops:		callbacks from driver
  * @signals:		array of Signals
-- 
2.32.0

