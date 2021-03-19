Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD529341AEA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCSLDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCSLDA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:03:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDCC06174A;
        Fri, 19 Mar 2021 04:03:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso4665380pjb.3;
        Fri, 19 Mar 2021 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tcESTYG+Q+wtlieN7sDSgCHsiQUUS+79HIQLrQg5rs=;
        b=J21BnrqJHpV+AM7Wtm83gn7eepWxB63hJ7NockTW0xnljY4G/Q8rDxylDO/t8+EEO+
         GM3TvWFbatL1Ls8O3B38cgjFhhc7XCH4XEqb/Uzmd2ecuBLpoycYdO4ssu7RnbADYIf9
         8trkovvyqz4ySUKnSUwkTTDogA8MWXERP9ucFKUY6lrwWCBVDCpSjOOT3I0hg4xRbe6F
         CrWs/1mkVY41rBhcqnWLW0mV7OOEsODC7Zh5Ah6zG5U8JyC5vm29zUm8GWG7Rgqq54B5
         9pBYbd8+V3GdGFnDT6MSgCnfo2X3AUsA+q1ObTvJsSX8TotE2MTp0ZqlB6se5LoX94ik
         n68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tcESTYG+Q+wtlieN7sDSgCHsiQUUS+79HIQLrQg5rs=;
        b=SPjiLlKxy7PDbnjBAD7DGcGPz+E3HIMgP1Os1Nla+QsFLRQ/eV49zk0TPt3W1rlTEQ
         xV1Y1sgw+BD9hkVwjWePE3VPk2tsr7ZgKsbdWmcHiu5cOodoxFVkv/U+gpnvxA8tyyGj
         1WxIBUhnbXK02+++NEIs4csrfaz0hFS1vigZjIjzNcgbX/zTwfcjUJgd7mD2xuG0o0Jy
         rKSidJ8B1S+BdRQgwspgAz4M3HcWtkAdFJbJD8jiFskB7pSIJ+T5nSvFcxJBnon2FO3k
         qQyHeiEXGC77q7TpnIfZdBOVPDp0th/B22EBJfsnF2NVa5TOPAS8KgSN17Y7BFFSU88B
         5QUA==
X-Gm-Message-State: AOAM532oQrFOjoB7EO8E5wT2DZoZS5rPjM49Ayoj1TpWNHid3Nh4yvkX
        PYVjkE7m20U5ofMekKrTZpQ=
X-Google-Smtp-Source: ABdhPJwXFmip/iYe7tRt8scz59n+KTk0vY40omuBd7na3cbbvJJPI+ZzpMv7hCLc+aNA+xiRI3CFQA==
X-Received: by 2002:a17:90b:228e:: with SMTP id kx14mr9250409pjb.71.1616151779954;
        Fri, 19 Mar 2021 04:02:59 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:59 -0700 (PDT)
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
Subject: [PATCH v10 23/33] counter: Update counter.h comments to reflect sysfs internalization
Date:   Fri, 19 Mar 2021 20:00:42 +0900
Message-Id: <6cc4a2c7c16810addbb072be37022b331e3585cb.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
2.30.2

