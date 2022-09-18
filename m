Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C065BBE72
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIROgz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIROgp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 10:36:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA70222A7
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g2so16120268qkk.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aFLFcX0Ge1NaS+vS/PtWRb3M+OHkdYHPDl97KJAqEJg=;
        b=WmQiztou3FCfn/Hz1KGe1HZ1abdjEdJxRWsNN54qdxJ+aCYDS2Gvb+rvhEUYqiZdev
         eO1vpCS8B2Sbfv3IaxaKVs3r3PSoRAguCWllD/u1EuSWT5alec7ec4DWcaanJcdoKyd1
         Bw4/OGAtQtcx9YmAMgCj8Vs+K2kxu10QKvW0w87NhAXcB/U+yqayovcMF3IkZik+oYPb
         CaR6qD2CfcqbmLcl/CdW1wVQSLTLJwwv2/rD1uSfUGclvVu7Eg1jMzEoVLwG375QIEGF
         p7EerXK1ut/AthOy5fwLn1WKvnAdBe99mh59x3tY8WKnswLN5s8+y2PtOJaghwL9Ur85
         x+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aFLFcX0Ge1NaS+vS/PtWRb3M+OHkdYHPDl97KJAqEJg=;
        b=hfh3lu7o9PU8BNyQZGew3uXP1LBWPBnWr4mJyEZOm+rwS+lstRUYDumiznmPnTmkYv
         oVCjmugdV6HwTqRpimulKYlDDLdeuWpQu3oT3IPuh9g24JDoP92JcIgfwDg31ygGj76f
         dahZ+yZhTpoO0bOKxAH4Rvq7mi42GxUdz7dfJXe9fWgjUcT/+bl/vPbwEEAAIz5+kZnS
         Ob5DENAiPnuy+ODdfPa8pfGjnig7a3SWMnfARQUODd6V8WTI4omInRO/t/xZblZxL/1E
         LtfhV3TjMJm+p7TJNekKz6k2k7+lrPPHUcJSOZwENQABqzdt9XYGkuW9liiFDsUB0f1J
         6GzQ==
X-Gm-Message-State: ACrzQf3adf+VQL5hqWZke+ZkgC0fZKQnTOStfipqbD31Pce3tue+uers
        BI70ULYHRFyyjZQASv3xDjhbnl6ww4MkHg==
X-Google-Smtp-Source: AMsMyM64Fbn0DNezINL7uBn/WUKg37RK5a4t1KOiMSSRJhl3qjD+05cUsHM3QMSmlODukfBEHyxmdw==
X-Received: by 2002:a05:620a:280b:b0:6b6:5a6c:9acf with SMTP id f11-20020a05620a280b00b006b65a6c9acfmr10086348qkp.749.1663511803455;
        Sun, 18 Sep 2022 07:36:43 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm11456215qkp.85.2022.09.18.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:36:43 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 1/4] counter: Introduce the Signal polarity component
Date:   Sun, 18 Sep 2022 10:36:31 -0400
Message-Id: <dbf9d9cfb9ba3b46b177e0a2c24520e8e2def1bb.1663511054.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663511054.git.william.gray@linaro.org>
References: <cover.1663511054.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 13 +++++++++++++
 drivers/counter/counter-sysfs.c             | 11 +++++++++++
 include/linux/counter.h                     | 10 ++++++++++
 include/uapi/linux/counter.h                |  6 ++++++
 4 files changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 06c2b3e27e0b..a234022f9add 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -303,6 +303,19 @@ Description:
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
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..92d3d4f549cb 100644
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
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 1fe17f5adb09..d508b260aaca 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -31,6 +31,7 @@ enum counter_comp_type {
 	COUNTER_COMP_ENUM,
 	COUNTER_COMP_COUNT_DIRECTION,
 	COUNTER_COMP_COUNT_MODE,
+	COUNTER_COMP_SIGNAL_POLARITY,
 };
 
 /**
@@ -483,4 +484,13 @@ struct counter_available {
 #define COUNTER_COMP_PRESET_ENABLE(_read, _write) \
 	COUNTER_COMP_COUNT_BOOL("preset_enable", _read, _write)
 
+#define COUNTER_COMP_POLARITY(_read, _write, _available) \
+{ \
+	.type = COUNTER_COMP_SIGNAL_POLARITY, \
+	.name = "polarity", \
+	.signal_u32_read = (_read), \
+	.signal_u32_write = (_write), \
+	.priv = &(_available), \
+}
+
 #endif /* _COUNTER_H_ */
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

