Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65AB5ED074
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiI0WyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI0WyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B96CF4B3
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n83so13502455oif.11
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MciPEz9A5X8un10orFZOdn2x2fMP8cVDFasDSDZI7dY=;
        b=UOGXpIJdGLTKuc4WhjDl9BaPNQIzoYXK/7LFnj4gQqkgtz6tec+aHbSh4vB7H/1vgj
         Iba2pTjfRZx6DLn0NIzuxl4wTQoFcrU3o134LMBs67kNbliaftzwzuTJ3MxJaHrk36Jf
         7joJVbAsxPkCs7s9bUQl9HMG9C0x7GxfW1HJUhNhNMqQRUGWCyzpPcsefvsdytZYpMjx
         HsqQxEQVJBtC3XKd2/43RU6W18QwXA2PmxHtXR8clQdeD6BKdzx3N7OxW+6ZCKtrswvN
         VqdcUWuJIOwqr35Rv1UrvNkfzzOp1wRdoZVimbE1zgnBi9XFpKUCRErZsO1hLbg33ubN
         pjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MciPEz9A5X8un10orFZOdn2x2fMP8cVDFasDSDZI7dY=;
        b=4+2hsisyEvJ8JStmtnyMppHzY64PzeaB+h6nm9HCNqDnlpNCxuAAaBaMIaQ3l/OvFI
         4EnjvoP97rdO3fJbriqnsbqQJRArXGDBZ+ShlrE+JkOJsDdfjmL4s5cG1+DsE6ZGWgea
         ktbx8nwf8X0zPor7SOYgKWuATpHetNsdU+caNqlSDosFgPOG2wGhQnM78ZAMgMqkVv4b
         E9PN7JE1t41xYfAfLsHScLeyAuxurZ6wVSRThZKHXqfXgS+U/KZ8y7BLTFotBXzDa9hV
         bky2QyojxPSbS+qw++dIQXsaethQDftHPb/xHXSRPn0Xzoa/Ri9OKdACZcgRtjgH/sMJ
         aj9Q==
X-Gm-Message-State: ACrzQf0r4EL8Gq93lWtYvtQHOfSdkX5pN+At2BRYNdbEzSS7xF5o8fpT
        DcrvCzBEjyE/x35U+/+kta01Ew==
X-Google-Smtp-Source: AMsMyM5q5EX57vdlDSLmulutwEHiiMyt/d10izxitUTWY1s+0nGr7U/9MBccGRmZb3LPv994mEsDmA==
X-Received: by 2002:a05:6808:30a8:b0:350:2323:ef2e with SMTP id bl40-20020a05680830a800b003502323ef2emr2837890oib.38.1664319247649;
        Tue, 27 Sep 2022 15:54:07 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/12] counter: Move symbols into COUNTER namespace
Date:   Tue, 27 Sep 2022 18:53:36 -0400
Message-Id: <8a756df96c24946547a7ece5caa5f654809c5e7f.1664318353.git.william.gray@linaro.org>
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

Counter subsystem symbols are only relevant to counter drivers. A
COUNTER namespace is created to control the availability of these
symbols to modules that import this namespace explicitly.

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Acked-by: David Lechner <david@lechnology.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220815220321.74161-1-william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c            |  1 +
 drivers/counter/counter-chrdev.c        |  2 +-
 drivers/counter/counter-core.c          | 14 +++++++-------
 drivers/counter/ftm-quaddec.c           |  1 +
 drivers/counter/intel-qep.c             |  1 +
 drivers/counter/interrupt-cnt.c         |  1 +
 drivers/counter/microchip-tcb-capture.c |  1 +
 drivers/counter/stm32-lptimer-cnt.c     |  1 +
 drivers/counter/stm32-timer-cnt.c       |  1 +
 drivers/counter/ti-eqep.c               |  1 +
 10 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 62c2b7ac4339..1323edfbe40c 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1241,3 +1241,4 @@ module_isa_driver(quad8_driver, num_quad8);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-QUAD-8 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 69d340be9c93..4e71a19d7e6a 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -574,4 +574,4 @@ void counter_push_event(struct counter_device *const counter, const u8 event,
 	if (copied)
 		wake_up_poll(&counter->events_wait, EPOLLIN);
 }
