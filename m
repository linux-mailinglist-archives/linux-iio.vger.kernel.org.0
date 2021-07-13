Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9AC3C6DE2
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhGMJ5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbhGMJ5I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:57:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E690C0613EE;
        Tue, 13 Jul 2021 02:54:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m83so11405906pfd.0;
        Tue, 13 Jul 2021 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7akesCPV2znBVRN41Z1QYwIOg8zDhI3rATd9/DVG5U=;
        b=aainePnj66ot1cl5WWgwFfELFiq7CQHvhIKfKuXZm22gueZLkEDFNBNMof0Mwy4R6k
         2XWHbtF426bsSKjO57bxp72H+g/l85m0wWPuQKMl/ZCj17FUB6RNsn4Qx0GEfoGTpsKU
         4i4EpF8LsH/QqYG2xTrBKXM/g/phmPLtP4nBa4hFhLnthCS0/GyuhMIKxML6oWQtt/XL
         YJkjwRSpKPX6V5xKj2pKzLrSkj190zH0Vuj35qxPhJsGeUE4BTMqHXH9zcLQuDRQBrSW
         fRlbMaC3bDDtXKaO+Fr1QjWdb/03RlqHTJrNQ3YJJUMONkmOXxOYPhub3dVZQ/s/oq0Q
         0EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7akesCPV2znBVRN41Z1QYwIOg8zDhI3rATd9/DVG5U=;
        b=mMQCoApTjuytz6FF5pTU4euBMZ64XrLPoMsURQaMp/4IPMybOkJlT6NajqNVwrqqSz
         XP2fbWc/Hg9+RF1TUY7IbcUhzaX3vW7X5usQr7oE5jIndhzHzxHIZjV9RiaEwz7dh0E9
         20AMClcg14utBPmrxTKm18WMTPe64a5Ul8G4zaNkoWDa4kqGG9ymQBVQkT1TpZNSufx6
         EtwIvQgVob6vy0wf7MgDK9uAPA2b2CVJrKL0hNGY20o2mGck6wP+qEYunYoUravlcbzM
         gilUO5MyP4hYJ2Pj6leVb+88wqOwj5mmVFyHovPoOXbjlEG11ZvDsBzEV+A3AnmnowcG
         A/QQ==
X-Gm-Message-State: AOAM5318caQk8VSkk69TmP4hY5baxVz/r7Td8JWH8uD3kP7Citg5HBKe
        ZbnWOBukvK9Ccjx9eGXUc0A=
X-Google-Smtp-Source: ABdhPJwvDFEGXdPXzE7KlOjAHYndApHTmtqiNRPrW1H9toeIARD8+D8owqm6hS3yHwWb2YQWqHX0WQ==
X-Received: by 2002:a62:5b81:0:b029:32a:dfe:9bb0 with SMTP id p123-20020a625b810000b029032a0dfe9bb0mr3955543pfb.0.1626170058685;
        Tue, 13 Jul 2021 02:54:18 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:54:18 -0700 (PDT)
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
Subject: [PATCH v13 07/17] counter: Update counter.h comments to reflect sysfs internalization
Date:   Tue, 13 Jul 2021 18:53:11 +0900
Message-Id: <f95ce3f95f9ac068abeec156aefdc3ce1626eebf.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
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

