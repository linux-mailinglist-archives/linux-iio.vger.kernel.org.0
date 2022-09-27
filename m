Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD385ED076
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiI0WyN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiI0WyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2005D58B4
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q10so5961600oib.5
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EWZt9wTa1gBSeOt9hkCnvFAqrX72cr1OInLn1L4w82c=;
        b=ZyCfgiM5VphrMbZsIxUOXbKFZugEVb6ITgbFCecABu7a4OogTIlVoKqhrdy0hVJ9Te
         tRRV1I4g06WViehAxRsKHoiQsBytV+8f6sNWuHZ0rvtRmQbfyyHYNh93Ru1KPyJaf0Ii
         2Y/Sy3fsgVgrk4jhg6npfBbKHytKRtyNcUc4wc2cXmgeOC72a7MuJ8/YMPs463tu9EXr
         BZ18meWJUPU9UbHhWQs43SZRpVdiUCBDj0lna1BYa0Opn83TOt1NXqWrNXPEd0A/Ll88
         a5SS0TO8rGcyaSYzeTyKKmajgCgtg+Lpt6WmjJ96MaGtJBuzDhh688nXDLDdwbT41i7t
         Kbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EWZt9wTa1gBSeOt9hkCnvFAqrX72cr1OInLn1L4w82c=;
        b=g07W4FtuJSNe2OGVAe3km5Be8/pMWOu2r6wC0xuqLPJlOtgZBbVPoG4PAqRVEY9g5O
         X+dOdHJB6Ddau6+7K2olD36ONG4SwtcC777PxrqRwYsylp0OL7+z8F64UZ9puFulUOkf
         gQIAuQAICWdBmsIGw4Va8JD5+H+1OToTR0R/Wf8204bsppT3WVc4tE3Eu4jrorD9+m6m
         ZCK4WpW2XIQMRkYcVcu2NTjwsgyL6D+aLxD0un8sIlHpVuKfMP6ZSlYqzBf6dN0oEZv/
         E3RMfcvv85WXtca99z7jA9pCy1MuZGmVtQVgr1Do/1k7iu3bPlOu+mPPlyl9jF0C7vI6
         exoQ==
X-Gm-Message-State: ACrzQf3p9BL9zdlFow05DnAAX0+pRuL27eotR7eT8idcRueymQKZBajU
        OiSYror5ePPDiwqbjEtFL/SsLA==
X-Google-Smtp-Source: AMsMyM4aMBTSh1rc+5Jb5V4O8xWxdipxUDj783rvJbMkw52jrFRGwmXENKZP8QsEqriKCihW2MSzHA==
X-Received: by 2002:a05:6808:1391:b0:350:e93b:a4b4 with SMTP id c17-20020a056808139100b00350e93ba4b4mr2899020oiw.199.1664319249225;
        Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 04/12] counter: Introduce the Signal polarity component
Date:   Tue, 27 Sep 2022 18:53:38 -0400
Message-Id: <b6e53438badcb6318997d13dd2fc052f97d808ac.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Signal polarity component represents the active level of a
respective Signal. There are two possible states: positive (rising edge)
and negative (falling edge); enum counter_signal_polarity represents
these states. A convenience macro COUNTER_COMP_POLARITY() is provided
for driver authors to declare a Signal polarity component.

Cc: Julien Panis <jpanis@baylibre.com>
Link: https://lore.kernel.org/r/8f47d6e1db71a11bb1e2666f8e2a6e9d256d4131.1664204990.git.william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 14 ++++++++++++++
 drivers/counter/counter-chrdev.c            |  1 +
 drivers/counter/counter-sysfs.c             | 12 ++++++++++++
 include/linux/counter.h                     | 10 ++++++++++
 include/uapi/linux/counter.h                |  6 ++++++
 5 files changed, 43 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..2a996deabe9e 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -217,6 +217,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
@@ -303,6 +304,19 @@ Description:
 		Discrete set of available values for the respective Signal Y
 		configuration are listed in this file.
 
+What:		/sys/bus/counter/devices/counterX/signalY/polarity
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Active level of Signal Y. The following polarity values are
+		available:
+
+		positive:
+			Signal high state considered active level (rising edge).
+
+		negative:
+			Signal low state considered active level (falling edge).
+
 What:		/sys/bus/counter/devices/counterX/signalY/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 4e71a19d7e6a..120879ee2e87 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -487,6 +487,7 @@ static int counter_get_data(struct counter_device *const counter,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		switch (comp_node->component.scope) {
 		case COUNTER_SCOPE_DEVICE:
 			ret = comp->device_u32_read(counter, &value_u32);
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..e5dd36e1a45f 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -91,6 +91,11 @@ static const char *const counter_count_mode_str[] = {
 	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
 };
 
+static const char *const counter_signal_polarity_str[] = {
+	[COUNTER_SIGNAL_POLARITY_POSITIVE] = "positive",
+	[COUNTER_SIGNAL_POLARITY_NEGATIVE] = "negative"
+};
+
 static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -201,6 +206,8 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 		return sysfs_emit(buf, "%s\n", counter_count_direction_str[data]);
 	case COUNTER_COMP_COUNT_MODE:
 		return sysfs_emit(buf, "%s\n", counter_count_mode_str[data]);
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		return sysfs_emit(buf, "%s\n", counter_signal_polarity_str[data]);
 	default:
 		return sysfs_emit(buf, "%u\n", (unsigned int)data);
 	}
@@ -252,6 +259,10 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 		err = counter_find_enum(&data, avail->enums, avail->num_items,
 					buf, counter_count_mode_str);
 		break;
+	case COUNTER_COMP_SIGNAL_POLARITY:
+		err = counter_find_enum(&data, avail->enums, avail->num_items,
+					buf, counter_signal_polarity_str);
+		break;
 	default:
 		err = kstrtou32(buf, 0, &data);
 		break;
@@ -469,6 +480,7 @@ static int counter_attr_create(struct device *const dev,
 	case COUNTER_COMP_ENUM:
 	case COUNTER_COMP_COUNT_DIRECTION:
 	case COUNTER_COMP_COUNT_MODE:
+	case COUNTER_COMP_SIGNAL_POLARITY:
 		if (comp->device_u32_read) {
 			dev_attr->attr.mode |= 0444;
 			dev_attr->show = counter_comp_u32_show;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index a81234bc8ea8..b3fb6b68881a 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_SIGNAL_POLARITY,
 };
 
 /**
@@ -477,6 +478,15 @@ struct counter_available {
 #define COUNTER_COMP_FLOOR(_read, _write) \
 	COUNTER_COMP_COUNT_U64("floor", _read, _write)
 
+#define COUNTER_COMP_POLARITY(_read, _write, _available) \
+{ \
+	.type = COUNTER_COMP_SIGNAL_POLARITY, \
+	.name = "polarity", \
+	.signal_u32_read = (_read), \
+	.signal_u32_write = (_write), \
+	.priv = &(_available), \
+}
+
 #define COUNTER_COMP_PRESET(_read, _write) \
 	COUNTER_COMP_COUNT_U64("preset", _read, _write)
 
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 96c5ffd368ad..e9610e1944dc 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -153,4 +153,10 @@ enum counter_synapse_action {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
+/* Signal polarity values */
+enum counter_signal_polarity {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
 #endif /* _UAPI_COUNTER_H_ */
-- 
2.37.3

