Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2854BB563
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 10:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiBRJVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 04:21:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiBRJV0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 04:21:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A327CC5
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 01:21:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso7947486pjl.4
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oL38d/xhLakar1r3IADvY8npTUwpwPyjsDa5M8iZYyg=;
        b=qgOuGk+ALMVLZF217C9jdDK9A5b/e6HUP3Vk33NVbIsuOc7sAK/8gZ4YVAXYDCEKIB
         xEp3TdzLLV3pOT1vVlcRcWfao1da3ExBZFwYzhUFlFe2FHZ9af3PCFch8eZCPaAL4zXz
         dw2W8Ey7Us3YhkdyHS2Vcq53/3cIlcX/u/j4sPSbFBPbG5ulGudPEAOnVSRxzIqwHiqU
         uiCxeNWmVM9GvNEGQnv+CXJlhYOmLrZH2176bRWNOq4i3mZ7fG2n69OX8YLZCEgsOJN9
         v5frYh6kGAvQn0X9qn4hXr+TNrdge+Wz5bV2H/tGzgtzDM+NIC07+/YAbHGiWZP47qz0
         CKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oL38d/xhLakar1r3IADvY8npTUwpwPyjsDa5M8iZYyg=;
        b=hJbARDClX4x21xFuLdacYLrh6yj8eTNRikH5H4RQU7X2/ss0+lNNe1Juv2pUsxfti/
         +Q/hKxHuV1B+rBR3xR201VsAtVjBdyfwl5tzbEb529vCX32RDjCiEQcPw1b5cs6iy3+l
         ktHMDuPPs17jz4nyu0d+zGY8QdXotS0r8BijUZxP1CL36WqntD8G/YjK6XDnbqJqviYz
         KDTDBf/e9l+j4aAAJDN8zzfguHl+nrOjvAXVhkBZ8Yh5K0yjGreif4OR+FkIvYCCaTQL
         4+PNAHOjEad+CrjUf3sEgR+2j6l9luVc4EoRGoiugQzM/BSUNqPSwtmal58ESOZZnudn
         5DEw==
X-Gm-Message-State: AOAM533DmxaH2d7N7VKb8kAnz4sR9j3zSgjExzxrAjFCWvxIoLHVvbEz
        UKCyMzUP7ZVMCCFcSG6Lbq0=
X-Google-Smtp-Source: ABdhPJy6OHGRlYqtEOPxHXbPMXrEVXj26cV6FSe5ZTjQTICO5ZBto6X9PDZgQoFOiqE9ah9m42pw8w==
X-Received: by 2002:a17:90b:3d0e:b0:1bb:8615:78d6 with SMTP id pt14-20020a17090b3d0e00b001bb861578d6mr7511405pjb.4.1645176067672;
        Fri, 18 Feb 2022 01:21:07 -0800 (PST)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id ot12sm4523155pjb.22.2022.02.18.01.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 01:21:07 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: Stop using dev_get_drvdata() to get the counter device
Date:   Fri, 18 Feb 2022 18:20:31 +0900
Message-Id: <20220218092031.167689-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
container_of instead of drvdata to track counter_device") which wrongly
claimed there were no users of drvdata. Convert to container_of() to
fix a null pointer dereference.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to track counter_device")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-sysfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 7cc4d1d523ea..04eac41dad33 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -19,6 +19,11 @@
 
 #include "counter-sysfs.h"
 
+static inline struct counter_device *counter_from_dev(struct device *dev)
+{
+	return container_of(dev, struct counter_device, dev);
+}
+
 /**
  * struct counter_attribute - Counter sysfs attribute
  * @dev_attr:	device attribute for sysfs
@@ -90,7 +95,7 @@ static ssize_t counter_comp_u8_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u8 data = 0;
 
@@ -122,7 +127,7 @@ static ssize_t counter_comp_u8_store(struct device *dev,
 				     const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	bool bool_data = 0;
 	u8 data = 0;
@@ -158,7 +163,7 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	const struct counter_available *const avail = a->comp.priv;
 	int err;
 	u32 data = 0;
@@ -221,7 +226,7 @@ static ssize_t counter_comp_u32_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	struct counter_count *const count = a->parent;
 	struct counter_synapse *const synapse = a->comp.priv;
 	const struct counter_available *const avail = a->comp.priv;
@@ -281,7 +286,7 @@ static ssize_t counter_comp_u64_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 
@@ -309,7 +314,7 @@ static ssize_t counter_comp_u64_store(struct device *dev,
 				      const char *buf, size_t len)
 {
 	const struct counter_attribute *const a = to_counter_attribute(attr);
-	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_device *const counter = counter_from_dev(dev);
 	int err;
 	u64 data = 0;
 

base-commit: e6cb9c167eeb8f90ab924666c573e69e85e700a0
-- 
2.35.1

