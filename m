Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D101319E28
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBLMQh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBLMQE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:16:04 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B30C061788;
        Fri, 12 Feb 2021 04:15:23 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id q8so1137154qvx.11;
        Fri, 12 Feb 2021 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7Ux/Zv3srwXqY0m4J4Hxv1kQ4CaGDRseKF+KFYaZgA=;
        b=THdQf51LqiHyTtRwpP/jkZ0pa0fqfnwcRXzewn4oNgW3qv1+1mBTSV56WQaEjAmllJ
         EGoBNHm9m1+E84oFB6q+pfZFe3nC6J52KfohS373lpqeLfJVRZTHbZ2TszHTHOobf78C
         XqlDtozKSK71v7VyZVaL8LuXiqYD3jo2CjdpeX5frBu+HZ0KtOlOO4uMXPjOZTmyDY1V
         Glg8lAh9ZsGfK2LOsmjpVZ1LAzSoUtr092hGKlsUCJO7MBxB9gP6acGOfJKuqTZw3S23
         xY5cYG5eOzh8k2z+vAhwF+guALi30rHP16jJURUm42cPaHTFdiaSsVWALyYLr9nxFF5N
         r/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7Ux/Zv3srwXqY0m4J4Hxv1kQ4CaGDRseKF+KFYaZgA=;
        b=e3Pxy4ds/c25uquMN5J3eG5kgAiOxpL+upiVv92NqNk+prwEG/BWkzETBNlxrZPAZC
         mlt4SszpeaTWkcoEgXw1Q2YZrKJdZWxbjWAYy7pnCNBUsqjoRUYuBPjNLN03GSz2FZ5V
         s/BxW8szgz05SVYyf06dofDp7IVW+tQcxCaVsOYDNIqLefyenbVhCs/h1kjmmtmH3Dtt
         F7qUBRcLxGwzzh1FGmqRf6I3keOWwrhzBBh8uvpMYtG1glHh3QMJWxG07lH1QjQ1w0cw
         mwxewcQfccU2LM4smyGc2NgY0tfIc4ZboLkntihvtu2+FKGkOIQDpQ43rF5SpnzMOIbY
         y87Q==
X-Gm-Message-State: AOAM5320Ie6ttSex7ZequGe9hhTWdpEJf4L6AtWzDMwX6BZ0doXJXMHD
        S+ZxaYy8xtCa9hjRQGRQ/fo=
X-Google-Smtp-Source: ABdhPJx0eMmFLBPmmIgWd4x1X0KThwe1Azvkuwb19abvL00i78ODiL5sjd4VVw+ytaTZBmuVhwTgvA==
X-Received: by 2002:ad4:55aa:: with SMTP id f10mr2235053qvx.46.1613132122933;
        Fri, 12 Feb 2021 04:15:22 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:15:22 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 14/22] counter: Update counter.h comments to reflect sysfs internalization
Date:   Fri, 12 Feb 2021 21:13:38 +0900
Message-Id: <514843522c18867ec2bc7b82ba084d5e7cc22381.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
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
index 1577a6562cad..bcf672e1fc0d 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -40,6 +40,9 @@ static struct bus_type counter_bus_type = {
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
index 76b0b06dd5db..2f01e1fec857 100644
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
2.30.0