-EXPORT_SYMBOL_GPL(counter_push_event);
+EXPORT_SYMBOL_NS_GPL(counter_push_event, COUNTER);
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 938651f9e9e0..09c77afb33ca 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -73,7 +73,7 @@ void *counter_priv(const struct counter_device *const counter)
 
 	return &ch->privdata;
 }
-EXPORT_SYMBOL_GPL(counter_priv);
+EXPORT_SYMBOL_NS_GPL(counter_priv, COUNTER);
 
 /**
  * counter_alloc - allocate a counter_device
@@ -133,13 +133,13 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(counter_alloc);
+EXPORT_SYMBOL_NS_GPL(counter_alloc, COUNTER);
 
 void counter_put(struct counter_device *counter)
 {
 	put_device(&counter->dev);
 }
-EXPORT_SYMBOL_GPL(counter_put);
+EXPORT_SYMBOL_NS_GPL(counter_put, COUNTER);
 
 /**
  * counter_add - complete registration of a counter
@@ -166,7 +166,7 @@ int counter_add(struct counter_device *counter)
 	/* implies device_add(dev) */
 	return cdev_device_add(&counter->chrdev, dev);
 }
-EXPORT_SYMBOL_GPL(counter_add);
+EXPORT_SYMBOL_NS_GPL(counter_add, COUNTER);
 
 /**
  * counter_unregister - unregister Counter from the system
@@ -188,7 +188,7 @@ void counter_unregister(struct counter_device *const counter)
 
 	mutex_unlock(&counter->ops_exist_lock);
 }
-EXPORT_SYMBOL_GPL(counter_unregister);
+EXPORT_SYMBOL_NS_GPL(counter_unregister, COUNTER);
 
 static void devm_counter_release(void *counter)
 {
@@ -223,7 +223,7 @@ struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv
 
 	return counter;
 }
-EXPORT_SYMBOL_GPL(devm_counter_alloc);
+EXPORT_SYMBOL_NS_GPL(devm_counter_alloc, COUNTER);
 
 /**
  * devm_counter_add - complete registration of a counter
@@ -244,7 +244,7 @@ int devm_counter_add(struct device *dev,
 
 	return devm_add_action_or_reset(dev, devm_counter_release, counter);
 }
-EXPORT_SYMBOL_GPL(devm_counter_add);
+EXPORT_SYMBOL_NS_GPL(devm_counter_add, COUNTER);
 
 #define COUNTER_DEV_MAX 256
 
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 2a58582a9df4..aea6622a9b13 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -325,3 +325,4 @@ module_platform_driver(ftm_quaddec_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
 MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 47a6a9dfc9e8..af5942e66f7d 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -523,3 +523,4 @@ MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
 MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Intel Quadrature Encoder Peripheral driver");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 3b13f56bbb11..5a11b65fc0e5 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -242,3 +242,4 @@ MODULE_ALIAS("platform:interrupt-counter");
 MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
 MODULE_DESCRIPTION("Interrupt counter driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 00844445143b..f9dee15d9777 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -394,3 +394,4 @@ module_platform_driver(mchp_tc_driver);
 MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
 MODULE_DESCRIPTION("Microchip TCB Capture driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 68031d93ce89..d6b80b6dfc28 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -520,3 +520,4 @@ MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
 MODULE_ALIAS("platform:stm32-lptimer-counter");
 MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 5779ae7c73cf..9bf20a5d6bda 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -417,3 +417,4 @@ MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
 MODULE_ALIAS("platform:stm32-timer-counter");
 MODULE_DESCRIPTION("STMicroelectronics STM32 TIMER counter driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 0489d26eb47c..b0f24cf3e891 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -456,3 +456,4 @@ module_platform_driver(ti_eqep_driver);
 MODULE_AUTHOR("David Lechner <david@lechnology.com>");
 MODULE_DESCRIPTION("TI eQEP counter driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(COUNTER);
-- 
2.37.3

