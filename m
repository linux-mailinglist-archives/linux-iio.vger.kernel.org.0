Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC21A3E45B7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhHIMia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhHIMi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:38:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB96DC061798;
        Mon,  9 Aug 2021 05:38:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso6483658pjb.2;
        Mon, 09 Aug 2021 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06S6aEygv6SQ/wVlttAzgyw3/lRN6L4b7rC8FG/18VY=;
        b=QRDnXDB7jNJLpaBk1hPDvmgVMD20ujOePN48pysCXRff4bV9L2qp7vl7INSyGmSKNn
         X/ATyJGvpifFgITVsVI4k1o4ZZDS54DGFoxkUnLgHEsEq9yZwNos9x/kfS9jJBZ5GAMX
         d3wuHJWzwF6ZrljqSd9AlTW7siXSSR4YQMk62OK28ErWgM+toMi+HpKG/5RBcUxwn5CF
         q9vRe8XN8xG7xpyl+YTlwKHM+RVMqmz0b0T2T2tHBh+hbCwh3EwEUsSBHX+w7btWgx0i
         d55nhe4dVSA0YKHpJ3ujg5t/J331L0CcbLLHRx6Nt66ye1l0YZDz/wq0u15DO7/0TtnL
         YClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06S6aEygv6SQ/wVlttAzgyw3/lRN6L4b7rC8FG/18VY=;
        b=mF3DdKUbKm3MbVnjtJ1yanH8Pf1UjUobcrrtydCAc8PJaBEuCOHyJKRHZvS0C31/0n
         c0oJxXtnPVNAAAtU94M4/S1D62WnGe8lHIw3ehXCV1UIXwirf+y8mwyyCfXdcMXl+8kH
         RzvaCoitPnCfWNcJbKPahF6T9jt9oUBdKQc1OpuyKI+HlbhiP+73FTyBe/LPFcFNkeLZ
         GzjCaZfWgyhCYaimD3KOeMGyxhK0uvaHlXeKfOUiir3iwGdy7lHEfd08o0KNyRBuQlpq
         TyCg02BQCTWJfcQMogZpokdanbvSCO8k9vcIq+L1CE/jZG03mHTKLuZ4ZTRlnthDC9hD
         Ao8g==
X-Gm-Message-State: AOAM531pTD7C7SU5OILGJM9BSAOfs63aR2ASb87ZCOT4wD3ZaGqloPJH
        SZq8MxYTdYlTEqFuRH8gJsI=
X-Google-Smtp-Source: ABdhPJylCu7h16uatRHrhMhmtOvPHWJodBNn8qJnHGl1TTPglH8bU8THuFwoSUg6XzW/Ks1C4K9XFw==
X-Received: by 2002:a63:4a41:: with SMTP id j1mr37026pgl.227.1628512689214;
        Mon, 09 Aug 2021 05:38:09 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:38:08 -0700 (PDT)
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
Subject: [PATCH v15 03/13] counter: Update counter.h comments to reflect sysfs internalization
Date:   Mon,  9 Aug 2021 21:37:28 +0900
Message-Id: <83d75aa8d88d7ca1b5cc9fbb0249fed61f10ba13.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
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

