Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108783326D5
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCINWd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhCINWN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:22:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFBC06174A;
        Tue,  9 Mar 2021 05:22:13 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q204so9362236pfq.10;
        Tue, 09 Mar 2021 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spjhsDWsVmp1rYIFmfvPTKmpLE6A3E8vWL8uxeu2qR0=;
        b=vhQn/aeItqL6OlE36cHKbo1p2bsZLXE9P7CX9xjwOZB7oDsb5h7w1bKIwYADxUFf0/
         idAcobrHnOa8HoAFrZO5tX/mHqb5Zu0kGezle6FdBAzZHEtPAFSKjU2ebN4o0tyioREQ
         bC+xyND4aFJ8pIZAQDbumlbj3RQzZx9luh0J5/GAQRMh3uju1q0FqhZvIigS62KtwbKp
         +Tbz+AeUKymJaCPIG3LCCBQroqWhtv9REnly5j3ARcFjlv3QZpQ8vnR7ALJAqF3Ln0TJ
         ZhpqPZ3zfh2vq8Y6UdAHtTdqMkMW08+LEqN7qh8wnHCrgByni5GrHAdqGE1p7qKfb8tM
         FXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spjhsDWsVmp1rYIFmfvPTKmpLE6A3E8vWL8uxeu2qR0=;
        b=LxXGRyGJz4aIXOTrUe4H5ZfSu6FIpCAsI8iDNBtKtlGXbmgZ6bSRt6QrKkLs+4ZLUD
         fbARtfHdAA2k37jDLgHMc1KeVN/3znhwBTTdseuJxvqUw2tJ6u7V1PzoKhOqczF5FFpG
         L3epO8kccLtz52P36gDkpHRA3webCUS4LKa1CcM440gpL7KGVk0fRk5Dn4z0dn/FYn3J
         EO0fX4JHueiFWSVXHZWKBLcPbAXJhP+ndKseHpPnNkOT9KhTOx6oCQjIG3BNDwkf70PS
         2MRVq9d0wcdgQvvopjzrn2UPNvt6JLCheai2d6+pILHJQuhlKUREqYxoSAjpuqUrpqlT
         QIgA==
X-Gm-Message-State: AOAM5321KbxSGKCfi9mWpcaaAg3rlCoGMhDz+7ygJtgKpgP7MgpFOecB
        u7a7sIjmAbM3EZtcKBy9bww=
X-Google-Smtp-Source: ABdhPJzuGNOPwo/Bvl7Mx8+XJDPIBFFBY1nXuNPZIeyt9003Bnto1cQysR14YdmUO/GzEaaObYI6WA==
X-Received: by 2002:a63:1542:: with SMTP id 2mr25117350pgv.338.1615296132911;
        Tue, 09 Mar 2021 05:22:12 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:22:12 -0800 (PST)
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
Subject: [PATCH v9 23/33] counter: Update counter.h comments to reflect sysfs internalization
Date:   Tue,  9 Mar 2021 22:19:36 +0900
Message-Id: <29e31fe01911058bad6a2f8373024c29cc6369fc.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

